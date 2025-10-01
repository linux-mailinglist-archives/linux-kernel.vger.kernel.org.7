Return-Path: <linux-kernel+bounces-838534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C85E7BAF68A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D061923AC3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0B2737E6;
	Wed,  1 Oct 2025 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KynML4EH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919972309AA;
	Wed,  1 Oct 2025 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303913; cv=none; b=Ajc8A8cIJ5/EuLNGkhqGCIfutI+9GTHNaby4uElYcUvw2A1ahRSz/CEo0fBW2MRsy9OUnOpU8HoIrvdNS5Srve5qDk3PmlZKN6XD8f2HuVsHYmZq3uFAfHJ6piwRtasuKM4lcNKj1YnFjhX2cHTI4F0KQVYfezpWFrzzBZDIpUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303913; c=relaxed/simple;
	bh=wA8sMS5hWdLJEHapFz5MhmyvjjUTDgsUG0G9Z8BrzvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwevjvKOTJ0c7cGcKibLcmJA37jFKEh+QWAapisgkeJvIpfrX2IzyyY87b6PgH2JEjdRSJ2Vhce6/ShG/fCmXg3L0MzxH8XSEUmIb0/AITtshcwF4ZnLu6/SsPT9LeJ6+B8ImGmXu7nWXCnUiDIl6sLTIiogSeYfcysu0ExnHig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KynML4EH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC8BC4CEF4;
	Wed,  1 Oct 2025 07:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759303913;
	bh=wA8sMS5hWdLJEHapFz5MhmyvjjUTDgsUG0G9Z8BrzvY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KynML4EHecaUWlDIwfJJh4/nPplB5zG+5h7GVLnDD6RIX2qxAWwOhs9E9z9GlXpe4
	 VY7/8LkvrIoUMIsf0CPBB87LRnZ3tENCEBanSyAGfgBxKO8UlbiSHsa794fZKlHUmI
	 o7XxIcNH9FGW302bJ0/L/c+RaGu6yzrYtdghj+Ux4MTq1pENseDFNFLLXeOGUozfQg
	 lp6laGKzRn6nnYhkgMGWBud5PwRa9JuWaKAxeEaQc6gYRVqv0MB6A6d16rMWkkA4UW
	 S+TyLRBpRJEurQkIIJUnFqQ/95DGY8LUvpnh/Rn0chB/4wgdtAUUfcwwAJ5U2gBNe1
	 OoauDQ3+9ki+Q==
Message-ID: <5604e09f-f34b-45f0-ac1a-c96acb5fd994@kernel.org>
Date: Wed, 1 Oct 2025 16:31:45 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] blktrace: trace zone write plugging operations
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
 <20250925150231.67342-15-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-15-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
> Trace zone write plugging operations on block devices.
> 
> As tracing of zoned block commands needs the upper 32bit of the widened
> 64bit action, only add traces to blktrace if user-space has requested
> version 2 of the blktrace protocol.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

