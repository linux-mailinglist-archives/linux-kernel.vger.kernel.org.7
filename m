Return-Path: <linux-kernel+bounces-860515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D6ABF04D5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320D1188F7C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC2E23D7EA;
	Mon, 20 Oct 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="mWcRVKqq"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D7E1E9919;
	Mon, 20 Oct 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953741; cv=none; b=Xvl4NXb1EN/puaiFEAnGg41So/C6y9DcPG65LCpZzgigbcQIvmNgmK9jy13+8aEmpiXfCji9U5PYAVLjHPFZSdj3KqqJSxCAnAx0UcA1vCI3z3Io5R7MRzeyPMx3PyLaP07B3p13zzqaNVWCVkMczeWQKAYtBCEscpMKTE1rKas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953741; c=relaxed/simple;
	bh=ek7hXcjHfSQNfshdtQ9VuzGH6TYTSrmvRDEFyQJSzMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpGWUR/Dn8eEjpH2obsKhFRDxaLtHv6koYyG5W57T2EsOJN+8Upb8XxXsjo4HA6e6Gsw89/HrFCoT5MzR0ZAEKGQFxAx/PdNbSJR+5gy48CtM3D9tjo9lTqMhi9/yTmmxPU/V+EV8zb/9jemejI767sN/tDzNh2kQTz3k4FCQlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=mWcRVKqq; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ek7hXcjHfSQNfshdtQ9VuzGH6TYTSrmvRDEFyQJSzMY=;
	b=mWcRVKqqug1bMs4Cgl7P9GItTyL3VXvC38rpN+vmjwC9emt/RfOm5zkq58oU2V
	8e5iF29jzuwua1M9BAW0/vuWmGimqQYPl00w804ktNcu5Ndiri/pqFJAZZUqH8gy
	AdYRCTt+6ourUYnq4VtJK1M4rM8BmN1X8uD9cmckPzSbY=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDX54tJBfZoTepRAA--.25208S3;
	Mon, 20 Oct 2025 17:47:54 +0800 (CST)
Date: Mon, 20 Oct 2025 17:47:52 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <bence98@sch.bme.hu>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrej Rosano <andrej.rosano@reversec.com>,
	Andrej Rosano <andrej@inversepath.com>
Subject: Re: [PATCH v2 2/8] ARM: dts: imx53-usbarmory: Replace license text
 comment with SPDX identifier
Message-ID: <aPYFSKQ3T3I4VTff@dragon>
References: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
 <20250814-imx-misc-dts-lic-v2-2-faff7db49a5f@prolan.hu>
 <aMKEF4wAeET3Ntus@stjenka.localdomain>
 <78cae034-77a3-43bc-87c1-18344d5ba8c8@sch.bme.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78cae034-77a3-43bc-87c1-18344d5ba8c8@sch.bme.hu>
X-CM-TRANSID:M88vCgDX54tJBfZoTepRAA--.25208S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUx2YLDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIgsrkGj2BUvImwAA3R

On Thu, Sep 25, 2025 at 06:44:37PM +0200, Bence Csókás wrote:
> Would it be possible to partial-apply just this patch? Or should I maybe
> resubmit it alone? The patches in this "series" are not really related after
> all.

Applied, thanks!


