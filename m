Return-Path: <linux-kernel+bounces-606441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B85A8AF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 06:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70CB16B4D5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 04:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DA7229B36;
	Wed, 16 Apr 2025 04:48:38 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC33D1714B3;
	Wed, 16 Apr 2025 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744778917; cv=none; b=HrUjVSXZifY5UkpHeV9AS41+cgSGCWCegJgbWdGhLAsrhCZ7qVLLtizL+hqxIsSZ3H6KEpmP03R8+nsxe6fOgI3eVGuBoL/TTcrifCSTRCfjSHGGwGPg6k793ifffWR2r36lv0da2DQCx7CauudOlQ9nfXzkpCVo2cdzo6fNmXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744778917; c=relaxed/simple;
	bh=MPhAKgSzy8ZorosPbLbQYUfCXsX8YY93br9OttTmY1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqNYxa+gS6WJ21WWJ+DbiCQS47JWvaluSlOa2fVb+2QuYZvSm5cLaxoZ74B49GdAo831NIF8WDc1GfRqIe4CpNLJwmOFPfVGNoDXjS3g4LKsF7j0yo+1A/ptdzffBXL/sOL+QSKAjMMKkeYV3eIAB79c0DmfzmqdPOU/9LcQaFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CD62068BFE; Wed, 16 Apr 2025 06:48:27 +0200 (CEST)
Date: Wed, 16 Apr 2025 06:48:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-mm@kvack.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 0/7] kernel-hacking: introduce CONFIG_NO_AUTO_INLINE
Message-ID: <20250416044827.GA24153@lst.de>
References: <E9B8B40E39453E89+20250411105306.89756-1-chenlinxuan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E9B8B40E39453E89+20250411105306.89756-1-chenlinxuan@uniontech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Your series did the grve mistake of sending various patches only
to some recipients making it unreviewable.

But doing less and more explicitly inlining in general seems very
questionable.


