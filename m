Return-Path: <linux-kernel+bounces-740251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99115B0D1DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FDDAA0136
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB8428B50B;
	Tue, 22 Jul 2025 06:28:55 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0CC28A40F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753165735; cv=none; b=WO02ixj5kkjxOCDJkVoRA92/rLRsmgGcti7+X6k7iS4a0KkGFO3U1irpagymeF5uSqLMrV10wPrVxtsB6NtfUYMaTol6hb8h4z6POzvrIJArvZHu7ag2dSEhr85GQawD4mA6ZgAuimxAF0akAX7GJFcSAdDj3zXnqmNQPpa06dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753165735; c=relaxed/simple;
	bh=SBKOdxW28jmuDVPViy2Scq83g0cvOJ2w8ggLjiNpmFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af/9he7cQWUnFR6TFkRMzQNd21Taf4oyV33UqUji81eAqNcJz6qyG6IM7f5L7TvNYs2ptzM3kfGGMFbIpWqFBU6btkhA2G/iJhdisHEMTuXtyIgZ9K9yShxbL6uY++pbZ4uB4m0z4x+cgL0O8/ecCoKiGTq38gNPAjjsvUk2lqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0586768BFE; Tue, 22 Jul 2025 08:28:49 +0200 (CEST)
Date: Tue, 22 Jul 2025 08:28:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kamaljit Singh <kamaljit.singh1@wdc.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v4 1/2] nvme: add capability to connect to an
 administrative controller
Message-ID: <20250722062849.GB15013@lst.de>
References: <20250721173700.4153098-1-kamaljit.singh1@wdc.com> <20250721173700.4153098-2-kamaljit.singh1@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721173700.4153098-2-kamaljit.singh1@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

added to nvme-6.17.


