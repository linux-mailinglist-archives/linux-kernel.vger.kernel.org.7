Return-Path: <linux-kernel+bounces-741842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 231F0B0E9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8701C851DD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9187D213E90;
	Wed, 23 Jul 2025 04:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1XN4AoV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00651862;
	Wed, 23 Jul 2025 04:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245409; cv=none; b=QTANrlVqezXco80YgxPKV76an+Dsgj6rbz46jGzlB+BfMiVU3EsLVXJ/1d0rQ8Wg/CBEXX1rfGIQTV6kCrszrpvBr+yRIPsSl/Y9wT/6Gfr8x9KPQ3Ac2ySKQNeJrpb0x59zr9uGKVfGsutU0rIQSFDgzgRPrMemPhEAr8yJVvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245409; c=relaxed/simple;
	bh=p74UQxL37h+qr7qVg6gSZ2EFfhn9ij8y2knb2vj/tS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HulFDjVHorO/uZRFvoU9TYDh/awHWojhYQy4x4aHtkImDvwYL4oaSqI1WjWSFN5Vbsg71M7Ou1L+wll8CeffFgHpv7n/nLRO1QpCMC5XIIySDFrlUV9FtOxEMNGV8oVFfcnx6gMao9hfbOQsu5wxQqhDiwMOUZb1uyZ/rmwewv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1XN4AoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9522DC4CEE7;
	Wed, 23 Jul 2025 04:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245408;
	bh=p74UQxL37h+qr7qVg6gSZ2EFfhn9ij8y2knb2vj/tS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1XN4AoV+19gzg+G2YbU+hc/5erT24ot/DxijuT5PquMvXxd0voSi4pYmNhYNYlay
	 tf+D35Tmv1hZ9SLgaHfsHMi0D//H90Ex3RKRvJH1PyTpQuIbkbkMQBq05sJlF6ANMx
	 24DT9D8dQEldXjTNMGs1qgOO9ztMvWu7BklOD6yol70cNf14MbdqLDFf05hQ1wufVL
	 lvS3gKMBL3nTvdQbIxF4hl4tvSiXp4IwZBL2V+sCCkBo5GTFe1joPPXqfntqFnFhGR
	 Kbugk5NGriYPyTexgIjzph/fXP7ywPccDyMzIapaH5XlwBc4DCKBDw5YeveLMNl1pt
	 OtqntMnO4l1CQ==
Date: Tue, 22 Jul 2025 23:36:47 -0500
From: Rob Herring <robh@kernel.org>
To: Erik Beck <xunil@tahomasoft.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2a]: New board support,LinkStar-H68k-1432v1 (RK3568)
Message-ID: <20250723043647.GA1201956-robh@kernel.org>
References: <20250721201640.233818-1-xunil@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721201640.233818-1-xunil@tahomasoft.com>

On Mon, Jul 21, 2025 at 04:16:37PM -0400, Erik Beck wrote:
> Signed-off-by: Erik Beck <xunil@tahomasoft.com>

The threading of your emails is messed up. This is the only one in the 
thread. You need a commit messsage. Perhaps it can explain about this 
device/board some.

> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 5772d905f390..7f3904b69293 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -1109,6 +1109,11 @@ properties:
>            - const: rockchip,rk3588-toybrick-x0
>            - const: rockchip,rk3588
>  
> +      - description: Seeed LinkStar H68K-1432v1 RK3568
> +        items:
> +          - const: seeed,rk3568-linkstar-h68k-1432v1
> +          - const: rockchip,rk3568
> +
>        - description: Sinovoip RK3308 Banana Pi P2 Pro
>          items:
>            - const: sinovoip,rk3308-bpi-p2pro
> -- 
> 2.43.0
> 

