Return-Path: <linux-kernel+bounces-727114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7087EB01539
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D57582C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97A1F4C8A;
	Fri, 11 Jul 2025 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xTERj0jb"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487201F4C8C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220365; cv=none; b=pJW5fAE5hErFbXF1wIg6Si5BIe9uh72JaqDmOZzoEOCU+UMHf+qmPEu4p6q8dNMSCoP3bD7CV24Jg+acap4Hn4SkIKnD1yIo+qiPeDxoN0gPhh1CIaP7p1Ee4cfQbZ+wxHhw7LNf9oZVTH4BzfgzjucC+ZaVHf3+OJgzsc2n+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220365; c=relaxed/simple;
	bh=88clJWMTGmjqJ9BXiN1KTtldoVSFmnjIjDiwiXd3dew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TosJDwWKsx3tg6pGK7Iws5uBqmupSm11qDbMuNemUks9qvF9rHFuqch2iKF2ChMvnkxHGkl3nTyQZLBamGikKETUOtXj2xyU3/SC7KwJIRFwDm47REawdNdaAPol0vovy0lVsKVgn5JmDjyezOkmAHaH/FasEKBQgYSV/XYWXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xTERj0jb; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5561c20e2d5so2293106e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752220361; x=1752825161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yjU8KLlsfOgD84pvhzgohiFicyXio8p2w/NrIenWZQ=;
        b=xTERj0jbyEBY1ou9oHAhnP8s8HVgQ8puUPoYhAdVmHv2xNx6G++ZUmjIDGJqS0N0nd
         ISBBvPVqTKgmz1tpILfwPqGq9KOt1QA9ixW/yQuZ4QDTxaAWA2Nu8wtrPdWHrhGBqqlQ
         Tk1zXW7tFDNpJgZdIsKWHx+t5VcfI0y6AM9z21vHzTFK2a9ofmsuCRaCFDFfzI8Qxjmq
         GFBaftBLjAXgAs/tW2wvuW3hv0eCWEinPU3fTJ/KlAJNFC3SJzJ/oRXim4T028bxxdxJ
         GDBIkbrDm8zJJBtEkAhc/kJhi++YUGFYhLhf1dJp6Cs3FwryaF7iVlU0jDZPBNTa4I7q
         +g5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752220361; x=1752825161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yjU8KLlsfOgD84pvhzgohiFicyXio8p2w/NrIenWZQ=;
        b=sVPTzULbwdEt61XsVX758Zwf953Q9l3L3hhqeBps9HrGXc9mO1VIQkD02qxY76p7d5
         oFGPCYUs2tUMGGyuNVKtSXR57hH5ChxYqPHuViNiQgD71/vbiTGZcGdsQxKyrBYdwZaD
         A3gaXClEU5TywTqF3BVcCv0HG6idxADf3POyU1YNihJyunBcxdqL+DZQhtn1d5ifKMOQ
         /gYGpyeAOAeWQtGOLnJ8UBKu0dkUxU0bnZLaaM2hVf5jodcNfxath5Z6IVy9zjE1rxMc
         PDhriXm9CxaxcPguWA6c7HxP3fLwglT9jb6C5Zr9aNV44/XGkgcShvMoA5IlD1M0/bWe
         UBwg==
X-Forwarded-Encrypted: i=1; AJvYcCXiRIdGN0VH1eDWJI47euy5/5BhBK+c0l6wCyXEds97SwDksWlZq7z0r4i2dxi5YMqU9PbrE7Wc0Z+gnsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP2Q64qBwIrwr3CqLCqC0Ho9RGqnoyxg5Ph6a7bkJ0mPyR3gmU
	SiQeUt1ChBVsj1aUUF4vImrPgi0yV6AURygIMnytcmzNRnN0+EccDHIOk1XZ8CuI6ycxOGvT355
	ijh8k5ygF0S8fUFL3eus+DRUEv4wmoEGi3m+GPoLaNw==
X-Gm-Gg: ASbGncvh/ilVeAtSyj49X3KjOZe3sU6K4BOPSpWwOpoka8xOGbTA4BF1SR0JpujU4a4
	69wmScEIHRzzpqVfcC2mNoXwlcTW3vkAriISiBTnLD9xeL4MFSaL/NoA9lTVKRD6qyQ0uZT9XMz
	rHR+/4ZTQ48UDMcH8p261Q57pFDn5nFFtMlC3khQotv1sGXmbZrhXgdoWcRnULvDaJ2dITULp+7
	vlZ2Md9ABblitxHK8Ao5QKSuyGzYUw9phvc9A==
X-Google-Smtp-Source: AGHT+IFnZKQzO8SQsEPR4+bbnrAqa1B4u0Jro/T92Yroa1+POHLtNiQWfQd6cdNN76m9sgUP6bGZdURAsrGpoIwSBow=
X-Received: by 2002:a05:6512:3ca6:b0:553:2bf2:e303 with SMTP id
 2adb3069b0e04-55a0463bafamr620336e87.30.1752220361177; Fri, 11 Jul 2025
 00:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-qcom-gpio-lookup-open-drain-v1-0-9678c4352f11@linaro.org>
 <242d353e-99a1-4ce8-9435-8b2addcf1276@oss.qualcomm.com>
In-Reply-To: <242d353e-99a1-4ce8-9435-8b2addcf1276@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Jul 2025 09:52:29 +0200
X-Gm-Features: Ac12FXxcX5qRn9gdh-ZC7VHsr37pXFF-mMITmlqtVTHjrCNkvSZ0ELEV4kvVi_I
Message-ID: <CAMRc=Mf6o0XNGTEbKih1vNNk119i5uSAqdOT219Fqk214cWoOQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: dts: qcom: fix GPIO lookup flags for i2c-gpio
 SDA and SCL pins
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 1:11=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
>
>
> On 01-Jul-25 11:01, Bartosz Golaszewski wrote:
> > There are three platforms in the QCom DTS tree that are missing the
> > open-drain lookup flag in their DT nodes associated with the i2c-gpio
> > device whose driver enforces open-drain outputs. This causes the GPIO
> > core to emit warnings such as:
> >
> > [    5.153550] gpio-528 (sda): enforced open drain please flag it prope=
rly in DT/ACPI DSDT/board file
> > [    5.166373] gpio-529 (scl): enforced open drain please flag it prope=
rly in DT/ACPI DSDT/board file
> >
> > Silence the warnings by adding appriopriate flags.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
>
> For the series:
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>

We're late into rc5 so gentle ping, any chance we could get this
queued for v6.17?

Bartosz

