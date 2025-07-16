Return-Path: <linux-kernel+bounces-733434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D20B074A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607427B7A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DDD2F3629;
	Wed, 16 Jul 2025 11:24:16 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3922F2C6C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665055; cv=none; b=FefnciS3mWV3hjtpOKeN9kdTE4vqRjXRRsdhqHooiV451fDUijlh04eCr7VCsapq1GhZhxIWBkZ/+fFgI3HMk0P9HOmhaN51df87EbzNbHlyJ3DsawJKH77VXzZPbHfeQvz389RS4DrAggb5iUKi7eIO4nXG8gfnVXhMM/LHTz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665055; c=relaxed/simple;
	bh=FAv1cGPA7pilhCumJlJNfYz52Q/FcpUPZIRSSASDsaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHJyJ6fJO6+vRZTr8V/lUiBvcnbKWM18Qyb6zQqyb3yd40WjlVjD+rnNRxf+90MF3NkPuwHv396Zxd2OoCkEQDgLQwWhls1mhT/WnT1M1UWkOuYrGXxzz4ntRN317Jfv+xMyn/tc73OjoN08YV0Y5CEpa0qW+7L2YrnFi/SCmJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A0FA68B05; Wed, 16 Jul 2025 13:24:09 +0200 (CEST)
Date: Wed, 16 Jul 2025 13:24:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, gost.dev@samsung.com,
	nitheshshetty@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Add support for FDP devices in fabrics passthru
 path
Message-ID: <20250716112409.GB30581@lst.de>
References: <CGME20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0@epcas5p1.samsung.com> <20250715061804.1954522-1-nj.shetty@samsung.com> <20250715080958.GA20790@lst.de> <20250716084301.aulmx23rmumae3ba@green245.gost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716084301.aulmx23rmumae3ba@green245.gost>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 16, 2025 at 02:13:55PM +0530, Nitesh Shetty wrote:
> On 15/07/25 10:09AM, Christoph Hellwig wrote:
>> On Tue, Jul 15, 2025 at 11:48:04AM +0530, Nitesh Shetty wrote:
>>> In nvmet passthru path FDP is disabled, because of failure of
>>> admin_get_features FDP(0x1d) feature command.
>>> Supporting this through nvmet_setup_passthru_command enables FDP.
>>
>> I don't think this is safe - the feature has endurance group scope
>> and thus can affect other controllers not passed through as well.
>>
> Agree, how about only enabling only for nvme_admin_get_features,
> but not for nvme_admin_set_features, something like below?

Yes, that looks fine.


