Return-Path: <linux-kernel+bounces-896610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA40C50C54
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DB3B34B2E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D66F274B48;
	Wed, 12 Nov 2025 06:54:22 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8323184A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930461; cv=none; b=XxGIYD0FmTDn1scwe3UvoUVph03EZSfIz/IkyV+NuVFRBAU+meLBI7iTJIkuLyCkKdAO9cFZJbG3HSH0ubG4hv4jI4BXnfWmqhF26qbE7JO/b5ZthQ1tYrqfqIv1Fsy3ozvDhMChn0/WhwSYsgZp++0VrpyIgazWmuZhlaEcPB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930461; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9nyMHM/mdCftmxXdYTyCQjPiMZDFmLdmNa0N+I8tS8RSgjbCBZ1oMrEK6JsMvdedxoctCt9ZSROPAlv5FoNIxUzqd+71TvecB++CHWqATaNfXDNz+mddQ31uVXorvNYU1958xmq+errmziDbZu4YBL33ANCCaGkbaNMZxuKE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 45E63227A88; Wed, 12 Nov 2025 07:54:14 +0100 (CET)
Date: Wed, 12 Nov 2025 07:54:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 1/4] nvmet-tcp: Don't error if TLS is enabed on a
 reset
Message-ID: <20251112065414.GB4873@lst.de>
References: <20251111234519.3467440-1-alistair.francis@wdc.com> <20251111234519.3467440-2-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111234519.3467440-2-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


