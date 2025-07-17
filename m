Return-Path: <linux-kernel+bounces-735458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AB1B08F94
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FE116526C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D792ED87A;
	Thu, 17 Jul 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RDacqTM1"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3062F5C5E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762972; cv=none; b=oKGyZxBKo4hatOarM1SwGQeomB7i0kMtpoN33+tCZhWvg4vxsuc19mqe9SA3ZwKM3YCxxcZ4R1ARCFAkYgV8rfeyjlMMZnPLL8Vc/rlXiL8kKZUkxDRFixJb+aCKEYiMD60EHZVmLsApaB+Vr3NvBBhh3RKWjNbRqH8L/VXhqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762972; c=relaxed/simple;
	bh=ny1BxpwJ+gAFLsYDwALEIo5Wv2OZBJ0SHB8Cu6cHY60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGuJgKZ6Zqy8Z6JOLtwhyUkYXtfy+iiwIJsUu2uuXKhnJ6u5PGLSPHKHM0c8CsY61vJVx4B2PXGO0DtkPapSDmRMZoZcaCD9wzrm+cbdFsCLXBkbiRFXg28tsB1PJOjDaGLWtug/WTw5SVLtcavetzv3hlS5NDUve0r0K/VrM8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RDacqTM1; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5561d41fc96so1219956e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752762969; x=1753367769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny1BxpwJ+gAFLsYDwALEIo5Wv2OZBJ0SHB8Cu6cHY60=;
        b=RDacqTM156otUAtjNJ6NoWDczXDxYnMU+CJ/w7Q+kpxdQLhHey+klzTxyabRC+WUEz
         h7t2UhBJhjtIsBeLzTCw08DOXTmm01nyULxJFmBrl84oRLx7ZGh44NmlxiUsYhv6Orn9
         Otgwkmm5J0Y3rTNgBpEXkjMlxrwjH6TV5W1hTahmZfs6U8kESbxTMbWvnlmBaY9d8pPz
         vS6TC5KS7qd6+fjxThpW5Uvs7J3ngNKrnCW7ubeck/uySKE6H0mXKOrHbCjW49HOYFXG
         V+ilQFXKoRBpvj5r2jmE7kuZs2tGJNygSaTc02Zt4aZS0qKtEjWeaNjH95L7o4ZpFVe7
         mj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762969; x=1753367769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny1BxpwJ+gAFLsYDwALEIo5Wv2OZBJ0SHB8Cu6cHY60=;
        b=FlUk83jEcCDsjMHjg2OISwKCbL1MVl/pvnnIJf4moqhtLJjMTKnBVnEEGmQLPRgQAx
         lkYTKi3bLu4e5RbvPHmmyzAN2B6TV5oq/TTtFE+o8t/hlS6yASd3G7+o0OHId4/0NCDD
         +0BQwBTttZLtLqmbpFZSEDBiHPoigYC1JLyTfnvcmSSWnqGS9iNHGja6asxtl3/ZxAT5
         Vd0Yl0M+aRHEytFRPKfu9BFKShq81h0JOCz2GtxRKUSi3P1+PewQcxLfluRxJsgYoZhu
         zz/I9+SK+3lnjbu47zve0Sh2L/SS9TARoUyTnB4+4RAQrYR/wOZfJlFStVzCyhpMgkl4
         m6Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUcfd9lFN1/WfF19JUsfsVnKDlzzdKYSqQCtL3/nXBoGWnMj2dRx1+Q1Shxm0HmMzaPWOQ0M8Uat6Tfa68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQwFZ8yeWoY4nnKLW92PyfEuGjtxfscgp8q7xJLX0JYuCEIZm
	qDWXuQAsWqPnGk77y/gACnzjzgLezyWaJ9Cb2VI1TGQafFwA0uhWlFpE8I52B9DaqcA57ge/+IT
	L30hIlUozbHR38DIMYxvfaEZPfiCo97kv1lwZOFkACQ==
X-Gm-Gg: ASbGnctR8DJ9o+hBbAks0eWJbhIr8vnCTru+q7QW52AyWCM0AE3P8zhlr/LJX9hvAhI
	+9eVMEu9OpUbiDgupAXZG2Llju7D8MzSRF9qooQn7zu98M3Jbcphleh/1EZF7uvgNyTn+5u5WST
	ZlzwZ82B8K3b90GAonY0sZDuwheolBKZlvC+uoQKZaZUqw/3mX7w07nW8CdM5LHfai5DP2y86m8
	jcSaDFIq7ULLWb9w9rZczDZ4NiqT3372D50DX4=
X-Google-Smtp-Source: AGHT+IGjl+IjWtSow0sNLT+eDGz2anPMKy3xAT4nehVSKgzWbZzJ9LXLTECN4HkXrMGqD1WGIZl2+8KPUCZyseARbVg=
X-Received: by 2002:a05:6512:b98:b0:553:a60d:68a3 with SMTP id
 2adb3069b0e04-55a23f0b81bmr1812465e87.2.1752762968763; Thu, 17 Jul 2025
 07:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com> <20250717-fix-rpmhpd-abi-v1-1-4c82e25e3280@oss.qualcomm.com>
In-Reply-To: <20250717-fix-rpmhpd-abi-v1-1-4c82e25e3280@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Jul 2025 16:35:57 +0200
X-Gm-Features: Ac12FXw22vD-hbFh-u0btfg0jHk5nii8D4KA4wahfweHWkbcoH7xxCz4FWUk7vY
Message-ID: <CAMRc=Mff5Yczwq=LTPNYkFAxh6D-Zt6Za9y3eLkVXfhoKdxkKg@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sa8775p: fix RPMh power domain indices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Ling Xu <quic_lxu5@quicinc.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 2:51=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On SA8775P power domains device doesn't use unufied (RPMHPD_foo) ABI,
> but it uses SoC-specific indices (SA8775P_foo). Consequently, all DSP on
> that platform are referencing random PDs instead of the expected ones.
>
> Correct indices used for that platform.
>
> Fixes: df54dcb34ff2 ("arm64: dts: qcom: sa8775p: add ADSP, CDSP and GPDSP=
 nodes")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

