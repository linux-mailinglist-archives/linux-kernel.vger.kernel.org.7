Return-Path: <linux-kernel+bounces-726918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B82B012C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90CC1C80C18
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1986D1C84A0;
	Fri, 11 Jul 2025 05:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="H62B/Bbg"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB96188907;
	Fri, 11 Jul 2025 05:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752212290; cv=none; b=LJfX2bFhp5M0ZbNdCmq6oio6aMUcchhkDXOsaO8HItNpI7+JRdfEnyow/hExynteAUsE8g7lCUKbM/3ES+mIB/8rwGuUWIhsd1DdCqEGY/Tz5HLZFwoUvuMUwfyxOazO8qWSUijy9ugkQ8YByKaQMW8k1xXJ3echptLAst86z8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752212290; c=relaxed/simple;
	bh=dSzZXBtaUtF6MwhCEZHgYoOFBwfwB4QKpkWElkUK1o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VI0/Dt2iK8yuypLnXtzK5VsBSUhERqJlE1Teyc2sWtOAZmTsTFHMWXDVncX+wbFKaV76rtO2xq6TV+xA6JjnU11UezwKi+oy4S4ChBWxSaq/Sr2uajAqCJZpPNrQF5TxXgcpgTkyPDzGFqEnpIe42kNhQ4ANc0hlZnH95Lecgys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=H62B/Bbg; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=OhAsV/CBrgYXlLFY+8qkcKo/GadLSGwmgLi8pRb4QUk=;
	b=H62B/Bbg/cEOgUnp7ap3h3tfUm7W4fQQmbCIIu7+/C38Ajeij8sKBhr6nwaiI3
	03t8NYs71gCAxHhpYnrVzpereZLFz2CdbnKGk5w2MU1NOHSKh6rFJZ/0Id7N7Av8
	e9mxbeNGEaKp/i3Nir3h+qEI66llfAv+KbFqy0+FEBZ7U=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDHX52HonBobvdOAA--.742S3;
	Fri, 11 Jul 2025 13:35:05 +0800 (CST)
Date: Fri, 11 Jul 2025 13:35:03 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Frank Li <frank.li@nxp.com>
Subject: Re: [EXT] Re: [PATCH v17 0/7] firmware: imx: driver for NXP
 secure-enclave
Message-ID: <aHCihwHKVck-emEX@dragon>
References: <20250426-imx-se-if-v17-0-0c85155a50d1@nxp.com>
 <aEqMSG8k+NpQ7ROH@dragon>
 <AM9PR04MB86048A698B03E974CFD3DB489574A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <aEuB1qgd6aVl0i7i@dragon>
 <AM9PR04MB8604F77BCD3427B38CB9E664957DA@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <AM9PR04MB8604BFF7161570CD464723FA9549A@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8604BFF7161570CD464723FA9549A@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-CM-TRANSID:M88vCgDHX52HonBobvdOAA--.742S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4DurW5ZrWDuFWkGrWDCFg_yoW3KFc_CF
	Wqv3ZrC3WUG3y7tFsxJryqyrnxK3yj93Wft3yUtrZIy3s3Ar4kZFWkGryfAw18JayrGF9r
	Cr4DZa4DA34xZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj7DGUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNQkBZmhwookRsgAA3L

On Wed, Jul 09, 2025 at 10:23:45AM +0000, Pankaj Gupta wrote:
> >>> Hi Shawn,
> >>>
> >>> To test it on MX93, you need additional patches on top of these.
> >>>
> >>> The plan was to send the next patch-set to enable the support for 
> >>> MX93, once these got merged.
> >>>
> >>> If you suggest, I can share the patche-set to enable MX93, as an 
> >>> attachment to you only.
> 
> >> Yes, please.  I would like to test the driver before it gets merged,
> thanks!
> 
> > Please find attached the patches for enabling iMX93.
> 
> > I have also sent v18 to dispose off the comments:
> > 1. documentation,
> > 2. updating the commit message with collected reviewed by tags.
> 
> Are you able to test the driver on i.MX93?
> Any help needed?

I did not expect those additional patches (except i.MX93 DTS
changes) for testing the series on i.MX93.  So, no, I didn't test,
sorry!

Shawn


