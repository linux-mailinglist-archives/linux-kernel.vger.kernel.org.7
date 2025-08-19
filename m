Return-Path: <linux-kernel+bounces-775182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F398B2BC41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D649A5259C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F933115AE;
	Tue, 19 Aug 2025 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGtWxINp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09073220F5E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593658; cv=none; b=dJA4tKogEF34QBNbXcNmDxgYvW965Yz+pcoJNX3pftWFilwmD6ajH1AQQlRjTq81zmbQxHN9bai8189YJH3lDFW0FtmLUHh7ve1v2c8q1IHMt7derxwM0EEatmpZd9uSmzTE2u93gC6JtjJxdK1Xn5Ys25QY4pPcW433ast9fxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593658; c=relaxed/simple;
	bh=nkHuaZ30Wj4HRODgV+5qzmcgMbTC/viCq0aPzkOd1HY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SAK7MvDiMB66rh/c5gsNy6+GP+29z4ijT9azdutFN+EwVTTSHwvViM7aaMudyeS840tKZa3QNw05MN4PGAOVo7nl+sGRcihH5CYa8/E+n+zfMdzDtx4LeCdSHAkZZm3uoBi4NXu6NJSSQL7cl2a9V6rGAf7lT7DuM/CSFakLCOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGtWxINp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755593654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nkHuaZ30Wj4HRODgV+5qzmcgMbTC/viCq0aPzkOd1HY=;
	b=bGtWxINpBdseUFjE7DnBUAfOkjJK4hcNpma3MSUvSZ7eoR5U/mHyZYix+IKaAralPA4kdn
	OC55owczAUgQNgvNdWmymjRgLx3aSPbyGUrGB5tf6/oqppcLLiXj0HqaT8UwQc4QoRREI1
	48avpWEcPF1blYZUIdrDTZuWRSZfwtc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-JfKr_H8ZOze3W9r-nu6Sqg-1; Tue, 19 Aug 2025 04:54:13 -0400
X-MC-Unique: JfKr_H8ZOze3W9r-nu6Sqg-1
X-Mimecast-MFC-AGG-ID: JfKr_H8ZOze3W9r-nu6Sqg_1755593652
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b05d8d0so30992085e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755593652; x=1756198452;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkHuaZ30Wj4HRODgV+5qzmcgMbTC/viCq0aPzkOd1HY=;
        b=FiCOd9upAslHG5VOQDGj33rc97I07R51fVBTzOMvlzwgpGiiRcRPz+UUXYyt+BQR3z
         qDI0Vffg+6gqrIVZI07BxhftGnUmPr6GwvIXnJItICk+N2hOhlUx731gCKWXqDeElATm
         xjek1roDG7wVE3dxB5XUAeAWYQ+XkweMzn6g4fJFoO53OGs488vNgfhE6NR8IBDCeR6h
         ZO6MDQNrjY7BPWJn9dfsWA7G+s6yYJZGjW9/6QB6VuHNyFInouECAD4VamzvV/yFUvn9
         BevajnVb907L/DBXx0zoFznI9oXIg3EDDSFsDFikJF8A3hkBtA3q71cRjmRX0907Jehb
         HIIw==
X-Gm-Message-State: AOJu0Yw23QSrEX1FR5msC9VMerXXqmqZUxgSDUrAkonG5s11nG6l/FG/
	GxYpDcHVobuQ/ZpiApbcZvnEj412RGEPf1HHakiA3XnxKBDaBttdlgQ4L06azoMwGeYKznhkSzF
	knl71s5BpZmNutOEFqoFIIgHJmZkr/dVliuf0O5NPby/BnWV0d979Z2Do9FCJXB73JA==
X-Gm-Gg: ASbGncuRrWXXMa5VdqoXIe7FkAUUZX2pCrKlhqqMxUir1y5coBgYPSqukF9FGXVId4l
	cxYUa55GlV/c8DTzc0ok78TuOlP5EG+YVN11Hxd6bXPZJ2t2IVG/ygtJNZDA/Uv8o3ePYRalWEc
	E2JF1nRvHRU2atWeItxlM7N/TlnDAPgbGihQFCpcB9wzMHy4+3sqFoYlveMBmsYGgL0JiRxvRTn
	KYTlYYbBR7Towcp6JGsF75DP38cAOTkb5BvNpfwaXWNL3WuHyea4TkGecjZtDnNIKz6MDNz92Ym
	W/cHZQm9xLstN47v8boTdgf3XKEqvbt3X01BOCjMJagWybhYD0DTOBV0n8STrPI6LmR5+qfMktd
	ZuwFYXtN56RwCyWru5x9oCnqf
X-Received: by 2002:a05:600c:450a:b0:459:dc81:b189 with SMTP id 5b1f17b1804b1-45b43e1b850mr14160945e9.31.1755593651989;
        Tue, 19 Aug 2025 01:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+Ey67ZMFhWDj5dn/vsBSKqmO8X2bM1iUd3EZAP4FgneFUIPIEOM/jpKt1l5k1O7nvLkOjEw==
X-Received: by 2002:a05:600c:450a:b0:459:dc81:b189 with SMTP id 5b1f17b1804b1-45b43e1b850mr14160585e9.31.1755593651478;
        Tue, 19 Aug 2025 01:54:11 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1715sm2942703f8f.36.2025.08.19.01.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 01:54:10 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>
Cc: linux-kernel@vger.kernel.org, Marcel Ziswiler
 <marcel.ziswiler@codethink.co.uk>, Yuri Andriaccio <yurand2000@gmail.com>,
 Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/deadline: Always stop dl-server before changing
 parameters
In-Reply-To: <20250721-upstream-fix-dlserver-lessaggressive-b4-v1-1-4ebc10c87e40@redhat.com>
References: <20250721-upstream-fix-dlserver-lessaggressive-b4-v1-1-4ebc10c87e40@redhat.com>
Date: Tue, 19 Aug 2025 10:54:09 +0200
Message-ID: <xhsmh5xejite6.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21/07/25 15:01, Juri Lelli wrote:
> Commit cccb45d7c4295 ("sched/deadline: Less agressive dl_server
> handling") reduced dl-server overhead by delaying disabling servers only
> after there are no fair task around for a whole period, which means that
> deadline entities are not dequeued right away on a server stop event.
> However, the delay opens up a window in which a request for changing
> server parameters can break per-runqueue running_bw tracking, as
> reported by Yuri.
>
> Close the problematic window by unconditionally calling dl_server_stop()
> before applying the new parameters (ensuring deadline entities go
> through an actual dequeue).
>
> Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
> Reported-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


