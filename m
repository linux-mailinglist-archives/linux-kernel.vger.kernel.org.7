Return-Path: <linux-kernel+bounces-890750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B73C40D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EC818879AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E38B256C9E;
	Fri,  7 Nov 2025 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBAuiat4"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D35259C94
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532215; cv=none; b=OEnYF9zBADN/pNbj2serZZZ1MdCTEmN3dRSOVsV2OioDj3Cu+tAlgCNyGnwMhm6cJMmflo4Pmjg8r8o9dmKqHoCcCZ6Or5cCDzM1qPTlF1qWzqyI4/jcLEtjQrC08swIP65X7+PUuELktlSb7c6EmwQaK6w52wuAIb5XZ4ZvORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532215; c=relaxed/simple;
	bh=m6h5md15vl7XA18igPsSaXDaZbae5jLpA/oiBVEflwY=;
	h=Message-ID:Date:From:To:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYagJqfPw+q8keTCUMwCzi8Avkiv+9UFDBDzGMvSgCvPsFbAsZtjxIYq8X4/PGc3yUrJkY0bYk3qYxPtGDkylu5U8cGIiPAuoACgRBGwh+6yr3mNX6u1lLtWQ9LW7Z+CdoJprsHZG+aZ3rAqR8mPg4pGj77rXfQp46yZZvnVBBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBAuiat4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429c7869704so744044f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762532212; x=1763137012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq+cWEKtg2ZUTyxd/Vz8Kc9fcT1gEAUEGw1yp5hm07k=;
        b=lBAuiat4NMzoJBjXdGf6qV7UglfWMm+nvXHO3L2Qt2rnXJ+qJG5BJEwl5MFGAaccCn
         trEVCZTD8Vp4BKGuOOereI4JMkCdUQJXcC83WhEN+K6VnsZTeQA7RVicoGjWNk3LrU6Y
         J5CNW3PTG/9RPOQnn9w8KZXDrCza8rlPA+GWrUdmJxrYI69XQuXhJPiaMEy5t2WrGZl7
         JqZda9N09B23SRzFW9SEU7/0C65qQe4NGDf67EMXiac5wcZhzXMel+cXsw7Gy/xDSQ5I
         7UzaHhqZgntXBo80wTCKt7UxHTRFPR18gAvDzPcVS8oKs1uBzTicON7OPR+s8FE4zWzb
         U+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532212; x=1763137012;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rq+cWEKtg2ZUTyxd/Vz8Kc9fcT1gEAUEGw1yp5hm07k=;
        b=Sp3yiGkBj2b+O0yp69bdl2av5rUbZLuE40F/ViwXqH0aTWVxwAHNcksFZ/pytAlv/V
         rMOivz8GWTqVM1KYu8rjwUJruM898XVSRU1xLnZzrF+zqGc85xJxDbSVqbcOl1SoBSwo
         Nq0rOthH2oyOUqf4ect8E1vFzr7SqT8h8jBy4hRgIW+Pf2h0aYzFwWppPRIOJHNL1D5p
         8VF0O6gNGwx7DJ9T5kZD52c8Fr079pJ8FV704AOPztYpoGQ/YILCWqTZOOEdBgTjxA/F
         1+YFrzT1QCl+p4lOiNONi0LA8SMuk2jU52R6tHFnZ914Fd5J1iG2GPl7wM3IROkT0JiL
         wJfA==
X-Forwarded-Encrypted: i=1; AJvYcCVOCJtgVRuYhoZtJa/7nx65MdgAhMDXdRyEl3bzuIUO++JBtKUKcen0gvcMw5c2pMYekVbKcm5j0YRsxEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2cpXWlSxOys/0clPr8ytfMqMkuZV8eDqXfO3q89isu4tr1ADs
	yuG5W6es96WGe6QR0hGXKGfOZDjRzKXMvFj59ZoTk6BOoHEA3FLgnJ6HZhejmA==
X-Gm-Gg: ASbGncvX8T/JU4R5L5qVXHvG/toFV1PZebO2MIipSEns2ZC/vZ2r7Gx2Il/Hb1uoTGu
	ME6B3lFV3GAzxC+YgYRtZD4HxCUf//Dnxo94/NFyUUJYXBWPMeQJd+fy8E91OUD8GBkahoAEAGq
	ekteBOAKtAC9SsUPUv8Hkn/8TB9L6LxHVkhw3EV03Tvw7rjvqQW322Yv+G44aHWy5rCScEwd384
	XL00tN2TK2lz//g7niu5CGfAVk2s9dSYIz5RRCuER/ElElHGkjnZNw5bYlVAIjNUGACOqseZAGx
	qCt4j1SCU8cCv5PxmL5b4I+1f+vzIB0EexiSIBZmqsxm3ZQkTcgwVNYBkjBUy1Z1sEnSwUT/w7h
	G7vVulCNcN04qfrrOpouJLchGYjU05Lcf5mNzeG1VEIB6Y7n1X4NWz60ifPc2ut6+xSdb5bBk8S
	HDL9q/+tALjDvVJtWGOihalDFB43iP
X-Google-Smtp-Source: AGHT+IGBls4w5DXj4dsI+iVzj/lD1T2JS8LC5CnrQ6tP++E+okDJx9McJEWsKb0hTWxZy1/eytT3yA==
X-Received: by 2002:a05:6000:26c9:b0:429:cf03:8b1a with SMTP id ffacd0b85a97d-42ae5ae9995mr3350125f8f.45.1762532212275;
        Fri, 07 Nov 2025 08:16:52 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e131sm6344445f8f.20.2025.11.07.08.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:16:51 -0800 (PST)
Message-ID: <690e1b73.df0a0220.312af7.18e3@mx.google.com>
X-Google-Original-Message-ID: <aQ4bcJDWhgQINJry@Ansuel-XPS.>
Date: Fri, 7 Nov 2025 17:16:48 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 0/4] arm64: Add AN7583 DTSI
References: <20250929114917.5501-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929114917.5501-1-ansuelsmth@gmail.com>

On Mon, Sep 29, 2025 at 01:49:11PM +0200, Christian Marangi wrote:
> Simple series to add initial AN7583 DTSI. More node will be
> included as they will be supported.
> 
> Changes v4:
> - Add review tag
> - Fix alphabetical order in Makefile
> - Move PSCI node after CPU node
> Changes v3:
> - Fix typo EN7583 -> AN7583
> - Add specific compatible for watchdog and crypto engine
> Changes v2:
> - Fix DTB BOT warning (fix crypto compatible and OPP node name)
> 
> Christian Marangi (4):
>   dt-bindings: crypto: Add support for Airoha AN7583 SoC
>   dt-bindings: watchdog: airoha: Add support for Airoha AN7583 SoC
>   dt-bindings: arm64: dts: airoha: Add AN7583 compatible
>   arm64: dts: Add Airoha AN7583 SoC and AN7583 Evaluation Board
> 
>  .../devicetree/bindings/arm/airoha.yaml       |   4 +
>  .../crypto/inside-secure,safexcel-eip93.yaml  |   4 +
>  .../bindings/watchdog/airoha,en7581-wdt.yaml  |   6 +-
>  arch/arm64/boot/dts/airoha/Makefile           |   1 +
>  arch/arm64/boot/dts/airoha/an7583-evb.dts     |  22 ++
>  arch/arm64/boot/dts/airoha/an7583.dtsi        | 283 ++++++++++++++++++
>  6 files changed, 319 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/airoha/an7583-evb.dts
>  create mode 100644 arch/arm64/boot/dts/airoha/an7583.dtsi
> 

Any chance this can be picked? All the patch got a review tag I assume.

-- 
	Ansuel

