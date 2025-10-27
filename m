Return-Path: <linux-kernel+bounces-870876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11203C0BE22
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7503BC24C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E6F2D7DF7;
	Mon, 27 Oct 2025 05:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="KuNZD907"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD702C027A;
	Mon, 27 Oct 2025 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544777; cv=none; b=TGZFiqagbwzo+5aRVGPBDPcdwA58oD4flr/tGGrPv+t2+MCbrH3227aXzZpHOyyXVwGaMSb9N0bIB1KfMNJvBIlySVhnO0aJlNkYNg6i7yoLxGzNw+Va6axi4QI5m26Dko5x3fu2Igkb27JkSD1agHtGsLRyZQJJtmupZrreTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544777; c=relaxed/simple;
	bh=93Zp0d73yElyssTl11o4xqnsQNybTnAya+0hGW33ZC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooC/Nv64nqSyD7mJx9JqYGMvaTyfRgNEu39svvx5kXHdGWahFqz9ihcRZIhC4s1uk1CNuZ9RkVUnTiwdy9LWgWwmq7K0VLosiacrWpFYnE4SDC7FD53xHbX454nzGG4vL6Vxrx7sZyEXp7VxIIVpcPODYuYcPtKaQjlT5me9yS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=KuNZD907; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=06tZjU29VwqByqyIrPkQHEnCjRdvf/czRzQRFH3f6Es=;
	b=KuNZD90719RC4PCN7bHia9QNSl/2bCZTq17vXE0WAnM8BXAykaYGV7Qu4Fl3cg
	SqmO9LabkeKZXrHWfntfe6ejdjxNi91Y3WKOhAKzBGdu964e3XXVPDe3F4wPpxDL
	bc19wccwDo5ARVg55yIj854uaCR+zboGPrpCc/BgaOz98=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3_1YeCv9oMlm+AA--.27868S3;
	Mon, 27 Oct 2025 13:58:56 +0800 (CST)
Date: Mon, 27 Oct 2025 13:58:54 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: imx8-ss-img: Avoid gpio0_mipi_csi GPIOs
 being deferred
Message-ID: <aP8KHmFbGFRmgtQz@dragon>
References: <20251014-imx8-gpio-csi-deferred-probe-v1-1-62dd1b949731@toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014-imx8-gpio-csi-deferred-probe-v1-1-62dd1b949731@toradex.com>
X-CM-TRANSID:Ms8vCgD3_1YeCv9oMlm+AA--.27868S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWDKFy5Wr4rWr4kKFW3KFg_yoWxtrg_AF
	yvgr4kCw4DGrn7Jr4YvF42gFWFkF9xW34UKws3Jr43AFySqw4rAF47tr4rAry3Wrs0qry7
	JFZIyw43Jw1Y9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjOVy7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNQCkCmj-CiBa0AAA3s

On Tue, Oct 14, 2025 at 09:56:43AM -0300, João Paulo Gonçalves wrote:
> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> 
> The gpio0_mipi_csi DT nodes are enabled by default, but they are
> dependent on the irqsteer_csi nodes, which are not enabled. This causes
> the gpio0_mipi_csi GPIOs to be probe deferred. Since these GPIOs can be
> used independently of the CSI controller, enable irqsteer_csi by default
> too to prevent them from being deferred and to ensure they work out of
> the box.
> 
> Fixes: 2217f8243714 ("arm64: dts: imx8: add capture controller for i.MX8's img subsystem")
> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>

Applied, thanks!


