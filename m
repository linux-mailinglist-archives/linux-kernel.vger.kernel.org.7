Return-Path: <linux-kernel+bounces-731437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF25EB05432
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1391884A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23A8274648;
	Tue, 15 Jul 2025 08:10:05 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4C2737F3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567005; cv=none; b=YoGnNpvX/uPCb2Wg2RclFHjw6TF3i2tYwAWBnKIwrsBtZkn/Yds4wi88dCm6+vrxewz7V68b4FT7Y4vXOUEQGS92e6pFOFeSVUiMm11vrlM988k2eva2ckJkX8zSYMWawWVY0hc4g7iT5wHUBYijviUY8znDm8Xf6GCUR3k7O/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567005; c=relaxed/simple;
	bh=cO1mBIACdPX5nm0QteMyyrTG+5K+DIEd5gmeCRx6BGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjuSu9LrLGU9Ma9Fw+IcfoVwvHVbdj4Qv9CT+REnBA3JV/sTKC1i+GsNp85hEtYK40MssT6K2gloGjewUl4R2BiyqC+PCMLzsMjXCt5+kh7RtxSEPcFdPBEmtKJTgwD/sI2aSGnwTdJN4W9cV4ytfylOKc+KARdW3K77JzFhaAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D7E268AFE; Tue, 15 Jul 2025 10:09:58 +0200 (CEST)
Date: Tue, 15 Jul 2025 10:09:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, gost.dev@samsung.com,
	nitheshshetty@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Add support for FDP devices in fabrics passthru
 path
Message-ID: <20250715080958.GA20790@lst.de>
References: <CGME20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0@epcas5p1.samsung.com> <20250715061804.1954522-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715061804.1954522-1-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 15, 2025 at 11:48:04AM +0530, Nitesh Shetty wrote:
> In nvmet passthru path FDP is disabled, because of failure of
> admin_get_features FDP(0x1d) feature command.
> Supporting this through nvmet_setup_passthru_command enables FDP.

I don't think this is safe - the feature has endurance group scope
and thus can affect other controllers not passed through as well.


