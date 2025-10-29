Return-Path: <linux-kernel+bounces-875549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E127C19537
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26544584904
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F231326D73;
	Wed, 29 Oct 2025 08:52:22 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C7B326D45
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727942; cv=none; b=gC3tQv6hwgkFHBTKMkMTdCk70Cp4/yFC4Yc7JlGVTFMKOUSOLpjo1UbS4Fiv2hKstXwUboKilaqAWnDO5W74a/UMI7IBNbwaEMGOeHCnokQq6N+2EFfYUziQuA7F5XtuyR5cnEy0nsuoRXpIdwz6EyCiryYGii8JJaOqgnPz/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727942; c=relaxed/simple;
	bh=cY/qXVPk9mIQSQ3FKadnVSsHuwFCQ1bn8O4gFJ6DgMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UALq+s8F9fgtd9vwNJg6UqnrqOYq1t6bYfrOtnc8DGxYgPJ38K760QCCjCbOnoQG2Ze49Y1czAt3n4LEx/xemygJcHJrSGjQbeGW46LABRm7LJrKaLRBEYxbHRvU/dS/sQAA6FHhrr4zWSgRyxm6+z2AAWbavIhhdpKwsmyCnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47C66227A88; Wed, 29 Oct 2025 09:52:17 +0100 (CET)
Date: Wed, 29 Oct 2025 09:52:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] nvmet-fcloop: check all request and response have
 been processed
Message-ID: <20251029085217.GC32307@lst.de>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org> <20251028-nvmet-fcloop-fixes-v1-3-765427148613@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-3-765427148613@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 28, 2025 at 04:26:22PM +0100, Daniel Wagner wrote:
> When the remoteport or the targetport are removed check that there are
> no inflight requests or responses.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


