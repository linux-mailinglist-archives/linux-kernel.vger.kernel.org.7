Return-Path: <linux-kernel+bounces-869711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1080DC088E8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A02F352D72
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCF923ABA0;
	Sat, 25 Oct 2025 02:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmWGZOmf"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E08D531
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761359238; cv=none; b=eoOjAJHswannVzvr6AthvEC+6fG5I4I6E0K8mefiL67i96Qq546O9VTRn0fmhtf480rCRGK6DPN6PuT9BYPsBtVYaOOKLmrhw4/pFoPoO0AyAOwfNovRXv6BQwhURNt1xL+sFK+SiCRgbW04k63/9DdiNvzlCDTXkHdPtZsQrRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761359238; c=relaxed/simple;
	bh=x8OlYWFi6qnMbSDUo1cgT5csPWwOhJOPBrlPWQui8DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1Swn31c92AWvCbPHf3UdDkh5piJtEEizoA4eNIUXcLY4skwA1n1Q9eS3X05DG53vuEcwpxqXFoYASQWaAVNIIFuWSRgqhuSDPUmh1K8FCWJ2bAH2xD4IA1SHatankfUHj67l4Nr+GiSmDoDgzGhnZMuvg9QnjBM0DMzfBl0pLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmWGZOmf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290dc63fabbso26492585ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761359236; x=1761964036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5g8OWVuVjsbahwY/Qa7JcyvpPlQfkEr7235nxaCt5s=;
        b=RmWGZOmfLv8u5Gqw3g1uk3Lc5GM3DU4/2G7+PpFOIHKSc04DsCrPZmIVlgwaJ7bzAX
         RhvBSa2+o/BmiA6jiuidar9JEy6oide/uFd+qmP7GUiNXrB0YUgUliPPHKFoWHPPCCgD
         HXlCNU3AzOju2jVgDPTEbjZm1fEZIPPJK8FqFa9O0w3ymL5/f+ChvvktjxZdmjoGv2EG
         4cwwhonY1SKQGBCO9vZs57tU6tiV5L9ONC3032y7CnUCaTexSXWemlIVC+QI6LAVVje/
         RcGTeqnJ5Zzuix2lDfUDMvHzbfNS6ioWQdLfsAH1ozjxizPXpCLaxhlmuNLNJnbU8B5j
         t9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761359236; x=1761964036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5g8OWVuVjsbahwY/Qa7JcyvpPlQfkEr7235nxaCt5s=;
        b=vMvxJbG3eGzNUXYjQP84Buxuo7jWhKMXnSVpJml8ElH22mcWUFhFdfu5hnLeo+rXWq
         gid/hfXTzLAbij+/Wf7K7lfckWrjmrESp0wt/s88bwX7lElhzHJFYlHx/aZoTfsrofF7
         ZMf3UuvZL4CARDvVTcnoqGBmb+vys1NIx7ur5/cVh2cIjd38YtZN7rs9g5wHWpB0mjzg
         c407EHWl0CcMi71owEcRzae6Z5mcsopFlyaUT5qy9QgxE6lSQZk4uDiHeLz056ZCwweS
         ta+4c1RhJA8kXlxGvijBZxmaAlC3R2wmzfyTOPAsjratxFR/eHaMXzBm1p2UY2lqLYhI
         bdZA==
X-Forwarded-Encrypted: i=1; AJvYcCW2zDJxDepm5boqMp0HabVQgAn79AiLuKoNVRX95GWx1djndqyfPWkan8lX+LAEnuQK7wRTtTxrxpZem5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Wf4K+5H5UgbPunYtMi8iWPF/SNpDKlwah/ZN8j4pk6orePkF
	TpePSN8odNEcfSoyWRgRm4ewQ/IUVKs2Q4KFN9SGdtQBw4UpBQhxjEPS
X-Gm-Gg: ASbGncuGVgv2LjxMtyi8Shp3EEGP0mAa3yD+nqwc5z2MGdLBv8lAyrJ/9OHmMWqVZgu
	+hBJ6U07SzDR/cszPA5lH3lw5KlBg1Bm/uoE2neZXAfeVICTkz0zZuyiGiY2k4G2s47jy08DDC4
	h+ewFVzp28l+HY3joS6Js+jWfT6uAQPpC6Y8QCV/JcoyFUEk2JzHCHygtIVJsoDFHnKl8Cxi7JC
	zNp2R3Ioo+ARk5RC1Kkl0n4otDFBspUWV7FeOpdG1XnxMbBxm8SILO+Zao8pe8RXIqNtmSHJIll
	sAdsfvrRNNfDi57/TE7o4Rj6v1OUYXitvpjrq901ln4FPapQkRG7P5h9aXcYESUeJlvvECoL5HS
	dATpfJA/pEPKkSU1K+k1SmLvRUKs+Uo7TWczhVP2Y54QGuVUGdGyGcWwWQl58hu1enckGL4YuTM
	g9aimON98ru1fs8P23xDE2Fw==
X-Google-Smtp-Source: AGHT+IFfj8dcaPyoJUnBwrQrbEjc0tKnxl0fbsVgVFk4QvGgEAOydtQrbEdriDic6wnAsYVeECy3eg==
X-Received: by 2002:a17:903:1c2:b0:270:ced4:911a with SMTP id d9443c01a7336-2946de4071amr99308125ad.9.1761359236031;
        Fri, 24 Oct 2025 19:27:16 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d23334sm6685145ad.52.2025.10.24.19.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 19:27:15 -0700 (PDT)
Date: Sat, 25 Oct 2025 10:27:13 +0800
From: Longbin Li <looong.bin@gmail.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Yu Yuan <yu.yuan@sjtu.edu.cn>, Ze Huang <huangze@whut.edu.cn>, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: sophgo: add TOP syscon for
 CV18XX/SG200X series SoC
Message-ID: <oymxspgopaqja63nipufgzn6kpobkdopemfaw3azhom3ikvk5f@e7cg4lq64j2o>
References: <20251024030528.25511-1-looong.bin@gmail.com>
 <20251024030528.25511-2-looong.bin@gmail.com>
 <20251024-hangout-designing-33e96c0d35fc@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-hangout-designing-33e96c0d35fc@spud>

On Fri, Oct 24, 2025 at 05:46:03PM +0100, Conor Dooley wrote:

> > ...
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: sophgo,cv1800b-top-syscon
> > +          - const: syscon
> > +          - const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  ranges: true
> 
> Do you actually use ranges?
> 
> > +patternProperties:
> > +  "dma-router@[0-9a-f]+$":
> 
> Do these actually appear at variable addresses, or is it always 48 for
> the phy and 53 for the dma router?
> 
> > +    $ref: /schemas/dma/sophgo,cv1800b-dmamux.yaml#
> > +    unevaluatedProperties: false
> > +
> > +  "phy@[0-9a-f]+$":
> > +    $ref: /schemas/phy/sophgo,cv1800b-usb2-phy.yaml#
> > +    unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/sophgo,cv1800.h>
> > +
> > +    syscon@3000000 {
> > +      compatible = "sophgo,cv1800b-top-syscon", "syscon", "simple-mfd";
> > +      reg = <0x03000000 0x1000>;
> > +      #address-cells = <1>;
> > +      #size-cells = <1>;
> > +
> > +      usbphy: phy@48 {
> 
> Drop the labels off of these two, since they're unused in the example.
> 

Hi,

Thanks for the review.

There are a couple of different opinions here.
Could you please help confirm which approach is preferred here?

This is Rob's reply:
https://lore.kernel.org/all/20251015134144.GA3265377-robh@kernel.org/

