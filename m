Return-Path: <linux-kernel+bounces-817764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473CFB5863D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818517A84F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F57E299AB4;
	Mon, 15 Sep 2025 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDg19uYk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC4326E16A;
	Mon, 15 Sep 2025 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757969848; cv=none; b=GxQLQHjt+MvACXUSen5V7EUotwU90p3rzD/kz1OBpTxnAqvOKBN5pUMPPN4u4fYRYKc5VnQk3TphaYU3r1769DeHyhc8rwOr2jM8Wr5ry6Cjcc8iGG7ECLcblDGZ7qqOgOZrtPTpHhiJp4SV+NL6TVnL9fX1Ft2ShNzwmmwllwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757969848; c=relaxed/simple;
	bh=FAhsTruNsmWXJBgpWX4neFlt6ZUZBvbVYrNSsZrP9Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JznsQZLtvwEiZLqP0q0v2J15rWAHsIFmx29k3uPkrkfN8JODsgl/G311GvobZ+D+BknZLw9DnqRa2yvTUUAehq/JUyygVlvYWTV8wlROBruG0EAXiAjmBIOOlXp6tR59h2q8QkkBIubGHgAGh/2m1rANtMw+HRJJprPLVNGnVIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDg19uYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D0BC4CEF1;
	Mon, 15 Sep 2025 20:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757969847;
	bh=FAhsTruNsmWXJBgpWX4neFlt6ZUZBvbVYrNSsZrP9Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDg19uYkgT3SYKYudfHms/thXSN1PJVhS6DNjX/ydUkyipksa9MUbbyu67Vy5MDde
	 HN0rfRbZgXVFQnA4OuN1sK63G/q/ydnVclilBLVFna0ZzKI/UHzEICbx8oyEcHmx0a
	 NieG0Au7lFxj2Rlppk7m3j2XHuGH5CIJGdHPhjubOTrKriheI9LPVqRmn2vIRC5l2l
	 T2F2r3a/O860Qy+dR/Whz3WTUIKQX/j7481LEYgZMq2ukKh7LmBsvpOwl2/gL37PRK
	 HXECH5Xp//gJ+77E1otT9Uzy2U9DAcl5Wz7ZdDrS1do8NN2lH8jv/Qykj0CUcZVfjv
	 5OFEh3p4q6duw==
Date: Mon, 15 Sep 2025 15:57:26 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: auxdisplay: change to
 unevaluatedProperties
Message-ID: <175796984570.3379405.7210704746413204244.robh@kernel.org>
References: <20250911180641.1031346-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911180641.1031346-1-Frank.Li@nxp.com>


On Thu, 11 Sep 2025 14:06:41 -0400, Frank Li wrote:
> Change additionalProperties to unevaluatedProperties because it refs to
> /schemas/input/matrix-keymap.yaml.
> 
> Fix below CHECK_DTBS warnings:
> arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dtb: keypad@70 (holtek,ht16k33): 'keypad,num-columns', 'keypad,num-rows' do not match any of the regexes: '^pinctrl-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/auxdisplay/holtek,ht16k33.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/auxdisplay/holtek,ht16k33.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


