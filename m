Return-Path: <linux-kernel+bounces-612201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74673A94C19
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 07:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4D13B1FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 05:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450742571D9;
	Mon, 21 Apr 2025 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P83Pd3KD"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4E833C9;
	Mon, 21 Apr 2025 05:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745213202; cv=none; b=R8vkqquzuBAVBsQs3a0521Kz8mRJ4A+wbOgFcucaVqtspaUWzaRUJVPIRFWtKkODDati/Uv4AAFEhH0FrMHutecozzqK0Osz6Hn41la6KYqxeS3nkPqlsxTt7vOhnxhQmcaigwrHQZDFgCXdX0bDQYXnPaQSGJUxA0Xn5ioHhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745213202; c=relaxed/simple;
	bh=I9cIFNM/rZLvlCUfb5axbjFsdCTIlMyMkst/MjJwXIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA4fPsFymsMREN908+IEMo9y4uxFkKf8Xk3dTXXgXtRpaXcVZ5BRGdmjA/Va205BqOodRTL6TZqJsWpEWQHYWi9Wdl8SrAvAX6obexfOa0U3YppY701jmm+YvjfjtM572Q5WCpeNYbvkrZxEpubO+X9rbv9PE6LNfQ7E0tS0c8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P83Pd3KD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K/HSjt6txIA0ZCpteMMDZN2a9UaEpJLK/ifYtNGEuz8=; b=P83Pd3KDF1AejtxMHVRiv8FJ/m
	uTSpz+xBnBOR3lcCbQunULRe4iyI7NC3L3CtIg++3VB/ufJC40XrpI6N2LxRcBz1773xJs1vWaA0I
	bHPiSjayq0uubaqoupEWCWwqw5zs7WdOA7VMW3eNDMGkZ8Ue/jRFn4WPGAU2AV2hAWlRJCgQluT5N
	JGLUGx0uqfZMzUU3+XSfXrq/q+JF5HuMp5ObnFs4wZ/wsgqvYh8y8YwwRLgpF/fvMTPZrmbo2avee
	6ZnylOP8W9Z9k2lgAFj4Wx40hbZW6FzjmfeSiLb4MWPVaaXzlBdyZurQL/a6r4Ftle1bgoKQngEzS
	vd2kFUqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6jfy-00000003d0y-3L0C;
	Mon, 21 Apr 2025 05:26:38 +0000
Date: Sun, 20 Apr 2025 22:26:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 4/5] brd: fix discard end sector
Message-ID: <aAXXDs1t_WUekH0y@infradead.org>
References: <20250418093826.3149293-1-yukuai1@huaweicloud.com>
 <20250418093826.3149293-5-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418093826.3149293-5-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 18, 2025 at 05:38:25PM +0800, Yu Kuai wrote:
> +	sector_t aligned_end = round_down(sector + (size >> SECTOR_SHIFT),
> +					  PAGE_SECTORS);

Nit: I think the version below would be a bit more readable:

	sector_t aligned_end =
		round_down(sector + (size >> SECTOR_SHIFT), PAGE_SECTORS);

otherwise look good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

