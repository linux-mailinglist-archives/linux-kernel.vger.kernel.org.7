Return-Path: <linux-kernel+bounces-896613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E110DC50C60
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F33C34B2A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1AA299AA3;
	Wed, 12 Nov 2025 06:54:53 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547002BEC30
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930493; cv=none; b=oVyaEYXoe476KUYkLYN+ueqS7Gi5c7kbtoTNOL8OOhrJhwgRikI+o0VZ5ljfC077WedeVDA0XUH5C4Zyf/vQREgF+pDTziVXsRInGGm5aDPO1GS3Az1LuC/JGaZNaWbytsZArkqNYXGjNhfLC6+MITmEtGsPIF89Kg4r93heRko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930493; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNbEBNX0MiPiYQ940siGveFUAREV+EMjiIyEqRoKv7ilFAE+BNwgm18gpyZ+dWY5aOTjBUR+WL+nsfx798ZDY9OEQJ51jQkxR9zYz96hEXmuaeVj59SlE248twOoraRDKi2jmHpJrAAlpFB097zlbkHUJnvg9+WZalmfVTg8lcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A7EE4227A88; Wed, 12 Nov 2025 07:54:47 +0100 (CET)
Date: Wed, 12 Nov 2025 07:54:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 3/4] nvme: Expose the tls_configured sysfs for
 secure concat connections
Message-ID: <20251112065447.GD4873@lst.de>
References: <20251111234519.3467440-1-alistair.francis@wdc.com> <20251111234519.3467440-4-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111234519.3467440-4-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


