Return-Path: <linux-kernel+bounces-880952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECC1C26FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B517C351691
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5A02F6169;
	Fri, 31 Oct 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVOC31sb"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206DA2E9EA1
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945152; cv=none; b=Rph1/kAP8pYFgaXYit0tkYZGCSAKGSReSR1qmOTRTnhTKoQtiwgec1UzEwm+c12rlS161vIcn5pPz8N2ddYOptRi9DioIWuK7ZML3SLu3kXRcjaoyO6ULjoa3Hm2/wQkEI+5yjLsa/5btNm9Zl8bwA3jkpBhmVXSyQCETeKY59s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945152; c=relaxed/simple;
	bh=RxRZVbgBXbZ11l9CJuzna3nb+s+vri3PRzzPf/vY52E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvjpcgWMPl+xvLNQ6ATGEoBmQUZojOKTLEyG8LfB/NKh43t56lVFpocEk9SUzgdY4x3Ilzr9HjpcnDoD6+yMnBGMXE0J9Q53RPa+OJxCoC54u2hhZsPsK0Vj2lNoocY3uYjwGZo5plUCQZRsJ3k5htucUZwjOxYLiIdyRfjEqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVOC31sb; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-786583618d8so5122587b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761945150; x=1762549950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxRZVbgBXbZ11l9CJuzna3nb+s+vri3PRzzPf/vY52E=;
        b=XVOC31sbo9r5F7BVAWX5E/04JfG3p7nH5F3qCrZ2DQ1cQz15Uw15+2oZcQU4FIHodW
         vkyPNxj4b0FhXxT38Q8lXTNbYaKNZGMO8RtTrWnOSUmShjcK4zx3FlKPvUQZ74AXPrYb
         rMYtQbcV+i/scrt536UfZjv10zhBBdyxZpHtyjPSgQzuetr2dA/YvqB7iWHxCHDKRK1A
         01c/Hh0zE05wcc43EmF6Fe1KiLR5ntFUHf+uV4FDc/XuvoL4raii/92gP2yFlIre4Z75
         nclkMgk9upNA50VoOKXV3/gXP9aBu4Lno7NGfbJWRClal6YE+abvDic3D7FfGXC6sJFg
         Q14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761945150; x=1762549950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxRZVbgBXbZ11l9CJuzna3nb+s+vri3PRzzPf/vY52E=;
        b=KP719WIxlbeDLRAJ0Tcu62rJ1DL5Pvs45JxSLt2MCPt6BSbTFiKw6AO/C7lxkbELfI
         qJynZhDa82cmEcqYtViDk132NgPcMZ7VGo7xr1k9AAOACZrhWzIVkKATlVkGbQpjdtQA
         OMUGmBrqRwBz3TDhfRp5FxiImhQQfmQBwLXaLBkp9kNmQWC4CB1zG5ZCsWefSg0+UvNo
         h46ykSC9Fn/Y2pVejesutBM1OnsJqFnLQHj5viF3qr5AUWAbAvm1EFV9WkoQlQk6dQex
         CdTYGis6Z1y0UARcx3wVW4q5So7qDAn43w4qXc7WivYpWAdgU3cKTkYSISGGwzf8W1dk
         NhHw==
X-Forwarded-Encrypted: i=1; AJvYcCVXOKi+L+LOlreXq8uUxB1/5+jRpE/ctVHO9W0DTDeFwcMJRiAPp8Fs/hHiSwCxmzIQIPcOsDGLipoQr3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJV7TnD0T8tOtNoZ/VPVI+OuPi1oM7RTUW7r9d0lxTcZnmEPEG
	OmKsjOtPIH1oc4Z8OwBLpHj8kMp0Bb1gWIzCVyPSmOIqAfNllRgMei8Q+V15YWduaw48iwjqCCq
	14s2JB3U+xaVAnnRT2kInIKdo4EPJ/Ss=
X-Gm-Gg: ASbGncuzZU98a1Ir+rCzUoREZtRmyYNEnu9tIYZaa9B4zOFsK9SMSHEKW333Mk348FZ
	/12FxwGncFvb/tD8tCt67/iW61Wwm9MwbGoOSP8dfg+cnNP8vYA1U5qr0ns6LJU1WGYGXVgGeoQ
	28vxRpzQI3jk52VQvE970LYJCOz1UgilsVaODhjJbDg9nIQABe+LA0T4+w74KAxmeW4YXgRSPJL
	EtahEcVpQJcTzxGynJT97y0ILlQUQxS2NqnwhD+k/SRtvLMCmdZdvYu1Mteww==
X-Google-Smtp-Source: AGHT+IGf+2hqwNIvkxF2qVcHXGJA9AdN87r2O00FhqVjx+0PJJ4RnIdOz3Y2v4WN+nf2PaxkjO4OJTI6SiNS6tCn6BE=
X-Received: by 2002:a05:690c:6111:b0:786:56ec:e3c6 with SMTP id
 00721157ae682-78656ecee71mr19761427b3.55.1761945150168; Fri, 31 Oct 2025
 14:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014044135.177210-1-ghatto404@gmail.com> <91113d48-a8ef-4a24-a73f-6d32ac271a00@oss.qualcomm.com>
In-Reply-To: <91113d48-a8ef-4a24-a73f-6d32ac271a00@oss.qualcomm.com>
From: Ghatto <ghatto404@gmail.com>
Date: Fri, 31 Oct 2025 18:12:18 -0300
X-Gm-Features: AWmQ_bkJM_BsqbzwVWRLOCiui_KfbOc2l1X_oA_9DhB9pGWlZLXqfCHgZ0VRaqY
Message-ID: <CAMQHOhcMUk99wdS03yjQiwzTg0D0mt8H-QU5QQFn44m7sDZ25Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] arm64: dts: qcom: r0q: enable more peripherals
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 6:58=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/14/25 6:41 AM, Eric Gon=C3=A7alves wrote:
> > This patchset adds support for multiple devices found on the Galaxy S22=
,
> > side buttons, touchscreen, max77705 charger/fuelgauge, RTC and UFS. It
> > depends on "Input: add support for the STM FTS2BA61Y touchscreen" for
> > TS to be enabled - and for the fuelgauge/charger to work,
> > "mfd: max77705: support revision 0x2" is needed too.
> >
> > Thanks!
> >
> > Changes in v2:
> > - split the gpio keys patch into 2 for small refactor
> > - rename spi-gpio: spi-gpio@0 to spi8
> > - use tabs instead of spaces on max77705 nodes
> > - added new patch that fixes adsp_mem and video_mem memory regions
> > I couldn't find the clock-frequency for i2c5 bus :(
>
> You can boot downstram and run debugcc to dump the current state
> (incl. rates) of all clocks
>
> https://github.com/linux-msm/debugcc
I can't get a custom build of the downstream kernel running on recent
Android versions...
>
> Or /sys/kernel/debug/clk/gcc_name_of_the_clock/clk_rate
Nothing exists past /sys/kernel/debug
>
> may also give you a good result, although YMMV
>
> Konrad

