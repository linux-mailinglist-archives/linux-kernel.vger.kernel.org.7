Return-Path: <linux-kernel+bounces-874946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA6EC17AED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD36C4F713E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692C92D73B2;
	Wed, 29 Oct 2025 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew9HlEcK"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417842D6E55
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699379; cv=none; b=VU/Kz9hSZtuVRjlxaN+P4+Uhx1zho4duT2alj1PeBAf8m9kOC+hSjy6ppXq/30bD5dcAcTyiZMztrFRo/Ei/wovkNtoZszA8hm+pNVQYDy04V3bHd6aOPbKln3QGPm4ghJBG8RtEDOwJaX5tqQOLCxlnP+fngCn9QRwsCJWJpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699379; c=relaxed/simple;
	bh=QLSCmp+DageXB/lbgTmmOjvd9XJyigv0R3q9m8lS9aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fK2CQ2sxFq0FzTHOtF/iRwDumhePUGt6Rs6F0LFvRHOF097rMKUjsHB/HJwa/ImUCBd8S+Bmrm+ZWrC5pTU1AjWlkaEWXCtgpdrmTsFVjOklSxXQtLBo10NYrwFW4WYY1tSsAgcNV/2FBKZ0mDjLTYz005XCuf2firPau/Wy6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew9HlEcK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78118e163e5so389577b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761699377; x=1762304177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pezF2VK8RuTzI7DSs1mIZQ9VJH2IBGxZMtiOZQj+jXY=;
        b=ew9HlEcKt4uoaYutWi49vf4yST4qKRv/x7Coo9jumKpIe1hI4lF6tnihNI0DL9Y8FH
         JANRfHVxTe2FdpYugEnrz7VK/nZ4yU75YiOfWcN/zB1HJm2YCOWakA24DPKq3RDhLncz
         WJNW8bjyvlVLwRPrYbR68RH6d28RGKi7TEQrPurolZtI75QMORxFJSBr0SGXxCQzitGq
         vKuBy0nyKKs7Uu3uQAqTHsBcmAj/pDdRE9H5SSScB31ZZ1tWY59IDormNG/YhhvX/xRd
         guM+EBudY9tiekigiROq+/xQSvULwMvTzzSY1r5LrFBBFqXcGf7tngiuQud5r2BilhrB
         Cn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761699377; x=1762304177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pezF2VK8RuTzI7DSs1mIZQ9VJH2IBGxZMtiOZQj+jXY=;
        b=YzfImKHi9UiVD3s0RCdtdMghB99cdKIngJw27l4+Z9BLs5RxUb+XaQPenRycC08ufZ
         ZJC/dE5kz8CuMLrGygG2F0Va3mPeWRNRoKnuCKdeh+UvFSJBzHgpQYctHBdGD9b1YKB1
         QYBA60b4sRRB4dZjE+bY/6ivdNV/qq2W2hAgCifWAA6d8ncH85minSOWzuazaFfITE1w
         xJnmOHSl1bbP2/lGcXZx89qUw6p8mwruJ1urVYN8Bicb1Dshva2lTyMJnxTGhuK4+cX5
         I4fZp8riDxmKAmsgiKO89b5Lr2qYeqBALcJKIWBdT7TWa94uxy8lTQtlC2rvqIbzV/oN
         W/vA==
X-Forwarded-Encrypted: i=1; AJvYcCUiiYqyZwvWawJScs4OjPSW23ff3PerHSfFMhUXfXhG/nUlUwlMfQJc522TKdY2J7vXVg5y2sO4ATODuUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1YVD6Go4qohnEWsoFr+PbAAafo1v4y9h9fVMl6M2RDCf6UTZM
	8xHASrhuyDxBkcC1Tou6Q7GjsJ8quhsQWvezfePbHyoLMUwRGS1V588P
X-Gm-Gg: ASbGncv9T1VaKh4EWQXUIicfZS4Ej3xKSWUhiTZk8NOAlYpdgGjsuxbMykr5uSuRsG+
	mdPaLUqoSGmliBvjNgvE4O+KUW+yx9Cl/iz0aeIuF1HnAKSHcBuZ9CXfJfoIEsX2OCgZA32Ya+4
	W6mw37fWeZWtBk7Bmx4EBST+K4NRG/kC3V2DF/gufvUjNXxUfp1/0vZtVDLXHyUcKKFiQIZOc2a
	KghAkfPQpEiMNwxefFsnMJrnhzOvabnLDSTvlh3bds8fYSgr00ppi1/JdVxgdOTbRC+p0vf9v9L
	xLdLqrO3aFKe77fKnYmeK3624m0Dj1r4MbTCj5qGZdeZ0w5IGqrT8ob33f6UFz/i4Rr1xvL/JCE
	jxdrQDUZ79fuSaXzVuRPw52cQrCLlFVtxGF9rDbhoLEtm8ALL0J8R1ivtnW6PiwzRQn9IyMKZSS
	8=
X-Google-Smtp-Source: AGHT+IHOlz4wCJmTj/zx16kQtcK3MAOTVFHMVAoc2+es1wdMlMVDqBf6QFztVnrfW0sWZY15JATnUg==
X-Received: by 2002:a17:903:41c2:b0:26c:4085:e3ef with SMTP id d9443c01a7336-294de9f7ae3mr12621045ad.21.1761699377445;
        Tue, 28 Oct 2025 17:56:17 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d230c5sm130960935ad.47.2025.10.28.17.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 17:56:17 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:56:09 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy
 mode restriction
Message-ID: <rclupbdjyk67fee2lgf74k6tkf7mnjcxzwcjvyk2bohgpetqt5@toxvy3m5orm2>
References: <20251028003858.267040-1-inochiama@gmail.com>
 <20251028003858.267040-2-inochiama@gmail.com>
 <20251028-parka-proud-265e5b342b8e@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-parka-proud-265e5b342b8e@spud>

On Tue, Oct 28, 2025 at 07:22:37PM +0000, Conor Dooley wrote:
> On Tue, Oct 28, 2025 at 08:38:56AM +0800, Inochi Amaoto wrote:
> > As the ethernet controller of SG2044 and SG2042 only supports
> > RGMII phy. Add phy-mode property to restrict the value.
> > 
> > Also, since SG2042 has internal rx delay in its mac, make
> > only "rgmii-txid" and "rgmii-id" valid for phy-mode.
> 
> Should this have a fixes tag?
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 

Although I add a fixes tag to the driver, I am not sure whether the
binding requires it. But if it is required, I think it should be

Fixes: e281c48a7336 ("dt-bindings: net: sophgo,sg2044-dwmac: Add support for Sophgo SG2042 dwmac")

> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > index ce21979a2d9a..916ef8f4838a 100644
> > --- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > @@ -70,6 +70,26 @@ required:
> >  
> >  allOf:
> >    - $ref: snps,dwmac.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: sophgo,sg2042-dwmac
> > +    then:
> > +      properties:
> > +        phy-mode:
> > +          enum:
> > +            - rgmii-txid
> > +            - rgmii-id
> > +    else:
> > +      properties:
> > +        phy-mode:
> > +          enum:
> > +            - rgmii
> > +            - rgmii-rxid
> > +            - rgmii-txid
> > +            - rgmii-id
> > +
> >  
> >  unevaluatedProperties: false
> >  
> > -- 
> > 2.51.1
> > 



