Return-Path: <linux-kernel+bounces-810713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1751EB51E41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1E63A2FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3342797A9;
	Wed, 10 Sep 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPAOgAbm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC825CC40;
	Wed, 10 Sep 2025 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523012; cv=none; b=QcpLMQt1VwYHHbM7gDgFiQ6oSkGp6OllVx0qj+2KsazkLsXfGXY0SDLIQhVXFeze5k9m9qEIj99iBcmRP7raCtMzFqjvais9gMaCr25UXbkLoDl2NG75rQtugJTKCN7xRkrGApcX5VHgEmeathQLNMBtJmTH/Y8sZuPbKrAKXSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523012; c=relaxed/simple;
	bh=ug5CvfYVPJihh5Zy5QREZIKCevb4x/BKaIGi7u0wAkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJUNJz++1I4yU3mSQwbT3OPsX7Iy6zfLiRU3hfkWp8RRZl7BtDfFk7a6FvrePy8/R/Gg6dhUwuFWrBJbWS21tfxRB3Zz34lAkJgiaXqIEEJ7vfnI5R4dWY9yqK8qwTZdoIoBqiX+o7H8/ObQf6AowhVaWXSjD2W0MoGaS6mC0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPAOgAbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB16C4CEEB;
	Wed, 10 Sep 2025 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757523011;
	bh=ug5CvfYVPJihh5Zy5QREZIKCevb4x/BKaIGi7u0wAkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPAOgAbmybkyYUUePXHpTFbjK4/sSheXD5Cb30bErD6cxup1wf9xVxlmDMRNMwIRT
	 USv2axQrbQ9wY+QTzUewNNHgDwGIdgP0EjSPGNTVuC9d0QkPOrgMA92s+XiOFek6X1
	 PGMz9vUOXTxn0jSQ3m8DaC5UtBYLbIJXCJZ0NwZftg6ovmRECwNzzyDuBU0ehgCApW
	 EEOuiAPzHvdeIAFmWJxQp2PNt2U3wGDVHlH3skZ/ypc4gZkH9N44g0S0cm0zhGw28r
	 TpE4NPHIm94DswLhRiL/EjL0BtfMRvLWNDtU8OlRbNqE+QNkJW4kvmOlj4D7+u+QnS
	 LICDXPxSa2YPw==
Date: Wed, 10 Sep 2025 11:50:10 -0500
From: Rob Herring <robh@kernel.org>
To: Andrey Ryabinin <arbn@yandex-team.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>, James Gowans <jgowans@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Chris Li <chrisl@kernel.org>, Ashish.Kalra@amd.com,
	William Tu <witu@nvidia.com>, David Matlack <dmatlack@google.com>,
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/7] kho: replace KHO FDT with kstate metadata
Message-ID: <20250910165010.GA223810-robh@kernel.org>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-5-arbn@yandex-team.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909201446.13138-5-arbn@yandex-team.com>

On Tue, Sep 09, 2025 at 10:14:39PM +0200, Andrey Ryabinin wrote:
> Store KSTATE physical address & size instead of FDT in kho_data.
> and initialize KSTATE from kho_populate().
> To be able to use FDT in parallel with KSTATE place FDT
> address&size into 'struct kho_fdt' and save/restore it using KSTATE.
> 
> This finishes wiring KSTATE with KHO, making it fully functional.
> 
> Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
> ---
>  arch/x86/include/uapi/asm/setup_data.h |  4 +-
>  arch/x86/kernel/kexec-bzimage64.c      |  6 +--
>  arch/x86/kernel/setup.c                |  3 +-
>  drivers/of/fdt.c                       |  6 +--
>  include/linux/kexec.h                  |  2 +-
>  include/linux/kstate.h                 |  1 +
>  kernel/liveupdate/kexec_handover.c     | 60 +++++++++++++++++++++-----
>  7 files changed, 61 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/setup_data.h b/arch/x86/include/uapi/asm/setup_data.h
> index 2671c4e1b3a0..844f5b93473f 100644
> --- a/arch/x86/include/uapi/asm/setup_data.h
> +++ b/arch/x86/include/uapi/asm/setup_data.h
> @@ -83,8 +83,8 @@ struct ima_setup_data {
>   * Locations of kexec handover metadata
>   */
>  struct kho_data {
> -	__u64 fdt_addr;
> -	__u64 fdt_size;
> +	__u64 kstate_addr;
> +	__u64 kstate_size;
>  	__u64 scratch_addr;
>  	__u64 scratch_size;
>  } __attribute__((packed));

Isn't this part of the ABI which you can't just change.

Rob

