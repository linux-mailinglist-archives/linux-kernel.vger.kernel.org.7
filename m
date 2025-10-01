Return-Path: <linux-kernel+bounces-838462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC50BAF387
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A67F7AF762
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32DB2D7D27;
	Wed,  1 Oct 2025 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewjfZxYs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6201547CC;
	Wed,  1 Oct 2025 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299687; cv=none; b=NhIF2VKKIAOfCHG8nz2LaId1nus+91T5X9QkSp+tQixti179oRE7DnzDaevB9rQGNVa2wanPH+k+iH5ayVIPmLphx0XO5I/bny8SJ//jmC/Oa8LDlXlB62zeU7dW8QKS+cHpuZZGe0dP6k58z3r1aRWnKxNn/B7CcadJU7J0jz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299687; c=relaxed/simple;
	bh=2JTb6KrNO0HqxgdAu+4TdlUiI91ZOMArJz8lZ8ZV4cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1IRveOVRHxYbiS9toxnNt3GHyuIjix1iPHhjmGl214QKd6NJQyxtnfj6lgo8MKdynl6Jk6vGGOQh6kPoruQ8H15Z2tH6ZgsoDIkhCX/XFEwnoiYaRAJyDlX3jJMEFHTHehmZkNNnsx58cXZYnztwwNup0lYZyowkkGlfAPtir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewjfZxYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95A9C4CEF4;
	Wed,  1 Oct 2025 06:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759299686;
	bh=2JTb6KrNO0HqxgdAu+4TdlUiI91ZOMArJz8lZ8ZV4cU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ewjfZxYsFBoZZL7QWYFh5Q9OeFZceRVN9GfEMe1P93RnEuiV9m3zjASxsJzwtEK5J
	 yy9PNV5PkwvUCz0l3m7Fyn4vAhbJfl6hfGkNO+eGN36FN2vWY2EZethwSwszuNJG8B
	 FFYVWIp8BfITgLKeUehp9h0N9010UBjpdEhUOvEP6deKBGMmbw/E/a+F6dilBcRAGH
	 /eIFvubxQdpQf8FMg0gMax3eIWVkEZHtvHmR+QZp4F6f8NZXIuYwcB6Y4xL9J+9wOx
	 9iWZ1ISWfusrXmaAcy4aI6YpeGuOu+0mq8elDlOy8U/xS95KmHUDdK0hZ4kD3St3oj
	 xwDFBIeEFE81g==
Message-ID: <9f4761db-7638-4697-ba5c-c454964c69d1@kernel.org>
Date: Wed, 1 Oct 2025 15:21:19 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] blktrace: change the internal action to 64bit
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-btrace@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
 <20250925150231.67342-6-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-6-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
> Change the internal use of the action in blktrace to 64bit. Although for
> now only the lower 32bits will be used.
> 
> With the upcoming version 2 of the blktrace user-space protocol the upper
> 32bit will also be utilized.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

