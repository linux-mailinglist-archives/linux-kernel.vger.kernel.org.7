Return-Path: <linux-kernel+bounces-778957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C385B2ED28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2355E2D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BCE20E6E2;
	Thu, 21 Aug 2025 04:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CvDA5XY4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A6347C7;
	Thu, 21 Aug 2025 04:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755751680; cv=none; b=WL01BL5KKljM9Qam8j8iSuu19c8B1JrxNggOKB7Wohsu0iIGfbFQQYR7BoCeRAYDWJr39hpXlVUnn519HPJ2U5j2dO3ZuAug+dZzQ9rmaK2fLUcJwQZnH9W/uEQrMCsHeJtIJfH8QQzHmTmRXWhvgVnugBSmgZYlyKjN+rLTxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755751680; c=relaxed/simple;
	bh=s9beO2CbS4BGY4VluAibPH2xkOmXO0+zZTnWtdDIyoI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mHib93To+qTHFcsjI1vQxbR+gjj8zyDDsZOJFrQ7lxnVKs03WDZs+E3zOqbsJzQ8RpJldZy4j1Bxei4KqaSJ9vuLHpCQsObtu7C0RWJvV5BiZX9UQIJ27Q0QQQo6uEjvP2FD9mApXLs7mn8fkjKgD4yaLGkcI7wGHNXDKmWKewQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CvDA5XY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FCEC4CEF4;
	Thu, 21 Aug 2025 04:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755751678;
	bh=s9beO2CbS4BGY4VluAibPH2xkOmXO0+zZTnWtdDIyoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CvDA5XY4aN67rGgi2OSdyrOpEVOn7NxmxoH2uDjIDpSs8anlTLBTKbRMz/iHchRzO
	 W6HmgQ39fV65HHE0el8KyLHwXTIPh7kS0RAZieQaiD55oz40iINm/BZdX57b3cSsit
	 soo/PqlghcS5IlzQDrxA+Pkb6MtHp/z7ntLDFpzo=
Date: Wed, 20 Aug 2025 21:47:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Brian Mak <makb@juniper.net>
Cc: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Alexander
 Graf <graf@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Rob
 Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 <x86@kernel.org>, <kexec@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] kexec: Add KEXEC_FILE_NO_CMA as a legal flag
Message-Id: <20250820214756.5c7b551e4723d9f0b5dd55e3@linux-foundation.org>
In-Reply-To: <20250805211527.122367-2-makb@juniper.net>
References: <20250805211527.122367-1-makb@juniper.net>
	<20250805211527.122367-2-makb@juniper.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Aug 2025 14:15:26 -0700 Brian Mak <makb@juniper.net> wrote:

> Commit 07d24902977e ("kexec: enable CMA based contiguous allocation")
> introduces logic to use CMA-based allocation in kexec by default. As
> part of the changes, it introduces a kexec_file_load flag to disable the
> use of CMA allocations from userspace. However, this flag is broken
> since it is missing from the list of legal flags for kexec_file_load.
> kexec_file_load returns EINVAL when attempting to use the flag.
> 
> Fix this by adding the KEXEC_FILE_NO_CMA flag to the list of legal flags
> for kexec_file_load.
> 
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")

A description of the userspace-visible runtime effects of this bug
would be very helpful, please.  A lot more than "is broken"!

Also, could we please have some reviewer input on this change?

Thanks.

> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -460,7 +460,8 @@ bool kexec_load_permitted(int kexec_image_type);
>  
>  /* List of defined/legal kexec file flags */
>  #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
> -				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG)
> +				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG | \
> +				 KEXEC_FILE_NO_CMA)
>  
>  /* flag to track if kexec reboot is in progress */
>  extern bool kexec_in_progress;
> -- 
> 2.25.1
> 

