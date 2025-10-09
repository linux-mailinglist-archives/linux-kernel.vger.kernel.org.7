Return-Path: <linux-kernel+bounces-847035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD28BC9B51
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC9019E5516
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CA92EC0BB;
	Thu,  9 Oct 2025 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWszcOpT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA6F9E8
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022637; cv=none; b=OhpLa0iVUKnU7hT6prOsmnnWMXrYFgYifphQ7xzSQSF0V0/WzRzV/YADXy1tAzHvVQ0YNar5i9tU3gjWxulwf59hg/NBJn52Xl6OD2KQ3IVHBrjTxbCoaAaouS/Sp19rX2YFvBKCvi5qbKb2EQlhjsJzIrkJcJGRtwj+vLOP7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022637; c=relaxed/simple;
	bh=Isprq6q6LkghppD5uA1BlqTuxnab7pQeDZHphtpTHbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTLg2cSUd51QCZ5fQsvi+lMegJKCkgTCKId6ogasIgddd+16uS4GarUljYlXgd/+O7e3QNzvKRSpcptm6qEXioojBy0Q56gTqPzBh+pOleRl4H0Tr98OyfsiV4Z9OjNPIFlef/bq++OZ4QSfGqRZKCk4qPuJCfpSEBCqY9OLFrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWszcOpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E2DC4CEE7;
	Thu,  9 Oct 2025 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760022637;
	bh=Isprq6q6LkghppD5uA1BlqTuxnab7pQeDZHphtpTHbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWszcOpTmJLgvU4gcfh5/I8AqGMap4991PLXSn+dqcFCAm+k9nuYgqDDcOYYw2ty5
	 9PrzmyyRpCe9yHOhzzQCzsJguCYdl6xCTU1vdELDjJj8mpfJJeKc10EZFcR307Iexg
	 qj4DlKvcy4F3N+5/FK2kj6QkXLEdO8IQObVPZUzOiSE05ovQhQKv5WkwYK7zyWVhjA
	 xD/p9POVcmN+1PlbGC8hVh/0nHcULTJg8qH4etKJqpLgNge3EZyH1AK52W0lzHvTH+
	 Atp9s1yqajKgDE66cp1Fl3UGXyfUm0gXIWSCtESZ2TwebuTLzUUUEpDbXCtVE0VJpZ
	 ZqFkxgqWJNKiQ==
Date: Thu, 9 Oct 2025 09:10:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Amit Chaudhary <achaudhary@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, mkhalfella@purestorage.com,
	randyj@purestorage.com, jmeneghi@redhat.com, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme-multipath: Skip nr_active increments in
 RETRY disposition
Message-ID: <aOfQatF6bqyE1OCF@kbusch-mbp>
References: <20250926190823.5031-1-achaudhary@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926190823.5031-1-achaudhary@purestorage.com>

On Fri, Sep 26, 2025 at 12:08:22PM -0700, Amit Chaudhary wrote:
> For queue-depth I/O policy, this patch fixes unbalanced I/Os across
> nvme multipaths.

Thanks, applied to nvme-6.18

