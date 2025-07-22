Return-Path: <linux-kernel+bounces-740250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18641B0D1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4108E7B1207
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E5328A718;
	Tue, 22 Jul 2025 06:28:44 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0528CF56
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753165723; cv=none; b=qU63FfDSznVyS5AQYZCGIgSxz5FxltdMpI4PJL3LOjNOFt1tKfuetSBtmt3BNwKd6TE6GNeo49qe/0ut4PDm+mI3WV8Otbor3HjNy8s8zlhslIapLVuhhz+gNbtsXUTi+E86GZBsPe+DB3hpPbT1OkSNEWeSHRHg7ZkcsIzNwJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753165723; c=relaxed/simple;
	bh=SBKOdxW28jmuDVPViy2Scq83g0cvOJ2w8ggLjiNpmFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbxsFEAXqaAQKkC1frvleiGqGHh5EBQgKEz0G5ww9xWcs73ljN/knuinl2hbFmMIOWNBFW76OrQbGhxqjX7/HcLnMB8O9YJFpjxhPt2uQidXkhtJoPaJ2THGBYzMYMdPzl6DvAtdLJ8A8U9UYexyzB/jlxpHTM3lGEEyYCBsapE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA4B468AA6; Tue, 22 Jul 2025 08:28:30 +0200 (CEST)
Date: Tue, 22 Jul 2025 08:28:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, gost.dev@samsung.com,
	nitheshshetty@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmet: Add support for FDP in fabrics passthru path
Message-ID: <20250722062830.GA15013@lst.de>
References: <CGME20250716134010epcas5p1c7ca7bcc7addf12c4cab2e4aefb7e020@epcas5p1.samsung.com> <20250716133944.1384388-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716133944.1384388-1-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

added to nvme-6.17.


