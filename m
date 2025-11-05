Return-Path: <linux-kernel+bounces-885965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DCCC3465A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1CC1881771
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247FB2BFC8F;
	Wed,  5 Nov 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZGq89TI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43919D093;
	Wed,  5 Nov 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330030; cv=none; b=Xz497IU79gVt/LVGCXKgV0EKXHhtrFh9wWkz/FfvI12EZTSFQqv0a24zWg+/QUPWyWY69II5xJW2gPS6OnQsxhyPSzLTlJXcCeEJKkVEkCy+tk3o9/0uDCD5ESzG6s/ZQTu3U1DGRks2Miky9bRUIxcB/q6RZGKjfYmvlibXb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330030; c=relaxed/simple;
	bh=ysdaCTaAgAss4/GsTrN52AKA2BxvM2SH97zvlE6w+YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alEvkj/0IGfg96Yi5iChFnB61W/KMiCFBRW6TIOGwNwK1sgnBUEjBePRCUeIYPDejrn2BsPNAGG3opT3lURcGc98+yaQl0Xw1ovk9GFFDikQFOo9MI5lvJHZL+oRIFY63ch4+scwUjtb+AUMigY2IOfBBre9eW9+519HpguNhNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZGq89TI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C75C4CEF8;
	Wed,  5 Nov 2025 08:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762330030;
	bh=ysdaCTaAgAss4/GsTrN52AKA2BxvM2SH97zvlE6w+YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZGq89TIXF5jVACh67jprFUvkT789XJgr1728AnIv90SRnE2erOC2+GS9k1mZ2Cqr
	 /5TwLpSx4Q674iV1MyRjTUJ6F4jPzIKRj0BEZLUMr5yfpitbHJOsbINCrIekDDJX0Q
	 wlHyVZOvixujHbaGsjty6L7ia/9IxcasojcgwQxZyRLKQedsBbPaBawTfqnq8Zqb6T
	 YrS31qjL8Nz0LvZPAQpd1UCheROL+7XFDlelNj5fueMnsdWCZMnZDP+qZCuaLUAMa/
	 T8XMdwMG/mCBz0u2MzIpteeAY1ggDejkTzeqa7orL8/gvZk3pq4o0PtADInXMU2xDR
	 3lJI04UaXoZZA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vGYXv-000000004tG-1gIA;
	Wed, 05 Nov 2025 09:07:11 +0100
Date: Wed, 5 Nov 2025 09:07:11 +0100
From: Johan Hovold <johan@kernel.org>
To: Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
	Houlong Wei <houlong.wei@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Nicolas Dufresne <nicolas@ndufresne.ca>,
	linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 0/2] media: mediatek: fix VPU device leaks on probe
Message-ID: <aQsFrx_wHor7CAPD@hovoldconsulting.com>
References: <20251028100454.4086-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028100454.4086-1-johan@kernel.org>

On Tue, Oct 28, 2025 at 11:04:52AM +0100, Johan Hovold wrote:
> This series fixes VPU device leaks during probe of the mdp driver.
> 
> Included is also a minor documentation update to make it clear that the
> VPU lookup helper returns the device with an incremented refcount.
> 
> Johan
> 
> 
> Changes in v2
>  - drop incorrect vcodec patch since that reference leak has already
>    been fixed by commit bf1d556ad4e0 ("media: mtk-vcodec: abstract
>    firmware interface") which added the codec release callback
> 
> 
> Johan Hovold (2):
>   media: mediatek: mdp: fix device leak on probe
>   media: mediatek: amend vpu_get_plat_device() documentation

Looks like I forgot to add Chen-Yu's reviewed-by when respinning:

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

