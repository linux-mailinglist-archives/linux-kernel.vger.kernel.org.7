Return-Path: <linux-kernel+bounces-834610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AF6BA5157
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F711C0221B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090C228504C;
	Fri, 26 Sep 2025 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXC68ciZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B929927FB34;
	Fri, 26 Sep 2025 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919217; cv=none; b=rxoxMIFHyD72qbeLN0A10F85oztlrBUlDLllBH8u4EbDQwpU2HlYCa6wSVElk8Y5CXiOSHh5fl+r6AG8cBQCzVAKgs19+vtUHvDRH8sCCkdMAUcwWyR9ZUuxgHj0h99pA5uPgdPqHndv4PU5UQr5cecWU08BcltwB45eunRBs0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919217; c=relaxed/simple;
	bh=qvpmGn04f1nQWbNS/j/1Di7h/FR8OeiFalN5r9o2bW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4/6/b1a14Iye5Vjj6VOgNnjHqnvobcGPYCH9vd9HdwotIl8cO8p/IT8T6s4DfC8oblBVQc80zAKAQ4IX4DCYOHqt+m1MyziPUNFYarO0wpBS/PZ6od/gvBM7PUpJ4Q+ZJpU7wU8GETKm4u+l5P27X8I/bgXHb6+ozX9lP7eMLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXC68ciZ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758919216; x=1790455216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qvpmGn04f1nQWbNS/j/1Di7h/FR8OeiFalN5r9o2bW4=;
  b=mXC68ciZrstJtUF0tM2EslgkpLYk+blxxM3EzXYNO6fMGAtES+6pwU23
   nckpuVC07P4HCP0mhVEWgTMIe4XtoiJSMs3dXCgKUu3+rJkVUtKPPMZui
   1XNQSXVA5U2w3iI8NTKNjBecCWMOJBPe8MshLhLbrXbnpcBhpdPia/pb+
   bqcqj0YZgLm3wtjNukhqxljtDBEhfQ+8B5aFVFuafh0FpP3AY/NQTeahj
   ZAsACcODb9XgbjE46yxLjZcCkv1FaQFEGH9lodJgTINQPVfftW+GqF8KM
   IsbTP5cnTxXo9l22TL/NuouN8p/8LVyLjcdpLMv8/wRWZbGFy31MNoBLy
   g==;
X-CSE-ConnectionGUID: HzvUCzi+SYqpsId0ZYwJEw==
X-CSE-MsgGUID: 3xExbICWSu6s7WOUg1r+mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="48818955"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="48818955"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 13:40:12 -0700
X-CSE-ConnectionGUID: rHFQlC2hTP6FsGYW+b1oWQ==
X-CSE-MsgGUID: lzNN5vchQPW2D11VF2GEBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="177759461"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.69]) ([10.125.109.69])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 13:40:11 -0700
Message-ID: <a9c29f6a-6b32-457c-8e9d-a950a992b506@intel.com>
Date: Fri, 26 Sep 2025 13:40:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: admin-guide: Correct spelling of
 "userspace"
To: Akiyoshi Kurita <weibu@redadmin.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shannon Nelson <sln@onemain.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org
References: <20250926190019.41788-1-weibu@redadmin.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250926190019.41788-1-weibu@redadmin.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/26/25 12:00 PM, Akiyoshi Kurita wrote:
> The term "userspace" should be a single word. Fix the typo
> "userpace" accordingly.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/admin-guide/tainted-kernels.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index a0cc017e4424..ed1f8f1e86c5 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -186,6 +186,6 @@ More detailed explanation for tainting
>  
>   18) ``N`` if an in-kernel test, such as a KUnit test, has been run.
>  
> - 19) ``J`` if userpace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
> + 19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
>       to use the devices debugging features. Device debugging features could
>       cause the device to malfunction in undefined ways.


