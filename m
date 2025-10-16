Return-Path: <linux-kernel+bounces-856967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 558D0BE58E6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990AC480B44
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D842DF3FD;
	Thu, 16 Oct 2025 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NdVUtxqo"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AC155326
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649543; cv=none; b=TOtzZR/kBvQgarFKx6cr6uqAOio+EEcI0fWRqciWhobB1N0Y+uL7HmBtZIWhsONgW8KFTIPRE55+7n2bpyQGGtn0oALIw61k55c3Bhc2iC2FB24mlTLAQ4H2otqGYPDBUw/6ViW/EvqjwuQDvRTHAxFPi2ZdEcMgmMUCXq/b32A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649543; c=relaxed/simple;
	bh=Xc6Ma2BJ4rIJwOkFan2uQDZX9PCmX1NfiSFI3iHPhIY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=bLoEPOzUuWYhiiYcgamxU00QYAk8nR1cEg+BnB7u/V9SMrchE9lfRVoDcL+mSWOkZpQNmh+7gcB80NAuyG42/ePXGoWGJdow+plPI5wDvm9fKbw+R3w3x1N9C44VYrjrr89pUP3uNuPFyIxXyr99x5Jp+NsAdRewD6VIUUZYdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NdVUtxqo; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87c13813464so22055336d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760649539; x=1761254339; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRxspZB6n0Ost1maui+Aw2s6FnuDB+lZ6WB2dbmokFg=;
        b=NdVUtxqoXrhbDcP+anD39EMsA4HbtozBFtqg8rIMEgZUVFIjGPX7D/hG0reQkFc72I
         6OLVgq3WCEyWpRGDOVYp1upbjb1X4C5wu0dKYmTYOVxdhfiSjCuBTZIDXUVlIb6xAB/i
         x+thXHV8ngNkVk/dv+dPsrSHh4NLL0G1oVUuFCJZ32irNRndUuKJGSvCd7iFnEQoF/Vl
         Dk5cPI7+qBlJA3ZG+821uErYibGpy8H/y8zEy/TQRpJSMMkQWs88C1V5nD0bRGfe9p68
         hdEmPpDIvJ7dXa3MU/d/iRecOrdR6BS8KsMZG5DoOTYZiTOpHuMjTfQCdoaPMhaSXPuG
         F5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649539; x=1761254339;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GRxspZB6n0Ost1maui+Aw2s6FnuDB+lZ6WB2dbmokFg=;
        b=e3wEKsVGMa22p4tDpDpzyTrHkHBm3CEAY8AYNacXr5i2ED24Ua0EDzeYOojnLPeyPv
         sPwT3BctlhZBgFKAirdsgOTI/ilJZjb7eAB7s7mS6jMc3su5vF2IQuX4viIsIQv0Uwyn
         bmvjYRijbxyBTuuCGWA9KbCMNBPmJ/Y48H+JLsZ3y+mY6VD5mHCjk6Yj4NOSGpNex17p
         Wo2/tFpE36vi5MLrbXfyFGFF+0xAFZHJEeqfRyIqQknMf6uwtjLrzzRYIgO/vT/xByt7
         NWCo+JJkOA5EV71ZlDpOkdq5Bbw5gQVDeDZyLupWbsQ6fzx1Z/01qpdVktyox6Avi+o3
         TjLg==
X-Gm-Message-State: AOJu0YxQ5qpmCSKtEK4SzlmP+YbiSq5fDKYVfL6DIftmd+/elnSYnB4F
	682uABK3sB6NEGs5WfXRi/ZQVRcRhammH3UOLHvEzA1qo5ZHmm40u7VrA0K1eshAQA==
X-Gm-Gg: ASbGnctXUE5cuN7cHjfE+Df99ebQRZLxWj2t5Y2ACr56TV57GiFUMSkeJJI9jSnKvEd
	yrC93MiOuXspkNBclSPkLIq9v/OMpzgNM2jOlkDEKSCbnwebufhAQEmCHHhQu8jI6t41YigtOjW
	MV0roeiQU558835cm4RyidOCb/Uuu/qvMlfzErGGdCq0iv/b1oMIqjHcMnEzbU4GKYyw9c9CfVI
	XnIrUH2Bly21VsjZHyTkKlrsJhSQs1Qz73IhFLlGT516HuVJFzfwgH0SRCkqrjQPPY0ZSTEfosT
	mqHyI+ZFOVaqE526Iw2RuWrvObev9L4guBceBc3MbByrLh5XBEbaOW3RSHaNXtDrzqrd0b5XrUZ
	rMd7ZfL0fX2UQ50/yHb3CNFNyzYn4Ulq1GZVSeFg6BxW80KtmvP1fsjB3QrK0nLXjPlLs3d7wVI
	VNu8NXQ5RI2cAB0YO+a1neEaSxqw1Ci7kkV4y0eCP+npZWC4U4XlAgGBuG
X-Google-Smtp-Source: AGHT+IECwF7FbZiJrx4qruCBvl4hn6IYvAgULKR8CrOlLlmi2Gc7wo9kcdTdR0bBbN18TCxqmD6XHg==
X-Received: by 2002:a05:622a:1917:b0:4b5:ea1f:77f4 with SMTP id d75a77b69052e-4e89d3a5ec6mr25065231cf.64.1760649539236;
        Thu, 16 Oct 2025 14:18:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e88db8b22dsm33512551cf.4.2025.10.16.14.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:18:58 -0700 (PDT)
Date: Thu, 16 Oct 2025 17:18:57 -0400
Message-ID: <b30e8d56703dfd84778fa73845eaa1ec@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251016_1653/pstg-lib:20251016_1653/pstg-pwork:20251016_1653
From: Paul Moore <paul@paul-moore.com>
To: Hongru Zhang <zhanghongru06@gmail.com>, stephen.smalley.work@gmail.com, omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org, selinux@vger.kernel.org, zhanghongru@xiaomi.com
Subject: Re: [PATCH v3 1/2] selinux: Make avc cache slot size configurable  during boot
References: <d849e8a98bf88bd12fd13a8f6b6e84290dcaaf6e.1758859391.git.zhanghongru@xiaomi.com>
In-Reply-To: <d849e8a98bf88bd12fd13a8f6b6e84290dcaaf6e.1758859391.git.zhanghongru@xiaomi.com>

On Sep 26, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:
> 
> On mobile device high-load situations, permission check can happen
> more than 90,000/s (8 core system). With default 512 cache nodes
> configuration, avc cache miss happens more often and occasionally
> leads to long time (>2ms) irqs off on both big and little cores,
> which decreases system real-time capability.
> 
> An actual call stack is as follows:
>  => avc_compute_av
>  => avc_perm_nonode
>  => avc_has_perm_noaudit
>  => selinux_capable
>  => security_capable
>  => capable
>  => __sched_setscheduler
>  => do_sched_setscheduler
>  => __arm64_sys_sched_setscheduler
>  => invoke_syscall
>  => el0_svc_common
>  => do_el0_svc
>  => el0_svc
>  => el0t_64_sync_handler
>  => el0t_64_sync
> 
> Although we can expand avc nodes through /sys/fs/selinux/cache_threshold
> to mitigate long time irqs off, hash conflicts make the bucket average
> length longer because of the fixed size of cache slots, leading to
> avc_search_node latency increase.
> 
> Make avc cache slot size also configurable, and with fine tuning, we can
> mitigate long time irqs off with slightly avc_search_node performance
> regression.
> 
> Theoretically, the main overhead is memory consumption.
> 
> avc_search_node avg latency test results (about 100,000,000 times) on
> Qcom SM8750, 6.6.30-android15-8:
> 
> Case 1:
> +---------+---------------------+------------------------+
> |         | no-patch (512/512)  | with-patch (512/512)   |
> +---------+---------------------+------------------------+
> | latency |        85 ns        |         87 ns          |
> +---------+---------------------+------------------------+
> 
> Case 2:
> +---------+---------------------+------------------------+
> |         | no-patch (8192/512) | with-patch (8192/8192) |
> +---------+---------------------+------------------------+
> | latency |        277 ns       |         106 ns         |
> +---------+---------------------+------------------------+
> 
> Case 1 shows 512 nodes configuration has ~2% performance regression
> with patch.
> Case 2 shows 8192 nodes configuration has ~61% latency benifit with
> patch.
> 
> Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 ++
>  security/selinux/avc.c                        | 68 +++++++++++++------
>  2 files changed, 50 insertions(+), 22 deletions(-)

I would expect the number of active AVC nodes, and AVC churn in general,
to be very policy dependent; some policies and use cases simply result in
more AVC nodes than others.  With that in mind, I'm wondering if instead
of using a kernel command line parameter to specify the number of AVC
buckets, we should instead include an AVC size "hint" in the policy that
we can use to size the AVC when loading a new policy.

Thoughts?

I think it would be important to consider it strictly as a "hint" as
that would make life easier, e.g. if the previous policy hinted at a
larger AVC we may not want to bother with reducing the number of buckets.
I would suggest starting with an implementation that uses the hint as a
power of two for the number of AVC slots/buckets, with a value of '0'
indicating a default value (512 slots, e.g. '2^9').

--
paul-moore.com

