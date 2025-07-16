Return-Path: <linux-kernel+bounces-733672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63091B077AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079B33B7A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DF021D3DB;
	Wed, 16 Jul 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DunwLRFa"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A519F12D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675077; cv=none; b=qmoQDDDJ6k8EnSn8QchHaMrmgqAsS7rmUGl++/tXMd79eEVG0dkzHzV7nMaMYDLcnxmtgKeuol1G7EUYIZsQcvbsZQEIu5tS7QXrGQrJFEAnOj9EFzwqf32pXYMfu29IMuEQ7jnimN1LgPBLF5cio9im1+u2qIHuzvCWBvvleHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675077; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5yO9HcqamFZPOJEBBl/GY9aVwb9CQsSGqPKsHe390bzk+VguTG+IcqGnsiK5TZ440hVkSCOe8fhxX9V7Iu9DGclEmoT3wNvyXAktbpO58jbAVD5VIdQ56FwBpTrCvsQZChKnZ2dCj8s3AS38zpCXj58idmsAtMmQyXZLfMIZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DunwLRFa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=DunwLRFaQWevoWW1aK9fTdlCKk
	gaKX6fcIVZub+WFc2S6YCtfLYKD0c0eCzu2EmHEZTJx5mUr8ElFBrQAUjzIKnYOyrUmz6CEfFH8js
	IKZi/czhLBizagnWzq9/n7OZSZ3PMIQP7BvucrWQ68lp/RLvA22wspIwUTqoTxYF+O26e7TB/vMrM
	nVgGdl9ii812FF3Rq7R2p/YWblHOcdAiq2udyk7t5Eb0x+5DKzoKI9ufN5P6TbRh03jTzLUWlJ0WE
	tu1R8cfeRcLFGNGY+NygzwwSLN+ffR0otc6OIgQibMTVho10/qXevzvteUIDeyZLsElNMFiaU/03G
	bocyODLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc2qo-00000007s5H-3kRT;
	Wed, 16 Jul 2025 14:11:14 +0000
Date: Wed, 16 Jul 2025 07:11:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: linux@treblig.org
Cc: akpm@linux-foundation.org, hch@infradead.org, terrelln@fb.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/xxhash: Remove unused functions
Message-ID: <aHezAgl9CE5RBPxE@infradead.org>
References: <20250716133245.243363-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716133245.243363-1-linux@treblig.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


