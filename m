Return-Path: <linux-kernel+bounces-748533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0061B14256
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D107AE861
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FC6277011;
	Mon, 28 Jul 2025 19:02:22 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C438826D4E4
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729341; cv=none; b=iedR1jeTXFx0vipfYJBiOLLP20ONCFzJnZLAypJd/gilTJhXxvo8J82Nm7OvkN5G83ZthkQ4N97N/1u2bTF4N3ZW9GEpHNrNJzwhpawjvxWZXoAKkQf9RGVZpkqGtbbg3S9Ci9BXKpKhSZU5buwe65hFBoanlbxT3a/vFUeoF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729341; c=relaxed/simple;
	bh=Cw180htXbw7ovak4HVQUG/1JI7ZYunDfzfvjtVI5r9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViQLYAoSSseR8D8IzBY1LJb+sGsuWnw2md5sWaFW0Px8yj+gRAsNL+EEOsMvvCPPqdXg8SVtrzS+tbvgJQwqKm9/vZgjTNfk+Uan5cEqieJF2eszl6wE+ZF+e+XkrV90AhWWhaGY5p43gX8fS+WRTW6cbYTu548rB1dkEYvJub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 56SJ1s1s024575;
	Mon, 28 Jul 2025 21:01:54 +0200
Date: Mon, 28 Jul 2025 21:01:54 +0200
From: Willy Tarreau <w@1wt.eu>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
        Finley Xiao <finley.xiao@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 3/3] nvmem: rockchip-otp: Add support for rk3562
Message-ID: <20250728190154.GA24527@1wt.eu>
References: <20250415103203.82972-1-kever.yang@rock-chips.com>
 <20250415103203.82972-4-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415103203.82972-4-kever.yang@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Apr 15, 2025 at 06:32:03PM +0800, Kever Yang wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> This adds the necessary data for handling otp on the rk3562.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

Successfully tested with Jonas' patches on top of it on my
Radxa E20C (RK3528):

Tested-by: Willy Tarreau <w@1wt.eu>

Willy

