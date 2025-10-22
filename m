Return-Path: <linux-kernel+bounces-864227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9842BFA379
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0607D568562
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFC32ECE8C;
	Wed, 22 Oct 2025 06:27:32 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7802EC0B0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114452; cv=none; b=Gv2xwYYRuXPAeDm1OWtfMPGwIo3nWPe8wrNTZ9ClTPv3HrweH0MSaTlib2q8shTE48tpHhIFXLbiBekeDFY4ChSR9EMGdYcbfCy/uBeHddHrD60SsDEDKukQWe3HjsyaExViu1scdw7i/gn7zInthBdktZV3uzTvnHqxBecvpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114452; c=relaxed/simple;
	bh=Wkx7cEliaGkRR89KIZGZM/OnPhWJWG9XswZNUBP8tYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1VlYTS4Ub3JrECowxu7Hfa6pahR+jkDJYYhpenELlNa1CFrkxN+AEfbvqO9ENQLF5enyy/daLc0yh0MG9qNEw+LBxO2Onejaj3rgm4sSfyo4PyUwfh6KVEEN5u4GCc6rpVpYLKFJ7gkA7pQgwhZf4OdN573HLyvv5AGAhx2ipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6EDE66732A; Wed, 22 Oct 2025 08:27:27 +0200 (CEST)
Date: Wed, 22 Oct 2025 08:27:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme-pci: Add debug message on fail to read CSTS
Message-ID: <20251022062727.GB4790@lst.de>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com> <20251020-nvme_probefail-v1-2-a420046d98f0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-nvme_probefail-v1-2-a420046d98f0@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 20, 2025 at 05:29:08PM +0200, Gerd Bayer wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7544c4bac2c4a230d32cf729abb9e94bf93a921f..c3b0a9d56ac1f32f67ce0890becd6425eb80ebad 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2906,6 +2906,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  	pci_set_master(pdev);
>  
>  	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
> +		dev_dbg(dev->ctrl.device, "Read CSTS register failed");

Should this say "reading" instead of "read"?  Also most (but not
all) nvme errors don't start with capitalized words, like most drivers
as far as I can tell.


