Return-Path: <linux-kernel+bounces-851779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871D6BD73B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9C418A42E2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610E0305E02;
	Tue, 14 Oct 2025 04:18:37 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5CDF9C0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760415517; cv=none; b=QAi2cmHcDqeLqfQnrnMEKQ0yKaT8uL6uI2z32LLSmvhwwvpDFvMpXyk7cgUKRKdrftgKr5XzVoyEfp1CAQhhwqmHZUFS8LLyEPWOHyjnFjAWGZMqC99rgbLEO1Q20emFhfuDxZl/BaVdIbYuE0rBYKSCLJuH1bzJtUcQ57SF0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760415517; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG2N2F+3DwcnzdWLaTT88fOQQKsQnasK/l/95to9KIegl6jUAPYCIsFK/hzJp+9RZqF+AQei8OFYWgyVzcamedPs/1zv4QJ32ztqFk/or0w4HhqzswEJE1CgEjWlLEyZ47rSTfnwfa+PpYNbDZoL/wL/FrAXhXgaqCFPQXSoQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 528D8227A87; Tue, 14 Oct 2025 06:18:30 +0200 (CEST)
Date: Tue, 14 Oct 2025 06:18:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove the BOUNCE config option
Message-ID: <20251014041829.GA30344@lst.de>
References: <20251013095620.1111061-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013095620.1111061-1-chenhuacai@loongson.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


