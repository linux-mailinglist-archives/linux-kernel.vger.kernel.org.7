Return-Path: <linux-kernel+bounces-866778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C62C009FC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DC33AF444
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444B92FE573;
	Thu, 23 Oct 2025 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r1JINhMV"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF50A30749B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217438; cv=none; b=Yi7Y+cpaKvp6yrAMH3tr59zMkhuUcevek/qCTETLCTx4w+lQJvjNM3wRoOF9BIoRZ9+trcl2pRNpqNIvlt+pDgBoMFzZmJ7B+lDWAz5YqPF2KczBPatk8M1gpOa8IwtfoJMupE3rmBBrXwq7phDllbOh6Wxs46ggySF37O9p06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217438; c=relaxed/simple;
	bh=kBsrJnbxBkr/fO6jx2/I7vg7Jb+qOy1iGAu9156yEwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+47LJu5TB11SB2SippwdhXZJD1jjDypRFu7yZpxGiIWu2rne9hnCZvTSKRj3u1YqW57FSzaaBR4fQQ5vTvn/S2C2ajdkEI/1sYSjT6/P2aHR94CbBVu/xLq3FJk+g91SxqFEhZml11B3DKz6Y+xdeDNfBnNuttZG7PQVNN+HD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r1JINhMV; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-785d3a5f641so2749147b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761217436; x=1761822236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s7kfTDQj4kvXnrctF0hqqEzRvRC3TedEvs2k0hyX+5Y=;
        b=r1JINhMVuEvrTH0Y0mbR4JGF+rHZKQC6v67TL3rK0ZxlzdDALF2hVfF7qAstJh1Yfv
         7L3eRrR7Egd8nBo1zAk5ep37v+VFAjK/9ytsTsgTOE5/cQA0Yl09QrRbAlQQF3bLUnQh
         O9/A+zmrMOASiwM04zBi53L714qumG8OARQX/Bdd2JOTLWiDutgifqLGNNKqVGZWLFMk
         NiBWril2NEzNZ23oyW3fsH+hdPx0ojf5KVaYiaHMbhDFZ2f0ScD0XkRew51oHiemU4wL
         eodafF8WCrL0yEmhHT7RXjvkZHdtiMarU/MfrTyziJc6FilEQnibwaUCI4Y0HTZkVU4I
         4HdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217436; x=1761822236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7kfTDQj4kvXnrctF0hqqEzRvRC3TedEvs2k0hyX+5Y=;
        b=RjFV3OmLCK+vmgJQP8rNCr8MC8rylZPGDWIDeXzV5R843WLwdApew298B2F164hkyB
         ibL76FuaL4Pa48zm5vBP9iGLKLnH/x9vMSOIvGCTlOm47o3XCMsYbEXafzpQpbTz9QQQ
         H8WtJyKF68TVX+aF3dB3DN7Zya5EooqSW45n99e76p9d68D8UArpb3eWihUMGtI1HrPX
         7f0VOlJXXto08fgX8fz2DrggkENkZoGzg5UrouMyBcMgtMRLtI8Yw8mPJsHVJeAoaDbW
         yh73Pjn7Rzv5/A7MYXownQOJxSK1krncGROLZNifeafSIOpDX3bZsV53+fFSFwM5GChf
         g/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXk3ZXEy+MpAea/VCgZBA7y+xTZ09jZyDGmdKFyLy3ioQRhEb4XDCN5oln/lWSsjLHG7GAhiKkyoS1LCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVwAT/mV5dNMX7trKgqVxSRfAScwRkbwgdjBMNikZtO0PXV+t
	Ogi9Nt1sB/RSOMVrtYJLyI2tD5c3q9lUoVFsEEp0+x+0wuwBUvn2c7+yH39FZ4jmyez+lnMGv9m
	qVZrFb59B4i0J22yX6Ykub6Iti3+mxWAPWu+yMbuZoA==
X-Gm-Gg: ASbGncvEGufrcOtDRyhlYsgo4ltmAWN6vrORc7PxQYM/tv+4NONpQLNudtIBS7+ZeLY
	3LwETG37IqIBrcOioQ0+VP0+IWS7Ua7CQ8PTDzZYijIuO25MyCgCQM1U/oVVDE/6BUKmJ9xaNIY
	0u/V/BdGqJlFKgYLi2fl+MywAeynna/uJtRcyKKGtYXw1eDvQiybAuDhtnIk1IG4YHTtXviohcX
	BdJ0dcyaTuZyPQVon/lKCl8TgJsiI6ZoSkrKBZEZiLRo73lLgWqyhXo92H2Wg==
X-Google-Smtp-Source: AGHT+IGQU8iAL2oBx44YJmSWLgkrzJbNQnnv5TJU5QYU9Ll/NoUPEJP3VALvDA7MdFtXzoHgi4s3vJZ8kDBTes0TUhA=
X-Received: by 2002:a05:690c:3203:b0:784:180e:fd4c with SMTP id
 00721157ae682-784180f0adamr181008387b3.31.1761217435834; Thu, 23 Oct 2025
 04:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
In-Reply-To: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Oct 2025 13:03:20 +0200
X-Gm-Features: AS18NWBVEatEe3gSBhE8qZaLai0zI0Dc2SVrRDXu7B4f5w61d7RxUXvBV6dUips
Message-ID: <CAPDyKFprP1d-9Ojwz7QaVBbdFumPmRoVnifrP8v+eL6FHR3Unw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] PM QoS: Add CPU affinity latency QoS support and
 resctrl integration
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, tony.luck@intel.com, 
	reinette.chatre@intel.com, Dave.Martin@arm.com, james.morse@arm.com, 
	amit.kucheria@linaro.org, christian.loehle@arm.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Jul 2025 at 14:41, Zhongqiu Han <quic_zhonhan@quicinc.com> wrote:
>
> Hi all,
>
> This patch series introduces support for CPU affinity-based latency
> constraints in the PM QoS framework. The motivation is to allow
> finer-grained power management by enabling latency QoS requests to target
> specific CPUs, rather than applying system-wide constraints.
>
> The current PM QoS framework supports global and per-device CPU latency
> constraints. However, in many real-world scenarios, such as IRQ affinity
> or CPU-bound kernel threads, only a subset of CPUs are
> performance-critical. Applying global constraints in such cases
> unnecessarily prevents other CPUs from entering deeper C-states, leading
> to increased power consumption.
>
> This series addresses that limitation by introducing a new interface that
> allows latency constraints to be applied to a CPU mask. This is
> particularly useful on heterogeneous platforms (e.g., big.LITTLE) and
> embedded systems where power efficiency is critical for example:
>
>                         driver A       rt kthread B      module C
>   CPU IDs (mask):         0-3              2-5              6-7
>   target latency(us):     20               30               100
>                           |                |                |
>                           v                v                v
>                           +---------------------------------+
>                           |        PM  QoS  Framework       |
>                           +---------------------------------+
>                           |                |                |
>                           v                v                v
>   CPU IDs (mask):        0-3            2-3,4-5            6-7
>   runtime latency(us):   20             20, 30             100
>
> The current implementation includes only cpu_affinity_latency_qos_add()
> and cpu_affinity_latency_qos_remove() interfaces. An update interface is
> planned for future submission, along with PM QoS optimizations in the UFS
> subsystem.

My apologies for the very late reply.

To fully understand how this new QoS interface is going to be used, I
really think we need to include a user of it, as part of the $subject
series.

Besides the comments from Rafael and Christian, I also wonder how the
user of the interface should know what CPU-mask it should use? For
example, how does it know the CPU-mask for the big-cores and for the
little-cores? In particular as I assume the user isn't a platform
specific driver, but rather a generic driver that should work across
various platforms.

[...]

Kind regards
Uffe

