Return-Path: <linux-kernel+bounces-887067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D57C37204
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F3E1883A4D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1733858E;
	Wed,  5 Nov 2025 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwssDAbz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723DC1A9F82
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364239; cv=none; b=OrIl9VuSi4LuF3Ufyp3hoFXXZuNgWhXit/TdywQff0WoYRkVi+QAMPQUlD6kji/n/ou4zIKC4/GmCpp6i6YeziSbKILVtXXzhaDv+oD+AfI2dN72RB9E10J3rmzgqXGsPiA3DUDfDmHVe/To0bLNs1dVFCZhKbXJmEx1/6XNnvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364239; c=relaxed/simple;
	bh=oikeBsTkXESg/zQM0VeX21fpP5BX4NjeQ4ImkTAOD5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGjR25LAbkNjF+aDWivge7MZVkW5W7QF3psGGluSmiE+BYt4iplefidiiaIDpFDp0z6qx93SkJhXIK3S/4xU4mOIWN8U5Y2tLCG6IOpmqE8Fvq95F1+hZhAFa2XsEfPVDTTRlBl78oFoeZFSvOaXkMne/7vrWR3PeD1qpeLkZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwssDAbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C02C4CEF5;
	Wed,  5 Nov 2025 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762364238;
	bh=oikeBsTkXESg/zQM0VeX21fpP5BX4NjeQ4ImkTAOD5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FwssDAbz9953tgEm10JYoi4KJCfP6SA6HAnQavrw7zTCAAxZbffzhzNi1qIUHFtYB
	 wktfURi/o17LfLNLdryKQcTkeufo9Aa+Yt+Z1np3CrMVo321ZTgvxxCWVfmLki1ioB
	 ChNFrzDkmWVMpPJbteshSWo352Oe8lIzVbH+Q0ePF02kVWIzYfzquMgYJYdu88LS4k
	 +CXAY85sr37wiOCTIs8Uugg5lhkgSTPGGGIzyqgOSWZoqE1sbFC7xnD6zrTXKn6zxg
	 IHoTiDci/Ni/aU+QDZVvHJ71CB3OFl9+zb8hevZBjPFcpWNvWPXC4agZJQDi2Q9t2P
	 XLtb2qGWIgoQQ==
Date: Wed, 5 Nov 2025 19:37:12 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as a reviewer for KHO
Message-ID: <aQuLSAAy-hfxLVsJ@kernel.org>
References: <20251105102022.18798-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105102022.18798-1-pratyush@kernel.org>

On Wed, Nov 05, 2025 at 11:20:19AM +0100, Pratyush Yadav wrote:
> I have been reviewing most patches for KHO already, and it is easier to
> spot them if I am directly in Cc.
> 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8ee7cb5fe838f..3c85bb0e381fc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13789,6 +13789,7 @@ KEXEC HANDOVER (KHO)
>  M:	Alexander Graf <graf@amazon.com>
>  M:	Mike Rapoport <rppt@kernel.org>
>  M:	Pasha Tatashin <pasha.tatashin@soleen.com>
> +R:	Pratyush Yadav <pratyush@kernel.org>
>  L:	kexec@lists.infradead.org
>  L:	linux-mm@kvack.org
>  S:	Maintained
> 
> base-commit: d25eefc46daf21bd1ebbc699f0ffd7fe11d92296
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

