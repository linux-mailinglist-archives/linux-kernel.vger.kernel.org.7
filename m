Return-Path: <linux-kernel+bounces-890840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE9C4125C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54923188C519
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D84B336EDA;
	Fri,  7 Nov 2025 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzlRLGiF"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40682207A22
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537760; cv=none; b=rsMTV5dz24k17I47ODA8UT/YGs0K341EtIhUreNYDZNt/fcLRBsv4RAY6aYx7MTBABrNcHH7iuRGUuuuNwIJ5cF95mupOb0Z3UMtiW6ecXp3tTm4XPEFcHItQf/YEfbFscFiZQYzIRqdCHGvdTo3NfNLlwJNAmROnBUuD5TiGZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537760; c=relaxed/simple;
	bh=OCNdxRW1IYaC1j6PkP1OCghDlVuNLB2cyrdqHo1Qdqs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a07XE3NVfogOVjbhBqtu71WROwlrhhmQd6b0pSQP2sNSv6RRx4rnOzUBl16V/yFvLg4ZdYWVzaVw7yUH3l3/vA44nPh8MAi+C0Qdb9uHReOT4CzMYkI5CvHv/pEw4nCiBIehRiIkmZLnwcTk0jBOtltMjbZZ/I8SFikYvC3j+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzlRLGiF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso621368f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762537758; x=1763142558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cmq9pT7Misz9s4VB/B7TdNfaf15j6zAigKUGG6pS/SY=;
        b=JzlRLGiFKf1ol41cI2IrFXYPlBuEi+3y7Uj0j7QO3ail9SSUcMHUDYtWTJRT4Y99JH
         l5FoiZjWFZMlFu+yfACJUgoUAw0ePvsMnWeeAS1ifOCO1N/CRxVUOi+Sl1YTEwwT8iuu
         mhfv1J+L+vNwgHM1Pq8kMYP1gkk22OtsZgPpSmD0gJbl0dYYdPdLSJ0mnxy3uE5u540i
         nBX4Al3GPQyCiR90XKNLDodKH0OyhllxgZPua508W201bYjzLJKluWV0QZ9PFbmY3hDc
         5yhslRN7BfGd6ZJ6CO9xjp1jCJA5qPe4TQJFAVCdnBxwf1uuHn3sQRPfhdz17ZeH71V3
         gD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762537758; x=1763142558;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmq9pT7Misz9s4VB/B7TdNfaf15j6zAigKUGG6pS/SY=;
        b=ayuYLtLyB1JAruHiFbiWhzA+WvgCNze9yu6NkMUV3x+QCxXQzqcZ+1ztUxD4n3ix2H
         8gwmkb4tPGV9JgROmkevUOKXRE/gq+Jw8sAnaaElGxPxGrAWX7swbbqy7ZJ6JeaPVlEZ
         RD9PPF0L0d8TAAqdcnd75cdBcH1ZPiTeXN2GjKATA3SqlaHiIHk48tyZa8Gq4qrVf3/U
         g44yFCS1P9uAf1hA0wStKmsxJvd3YADsWbkwNHK3ko+44P7rMWa9ryK6sRSjgy9wNAlV
         jZajS6TME/wuu97wU6VZLL25HdXQ1SwGH8/0/td9s1fOdbbweZH29Qk38Kwh73dgBxd/
         QRGw==
X-Forwarded-Encrypted: i=1; AJvYcCUS6mj+sBUGlORtZyHv5lQ5TYxLt6ezO4BVwRbbQwk0VeLHTTxnsIaVjlYhQeBYZ89Zt++3sye8Z7fRqHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+sijg8KVXNOhjVnECh6ZY2rOqPtWLJUnZ6fYYfMc4dNV2s+M
	G7VSo+QqmsOGrxR6bsMHCNT3wmG6VY3F04Kmvutwmbx0XJISoaxT2r8o
X-Gm-Gg: ASbGncuSRzzFO01P7X9NbuvE6Hq9d29W0l/788+Cf9n3mAcEb50+DoHZJQHlTOi7kom
	Dr9dOFnO7Xqe5laLoDpBecpiPAkGDe5TCFzYQ0uLA78wMvVfwyJ8hfSGVRMQR/+5P9cJvZQDFC3
	0XKGXJsKWZ3yA6K+GM72maRIY/rruEZCUMq4I1lwfYUjykouayUgl4+enW3qhPHiZG1Bhk0iBbJ
	70yJSMCj9zvgQqVnvqyrc/owkSP5Jpes8sH1p269S7+9Sw6I+XFUV7UbELO9fMxvPwXmkq/p7TR
	9GUqRbLo7A90cO4/h/adN8ozHrrfCQmtBRl0zWUUDLGSupDjiNGQpLH0MTKuBtMmOVjPyWG09nP
	XnNQ49ZKzxKVhH8NsnILE9jpBLXOmAQl/76/mu39jBj/d2F3KwLL7va4TIcdE0nd/VYSrH+620L
	BYkb2ZrQwklP8b5SBXfkbTSL6VKXf0
X-Google-Smtp-Source: AGHT+IGejCZdNQWYzzYKXyulx7D4hGO+/hfj3nCbt4DKHyJm8dB3hqEzCyD5AYyGNe1UabBQmO/UtQ==
X-Received: by 2002:a05:6000:250c:b0:429:8bb2:d0ce with SMTP id ffacd0b85a97d-42b26fb47d7mr2445454f8f.18.1762537757448;
        Fri, 07 Nov 2025 09:49:17 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e07asm6575381f8f.17.2025.11.07.09.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 09:49:17 -0800 (PST)
Message-ID: <690e311d.5d0a0220.2f18f8.2b28@mx.google.com>
X-Google-Original-Message-ID: <aQ4xGRCSkjsVWQRt@Ansuel-XPS.>
Date: Fri, 7 Nov 2025 18:49:13 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/5] dt-bindings: pinctrl: airoha: Document AN7583 Pin
 Controller
References: <20251106235713.1794668-1-ansuelsmth@gmail.com>
 <20251106235713.1794668-5-ansuelsmth@gmail.com>
 <20251107-washstand-motivator-c5e5e5d30dae@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-washstand-motivator-c5e5e5d30dae@spud>

On Fri, Nov 07, 2025 at 05:24:21PM +0000, Conor Dooley wrote:
> On Fri, Nov 07, 2025 at 12:57:07AM +0100, Christian Marangi wrote:
> > Document Airoha AN7583 Pin Controller based on Airoha EN7581 with some
> > minor difference on some function group (PCM and LED gpio).
> > 
> > To not bloat the EN7581 schema with massive if condition, use a
> > dedicated YAML schema for Airoha AN7583.
> 
> You went to more effort than I would have here with that conditional!
>

Well it was suggested by Rob and it's honestly a copy paste of en7581
with the relevant thing changed.

> > +patternProperties:
> > +  '-pins$':
> > +    type: object
> > +
> > +    patternProperties:
> > +      '^mux(-|$)':
> > +        type: object
> 
> What's up with this regex? Why does it allow either - or $?

It's to permit either mux-* or unique node name with mux. Pattern is
also used by mt7622 or other schema. Other use mux- to require a name
after the mux.

Example

./xlnx,zynqmp-pinctrl.yaml:37:      '^mux':
./xlnx,pinctrl-zynq.yaml:45:      '^mux':
./xlnx,versal-pinctrl.yaml:34:      '^mux':
./microchip,pic64gx-pinctrl-gpio2.yaml:27:  '^mux-':
./microchip,mpfs-pinctrl-iomux0.yaml:33:  '^mux-':
./airoha,en7581-pinctrl.yaml:51:      '^mux(-|$)':
./mediatek,mt7622-pinctrl.yaml:72:      '^mux(-|$)':
./nuvoton,wpcm450-pinctrl.yaml:64:  "^mux-":

-- 
	Ansuel

