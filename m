Return-Path: <linux-kernel+bounces-858803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 051F8BEBE29
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A68093534AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CB12D5A13;
	Fri, 17 Oct 2025 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4eeOI3+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D82C21F0;
	Fri, 17 Oct 2025 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739009; cv=none; b=bOKMEkXlkcSSEm6/BiJys2TH+G5jBq/M5Ectic0JlbpFHzV6UnW0eYqaYvagRR2lYfgKMK/dGLRpft3QwbGbEyrpaiue5hmVpjovi0KGtNaDjYgxGZqwi1NErxzwcnQRS1xWX/75xAespiL8zBb97p20Yy4OLZ+vLSKYOCNTEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739009; c=relaxed/simple;
	bh=x1z347hMxixZcSBEbBjk9C/HpdFUHWI0+Gy1yWvmKXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGnY/hri5oRV/RAsupSbMrYBVUnd3X4HIb1EbjEJfswQGyadQ4OZgJ1PxjIIFllhIKvibH0NC2Y8JojbkpDBk9D+3YG02zaTavtmk8bZTDNqVYscWuNqLk98i7yJsgWeY+XsvFGSBVaORl9v9JpIop3aBBY8gGtn+kc2JKkEPFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4eeOI3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FD4C4CEE7;
	Fri, 17 Oct 2025 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760739007;
	bh=x1z347hMxixZcSBEbBjk9C/HpdFUHWI0+Gy1yWvmKXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4eeOI3+X/mGlQVsVMVkmdFUflM5mP2guyML6aVLY3EBQEFCCWu8Ov9JztYn2tVEB
	 Sg6cR9qiMX9ME/mN5jdEO+SyCzx3754nU8GRv1gktL3WcW0Zcc8gMRca/bfR6UHtWj
	 HSYYQswg9H/ogP7Q16l6TV/bZtI6Hx6SdI8GKBstnS7O6KcJeOp+KzQrYtFmOf+w6K
	 7eba0JFMiBAA9FeK8xcWj8w6L9drrjvcFHYpM8Nh9oigsw4mC0OFJ9KWwDZZl30NOV
	 2BmwcUJVrvykMquaUiMD6fHExrIV1Cyb5yhSkuE0qvdBSCwG2ansPRqB6POQoAeac/
	 ZgmTEMGGm/AjQ==
Date: Fri, 17 Oct 2025 22:10:06 +0000
From: Wei Liu <wei.liu@kernel.org>
To: longli@linux.microsoft.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [PATCH] Hyper-V: add myself as maintainer
Message-ID: <20251017221006.GB614927@liuwe-devbox-debian-v2.local>
References: <1760738294-32142-1-git-send-email-longli@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1760738294-32142-1-git-send-email-longli@linux.microsoft.com>

On Fri, Oct 17, 2025 at 02:58:14PM -0700, longli@linux.microsoft.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Also include MANA RDMA driver in the Hyper-V maintained list.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

I changed the subject to "MAINTAINERS: Add Long Li as a Hyper-V maintainer".

Applied to hyperv-next.

Wei

