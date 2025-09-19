Return-Path: <linux-kernel+bounces-824819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE90B8A376
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E5A165917
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46AD314D25;
	Fri, 19 Sep 2025 15:12:03 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2742130DEA7;
	Fri, 19 Sep 2025 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294723; cv=none; b=eFGsr+DWBAQW/DoMRi1uUl5ylWM3M/S8cGKfmZrQcKI2XHit+TRzP07cmvojWcAdUiNm9peBRx3FrRke0uwTmVY8hJerSUfQOkuHWNocCWuxxl/SQQZCNCNx4W1OPBO4UXxWarI7H5D+sdA1A6fo7k2ny41bOoaXAlCeWvZX03c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294723; c=relaxed/simple;
	bh=2QuC0BhxcVX9IfJVhycXKBPRsD9sawudv5RVv+kBDqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtXLkdvAhvrxxOMoT8+3P3fYDJOd4tNcJ0stoPFpX5OM/OBPjzgTx+YuBYtnE74EMH8PqkwMIy/5WGVd1yxKhi9lV1dTi3vSp4gW3al9/yj9ZtiUBkLgEs7oZ2/q5yJ1j9fHwuPoAnVB8JcUxioGRp5MRj5azRnZjj3jq1M8brQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 888BC68AA6; Fri, 19 Sep 2025 17:11:57 +0200 (CEST)
Date: Fri, 19 Sep 2025 17:11:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-btrace@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 09/16] blktrace: remove struct blk_io_trace from
 __blk_add_trace
Message-ID: <20250919151157.GI28352@lst.de>
References: <20250909110611.75559-1-johannes.thumshirn@wdc.com> <20250909110611.75559-10-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909110611.75559-10-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 09, 2025 at 01:06:04PM +0200, Johannes Thumshirn wrote:
> Now that relaying the blktrace protocol information via relayfs has been
> removed from __blk_add_trace(), it only uses 'struct blk_io_trace' for the
> ftrace portion of the function.
> 
> Directly pass in the reserved area of the ftrace ring buffer to
> record_blktrace_event().

Shouldn't this be part of the patch splitting out record_blktrace_event?

> 

