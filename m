Return-Path: <linux-kernel+bounces-842153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FF1BB917D
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 22:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622B43A4616
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 20:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8562737FB;
	Sat,  4 Oct 2025 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iYbMn4o2"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA43946C
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759608016; cv=none; b=Qjs410CLE57jw28k3pOtXaYe826lnUDkwUIfzbVzdCZSzXGTIx0ij2YYZ/cKjyZOigYpQCE2dUwRNLmh7twARzbk2SF4gvD2oXrSQNYDuS9A1HccFFOkixgPmPEAtdObLIyJRNzwtDo7TZUk5TtYAs3WbVa+8ZzRV3pvesi8PRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759608016; c=relaxed/simple;
	bh=MAAATEzUG/gnyFxR4G/qPSO1lh1Qm5uC32oRTnBeWCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dj8Pi0BTKLEP7xq5LV2T8QtJ9N1Mr82X1/ZKmHzEiQr+ShXHNkth1xN/mmgpN+x2mOFbyD7sIbAI43GaKAxNMjnZkkf8evkBeKukFf6eUJ3zezsL4GwbIXaAnFZnCCc2DssQVmyTts99AucBcaD3/BOsd/akNrPtHYVn08p5Ns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iYbMn4o2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2698e4795ebso33198585ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 13:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759608013; x=1760212813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAAATEzUG/gnyFxR4G/qPSO1lh1Qm5uC32oRTnBeWCk=;
        b=iYbMn4o2nrhsUiHcXndAhn3D5rveHqQazkRi1tKZemwh96gcAChFRegaQ4ODyBdoAU
         FaZlbEJNooja+uRDrY3LFPEKzdl9yOVXmF/egYQ14GdIC25e/ZZW+0x31+0sTGAy3quM
         PSwiiX8C0ZZaSiqC4zepuP3WecWv70RHH7fp2Exjt5yZYy4qHy4oqN9X8+WBgAXf49zm
         fJ+swr4WXn3Bto6yfZT8YKQhQnnBt/WgpgEp/vzibK39weL7L3b4kxb3bL04IvYjSFQ6
         Nq90EfJLsq3gJlZ9zZCj2zT6RepbQ6jpc2gWtdMtk+6jHEHseU/7X+IY2W2dJWIXJs0/
         6KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759608013; x=1760212813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAAATEzUG/gnyFxR4G/qPSO1lh1Qm5uC32oRTnBeWCk=;
        b=cKtb31Iv0N0EA8Bnw8jDyvK+VOxW+LR4M0KYboV1ofAaS3UYrzcHbFvPxQZa/FqtCa
         BvLkiJm5yWxOaevRlLIE6XYfx15q73Iy1cC54yn3S6EFR6OqDj59akzA3TyvR2Bq9/4z
         KWPPcJtNsYNQ8xlB3w+2a2NYYFHbejsoxvJ3mt5CqIppEEmuvSoa6Jfb881ZQAttjgNI
         z7r9aXycXqCbBGD8Z8fmM3Chw88WWbdcwc4/SPCl7V+oJP1R2+qFWhM7fm81tXTlNEUw
         68hvAOUd4YqlcbSnW/y2XbUn3etGM/cpjfX9xQS1JLEv+KlePIipmfEHZVBW6mRfMy/0
         gh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqeHrlE5CGTPt4UUDNa7pYjqVp1peDBOeRP4lt3O9Wr9flTDha+uv26M25kdwyvkaBcacptPNb+58cKAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcMYdwRDsZt3IOrsLeae7nhXBJcC/vn2Y86jzVsrZ2M2bPdsvf
	hjFZjsuav5AaihyURTkzFS3wqDDdcaBeL6fPW/ikUpFsGX9TLOTYA+qIE8x9C95Yxn05xYKrOUn
	7npi4x3OTtqOiQFw/A3CUlgZ6UIaO3CA=
X-Gm-Gg: ASbGncuMHuoe3Jxd21Itz6x4Jv3QD4zXm0PHlooLOKCWX6H+o60bhASg+4FuRG5mngf
	awPbVbESFZ+zLur06UtQivPRPpGvwI+Cl/THDC09qUH2ETFaQJKsX0w5dr4DhMC5rCoNWr2vnnd
	A54M2y5TdxkARVR0zz9B5NJMKx0Pj8se2jPFUODimMngbN5lEmzxqgjRDnXs5eOofyS9AAzXYsQ
	AB+QwofqBEnK57XpQMD3HtixzKPXotO68Y/+TgS1+PsIydadpVs+akFctrq3nxi0HxEO65LFdbb
	IPPdvM/PCw==
X-Google-Smtp-Source: AGHT+IFiDzVT+2dmKCxs79HazquRaVoEKj9U/SHZ9ROcZSGxvoksUVUV31FTbP+B8I3rHTQWDxtOGVKUAq/NVn1bvko=
X-Received: by 2002:a17:903:1aa8:b0:272:a900:c42e with SMTP id
 d9443c01a7336-28e9a693ea9mr80467765ad.35.1759608013223; Sat, 04 Oct 2025
 13:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927125006.824293-1-christianshewitt@gmail.com> <20250927125006.824293-2-christianshewitt@gmail.com>
In-Reply-To: <20250927125006.824293-2-christianshewitt@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 4 Oct 2025 22:00:02 +0200
X-Gm-Features: AS18NWBM_Q13VsV8nrfsb2laKCZ_aAXl7OeFBFEiWoHsvMuxISq6Y9mZ9LHfpAE
Message-ID: <CAFBinCBeN-wjn-LBpgX9N_evzF1gL0nU8DPk5GSC28_s+tX+AA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: add initial device-tree for Tanix
 TX9 Pro
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 2:50=E2=80=AFPM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> Oranth Tanix TX9 Pro is based on the Amlogic Q200 reference design with
> an S912 chip and the following specs:
>
> - 3GB DDR3 RAM
> - 32GB eMMC
> - 10/100/1000 Base-T Ethernet
> - AP6356 Wireless (802.11 b/g/n/ac, BT 5.0)
> - HDMI 2.0a video
> - VFD for clock/status
> - 2x USB 2.0 ports
> - IR receiver
> - 1x Power LED (white)
> - 1x Update/Reset button (underside)
> - 1x micro SD card slot
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
> Checkpatch generates the 'phy-mode "rgmii" without comment'
> warning but this dts is using the same rgmii format as all
> other Amlogic boards, so I have omitted a comment.
So far we've been mimicking the vendor kernel (which sets up the MAC
to generate the delays and disables them on PHY level).
If we change it we should do so for all devices.


Best regards,
Martin

