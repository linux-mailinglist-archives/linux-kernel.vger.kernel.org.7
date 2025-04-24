Return-Path: <linux-kernel+bounces-618714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E7FA9B273
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 17:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FBA9A2774
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6469622AE48;
	Thu, 24 Apr 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSUPMNRp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF2B1A841C;
	Thu, 24 Apr 2025 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508821; cv=none; b=V3yI2MWr0yQsPjWWL6rczGXKdiiq9pfpIJ9KJZiaruGMk/G+BLKFamb0NpZWhCTCRlsGzz0pWxub9gpunf29HY5d22RLFd8HvF6VNhtI4jpqoBr/oVWiP6dZa97HpDqc6MVQvcj7djkvyf5GCmHngBTHqxAdlDz9K09N/EtobPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508821; c=relaxed/simple;
	bh=wU9jfyce70/Gvv2ki/06OL17ud+SeMYiIauhmhd6z1g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=apZWf0/77yxTaJd6EXoXadG8KwWyvKnQjTXKQ3/VTqHuWB01lNw4zo7QR0S4Yw6EC74yiIGM4XEI5OHhb/8iViDIWlQsB0V8vYk8XxwkiXAgDXfyq8cAHbc5u5C/rDGiLrX2y6Tni87KUVQqOf+mJ8TcnHpYIZTRIsQ7QxzQ62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSUPMNRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DE8C4CEE3;
	Thu, 24 Apr 2025 15:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745508820;
	bh=wU9jfyce70/Gvv2ki/06OL17ud+SeMYiIauhmhd6z1g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MSUPMNRpw+9NAbENzEu/+kpPuwRDFbBT5B3WQ6jEWpnVUdLMhWgHBwMRVnbg6HvLp
	 2QhU+fICktAQ8iVtXMB9jSnerbcSQJrM0LikVBpAS6i/kT81Hm5fx7kXKbGXGQcuPu
	 f3DOiCgZuEbUidiRV3U0vNZYphBr9t4toROxbXNtmF7DgcTRh70Og3B22oP/6FWmcj
	 ljppaKAvTLvJJYLm4vZ9KnwnDEYiwGLfuNU460dcn7SD87T9B2pnqKpGYJJhLn+ckE
	 P5uQwsWXmzJkvCDL7IEvaJsjX2D61B/tGTLMrY9+f0MFiT9Im3csqvbG47k4G+Cykt
	 eR9+sf18dq+/A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, mandyjh.liu@mediatek.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 kernel@collabora.com
In-Reply-To: <20250416120225.147826-1-angelogioacchino.delregno@collabora.com>
References: <20250416120225.147826-1-angelogioacchino.delregno@collabora.com>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: mediatek,mt8195-scpsys: Add
 support for MT6893
Message-Id: <174550881826.1465250.14293935570790727278.b4-ty@kernel.org>
Date: Thu, 24 Apr 2025 16:33:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Wed, 16 Apr 2025 14:02:25 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for the scpsys block found in the MediaTek
> Dimensity 1200 (MT6893) SoC.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: mediatek,mt8195-scpsys: Add support for MT6893
      commit: ce37cf8b8520aa292d2eb975b009e15e38347351

--
Lee Jones [李琼斯]


