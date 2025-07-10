Return-Path: <linux-kernel+bounces-725973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F634B00627
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6816641FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02E82749FE;
	Thu, 10 Jul 2025 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSqnnY+S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40634273D9C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160269; cv=none; b=FOr7j78PsuSKnBfSyZDX2PTc2KsiwgQ6TTVgYXxQNuhlAdUF8s0uV+YHynl1bIXngmHZU0QXtdAVD7oS1DbT6ZzjebPgv+2BePUZG+nNMsrW2Z7BVmzzsJTm+rqY/K4yrAxspBcmVvlP2N4WN1iOwdk1IO7wAsEQ3EuYRGdGetk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160269; c=relaxed/simple;
	bh=qp3b/VRh5y5h+VM7jR9g0Wg8Qz9Tf1YYfbp9OuB8m88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cse+tSb18cEC67Jkgg0W/FksROv2FQd/MGTUpzbt3JgBRWJuowPtyZdkR0y72mMMlSlaTa059S4fJIewRjsw3omsVXU4mIfAgNdlO08DUUbUl+hL7XehX2GRBPJ2ohXVu89Wf6yOOurwkBm9nxPQlGGc/9WG7k4KuXv5txO8wrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSqnnY+S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752160266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7d37F/DQnLa+T8Qo87AEGZXUgyBcAt+T8G+l0O12LuA=;
	b=NSqnnY+SNQiKNAUykJZ29TE2swhrzNKQEWagg7S2ZgYvxZuEM/1viaHzG936/BeiIbvH/M
	MQXKIzGTWk6bjHjhhhrZnTcKOrZr3Rk7kTxVfDz/yWo9st+0jVXBAAc7wJ4c6PzmjMcaoB
	pRYN6KCDG01Qx+kLom+SWrrVeKuzkXw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-wCMbUuAYMN6VmGu1DbE5nw-1; Thu, 10 Jul 2025 11:11:04 -0400
X-MC-Unique: wCMbUuAYMN6VmGu1DbE5nw-1
X-Mimecast-MFC-AGG-ID: wCMbUuAYMN6VmGu1DbE5nw_1752160264
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so6278115e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160264; x=1752765064;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7d37F/DQnLa+T8Qo87AEGZXUgyBcAt+T8G+l0O12LuA=;
        b=bLpGBPrMfBNBjF9Rc+8Z9YDNkrKOMny5tii1BYqiZep2DKlVjGYT9F/jIwVlOPl+IF
         GdjLuKrxNn515P1DpJrzgWkmowRKcs48c3lWkuM0M1vxkqyuJr7emAT/xg18b/KBNtvR
         KcqU7KwV8V42LBUZFBXSQmsahruTDlY3xE2BCcfkuJ9QQPViJI4Y9cXcRwOtHH+ax+x0
         QHein+/qWMZHcoSo5uW1ZUmw0NzKApgW2aSjwNwXvHMfddE+xhO79zZDOC/i2uifWzvU
         NIstlPmcr3+5eH6gvN6dbAMfEXZapQkuqAkZZy+kDya2vV0QF+DyyRlUP2QHf4VjkkH+
         Fzrw==
X-Forwarded-Encrypted: i=1; AJvYcCU9E5FqBxE9leIDhM2QxaYBfFvkS+nSRjvpMWJlktwGAckMb3f73LDzFDHAZ6GUL1qXTt0SXcdvler/BV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDfK9VDpkfhwy5tmFINVq+oQkhkyn7Wt3UPOPFQFgHd48oCDkS
	qEi+pbXr2vkHd70BSfdmlYF7hlg1vgt0qsCIhJE3o62sW+bekkQqK5vTiQBf3Ufabu+bPD1jAa6
	V0aj0IUtDLQFsqfo/XWKr00An4id0Z4tmEzwSE3xuGxBGCj0AqmFWHlICLVOXftlPDw==
X-Gm-Gg: ASbGnctCPcWNrhwJqCDrh6QU1tURPnlY2O/UPP2IJvtokIcdb8fll85DiJiEBqIYvMW
	wTZu5KJesb3cqEwMU9qCOUpRnN7QDxLkhrfMaRsI8Smqg0ScnbD61JW5j4BuqfBjSZB31sPicda
	v6rTLhfmywxTg07OI2KoHUePe+z/1ze/aNe1NiNTcF9bSG4qsgJVE5qZeD8chQ6QZUy4msYzcWj
	CV9PQvx3KXf2HkUPcWK5uLOnISMVKrWdJU/kGeCNmNf4jH5hPoNmicwJZPU4kdbNms7RX4zn5Zu
	W0+PQ49Dax6S4Ikn1KNcTzjdKTU3qsHh9KdSUSShZfHjzp0cYRe2HBib3bhHkCXPhSvb1SFSHp2
	3Ufhg5hU=
X-Received: by 2002:a05:600c:4e55:b0:453:5d8d:d1b8 with SMTP id 5b1f17b1804b1-454db8909a8mr45390565e9.30.1752160263631;
        Thu, 10 Jul 2025 08:11:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHXTFZIaaI5njPILH2TO4vBwzWwKodiXFjTsfzS73Sgo/vNHwZ5/Uil+YNiuIyqJOfh1DvhQ==
X-Received: by 2002:a05:600c:4e55:b0:453:5d8d:d1b8 with SMTP id 5b1f17b1804b1-454db8909a8mr45390025e9.30.1752160263126;
        Thu, 10 Jul 2025 08:11:03 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd541167sm22279755e9.30.2025.07.10.08.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:11:02 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Leon
 Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org
Cc: Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@alien8.de>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, K Prateek
 Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v4] sched/fair: Use sched_domain_span() for
 topology_span_sane()
In-Reply-To: <20250709161917.14298-1-kprateek.nayak@amd.com>
References: <20250709161917.14298-1-kprateek.nayak@amd.com>
Date: Thu, 10 Jul 2025 17:09:51 +0200
Message-ID: <xhsmhwm8g13r4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 09/07/25 16:19, K Prateek Nayak wrote:
> Suggested-by: Valentin Schneider <vschneid@redhat.com>
> Reported-by: Leon Romanovsky <leon@kernel.org>
> Closes: https://lore.kernel.org/lkml/20250610110701.GA256154@unreal/ [1]
> Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap") # ce29a7da84cd, f55dac1dafb3
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
> Tested-by: Valentin Schneider <vschneid@redhat.com>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Changes are based on tip:sched/urgent at commit fc975cfb3639
> ("sched/deadline: Fix dl_server runtime calculation formula")
>
> Changelog v3..v4:
>
> o Use empty span to detect sd objects that haven't been initialized
>   instead of using "sd->private" (Valentin).
>

LGTM, thanks!


