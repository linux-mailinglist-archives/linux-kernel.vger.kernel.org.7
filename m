Return-Path: <linux-kernel+bounces-811285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF107B52700
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E976821C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4651222AE45;
	Thu, 11 Sep 2025 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="frCjEGxs"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0650313D891;
	Thu, 11 Sep 2025 03:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757560993; cv=none; b=hqx269CoiKQPazmXNHalL3NE0zwXDTPLZgwPTQdveKEyEWLFze1mQ1hdxNwGcSprTrBE+vBLVnVrRjQcJ3UhY08adteBljIzXrJPHoK6cxlvsH1fuTstqheugECQYCF/vWAPdmIqTfSO4jpaqAXov3nKNxVbrXeIdUDtZZ2PUh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757560993; c=relaxed/simple;
	bh=1G77BigPRMZi5VbYGFj3vPc+tY7bX4tVaDZbtyle2Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqX/xOWuVZ08xDCaZUZRzcpl6680c+Fh5SGr8atiBYi+yOw1yaFvYDmYoLLyImnK+miWgbebtWbHl+iFEwhi1dCAn98S1bwLmiN3WoMnz82YhKAlOWUl+hCZNwJVgKI5/xIci02dhYf+RMyvxHBMegyh+CAoKnYd7IW1PGuh4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=frCjEGxs; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=THlvFbB78RIDz28+vysH0ce88JgTgR3a3bl/ZMN0Ldg=;
	b=frCjEGxsW1ezgKWmLhsN0TmHjLL2JoC5L+raMBoyUyvnOAOSNStaIaJQGHF9u3
	zurLhWJVjJIDL19H+plKT5YNLLNmV3Zu9IwdertN/JX3hHRrbUpnOg4xPwGS9Fg9
	kkbbhEEmSiIpiv3TQ115gyE+1rAtcDiKciz7UAZ8EhWU8=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDn3wx_QMJoV4hgBA--.15626S3;
	Thu, 11 Sep 2025 11:22:41 +0800 (CST)
Date: Thu, 11 Sep 2025 11:22:39 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, Frank.Li@nxp.com, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx95: add standard PCI device compatible
 string to NETC Timer
Message-ID: <aMJAf_L0AbVfat5m@dragon>
References: <20250904020049.1397308-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904020049.1397308-1-wei.fang@nxp.com>
X-CM-TRANSID:Ms8vCgDn3wx_QMJoV4hgBA--.15626S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7jg4UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIQL6YGjCQIJmVwAA3g

On Thu, Sep 04, 2025 at 10:00:49AM +0800, Wei Fang wrote:
> PCI devices should have a compatible string based on the vendor and
> device IDs. So add this compatible string to NETC Timer.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


