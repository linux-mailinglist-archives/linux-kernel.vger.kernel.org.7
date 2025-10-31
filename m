Return-Path: <linux-kernel+bounces-880485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DAAC25DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73D4A4E52CB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A692DFA26;
	Fri, 31 Oct 2025 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThF8r4Jj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ABB2DCF6E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925290; cv=none; b=FjYVnIZBjuVmW5RDD0UMvAb7Wnee9+vAHpWC1OCRtUKcW5jOiMClivFlCMuv38v2mW3wcX26NO1hLgYwZuz3fKZWvk5aI2v198JsgaeL2qy0wdjJAI1NdMwfX0VHQVW8RqzJ+g3I9LlLmuyizeS/KZrEhuutHaTfoNeaYhkj110=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925290; c=relaxed/simple;
	bh=CY07atiK/mfQVJUxa1CO3NfCCijt4RbMMTOr9MWii2Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pqaV/nMgckdJuetTbmQewtS44DvoAEZiwqzOM9QoVRv86nZGlB3Vdx54mv6MLEV+e7/yixvDuk/VnfirFhBXgPtN15BV3Y3BagoHWmntd7RMhZnCvl512Hrei7DMvF50bgfF9VC6K7t3B6AHl7WcJbVFxPR4guzRTg/Vc47/6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThF8r4Jj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761925287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9qooR2gBmbQgGN8XbZaIkwlII4Zlk51tngieqgy2cUU=;
	b=ThF8r4JjqH+hldeq53Vot1HWOUXJaVUtbw1mBeJ62m6rwKOhIAVCe+2wz4b3jzqmR4ucik
	PGU2jjiFTv/1oJBSr9Z5G5alN5s+bRCNLnlEWhNplCjUe7qNYJNxCYwZqIfuwEMBb2NH4l
	AeJoTS86xWSpm4ZeYQ+lIaLI8f2bFx8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-irisuogoOn-kOPL3BLEauQ-1; Fri, 31 Oct 2025 11:41:26 -0400
X-MC-Unique: irisuogoOn-kOPL3BLEauQ-1
X-Mimecast-MFC-AGG-ID: irisuogoOn-kOPL3BLEauQ_1761925284
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47106a388cfso18126945e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761925284; x=1762530084;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qooR2gBmbQgGN8XbZaIkwlII4Zlk51tngieqgy2cUU=;
        b=a/oAvusu2c/tJITdXBPS5FC90FF8NjNp0UlNKuBucQGFPUjaY/UZ6Z8y9af35T6/Zi
         4Azg5844TX72FuD9DLUCRrPauK/5CPYi2FTyHOVdOC9lznRQZ+CS3zlRluH5yTum1cj1
         lAnUmUX3S2Ox1znVVLCNzlihUeS6uxZPclhFF7KImknvlwF38vaTPfAxvgtgwJfhT3kS
         f51l5/yi/BsyxNK0q53+mlPNQzTjyVu81oYcbBBkJL79JbShJgt99Wq22xFvHVopvrdR
         GtoHyWgQwsi5eM1bfIMzpMb5tI5V8hksE6hhzZSX8LARgphuDV4id8L+U9zUC/GBjX2u
         2MAA==
X-Forwarded-Encrypted: i=1; AJvYcCWro7HK2s6lEmFt48/GEbIrvi7hyhPxyr0H5dclnnDqBFlpdLmP1oqIscPCjCIwwRZkyEJ0k7iRCfeL5rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrB6K/dIh3x/ppit0fq7oDPgIS5wz6se6VAiCxMTV867VO9xR
	FGV+yKrCzT/4NQbwxMcNr3oqdTJs1flEzB95Mpf3G0EDA5E7A6N7yf67FTtcA0wu5sER6NcS7iV
	EmSGQ7IBGHfEww+M1j/37A+faDjFIH38iL/KgmqhYSeeUtZr7M7CWxQXqFKVYycNUvg==
X-Gm-Gg: ASbGncvpBwGXzzpz6vbDioZwBom416pVM5JbUaT6xWoOsJrdCX/M+Bc97Q3WnonZT2S
	dJK3+5BfJmFYnEsRm4bT2Y74u3dty22UKHgqpW52HWpxPLtg2PVXSlNMEG+ccwM8AGE6ITTX02m
	vmbuOyAJijIQ6oeb46Vtocy2Vid+tbBXoFUA1Veq8BWm1T7fq/ksAnpxzswSCqH+tL0lquZlQAd
	wzyEPIdMKsOmUzxJSLr/1+9RCcKR4nQbuEuIlPw/ioRa3R0z0nEF+ADvWs8n45OUq2EAze/y0kI
	lbIg4EGsAXosmiOFSvfa9RN+IXmuDx3a5NNM/qmFnkD1LtTVatg8HPk6MfNZxO1RlZX2BuSFaeX
	Echf2jvlnv66+2QuXH6ZQa/Xj
X-Received: by 2002:a05:600c:3489:b0:471:15bb:ad7f with SMTP id 5b1f17b1804b1-477307e1f05mr36743735e9.17.1761925284420;
        Fri, 31 Oct 2025 08:41:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzEJR5rAki79Ma8q+7kkmBdMIWsBwJsRMW2wtEaLva07Vg+1OMiXKWsCQUIlAiQZR5f1VJWg==
X-Received: by 2002:a05:600c:3489:b0:471:15bb:ad7f with SMTP id 5b1f17b1804b1-477307e1f05mr36743515e9.17.1761925283935;
        Fri, 31 Oct 2025 08:41:23 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c5647e1sm2162025e9.15.2025.10.31.08.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 08:41:23 -0700 (PDT)
Message-ID: <2daa2e6217eeaa239616303626c0d73d808ae947.camel@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, Ingo
 Molnar <mingo@redhat.com>, Clark Williams <williams@redhat.com>,
 arighi@nvidia.com
Date: Fri, 31 Oct 2025 16:41:22 +0100
In-Reply-To: <20251031152005.GT3245006@noisy.programming.kicks-ass.net>
References: <20251014102541.GS3245006@noisy.programming.kicks-ass.net>
	 <83a5971ef07226737421737f889795ec57b6fa6c.camel@redhat.com>
	 <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb>
	 <20251014193300.GA1206438@noisy.programming.kicks-ass.net>
	 <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb>
	 <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
	 <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com>
	 <20251030184205.GB2989771@noisy.programming.kicks-ass.net>
	 <20251031130543.GV4068168@noisy.programming.kicks-ass.net>
	 <1f2ad071e59db2ed8bc0b382ae202b7474d07afc.camel@redhat.com>
	 <20251031152005.GT3245006@noisy.programming.kicks-ass.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-31 at 16:20 +0100, Peter Zijlstra wrote:
> On Fri, Oct 31, 2025 at 02:24:17PM +0100, Gabriele Monaco wrote:
> >=20
> > Different scenario if I have the CPU busy with other tasks (e.g. RT
> > policies), there I can see the server stopping and starting again.
> > After I do this I seem to get a different behaviour (even some boosting
> > after idle), I'm trying to understand what's going on.
> >=20

After running some heavy RT workload (stress-ng --cpu 10 --sched rr) I do s=
ee
the server stopping and starting as the models would expect, but somehow it=
's
always boosting as soon as it's started.

Apparently dl_defer_running is always 1 in that scenario. Perhaps running i=
dle
counts as running something too, so it never defers. But I can't really see=
 how
this happens..

<idle>-0     12.964637: (+8)     sched_switch:         swapper/9:0 [120] R =
=3D=3D> irq/50:212 [49]
irq/50-212   12.964699: (+58)    sched_wakeup:         trace-cmd:544 [120] =
CPU:000
irq/50-212   12.964831: (+24)    sched_migrate_task:   comm=3Dtrace-cmd pid=
=3D544 prio=3D120 orig_cpu=3D0 dest_cpu=3D9
irq/50-212   12.964842: (+11)    event_nomiss:         -9: idle x dl_server=
_start -> idle
irq/50-212   12.964843: (+1)     sched_dl_server_start: comm=3Dserver pid=
=3D-9 runtime=3D16238881 deadline=3D13592407587 yielded=3D0
irq/50-212   12.964854: (+11)    bprint:               pick_task_dl: Pickin=
g server 9 (armed 1 running 1)
irq/50-212   12.964861: (+7)     event_nomiss:         -9: idle x sched_swi=
tch_in -> running
irq/50-212   12.964862: (+1)     sched_switch:         irq/50:212 [49] S =
=3D=3D> trace-cmd:544 [120]

The trace-cmd in the example above is boosted, like highlighted by that bpr=
int=09
just before.

> Ooooh, because idle time is accounted against the server budget too.
>=20
> That is, idle and running fair are both [2] in my comment. So we never
> get to [5].

Yeah that must be it, however I don't think it explains the other curious
behaviour above.

> Humm, let me noodle a bit more on this. Also, I should see if I can get
> graphviz to draw ascii art state diagrams :-)

Dot doesn't do it but graph-easy does reasonably well.

Thanks,
Gabriele


