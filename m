Return-Path: <linux-kernel+bounces-763318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61722B21320
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C40362656A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B742D3A7E;
	Mon, 11 Aug 2025 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYyix1ze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8F1F3FF8;
	Mon, 11 Aug 2025 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933287; cv=none; b=BTnrc6MA7gab461fRMNDPjFX4hxj2MVolyBsODHsvns+FCndVOoFlurj2KmcQuv31QkJnpn3TyiNJyOP47effEXggi1aXi+g/x5mc0tN6pWYO6wFkGclhUlgLF1xGHCYMWx3ROSTCA4bPiLsdgLLHkTkfBW5Pked2roo0Y0c3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933287; c=relaxed/simple;
	bh=GzXL78caePKT9Kp2B9H2vZ39HrtiTx99PRelRc5k0E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUCMVpDbU5zC3bkjdcgPLJM7+bM+BrjuekDhP6lKffpRskIEJH8f8benXoq9xvO3mWZ72n4jwpW4MpXUPTQU+u9Tkw5Bce95TCLmT1oaQ3QERnxkQNrM/4HhvK6aU0q09Cx5K/W8OPrR8wcBH/PTDBrs4SiMqLWFZflc7VOxX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYyix1ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B236EC4CEED;
	Mon, 11 Aug 2025 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754933286;
	bh=GzXL78caePKT9Kp2B9H2vZ39HrtiTx99PRelRc5k0E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aYyix1zeKP8PELpFLtlD/eXS0oiangjZXj+KteH+p9IpPTUJ7IrBq0ww+SviNFoLS
	 CuSRKh7TXGBcPUCWvPrymjWHXTjFMK4VkfuXwyZGRNCItwhLDThmn0K0A0Sr0vuP/V
	 IFS0yHz6eyE8EAa0WUuhpL5zFPOCooJdcWjLIHdsnwSlqQcAqSTPYbScMrCvDC1X5Z
	 Fz4dv6jDcelpRDWMQMDY7TMl4HYcQxipC3ecrn58CunDi2T6KuvKojZJ03/TnX/FtU
	 JTsxtRhihMAcFY75U0BPfcfQr2+pCpVtznQoWyZnpaHszHhITqVtHb/MzOt445MhRg
	 SsDxV9TN/z1bw==
Date: Mon, 11 Aug 2025 12:28:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Robert Richter <rric@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm: Convert cavium,thunder-88xx to DT
 schema
Message-ID: <175493328471.3839591.9689059302626168961.robh@kernel.org>
References: <20250806212741.1633917-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806212741.1633917-1-robh@kernel.org>


On Wed, 06 Aug 2025 16:27:40 -0500, Rob Herring (Arm) wrote:
> Convert Cavium Thunder-88xx boards to DT schema format. There's not any
> defined board compatibles in this case.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/arm/cavium,thunder-88xx.yaml     | 19 +++++++++++++++++++
>  .../bindings/arm/cavium-thunder.txt           | 10 ----------
>  2 files changed, 19 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/cavium,thunder-88xx.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder.txt
> 

Applied, thanks!


