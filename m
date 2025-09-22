Return-Path: <linux-kernel+bounces-827689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210D3B926A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD50F164987
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562243148BA;
	Mon, 22 Sep 2025 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lwy686eA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F03148A2;
	Mon, 22 Sep 2025 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562062; cv=none; b=Y/hfc/Em0kJV0ucc9BUhdx6NbE4CV9kJJwkllH4C5IOMu7+Lwbs+h54Vk6V9c6sTjLGysxJW3zETujIDx7K4X8/7Mna6xLjj5SzvlRgh1mVFVca2LvViov+rixvIvTCx6Ee850Mk57HXnLIu+NB0smate08Vgyf6r3ZKMCWzIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562062; c=relaxed/simple;
	bh=LgvstVAhZFC9XhxzN9f9868XJZhXwPjlACehXJwu3Ow=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=C0xKXrHcCsThLouMZtS9DvwCE/PAfZteGKjCKs/XUAkevnWuL6/tTj11Pc9EsoYo3jVzTuLgLSEaNnITyOUM72br+Lroc933wobl91OsH2oFRXYm5u9vuNORqAgf59VyEu1jSk+de211ZUQxPh5XcDhNKshsry87i5q00VmriLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lwy686eA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1A3C4CEF0;
	Mon, 22 Sep 2025 17:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758562062;
	bh=LgvstVAhZFC9XhxzN9f9868XJZhXwPjlACehXJwu3Ow=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Lwy686eAmRzFn9wVoSkxBMfVS0wTWyDxiuIfRayw8WHPEqgHVdzudSv/T7EHkf+mT
	 OUnV7UYLzVxuGZFdDO8Nhm7lLnR3Cv2Hdo18GaZh1LuODRyO6BWqkB2XWrdLx/fQ0e
	 zmELoJT7yq+iTEcmun9sALqa5iSEmoYG0uJRifsQ3ZhQVU8TE3tCtqGtqoyVPP7Kun
	 TmVitBC7BgB1AdwawbPKSOIK/4D/VVh10OW9Q6C12gDVjZdWmdpADxup6wDYEEAjbN
	 KgnB984+8t3Y8gJTYzSNQLfxNmZEDYr/b7ZHnOGvDhmETbpYSo32r1Wxy47IX+f8ZH
	 SjjU6G5H9g8kA==
Date: Mon, 22 Sep 2025 12:27:41 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 devicetree@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-kernel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, John Crispin <john@phrozen.org>
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250920091230.17702-1-ansuelsmth@gmail.com>
References: <20250920091230.17702-1-ansuelsmth@gmail.com>
Message-Id: <175856183533.499759.5488159366911717626.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm64: dts: airoha: Add AN7583
 compatible


On Sat, 20 Sep 2025 11:12:28 +0200, Christian Marangi wrote:
> Add Airoha AN7583 compatible to the list of enum for Airoha Supported
> SoCs.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/airoha.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/v6.17-rc5-999-g7ca61ed8b3f3 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/airoha/' for 20250920091230.17702-1-ansuelsmth@gmail.com:

arch/arm64/boot/dts/airoha/an7583-evb.dtb: opp-table-cpu-smcc (operating-points-v2): $nodename:0: 'opp-table-cpu-smcc' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/airoha/an7583-evb.dtb: opp-table-cpu-smcc (operating-points-v2): Unevaluated properties are not allowed ('opp0', 'opp1', 'opp10', 'opp11', 'opp12', 'opp13', 'opp14', 'opp2', 'opp3', 'opp4', 'opp5', 'opp6', 'opp7', 'opp8', 'opp9' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/airoha/an7583-evb.dtb: crypto@1e004000 (inside-secure,safexcel-eip93ies): compatible: 'oneOf' conditional failed, one must be fixed:
	['inside-secure,safexcel-eip93ies'] is too short
	'airoha,en7581-eip93' was expected
	'inside-secure,safexcel-eip93ies' should not be valid under {}
	from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel-eip93.yaml#






