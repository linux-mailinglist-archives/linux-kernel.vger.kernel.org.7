Return-Path: <linux-kernel+bounces-851647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E66BD6F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E6C42570B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A558A271470;
	Tue, 14 Oct 2025 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLZAJdXs"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B118270EBA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760404533; cv=none; b=sVQpfSIlgGT12pF8LOf2eixY56+MpWU492X7cxfSLNx9+3jZVctcARMFhIJC5ncZ2aQyvwjjo4cg6gm7yM2i/Y0xrV7192J1yRBQsoC7pNTRY617vH5TGnnDr7ogKBmldcPrMFV3DSNI1YGYPpsaPl0L0dHVPbOhDiOyNHIcsOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760404533; c=relaxed/simple;
	bh=ZI69gXQKs5ObuEjO9qvNq0asHfYqF0cmxfkJbB6xgYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdgiQkJxxl5mmClm+QikO+jTJG9jrQycFUwx2LTDiGUsl5Hy9GIwmNM+/IRD0MVo1XU5DcpG74aYUfVrr/GKBZhPTl3OLxW8Sa4LYMsZn14caT25lf+MYmqxEKyAr1gJCL4xsoAwa0izjzlPUdUFDcBw6BBuwc/YCF25L2ndPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLZAJdXs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7841da939deso4136651b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760404530; x=1761009330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=phZtlvW8k97758VvwCeGeCQ88PxB75XoJve4vgpnWeY=;
        b=jLZAJdXs7mZ63tsuXhFfUa5B8Zzz0T2aTSfhEQ1Yor3+EqplJbw2IPn51uXk93wJWN
         0oCXakdWCiel4njmM+hN0Ntm3wALXjJ3ni3WscVmJix23LHXLDt1zPy4is7vldme+RxK
         zg9lr8fsp3n1L8BIRlbvcV8gBr6+9jeUYUGq2vsepiend2+gL6hro585D0B4Q5i2RkX3
         zyi39GU5Ook5yc9xn9SUyzXseKSbHih3fFKNP15ddsFSCcfp5ac8822tHgCCw5sFuFRm
         YyOTNLPqOO54hcpcYGcdpBKpAkC5btTYMi1V6OTaFdQTOfECSk/eHDmZCuwYnbaoH+qQ
         KdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760404530; x=1761009330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phZtlvW8k97758VvwCeGeCQ88PxB75XoJve4vgpnWeY=;
        b=AP9N/O+k5eL3DwlRr23Z2aQpVOHITZwL/LbNhGB/WBh2ahI9IVZACE8j4KGj6nlsOM
         oVSB9PrETcLhKAe8ukz9BsdlM7IL/ZjLknxBIyUr0gLKqwqj5C6dzsEg24eNu2GTlyvD
         d4V4Nf5MLyKxdyJ5m3YskZry7Api9NLMEMLwbPj0E9+uM+cRnIS8DL3qzkQflmJTgPPx
         uU1oBtsqw0Tf6Q9gy1NAUFbClTz9z3/h2/gbBKLJNIV11Cv5H0w5FWOVIine0DMYh1tZ
         53MEXgHrASzfcymPMS2Fh6/yFA/SG35QAXfAurXeE4d8oyLSkmefTrQfJyUr49fQbHql
         eMiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Oz8MbOsN8c4noE5ldEf8eiUsOXpqLv62aVyNAjabRZxFPvTkgjHXW/c0gAxTE64FnwChw8xlEiEUgU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzg9RSXpOfCx2ttQy7t5mhnHlq0skhvUQD+jKqnYPbEzvl6htq
	F+BeF1ELnpbkG0vYBtWcsLNgeCkK43IJB7qINCnbLKboTwElgIJbje7G7NMJMUtr
X-Gm-Gg: ASbGncu5wYYf+fuI6qiPHisrAK0Plwyc5hv8puV38lNGT2QZM7/5VghgrZ2GbBz+YJJ
	VmbNfqqbVogLzKRgfEtzZTgVepGASdUlMn/WGU/iLqIEFD3oOupi5mPPcaOiAlO1XJQlEyyibL8
	cWEkp3CgqZq/4fIyHbwT5cCvySZ3EUEWou0T0ZvC0A4ObmWEYN3p9ScU0b9SZ3sUx8vFmNLpFkn
	o1mUh6firz1Z8P4wEwu1/f7hy0l3z5cfrUl8gKoiEowepL7phc7olggzk5BkSaXyZT9QyuIDuOR
	QQkvSo8RZj7yYY3OSMjEpY02QRaS2wqfJuPYXhPjVYCV9535hnqoXOjUU/LmcP7+4gqB9lkehXZ
	ZwibUW96NReFRu+Ti4qtiInxsCATq8r2kBp8ugNiBuzToFuPJwJT1Av/9y7tBUpEmcGm+fOhSj2
	04B9mjYzF3
X-Google-Smtp-Source: AGHT+IGc6pF41NoPdDYQMQp8aeLQWIfke286IFthWwuWj9dAjt12ahG3XuGO1XLg+wdmBQpu8UKgqQ==
X-Received: by 2002:a05:6a20:2450:b0:2ba:103:aa3b with SMTP id adf61e73a8af0-32da84ea472mr29893401637.53.1760404530225;
        Mon, 13 Oct 2025 18:15:30 -0700 (PDT)
Received: from fedora (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e275csm13012575b3a.61.2025.10.13.18.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 18:15:29 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:15:27 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
Message-ID: <aO2kLyxGlGt12sKD@fedora>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>

Hi Guenter,

On Mon, Oct 13, 2025 at 05:20:57PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Sun, Jul 27, 2025 at 10:56:13PM -0700, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
> > duplicated code.
> > 
> > Fuji-data64 and Fuji are identical except the BMC flash layout.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> 
> With this patch in the mainline kernel, the Ethernet interface I use for
> testing does not come online when loading fuji-bmc in qemu.
> 
> Reverting this patch fixes the problem.
> 
> Looking into this patch,
> 
> > -
> > -#include <dt-bindings/leds/common.h>
> > -#include "ast2600-facebook-netbmc-common.dtsi"
> > +#include "aspeed-bmc-facebook-fuji-data64.dts"
> >  
> ...
> > -&mac3 {
> > -	status = "okay";
> > -	phy-mode = "rgmii";
> > -	phy-handle = <&ethphy3>;
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&pinctrl_rgmii4_default>;
> > -};
> 
> I don't see this in aspeed-bmc-facebook-fuji-data64.dts, meaning that
> interface is now disabled. Adding it back in fixes the problem.
> Also, MAC3 is explicitly enabled for fuji-bmc in qemu.
> 
> Was the interface disabled on purpose ?
> 
> Thanks,
> Guenter

The mac3 interface was removed in the latest patch (v4) per Andrew Lunn's
feedback, because the rgmii setting is incorrect.

I was planning to add mac3 back as soon as rgmii support is properly
handled in aspeed mac driver, but kindly let me know if you have other
suggestions.


Thanks,

Tao

