Return-Path: <linux-kernel+bounces-892249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0276BC44B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4353B09F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA45120296E;
	Mon, 10 Nov 2025 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0N9pJjZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095A2286A4;
	Mon, 10 Nov 2025 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736702; cv=none; b=QUp9xWk3chmWCmQ3myWtAQJH7Mkbr5RzcPQwM5W0WNJS2Lsb7xJp2uHcY4iN/DKmQEiRZ5rCADpsc56QXAY4WezCLssgLzG6jlcldNVSxLmKptUxCJANB+Bj77/DhCL/1pO+M/P6UjQ9EmKQEvaUP2PSfMA0xnh1NZHhqk0qDxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736702; c=relaxed/simple;
	bh=R+V0Hzfys57c/aQcKhl9q24jMrKAlHVuduRLA5/ZiLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZh+v1m2xjbTkJjYNe4CUlVMMvnw0LKrXT4dyEvS31SHXfJalJa7e3qVg4FMdzy6/GuAM6XyQ2b3awqhu62sD+8psRwFDjH9I3llQhHT3o82zcoLqmCAquTFxqUbKDESjUZLklFYGlh2HlS/wLFItbhxayxMkqLzC0fg/4v4Ljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0N9pJjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C90C19425;
	Mon, 10 Nov 2025 01:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762736701;
	bh=R+V0Hzfys57c/aQcKhl9q24jMrKAlHVuduRLA5/ZiLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0N9pJjZ/8zU6/P8tjKKBuajJf66vBAcxWFkn9koV7rQ5sKBvcmlApWCng0YiO9p5
	 AmWae1thEFPP86hhlLmPptwWeg37FqRJShgWPW7JijzH+bSEbLDQ9KUBXEwgI9CkrP
	 JVuSuXH7WGrmr+4fRQqBPt8d/vLR3RoE5PRALHLuB+BQxVQt+hMy6XLXHpgx0EniRG
	 6Dtg9nCSFrAJfRphcPKwqnA7P/2cJP8E7LpXE/6W7hqmKocGwbA2RMgeDhCYjIfRKz
	 kCaE+ySbbZ4Kp9wgNzs4kFaiCW2k9gre5jtNZw0/pa4/A5uuWwMI1mZil/I3KiUB74
	 SnhSxlO32qdOQ==
Date: Sun, 9 Nov 2025 19:04:59 -0600
From: Rob Herring <robh@kernel.org>
To: Rogerio Pimentel <rpimentel.silva@gmail.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	alexander.stein@ew.tq-group.com,
	dario.binacchi@amarulasolutions.com, marex@denx.de,
	Markus.Niebel@tq-group.com, y.moog@phytec.de,
	joao.goncalves@toradex.com, frieder.schrempf@kontron.de,
	josua@solid-run.com, francesco.dolcini@toradex.com,
	primoz.fiser@norik.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: fsl: Add i.MX8MP FRDM board
Message-ID: <20251110010459.GA2481668-robh@kernel.org>
References: <20251109214515.121742-1-rpimentel.silva@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109214515.121742-1-rpimentel.silva@gmail.com>

On Sun, Nov 09, 2025 at 04:45:14PM -0500, Rogerio Pimentel wrote:
> Add device tree compatible string for the i.MX8MP FRDM board.
> 
> Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>
> ---
> 
> No changes in v4

Missing Conor's ack.

> 
> No changes in v3
> 
> No changes in v2
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 21b7168d61f5..f46cf6d1f502 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1099,6 +1099,7 @@ properties:
>                - emcraft,imx8mp-navqp      # i.MX8MP Emcraft Systems NavQ+ Kit
>                - fsl,imx8mp-evk            # i.MX8MP EVK Board
>                - fsl,imx8mp-evk-revb4      # i.MX8MP EVK Rev B4 Board
> +              - fsl,imx8mp-frdm           # i.MX8MP Freedom Board
>                - gateworks,imx8mp-gw71xx-2x # i.MX8MP Gateworks Board
>                - gateworks,imx8mp-gw72xx-2x # i.MX8MP Gateworks Board
>                - gateworks,imx8mp-gw73xx-2x # i.MX8MP Gateworks Board
> -- 
> 2.25.1
> 

