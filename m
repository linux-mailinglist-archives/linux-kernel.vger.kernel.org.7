Return-Path: <linux-kernel+bounces-870278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7082C0A5A3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 10:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37373AD14C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8578A23EA95;
	Sun, 26 Oct 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv0m7Rsz"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BD01DD525
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761472059; cv=none; b=W9tHgMW1erAMOlp4kzoSEeQ+t4vUX1sTxDTRzFC6Yk+RTEm5Rj8pZKuf99gdTCXHxhlNHYoLCfAQpL0KMAR7EsVYyieJP3lt4mfKbtLXRA+2xhrHHCFRi0u0PdCtnVOf4z1rDTQ6GavPv3n6qKOsuDjhh0XBqZDyQoKfl0BXnUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761472059; c=relaxed/simple;
	bh=qcYvH9Ptny0DNh/rzoeTiiivcuo/PRAup2s+HOtuycw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piaxSCoGrqKHn+70s91eVGtrqVyJoPQt/gILEBrQrJ7MvxEhP4Yvud7BDPa0Zqch1inZkh4A7ikBMv6h+8gTkzsi/a3fUNCQT3XuLkLcmzlwoR5RwFZDFEbPYdx8ELb2lbewvxAZfxXObdFmobd0CI1pekFeQEkxVRMe8QlXvDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fv0m7Rsz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so4686659a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 02:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761472057; x=1762076857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C91HvAQxwR7B1bhgRZq1EXx7cSrqAYa22OF4JmCWXOg=;
        b=fv0m7RszL/M3uZbs9WgrQon1osn5ugYXFRSH2vxuHsxl5jAxrL/DsmNByNrcjG1tj5
         PytDdt0gtaLAIz5+Frr8qOqvkykMAVSinaSr3UUrvco8u/jZvfRu1MyWaJrMBBQ+xTV9
         FQ/9o6kgiwVWzDXVpu/mO/OmmKRSSBxIc5M2MZmU7DmwSxnRawtYWKYg5negmF8LrF6S
         Y60wRWRx98zLE1tn6HFjbYNjJmBFK+mmYqu70nK3CjyzlNGRbxZOYFqWEJ6AJ80ZICHq
         EVx8WDAK2tR4f6UpMJ5HxTsl11XrvcJGyjr6dkEmwHiCp7BAwXoF66wn2WfW1yPVL81w
         Kigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761472057; x=1762076857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C91HvAQxwR7B1bhgRZq1EXx7cSrqAYa22OF4JmCWXOg=;
        b=XehcyoA1sHXgM6ErxboROK6MHnTtXaxhjlqWZs2Q5elAVH4j43EmOzelXYJhit96hv
         zpRlHaoNa+hm6EtYNQtz0Xx9Yc6zTs23E5B7x3TiJtG8oE1voKiJNdFRzpTk6r4u7U+X
         qdDwM61kB8jpfeP8C4Vmvpsh5c4+x+V2ltkgok4SXM7w9iFiUNisbQ32eBxsUlLJyqob
         f4W+a7HacAA9WHO1t6uMP7oRka5AEf3fwV1im/mFxqCGjF+u+/CKLhinMD1GXXlBCrdP
         9LSy7iAZ3+rmOFYw+1pVKq2m1Z2hRrXEXzeXXhx/Zsd0g7ORImLd7p+ZKtvpDeV9YE1l
         X8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXJH5IXn+2JCA4/lewcAZjk6HtP1nai5g9iAU1fDhHI1RRREci4AhoE+X4ak2ghy4vy2nXPfapa3Z8DxZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLTxnSSMsva3vXSZrLkTEFCPpdEUIjkthtF/fvzLDOg6VSfvi
	A4emIo/kVNbLLstY+JnyfhPxcH0Tpex8fsmxhe/ARZcEMDU774AeUjVQ
X-Gm-Gg: ASbGncuwumMg273e9X9KGyxMWNtS1tGwRnA8maHqhKTsUNB2KlVEi0jmJ9yDizjZ/TM
	J7d/YpYyDRkonc+vLq7mr9gx5ZQiK5vlAvyT1A2COuApekudscrlMefDkckTVHitL4C6+CPWWZU
	Mf5fwEqtSImWUfd+OXEhYWaoMMIinzPWcs9fMALmWCD+HjkZVNVAtKf+gY53d2oqF0XryfdUu+e
	ulO8H4aFB8B2vRxvClqMnq6ro90XyW5iLPfJJVqxS1jMjdvnzooI/IXSbIlBpukiU6nHmf2HInz
	39FeTqTpbsWy//OsblnljcObMWHypGhJBX7ZWNHUnq+alVxyp/+Wo0OkWB5MUMIfj3an4zriD13
	VFKtCvKlQ8pmKc5VqZ8lYnCBtoSEGlJm5rCH3nbs+QpIbR25WCbtYQ9OvtDc0JQ6y1mjFq3+jK1
	YO
X-Google-Smtp-Source: AGHT+IGBtA0xQBuD4uogDvjIhQK7Qhr4z8CGsMy+ULWwP1OFvRuXkY87KrHlWUr9Efn6GjJx6fmMdw==
X-Received: by 2002:a17:90b:3e43:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-33bcec297c9mr40598008a91.0.1761472056734;
        Sun, 26 Oct 2025 02:47:36 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed807dbasm4802556a91.12.2025.10.26.02.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 02:47:36 -0700 (PDT)
Date: Sun, 26 Oct 2025 17:47:32 +0800
From: Longbin Li <looong.bin@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Yu Yuan <yu.yuan@sjtu.edu.cn>, Ze Huang <huangze@whut.edu.cn>, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: sophgo: add TOP syscon for
 CV18XX/SG200X series SoC
Message-ID: <ugmphokne6ssc7ou7apvbldxg7xxk24wp5jrzdasjiplnu6gfy@ebbuxnjqlsw4>
References: <20251024030528.25511-1-looong.bin@gmail.com>
 <20251024030528.25511-2-looong.bin@gmail.com>
 <20251024-hangout-designing-33e96c0d35fc@spud>
 <oymxspgopaqja63nipufgzn6kpobkdopemfaw3azhom3ikvk5f@e7cg4lq64j2o>
 <20251025-shakable-jujitsu-3a5e9c8895a5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025-shakable-jujitsu-3a5e9c8895a5@spud>

On Sat, Oct 25, 2025 at 01:44:00PM +0100, Conor Dooley wrote:
> On Sat, Oct 25, 2025 at 10:27:13AM +0800, Longbin Li wrote:
> > On Fri, Oct 24, 2025 at 05:46:03PM +0100, Conor Dooley wrote:
> > 
> > > > ...
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - items:
> > > > +          - const: sophgo,cv1800b-top-syscon
> > > > +          - const: syscon
> > > > +          - const: simple-mfd
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  "#address-cells":
> > > > +    const: 1
> > > > +
> > > > +  "#size-cells":
> > > > +    const: 1
> > > > +
> > > > +  ranges: true
> > > 
> > > Do you actually use ranges?
> > > 

Actually, I do not use it.
I added it following Rob's suggestion in
https://lore.kernel.org/all/20251015134144.GA3265377-robh@kernel.org/.
Should I drop it or not?

> > > > +patternProperties:
> > > > +  "dma-router@[0-9a-f]+$":
> > > 
> > > Do these actually appear at variable addresses, or is it always 48 for
> > > the phy and 53 for the dma router?
> > > 
> > > > +    $ref: /schemas/dma/sophgo,cv1800b-dmamux.yaml#
> > > > +    unevaluatedProperties: false
> > > > +
> > > > +  "phy@[0-9a-f]+$":
> > > > +    $ref: /schemas/phy/sophgo,cv1800b-usb2-phy.yaml#
> > > > +    unevaluatedProperties: false
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - "#address-cells"
> > > > +  - "#size-cells"
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/clock/sophgo,cv1800.h>
> > > > +
> > > > +    syscon@3000000 {
> > > > +      compatible = "sophgo,cv1800b-top-syscon", "syscon", "simple-mfd";
> > > > +      reg = <0x03000000 0x1000>;
> > > > +      #address-cells = <1>;
> > > > +      #size-cells = <1>;
> > > > +
> > > > +      usbphy: phy@48 {
> > > 
> > > Drop the labels off of these two, since they're unused in the example.
> > > 
> > 
> > Hi,
> > 
> > Thanks for the review.
> > 
> > There are a couple of different opinions here.
> > Could you please help confirm which approach is preferred here?
> > 
> > This is Rob's reply:
> > https://lore.kernel.org/all/20251015134144.GA3265377-robh@kernel.org/
> 
> I don't think that Rob and I disgree about the example, having child
> nodes is good, having the label on them is what I don't want.
> 
> Re: the child node patterns, I was not looking for a return to what Rob
> didn't like, but rather a move to just making them normal properties
> rather than a pattern, if there's only one possible address.

Thanks!
I will drop the lable and move the child nodes to normal properties.

