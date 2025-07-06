Return-Path: <linux-kernel+bounces-715383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 762CCAF7544
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 15:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA8D486F38
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3E32D9482;
	Thu,  3 Jul 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fkLNpk/N"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E919513B2A4;
	Thu,  3 Jul 2025 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548687; cv=none; b=AdL04NCKxN3JITxnh+rPEUviyCK2BYrI9L4TZgbcv6Li8tXGaylmTNTfUmuWnBq/jxDTH3t+NUWP4R6wasd+bfWjwivmgESuuzUzKwLiqndp+jZfe1JQwatTTDCbViWReIPPGJwc5eqR4UHf1d8d6eRdNcc1fVpNkTI5oqi8AEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548687; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJgJ0gFvriPeDOijgxVrWxUHGS+fZBROIr4xaZKFok5ofUSynrKLccN/k0oYdPxUn0wyaMjTnf4jj1GNu7JMQCxNJF2mM7kZWkG490zoU5DAvJYbmCtXKu3ukM9UJB35t7yoiU8MNcgnmUbcwFuvkUxKTc/Z6DSMdnGL63mJsUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fkLNpk/N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=fkLNpk/NXA3GNlUMzL/+aIyome
	//R/B5BB+el3c2Jznbb0VhYB16Tp8UasA8bteqL01m5+mNe837tHUJQl8YE0aCDeudmroM+zw/S2H
	Q+AwGHjTZ5H+YP4RRGehJUX5nuPLKjiDmKxG0zcfkoUvNai/w+iOOtnAFLSbp7vj0VdIIf5ct+b2S
	y9pFfHFkwh8w51K0wESmxZ8lJ7SYDBRGXcrdew9m7noPa1bBioGVwBc6jPK6y1RWzKFKyS4WmWWI4
	Wx3rW2kQm7dLYdu4cy/imYW+Eizk0bra38cH9VsO3fPbOIBIWjas1fOFPDElwhhUQobIcWUquo9Cc
	guo2jGvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJpF-0000000BSj1-2MFe;
	Thu, 03 Jul 2025 13:18:05 +0000
Date: Thu, 3 Jul 2025 06:18:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH 2/4] pNFS: Fix extent encoding in block/scsi layout
Message-ID: <aGaDDdcAc4yaYVdg@infradead.org>
References: <20250630183537.196479-1-sergeybashirov@gmail.com>
 <20250630183537.196479-3-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630183537.196479-3-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


