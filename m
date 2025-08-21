Return-Path: <linux-kernel+bounces-779097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAEBB2EF0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36BC17AF08E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2BF28031D;
	Thu, 21 Aug 2025 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="RGXDACYu"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A2727C162;
	Thu, 21 Aug 2025 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759924; cv=none; b=dcEKrhqx4vnD00NlO2GCRm6EJexKPCtuA+zju8ltBrtPxjlQaMISKcp3GHu0BdekVJMaF2UIOZenPCJII2OmhIUkNcvaSDPq/DKzQmAYw4grINzGVB3egkW+edtN7tAeagNFAEUfRaWXlOFpOPObn7B3ce/TRmnGKYU/FKQPLrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759924; c=relaxed/simple;
	bh=/37P9PX46AuJ9sE98BtSaSr0PiVN6fbgP3lfSULNFXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaQ/OfIv9nM1VfpxrJ2Sscy2FCl7W+WZdkRUxJeDzDlKzeIljXRbJNWUNe70SNLTlFlVROaCrvyPohqPsFIlRg/HjgqcdEe4NpVuBOZB8NYZ5jOaRs3AgOAYvrWHx+eeoJ3yY6LYwuELWeC7uz1lYB0U4u/d9KBmCSX9LnzaD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=RGXDACYu; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Fk0xDD8EPIhERL0BEWTkkqwiBfkZLYWi21PeTKx1dEw=;
	b=RGXDACYuomVrVszZwmqbb8g7OMlsV/8uZbysjYBOV0ebGpaUyWTzEeceztAueh
	uKJTPh5498+RzendPtffTU8RwF9ubELeLTMZbhZRs70XHGZj1NaTBXr8gS91gZbL
	xT8s9/778pSoOVGUkQiLaEZSn4mt09aPej6EvjQ9JGe/U=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnbyf+xKZoHlYZAw--.40022S3;
	Thu, 21 Aug 2025 15:04:32 +0800 (CST)
Date: Thu, 21 Aug 2025 15:04:29 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] arm64: dts: support the i.MX8ULP EVK9 board
Message-ID: <aKbE_dWm9T0sdzTj@dragon>
References: <20250714151346.7575-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714151346.7575-1-laurentiumihalcea111@gmail.com>
X-CM-TRANSID:Ms8vCgDnbyf+xKZoHlYZAw--.40022S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUYJPEUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIAA1mmimxQDR8AAA3l

On Mon, Jul 14, 2025 at 11:13:44AM -0400, Laurentiu Mihalcea wrote:
> Laurentiu Mihalcea (2):
>   dt-bindings: arm: fsl: add i.MX8ULP EVK9 board
>   arm64: dts: imx: add dts for the imx8ulp evk9 board

Applied both, thanks!


