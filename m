Return-Path: <linux-kernel+bounces-893579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1F8C47C53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A63B04F8DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F97276028;
	Mon, 10 Nov 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkEcibiS"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2857F153BD9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790108; cv=none; b=fr0b6M/849aTHwu6B9eH5ilu9HHIlCYoo1utNRL/ABvubdi5PF2t0cv+UuAVpeIC2azG7bl5iSCzUYCOcOeeF23abLU1K+wJ8/kBeIl9mWXmRNqBeHQBMcu0mt4hXg6s0czsiJV2AU5XbuXmTjKpGQ4UYqn4TB/Iv8DYZ32xgQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790108; c=relaxed/simple;
	bh=UIjh5OHK+/m1SacpjkCMs9vMDSevjykGUGOzGYpUTAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeaQp1DMc2Vo66YvXF3mwCOwWeO+dxOrgwjzR8pTWxX9AXPNpc88Y23ACqYtca/NBn6vgsNzkUp4ROXOwJOzBubcFwDHWuAtEFPCt6oXeMp6TkUwlEqky26TPbqlXSgtHwoAlUGND10UQA6b4z/q9NiPmwXnTJZ61+UsPXBuGGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkEcibiS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-340c1c05feeso2634683a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790106; x=1763394906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6R6wcVAFeAUcZ6mJYKCCW0Bji6CCIjd7Ps1e8q5bT4A=;
        b=FkEcibiSNDFhNrAHibdnFVvu88HjyjVWY7EAdCoWSDGir1vSkuPocBJrwXrBhbMXD9
         wsIjT579AV5dRQ0p//O9/pKfTvYgg4W453FUFfb9bRdd06x5S2pU8MswRAUk87vtTpCv
         ogYM9+V5rnhDxhN/PCmHAyuF4gbA6czzk9YGT/5vtM74mjdvUSSVoWsg9PCMISGWk4ph
         oU196O2PWIdenwioZMMSRMbc1siiqq93NsTwP7gLyXKpwZGy/ewqwRFoLpbMSOHYDmEr
         RoSf+WjsaXFOJ40O3rGiK4n6+eBNG/erZRFY1dLIs1R9O5OSaZoM9HJlIlRCuzyus+h5
         IrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790106; x=1763394906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R6wcVAFeAUcZ6mJYKCCW0Bji6CCIjd7Ps1e8q5bT4A=;
        b=B1UIy5k6TiFH44xqs480lV73MeHrIDMAJDaio3AAF3VvlCzwbdnnodIdWymcW/j4Ew
         Nzx7LBtu5U2QhublBLbCwvsFAKGDxFPZ+yUNQjTSi0x5xjm8R2gyHIsz3UXydUJLH/5s
         u8ZNV2DFEY0WIaPmoL3pnISzzLp/1OCbz+DnUP2BM303x3h3brnnbJlqh7D6sNpmKsoP
         7/BJ0q12RwijF8uN05BZDQC1jiu9yMl6apUGjogDe2uiTucQkRXeogqwdw5UDphlWRYe
         SVEvTY+ioMAHNKiY3cvatN20okxZNdXxcev+/RdR+9TTfT+peZMiRNBLINQ/0HBhWqA/
         E6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVZA8LmzqCd4rDSw3r3vEDrvx67Yzq9NHIUjM+inK1A3xwcRJRrcpU6ryZcu041yU/ePw6n4muTxN/emA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvN/HbYK/BHUWkCo2CuteDnFo2G3uwTrOZCtBvY2ofgN5NAPW9
	7V0IsZ3A1PoQqIR1s732fFcI3Yq9bneQ0ZOKTeZWne9VfL+I5VbN2/MZAzPP3gjOV33IKqjuiad
	ObHXNbJlv+sUYXIofqAVGmfClilWuXL8=
X-Gm-Gg: ASbGncsC68HQL6RWM/oWF4YuRf3Fa68XggGqB05f75G8J2nkS2o5Gcyoa92TEsgcwFm
	nz18iLRUpnLt1sc2FZJpmFk7T8Zu79LcJxPO2DL8qDHSoc5Rp8xt5wIcxF5EAivRKiGwVRKrXeh
	1so8d81xraIBzwBWdrQm8eO65J+jPvaPftpUUKf7/buiNAUawdXJh1dJ6s3V8np792n7Of/WEuO
	ehvP9banqkWjqHWr+BtwGMadInbbPaRscwTdsGMv8WWQ7YG1XqBHaZGkPg=
X-Google-Smtp-Source: AGHT+IHCrQU0UlElplZd+YPzXUqH9miCN+y+iRChbMn/h7fN73CjNrmEf5PFWQKDUy/hBQwfC1VOyq54JxIn8cvEg2E=
X-Received: by 2002:a17:90b:54c3:b0:33e:2334:ef05 with SMTP id
 98e67ed59e1d1-3436cd06506mr9221689a91.28.1762790106437; Mon, 10 Nov 2025
 07:55:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630202703.13844-1-gert.wollny@collabora.com>
 <20251110144625.18653-1-gert.wollny@collabora.com> <20251110144625.18653-2-gert.wollny@collabora.com>
In-Reply-To: <20251110144625.18653-2-gert.wollny@collabora.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 10 Nov 2025 16:54:54 +0100
X-Gm-Features: AWmQ_bm2wmrOPItOxwhoBd9H4sTLBEoxQE9s611ak2i40wnU7FFtiRLd5trLVSQ
Message-ID: <CAH9NwWcYOfrjbL==PBZ8z-Ta-C9EVQSypovqturj4=ROCfxpqQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] drm/etnaviv: Add command stream definitions
 required for a PPU flop reset
To: gert.wollny@collabora.com
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> From: Gert Wollny <gert.wollny@collabora.com>
>
> v2: move some defines that resided in etnaviv_flop_reset.c
>     into the header as well
>
> v3: fix spacing/tab stops
>
> Signed-off-by: Gert Wollny <gert.wollny@collabora.com>

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

