Return-Path: <linux-kernel+bounces-762073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34520B201D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42AF3A4604
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4F42DAFCF;
	Mon, 11 Aug 2025 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bay333fi"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77642DAFC0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900949; cv=none; b=YHe5rDxXMc4xidT9gLUPUOhk8S8yujQjnEHcRnRAsIZULwkr2MihdOIzNxh7/ekwgRiWKAEehGoHId0zXl43SrhHEJivWN568dJp7x16kRncjFlxLj4dLeVCJqbThFQ2m2uk3EvBAlCvMUtHX9bAHgg7yGgwy/7mRMizaOYtCw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900949; c=relaxed/simple;
	bh=8OUPpbyUH6iQW0ZzC61xGzIe1Y5BAJjUtkW5uqaIVLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBwAH9cvmkiUTAkTYLT9jcON9N4hfNIUSUc2eVML0Txf42ggckwoDuQbxjZVWejTqmzTG55YeYrCIP3590p8ZHQxg4m7IMkmsv93qJDvPqv1ijH0wl5GV95FYBWGHLg9Fi59T+AqynDM1IpU3OHZhcJ14KfSdB3PjmgRHHZAh+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bay333fi; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d28f89df-5a12-4b81-99e3-09bb0cbbf9aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754900944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pXNPgEvuSkKgSyzTfz814oCLHL3y4lUmjv8OC/1b9/M=;
	b=Bay333fi6JdycsDQ6S6uBDGaIGmchlM+9jubDPCD4UNyWnlK87+OagsWIqbbtAme4JyGgo
	HvuTLVJe8y4jb/RKMzrAf2ACdh9pqOS++cXAN/Q7+LB+CHev03u0sP6kmjgCWBY/mad38g
	2tYiyHtUmouxkkOZ1VDCnZ9wzXzti4k=
Date: Mon, 11 Aug 2025 16:28:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Documentation/printf: Use literal fwnode_handle
Content-Language: en-US
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <07262c55e82fc4a3e3dbe7c45713b14955271e7f.1754552156.git.geert+renesas@glider.be>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <07262c55e82fc4a3e3dbe7c45713b14955271e7f.1754552156.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/8/7 15:36, Geert Uytterhoeven wrote:
> When looking for fwnode_handle in the printk format documentation, it is
> only found in the Chinese translation:
>
>      $ git grep fwnode_handle -- Documentation/*printk-formats.rst
>      Documentation/translations/zh_CN/core-api/printk-formats.rst:用于打印fwnode_handles的消息。默认情况下是打印完整的节点名称，包括路径。
>
> This happens because the original documentation talks about "fwnode
> handles", without mentioning the actual type name.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   Documentation/core-api/printk-formats.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index 4b7f3646ec6ce028..7f2f11b482865175 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -521,7 +521,7 @@ Fwnode handles
>   
>   	%pfw[fP]
>   
> -For printing information on fwnode handles. The default is to print the full
> +For printing information on an fwnode_handle. The default is to print the full
>   node name, including the path. The modifiers are functionally equivalent to
>   %pOF above.
>   

Thanks for the patch.

After apply this patch, test result:

#  git grep fwnode_handle -- Documentation/*printk-formats.rst
Documentation/core-api/printk-formats.rst:For printing information on an 
fwnode_handle. The default is to print the full
Documentation/translations/zh_CN/core-api/printk-formats.rst:用于打印fwnode_handles的消息。默认情况下是
打印完整的节点名称，包括路径。
#

Tested-by: Kunwu Chan <kunwu.chan@linux.dev>

Reviewed-by: Kunwu Chan <kunwu.chan@linux.dev>


-- 
Thanks,
        Kunwu Chan.


