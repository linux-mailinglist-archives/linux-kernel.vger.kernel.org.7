Return-Path: <linux-kernel+bounces-867861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52F6C03ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF19B1A62B35
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1028C280308;
	Thu, 23 Oct 2025 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZX9+ush9"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880F886340
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761258268; cv=none; b=iLrg/5dJLr9C4eQ5uArrO1Kf5pzLug7cPDmv5BEqKJYoGF81NLlYjBL+rPv7iNgvlCcUsfOyeo1jLz5mEu8+WnFunCc9lqVz5TVCnZ8yaZApRRa9hz/3s4Mpf0ZlEYOtl4PfK2VxnjTZBgHm3RTjFjkpjXwEaaQg8g0Mvu9LmGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761258268; c=relaxed/simple;
	bh=RI61nj5Xpi3g63pf6MmrqXj3YI71ZQ8vNKUPxwaYJkY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=pVXz4QFUDrngBzMmQT6bqP2v9ZqV9i4nCo60TXTsPrtUkYpCLurTYcKfyHhGRtqk7vShKe+CeHdjJUDanRRvNODCTHcvZGNv5g5sw4SmFzk6SqbM6Kka/NwFz3DXQazWsAbIu4ReMqIlt4PkuJEqLZpebb4q+pXDhdKSnffDUQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZX9+ush9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-87c11268b97so13952976d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761258265; x=1761863065; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ltpHz74jq2314hEgAIMxZgJUxyrXRNrY30m3sAX6Y0=;
        b=ZX9+ush9E9fMDqGpCpziy2RhwCNo7k1a0fMcmSGzSAhpwHNDe+ZTq/TWZ0Gzu0aB5r
         mnqOQ5Mee3TenzjjSVj0mz7dN+uPOTjrdoQZqH6E33LftU+PVmxEqm5qdwlngN67Vwmk
         PR2zgZkfRQvuOwx0ohwrpxgKWafXtzAajDXDGihCoM6P3LXLGMiAsM+MRM7Xzl2NWKxF
         +yxnjJx9rRfPJFbQm25+2Rc4PRoWb9CIY0SIvOJQaxm7Qf2xmZqWMUs/mSBwkeW5n7BT
         dLfveqmGlKoZG6k79VPFrpCz6FjwPjyN8oaeLcBwY4b1fjy+mWoqpmADlK1Y/Kcil/9M
         Huyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761258265; x=1761863065;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ltpHz74jq2314hEgAIMxZgJUxyrXRNrY30m3sAX6Y0=;
        b=Zz3KtuqsyCJF/f9juTSHHl5uuLmb+Sszt5Ld4NpXrgq7Hs1X6rWCnFpNt+i8yTReCU
         LO4PUK+lkqKFEXYbRfxmgDM6KhVjbMSXR6IEtWqi2RHM61flUrlhvLRXzIRTe/xKRRII
         yz4HaRhEf29gsiwKhCJ3FrcWHvN92jzvmS4AF7rDsvvmBnyaJc5Kp4Wd4/LklFrSJecI
         b39TO01iWJ9JRnrbMkfg+0ir9pwYwptGYi5VmvV1SlEbxA0LBLGOtRdNDxLAR0ndYi09
         MXxNqjVKhr3ytDelMykfesnlBXBHgJ4AEZXVvVldOD/KNygllHcwf+gKQiWGdXRlfEp2
         iB+g==
X-Gm-Message-State: AOJu0Yxg9jxdhKTD43Ts9qupy5XOwCIb00RvEVQ2sLa72NDBGsSoCr9P
	qLwR3ckqqZFnGVNUcJ9i1OnTjDCd82Imu1svzr1Lvr5DQFxRFsYZ2DUdDpeh0v0CZQ==
X-Gm-Gg: ASbGncuC3N8AuxKlGeXgGSjBpJaAQlFuzGbP0wl3xutysccvFCPNMDvbXvcwfJJNOT0
	rVxp6DPm8BqthFYjxVxYDyO408mV5CKcqcYk+Bbk+Q/sN8encPGMExHBZwHhP/KxoMyZGdqHjB0
	xgN7N6rk1kKXYqP8ySYj9QWNLvh0L/DfpCjPmTKQzPnpZ6i/hlpAKl1eJJzldlQz2So2lham2/s
	pF1Y4K5+lfemh9JGtJsB1iYr5fekwogM+xkezT+XrlQ0pklEzzMoP6LIPYlY7mJGTZYFDjP7OJs
	PtRef34rcWalrBsm4cKKdBVZVazSE8/y0cPAKXwp+LLeP20sd/nCpHbnMhICzM6EVBOwoByXk/W
	fed/5OVaRiPxSWITe2B/HeVktaLTNeOY/7kOVxvWqHZOEDUElMKNremaZEH+VJ/kOs6uSWfcJCZ
	7l56smzcdxEhUVzrCOvot05VK59FwL43h8xUYhPpO1AaNXVwmVQ/Fyuh1A
X-Google-Smtp-Source: AGHT+IE8jv3Je8Ul7XlJ8/oqI6J54riHmM5iZFaCaN+Iyggje6kxt1OT1o4JcVmt60o1zEpBWQteiQ==
X-Received: by 2002:ad4:5ece:0:b0:878:6fa3:842d with SMTP id 6a1803df08f44-87fb62a1d27mr1305436d6.0.1761258265418;
        Thu, 23 Oct 2025 15:24:25 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9e82908bsm23214256d6.58.2025.10.23.15.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 15:24:24 -0700 (PDT)
Date: Thu, 23 Oct 2025 18:24:24 -0400
Message-ID: <5364449d2011c1d394a7bb30109b923d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251022_1923/pstg-lib:20251023_1801/pstg-pwork:20251022_1923
From: Paul Moore <paul@paul-moore.com>
To: Hongru Zhang <zhanghongru06@gmail.com>, stephen.smalley.work@gmail.com, omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org, selinux@vger.kernel.org, zhanghongru@xiaomi.com
Subject: Re: [PATCH v4 1/3] selinux: Introduce a new config to make avc cache  slot size adjustable
References: <cc48748e9dcfa63fbbaeabad0b2536a0f602cb1d.1761217900.git.zhanghongru@xiaomi.com>
In-Reply-To: <cc48748e9dcfa63fbbaeabad0b2536a0f602cb1d.1761217900.git.zhanghongru@xiaomi.com>

On Oct 23, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:
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
> avc_search_node() latency increase.
> 
> So introduce a new config to make avc cache slot size also configurable,
> and with fine tuning, we can mitigate long time irqs off with slightly
> avc_search_node() performance regression.
> 
> Theoretically, the main overhead is memory consumption.
> 
> Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
> ---
>  security/selinux/Kconfig | 11 +++++++++++
>  security/selinux/avc.c   |  6 +++---
>  2 files changed, 14 insertions(+), 3 deletions(-)

Merged into selinux/dev, thanks!

--
paul-moore.com

