Return-Path: <linux-kernel+bounces-871695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CBDC0E1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE8A421AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D41027F754;
	Mon, 27 Oct 2025 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8ONXjuc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB9264A8D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572095; cv=none; b=bK48ABhIrzMv6UTM5NRdZrFFYe12/YBPY3eD/FEeUJ+U1zf5gidi2CMZJ9hbKUyXjnhBFRszZkdddDuTeRpoHluOe9JypOr8+l88VSNsCTomlpBH8+IddQklOeG2xbc+h2sbGlY0F3v0ZhAMzgTLteCn6Rk1Tm9MPXNyuuysMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572095; c=relaxed/simple;
	bh=CwbhXocmjxTFWUjGdv8larPIeY/QV47kgdj1kXROEQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNrS+omWmWGAWFDzv4pymMtAPKN6/qa/Hrfp7scwCmdatCeKHGeEv4S6OhY1NEbhIKC8hL2JBHuwWa/GbRmRXn5jOP40GQIFW4HXSWyvZfwbxlCSOUlijHl3cQQKLAIaV9m/zOcXtFKPEZ2vX9gFSegvihJNrRQen7tgOWRA+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8ONXjuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BEBC4CEF1;
	Mon, 27 Oct 2025 13:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572094;
	bh=CwbhXocmjxTFWUjGdv8larPIeY/QV47kgdj1kXROEQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8ONXjuc/fmeCiRsrIFQ+ouZyIn5sCP9ugBofsPdhICLVSbEAxtdXww682fDWLs/3
	 cSLVWsXwxDTSMHjEMFMk52sMh1PR8/hd57Eh6HzSF9ZnoHLUo0zuwGDt+CzSyX3AHJ
	 4UfPSgV2dyc5PuFRSmBPoW+YkEMCJ/E/Ho9nVV6cwixUrLRTgOH7GS5raoIdggoXrl
	 C3F8ZcOoKYmaVaknLGsyY3HEQ6FMkf5ZgVJoY6bQBWnK8v/hanqesM2dID/pprDhI9
	 pZJbGzAshskjSoVw+UI++8E0vYWJDFYKIv1zLiROl5nixXHQUNH8cSOVLFmGzhWdmX
	 cO/RcQfOrtjng==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vDNNB-000000000Gj-16R0;
	Mon, 27 Oct 2025 14:34:57 +0100
Date: Mon, 27 Oct 2025 14:34:57 +0100
From: Johan Hovold <johan@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] drm/mediatek: fix probe resource leaks
Message-ID: <aP91AfdoyESxqfPG@hovoldconsulting.com>
References: <20250923152340.18234-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923152340.18234-1-johan@kernel.org>

On Tue, Sep 23, 2025 at 05:23:35PM +0200, Johan Hovold wrote:
> This series fixes various probe resource leaks in the mediatek drm
> drivers that were found through inspection.

Can these be picked up (for 6.19) as well?

Johan

