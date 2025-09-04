Return-Path: <linux-kernel+bounces-800470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44254B43813
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13920189DDA1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3A12F998A;
	Thu,  4 Sep 2025 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyzLLZMp"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C22F83DC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980644; cv=none; b=LvSJK7dcmcGc0MH4VDqc0hCpPQx3ZZ3LbTuvdeC470Y3TNDa1JQ1dKNIXxthcx6UyACiMYX2/3HQvqCBXxmJ2yio+ZvRofmtTf3KcrUohEgszbOQ5+0H/WfzLeSTGoKwsENU/AsYLQZz+uiUhPoeeYTvOZV82F6g1Rsm1pOkATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980644; c=relaxed/simple;
	bh=WYAkuhBUkyGeNAMuzRFafeVQCBzyUp43MM/5ay7OtGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sr9VE7rgODQfJOBGsnNjnH45FHIQjloNPsPOR5fM3zU4GE38zKbvvFBRaSJN2a1sP2issmr7y4bLLlIQWjWgaIj+mgxPUuHKS22nr/oGciURotSVUNFCcAZBn/U8tqfUlfyeAtkqU/VFhBxZrvHshPgl30sQVPxzDJuzxNiXcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyzLLZMp; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32326e09f58so939554a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756980642; x=1757585442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mzz9fRqkvT5uX5MoAuPEzgbckQvhFxni4jRgfGvmtgU=;
        b=VyzLLZMp3UNgdhNA6DQN1XU3hwLiP0Y6siHsplNNRRQau09GUmkpNu/ip8r8GqJzxw
         GRFAITtwzHxpZmui8tGibE60xuQd0/UAPOCv9fecYw2HSsyOwWXEJjffTrcKdMm3erxj
         d0ivxGTqqBjdbQpF4DU2QfCsVaunjTDAMw01Pd7a+2lUd+IhpgxS+zLaJz716xkxO7Bg
         E6HMbBQVXbt/tb9gqAYyRdk67Od2RRCI02bIRNI8UoE3E61KdaYHz3oHclBOk3OyRTnY
         w4b8e+n8N7p1+4BzkxY8rZ3PK+/hGawVZvOepnZop4tAAFNPglhwGly2qraQY5l76cgi
         4AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756980642; x=1757585442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mzz9fRqkvT5uX5MoAuPEzgbckQvhFxni4jRgfGvmtgU=;
        b=joQ/l31QnOPueD+/pWA9dED98VKmQww1oWDyIJEXCPNjGSx7s/Dd/AnaLHKWof7Gzr
         bPqGzXugPcN874cHPimKllPCPcjRV5eWpedgF+aw5N78nHdH8K3Jy8k2/N7/VK8DATN8
         YKTRw9lOBDTDVQwZSiKYrDZN7nGzWlpj/+5Wes4+aVR9DnM+IECs22eRBOSa8uoPDg8e
         bVee/IBwWcEmdUo31T/hGf3tpyfcbcVPWGAWCA/rk00s2u9RWWDWbN0p7cxw37P0ruCE
         s2l15cEGWMk0w51Hi3SHO839qeZl5PMi+5UXhLmns4gnXR7jzX2Z01zKZ4f1Cx9FiGB/
         sFLA==
X-Forwarded-Encrypted: i=1; AJvYcCUpKnNIKnZOZVr/QMjeGNexB2wSTqvZWxwPeddppF40jOchpQGp8eROkoB9lKV+A6v/fp97UW9uyj5Y7eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIOKlyNP2sssAzbt/zRMMh1DywgyhdJsO0V1MIsTovjYnBw5Or
	w6mAxYE37s/B5Rq3dVPTZ977JYiMpn6QxjywHhxhSnqhDTZPJjhEEcCoMGnZ8C+71d/L/MLH+Kf
	G0ANcESJza4/Vs0GUaxMn2euJRwV1JBM=
X-Gm-Gg: ASbGncvn7PIyU46irwrLqOsmGToG48Ai+FpTIoBi5hO7hq1/NjYGw6r7g6/GR9BmAwu
	3CssAyvRggO2d/o7yUNM+lWhJqHCSUjWJ5nxsyHaiGVQS4JMYbVsRG+ji8lV8Ajc6Z3AgxWc6xp
	7/kuntcvUdmvb/qMQo1ORGkGQxRFArXGK6RtXvUZJ8X28tJFaWuxpcDBMGPrOeqKaf5TCsDo2QL
	2yD17p74zTzHDJl
X-Google-Smtp-Source: AGHT+IEcr6S5zr86X7JbbP5sYJWvgrw9FGbOqdwNbxj9i0AU+TbarxyEOKi8uBCwkBmAEckqzOKfKywVq1s6p5aN8Pk=
X-Received: by 2002:a17:90b:2252:b0:327:edde:609e with SMTP id
 98e67ed59e1d1-3281543caffmr28305888a91.12.1756980641893; Thu, 04 Sep 2025
 03:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904002924.2bc63b73@minigeek.lan>
In-Reply-To: <20250904002924.2bc63b73@minigeek.lan>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Thu, 4 Sep 2025 12:10:30 +0200
X-Gm-Features: Ac12FXy-UNDQKQzOziQWMNs3hr0MwNpnD0zv9eFEeEfrnSbWD3LfsO0NbySuusI
Message-ID: <CAH9NwWepSZnBP7tot9it_bDEbSC14PrMePz+fBtHfHz4ikLDYA@mail.gmail.com>
Subject: Re: drm/etnaviv: detecting disabled Vivante GPU?
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, 
	linux-sunxi <linux-sunxi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

>
> the Allwinner A523/A527/T527 family of SoCs feature a Vivante
> "VIP9000"(?) NPU, though it seems to be disabled on many SKUs.
> See https://linux-sunxi.org/A523#Family_of_sun55iw3 for a table, the
> row labelled "NPU" indicates which model has the IP. We suspect it's
> all the same die, with the NPU selectively fused off on some packages.
>
> Board vendors seem to use multiple SKUs of the SoC on the same board,
> so it's hard to say which particular board has the NPU or not. We
> figured that on unsupported SoCs all the NPU registers read as 0,
> though, so were wondering if that could be considered as a bail-out
> check for the driver?
> At the moment I get this, on a SoC with a disabled NPU:
> [    1.677612] etnaviv etnaviv: bound 7122000.npu (ops gpu_ops)
> [    1.683849] etnaviv-gpu 7122000.npu: model: GC0, revision: 0
> [    1.690020] etnaviv-gpu 7122000.npu: Unknown GPU model
> [    1.696145] [drm] Initialized etnaviv 1.4.0 for etnaviv on minor 0
> [    1.953053] etnaviv-gpu 7122000.npu: GPU not yet idle, mask: 0x0000000=
0
>
> Chen-Yu got this on his board featuring the NPU:
>     etnaviv-gpu 7122000.npu: model: GC9000, revision: 9003
>
> If I get the code correctly, then etnaviv_gpu_init() correctly detects
> the "unsupported" GPU model, and returns -ENXIO, but load_gpu() in
> etnaviv_drv.c then somewhat ignores this, since it keeps looking for more
> GPUs, and fails to notice that *none* showed up:
> /sys/kernel/debug/dri/etnaviv/gpu is empty in my case.
>

Looks fine to me - no wrong behavior.

> Quick questions:
> - Is reading 0 from VIVS_HI_CHIP_IDENTITY (or any other of the ID
>   registers) an invalid ID, so we can use that to detect those disabled
>   NPUs? If not, can any other register used to check this? The whole
>   block seems to be RAZ/WI when the NPU is disabled.
>
> - Would it be acceptable to change the logic to error out of the
>   driver's init or probe routine when no GPU/NPU has been found, at
>   best with a proper error message? As it stands at the moment, the
>   driver is loaded, but of course nothing is usable, so it keeps
>   confusing users.
>

From an application standpoint, it=E2=80=99s not confusing since there is n=
o etnaviv
device to interact with. The user might wonder about the kernel messages,
but that=E2=80=99s actually caused by an incorrect device tree. If the SoC =
doesn=E2=80=99t
have an NPU, it shouldn=E2=80=99t be enabled in the DTS.

--=20
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

