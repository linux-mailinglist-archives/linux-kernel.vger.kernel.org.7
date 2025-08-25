Return-Path: <linux-kernel+bounces-784215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66FB33834
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EE83BD73C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB6329AAFD;
	Mon, 25 Aug 2025 07:50:14 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF1299AA3;
	Mon, 25 Aug 2025 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108214; cv=none; b=mMQsmFCuQSk+fqWgtExNc7Qa+0gU93SadFON99AvJ7Ux6B60L92fiIR60NMnh+lEyni3khN9Kmhx8ORNoZpECrEXirq8CJySRqYPWM85L+WDCEafXzJkD2+WMrDkfJy4Z22nSOP6UnnmkC85h79QOST+1WH9AABMLdzoGUq0Frs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108214; c=relaxed/simple;
	bh=d9yA0rfklyh4oKbQWfBmM0JAHZv5r3P4oh/Dzwnl2XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3+HlTJ9PLzwyHNa9XQvnXYeJxIvjHHqlVXVARfclE67ZOoZDQ5PMx6J3Ycol3vQJ5RoegyJhiOmPotaVECT1JnSLYJar/g+ddkjzHp6wb+JmXcYmFolGIDfLacAJ8ZD5w0vTtew1LyL7QHAk0O2LDTOOh97SW8CnHqaxDtl+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 17E6C68AFE; Mon, 25 Aug 2025 09:50:09 +0200 (CEST)
Date: Mon, 25 Aug 2025 09:50:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk,
	dw@davidwei.uk, brauner@kernel.org, hch@lst.de,
	martin.petersen@oracle.com, djwong@kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv3 8/8] iov_iter: remove iov_iter_is_aligned
Message-ID: <20250825075008.GK20853@lst.de>
References: <20250819164922.640964-1-kbusch@meta.com> <20250819164922.640964-9-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819164922.640964-9-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I have two callers in code I plan to eventually upstream, but I think
of all your pending work in the area lands I might be able to kill
that.  If not I'll have to bring it back, but for now it should go as
all dead code should:

Signed-off-by: Christoph Hellwig <hch@lst.de>

