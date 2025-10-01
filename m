Return-Path: <linux-kernel+bounces-838461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999D4BAF381
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CFD19411B9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1C32D77ED;
	Wed,  1 Oct 2025 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErCniXdU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CFA13C8E8;
	Wed,  1 Oct 2025 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299602; cv=none; b=MiFVIm6HIpBIMq9abME/XeLYJcNZvR/hL98EZltKo6ahCs0smyOqw5vBDJ93Wsne2BgjkI55mh24rRa2fTdVxdAZnYXWhp20VIV9+ysgQZ2IAtkaQchJRQDIGqI1t93MkB7OHLtW2E8xV5MaFkWlLTttZkGzuTRE8DwDdLtR1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299602; c=relaxed/simple;
	bh=WiCccQxp2MjsbkHC35L2p9tJNaRhMwXne0u3hTUUtBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzyI6AOTTTI4m1w7F59x2ZwMFTolqx77jRV3r91tdjaqik7hS9EncA1QNzWMsrExWj0nlQ8kfLgpCnruAs4TabVgDeyrBNFaEoAtnWnbfKOJ1nxBhtXoCW/V2bsGsdNHww8Z7u0QHzZTJxXnNxEYPVt2Vwt6LV3jCam6DjeNoEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErCniXdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA98FC4CEF5;
	Wed,  1 Oct 2025 06:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759299601;
	bh=WiCccQxp2MjsbkHC35L2p9tJNaRhMwXne0u3hTUUtBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ErCniXdUJTogpnFn63qbRyId6Xe47HnhDW5UroccqjtFcT20FUnMAC+0UtwSE0D4+
	 JiPSOuw4oXfAorXsZMlC/XbixHeWmSXKRIRibxL1YHuoIgUdszrMZ2JVepFxoUJQLi
	 cbOHw2Qvw3fTJWcfqTPmrIANOTuw2/mWiFskBo35bsOqbDUJe6X+ZgPjcAZW6XeQLg
	 NGxpulx+S8BHp4PP6Au/ljRwFzI0cAq/3qWTdKP60TV5vi6YipGBpRFJG3JFs/zBky
	 CSXWJUv5qpLKPbeuzKYeH0jSNHF00orKYi0VZm014V2dYstNZ9beE8avphTBTwlZAu
	 iRf5uE4FwKGJA==
Message-ID: <c1d1ef5b-2173-4fac-a7e5-2785da994198@kernel.org>
Date: Wed, 1 Oct 2025 15:19:52 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] blktrace: untangle if/else sequence in
 __blk_add_trace
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
 <20250925150231.67342-5-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-5-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
> Untangle the if/else sequence setting the trace action in
> __blk_add_trace() and turn it into a switch statement for better
> extensibility.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

