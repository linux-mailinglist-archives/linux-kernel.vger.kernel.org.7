Return-Path: <linux-kernel+bounces-890307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32208C3FC2B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2CD188280E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E62D31A55A;
	Fri,  7 Nov 2025 11:43:04 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE0A2D24BF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515784; cv=none; b=PplQ9i1uz9nW1j69W9Sl9TdviKFeklFTvcOe/82Y/9BKU1uOzRKbvez2d6E9vyrezvQ+7UVL8JeTqFI559AR5U9sbtAyn0zwyU2L9G0BOrgVZZ9dM4KcTjOIOwSRAHE7lZwirhHiwplVWaK1ATXS6hts4wBNYqxvQ2GxGopiswI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515784; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJKTTtsKGCYbYViPJchI9Pay1RWzXy2vnVy0TDDjXhQMNTjOSjztnrnPYe78e3j/nkyDFqO1Y6c4WEU7POvrh2u6Uq2+gWv6tLNgIr+JMWO1LSj9eN6U2Li5Jzua1GAcPFL2vY/Di9/9tX3IqBV/JIt+W37Tlw+V4o+4BtCyyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BDB4227AAE; Fri,  7 Nov 2025 12:42:57 +0100 (CET)
Date: Fri, 7 Nov 2025 12:42:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3] nvmet-auth: update sc_c in target host hash
 calculation
Message-ID: <20251107114257.GA29592@lst.de>
References: <20251106231711.3189836-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106231711.3189836-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


