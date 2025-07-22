Return-Path: <linux-kernel+bounces-740759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C7AB0D8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E26E7AA342
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F782E425F;
	Tue, 22 Jul 2025 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZISTQk5"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0419F2D3A88
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185632; cv=none; b=Ss+ZhRjpZqIruQ2InIoUDWty82kkcGlpnES2NI6XSeN0i+j8/ad8+sDSWIwzhXUvDzd/eQbhoL1emLhNG70rYbsjD4V5WFnSGH3B0yf8lISd/7puTN8U8BACHfmnSioPWFveHRvUncUkYNNRvn4M55lPvATP2rA8LCb5ruUf4kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185632; c=relaxed/simple;
	bh=TyKN+XzYCkV6rwuA3vy4eTsqF3nFqVxpsgelQW7FRPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ny+MlRrGWCKWEVZrEho2tdrcpcn0imqxaZj+htaP0qIWCq4eF3r472el4riPVNq4fVWbmnhdEMPrud5YtBI3BARDd8aK8+pEFBZwqWHKcyxRxq/NdPgHM+cIyESY/Ghv05Ux3WchJgeGc8n536682iNhqqjBXiLQMMFOGVGNOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mZISTQk5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-75001b1bd76so3345695b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753185630; x=1753790430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ptH7TdqJ1a9RBPR6TZDZBqzzcIS8gfN8+gNc7Nchtao=;
        b=mZISTQk5ifn97Cs+yFblJMTrviWVKG6QQSiD+iA8OMiMRBYkg8b+LdCspi0PCwHWQ0
         jqd+rYEbohqtz8veSa2zResH6/d/pcvlfHQZgaapnbVlhTU0gtZhHxNpnavAp95dM7Pb
         gPOg4WTG//4iO97V6NPkEETpUzvYci3JosnJNb+aCO2CAsxtyXHvn6x2+qsDXuFFMTyv
         aiFfw8lwb9r/fRQDeqKsElYQwo3q6EtOhzHj4bfeVJg7pYLXyoMyC0SiIZ3SfHtJIOXQ
         IFv1raMvPBMck/ZkEaq0AazukXEfBTclmTIoxMEvLXnBR/OCVzICYs22CXiFYla738z4
         0CJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753185630; x=1753790430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptH7TdqJ1a9RBPR6TZDZBqzzcIS8gfN8+gNc7Nchtao=;
        b=aByD3vv2qjU/aaG/vJHf3trMZ+kNUW9KYcbJcK5Rohd9JPwNb7FfSBSCDyNOPx0jNc
         qX7ZYu7vb1nlMqeM0J3Hp7geW/ftWR//JGfMtT0ACzI0ES1OksD/6cs89bVcKymNqHf9
         Zl6TDhk5oQKreq63nSr8jpwnqm2GPhuwUpE0KOlZm3vcMJEyv6KnOc83XYneLPA9Mlx7
         hHYiMzMshd632h68s4eUqAirY3UEyvv+hPYcNZNylSGPf/U58Ko8j6GHu2nHb8irrv5q
         AFEhvpiZ/z8qcGSzHG4pES/7bOK00DZKC0+r7s2BSydVGQ1Fa2nHSaLTe9M0zJF8kxwh
         g2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdymQXGSk8XVrGMwPqgF/Q3Bd2jx/NWAH8hFwMyG2nFAPM1ShWczC5gcY9wb+KmRy0cs9mxwszsF43yVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzafYHsE65UWHYIykYURp0sJ/opm9jEZMYvq4G1t1pDdGoIF3Jo
	LdWU/bsX9aV+MIqzpyoX2Hcbm7bsEyBFW0oSRN78m1SbDJnjl43A89GeFTRFiB0oXlGyQpyVnRd
	DzJFhjPw3bjyeClZE7sg0ehWVYajS2AIQB7WpO9Qz2Q==
X-Gm-Gg: ASbGncu94juMXl1m3xjB+ZIS9Aqj1tZABksRgdUBt/BajCTR3ig8W2sxuftvjsPJTmP
	iqFWT9KTi2JVHrr9HjKQiRa85DrW2WmPgiFpbXYpN+yrJiS3MudIytJH6N5sI+Zkwxe30gOCRo5
	6Kt8+zCqDQ1L9ILG+xYUGP373bOmOgne48PZlo6egHIR1GQKH8tMah9Jd/5XIV4v0GdkwUVfI8u
	+H/xuDr
X-Google-Smtp-Source: AGHT+IGTyCeY3UMh/uN26NrX+9pLVitYu44Yg1Cv05hntn0WmZXzyYQmgf2Srl3Zso4XLkxJAtt8NFNBvWJVP5c1/co=
X-Received: by 2002:a05:6a21:6016:b0:1ee:a914:1d67 with SMTP id
 adf61e73a8af0-23810e50f83mr36040966637.2.1753185629855; Tue, 22 Jul 2025
 05:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722081405.2947294-1-quic_jinlmao@quicinc.com>
 <20250722081405.2947294-2-quic_jinlmao@quicinc.com> <727fa9f4-fe25-495e-9d8d-48e504fbe6b0@arm.com>
 <20250722091425.GH3137075@e132581.arm.com>
In-Reply-To: <20250722091425.GH3137075@e132581.arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 22 Jul 2025 13:00:18 +0100
X-Gm-Features: Ac12FXxwWOJchARr8CvJVCGpP9c_3WusEBTfWMpJDyd4T_uRT6DBiailwW2ufC8
Message-ID: <CAJ9a7VhLLgAak_4FB=iW0izXprM4W+RsKfHUeo=XUHh9LwtUsA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: Add Qualcomm extended CTI
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mao Jinlong <quic_jinlmao@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Yingchao Deng <quic_yingdeng@quicinc.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Tue, 22 Jul 2025 at 10:14, Leo Yan <leo.yan@arm.com> wrote:
>
> On Tue, Jul 22, 2025 at 09:49:28AM +0100, Suzuki Kuruppassery Poulose wrote:
> > On 22/07/2025 09:14, Mao Jinlong wrote:
> > > From: Yingchao Deng <quic_yingdeng@quicinc.com>
> > >
> > > Add Qualcomm extended CTI support in CTI binding file. Qualcomm
> > > extended CTI supports up to 128 triggers.
> > >
> > > Signed-off-by: Yingchao Deng <quic_yingdeng@quicinc.com>
> > > Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> > > ---
> > >   Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> > > index 2d5545a2b49c..1aa27461f5bc 100644
> > > --- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> > > @@ -84,7 +84,9 @@ properties:
> > >             - const: arm,coresight-cti
> > >             - const: arm,primecell
> > >         - items:
> > > -          - const: arm,coresight-cti-v8-arch
> > > +          - enum:
> > > +              - arm,coresight-cti-v8-arch
> > > +              - qcom,coresight-cti-extended
> >
> > Why not call it qcom,coresight-cti ?
> >
> > There are no other "qcom,coresight-cti", so "extended" is not required.
> > Is this specific to CPU (i.e., CPU bound) ?
>
> I roughly went through the second path. Combining two patches in this
> series, I am wandering if can directly check registers (e.g. PID/CID)
> to find CTI with qcom extension. If so, you do not need an extra DT
> binding, right?
>
> Thanks,
> Leo
>
> > Suzuki
> >
> > >             - const: arm,coresight-cti
> > >             - const: arm,primecell
> >
> > _______________________________________________
> > CoreSight mailing list -- coresight@lists.linaro.org
> > To unsubscribe send an email to coresight-leave@lists.linaro.org

For a change of this magnitude to a CS component, that the ID
registers will also have to change. This is a requirement of the
Visible Component Architecture in the CoreSight specification.
External tools cannot see the device tree.

This is effectively no longer an ARM designed component, so the
CoreSight specification requires that the DEVARCH register change to
show qualcomm as the designer, and the architecture value change to
represent this component.
DEVID should be used to allow the driver to pick up parameters such as
number of triggers as per the existing CTI component.

If this component is Coresight compliant then the driver can use the
ID registers to configure to the extended trigger architecture.

With complete remapping of most of the registers, and the dropping of
claim tag compatibility - which appears to be a breach of the
CoreSight specification - it may be better to have a completely
separate driver for this component.

Regards


Mike

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

