Return-Path: <linux-kernel+bounces-779861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5F7B2FA83
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEDF3A7F48
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB927334396;
	Thu, 21 Aug 2025 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAuuQtHA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783B3376AD;
	Thu, 21 Aug 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782766; cv=none; b=AuCJUEyxhItj/Yyzpslo49Zp+GlLnz2jr8J6SWqyLO0wTv0XNArAA5s4X+xE9fBDTMih9hNxbrguMCNN1vH6CPYziVUmvwvPMaH/8mCDLdfTk5fvqGppI4TFPEuxWv8oMwyz/egOWQfANXa4FiGkm8G1mkF1132qqEObWnxAU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782766; c=relaxed/simple;
	bh=GWr+idq2vaOWrsPIEOyMjKzrWGN2V2+JkSn81+Be6FI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=F6zm9qR7auRM1GIwCNmmv7gFUsNaddF3UX+F0dCSYAau+aLG9PEDR5j3Pe1KyrV867YV7TI+fGGvGsFep7OMXiMZz5BlG8Z3URkxfU0EITMP6JjsqFMc38VuRVCRecddhUWAmCQwRZwr6y3i7gphgTA12zB3LDXnapjUFI2/vkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAuuQtHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E081C4CEED;
	Thu, 21 Aug 2025 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782765;
	bh=GWr+idq2vaOWrsPIEOyMjKzrWGN2V2+JkSn81+Be6FI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=cAuuQtHAn/7egNIc19ldb8tRH8UyXm6XziXRA7p6tjIp1YFgjgSzstXYiPxJMeBlR
	 y0ZtDnkLsIih2GtXr7bW34h/beKsqWBFnhiYtQZMolplYGXrv5Q9uD9nrdj5/orf9B
	 GVu2Fa9KRdmHvEjMw2vOIk0/b3kPE1N+wuu9FLCesrbz5JmjhVz+kPpOMd132qNnMn
	 iXtRCJu5LGtV72fKfUTFiB1s9WbTXzhWkJe+iQz33J1liO5K9c+fAXKBYMsI+y8s26
	 sgXnEgXgwH98e+/xOEGAELa8MCTAKgamEoeXbQKsHjQReH5+gY4OXKOb1b3Ea+iCP8
	 L2FbaDIv0JkHQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Aug 2025 15:26:02 +0200
Message-Id: <DC851M0PQQT4.298DSVDC1RKB0@kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: falcon: align DMA transfers to 256
 bytes
Cc: "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250821-falcondma_256b-v2-1-83e8647a24b5@nvidia.com>
In-Reply-To: <20250821-falcondma_256b-v2-1-83e8647a24b5@nvidia.com>

On Thu Aug 21, 2025 at 6:49 AM CEST, Alexandre Courbot wrote:
> Falcon DMA transfers are done in 256 bytes increments, and the method
> responsible for initiating the transfer checked that the required length
> was indeed a multiple of 256. While correct, this also requires callers
> to specifically account for this limitation of DMA transfers, and we had
> for instance the fwsec code performing a seemingly arbitrary (and
> potentially overflowing) upwards alignment of the DMEM load size to
> match this requirement.
>
> Let's move that alignment into the loading code itself instead: since it
> is working in terms of number of transfers, we can turn this upwards
> alignment into a non-overflowing operation, and check that the requested
> transfer remains into the limits of the DMA object. This also allows us
> to remove a DMA-specific constant in the fwsec code.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Applied to nova-next, thanks!

