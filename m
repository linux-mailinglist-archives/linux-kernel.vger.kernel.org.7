Return-Path: <linux-kernel+bounces-857568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBDCBE7270
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EABD4FF6D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E9928469B;
	Fri, 17 Oct 2025 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+SYuu2D"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82328369D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689570; cv=none; b=Lel07Uu8AeTXEFy3qentENJRA3/MMtxY8vxbtPomP/VkFBWMRJuX0+tNbxQ6ZGZmKtNeBbIJzCu8WL/LgBN4JHlKFRwBGFdlkc22rHpKLNak1ef2fWh3Dup0ZG6WIdyKR2XSKeidd8ZjVJiPlIbx1a3Fp/dg0CYpaBhjqT4thvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689570; c=relaxed/simple;
	bh=yFK6k6NhAz92VDinM24x4y/M4QwPXWbPL4uuyBP1h4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0fhE8+Lf5xrFFqf80pKyP2bvpgOkKHPjKIK+xh03tjYkH1Kb7uUBh7e9nIV6PKthXsW9foMNHmxlfexxtQlzP5YaXwdtswvAHjKklYWIVwLBt0gxL2O2tkaWAEX45pnadxgzp1oUe7LzYIyRj/7QpOcWoISZeXwdCp2FhOSUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r+SYuu2D; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b5c18993b73so282459966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760689565; x=1761294365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VyUwehKjLcuHDNejMzdoJjZAJgmXLkyY0r2v2tgM9dk=;
        b=r+SYuu2DDkYNv6Li/U1leIJ9WwxXoJxGD9ndnSXAH7VPeHWOfh48H32yVNiClAtCHM
         Pv/SEfjIkKF4QD/jmsMcjf/CbtqX9DD2fq1f6N1tFggBey74g5RquL5lEpL3DaVfnL2Y
         slBIQBVMi8FpAxqYjUj+KAMhTwgsKpDGnknGrgyRjMUCQmUzSOOLn8mIn9MOqMfh5+mG
         PVquCDI2ZnljPY7EAichAHwMy11iKEisB3/+Sl3ZIDQrIbLyufLpdjrBiPcJdFUeJ9EB
         1SLfS34Of8a2ZIb4N2wxnwN2WPniS8CV1DbPXjeJZqZ4LHeOQnu1zDVsoBwjgzdqjtE+
         aTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760689565; x=1761294365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyUwehKjLcuHDNejMzdoJjZAJgmXLkyY0r2v2tgM9dk=;
        b=SRZQr8zNOywFf0i6WBox8hqS9DIVYVVJAYKIEL4p+VDtgI2n6oT9Uq72yYYnm4neRZ
         GYYwttm6dJbl+VgwNXHoVxZotu+1G7+QooNWOdoe7qm99F2KcpYxPH+LPVvQBx0dQvYD
         YQkyJGQXW2lwIEp8SAle/WidTgnHAyN0a0plAUVMhjpXjsY/hOjzakm05okRq9GyUkg9
         YG0PD8LAy041BLtNkvGwcjWXwo2iG+jgeNlR9aFn579hoggDlY7Z+nB+sfFnEB3DYRO7
         9SQE3qocledX2XmaBTnJPGo/DVrODvnMMDiAg4wmxSh8VEOsPyGxbzUc94PK88qINcPJ
         IOqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5BWIl6/APXcGZnI+mNSHEjQIsUpR/IfJHQt/TY/lHOn8zejGFjy/dKVKKTbifWRyQLkRksBEv1rK4PLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyflSkBJgHLT5j2nqcISqh1GMUTR3uvW0tq/Ppt4HdIdAMmygYL
	IjReW6jZMbcPl5edfFuAg2QGWW6YpzMxZM6YgSpGG1MUCfqM63mbM22p7QaCo63b+BI+is/Ca8L
	XrIa2NaQ3pD6EsJfvWzrVTdD6YmRgU24qHawIdTvlis2I4j9i+i4DkEw=
X-Gm-Gg: ASbGncsK+WR+ra2gGle5LHyAYn54pSu7onFJ8/IIlslhS1AhPJSaDClFTr2qRRIz1MI
	oEM2q0+lHj282VJyoNuA85KBlraQGxDX/q61sS/1S/kuwxMnEJKZGs0z4lnQiDv/pIorgLeHEqS
	MoVo5xk2GeisFlPPnpam26GtROJrKhd3O3cnr69+3wzH+GPgdDIc6hJS1gea9pzmoYhDwHXiYn7
	kPiTU5X6wz2MEnqUjW1DP2rLbM9/UMQnYsYMR1Yrsx5WhCJHNsYNHgg29VOA+lv+VnTIRs/lXtz
	lrzPOQXyVkEV2i47
X-Google-Smtp-Source: AGHT+IHbtlFXBkl17CEDHiEIXjQIR3AcZWigxlCUhE3F8cQIbFOycTLrDz3Fd9b4pkwziOemPMHap0mwtYPqnRvlsVQ=
X-Received: by 2002:a17:907:9801:b0:b49:b75e:6983 with SMTP id
 a640c23a62f3a-b6475316890mr278570566b.49.1760689565581; Fri, 17 Oct 2025
 01:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017070702.1637092-1-rdunlap@infradead.org> <dfc03399-d4f8-4e52-b097-75fbbfd1c8f7@oss.qualcomm.com>
In-Reply-To: <dfc03399-d4f8-4e52-b097-75fbbfd1c8f7@oss.qualcomm.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 17 Oct 2025 10:25:54 +0200
X-Gm-Features: AS18NWCUY9arCyHfiUtW12k5sMm7r8Ddi1bbMBtkAIVhTV3EnWf4cbcOv4bku4E
Message-ID: <CACMJSetEtS6n8cA0bnH2VORw_4b3Jpw74nqNAqE4W8XLKo6grg@mail.gmail.com>
Subject: Re: [PATCH] firmware: qcom: tzmem: area: fix qcom_tzmem_policy kernel-doc
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 10:17, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/17/25 9:07 AM, Randy Dunlap wrote:
> > Fix kernel-doc warnings by using correct kernel-doc syntax and
> > formatting to prevent warnings:
> >
> > Warning: include/linux/firmware/qcom/qcom_tzmem.h:25 Enum value
> >  'QCOM_TZMEM_POLICY_STATIC' not described in enum 'qcom_tzmem_policy'
> > Warning: ../include/linux/firmware/qcom/qcom_tzmem.h:25 Enum value
> >  'QCOM_TZMEM_POLICY_MULTIPLIER' not described in enum 'qcom_tzmem_policy'
> > Warning: ../include/linux/firmware/qcom/qcom_tzmem.h:25 Enum value
> >  'QCOM_TZMEM_POLICY_ON_DEMAND' not described in enum 'qcom_tzmem_policy'
> >
> > Fixes: 84f5a7b67b61 ("firmware: qcom: add a dedicated TrustZone buffer allocator")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> > Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Cc: Bjorn Andersson <andersson@kernel.org>
> > Cc: Konrad Dybcio <konradybcio@kernel.org>
> > Cc: linux-arm-msm@vger.kernel.org
> > ---
> >  include/linux/firmware/qcom/qcom_tzmem.h |   12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > --- linux-next-20251016.orig/include/linux/firmware/qcom/qcom_tzmem.h
> > +++ linux-next-20251016/include/linux/firmware/qcom/qcom_tzmem.h
> > @@ -17,11 +17,17 @@ struct qcom_tzmem_pool;
> >   * enum qcom_tzmem_policy - Policy for pool growth.
> >   */
> >  enum qcom_tzmem_policy {
> > -     /**< Static pool, never grow above initial size. */
> > +     /**
> > +      * @QCOM_TZMEM_POLICY_STATIC: Static pool,
> > +      * never grow above initial size. */
>
> Didn't know inline '*/' was cool, but if the checkers I'm happy, I'm not
> going to complain either
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad

Yes, very surprising. Almost doesn't look "right".

Anyway:
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

