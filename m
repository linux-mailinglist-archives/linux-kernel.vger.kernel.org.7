Return-Path: <linux-kernel+bounces-841205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1537FBB67F6
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04C144EAD2B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB632EB5B4;
	Fri,  3 Oct 2025 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yJQobbHs"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6C1C84BC
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488950; cv=none; b=gEMJRyR3FJ56Kd0aCOOT80dBXuXspS03epF1yEifrw7FNQVLIDzenu/QEJpjNUSYdeMNHZ2iY2iF0bLVSUU0jpFHSXC22HCSXkmCxfyfqy++4GNHM5X8cs0Knd965ccx1EDmmIg8SXbCjmr+Cja7pl69A3yQQVQaMEUakNz80rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488950; c=relaxed/simple;
	bh=KChLKSNNxImhmb85Mo/OCLoDmoiyuSxlxjqr9/wUHno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbGv26G1Fso9ZK4L5zA7dKdYxui/girHC+WT8Vv+NcXZSBWmthcqVCRMv9kN0xkIKSevD9XCGXNgHCCDQ7+ZMmRbe02dS7/jTTrra/JdqYCvHPohPp7FXW+rp8TS7sXgkOBm6AxvyYSRYhHZJ1DCqMDXm4QdcVHPDdZmYkZD4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yJQobbHs; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso2485849e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759488947; x=1760093747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KChLKSNNxImhmb85Mo/OCLoDmoiyuSxlxjqr9/wUHno=;
        b=yJQobbHsF+Nyb4RPYgZr0NJ8omtIWZu0ESZxpaPEJ5O0eZtAoE6/LFCd4vmK86M/WG
         mYl/e7IdYmKEjHAJ0hafKhyh7E8fde6npBr08kV3K6cOq85IvXtfqsA3tkN/H0AtsHfd
         t+iNJ5nzyikfGed9kayawce/D8p34EH7RmD8SoYDZbxy9RVy7Fx0O8HNciU4PSSg+5BR
         y3A+EscyVsHK5+yCD3Xr8emxPvkF/4FY0gyVHRgEsGZRe1lyU21GhKfP7OAGxiEU9Z6A
         TBnoO2rDirBg2hyA4GFDrsH/KWOxiGpwRZ38+SHNoa74yU3lP721V0D7tpJqBkmioMtK
         FEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759488947; x=1760093747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KChLKSNNxImhmb85Mo/OCLoDmoiyuSxlxjqr9/wUHno=;
        b=axOt/tkVC3s1P0nh21JbGZLHMVvGWrJtWRs4rPWJvxhEh6HL+uSRMJcgqkSKAcSk+Z
         xKBL1YADaFhI8HVcGMIqn75Vq2NlG4i25UQRslwQt9pFUqUcZ41wur91BXQmk6ChqzAY
         qhQ6BuS0YBC5Qe6XX/I3a/pm4ptN1wcS6uWoMqeTAghPHBtlhlt+k7+gZXhVG8YurKM7
         YC+IDjPKEOIashoF1qlLJRqhYktEg7SJrhQvnmmyc2iuPXx+Ih1k6mggeU2A4wB9X9hT
         qyAQXzELAKuMmMyAUAqL+IWt3NWh4cIkBNCoO4hMhIG8gWYUo4fBZwJ/UKGU8H4S2NG1
         eY+A==
X-Forwarded-Encrypted: i=1; AJvYcCW+QY1jUz2kABLj++oYhI5T+cFIhmzgLLoMuvIBGnz1+rey1OWIZBLZuxWSPDNYQr2ooM6+JEQn3diBjjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNAYpy3xRvauJek4+v85Hl5lPAX5783BFqBs68X9ypNFaXwmR
	MpXguOfroC0RHAiiWtaZl9/g7OTrw/x0o4ffq+wni3/l8Zko9tD+7+VKNcKM5UsHWmPdErTEav3
	RDamoMdWWKFucQ6N+0dVi+1M/vyUwn4i/RkYpyJ+3Sw==
X-Gm-Gg: ASbGnctCzCeKR+emneWGdWnioacEOaTIA37sdXw6jkKSB5GTCVRpE2qdq54JM5g2cBz
	8ytAQCX5WuA3glsE2bYzNuT8ImloNSz+tc/PS7MUoWe74+PM5oNFhDfqxr3ePK0XhMWOiOpqQQw
	Iom4DptDWLm0/UIPdovdsaMEbd+J/rXFiDHj0mVGvsP1tm9HGG90QMAqWfwaVvlSPhWuSZorjro
	6swmnCMYA4WEqfPUn715Kp1MO+gE4r5Ay2Ex0WFyP8MsH2RWR6n82TE6qMJGyFDyEwfCTkQ
X-Google-Smtp-Source: AGHT+IE+mDtAHcj8cofetU5hFSC919BiuXGPbquu3PKU0UznoaKUN13j3pgLN59a6ZtfWEBTY/v4Bw3wEb2vT1GSTdc=
X-Received: by 2002:a2e:be25:0:b0:336:c873:1b10 with SMTP id
 38308e7fff4ca-374c36cc060mr6748801fa.15.1759488947068; Fri, 03 Oct 2025
 03:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-glymur-pinctrl-driver-v2-0-11bef014a778@oss.qualcomm.com>
 <20250924-glymur-pinctrl-driver-v2-1-11bef014a778@oss.qualcomm.com>
In-Reply-To: <20250924-glymur-pinctrl-driver-v2-1-11bef014a778@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 3 Oct 2025 12:55:34 +0200
X-Gm-Features: AS18NWAW-daWoNVINmwOmpTVjv-RaNkrGx2GTsWudsPfvxarUw2lB4KUyWnktIo
Message-ID: <CAMRc=McSfXDmObrBeCAnawe-BMB+824yEbWR+4vxJai9-n9+tQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: pinctrl: qcom,pmic-gpio: Add GPIO
 bindings for Glymur PMICs
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, 
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 7:01=E2=80=AFPM Kamal Wadhwa
<kamal.wadhwa@oss.qualcomm.com> wrote:
>
> From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>
> Update the Qualcomm Technologies, Inc. PMIC GPIO binding documentation
> to include compatible strings for PMK8850, PMH0101, PMH0104, PMH0110
> and PMCX0102 PMICs.
>
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

