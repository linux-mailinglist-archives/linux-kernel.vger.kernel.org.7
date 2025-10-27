Return-Path: <linux-kernel+bounces-870873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5E0C0BE0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B8518A22F7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B6B236A73;
	Mon, 27 Oct 2025 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="EPgcQSvS"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22762D8795
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544519; cv=none; b=DEQRQ2Mooq6TChNZUEKZiyTpB7soovU+4ItPFF1UETRxBZ/TnQDIiqysKMagZs5FKBYg78Tj9UG9I7U0By0s51yxznt/Zsn7CL6h7OVjGk+4akuCHioeV6AU3OCsqabH+NAAXtjnjsDwg/GIecu0JAPP+UuKJ+yc6VJxy3aGQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544519; c=relaxed/simple;
	bh=lwP5FYAMG+CA6PuikcdMmjSwA1h02EAFkhcU1pe2kaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGFaFNefAS3W2MD6bbvYYjXJsXvqT2vLjUUpYXdv6IXuNWQBUgecCy7HFCg0oLTWTGig/D/ZkuFDbKPomqOTvDQGLlS6OR9jFe/rgvT3QnDunMXhewg8WZuE9gxowXSqk0IfUZqL1ON68x6v5+KPIMcAKYDoJOyZmdfWlgNI7I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=EPgcQSvS; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=9JD8XR0rMxrds3N4D+/LhBdcJlCyVkkK883MJ9eIDgs=;
	b=EPgcQSvShWq7imV9BCWPHd9qQa2e8o8GJVLiQs+Jg7ox33hUKaJgfvHtt6/LQW
	V/nFlr+f04/BLnZFz+9NLsKikk89T6+E1f+pL+R0QNMBZi6lSwgPPhVydYyWQR6x
	SLafhlxzl56UEJUnXi56d1yT1sOCU+Vw7pdvEJkesb3B4=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDX_1nCCP9ojEW+AA--.29661S3;
	Mon, 27 Oct 2025 13:53:08 +0800 (CST)
Date: Mon, 27 Oct 2025 13:53:05 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, ebiggers@google.com,
	ardb@kernel.org, dario.binacchi@amarulasolutions.com,
	martin.petersen@oracle.com, alexander.stein@ew.tq-group.com,
	stefan.eichenberger@toradex.com, lukas.bulwahn@redhat.com,
	tytso@mit.edu, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: imx_v6_v7_defconfig: enable ext4 directly
Message-ID: <aP8IwcTzRuj542A5@dragon>
References: <20251013121709.104546-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013121709.104546-1-andreas@kemnade.info>
X-CM-TRANSID:Ms8vCgDX_1nCCP9ojEW+AA--.29661S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU5mhFUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIQRNsmj-CMRJcAAA34

On Mon, Oct 13, 2025 at 02:17:09PM +0200, Andreas Kemnade wrote:
> In former times, ext4 was enabled implicitely by enabling ext3 but with
> the ext3 fs gone, it does not get enabled, which lets devices fail to
> mount root on non-initrd based boots with an ext4 root.
> 
> Fixes: d6ace46c82fd ("ext4: remove obsolete EXT3 config options")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thanks!


