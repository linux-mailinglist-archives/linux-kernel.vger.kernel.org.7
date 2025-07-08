Return-Path: <linux-kernel+bounces-721017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339C2AFC36C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162331741DB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C82522370D;
	Tue,  8 Jul 2025 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="k6YUiYfq"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1952422256F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957671; cv=none; b=d/XKgAssWba7hQ9A3ox4zom5IJHc9TDc4YUVwARelfR4vLnwoA4h4c+XyzONtjQ92EloBvoAvZ95pNIO+EKSMmZaECqbXxezh8KVbTe7cvS3YdQW3Cf6ZY+0nCRTpz3hH7ds3COv+CknfQi8TwPsWLzp+r7GLmSQpFBhi8Taafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957671; c=relaxed/simple;
	bh=FmXpT1oIQU7+FHH0NMYMs/qchqVTDA4tNNONibA/G7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbWnyAqPanzSxvDmEirI5ft3xU1H3AMicjcW+SHxcDUvg8dQoyj3Bl0TfAZqBNtk/fPcHhSNSLeURkSJYL0J3PRjaa/3Lntc8L/bxylC6jUSpZnIpqPh9CZ7UWE4d/C+o4Ymf1cJMOUnudgHaPEGAmvtwj6zOdqiO8Pz7h7mwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=k6YUiYfq; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=aenlRMHsQWf230y3ByJlfMQQ8hx6Yn/ZktY6wc88/wk=;
	b=k6YUiYfqUwGLNoz6thTc/RodI5PlHSS+JlBjI080QfgV3Zmdf1apTg2Y4DecnM
	wrG558i6bjxgyuFVNlgLNvVqDw/FsrCiBZXm9X3aRlvDc6OvabntbToTds0cEr9i
	t+tgks8HPtDZM+E3ZSFQZk6ZnmFMCBFJhLIGRDEBHzgsE=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3vxZuwGxovnOJAA--.44602S3;
	Tue, 08 Jul 2025 14:53:36 +0800 (CST)
Date: Tue, 8 Jul 2025 14:53:34 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Peng Fan <peng.fan@nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: Update i.MX entry
Message-ID: <aGzAbk8dYliAfCrn@dragon>
References: <20250707063753.1684144-1-peng.fan@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707063753.1684144-1-peng.fan@nxp.com>
X-CM-TRANSID:Ms8vCgD3vxZuwGxovnOJAA--.44602S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU8BT5DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAR2EZWhsn652vgAAsA

On Mon, Jul 07, 2025 at 02:37:53PM +0800, Peng Fan wrote:
> Add two patterns:
>  - Documentation/devicetree/bindings/firmware/fsl*
>  - Documentation/devicetree/bindings/firmware/nxp*
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!


