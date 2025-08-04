Return-Path: <linux-kernel+bounces-754583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A5AB19996
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 02:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2DB177C7B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 00:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB96202C48;
	Mon,  4 Aug 2025 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="m+4UT2bm"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30E215A8;
	Mon,  4 Aug 2025 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754268184; cv=none; b=TQfVGY3J02ddGP5pXUy2XeXzjXpcSiXETLTPfOaz+xTgt+fm4IT66Bbh/5JRxBSEXHoAaxbAB3+ewYvqsvZHL0yl5sbCHRJeBLcmJ0z6kZDFMcTsATW83AxRxizDasOxwuvJ2aUeLAoYZjsMdz1rx6xWoAgYRYI4sf21d6cFS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754268184; c=relaxed/simple;
	bh=deXJ0X+SqyNo4x7YW1xMxDTf0Yf4yXvJ/VawO2gCEgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Un/5lWAxsNEfWtvLdbMgK7cjTRNajPxBVemh4Xsd9h0zSdUnFQVDvr6l6UxlwZWvm73WI017VGh18EiLTqfp54jqNt6dnfRa6m2nCT03RASmDTSKUR62/RoNA/GEdv4RCBThjPqRY2yMsi6Qqno71WkDK2tkQP/ThOcj45KXDPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=m+4UT2bm; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1754267587;
	bh=rZ2GTvtdLR4dKtuUYv6XmG3B25FHcvC5Jt/WkbqgpN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+4UT2bm2WHVQ46yE1uRgn0S4VP9FzC0oNr5wheu+bDu1L8wmbe7jR+n2sjbi6pCo
	 p6SKJ9JiagEp4DE4NOWOOTeHERCb3/dafxI/GDL8dyQP/FpuKO62aK6r8T7lhmNZ16
	 jS9Du+WwNr6ych95GqYrsyGZ/1g9IRdoleKWod2k=
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5f:8500::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id EA55D198;
	Sun,  3 Aug 2025 17:33:06 -0700 (PDT)
Date: Sun, 3 Aug 2025 17:33:05 -0700
From: Zev Weiss <zev@bewilderbeest.net>
To: Tan Siewert <tan@siewert.io>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] ARM: dts: aspeed: Convert remaining ASRock systems
 to NVMEM layout syntax
Message-ID: <4a58b9cd-8c1f-4a93-8c84-e8f625e1b6c2@hatter.bewilderbeest.net>
References: <20250803151822.68080-1-tan@siewert.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250803151822.68080-1-tan@siewert.io>

On Sun, Aug 03, 2025 at 08:18:16AM PDT, Tan Siewert wrote:
>Hi,
>
>While investigating an issue with an ASRock Rack platform, I noticed
>that most of the ASPEED device trees using NVMEM cells to populate
>MAC addresses still rely on a deprecated NVMEM binding syntax.
>As a result, the MAC addresses are not populated from the
>device tree/NVMEM cells properly, and an address from "the chip" is
>being used instead.
>
>Commit 76c5533925434 ("ARM: dts: aspeed: convert ASRock SPC621D8HM3
>NVMEM content to layout syntax") was the only system that had previously
>been converted to the new layout syntax.
>
>This patch series converts all remaining ASRock Rack systems in the ASPEED
>device trees to use the new NVMEM layout syntax.
>
>Tan Siewert (4):
>  ARM: dts: aspeed: e3c246d4i: convert NVMEM content to layout syntax
>  ARM: dts: aspeed: e3c256d4i: convert NVMEM content to layout syntax
>  ARM: dts: aspeed: romed8hm3: convert NVMEM content to layout syntax
>  ARM: dts: aspeed: x570d4u: convert NVMEM content to layout syntax
>
> .../dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts | 12 ++++++++----
> .../dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts | 12 ++++++++----
> .../dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts | 12 ++++++++----
> .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts   | 18 +++++++++++-------
> 4 files changed, 35 insertions(+), 19 deletions(-)
>
>-- 
>2.43.0
>
>

For the series,

Reviewed-by: Zev Weiss <zev@bewilderbeest.net>

Thanks Tan!


