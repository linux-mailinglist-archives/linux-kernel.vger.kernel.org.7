Return-Path: <linux-kernel+bounces-852317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCC4BD8A76
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 530674E5302
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CBC2F9DAE;
	Tue, 14 Oct 2025 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcTK4bOi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE6C2E7178
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436314; cv=none; b=icAVREgWxdUKmkrGG6vW60TFbfmwV0i4fFJuAOPFhPqX56JtfJY9pzCOrnLsBTIxZp3IrdblZ5n+IIVdqDYCAf7EJiATafRbzK1fl5v3dg4UPsmtUCKp+Z+nfGldxg7IYa73UPc57iJm3F6z4dqIIYmEPKEdXUf2xRzYZy8FuTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436314; c=relaxed/simple;
	bh=jFqIpHIf9xHyc6QUUUdRIzHOrrBWcJWi21R164nqFTU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y5LfNBxpDwQNXmdX1/1C4SDDbuTiJAgwlyQv+FaFhVBBkT32lFRL14qt/wfoziBZOA9bZf2WcUl+B57qP1AlCJUbSGpNonltRoYMmIr4zLI3S+GS6pfN/mRg8w+VLqyLI2rW+M1aDzk6xks7IyxR4fI5QoZ4YHxrkdGQz/dCNDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcTK4bOi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760436311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFqIpHIf9xHyc6QUUUdRIzHOrrBWcJWi21R164nqFTU=;
	b=gcTK4bOiEt+EKSPO44Qswq8fFKoNPEpQBv2A9JQZ6dSHh9uMqv/96Tvg62oeoDnyAVwPin
	XeIQEEe2YeJAEUVpfeyCfj5qmOh8OAYj/Rs40E8KXocPeeH8uGkphzyS2QdLviu+qx8+dF
	OliY8JZcIreMnJxkcucRaBipgC0R0+0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-TEJe9Pd1OVWreFBS1uEiqg-1; Tue, 14 Oct 2025 06:05:09 -0400
X-MC-Unique: TEJe9Pd1OVWreFBS1uEiqg-1
X-Mimecast-MFC-AGG-ID: TEJe9Pd1OVWreFBS1uEiqg_1760436308
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee10a24246so4514938f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436308; x=1761041108;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jFqIpHIf9xHyc6QUUUdRIzHOrrBWcJWi21R164nqFTU=;
        b=iPuzb2C/VXmykDQUzJTVTmWJmgFjMciR0BiD3XrYX3xgoZccV3bBDq8fc8JpXARVru
         KjXeVM5+cgXW1ljjJSKJjfKpXZtj1zelTbtvx3/Du1Tx+YSd0eZwNFp3XHufbkHRkzPv
         uG7juQgzEJw+RnsiA6mRc27GFVzhGa4P9796Gz7J3618ztW6ctT73fYIHEFRRqgXjKO2
         0KID+1jo3pg8rgBK6g6wsod6Ls0jtZ27zGkCoMfSrnS9VjhwOWwGja81ZuLquH3+E2gh
         EIvirb3olkP2vncBDOzd/9ziZEZMv7sa+AL8oYU0Q2hbeyKt/VUwFnIMSQ1UEIBJ1UHu
         j15Q==
X-Gm-Message-State: AOJu0YxrNMtCtmu5xnNOG3VkAyUjWYt9dLX81z39u/v/uV2MIgdI9UTQ
	aVNCrrmyN6gOIN6oRs+aRThVgwmgeQvXMxPxg0J93S0QCUKA60/PfgpTuzZaNvC20FZVQsF71pY
	89mxufl/eKCUOYbcVQZxaUYcqIo/CMG4UTd4nN4V2L2sAg+k7eBDsclpGY8sJam79Ug==
X-Gm-Gg: ASbGnctkXHMxTW8zQStEL14JnqCudTlPP1MOma8gPUOvY050aTqe8wjnLMVhkFCJWIg
	TD8UPOfsW6s+n4IQrV3s9SSvalL6BS6kvpKmS+tuYMN/GfVDhKvqH3u/NLMEQ7K1zMCz67Z+L6M
	Kp8kxKHZaHiCW9KDeUC+bwqF+2kN6DiK9coCxnaHT+FiyeCxXUWUh5yWi4hUuq6IsUep1Mc1wnz
	ZCXBj5NyhBPMFUXlxS/+PSX1inje7+1gtcegFTcXvBl1ccuTpwJxgafGWLCA0Abm6N6jOeCk9Dc
	1N/J9fDqzkfkKtEY5jWrA+W+oasngPiGKybnQwVlwTA5i9xXcHgyROFd81uf9285LQ==
X-Received: by 2002:a05:6000:25eb:b0:426:dbee:3d06 with SMTP id ffacd0b85a97d-426dbee3d1bmr6115192f8f.22.1760436308321;
        Tue, 14 Oct 2025 03:05:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3fQYnVJctdU0i4pCVctTbsJ4A3V4pG6cBhL/BemxgLMwhlGKRwltXCGzLJcibpPDFlhTJpw==
X-Received: by 2002:a05:6000:25eb:b0:426:dbee:3d06 with SMTP id ffacd0b85a97d-426dbee3d1bmr6115173f8f.22.1760436307944;
        Tue, 14 Oct 2025 03:05:07 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce589a21sm23378939f8f.23.2025.10.14.03.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:05:07 -0700 (PDT)
Message-ID: <a0ccf27f5e12a11d2e9dc951ceaf7f9d103f67f6.camel@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Clark Williams <williams@redhat.com>
Date: Tue, 14 Oct 2025 12:05:06 +0200
In-Reply-To: <20251014095407.GM4067720@noisy.programming.kicks-ass.net>
References: <20251007122904.31611-1-gmonaco@redhat.com>
	 <20251014095407.GM4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-14 at 11:54 +0200, Peter Zijlstra wrote:
> On Tue, Oct 07, 2025 at 02:29:04PM +0200, Gabriele Monaco wrote:
> > Recent changes to the deadline server leave it running when the system
> > is idle. If the system is idle for longer than the dl_server period and
> > the first scheduling occurs after a fair task wakes up, the algorithm
> > picks the server as the earliest deadline (in the past) and that boosts
> > the fair task that just woke up while:
> > =C2=A0* the deadline is in the past
> > =C2=A0* the server consumed all its runtime (in background)
> > =C2=A0* there is no starvation (idle for about a period)
> >=20
> > Prevent the server from boosting a task when the deadline is in the
> > past. Instead, replenish a new period and start the server as deferred.
>=20
> I'm a bit confused, should not enqueue ensure deadline is in the future?
> And if it doesn't shouldn't we fix the enqueue path somewhere?

Enqueue of a deadline task should handle the case, here the CPU is idle and=
 the
deadline server did not stop yet (and won't until the next schedule, if I'm=
 not
mistaken).
The following enqueue of a fair task triggers a schedule where the server (=
no
longer deferred) boosts the task straight away.

Now the only check for deadline is in pick_next_dl_entity, where the earlie=
st
one is chosen, despite being in the past.

Do you mean to check for deadline when enqueueing the fair task too? I beli=
eve
again nothing happens here because the server is still up.

Does it make sense or am I missing something?


