Return-Path: <linux-kernel+bounces-791207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D388B3B372
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E3D169EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DEC245010;
	Fri, 29 Aug 2025 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ead6Kr+0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784E430CDB4;
	Fri, 29 Aug 2025 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449141; cv=none; b=cHAjFR5uCYe3h/AqDPgdxKNtQhEjg6/5ECJMZloYaPvCakp2aPsPJxOsfw9ktPY+6lTBcRjHUDCwItTozLFUJGzQYAQDxjepfVBwYgfiEuEM6lWWLsQDByK5FvoRN9aMyJXBqLEvVF0HLg1CoLhHN77+SVZshzXasimFoUAMM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449141; c=relaxed/simple;
	bh=lZ0QTag0VjlOQOxSce3jMyppu0ATtFUwrlYgNcJo/x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYcvoAyxafn4eiC14ggm+lNOP2Ac0MVOTdxGDtSoaN6+fSyss4h8owRZMf+P0VTeY0L5N18bMrY27Vo74UFLbUjT59UyqKMOU7Kb0Aee531JUo3lGCgelMdAoVhvTqzJdnnxVM9NSsgsUsCyVoynCQTzEGSxWyPIM+rvLFi9ztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ead6Kr+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D48C4CEF0;
	Fri, 29 Aug 2025 06:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756449141;
	bh=lZ0QTag0VjlOQOxSce3jMyppu0ATtFUwrlYgNcJo/x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ead6Kr+0+piLg9YfVifMhyiEpWCpjYQwKm5BrNkbVVEhEtUxHhdAY3TZdPVPMcPho
	 X3MQDNIkatnzRTNeLcZGs0m8ip2ORZAsk+iB5f9gNgs9Q3Kr7pXUqAwlL/fhzdjlf0
	 5JpoRNg74ZvzDfAj19KNjv+NyjqWhN2ttfNmJN6aGpaRinfwpW0CW1TFc2bOvqAeiZ
	 x+X3MEjEruyfBzhwk9aOZJcYANhUWu4Atdkg3VSVbMKA73GlPZulTS1m8pd/XuZZFO
	 L6mqlEbt2gJG/NF5ilq0yfdbTjGFrpREaByt43g///9jPr93TLluHDTMvEZDCtOu8k
	 Fz+dHR4x+QKQQ==
Date: Fri, 29 Aug 2025 08:32:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Chen <paul-pl.chen@mediatek.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	chunkuang.hu@kernel.org, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	p.zabel@pengutronix.de, jason-jh.lin@mediatek.com, nancy.lin@mediatek.com, 
	singo.chang@mediatek.com, xiandong.wang@mediatek.com, sirius.wang@mediatek.com, 
	sunny.shen@mediatek.com, fshao@chromium.org, treapking@chromium.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4 00/19] Add MediaTek SoC DRM support for MT8196
Message-ID: <20250829-curious-indigo-worm-b7e7ad@kuoka>
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>

On Thu, Aug 28, 2025 at 04:06:55PM +0800, Paul Chen wrote:
> From: Paul-pl Chen <paul-pl.chen@mediatek.com>
> 
> Changes in v4:
> - [PATCH v4 11/19]
>   Add New commit to refactor the naming of OVL Fornat.
> - [PATCH v4 12/19]
>   Refactor ovl_blend_mode fucntion
> - [PATCH v4 13/19]
>   Move mtk_ovl_get_blend_mode to this commit to align with driver.
> - [PATCH v4 14/19]
>   Remove the unused paramter cmdq
>   Remove the reapet of pitch setting
> - [PATCH v4 15/19]
>   Remove the unused paramter cmdq
>   Remove the useless parametrt of func():mtk_disp_blender_config
> - [PATCH v4 16/19] 
>   Simplified the driiver code to improve readability 
> - [PATCH v4 17/19]
>   Refine mtk_ovlsys_adaptor_layer_config's layer config checking. 
>   Refine mtk_ovlsys_adaptor_config's logic
>   Fix func()'s mtk_ovlsys_adaptor_stop settting
>   Refine mtk_ovlsys_adaptor_clk_enbale to repaet NULL checking
> - [PATCH v4 18/19]
>   Fix the system report's syntext error


Where are lore links to previous versions?

Why aren't you using b4?

Best regards,
Krzysztof


