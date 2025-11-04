Return-Path: <linux-kernel+bounces-885586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C374BC33672
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B95142010E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6351347BD5;
	Tue,  4 Nov 2025 23:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cnm41Soy"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908F347BBC;
	Tue,  4 Nov 2025 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299498; cv=none; b=ngkEz1HBCHs3VuttKXeILuv5r8o/MAaTIBYurSLWwdhNxsgSAXWu7EHXbUGMJlUx4P5dF+v5g4EoIWjOpUcDMYE22tGKl2x5Mtz1MWqUXSIa/jcWYwYKox6liIAl7xk5EdSzhBRXamwTT43mRz2llVgBIsYiuD4EjZVZkTd0/xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299498; c=relaxed/simple;
	bh=d6jGXoU5GQSpFp0lLHnXVWpgeyTdlTkXzUAgiwHMotQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpnPjvR02wN03NCj7El0kFkkRu/jMQLLwW9Fi/OcZ67wVS3XaX2ZcnXruibo8VrF8ZjpD9bXukan6TbI1edKRziIKUqiD7ipH5JOHikBLkS1/pFBUImPDVQ3TvE1n3tYiht22v2we3/8Z1P7NwmMrsceVp3a23Rnji3HO6gQVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cnm41Soy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ElQ2RmJ1x7R7nu/XuCBdWb6wueQnVDguJsjDWzY0/do=; b=Cnm41SoyqaPXpJ/OuoYNN6myFg
	veQLYRFhrNs3VCIj1XK2BBsbtaXoYoYBjGFide05sgrwhfZ3QIsGcI1ke4Owc+vRQxpEtyJaEBNwf
	YVCFJfpCWXBM9TbaINmscGQOYoCe1ilC/bjRq+476xRhp9FOxBiFFykO/pD3f32yntVmZgvGqWU7t
	pL5CYxFUUlOIBT63BMIQHJrjIby5+lPciLSSPo2Sb6hNaEbUx1Ho3rH0ETqjbhpU9tUT3/DR36m88
	/87UB90SDbRKwfRGgrd31Kovs5SunhQfWKnwAzhAAylnDyQ/8/J/+8rpj4Qx6SSueVdRXGRvd/dwA
	iG6j8XIQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGQbN-0000000Cl96-33oi;
	Tue, 04 Nov 2025 23:38:13 +0000
Message-ID: <8189649a-604f-4d5b-82a6-b31ef42967f5@infradead.org>
Date: Tue, 4 Nov 2025 15:38:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: taskstats: Reindent payload kinds list
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>
Cc: Balbir Singh <bsingharora@gmail.com>, Jonathan Corbet <corbet@lwn.net>
References: <20251104130751.22755-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251104130751.22755-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 5:07 AM, Bagas Sanjaya wrote:
> Payload kinds list text is indented at the first text column, rather
> than aligned to the list number. As an effect, the third item becomes
> sublist of second item's third sublist item (TASKTYPE_TYPE_STATS).
> 
> Reindent the list text.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/accounting/taskstats.rst | 52 +++++++++++++-------------
>  1 file changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/accounting/taskstats.rst b/Documentation/accounting/taskstats.rst
> index 2a28b7f55c103e..173c1e7bf5efa4 100644
> --- a/Documentation/accounting/taskstats.rst
> +++ b/Documentation/accounting/taskstats.rst
> @@ -76,41 +76,43 @@ The messages are in the format::
>  The taskstats payload is one of the following three kinds:
>  
>  1. Commands: Sent from user to kernel. Commands to get data on
> -a pid/tgid consist of one attribute, of type TASKSTATS_CMD_ATTR_PID/TGID,
> -containing a u32 pid or tgid in the attribute payload. The pid/tgid denotes
> -the task/process for which userspace wants statistics.
> +   a pid/tgid consist of one attribute, of type TASKSTATS_CMD_ATTR_PID/TGID,
> +   containing a u32 pid or tgid in the attribute payload. The pid/tgid denotes
> +   the task/process for which userspace wants statistics.
>  
> -Commands to register/deregister interest in exit data from a set of cpus
> -consist of one attribute, of type
> -TASKSTATS_CMD_ATTR_REGISTER/DEREGISTER_CPUMASK and contain a cpumask in the
> -attribute payload. The cpumask is specified as an ascii string of
> -comma-separated cpu ranges e.g. to listen to exit data from cpus 1,2,3,5,7,8
> -the cpumask would be "1-3,5,7-8". If userspace forgets to deregister interest
> -in cpus before closing the listening socket, the kernel cleans up its interest
> -set over time. However, for the sake of efficiency, an explicit deregistration
> -is advisable.
> +   Commands to register/deregister interest in exit data from a set of cpus
> +   consist of one attribute, of type
> +   TASKSTATS_CMD_ATTR_REGISTER/DEREGISTER_CPUMASK and contain a cpumask in the
> +   attribute payload. The cpumask is specified as an ascii string of
> +   comma-separated cpu ranges e.g. to listen to exit data from cpus 1,2,3,5,7,8
> +   the cpumask would be "1-3,5,7-8". If userspace forgets to deregister
> +   interest in cpus before closing the listening socket, the kernel cleans up
> +   its interest set over time. However, for the sake of efficiency, an explicit
> +   deregistration is advisable.
>  
>  2. Response for a command: sent from the kernel in response to a userspace
> -command. The payload is a series of three attributes of type:
> +   command. The payload is a series of three attributes of type:
>  
> -a) TASKSTATS_TYPE_AGGR_PID/TGID : attribute containing no payload but indicates
> -a pid/tgid will be followed by some stats.
> +   a) TASKSTATS_TYPE_AGGR_PID/TGID: attribute containing no payload but
> +      indicates a pid/tgid will be followed by some stats.
>  
> -b) TASKSTATS_TYPE_PID/TGID: attribute whose payload is the pid/tgid whose stats
> -are being returned.
> +   b) TASKSTATS_TYPE_PID/TGID: attribute whose payload is the pid/tgid whose
> +      stats are being returned.
>  
> -c) TASKSTATS_TYPE_STATS: attribute with a struct taskstats as payload. The
> -same structure is used for both per-pid and per-tgid stats.
> +   c) TASKSTATS_TYPE_STATS: attribute with a struct taskstats as payload. The
> +      same structure is used for both per-pid and per-tgid stats.
>  
>  3. New message sent by kernel whenever a task exits. The payload consists of a
>     series of attributes of the following type:
>  
> -a) TASKSTATS_TYPE_AGGR_PID: indicates next two attributes will be pid+stats
> -b) TASKSTATS_TYPE_PID: contains exiting task's pid
> -c) TASKSTATS_TYPE_STATS: contains the exiting task's per-pid stats
> -d) TASKSTATS_TYPE_AGGR_TGID: indicates next two attributes will be tgid+stats
> -e) TASKSTATS_TYPE_TGID: contains tgid of process to which task belongs
> -f) TASKSTATS_TYPE_STATS: contains the per-tgid stats for exiting task's process
> +   a) TASKSTATS_TYPE_AGGR_PID: indicates next two attributes will be pid+stats
> +   b) TASKSTATS_TYPE_PID: contains exiting task's pid
> +   c) TASKSTATS_TYPE_STATS: contains the exiting task's per-pid stats
> +   d) TASKSTATS_TYPE_AGGR_TGID: indicates next two attributes will be
> +      tgid+stats
> +   e) TASKSTATS_TYPE_TGID: contains tgid of process to which task belongs
> +   f) TASKSTATS_TYPE_STATS: contains the per-tgid stats for exiting task's
> +      process
>  
>  
>  per-tgid stats
> 
> base-commit: 27600b51fbc8b9a4eba18c8d88d7edb146605f3f

-- 
~Randy

