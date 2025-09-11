Return-Path: <linux-kernel+bounces-811230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36504B5263D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D3B17E365
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9461B1F37A1;
	Thu, 11 Sep 2025 02:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="fGALOccq"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA06B173
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757556100; cv=none; b=l0NakAP5n8EU8dMqgOFc+KCVCtlUW4Qdynx2pMStS1ZY13Ij1DCNcsMDVDf9TOntJM0GQVsVBgRo0YT4ujWGNR5IrehnGZsbUnDtmpTUGw/jtu1x/fak4lBHlvYYwLacQd/tQ3ADH6Jh4TOAwFQ1zaY6l8uhfboIX+QG3/Ww69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757556100; c=relaxed/simple;
	bh=SjQ0VuRrX/wj/9VRm7fBxQNQb2Vk6Qm0wEkiK82lHHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVKz44bram+R8cUf4SWBaf9MKOEY2ykDEaNn0JRTI7IFlQd2/V2ClfXRh1jg4UFB86E/agAgn9tkZBxq/EECymvn/z+iZE+sBSvHfKZXAOsmph6wC3YRHArKk2cW0otZe3Dgw2eD2Y7CIBfopARtWXQRoxTp63xLulVBbeFRjL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=fGALOccq; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=MJkHWNhg96u/bWwhWBm9dtQDm3fe+lYmlVB+NnrOYTw=;
	b=fGALOccqq3/HB3aYedK7mhGWYXFRFcdVOtp+ZXVnxng+uZtQ9lkUnW2zJL3vr7
	ruXARSF/uRxQSVqXlXYKRRvjrsqimVa+QAWhA3jb0fLInqUyGVj3xMtaunG8FWjE
	ECxl9GnpqSVUMpHOUI0/wPF5HqfRZp9G7TD3BO+aAedQQ=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDHNdtTLcJoC6dfBA--.50379S3;
	Thu, 11 Sep 2025 10:00:52 +0800 (CST)
Date: Thu, 11 Sep 2025 10:00:50 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] firmware: imx: Add stub functions for
 MISC/CPU/LMM APIs
Message-ID: <aMItUoCIhGpF7tIK@dragon>
References: <20250825-imx9-sm-v2-0-0bae0265e66a@nxp.com>
 <PAXPR04MB845910056A522BC1DD5D0F168806A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845910056A522BC1DD5D0F168806A@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-CM-TRANSID:Ms8vCgDHNdtTLcJoC6dfBA--.50379S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7jg4UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNBUrkGjCLVXWFQAA3L

On Tue, Sep 02, 2025 at 01:01:39PM +0000, Peng Fan wrote:
> Hi Shawn,
> 
> > Subject: [PATCH v2 0/3] firmware: imx: Add stub functions for
> > MISC/CPU/LMM APIs
> 
> Is this patchset good for you to pick up?

Ok, picked it up, thanks!


