Return-Path: <linux-kernel+bounces-870737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C7C0B904
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 643984E75C8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092C91D5151;
	Mon, 27 Oct 2025 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="gwMHe0bZ"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4019D082;
	Mon, 27 Oct 2025 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761526997; cv=none; b=FNijnLPQN7I13+C+65xyMu8v3TGva/0OTU/CMG6JyeJHdOVtSnx9Ref7WecGm5EgXNNJBXdjAw7f2u/Kxvhr2rPX7tIb74zLsgezQIasmIq/P+qhLz7vBZHbZGOQeEHxHJA83vIozQvAAFfJvLoGgns9998mED93dNYAl1pOL3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761526997; c=relaxed/simple;
	bh=POj0vqoX2/Vx6PWI1P73vZHySA+zPCuiVOeqP/5zsAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0vBHyPE50S5yOFxH8PhSuwoh3UhctCk6YTzxAHCy8QMsEG/LV11GdHWYvDeXpm2B1I4NQ3dLSLO+5GErqTsC0IIq0Vp/kFAaHhCXu0rIzidSlisGSxPIFzo/LIMjGjTvMBEqT+O5BcdIpVUXO7dwvUOUsdvpio2LH8UtlXuFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=gwMHe0bZ; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=IaTmX9G3UENJWUpcQIJrd3kiZNYfexjLahMXatIssO0=;
	b=gwMHe0bZ8zz3GwLalwVcb668364HoXdnTJ6ECy1b5A5z3oBW2wB8iRJRI6y/xD
	bM1Po+J2vz2Vk92uacw30kOKEhiB7yLZkLxRZAMdGAB5AS5xF4Ow3QAYPkpkMd8g
	bn6xO1OKfXj8PEW9ZhduKk3Tw+eqFlvMcF+lGFa6yKaGU=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPSA id Mc8vCgD3H7x8xP5oF+E6AA--.41307S3;
	Mon, 27 Oct 2025 09:01:50 +0800 (CST)
Date: Mon, 27 Oct 2025 09:01:48 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Goncalves <joao.goncalves@toradex.com>,
	Joao Goncalves <jpaulo.silvagoncalves@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Michael Walle <mwalle@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: imx: document i.MX 95 Verdin
 Evaluation Kit (EVK)
Message-ID: <aP7EfJddKvEepv3T@dragon>
References: <20250925205211.171699-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925205211.171699-1-marek.vasut@mailbox.org>
X-CM-TRANSID:Mc8vCgD3H7x8xP5oF+E6AA--.41307S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Zr4xXr4kCryfJry7ZFb_yoWxAFgE9F
	n7Kws29FWfGF47Xw1DtFsaq395Kw4F9rn8J3y7W3sxC3s0yF1fJF97AwsYya13WFnavF1a
	k3ZxJr42v3yUZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1qQ6JUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIgArkGj+xIAhKgAA3A

On Thu, Sep 25, 2025 at 10:51:54PM +0200, Marek Vasut wrote:
> Document support for i.MX 95 Verdin Evaluation Kit (EVK), which
> used to be the Titan EVK.
> 
> Note that the SoM used in this EVK is a derivative SoM from Verdin
> line of SoMs, an actual i.MX95 Verdin SoM is under development.
> 
> [1] https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95-evaluation-kit
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>

Applied both, thanks!


