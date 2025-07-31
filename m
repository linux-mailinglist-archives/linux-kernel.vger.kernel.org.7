Return-Path: <linux-kernel+bounces-752240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD362B172DC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F566170434
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092442D29CD;
	Thu, 31 Jul 2025 14:08:56 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7012C1594
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970935; cv=none; b=e7mLvUXa+OdWoS5fibzYQF2abIVxUFNxfJKKqd2Wt8eV9IV9x7M7sU3mNMbh9HFQT3yUbHSj2AeNUKmiUafxYW1NYvuN4JksDLRpsKbxfTzlEjrsR8IH1QsVqDwhleZZC8CoPB7sw/i+EbFR9qZxv9MpuhCEtfNDCVXUqb0xIWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970935; c=relaxed/simple;
	bh=zYdG/uECLIsbELjbV3B3O27SvBUZrxfluB7h9TXZK5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioLEhNBT3lVubx+1BbjO7OmVkTS0xc02D5/7LGu60KoH18VHjcwXxJS+iNHZcIIUuH+n0Zk8dFIbMTPGZR8ZaxN4R0qhCnLb6LigUobgDBUpxLcWeJjOlnv2WDhkz3rLQ43d8CypbT46DS+bM7yqUjl7Ok21ZH2Ad8IrRzwFNYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9AA3268CFE; Thu, 31 Jul 2025 16:08:48 +0200 (CEST)
Date: Thu, 31 Jul 2025 16:08:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>
Subject: Re: [PATCH v2] nvme: Fix typos
Message-ID: <20250731140848.GA32550@lst.de>
References: <20250730204353.3383702-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730204353.3383702-1-helgaas@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, I've added the patch and already sent it on to Jens with
the current nvme pull request.


