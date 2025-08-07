Return-Path: <linux-kernel+bounces-758759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 579ACB1D38D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3803E18A564A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F59524113D;
	Thu,  7 Aug 2025 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JCLPVV6V"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110E623C512;
	Thu,  7 Aug 2025 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552544; cv=none; b=mbNYbURJI/ikaCTWG8MNumCCizMamnojIytJH86AADx1ixPK4wiVhaxHjCCcuLPZHnQwkAPd+fHyGYwP0pm6h8ANNxTcTaHmRp3+/oEiHkOAHPTDELrLOCRX8SO0xmfDcynz92P14T31zXT6E/lWHH3hBliyAc/8uiZw8MIB1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552544; c=relaxed/simple;
	bh=H7gI/QkU5mGOp6GhLKlxsKsfd/y/Y4/o0Q88QZH7wIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYOxLc1ZiRKT8NvK2QNY1Z/S4dKtjg0c4FeN6fM+AopwBVdwTIuHDNA06v22OtN+m1lpNntLkU1J1zWPOqB7Fhm27zg9kvFeMIPoKvtA5roWQPf3yZRhQ64XfgEm/M8+p6ZImBGRRRLywlg+IoHcq1elXj91hHKEZuNsmKGkTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JCLPVV6V; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 159E220692;
	Thu,  7 Aug 2025 09:42:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HHqSeRq_gcEW; Thu,  7 Aug 2025 09:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754552539; bh=H7gI/QkU5mGOp6GhLKlxsKsfd/y/Y4/o0Q88QZH7wIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JCLPVV6VnmiVpULyLwqu7CfnSt+w+68YFkSquR/haFOVOQvt3Tp1NyANmDsLS+n5v
	 0r3bomtLEYHgOX9MMUIgbYJBCSHb0tpkZ+4s0zz5powu+MNVt2GctxggttBF+pLnxS
	 qvhi3/aGsVapnSEaC4Dh2FuhIVT1tBbu2U+xLGdBrq+h9PeD5tYOkEIUhhf9UBeBMK
	 YNHKIWEcAt5u1T8d+0BZbULxj90ZJk/Mr+HfYv1y+9YsoTq8VvFXKaOMAhSUfTF7W7
	 ixfn0kCsmTO1KaQaciEOAP+zHNQOFQ0GhKb43uoKtJw4GZAZ2u76mK1ENpK86odBIt
	 Us8mvwZV0xVRA==
Date: Thu, 7 Aug 2025 07:42:06 +0000
From: Yao Zi <ziyao@disroot.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, cristian.ciocaltea@collabora.com,
	detlev.casanova@collabora.com, devicetree@vger.kernel.org,
	heiko@sntech.de, jonas@kwiboo.se, kishon@kernel.org,
	krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org, neil.armstrong@linaro.org,
	shresthprasad7@gmail.com, vkoul@kernel.org
Subject: Re: [PATCH v5 5/6] phy: rockchip: naneng-combphy: Add RK3528 support
Message-ID: <aJRYlA6jo9l-XrHt@pie>
References: <20250728102947.38984-7-ziyao@disroot.org>
 <20250807063036.480766-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807063036.480766-1-amadeus@jmu.edu.cn>

On Thu, Aug 07, 2025 at 02:30:36PM +0800, Chukun Pan wrote:
> Hi,
> 
> > Rockchip RK3528 integrates one naneng-combphy that is able to operate in
> > PCIe and USB3 mode. The control logic is similar to previous variants of
> > naneng-combphy but the register layout is apperantly different from the
> > RK3568 one.
> 
> Is this a typo? apperantly -> apparently

Ahh, yes, thanks for catching it.

I think this series (at least the binding and driver parts) is mostly
ready for merging, so I'll be thankful if the maintainer could fix it
while picking up, or I will carry the fix in a new version if it's found
that larger changes are necessary.

> Thanks,
> Chukun

Best regards,
Yao Zi

> --
> 2.25.1
> 
> 

