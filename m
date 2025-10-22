Return-Path: <linux-kernel+bounces-865945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ACFBFE634
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4823188CED1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C348330649D;
	Wed, 22 Oct 2025 22:14:48 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7802FB0A4;
	Wed, 22 Oct 2025 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171288; cv=none; b=E3bTMOXvhK2kb28mf4wwweYuwpATUcTu6yyhH787IYpsUv9hBYWe0mekOT76tn52rmGKIQEWkZ+6usNkROdVrdxLIlpp+8WVHfp7jAB8RCg5/AXVmKj8ESqtoqZ115ermwNCDKBKpxRQlMVvg+6n3QOs1mSmfx19OCFXM+5lz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171288; c=relaxed/simple;
	bh=B7kfR5y8oEyklMlpQM79q4UWoLKWg4b3vCuQLW+3VGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyPrBaY2pM7JIDRuc06NcVECbXiymmINPWaCscQAcw48LOndxDH3g2UpkQXsZzMtmW+IaOmMLOGJc76PSrU+uZWavUsY/svZD171vIE7ZoTcfLPYMq9JPeNhxDR0Ivfd/MHssVGnAwlm9Ik67rUB6+NVBWyP5VcUb5EmC+gFqto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id D91A6340E24;
	Wed, 22 Oct 2025 22:14:45 +0000 (UTC)
Date: Thu, 23 Oct 2025 06:14:41 +0800
From: Yixun Lan <dlan@gentoo.org>
To: michael.opdenacker@rootcommit.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <emil.renner.berthing@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] riscv: dts: spacemit: add Ethernet and PDMA to
 OrangePi RV2
Message-ID: <20251022221441-GYA1529213@gentoo.org>
References: <20251022201807.1474789-1-michael.opdenacker@rootcommit.com>
 <20251022201807.1474789-2-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022201807.1474789-2-michael.opdenacker@rootcommit.com>

Hi Michael, 

On 20:18 Wed 22 Oct     , michael.opdenacker@rootcommit.com wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> The OrangePi RV2 board ships two RGMII ethernet ports.
> Each has an external Motorcomm YT8531C PHY attached, the PHY uses GPIO
> for reset pin control.
> 
> Enable PDMA for the SpacemiT K1-based SoC in the OrangePi RV2 board.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> CC: Emil Renner Berthing <emil.renner.berthing@gmail.com>
> CC: Yixun Lan <dlan@gentoo.org>
> CC: Vivian Wang <wangruikang@iscas.ac.cn>

Reviewed-by: Yixun Lan <dlan@gentoo.org>

-- 
Yixun Lan (dlan)

