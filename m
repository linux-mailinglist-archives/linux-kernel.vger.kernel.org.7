Return-Path: <linux-kernel+bounces-781027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C430B30C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8F81C28290
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E023728A701;
	Fri, 22 Aug 2025 03:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="YHCbvlp3"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474A1288C8B;
	Fri, 22 Aug 2025 03:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832945; cv=none; b=PncZTxQnm9WFH6wC4Xw8tldTXz6Por+jHf+kFuf+dRD8Y4BCmZxEFfIUyY+93IaeARs4wydVAqHqmqBpHVg010hpwAqChJv5bSW1enEEv6+6ciiExPp093VPDA2jbi9bQ5Yo4Sfe3Fxf9BCg4rHKjJZiyTfQ8O4HYrvyu7HhQPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832945; c=relaxed/simple;
	bh=M1rWT/eRh1zi7imlVoXRwvYSpllxjPWNQiQAtYrbJd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovVIl8UHAGVtq6VV2zUjz6Ein/bsZwABtjMy6qAc0aEo2cNTTYU5FLT9U86wi4ctOuXtJ4pnVPdin3PlktH9RgZKAzrJ6HwOhkzywIgQpIDT5XP6+GxO4hUIwCZG8xPONMA6MOBGWP+Swk4vx4LTHq6zKA3pU4fsFxtAK8oi0wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=YHCbvlp3; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=zBn1vmJsIt6Ek80bx8yrAVNfXar4FH8V3p6SVBqOIRM=;
	b=YHCbvlp3mx4IB+ynXJg68XtUjaIPKEBS5OswEYTJ2pDh/iSbv6t7e7vUGKOlwx
	TXjLCFZ/2a8x47Xqf47jZt935Bpy5X8VazOEXibfKGxZxR8BWKzELJRS/NYZxWCA
	Lc8R4OiwuHN6W9OpoyrZp/rHx2/y2X7x2Z83/kEcn3FV8=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDn7yZZ4qdopcskAw--.47231S3;
	Fri, 22 Aug 2025 11:22:03 +0800 (CST)
Date: Fri, 22 Aug 2025 11:22:01 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: ls1021a-tqmals1021a: Remove superfluous
 address and size cells for qflash
Message-ID: <aKfiWY2gomK2wbxr@dragon>
References: <20250725061633.267174-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725061633.267174-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Ms8vCgDn7yZZ4qdopcskAw--.47231S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU5BMNUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNxvSOGin4luwZgAA3m

On Fri, Jul 25, 2025 at 08:16:31AM +0200, Alexander Stein wrote:
> The jedec SPI-NOR flash node itself has no partitions, but the partitions
> subnode.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied both, thanks!


