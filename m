Return-Path: <linux-kernel+bounces-781574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4451B3143B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A521D209F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE892EF653;
	Fri, 22 Aug 2025 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="lC6i4wG2"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610C27FB06;
	Fri, 22 Aug 2025 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855673; cv=none; b=Qg2oKexOBwNndnphFKMasulbyVZKZSJ/e9KFo+X/ZLgQk/21DGwTPFx1H2QlfknycLCLTZ5tt9VfQpnN9dG9VqiOCUcfDqTBYg244CzDGEd0O9tDqt3kCPnTwyCfmm/b+84m2HcfIZ8cQ7BOEdB/Fe0Fu+bFamEHnobkmF8ox1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855673; c=relaxed/simple;
	bh=b72J1HX9qiOQGPE5Pq9KrTWYi0t4u2zqvL45KnokvIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aThmgyY2QRXopm9q/4fjR5gsRu+LonlVcMj+4HRXZ4baV8jt2vRIXOeblrd0GhejOTkdyu7X2hgukd/527pHXcuReojQ9egd/YveU1cQBpr9qOxAuwIcxV5xzZUWCTO5UuKDoK8/QhbKodL0TwFYH0IbE8lo6sjeq8dqfHBT+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=lC6i4wG2; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=YdfAXE8MQUA9giWM1FSD6QrutjDX4S2ZHQRU7Dxu480=;
	b=lC6i4wG2QI0Bkc4laFss0qwLCocSgyzJoUWgpAhSe8XPwmcXUKHXDM4TscddvM
	yaMyX90jzjlB2Tqcmsvhxat2DPHp8Vt0wki82z6ajwtyBqaMBwXqhyOwikxMC99o
	3/JA8CHLRPRRWltW7bQixXte3WFWWXYFDYUHOvH6/SFQM=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAn_IcNO6ho_I0cAw--.16415S3;
	Fri, 22 Aug 2025 17:40:31 +0800 (CST)
Date: Fri, 22 Aug 2025 17:40:29 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Stefan Agner <stefan@agner.ch>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 3/4] ARM: dts: vfxxx: rename nand to nand-controller to
 fix DTB_CHECK warnings
Message-ID: <aKg7DYRXwXFJgsLa@dragon>
References: <20250819-vfxxx_warning-v1-0-080930d8e1ea@nxp.com>
 <20250819-vfxxx_warning-v1-3-080930d8e1ea@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-vfxxx_warning-v1-3-080930d8e1ea@nxp.com>
X-CM-TRANSID:Mc8vCgAn_IcNO6ho_I0cAw--.16415S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU29NVDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgqxZWioJsE0rwAAsw

On Tue, Aug 19, 2025 at 03:44:08PM -0400, Frank Li wrote:
> Rename nand@400e0000 to nand-controller@400e0000 to fix below warning:
> nand@400e0000: $nodename:0: 'nand@400e0000' does not match '^nand-controller(@.*)?'
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Fabio also beat you to this one.

Shawn


