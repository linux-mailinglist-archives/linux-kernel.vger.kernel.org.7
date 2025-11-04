Return-Path: <linux-kernel+bounces-885040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A9BC31CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534F2189B979
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118E256C70;
	Tue,  4 Nov 2025 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgXbrbaw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089C2512EE;
	Tue,  4 Nov 2025 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269578; cv=none; b=UTcbTYucOnldsGOvOrB/1j+h5v3SHo3IEbcZD15qnxf6mrrYHnEg+teqEaVaQjMzXnbRkfCZAm0oLmz/LaCBQF8rY696733/iMeKSYtu5p7c8dGUisLUFrKXaOUK8Vj5MBcbsYmpcLpSvQS7YzOI+HuqY9QQdwoujs5MIltLfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269578; c=relaxed/simple;
	bh=k4PWSdB9JPNF7dXkmlfgfPVWmRMPLaoLYeVYkmcgX84=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i0lc4zPEd/Q5tBI5zhqTZ1nvXZutgR5sEBJzrBMzg9XhNNFkEG2Zyc1+/RSj1dHlGPESZC+iFczY8BZRDWvsC0UuwRbqJkIOAW1yfM9nQhbaE8cPCMsr8bQZV524oweEWpWuo/5fepr/gAHbJlGhsqoP2+kfzQi330GAyEuD2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgXbrbaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1229C4CEF7;
	Tue,  4 Nov 2025 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762269577;
	bh=k4PWSdB9JPNF7dXkmlfgfPVWmRMPLaoLYeVYkmcgX84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YgXbrbawniJRA9mTXZfrvv5psDoKlD7p+oObyOArVrlKfTcatyvO2l4qVYgABbbWQ
	 GJBxUFaKXE+wRxy5wEYzPDSe6eZMjxsxNBSdF13Y7XI3F7C13mzlAdwnGAc8pjtrN3
	 lBoeGx3EkOaCwkEPrq2RhAOnMeVe0NyNj4/h2OLTknI6WkeEgdMCZvAelv7S118XkH
	 vOUgDqW5UXLG2gBBloPAiik4dkDFfJxdCriAO+w28cllo2sIUcr0SbXz4FZPTsGG+f
	 kuWp5LWxjzuZNuZBjZul4Qk9XB7BlWnPz149vmNlPdlFQrjc2c22oyXCA5nb+5/IV8
	 rKXN9Uac8PHlA==
Date: Tue, 4 Nov 2025 09:19:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: extend file entry in KHO to include
 subdirectories
Message-ID: <20251104151936.GA1857569@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104143238.119803-1-lukas.bulwahn@redhat.com>

On Tue, Nov 04, 2025 at 03:32:38PM +0100, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 3498209ff64e ("Documentation: add documentation for KHO") adds the
> file entry for 'Documentation/core-api/kho/*'. The asterisk in the end
> means that all files in kho are included, but not files in its
> subdirectories below.

Add blank line between paragraphs as you did below.

> Hence, the files under Documentation/core-api/kho/bindings/ are not
> considered part of KHO, and get_maintainers.pl does not necessarily add the
> KHO maintainers to the recipients of patches to those files. Probably, this
> is not intended, though, and it was simply an oversight of the detailed
> semantics of such file entries.
> 
> Make the file entry to include the subdirectories of
> Documentation/core-api/kho/.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06ff926c5331..499b52d7793f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13836,7 +13836,7 @@ L:	kexec@lists.infradead.org
>  L:	linux-mm@kvack.org
>  S:	Maintained
>  F:	Documentation/admin-guide/mm/kho.rst
> -F:	Documentation/core-api/kho/*
> +F:	Documentation/core-api/kho/
>  F:	include/linux/kexec_handover.h
>  F:	kernel/kexec_handover.c
>  F:	tools/testing/selftests/kho/
> -- 
> 2.51.1
> 

