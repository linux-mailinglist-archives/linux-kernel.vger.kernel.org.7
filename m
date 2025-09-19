Return-Path: <linux-kernel+bounces-824804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2510AB8A304
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E230B7C5457
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1C4314A7A;
	Fri, 19 Sep 2025 15:07:34 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C531C862E;
	Fri, 19 Sep 2025 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294453; cv=none; b=ffblvwlDTtM61YJ7XZV7xhwa1Djb8ntPQrj/5ExyzL7aQjH8vr1gtt2Lf/Zoc+3oYxzVzFedKcMW140ewu2PMpwhF2CsTDKwR6yzWWzn+ARfB7ZAogl0lkk/YGfGElekPO/6PCeLm5+gyb0CylUZgpN7s7+dQh4UoPXFElUsp4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294453; c=relaxed/simple;
	bh=HzuQVKIshIYBKEncafc3czPoiB033ma2FLPW5GmieFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfxH1jKvflhz0sh4XdMZl4hQ/jpQCoa0OwFsBxOTvlp5kpJX8c7KrG8rBcyraH1R0PgMtAhykC6PwuCk3Fc02jln9MVmW5HJLssHV8bd8KspIXhbhaF5NbNBiYptjhgt8rBQukgEK0mz+Y33tF6hxsLPr6RfJTdYKaUDtFdd1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F18FC68AA6; Fri, 19 Sep 2025 17:07:27 +0200 (CEST)
Date: Fri, 19 Sep 2025 17:07:27 +0200
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
Subject: Re: [PATCH 02/16] blktrace: add definitions for
 blk_user_trace_setup2
Message-ID: <20250919150727.GB28352@lst.de>
References: <20250909110611.75559-1-johannes.thumshirn@wdc.com> <20250909110611.75559-3-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909110611.75559-3-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  
> +/*
> + * User setup structure passed with BLKTRACESETUP2
> + */
> +struct blk_user_trace_setup2 {
> +        char name[32];                  /* output */
> +        __u64 act_mask;                 /* input */
> +        __u32 buf_size;                 /* input */
> +        __u32 buf_nr;                   /* input */
> +        __u64 start_lba;
> +        __u64 end_lba;
> +        __u32 pid;
> +        __u32 reserved;                 /* for futute use */

I'd rename __reserved to flags, and check that it is zero, and then
add a few more __u64 for extensibility.


