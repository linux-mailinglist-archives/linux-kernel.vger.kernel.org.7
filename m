Return-Path: <linux-kernel+bounces-892505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AACC453AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BADC3B2FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10A42EC547;
	Mon, 10 Nov 2025 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2FVL5ka"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484B2EC083;
	Mon, 10 Nov 2025 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760181; cv=none; b=quaQ6Lt87Rx0n2ZyioAkyuGtKhYXbx+l4xrjRSlvDa9e0WqWSlLU+9VyLqLL94Sp2OT5ad2popA0iHDECylsJ6IkH789t8dcN57eiv/KBDDmreki/ySo7DpOPkj6wQNDPVWA5UIjHutjGTwQEruoL08yTEmrtrqloer+MTBIpVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760181; c=relaxed/simple;
	bh=y+wG/rw2tXAG5zLwj0mDQigKy7jfvT4bcUlh+zg3SdY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QzvINaJ8D8giPsw1LOkHEhN4wlbXnhkwUTUl6sCBxYgcv4wtcHk+RsS0VsprO+2uv5rTZFWi2tweiDd/xdeb6QKGORvS+dj08caS2iAIdCJyrb2v4Cgky2S+NteVxuEC3wufSuLAgehgFx6AHbfGK5BiSvHlnVB5w/bHwK6tF1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2FVL5ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44809C16AAE;
	Mon, 10 Nov 2025 07:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762760180;
	bh=y+wG/rw2tXAG5zLwj0mDQigKy7jfvT4bcUlh+zg3SdY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H2FVL5kaQjTDPPrF4gGMzntCN89sGQfM3jiiro+diCD7zESTrd099Q1dZ2QXjI/a5
	 +KMPhtSX+i6EagnhL1F/DBKdSVoXl47j8TA1NKkd7oOdzrAjRTdL6zWKmwBtSs0iNa
	 OG+cYCyWjbpsW12P/R0oZosv+/7EUiy9+iX6CA5F5zjCPVpF/QuPFaR3dNvROKnl4f
	 dBLn2mDm9kZek6h4Nu+nmW69rnzNh2lfyOv4FcfCRrdI+t0dLSBoZc2jhlYQ2MNM1b
	 6f/fauO7bThPmSbxskrrnpnA2YxCjksTSuFbwsX6Bpg+t8Nykdq29+gesqmBZ2gXU6
	 vfSjXyc2DbDHw==
From: Srinivas Kandagatla <srini@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Lala Lin <lala.lin@mediatek.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20251030-mt8189-dt-bindings-efuse-v1-1-1148e474a9f5@collabora.com>
References: <20251030-mt8189-dt-bindings-efuse-v1-1-1148e474a9f5@collabora.com>
Subject: Re: [PATCH] dt-bindings: nvmem: mediatek: efuse: Add compatible
 for MT8189 SoC
Message-Id: <176276017278.17598.8750030991108782000.b4-ty@kernel.org>
Date: Mon, 10 Nov 2025 07:36:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 30 Oct 2025 11:26:10 +0100, Louis-Alexis Eyraud wrote:
> Add compatible string for the eFuse layout on MT8189 SoC, that is
> compatible with MT8186.
> 
> 

Applied, thanks!

[1/1] dt-bindings: nvmem: mediatek: efuse: Add compatible for MT8189 SoC
      commit: 11a4220f789fb8a75b5941a5205d866da4fe39c2

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


