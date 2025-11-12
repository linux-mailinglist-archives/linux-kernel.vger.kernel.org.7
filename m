Return-Path: <linux-kernel+bounces-897527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D18E7C530CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB7DB353876
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074FC277CB8;
	Wed, 12 Nov 2025 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YCIWhukC"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD80291C13
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960466; cv=none; b=OpTeSEkOdD14xp0LuFvO87LuimCeVUGicHYb6WFkWPibMhB2/zD6EWlgVuJVZpWFVwzvucP1kqTDhzgg2ta4AAtEqtoghrJA+dHJnmtDqOhktvzUMJhpu1PvmYm6RBUtUbWOUySesMzG8gl82SBdq4P6wcgRMtP1TbrmmACVbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960466; c=relaxed/simple;
	bh=KfVyXzQbeDETL/yDrjvNOh4rHGAiw+f1sfvOwR4EZZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fU6XuYltpSm22CiyDrN37vwRkOQvWRvlZrPOACGPraSLq63sTMUukQnWQn+ciI0y8crtSQhHn2mamPuVFY/CAosNYYjoN5xKV44bN/SaN+hVQLDiAg8N+/8j23Jk3O5pHzfGCNrpeywcitRVCDOsW+cES2vm5+uDhPlQ7hdZtk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YCIWhukC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37a5bc6b491so6828421fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762960463; x=1763565263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+QdVkbf95zLodOyO1kTFJXDz9bbg2/C6I/0nfO7/gA=;
        b=YCIWhukCeT6XBRug/feA8iYPlSslZVaPV/AY8RZG++FFOnHA3h/KdP+u4yPr6MS2N8
         SPb8KvqvqFa2YH7wPT1ZhEKss/Kd4STNazUnbzQifxnpUAg4pPl60A6tCdnZzTINx053
         OT86mRqpkcdcQyrhblx68Z/KADzgCrRjc/2laDs16kCLDbCFRgO0oo4KTFVVGw+QpNy2
         Q5CjxsMtVLe3KJQKCcbOZInSAGZOkrjIx7PnR1lFHZStPCw6jXAWh0ZNH2Gj2mNJPe7P
         Af//DG/WfGMXaadQT8VHibT/Fipoq0YTCs8qDyqtZxoalSyUoSo11UA6TDyXjdMoz5Ga
         m07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960463; x=1763565263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+QdVkbf95zLodOyO1kTFJXDz9bbg2/C6I/0nfO7/gA=;
        b=GsAsol2QcDREnQUDL9x5lFJmRUGg7R65R8i8eWklvStnNB9lb/9ePs0UgP4t4+TZ/x
         +Eu9A/wpS7P9aIAU+CfWqq2pIpzjPjiLhT60UdJ+fhpj3N9yXbsvQI+q24jg1wL2A1j+
         QXXCzc5Xynpz6CCv1em4N1Y2a5eV55RysxmDCRR3lJo9Ud8zFPOlmLg/N656QKPPHCmk
         fTbPuwRRSDNRk4C8p158KalKA56v201Yd/HKnxRwing0hc6xukw5FSFYsGQAy1J8kn5m
         iIFzuLYut4EK9c+rdLP+SPS9jhWVfGaZ3F3tAWg3jcotz9Sjt6m1BKqr6YgqRuwzAx15
         Mbfw==
X-Forwarded-Encrypted: i=1; AJvYcCV2FGmUqqHPBoFEq3UBhHx45277jdDv8bvScEoOFo4wJnCegifzlq1asTgjdfjYktxLZEK+x2x9ESls3zU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3T8zalN/Ys9Su4hUmThKlzlkUp95zNlcbONFChisFz4KZv2CH
	tk/eEw8xoHmoiCRReyy/8ki0sVQ4HbTOTxrvYfTLK6bwP5xNLmbwSEKJvJy5MKiMtNeQlEtDFlP
	/K0Up952tAskQ8+QXAeKo6K8Dv0PRmK0BWvyjjpVwLaTqTH5/Sl7OYbc=
X-Gm-Gg: ASbGncsmupc7/hPiDa1ejc8Dim40JzOxWhsdlw3bWkE+qcvFNWWFilHsiVwf2vqzcCM
	FRgg+MgHswrFd3vMdNmmL1fv+xLVVvLMY3bZpYcEohypsd3RgWrNyxOzfPc0vgi8WA7WrHsDcoT
	4qpsb4Vwxh5sH9xEYiMoa7fx8qerJXXmVc2+1mDfgQl4mtsfudfFmtTt7ZO4ssReVek8FcRFFz+
	5+b0uQcMPkWKKgcQN2xz/7lBU2nkhJwx04SnRMdy0NrcSK1BUB2/HhUVUlHvU2IlqGNorY88Y7A
	WaQtcJK89JTd
X-Google-Smtp-Source: AGHT+IFMDfiNQYOXVyFCJlLDwzpVyDmixLDSHAogUbbhy+wq6OHS7KGEO7K1heDM21yAh2VvGTgQF8A0HAZeooRc84w=
X-Received: by 2002:a05:6512:e88:b0:594:2db8:312b with SMTP id
 2adb3069b0e04-59576df1d90mr1036256e87.7.1762960463070; Wed, 12 Nov 2025
 07:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112034040.457801-1-raag.jadav@intel.com>
In-Reply-To: <20251112034040.457801-1-raag.jadav@intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Nov 2025 16:14:11 +0100
X-Gm-Features: AWmQ_bnpZz6ks3T2w4bfBK2oOgS0eQRCxr7lzgLUOHXAN4GCLssFxg_TaDnqeoc
Message-ID: <CAMRc=MfYZq8vKxb736RRc17Ufu1A+6YDMuKDSME3Ly73y1ZRvw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Introduce Intel Elkhart Lake PSE I/O
To: Raag Jadav <raag.jadav@intel.com>
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org, 
	platform-driver-x86@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 4:41=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> This series adds Intel Elkhart Lake PSE I/O driver which enumerates the
> PCI parent device and splits two child I/O devices (GPIO and Timed I/O
> which are available as a single PCI function through shared MMIO) to thei=
r
> respective I/O drivers.
>
> In spirit, it is a continuation of PSE TIO series[1] which received
> objection from Greg for abusing platform device and has now been reworked
> to use auxiliary device instead.
>
> Currently TIO driver[2] falls under PPS subsystem supporting generator
> functionality and will be coming up in a separate follow-up series for
> its independent design changes as per below roadmap.
>
> =3D> Extend TIO driver[2] to support PPS client functionality.
> =3D> Develop a PPS common driver which hooks to both generator and client
>    counterparts.
> =3D> Develop an auxiliary glue driver for PPS common driver.
>
> [1] https://lore.kernel.org/r/20250307052231.551737-1-raag.jadav@intel.co=
m
> [2] https://lore.kernel.org/r/20250219040618.70962-1-subramanian.mohan@in=
tel.com
>
> v2:
> - Consolidate OFFSET and SIZE macros (Andy)
> - Make child device objects parent managed (Andy)
> - Fix double free on error path (Andy)
> - Shorten child device names to fit id string length (Andy)
>
> v3:
> - Use auxiliary_device_create() (Andy)
>
> Raag Jadav (2):
>   platform/x86/intel: Introduce Intel Elkhart Lake PSE I/O
>   gpio: elkhartlake: Convert to auxiliary driver
>
>  MAINTAINERS                             |  7 ++
>  drivers/gpio/Kconfig                    |  2 +-
>  drivers/gpio/gpio-elkhartlake.c         | 36 ++++++-----
>  drivers/platform/x86/intel/Kconfig      | 13 ++++
>  drivers/platform/x86/intel/Makefile     |  1 +
>  drivers/platform/x86/intel/ehl_pse_io.c | 86 +++++++++++++++++++++++++
>  include/linux/ehl_pse_io_aux.h          | 24 +++++++
>  7 files changed, 151 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/ehl_pse_io.c
>  create mode 100644 include/linux/ehl_pse_io_aux.h
>
> --
> 2.43.0
>

When this goes into the x86 tree, can you make it available on an
immutable branch for me to pull into the GPIO tree? Either just patch
1/2 or both of them with my Ack.

Bart

