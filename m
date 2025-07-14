Return-Path: <linux-kernel+bounces-730758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7EAB04974
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E814E11C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC1728A738;
	Mon, 14 Jul 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvoMcceW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF1F277CB6;
	Mon, 14 Jul 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528149; cv=none; b=UenrXNgtFejmS2LphOpnz5W5D78heEt1TZsYTiCasSopq3WV6QHLszr6NEH/a5DFXY889OYUKNua+H09L97Fuurt+zn+AUGx+7IC0WnxUa4mciEffFadpX65IFo6ZqU+YFkLZgapGb89mro0+3KYBTpVwyB2WQ03mFFt8MaeZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528149; c=relaxed/simple;
	bh=XWvyEJu17/NYmt5lKHJpnUX0PIhb311yUkoU6DfI3wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCMZRI203WgFN6diGg4MIV6ir/+fu3RwlrrVTrLSJX1UrwWNsQn8Rfre/iTOJneDZgCjBw7w4MX0DHKYhwxtWRmG6kNaux04ZCBKo3Z0Wrvq1TN/d+OB/wVrygD1EO4Spz9WpidUrZZbDebi5X7KZjtmSQeZpdAfgkDsyXG27l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvoMcceW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C3DC4CEED;
	Mon, 14 Jul 2025 21:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752528148;
	bh=XWvyEJu17/NYmt5lKHJpnUX0PIhb311yUkoU6DfI3wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvoMcceWv1Y6tF61U88roTUWlaNIqhWe/DqowtENh0zvk+4MWV1j3cMWFwYHttF/Y
	 UuvxMs5JqKQDgeJqqv1PwxSNDnq+nobMH6BW91rOqgo+W9RaZfzlgy0xLQymd8wq/h
	 OLtfnMf1xHtD3XVRiFBBMUUyByiryS60CL+gi0WSsucdf3JYGScxsO1d/SVXYZhO9u
	 6pUzFqIrpBOgodGDqQ+shI8uUwNvx7rEF+BHh1tP3pBxlBZjCSfEkTwW1AQM+bXBKE
	 eijRQ/V8mVvJSwur+UYSibH9tMi7VYjn56cipMASCVu/Mei73KqUlomr/26Gu6h0Jl
	 0pOnmP1G58bGA==
Date: Mon, 14 Jul 2025 16:22:27 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: iuncuim <iuncuim@gmail.com>
Cc: Samuel Holland <samuel@sholland.or>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
	Chen-Yu Tsai <wens@csie.org>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: gpu: mali-bifrost: Add Allwinner
 A523 compatible
Message-ID: <175252718830.3073791.16346905793933146110.robh@kernel.org>
References: <20250711035730.17507-1-iuncuim@gmail.com>
 <20250711035730.17507-2-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711035730.17507-2-iuncuim@gmail.com>


On Fri, 11 Jul 2025 11:57:27 +0800, iuncuim wrote:
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> Add a compatible for the Allwinner A523 SoC, with an integrated
> ARM Mali G57 MC1 (Valhall-JM) GPU.
> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


