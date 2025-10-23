Return-Path: <linux-kernel+bounces-866461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C9ABFFD0C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC143A5C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CCD2EC08A;
	Thu, 23 Oct 2025 08:13:47 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378F1218AAD
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207226; cv=none; b=RGHLhSAsd5cfjSKmr03LOqcKi8UnhmE4PMwhXTrWPDjpVaLFUSJ2iol9uyutSIjz5s9RSVWE/tHUh1vxjOy2JJwC5EUZXXZfjp+DPkZDrb2zxPkr3Kol7y2xSybwKZM2VApXgUM2KYsa9FZ2ygPV2Qe/7HGVD1SFMAqteFX73cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207226; c=relaxed/simple;
	bh=EZJcoG882HHp7inpoigLZjYjAAr4ChrT6TgIjVfqHJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6UcGsb3ZLfV9d7YwIPuY2TjpmsHWRthn8r/Kvjrrt++QtEtnA/VLsJhk8vifiXJd9IiWvRQl7XIuNjuldN1RG/kdXoKXYSJzOSwXE9KwBCv76PABd4ww6462eXCK/kgrJgW3LM7X2drmLRM939I6ZSWfLnaaJI5DyZZgQEq2K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 861B9227AAA; Thu, 23 Oct 2025 10:13:41 +0200 (CEST)
Date: Thu, 23 Oct 2025 10:13:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvme-pci: Add debug message on fail to read CSTS
Message-ID: <20251023081341.GB302@lst.de>
References: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com> <20251022-nvme_probefail-v2-2-26bbdf94280e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-nvme_probefail-v2-2-26bbdf94280e@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 22, 2025 at 12:33:17PM +0200, Gerd Bayer wrote:
> Add a debug log spelling out that reading the CSTS register failed - to
> distinguish this from other reasons for ENODEV.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

