Return-Path: <linux-kernel+bounces-897090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839BFC51F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA243A8DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB5030DD04;
	Wed, 12 Nov 2025 11:19:59 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5330CD9B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946399; cv=none; b=PEBpWE6Ycs0lAjO8rdL0UAYIgLTR/8uUshuW8FeK2UuJwBe48l605qa2i5lQDvsyrGStl0NeLnUarLwORXfnEvkAm7+p+g97No3+ivpi8HZ7JN1ovFa+hphD7bHtuJuCWxbXoohKEF2md3yZTvBSQo2fXKzTyt2/POcAQK4JK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946399; c=relaxed/simple;
	bh=xCojaxOBonSzxDIu1K1MQg6gKQiBrnfbHNiqxw6nFg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2KvIsJGS9gfSR1A6JkHRgD6PSajuj7yZPdDfgX5q2+9QvL8znhpsRwCFy5H9Q0mre+ESOvxy4R7nKn05wV2lzLzB3yMAiiDv2LyLMorUFRdIRGbZ0+vHscdWCSQsXwh1DXa8B3ZpB/HyL6FAVBLY033zprh8uYmWOoJGnjqykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 1D9C6341E78;
	Wed, 12 Nov 2025 11:19:56 +0000 (UTC)
Date: Wed, 12 Nov 2025 19:19:52 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>, Conor Dooley <conor@kernel.org>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, conor.dooley@microchip.com, Frank.li@nxp.com,
	guodong@riscstar.com, fustini@kernel.org, geert+renesas@glider.be,
	cyy@cyyself.name, heylenay@4d2.org, apatel@ventanamicro.com,
	joel@jms.id.au, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 9/9] riscv: defconfig: enable SPI_FSL_QUADSPI as a
 module
Message-ID: <20251112111952-GYA1685027@gentoo.org>
References: <20251027133008.360237-1-elder@riscstar.com>
 <20251027133008.360237-10-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027133008.360237-10-elder@riscstar.com>

Hi Conor,

On 08:30 Mon 27 Oct     , Alex Elder wrote:
> The SpacemiT K1 SoC QSPI IP uses the Freescale driver.  Enable it as a
> module in the default kernel configuration for RISC-V.
> 
Can you take this one via your defconfig tree? thanks

-- 
Yixun Lan (dlan)

