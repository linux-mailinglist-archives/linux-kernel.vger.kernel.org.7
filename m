Return-Path: <linux-kernel+bounces-889894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF4CC3EC7D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B413A4F0F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61930CD89;
	Fri,  7 Nov 2025 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qObL/xgx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0E30C619;
	Fri,  7 Nov 2025 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501339; cv=none; b=nO1IUrGA9O1dz7ZkMH7bH5htfKfQBU+oLXnPF4/jt3EgYQWwD+6tnQOAruSctgwvFwIjOkkWFA6Sc5wbmhZRwLMgE6l7Nkutbed1PwJFGF6poofutNO0supOwyghcftff57rafM3XgZXxON4ocZVHdD+KcfYvs9jCW4Co0dJfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501339; c=relaxed/simple;
	bh=QOEsFOPjQFpiUiBz4jgCSaSJUjGyNTV8ntGjWFBTsAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oI939sxocq3XXibLS/BFp5XJEXx6/zsGupROMIZCZ9OEESheS1fx+NFGwArWmiAsBboj+Y5q5XnmymK35SbLP6XWSwybibrLyOrfeSo3g+TgW2JaGij8t9yOwLw7EpcZTge5HHZGoSXlda7i+M+d/pHgPrpqcoriNiBql0J4QHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qObL/xgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E6DC116B1;
	Fri,  7 Nov 2025 07:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762501338;
	bh=QOEsFOPjQFpiUiBz4jgCSaSJUjGyNTV8ntGjWFBTsAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qObL/xgxFTjgTNN2Kag+YR1CAvIAkyXCRYMclRO6VWUiEQmn+Gj7krSGTfYLyCE5Q
	 nLw3d5x0C3SJVPdmxaJdt87z63JxsJ2dp1SskKzXb3iuZ61fkQ93xMmxwjTIYfGx/J
	 gq2cOeYNdYkzPgYQHukjuPHLq0nKey83kdfq4OCbWsTQ1QNd3FxCb4DqDYqWCV2F5Z
	 +fZGC5/cV42vTzWqy6ekgGjlxy980sGvrqj96ZvXseaqJT/pwEsSz8hAnQ9gtoWseW
	 lxZV1791UtIGmPl7JP18fIyP/Rylqw+3gjnEc4xcOHtzg7tgWCIb6U0kSV7UXoMd2R
	 vwgZhmAGXSqUQ==
Date: Fri, 7 Nov 2025 08:42:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: clock: airoha: Document support for
 AN7583 clock
Message-ID: <20251107-fancy-premium-lynx-dc9bbd@kuoka>
References: <20251106195935.1767696-1-ansuelsmth@gmail.com>
 <20251106195935.1767696-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106195935.1767696-5-ansuelsmth@gmail.com>

On Thu, Nov 06, 2025 at 08:59:31PM +0100, Christian Marangi wrote:
> Document support for Airoha AN7583 clock based on the EN7523
> clock schema.
> 
> Add additional binding for additional clock and reset lines.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/airoha,en7523-scu.yaml     |  5 +-
>  include/dt-bindings/clock/en7523-clk.h        |  3 +
>  .../dt-bindings/reset/airoha,an7583-reset.h   | 62 +++++++++++++++++++
>  3 files changed, 69 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/reset/airoha,an7583-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> index fe2c5c1baf43..2d53b96356c5 100644
> --- a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> +++ b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> @@ -30,6 +30,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - airoha,an7583-scu

That's random order. Keep it sorted.

Best regards,
Krzysztof


