Return-Path: <linux-kernel+bounces-886888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB3FC36AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 548CD507A68
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5468D3446A0;
	Wed,  5 Nov 2025 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1ZDJ0xv"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D033F364
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359309; cv=none; b=F3erXgoRBbZHh8SPBYZCJkzH4izZGmPli5Qe9TZBLzXQStrTfB+v1N2uWLjVcHzhIZLbggO0W4sJlhtryWbf7Km4AXoagCcflAiZvBsp2do7qFxSwgwsQFrzoCIpEmtl8H3i4eUJshRQ9k8oqq+qqGkbt3NIbitxLPLbW8KtXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359309; c=relaxed/simple;
	bh=uO/6iVYZ1vFXrKMD4kA3PYSBEGhevKLmMat7U8ijANM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C9A/6ecZLT87iHZ3egs2hQYPFEKUKyQ/XPQGLyZLEOa+oW0NqsBitg3m5qZHUxuO5qCq8tV4SiI2ilEaIXilDrZ7dyeIsbSKbmPdtJ3Bt7yha8huJFO/g9sROOMABEnOdcbmZev2x27Ja49qIzKpEFj/w3GSzQtKZeOEcSdcNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V1ZDJ0xv; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so12062941a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762359305; x=1762964105; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PW+009+mxrT5Q7b6yvU7pEoFhY6Kftp+LN/SDJfngBw=;
        b=V1ZDJ0xvb7uRoFrhxUzsIPQlte8MdOkz2Novsgvdv55wo47Ukt/fgjcSmjlWY/lsvC
         XcqnnhuDP8NgVHCCOv78l9UxIkMfrdRjEyxElJK9TUX2Xb0g1N7v1XafyyGB/JzpoSeb
         cLmFdgZUMjEjd8euY9cicGuhRfaIgOhSDX6F4MJCoZ/FKodLgpmePVnBQQB1Rc3FpBGy
         Vr1iAx+UQA8rSz9UYWy9Bq2Ij3BsFxmq4PeALc3ZsCRaJzdLolTvH6k/CWrCAAeg77WD
         wF1XvZWMBgAQ8RjEA4pyqTEQlxWWWfu/mfHlEWMtlBXDSB1LBihExDRK6dcmSN/sdupe
         yfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359305; x=1762964105;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PW+009+mxrT5Q7b6yvU7pEoFhY6Kftp+LN/SDJfngBw=;
        b=DaruDjdlOXo5YAu/tLCwodXaAERsxioCfXCCRQ1iiGUjlsBnOkPFu8H2jtWpPfrouz
         AN6bYOfOE/j5zJNohtWcbsDczA2vouUlngie3vB8vTQJXKwwxVEE7EdWdMUrA8VyBSuZ
         mec0O+Sd8CanFe8qZoKJR3PO1s9SaYeCYKxw943AdAbyHD0VAn0MTrTZRxRfwO7cDPcn
         4FoInPZoZbH05DDSq5J66yoK4c4Tc4fec+stDIWVfLEWMGvhit/+ZqGhJt4eUHjTvw/L
         iW1i0mV5uOIWuZd0EEp5Lc+VvdDhpFZeUJfVBstnZwJ2sNDPpNqc61oQpxidpsWmgI+L
         t8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXxmq58hewZ4oIcjzSZ2QaLfFLB7e+TXcptDS7y9uP4LVy7f8OvhGKHIwdsF7k+NOnUheLALcJXsrfv+VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxI5EYRUC5noTjDm95tYaa02P5PRwdJnrQr4XuDExEysGMF3iU
	ULbPOGYNiI6RXqDZnSpE4fLy3vMZobp5dsnN+3dFopk8ffyY1EXtpfUqnm/8yFfr2Rw=
X-Gm-Gg: ASbGnctIDOcZI/DObKVIeeEUeQ8bAPpRHcELnxFOQ+IZRGlJH1zFCt88hmEdq2Hjp1i
	EOOUYHFVdvBDZiV1FyuDfX9/eluvtkAVCA3ogeNPA5/v9enVSlqZfFrxKYb3KFzj8qDhcTp0Qaf
	eilmQZ9LnS3yPhUUaLZJvLVhDrelQ4lQJv6rR9yo00CdAdH8espj2SUvcKOgBHc/CoZDqqJ2BQR
	kRSAEP8wtAD9NKBccaMrsOFyoLzKwzhSsUU/4DY+DZwfvV3I+0jH+1lfCFDY/Eqx9fDETZGVmE+
	LbrfpThtX0SyFYJEY68b0XKiKO/rO8/3/0HGIoVRyfrsgDmpPdkhTVFWFXN64g1ViQxYdnZX+jD
	u3Ja2SiKdJFDe5bXLjo55U8pre3kFt8FkHcVZHQj8bAZNh4s4pk7/7IAX+uDGto25XF8tludr52
	cUtRoPAP8VfvAqtW4Cz+dQpg==
X-Google-Smtp-Source: AGHT+IF4JPIePgklGlaLoqm71Bu7ApcoRu6iTmJ5L4gpcRDvE83BvmdQI2sf+Wxgg7a+5Eyn5thE4Q==
X-Received: by 2002:a05:6402:13cb:b0:640:d0d9:71d3 with SMTP id 4fb4d7f45d1cf-641058a2312mr3606599a12.6.1762359305340;
        Wed, 05 Nov 2025 08:15:05 -0800 (PST)
Received: from [172.20.148.133] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e680578esm4923886a12.10.2025.11.05.08.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:15:03 -0800 (PST)
Message-ID: <8f05eb9644d1920f7158c19d769c943fd5dba9a1.camel@linaro.org>
Subject: Re: [PATCH v3 10/20] regulator: add REGULATOR_LINEAR_VRANGE macro
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,  Lee Jones <lee@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski	 <brgl@bgdev.pl>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Peter Griffin	
 <peter.griffin@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Date: Wed, 05 Nov 2025 16:15:02 +0000
In-Reply-To: <aQoNPvwUCE9PijJ6@finisterre.sirena.org.uk>
References: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
	 <20251103-s2mpg1x-regulators-v3-10-b8b96b79e058@linaro.org>
	 <aQoNPvwUCE9PijJ6@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks Mark for your review!

On Tue, 2025-11-04 at 14:27 +0000, Mark Brown wrote:
> On Mon, Nov 03, 2025 at 07:14:49PM +0000, Andr=C3=A9 Draszik wrote:
>=20
> > REGULATOR_LINEAR_VRANGE is similar to REGULATOR_LINEAR_RANGE, but
> > allows a more natural declaration of a voltage range for a regulator,
> > in that it expects the minimum and maximum values as voltages rather
> > than as selectors.
>=20
> > Using voltages arguably makes this macro easier to use by drivers and
> > code using it can become easier to read compared to
> > REGULATOR_LINEAR_RANGE.
>=20
> It does introduce an additional layer of indirection into the validation
> that the configuration is correct, the reason we use selectors is that
> they should map directly onto the register in the datasheet.

My datasheet mentions the range more prominently than the selectors, and as=
 driver
author I can easily validate both (neither macro does any validation itself=
). I do
believe code like this:

    REGULATOR_LINEAR_VRANGE(200000, 450000, 1300000, STEP_6_25_MV)

looks more meaningful and is more naturally readable than

    REGULATOR_LINEAR_RANGE(450000, 0x28, 0xb0, STEP_6_25_MV)

as it's much easier to see the actual range without doing any additional ca=
lculations.
I'd prefer to keep the alternative macro, but will drop this patch if you r=
eally
disagree that it adds any value


Cheers,
Andre'

