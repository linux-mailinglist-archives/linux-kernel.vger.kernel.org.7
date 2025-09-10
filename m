Return-Path: <linux-kernel+bounces-809757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F164CB511A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F461C25ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F6D3101DE;
	Wed, 10 Sep 2025 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="UmRwnLK5"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D13064A6;
	Wed, 10 Sep 2025 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493654; cv=none; b=Ho1hQmKoQFko1nHs5/QdAprN9CsEPdbK8fOQRol3wvD1PLCP6di2RS8EIJQx98Rgitfx8LIbZm5kQbi1Kq5golBXtLhVNX1q3uPVUHGalLJeLwGaG4ggH+VckjgI44eUeDqmWe2GHbretqHFhTV156G3z82u0zCc0uBklP+iyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493654; c=relaxed/simple;
	bh=JYPfR44AQrBi8/0rqPIzp9qb0fGIF/X5EZHXYWpfg28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3NHxMsfA8uRJs9XcJCifMY84HSXchphbJwphf+u0sOdzHRxK67QQqYe3OdsM5DMMcgFReP3rDKoxJyMwQjVUnG1cQYpkZsqKzjNaN6dXyMQSWTIWxPTW05qBiqLj0Uazs215DhRnycf6qA59QKwkVuSZ4i1Q5ILeihFI2QMFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=UmRwnLK5; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=gKq2I1Pc15B5DW5nOnzTBvaO804siuKpXj5udWtqDZs=;
	b=UmRwnLK5WDCTcBjj0v5BwPktP4p4PRv9I1U1NWyAJ+Xul4USAxZaxHGKYtJfFo
	n2ms8QMwTTYfXv8jek5QAEXrYS4Jbz2pTgiyUOri0ZmtlXevvVHx99B9bKz4vkD7
	CGilnLyzHbR9FdS/+BcBWSA9bfjpZMg3wQ+6IJEaD1xJs=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDnz7zXNsFoucI8BA--.60195S3;
	Wed, 10 Sep 2025 16:29:13 +0800 (CST)
Date: Wed, 10 Sep 2025 16:29:11 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2] ARM: dts: imx6-aristainetos2: Replace license text
 comment with SPDX identifier
Message-ID: <aME2149l8ncGLCec@dragon>
References: <20250709-abb-dts-lic-v2-1-adc5e4781f65@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709-abb-dts-lic-v2-1-adc5e4781f65@prolan.hu>
X-CM-TRANSID:M88vCgDnz7zXNsFoucI8BA--.60195S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryDAF1rtF47GF45GF1rWFg_yoWxKrb_uF
	WxGw15tr4agFW0krWfCF1avasFgFWDZr12qwnY9FsrJF98trZ8XFn8Wrn0vrn8Xw47Jr17
	CFy5J342kwnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbhZ23UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNxlOs2jBNtlMHQAA3E

On Wed, Jul 09, 2025 at 09:28:47AM +0200, Bence Csókás wrote:
> Replace verbatim license text with a `SPDX-License-Identifier`.
> 
> The comment header mis-attributes this license to be "X11", but the
> license text does not include the last line "Except as contained in this
> notice, the name of the X Consortium shall not be used in advertising or
> otherwise to promote the sale, use or other dealings in this Software
> without prior written authorization from the X Consortium.". Therefore,
> this license is actually equivalent to the SPDX "MIT" license (confirmed
> by text diffing).
> 
> Cc: Heiko Schocher <hs@denx.de>
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>

Applied, thanks!


