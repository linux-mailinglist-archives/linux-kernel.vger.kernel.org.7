Return-Path: <linux-kernel+bounces-887068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED82C3722B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B211884581
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182033385A0;
	Wed,  5 Nov 2025 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqsEtYSW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB1246BC6;
	Wed,  5 Nov 2025 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364357; cv=none; b=fzI2bKWZTmsvSXEy0RO2ulkuzp77lmk5jmM2sMF86lKlLxuDZ+pmrAOV8Pp5pN38iDIdJjNIzyvpfHxuJh5uo3NsGo3wvpWBDKvOOSgpsPYa1tae0MYcjghv3YwgF3QC+8wKUbGSj7Eu9b6jZZASz92eVzb5uglaqqblCF5n5kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364357; c=relaxed/simple;
	bh=bnh3/CAPolVJG3UKOT5bLfJBBm8bDPtW71CYPwpR/mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1hldut+Cq0Iwdw4p+UUsVm6zVjkdk9aXooiXxvZNuGsbVPddFduRks9jV/ddOrMnC6u+vn/ou2kdOvVWSR2CHig5Num0TNV4llz5ofw3fGyhJSyIhKJWowdrNkp+Zeeyy8s95auX9097TF9dYbVzPdEJdftg2b7P2W0wF+gMO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqsEtYSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1058C4CEF5;
	Wed,  5 Nov 2025 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762364357;
	bh=bnh3/CAPolVJG3UKOT5bLfJBBm8bDPtW71CYPwpR/mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqsEtYSWwRoLiOeSsx3jWqVxakKTAiqjHt3pYO+HqWKIOgMb8Yv//+Q4+L72UVBBh
	 3y5NxBtKZHptCNufrfu4o+4y0RITkyywqH4qoGrzfzjTs58y2KKkTJcQKKU5RGWe0e
	 teyXwwpyWA7Vp3b3rCKTXj+TLa6cPruHE69TBxiMprtcD2sV2VuhNzG685aYPXuj8n
	 qOBGvBKiDh1AKxQ3F7/O4eUnz2HDhRzxyKnl3EzGswJndnPzAImRIu8a1Su0tLd2Or
	 rmpOjTcW7kuYuRDkgB+kGV1av2uWHZ+9vPbiHvs75FsEuC/i0MN8b6hImRNqw+2m97
	 gtxMrrog8iW6g==
Date: Wed, 5 Nov 2025 19:39:09 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: extend file entry in KHO to include
 subdirectories
Message-ID: <aQuLvVjH12g7L-fY@kernel.org>
References: <20251104143238.119803-1-lukas.bulwahn@redhat.com>
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

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

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

-- 
Sincerely yours,
Mike.

