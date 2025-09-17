Return-Path: <linux-kernel+bounces-821698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A162EB82021
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6356516B17B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58A130DEC0;
	Wed, 17 Sep 2025 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qA5MK06Z";
	dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b="mWAXJQHh"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74F29ACEE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145418; cv=none; b=WCZGaSj3OENoOIFxm0wgIRToMb8pcTSYvzhyJi5AhDGG9eNvjuKmc37uufuA0m3spwucIzOuYo09vDO/WM00GbCxd9hAxRGazNGujIbQq7JR50Bw/dakcaH6Kb80kvvRS4zvGJ3JGCsgx9FIpVpVdPEu6UQIi/VfOD0KTJnBv6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145418; c=relaxed/simple;
	bh=4JOcVTSCeEfgOssAtyQSaAtfoWGzYMGWH/ZaLvB0CpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLHsISD8wrOmZEQqPNxIjOUL75nt0+UlAi4VTZDydNqVjWuyI7x2aNx/G/75E9BMrNF+SezKBKFU2jLud82Ecsqk9h00in17QqRX0tZUF4v6bYLVAK3U4sdTfK5fHgbtS+hHsqg/ANKmTSkq0lwUlxCH5PrQ98keL8cfhepGyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com; spf=pass smtp.mailfrom=opensource.wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qA5MK06Z; dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b=mWAXJQHh; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758145416; x=1789681416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4JOcVTSCeEfgOssAtyQSaAtfoWGzYMGWH/ZaLvB0CpA=;
  b=qA5MK06ZV1OJY1Oqdj8gC9m2A2FBCl/uS6ZHo35n+61Fefqt7zJAHnRG
   G0gIBEEyQuV0R988mlEWHGuXtrlNpb/Owp6yRMXk98zUfdAPA7pAsheZu
   FV6ufD2A0cKlKkyP7EfQB8YePD//lwlgxRvAIQR5VuNmU5ggzSUjHWnUt
   IyMo03hmCSCZ8nSUFiquZdJVoJWIai/PII1WhzC4M/1B6FODKv8YMvQ7j
   S5mQaoftiQoddG5eePtMHLexZpSJiE9k5EGnPMbKcEsqC9IoJHAu/O7Bd
   HUA4Nf2eFBu5tCm0YBuDmQYIZZuDg3dTX8Lo9bby8Gwt5nFtPofWFTylM
   Q==;
X-CSE-ConnectionGUID: v3MSWAK+RdqV/mwjhLCDLw==
X-CSE-MsgGUID: e5lxZM0CT/2Vg2NaDdwADw==
X-IronPort-AV: E=Sophos;i="6.18,273,1751212800"; 
   d="scan'208";a="124467275"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2025 05:43:30 +0800
IronPort-SDR: 68cb2b82_3Bzrxg3UBgI2COSPRIYw0vdtKafd0UdPKS3yiqLLE5EpOiK
 QtdhVQ3e5pTEXZioXrQqmkzmpqL5ozfL0gZ+SlA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 14:43:31 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 14:43:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cRshf3R5bz1SHkX
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:43:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=in-reply-to:content-disposition
	:content-type:mime-version:references:message-id:subject:to:from
	:date; s=dkim; t=1758145409; x=1760737410; bh=4JOcVTSCeEfgOssAty
	QSaAtfoWGzYMGWH/ZaLvB0CpA=; b=mWAXJQHhbOUuvwoxwa2MSzY1dOq/Okrc7c
	Uz2S8uS0mIYMqZminsOypUjQ4mVZkD8Zds85sRnc/SgrSM8DWsF+gAa5fwi9Oeah
	N3RZGbojbZI/qVayVOr7lkvU+LOSS/tasNh+BSp9Pq1GGpW2piGE4meaT44Mxh/9
	hDnZ79tTxs0DbJUtbFcL9BPWQYlCcZMpUTJAOWKGVnbyfKC4yJVqGxtx7IrLtD6z
	rfx9nA7ZnNYiQPjB7p3OpMKpmnBEX90xCZouUOXUBkxYnsRTXG+gNXD375arDSlZ
	UIftvNzOpNY83mLaiq9VW/0aizaWYLH8IcdCqu3S88MmZuAHTWHg==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id fX9TIgqhaoML for <linux-kernel@vger.kernel.org>;
 Wed, 17 Sep 2025 14:43:29 -0700 (PDT)
Received: from opensource.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cRshd3FDSz1SHkR;
	Wed, 17 Sep 2025 14:43:29 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:43:28 -0700
From: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org, kamaljit.singh1@wdc.com
Subject: Re: [PATCH v2 2/2] nvme-core: do ioccsz/iorcsz validation only for
 I/O controllers
Message-ID: <aMsrgNycCQOCO9Sd@opensource.wdc.com>
References: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
 <20250905232550.1950307-3-kamaljit.singh@opensource.wdc.com>
 <1077309c-2e91-4f0d-b8a6-69d3f9d60cac@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077309c-2e91-4f0d-b8a6-69d3f9d60cac@suse.de>

On Mon, Sep 08, 2025 at 02:57:00PM +0200, Hannes Reinecke wrote:
> On 9/6/25 01:25, Kamaljit Singh wrote:
> > An administrative controller does not support I/O queues, hence it
> > should ignore existing checks for IOCCSZ/IORCSZ. Currently, these checks
> > only exclude a discovery controller but need to also exclude an
> > administrative controller.
> > 
> > Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
> > ---
> >   drivers/nvme/host/core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
Please review and provide any feedback for both of these patches.

Thanks,
Kamaljit

