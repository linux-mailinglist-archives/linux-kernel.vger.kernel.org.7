Return-Path: <linux-kernel+bounces-727078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9F6B014BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903B21888EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3FD1EE7A1;
	Fri, 11 Jul 2025 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="fequOfXY"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB71E5B97;
	Fri, 11 Jul 2025 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219101; cv=none; b=nILCqg3RbGhOkL8RjVzB0vZiQusZNEC0AUFulkwvYEg3JHrLWL7Nsw8q8Dz1BeCBSnWWHBwvIMpEp0/Sn5i7cBDAbFaMmyOAgWba7FHWr9rb1kJbNN9/8TDC867l+ZSmPwsrjIGOnd+knKxo30pnn9kri0E+x8L+GzqkTqwgs3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219101; c=relaxed/simple;
	bh=PzAlFYF97tmH4Q1sB1fM6SfqzavHRnm7smVxl6tRI7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2s9pQLog0UwxJD4w7NpdmVWtAg9L7h9DI1+9jmeMzSnuoEyefY1QtWsJgbtNpPaCkNZtv/MJjndQFankF4CZyfeI3NfraJK5LKbdBxBMdYbEY0PPAeUkJk5Otrs4WDbD0yWOkQrzOTxEb57y+Hx7t2gW3BwE3g1Aa4jKFkPOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=fequOfXY; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=JNeAFkTOa1f+sfeTOkNeMLDbT4+cizlqIq1w2Nummzw=;
	b=fequOfXY2pAeMgEV0LiAITGHkYg5DOCykh/xML6CvDMa6d/8Qv1Ec/kwTOS0up
	satE6eN2Q6cSJ2EY6c0PLGWWbjt9h064/2WEGYFXO98aigN0TNt6hxZ5uQh7JQhM
	BXzd3Z0W6E3s+RknH+6Lk3Sqk3FZQScaaefG2HeLI7O7A=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnzyKbvXBoKrdSAA--.57380S3;
	Fri, 11 Jul 2025 15:30:37 +0800 (CST)
Date: Fri, 11 Jul 2025 15:30:35 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Yannic Moog <y.moog@phytec.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, upstream@lists.phytec.de,
	Benjamin Hahn <b.hahn@phytec.de>,
	Teresa Remmet <t.remmet@phytec.de>,
	Yashwanth Varakala <y.varakala@phytec.de>,
	Jan Remmet <j.remmet@phytec.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/2] Add new imx imx95-libra-rdk-fpsc SBC
Message-ID: <aHC9m2iHKhjjXKjI@dragon>
References: <20250611-wip-y-moog-phytec-de-imx95-libra-v3-0-c8d09f1bdbf0@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-wip-y-moog-phytec-de-imx95-libra-v3-0-c8d09f1bdbf0@phytec.de>
X-CM-TRANSID:Ms8vCgDnzyKbvXBoKrdSAA--.57380S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7lksDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIR3MMmhwvZ1PAAAA31

On Wed, Jun 11, 2025 at 03:05:29PM +0200, Yannic Moog wrote:
> Yannic Moog (2):
>       dt-bindings: add imx95-libra-rdk-fpsc
>       arm64: dts: add imx95-libra-rdk-fpsc board

Applied both, thanks!


