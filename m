Return-Path: <linux-kernel+bounces-775922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C055B2C682
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7AF1798F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BAD343217;
	Tue, 19 Aug 2025 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a8TxIPfA"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC0F3431F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611934; cv=none; b=Vh5pmdyp6APw7S1bibuHbZ0oHUhnH4SqZgEbMGYNQovmxNYZEtZhZVqNoZ9g/pA+dGbgl+y4VGF3kYIZbkMT9zpmPwaxGwD21JtaSs940UwVOhEuf7AUsz3jaC3mcjIw59kF4RhOjgo4dk+u3DXWoQMCqX04X4qUeLJCfUSaoG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611934; c=relaxed/simple;
	bh=j7PVnel7ayWH3ho8X/v7p+9YH2ksWSNZpfdEzuQO47w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENawTXOg/LdhOTaHteL+lmV0+hoG8QVeis57A3iYEg1xCywoEqQaL8fBawsESDZAvim40Cts/ZVZMa2l5ph/x5HcvE32ZmjsLNw/mC54OLvDj3InkHSlSSNOMAxCpm2hU7gSv51v/pQq27kmORk8RoUKzO0CNM11YasDDDDe7I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a8TxIPfA; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ff84e67-075d-4dfd-94da-0b81262b8e0a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755611929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phWcgP1/kwPwDcBlWCgHS7YAADCIs8eHQL0JpzWKMnc=;
	b=a8TxIPfAPscgU9ugKmSiCPnwwtaI7VRFZVat2yodXspBUTou3O3K26YqtwxXzBM+ZCBK5v
	Vp1FRe0Ux1t8ooicBWm4ixqhcbvJmry0edxrMgj4RUWu8sPbUHjMi92y1aaadrVi2cmIHw
	hjEOIRkun9k7c2BgVdcpCnZfvOPM4Ow=
Date: Tue, 19 Aug 2025 21:58:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] panic: Clean up message about deprecated 'panic_print'
 parameter
Content-Language: en-US
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, paulmck@kernel.org, john.ogness@linutronix.de,
 Feng Tang <feng.tang@linux.alibaba.com>
References: <20250815071428.98041-1-feng.tang@linux.alibaba.com>
 <20250815071428.98041-4-feng.tang@linux.alibaba.com>
 <aKRJKZHgcxyNF3y7@pathway.suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aKRJKZHgcxyNF3y7@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/19 17:51, Petr Mladek wrote:
> Remove duplication of the message about the deprecated 'panic_print'
> parameter.
> 
> Also make the wording more direct. Make it clear that the new
> parameters already exist and should be used instead.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Nice cleanup! This makes the code cleaner and the message
more direct. So, feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

Thanks,
Lance

> ---
> This can be used as a follow up patch.
> Or feel free to squash it into the 3rd patch.
> 
> kernel/panic.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 12a10e17ab4a..d3907fd95d72 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -122,10 +122,15 @@ static int proc_taint(const struct ctl_table *table, int write,
>   	return err;
>   }
>   
> +static void panic_print_deprecated(void)
> +{
> +	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
> +}
> +
>   static int sysctl_panic_print_handler(const struct ctl_table *table, int write,
>   			   void *buffer, size_t *lenp, loff_t *ppos)
>   {
> -	pr_info_once("Kernel: 'panic_print' sysctl interface will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
> +	panic_print_deprecated();
>   	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
>   }
>   
> @@ -944,13 +949,13 @@ core_param(panic_console_replay, panic_console_replay, bool, 0644);
>   
>   static int panic_print_set(const char *val, const struct kernel_param *kp)
>   {
> -	pr_info_once("Kernel: 'panic_print' parameter will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
> +	panic_print_deprecated();
>   	return  param_set_ulong(val, kp);
>   }
>   
>   static int panic_print_get(char *val, const struct kernel_param *kp)
>   {
> -	pr_info_once("Kernel: 'panic_print' parameter will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
> +	panic_print_deprecated();
>   	return  param_get_ulong(val, kp);
>   }
>   


