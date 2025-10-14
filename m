Return-Path: <linux-kernel+bounces-851775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200D2BD7383
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C568D3AE45B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E0730748B;
	Tue, 14 Oct 2025 04:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYAx5FHF"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51518FDAF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760414972; cv=none; b=PtrJMdj7imQ0RqoBcL+B1IyV/kiHCWlZrceoiSwkGXwuuVPDIHDLEBd16ESiFqEcTYOYFDLhmJx4EQJ6jGMKaMrp8S0rL0uPt/Hv/vb3Sz+dLLo7E8nQeQbTKUBwNjnbCKX7XpwmgihN250B9Tyad5xq1ewb7PcIkHoNOlKBtfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760414972; c=relaxed/simple;
	bh=3SJ+BAJ90/2fM1tvgHY4MUBt6A3UEulndiODvhiJaRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+y9avRjSMeYlPDETsSZeqpUzqMWHyViIW15e9dyW6Yvxk1+3oDD3ATVSBgdhgkthTL91rqqYgFJCPsIXOHsOmn9KPpgZBh0mgTg4fXXE+0NsNx6GVDgQht+kFUPOIzVYzroqt/Jf55ZO7DVN0pjQvPK3IjqBNsiE92H18EljBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYAx5FHF; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b57bf560703so3125781a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760414970; x=1761019770; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0FUz4z1xFNwCgvQPUMrt9kZD59yR5IRPj9qAd263rQ=;
        b=bYAx5FHFLFmqOsHWaIS9zaZPMkzrGtd2FznZk/GkZhPYiEKwaCUuPF7YHz2Z8TCeX5
         h97hNEL9GKIQbyT4cYkuoUmBGpXdE+ZYl4d4Q0k1y+nU5ATJE1OocffPSsBIgIYLEZ/U
         EGmXYyakH7He74CDIhO+BV+2rT0pLAdmIFfy9C/Ntoi5fUC4mQgO6nA6booiWT+aUh46
         8Fu9oITM4vJgoyHd7FkuHYRRs9mcaZV/X8o/WFsCRNEbaq5J69j14X7cygMCkg1c74UL
         aluRakUUIXo9pEvVl7KGBHquCvkWDSyaKUJImyxWQwjM8PCLhCKJeu1X/QRZVU/fU5QA
         aJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760414970; x=1761019770;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0FUz4z1xFNwCgvQPUMrt9kZD59yR5IRPj9qAd263rQ=;
        b=roCLwf8npnSaCESV6ZGCoV6OY2alINm7PwOsHfbsKDpq/cHqPBdGt082XqT4cjdLoT
         WkNqciVPwC3Wj74h3ZHrlEm0moMPz1c4NsOmXtJCyY+h2r9ubAE5+9n86DZBkfztmFcQ
         quJRLOTrmkXRTvHOMXIi91KTggRvmcZ3FE/aQOGvKC8ycFjeu4S46DUtYsyZzcRzD19K
         aZ6jPmCKJMBz54ePp+lEQvM4eNcPO1ksVpdUyrgmPoyvd8NumUBxkbX3xVvzZFW9lW3J
         VCJ9uPPLUU9WSj4nTHpZIC6jbbTnKym3c3yS3WjQLhZeT28tLB8k2IfZGUdH6VauV4bq
         pXdg==
X-Forwarded-Encrypted: i=1; AJvYcCVhAgn6Pw8zron/BwcFNj/SWBbFdabvipu7wu4rf0XTiNN6y2lkayHQU965B4/huMPLU1aY39N39fyaqgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqJZ0hegXqWUZ0O8aSdK5jG3cgC0wS5qfMHRjqjexnq/FWhQN
	l46Pdl+GYaR1ulTeKkEfE0LMus221xhAgVEmBKz9MuQ4CRkOTV1pXMlF
X-Gm-Gg: ASbGnctnUS+FA4hsBeLZ1H7SvjeoCQkNXUCp+v2HU3Lq5wOfVWW04udlBnZ3Azq9LOY
	dCuWEeTEmcbbTZyvoxT32p5MKHaZpdnqvfcq2Znb2OaoAkaoxjuNsOgbHFK6cO2f2wADLvFjGib
	zgz2wG2plioOcwG+564ZRTS5PEdCTeKBehah77rEJXIXcB5ZeZWasfEC2tkkzDjZy+xG5OQl4vY
	ZOKTltwhm02WYEVASQiuPf4DJ0SSyGVRjDyiIsouagvUW2Ydac0EXwgaXn8Onmb/dguqRhDruM1
	CwVy6bq4HvpeNooo5I2vY3OLVwZi+qD/W2o28Yls9ftO3BFOhnH2tmT5p82tf/0Jn7sbUutdFTp
	Z0MCfyJSvGdgsDoLDg41XXPSaB99k+RCeYkVv7qJxxsZIRgexX5PuioDhQsU996OLs1a0ylgWm7
	5MHtZtNdpUlMj65XvM2uI=
X-Google-Smtp-Source: AGHT+IEr20kAH+dfqBTsSZfMO0yg/OwD4bgTloNhcSIQWl/DGKL1nIf9DZfEY5q5FY5iCmPtfo18vw==
X-Received: by 2002:a17:902:e806:b0:261:6d61:f28d with SMTP id d9443c01a7336-290273ffe94mr274157815ad.50.1760414970372;
        Mon, 13 Oct 2025 21:09:30 -0700 (PDT)
Received: from fedora (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de5dbfsm149146305ad.20.2025.10.13.21.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 21:09:29 -0700 (PDT)
Date: Mon, 13 Oct 2025 21:09:27 -0700
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
Message-ID: <aO3M90Ycp2DWyFuk@fedora>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
 <aO2kLyxGlGt12sKD@fedora>
 <e3dc7aee-c8af-4276-84e5-0f0c7926be05@roeck-us.net>
 <054cf209-61af-4d21-9a3b-d0f6dd24ee3b@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <054cf209-61af-4d21-9a3b-d0f6dd24ee3b@roeck-us.net>

Hi Guenter,

On Mon, Oct 13, 2025 at 08:44:17PM -0700, Guenter Roeck wrote:
> On 10/13/25 20:20, Guenter Roeck wrote:
> > On 10/13/25 18:15, Tao Ren wrote:
> > > Hi Guenter,
> > > 
> > > On Mon, Oct 13, 2025 at 05:20:57PM -0700, Guenter Roeck wrote:
> > > > Hi,
> > > > 
> > > > On Sun, Jul 27, 2025 at 10:56:13PM -0700, rentao.bupt@gmail.com wrote:
> > > > > From: Tao Ren <rentao.bupt@gmail.com>
> > > > > 
> > > > > Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
> > > > > duplicated code.
> > > > > 
> > > > > Fuji-data64 and Fuji are identical except the BMC flash layout.
> > > > > 
> > > > > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > > > 
> > > > With this patch in the mainline kernel, the Ethernet interface I use for
> > > > testing does not come online when loading fuji-bmc in qemu.
> > > > 
> > > > Reverting this patch fixes the problem.
> > > > 
> > > > Looking into this patch,
> > > > 
> > > > > -
> > > > > -#include <dt-bindings/leds/common.h>
> > > > > -#include "ast2600-facebook-netbmc-common.dtsi"
> > > > > +#include "aspeed-bmc-facebook-fuji-data64.dts"
> > > > ...
> > > > > -&mac3 {
> > > > > -    status = "okay";
> > > > > -    phy-mode = "rgmii";
> > > > > -    phy-handle = <&ethphy3>;
> > > > > -    pinctrl-names = "default";
> > > > > -    pinctrl-0 = <&pinctrl_rgmii4_default>;
> > > > > -};
> > > > 
> > > > I don't see this in aspeed-bmc-facebook-fuji-data64.dts, meaning that
> > > > interface is now disabled. Adding it back in fixes the problem.
> > > > Also, MAC3 is explicitly enabled for fuji-bmc in qemu.
> > > > 
> > > > Was the interface disabled on purpose ?
> > > > 
> > > > Thanks,
> > > > Guenter
> > > 
> > > The mac3 interface was removed in the latest patch (v4) per Andrew Lunn's
> > > feedback, because the rgmii setting is incorrect.
> > > 
> > > I was planning to add mac3 back as soon as rgmii support is properly
> > > handled in aspeed mac driver, but kindly let me know if you have other
> > > suggestions.
> > > 
> > 
> > All I can say is that it worked just fine with the qemu emulation,
> > and that it is broken now. Since it was broken on purpose I guess I'll
> > have to find a workaround or stop testing network interfaces with
> > that emulation entirely.
> > 
> 
> Ah, I see that mac3 was the only enabled Ethernet interface on that system,
> so you effectively disabled networking on it.
> 
> I don't claim to understand the logic (how can anyone continue to use this bmc
> without network interface ?) but I guess it is what it is. I'll stop testing it.
> 
> Guenter

Sorry for the inconvenience.. I have to take a local patch to enable
mac3 in my environment, because as you said, it's not useful without
network interface.

Meanwhile, I will need to work with ASPEED to enable rgmii delay support
in the ASPEED MAC driver so I can add mac3 back to the dts. If you are
looking for a similar platform for testing, you could consider elbert.


Thanks,

Tao

