Return-Path: <linux-kernel+bounces-738708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22823B0BC27
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA903B8DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0490213E74;
	Mon, 21 Jul 2025 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQgHjUXn"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3382C181;
	Mon, 21 Jul 2025 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753077325; cv=none; b=TIF5fvjKbJQbfzjM16GuEwtwBqlsx2y+oEbe+UoOQnD+VD0uYrT7qTVSXJCTBM8qx2vlwUTSgqOsBffmnqRtVcop8qdJ5BmefhX9SvnZvN6u6C9Orb2w8YcfoEhMe4DmwSjQeE2/ua5wwjaEgu42HfpSmnig9SYWYQCFqM75piM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753077325; c=relaxed/simple;
	bh=16M0+EiCrPrqc5avG/IvQFCCBohIkajg47iyOYzqspg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuM6A1czt5iwB8Fovn00imz3xrLFnXHWGLH85jMhXhp7MMcAxq6nNxzOMrrV1qrc6iyD+QUfKCKHz2uQbhN3rzQQR/DnOBe/FfIGlQxqNW2P1VQq+e0FSMxKtzkhLdmNjPxjrtGK8kRpFcJ7XwhtjHOJZjRbM1L/FLgYXCGDhAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQgHjUXn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748d982e92cso2600072b3a.1;
        Sun, 20 Jul 2025 22:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753077323; x=1753682123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pTbqmd/pDrisqN9r4zUGvC27ftvuz5/Vq0UCrl06Tzw=;
        b=YQgHjUXnP+6nk2xPs9iBvyMXir4y+uOWKz1RetwLZovBwJ4sAZP6y97gX3mOiIuxkJ
         hTJfNwnsfgB5swDN2rFAWjgwTsr5z5P6ViIuGmrXzXi7A0pahr2sHFJCk5Ni7Two+SFx
         Oc5zcCe5DC7uy397RFQmAmTpbHqjhGr7wUoOySkOWPDEeWNWPR+Z8o6wczr4q1Md/mVd
         Lm8ybqCRNvlHEq7ekvtVkj+8PAm7YtziVviaUkSOW1pji9AYKzfbEsAxCxLVOJ4o4h7l
         1sNwWqZ8CZjNbWwoQgFb6pi+FCsc9Fu6gOQW5xT59cEj37vQAehtu3G+osCEH13aCl3d
         3XJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753077323; x=1753682123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTbqmd/pDrisqN9r4zUGvC27ftvuz5/Vq0UCrl06Tzw=;
        b=kZXkDmDMl9L/taxKowudq5GbIIvj3LAdSJ1gewh19OoWzWxC58C8/3hncBa8URWUoC
         rzpwN6HCOoi2CmGzt7P6ZWySAPm981swSlavjnodLecHEanAnbOsIHOgehZHbx56skt2
         aYT010uJ3WODR2cle9u/phsjXXbQtz6P3pRw6WsSwZG+Bf/AFxrwBzWb5Z12AJm+YtBN
         Fr5lmIJ07EPhsL5zh2lANoc9Pf8YSgxEGFiRBpNH87cQGxM+9kFVGgms7Pt0fkOCbgSx
         XX2/oejSMzJN+f5m7Xvlt6cTFlvVZnO+W5VgTCmBtDv8lVODFZOajyJryiJgeda/9AFN
         4qCg==
X-Forwarded-Encrypted: i=1; AJvYcCU1BtczKV/bzMQFGCJ6VZP7wtQpYUTElbzzXnc3Bt6hZh3ILolp+DgD4Y5z30BAE++e9BVvi6l0Eg0r@vger.kernel.org, AJvYcCWqDlQBxPfCW2qdN/vNqTR7LTQechWro/XMK+Ks1ajWe4WluaPjGZwBGrq2GtLP4pyOEXq9sJR7VbuQ+pfE@vger.kernel.org
X-Gm-Message-State: AOJu0YwtLNCqigQk9JMcCkmwwPBJrLwFV7NZWwxMGnuC54sv484r83JQ
	1gF4IlpKjA/8wLNuY0hHJ+eQ1LJj8SWSf+g30gKxoXl2QcuDjk7SlfMt
X-Gm-Gg: ASbGncuVmBiHXeHDYaIvQoapm1utJ5OitQNIgGcL/YyYmFRQyuqwtG0izrmFSdEA9cV
	pBt8btR/ZCFPcqqbphw5KV6k7SAYYlbZofpN4rEfq7U4FcREmVKBT0xoY+v7UJDIl4mAYxDY7jj
	YZJxwEOrdTTrAljiCSBqJQ7OlMMHo6PtTHYAHq+12TnskqHtBdJwG7iXVri5hQSPIZBK/yEfCQj
	tkdG4Fg+u0Cf/3w1P3ZfDKPL+Z5GYkvuAqwdtrfgqR1Hqr/popvPoywZgjhVrnpOLxcWg9kATty
	MflkKQMmtTybOa+Yj66wDEZHMVaYVeMUb0RiONtf9Fvp1juH0+8QZLnZ+NqZeHDK9+7zWezSmA+
	ZlCV1TjeOLujAJKYOWReJCS/a4bwnvKYOkzE0VJqSd98QifEesO5/71SIMgJ4U6x/9UNJ78FGU3
	4=
X-Google-Smtp-Source: AGHT+IFKnAKH9LL3fu6dCh2WrvJAAXiTbjHR2Kk8Tffqoygfy2DvBPBBXVdwIstByROSc1BOjkXlvQ==
X-Received: by 2002:a05:6a00:3c8e:b0:748:2e7b:3308 with SMTP id d2e1a72fcca58-756e8773a2amr27457074b3a.6.1753077323016;
        Sun, 20 Jul 2025 22:55:23 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89cfac8sm4939060b3a.35.2025.07.20.22.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 22:55:22 -0700 (PDT)
Date: Sun, 20 Jul 2025 22:55:19 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v2 5/9] ARM: dts: aspeed: wedge400: Extend data0
 partition to 64MB
Message-ID: <aH3WR4HL/nzXfDCU@localhost.localdomain>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
 <20250706042404.138128-6-rentao.bupt@gmail.com>
 <0b9b6c712bff18a25da218c507d18b9a8f18c7e8.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b9b6c712bff18a25da218c507d18b9a8f18c7e8.camel@codeconstruct.com.au>

Hi Andrew,

On Mon, Jul 21, 2025 at 10:42:03AM +0930, Andrew Jeffery wrote:
> On Sat, 2025-07-05 at 21:23 -0700, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Extend wedge400 BMC flash's data0 partition to 64MB for larger
> > persistent storage.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> > Changes in v2:
> >   - None (the patch is introduced in v2).
> > 
> >  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> > index 3e4d30f0884d..cf6c768cbad5 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> > @@ -92,7 +92,7 @@ tpm@0 {
> >   * Both firmware flashes are 128MB on Wedge400 BMC.
> >   */
> >  &fmc_flash0 {
> > -#include "facebook-bmc-flash-layout-128.dtsi"
> > +#include "facebook-bmc-flash-layout-128-data64.dtsi"
> 
> My preference here is that we maintain two separate DTS for Wedge400:
> 
> - aspeed-bmc-facebook-wedge400.dts
> - aspeed-bmc-facebook-wedge400-data64.dts
> 
> We do so such that we implement aspeed-bmc-facebook-wedge400.dts like:
> 
>    > cat aspeed-bmc-facebook-wedge400.dts
>    #include "aspeed-bmc-facebook-wedge400-data64.dts"
>    
>    &fmc_flash0 {
>    /delete-node/partitions;
>    #include "facebook-bmc-flash-layout-128.dtsi"
>    };
> 
> aspeed-bmc-facebook-wedge400-data64.dts includes facebook-bmc-flash-
> layout-128-data64.dtsi as usual.
> 
> From there we can consider aspeed-bmc-facebook-wedge400.dts to be
> deprecated and can remove it in a future release. At least with this
> arrangement any revert of the (future) patch removing aspeed-bmc-
> facebook-wedge400.dts has no other impact. Further, both layouts will
> be supported in at least one release, making it possible to update the
> kernel without requiring a simultaneous update to the flash layout.
> 
> Andrew

Thank you for the detailed explanation. Let me send out v3 after testing
the changes.


Cheers,

Tao

