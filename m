Return-Path: <linux-kernel+bounces-725416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE41AFFECC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871C61C86429
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578802D836D;
	Thu, 10 Jul 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDwPg+Zc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42612D6417;
	Thu, 10 Jul 2025 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142315; cv=none; b=sSDK1fZ2ZFkb9e8RcRhebVaCfDLxyKWbdzVIMP16vyJUONlzxh9Sv6YhYBqIoonO0cWmHXYB2oyy//ociw44tEmuC9MUggyz1gdihjljyDzdxjLTlMLbYgNm9jjTDdzMcqiNQ6zSv6vndC7T6MDmkfPkgcI7IA+arKZjCskDPyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142315; c=relaxed/simple;
	bh=sFjsKP5Kq+l7KUXAo36cOhptVGEGd+oXiRAsy4MAfYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ho+XEecCvUR1oYhbBgiU0Z+TiDdX3dwAqGYw2SFR6CpLdbl5hk4oxBNU1Le94a3V9nPDX31pjUrJ6T664VxmSXLIi9XMSIfFerHtxfzlUqySbHQnUQofkNtQhtMV0ki6LDbV9oksohrBuww4o0iX28CulYsta1zYFLm28CJ4iEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDwPg+Zc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2B6C4CEE3;
	Thu, 10 Jul 2025 10:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752142313;
	bh=sFjsKP5Kq+l7KUXAo36cOhptVGEGd+oXiRAsy4MAfYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDwPg+ZcvbYBu62jE1I2xJ+Ra8QPGDdZcJnn7uAxHUWWbh513ghHaAKeqeXbGAdqt
	 D0cjV+zuglkbRzrc2JDXwt1XmKtbOXgBOfXhjiOtns4Y08Jg74R4ImR35vhjg8QWn6
	 dYAlZXTa4PLNbxCddpNr1UUZg25WhhP+XwACJFbSrDimsVBH+row6sLlUzUl8L7Jso
	 DQlui7fisLyXECnmCjRSmUiMdamJlAZ+frgoiQk6oUo0+2T6By+heW1httL8pDLCs6
	 CiEN9QXTSKDhrTSF6Wbz4WVANhaMRPApj7DMQfzr0hSgZ3NKhrNBIebxY/O5kSSy9M
	 oPm2WdhBxXpfQ==
Date: Thu, 10 Jul 2025 13:11:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2 1/1] mm/hmm: Move pmd_to_hmm_pfn_flags() to the
 respective #ifdeffery
Message-ID: <20250710101148.GJ592765@unreal>
References: <20250710082403.664093-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710082403.664093-1-andriy.shevchenko@linux.intel.com>

On Thu, Jul 10, 2025 at 11:23:53AM +0300, Andy Shevchenko wrote:
> When pmd_to_hmm_pfn_flags() is unused, it prevents kernel builds with clang,
> `make W=1` and CONFIG_TRANSPARENT_HUGEPAGE=n:
> 
>   mm/hmm.c:186:29: warning: unused function 'pmd_to_hmm_pfn_flags' [-Wunused-function]
> 
> Fix this by moving the function to the respective existing ifdeffery
> for its the only user.
> 
> See also:
> 
>   6863f5643dd7 ("kbuild: allow Clang to find unused static inline functions for W=1 build")
> 
> Fixes: 9d3973d60f0a ("mm/hmm: cleanup the hmm_vma_handle_pmd stub")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

