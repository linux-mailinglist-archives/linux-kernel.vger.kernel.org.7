Return-Path: <linux-kernel+bounces-602189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C3CA877DC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 08:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C1F3AEE51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 06:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4591A76D4;
	Mon, 14 Apr 2025 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LTMFSdZD"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E9713E02A;
	Mon, 14 Apr 2025 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744612120; cv=none; b=QT1dNbwIETcrDOfM+ugfXb23E/vnE0lVcrQa6zLZf7oX82URgkvAJ7pnzxoOqf6xrD1JAtPSiN+wtYR8IWHm95O6/cXSLzv5iUwT9pDFT/dTTHjBAk0hrmGPgizBa8Dj9Fu+MaFkCgg3zqfsk3veysrRPVHZI7pOf1nmvfGtY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744612120; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEqm3XlGvPc5as2s3xnYnGPGYjVCl+HVGyXwwVqToBCw5Ab4c+a02x7+oKNAkmKfrtwzKilgMhG9Ssb3EOTyA5o1gmXqvnv5dDO0a2njpFtQb04L/QZ23Njw6Q4RlDdvyDQEBhoXRkr6pI0+wJIM0zX8zuOiJQtoLDm6DisouqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LTMFSdZD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=LTMFSdZDjrOh6fAH/nEU2pq5H8
	2SU/lT+fcHtJdNGAZu9ugyiyo1QklQ6gqCsqntLAXviXmU+KT4YuxFD/hi5n3vAnb4eFOQ2MX8Qpg
	TSIEXukbdjVq1mrRI9idUzysZXf/divH/Ft8KEqzcrdhe355BdpoZRCchfuFpoNjhS+vzOldrxKoO
	NeIYi5utesz8+5lXuEzDpoF+3XSTn38LLktzbn1JDThUMrZTzzh7PHYaRGUr+Ryv1AUiLB1dA+HU+
	DJg2RKCvWoDJMzJqyMus88AsdE9D6jQvgD3nyC1L34SIBi22UXyrX7oRR1M5POFFIQtehzyvUYT+Y
	KjStaQDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4DJ7-00000000nSx-2pAA;
	Mon, 14 Apr 2025 06:28:37 +0000
Date: Sun, 13 Apr 2025 23:28:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, zhengqixing@huawei.com
Subject: Re: [PATCH] block: fix resource leak in blk_register_queue() error
 path
Message-ID: <Z_yrFeucUl6xemgc@infradead.org>
References: <20250412092554.475218-1-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412092554.475218-1-zhengqixing@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


