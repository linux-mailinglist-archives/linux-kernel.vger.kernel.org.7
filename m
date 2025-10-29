Return-Path: <linux-kernel+bounces-875623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2403C197F0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B6995839C1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854532B9B1;
	Wed, 29 Oct 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPGfSKT/"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0DB279DB6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730795; cv=none; b=FHz/fu9zPPQ5YUFRlFVyY8q13Z56kZfuAXy2heUeOT64Js+1NNzD1e/rH15HalmjhhRZVl0ZZt8OzbP/E0ESGTARR8vYh1UkjOOd/RHDCwPXsDQyykZK2EvO4anCn9QLl8CmiCtN4FuA5ei8nWJuu6s+WjApcAb7gzHqTfgnsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730795; c=relaxed/simple;
	bh=urnwJ0948OZAY6zDTK8e1ZFZ719514SR28lbeFJUqg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMcCvHUqlMLADjfltgYvjjP+RD3ENGPuualqtNhdUnasELdjkGG2xS9WJhFpQkuNn/ReX3txioD+zJNnehiKFe4sopHuPB6iOMAfKVgCfRwFLobopxEIzp6BV1toLVp0ujhvBLcNixFZb/7OWHRW+AzJQs4SMqbMqrRZX2opzzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wPGfSKT/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-89ef0cec908so578487985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761730791; x=1762335591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R+Rd5gslE+ZFZnAsPLhh3hhVOGomUEHbHKD97n8UNP4=;
        b=wPGfSKT/hLUQDLu+IM3dvya6BTa5HIRiJPDXeQcIRHMMcvN9nJ5dTwWnUtnZ1MyQBJ
         Ua2wkI3GDO8rRgOSa7zUo9Or7bg2WOTlpnxlI87SmPbgbaRsFEm6X8Yu16nYgsruQKIH
         i4hw0qlda5N3rRGJ6gpqFzw/kOlownOZNCZ6KAkNoMt9t0MKU5Y6azqhQ8ODiYgu6U9y
         O98EmsmxIzQqbxN2Hgmb7Nz+/GbeMwu+K00X9F2VSQEC8Fu3ptm9qPO50lnKb98lA4fb
         XMNQ/c1dJZV4EPcZH7TYSe8VJpuVfR/UUepm3qvFrM6f3BZgatuZ7pyDLk1MyG92oAgY
         g5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761730791; x=1762335591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+Rd5gslE+ZFZnAsPLhh3hhVOGomUEHbHKD97n8UNP4=;
        b=oWxgcXcNvqqrNvGqP4kBWIpeRs7LlFUfOiL6CCKK8wvIMHChJANkJBbHsPI0qi2njk
         8PatyeIjTrlv6WMkkczOy5cScDPdb3RVaot/xkC+wuogXDhPALfMtYJ3nWkBHldcTQp9
         QkcnAKs+NuQrDdnepWrOf57HrVNSeEXoA5a+ocu2tQVxzAKU5DbKYUcencBlooNaUSFG
         QH01ktcuttyDwmnBCM4cRSaeCjOZsQbnAwy00IMZPv4jWkvRzcdo2XWBHtJvQYJ2GR2u
         xWh6OiKQuqMv+x7dOyZ76e/6LhFGUc1NvWgVhGmv6VbYbmih3F0ZIVZT6usib0Hz8eu9
         lOMw==
X-Forwarded-Encrypted: i=1; AJvYcCVSpyP4Mr80jJ8YrxduZ/+ZIyuStC+O1/nw7BIeWVfUTL/oGTc+Gzy5eWiz8ImX4GeQna5fCDF+EK3n0BI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8EtBxMm3oQvm4gWQgbGtkyyOyR5YilMWqGGBlTDuSPaViCoW5
	IpI+fnVdw7OEKEXEX7gv9SuBFVXbxeHYxAmWi55OsuIhVXK5Cjo4kRVyTCgPGh1O0m6cScn1PPy
	2vUIbReDLUQUPAdnwTVO55KCjdCZX70IfdsFfS2UuMg==
X-Gm-Gg: ASbGncv1IgYA0yfYoROM4Q65f1piUGK0etBAUm1pXosJ+lHvZhxxsmsgPEfWlUPtM/c
	fsXotwP7HOL6Y7RVzLCfIWxob3ARslnuEcAeph06t3dqVPXkl7lTunmchCpOhD5Xp2Ubql1akW8
	bx/r0wA+8uS+RH9M3dldweHr6/24TJyYDlCzLK/bfBQcxN9Pua9ywFkiyjPBcrwZeoHqjTQvvQM
	Ma4k6TPyTayeONTGjBIicEWBjag5Lj91gI2PwOFUIBKSuNtAH7ZPZRNsnSvjdlTtjldnxD5IVnj
	SwnGNtLcLTrAYpHXbu7QPPbOgOf9
X-Google-Smtp-Source: AGHT+IHqXSf1MiiiqnfsW/ioS/jj/mhb/BAEdrr3nKBvzCE+jcWgD9EFD8HQohkXivlPjhP7YZ3CSvcZ9+eiOBWkEyk=
X-Received: by 2002:a05:620a:3704:b0:813:31ad:bf3d with SMTP id
 af79cd13be357-8a8e436119dmr303015885a.12.1761730790824; Wed, 29 Oct 2025
 02:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
 <20251027-cpu_cluster_component_pm-v1-1-31355ac588c2@oss.qualcomm.com> <20251028-enigmatic-astonishing-husky-f2c47a@kuoka>
In-Reply-To: <20251028-enigmatic-astonishing-husky-f2c47a@kuoka>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 29 Oct 2025 09:39:39 +0000
X-Gm-Features: AWmQ_bkH9LQFvaEP4xZtRhiFYXppvNFKfWjaQQ7mkEY-rNttgjUoHB7gFuBi_fs
Message-ID: <CAJ9a7Vg1jR=UBWwQanvyW_-ucXQ1HWQha47oJCUL6vkfQwgpKQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] dt-bindings: arm: coresight: Add cpu cluster
 tmc/funnel/replicator support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, kernel@oss.qualcomm.com, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 28 Oct 2025 at 09:09, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Oct 27, 2025 at 11:28:03PM -0700, Yuanfang Zhang wrote:
> > Add the following compatible strings to the bindings:
> > - arm,coresight-cpu-funnel
> > - arm,coresight-cpu-replicator
> > - arm,coresight-cpu-tmc
>

These are redundant - the actual hardware has not changed - what has
is how the device is powered up / down on the system

> We see that from the diff. Explain here the hardware instead.
>
> >
> > Each requires 'power-domains' when used.

So why is this not used to adjust the power handling in the driver? Or
another attribute.
Look at the CTI bindings - these can be associated with a CPU or be a
system CTI - we look at the cpu attribute to differentiate, not have
two separate compatibles.

Regards

Mike


> >
> > Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
> > ---
> >  .../bindings/arm/arm,coresight-dynamic-funnel.yaml | 23 +++++++++++++++++-----
> >  .../arm/arm,coresight-dynamic-replicator.yaml      | 22 +++++++++++++++++----
> >  .../devicetree/bindings/arm/arm,coresight-tmc.yaml | 22 +++++++++++++++++----
> >  3 files changed, 54 insertions(+), 13 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> > index b74db15e5f8af2226b817f6af5f533b1bfc74736..8f32d4e3bbb750f5a6262db0032318875739cf81 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> > @@ -28,19 +28,32 @@ select:
> >    properties:
> >      compatible:
> >        contains:
> > -        const: arm,coresight-dynamic-funnel
> > +        enum:
> > +          - arm,coresight-dynamic-funnel
> > +          - arm,coresight-cpu-funnel
>
> Keep alphabetical sorting. We asked this multiple times already.
>
> >    required:
> >      - compatible
> >
> >  allOf:
> >    - $ref: /schemas/arm/primecell.yaml#
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: arm,coresight-cpu-funnel
> > +    then:
> > +      required:
> > +        - power-domains
>
> Just move the allOf to the bottom like in example-schema.
>
> > +
> >  properties:
> >    compatible:
> > -    items:
> > -      - const: arm,coresight-dynamic-funnel
> > -      - const: arm,primecell
> > -
>
> Why do you remove this?
>
> > +    oneOf:
> > +      - items:
> > +          - const: arm,coresight-dynamic-funnel
> > +          - const: arm,primecell
> > +      - items:
> > +          - const: arm,coresight-cpu-funnel
>
> Hm? Why do you need custom select if this is not primecell? And nothing
> in commit msg explains why this is not primecell anymore.
>
> You have entire commit msg to say something useful, WHY you are doing
> this, WHY you are doing it DIFFERENTLY. Don't say what you did - that's
> obvious, we are capable of reading diffs.
>
> Best regards,
> Krzysztof
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

