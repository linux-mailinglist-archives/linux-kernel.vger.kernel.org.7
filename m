Return-Path: <linux-kernel+bounces-862960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D95EBF6A31
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3BD0345395
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0D8334C1C;
	Tue, 21 Oct 2025 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCFrou7h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5142494FF;
	Tue, 21 Oct 2025 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051697; cv=none; b=YsNJBk4Y9lwWOSqYhTXJdlrIVUb1JoBQviyUcL2vMhfOxCGM6tGHifp/sIyZZfW40culjQNkz9ero1/IY6zU02jxwL9/XAvgTID/p2Ha+ColIeUmXNizucfFsUWgPwE9yICHWPGFGa+ChqmLi+1k3ffcs4Xa7TIAvx4gAkBWS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051697; c=relaxed/simple;
	bh=bAOSuzIkzsOMAD3DqjZxBinmkAaLtQ6iZXn/jLl6V2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtP2xBIKYRYH/Lq2eqELt9EyjCavzCOeWUevbhXK/hsMqprlQy/4u5kS8UHn0gI0HEyEcQiyXFEFrnWXS7SLh7QweBC7b3Zwauj2qrJDPu6iRyjjUYaZNXe1A5HhP6aozS0I8CbOnueUkE30nVqCryHN8oGfDtJd97PRJ79dX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCFrou7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED48C4CEF1;
	Tue, 21 Oct 2025 13:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761051696;
	bh=bAOSuzIkzsOMAD3DqjZxBinmkAaLtQ6iZXn/jLl6V2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCFrou7hkHM2i3UwEjobo/NFRNvv8GUkcdcdedMIjJLBr3GyGSHXvCpUua5SdmUdg
	 sMlGwu29ciX1fx5rx3OhTIOpdiCTFK3oqdvOpoI4ej/V87yZfc7WQECv2CDTrzL3cN
	 I4ANO5Rx+lLGzEgC6q1pfCGT9LD7oHiRoEG68FZBaIG7D8PWBJw3qhu3ZuDcTFEQZ+
	 YS9dVq/de3rffqLGJiA4chc9C9YUmC4yUYP1Ktz1JwkICwiSUlQAouPODfSCuT72j4
	 CFlaaRUh9ovua5iNbnQPBmo7LAV2IgmCij3mwFpATmUGuNNyUkUSQYiBJySrzPkmlF
	 sb6kkoFNcK+RA==
Date: Tue, 21 Oct 2025 08:01:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: linux-mediatek@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	David Airlie <airlied@gmail.com>, kernel@collabora.com,
	Simona Vetter <simona@ffwll.ch>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: gpu: mali-bifrost: Add compatible
 for MT8365 SoC
Message-ID: <176105169286.4039322.13842766904505593753.robh@kernel.org>
References: <20251021-mt8365-enable-gpu-v2-0-17e05cff2c86@collabora.com>
 <20251021-mt8365-enable-gpu-v2-1-17e05cff2c86@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-mt8365-enable-gpu-v2-1-17e05cff2c86@collabora.com>


On Tue, 21 Oct 2025 09:30:51 +0200, Louis-Alexis Eyraud wrote:
> Add a compatible for the MediaTek MT8365 SoC, that has an integrated
> ARM Mali G52 MC1 GPU and compatible with arm,mali-bifrost.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


