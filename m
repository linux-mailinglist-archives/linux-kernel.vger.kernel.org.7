Return-Path: <linux-kernel+bounces-811023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C63DB5230A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF39D1CC1DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294852FF140;
	Wed, 10 Sep 2025 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMy5s+OR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E95C2820D1;
	Wed, 10 Sep 2025 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537649; cv=none; b=jeiUkdBi9WjlXXgQPSZy/yO2xpfbUs3f+J/5ekpVZ1Wkf1ncwv9Ib6aa5UtzN+8vnZ0s5xipdF+iC/O4vyYI7sxQ9fQgW/FT1uXT+/WaDl3fvuO2VBVwngZcaVJdzTMnl5s8GJSWctZg3aE1W8rgaWy3RaQgvms+jJS5HkB8Tfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537649; c=relaxed/simple;
	bh=/lPhduxhLE2dyo3EDgeauFRMNjRR24GuMLp+Kl/txcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjoSGuP7NCuiL/XM9LxBeMs0NaivlLPtXL2CXYhDxfAk3DjNyhTvPAtZk68BOuFDLzUlk2hfmW1tW3fQPEsyhE63m46PeISkbIU7mzJIgKEgBh6delmAsqZgdmRQSQQDYxtZv7mIfIf548QyCxwhNY+e6k1dDD89BRhJwlBKCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMy5s+OR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E83FC4CEEB;
	Wed, 10 Sep 2025 20:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757537649;
	bh=/lPhduxhLE2dyo3EDgeauFRMNjRR24GuMLp+Kl/txcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMy5s+ORtS1KZ/hJOTvg+ulKukoFIx5t6OHHrGMarN5mTnW6lzKC6VXmugr7uqz7h
	 AL1u6w3X+5xnBadTXHRNu4UzKCYRMmYjOBn8jQMkXJq86fEH6ZFdglkpcsLD6DsqHx
	 zcTRiPGiUAliPiTmk6JT1Eu53RuJH3LeLeewg0t501G/Zdc8wXdeGLXRDK0vGDzhnZ
	 aj9KIB78vUP3R9dTeSqA0rBI8KHp1g1ieZD/ZTzy2tA0bGvWqbtEJtv5DiORKgDA4p
	 vpMk8xksy3gCvtLvMoU4JIVQmH2InYhunf4U0JQ5nCjRc6MF0T72JFY5aH/68Vji67
	 3FzyHrlVxLNwQ==
Date: Wed, 10 Sep 2025 15:54:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: mailbox: Convert rockchip,rk3368-mailbox to
 DT schema
Message-ID: <175753764852.389988.1115547537255507154.robh@kernel.org>
References: <20250812181348.62137-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812181348.62137-1-robh@kernel.org>


On Tue, 12 Aug 2025 13:13:46 -0500, Rob Herring (Arm) wrote:
> Convert the rockchip,rk3368-mailbox binding to DT schema format. Add
> the missing 'clocks' and 'clock-names' properties. Document that it's
> one interrupt per mailbox channel (and there are 4 channels).
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../mailbox/rockchip,rk3368-mailbox.yaml      | 56 +++++++++++++++++++
>  .../bindings/mailbox/rockchip-mailbox.txt     | 32 -----------
>  2 files changed, 56 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/rockchip,rk3368-mailbox.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt
> 

Applied, thanks!


