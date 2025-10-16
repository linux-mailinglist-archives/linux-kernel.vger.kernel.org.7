Return-Path: <linux-kernel+bounces-855645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADD7BE1DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 531714F3640
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAFC2FA0DB;
	Thu, 16 Oct 2025 07:07:01 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B423ABA0;
	Thu, 16 Oct 2025 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598421; cv=none; b=X237duRlBVccyNTuT501S0GaulMDmqg7j2ygiVNHfulgyV4XLiNDwSBt0JRLBYsgncz1uIzqmcKOHCov9xe6TQf0KJ1J5jRmVWwdQAhTCdXulqmgO3LuJ7kvtJd21GoDgFIOd0Zkm8PQbsJG+X8xnd+koFkPVVG1sxaszmPkMFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598421; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeEevh4GPc/P5aHTuq94KDY+3hBeCuGdMpd+Gzi8otRF76VLiQW7wI2q12HCjt0dMnvS5viTKhhW/g5lpgsqKmrxY4PW6H/dhKWs0DQXeazNUiKOPFinZqdx8bPCLbiBDyJcNY5T5Ns5Z12V2pXR4g8wbDtQmlg9TtCnUj6yBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 422EF227A87; Thu, 16 Oct 2025 09:06:56 +0200 (CEST)
Date: Thu, 16 Oct 2025 09:06:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: axboe@kernel.dk, chaitanyak@nvidia.com, dlemoal@kernel.org,
	hare@suse.de, hch@lst.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-btrace@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, naohiro.aota@wdc.com, rostedt@goodmis.org,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v3 11/16] blktrace: move trace_note to blk_io_trace2
Message-ID: <20251016070656.GC1417@lst.de>
References: <20251015105435.527088-1-johannes.thumshirn@wdc.com> <20251015105435.527088-12-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015105435.527088-12-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


