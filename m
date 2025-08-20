Return-Path: <linux-kernel+bounces-776894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 875E1B2D2A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E231C27EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EA8222599;
	Wed, 20 Aug 2025 03:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="IfyRyfoE"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284A01C3BFC;
	Wed, 20 Aug 2025 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755661111; cv=none; b=ZDKGQ8BQo/OikT63VDCvgGjJwwlxBysE0B569+7ool25sd+V2jPvkOKLkTl0WZmOhcxU7TsDS9eM7mtcJWRtX2pEfEO0HxNO9DUUWPBKbL25EaYPLVYp7mlSA0uvpaccyIOs167Vl3KgEJGHxQNJ1QbL/V8SeCuEQ9jLrRKG9vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755661111; c=relaxed/simple;
	bh=pWtZZObaHpvxlXkVwVo29CfQOcsPDP1+v54ZQCaZr98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ymdt65q4+F4kquNEYqNVhubXqQdaU8Z8tFbyTS/7u+2+tDRVlPa98XwnxH2PcgSqlR8vFckRGL99YcIrVELilj+3NEZwiZBINbY5rVPUdYofpfYljLA3EFmU1sgwVCPul4g9KvpoWTxzYLvLvgUONe49vp8vcv0Yg0AZBXHpe48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=IfyRyfoE; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=xvh1pCRqTHR9A4JoztiXroqfhBCPl8NMVk/GDb/Q5xo=;
	b=IfyRyfoEto1U+DaXmFsp0MsFgucj9/2y/e++USXzSJH7jOSp/wrt7ZUpuLyFu0
	41IBX9V4itX9F4R6ROlXZqmIoxoKez7rzHYHVZYo+mP/aiMv06kTKcQ8AJmidh4W
	myToVIImsthOLa9Ba50Tc7gMkqcztvD9cFKa8rlLitaF8=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCnFdsGQ6VooU8KAw--.63245S3;
	Wed, 20 Aug 2025 11:37:44 +0800 (CST)
Date: Wed, 20 Aug 2025 11:37:42 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH] arm64: dts: freescale: imx93-phyboard-nash: Add current
 sense amplifier
Message-ID: <aKVDBnMro4kg59Kq@dragon>
References: <20250714103624.857493-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714103624.857493-1-primoz.fiser@norik.com>
X-CM-TRANSID:Ms8vCgCnFdsGQ6VooU8KAw--.63245S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrXr13uryfCr15uF1xJFWfuFg_yoWxGrX_ua
	97JFsrt3y7Aa4Ikw13AFySq34S9w43JF9FqFWjvrZ2g3sav393tw4qvas5Jw4DWrW3JF13
	uas3Ca1j9asrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbzVbPUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNAhWu2ilQwg7+gAA3W

On Mon, Jul 14, 2025 at 12:36:24PM +0200, Primoz Fiser wrote:
> There is a current sensing circuitry on the phyBOARD-Nash-i.MX93 capable
> of measuring input current consumption of the phyCORE-i.MX93 SoM @ 3.3V.
> Circuity consists of MAX4372 current-sense amplifier (50V/V) with two 70
> mOhm shunts resistors in parallel configuration (effective R = 35 mOhm)
> connected to the SoC internal 12-bit ADC channel #1 (Vref = 1.8V) via
> voltage divider with ratio of 1/2. This results in a current scaling
> factor of 0.502232142 mA/LSB.
> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied, thanks!


