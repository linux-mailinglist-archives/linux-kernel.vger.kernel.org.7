Return-Path: <linux-kernel+bounces-811216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE69EB52611
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D991886E09
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C803B21930A;
	Thu, 11 Sep 2025 01:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="O76U9ZV2"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB2F1C01;
	Thu, 11 Sep 2025 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555476; cv=none; b=YRRFp3q1yW02mjnT73Jbn1UeHwNwYi7LTDVGJ7Kh53tuC/p849KdapjByjDHO4PmEsyHbHYQLhOzovMySnMXgHg00q1O9fQYwQM3sJmsenWggrCWjWBHHuwn7e4Kzv0dYhAP3KBRjbyArESpsp2U+a6A70OkoPuXZdKdwwQC+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555476; c=relaxed/simple;
	bh=S0GcGkgfIGg68g741TdmbBJHFnk5Vj/Wgu4whH0XC4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qnc0uz0r1VRdZLS5WhNZ8fJs/elOtHW5j+y5H1DUO2zqtm2DGnnRWsnOzTOzDCzjRRppcS3gSwtk0DU9Vllol59BcSFhPiJyiYPzkzNthRDiD2T1eqkHPGVIRs4SV/PQbkdxzhdZ9idJI1GDQBsEo0hgyRFohY8qa4xI3/A8lVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=O76U9ZV2; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ZUI/i+ja9oevYg1fVVK/IyksXCQlyryj3w/XBV25Te8=;
	b=O76U9ZV2uADWd+6J6/mpLppDnBErAY1qsuLBqi/9SqqnLNQsucrZTE+bYVIJmV
	JEGmRiYB2qeBPxw2h88ujedrxhmq02Ap6++IENga7E7tXIO0Vkb1C0qgNi/jxvr7
	Ohc7zYFtqfRIURZNcKRVK2OdT/EHLyPhplRO+A6ExuyGc=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnnyjwKsJoColfBA--.14977S3;
	Thu, 11 Sep 2025 09:50:42 +0800 (CST)
Date: Thu, 11 Sep 2025 09:50:40 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: fsl: Add bindings for SolidRun
 i.MX8MP SoM and boards
Message-ID: <aMIq8FAJ3f6irsX0@dragon>
References: <20250823-imx8mp-sr-som-v3-0-a18a21fbebf0@solid-run.com>
 <20250823-imx8mp-sr-som-v3-1-a18a21fbebf0@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823-imx8mp-sr-som-v3-1-a18a21fbebf0@solid-run.com>
X-CM-TRANSID:Ms8vCgDnnyjwKsJoColfBA--.14977S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUw5l1UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIhKR9mjCKvKOowAA3I

On Sat, Aug 23, 2025 at 05:28:21PM +0300, Josua Mayer wrote:
> Add bindings for SolidRun i.MX8M Plus System on Module based boards:
> 
> - CuBox-M is a complete produc with enclosure including the SoM
> - HummingBoard Mate/Pro/Pulse/Ripple are evaluation boards with common
>   design but different available interfaces.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Applied, thanks!


