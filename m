Return-Path: <linux-kernel+bounces-825104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E4FB8AF86
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F441B287C8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF835260588;
	Fri, 19 Sep 2025 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3cUVJEJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369B725D540
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307466; cv=none; b=MTz3yHgltROtDdShJhNZbvCj8iPP2bEeqpu2EZTSO6q0a7cBCjqDrAdWVvIPz7cRCz330+i93TNAfAVXQ5p+WhdhVP4zpHhqETrchvIcGF53qlIgBTqoCckohLp6X2IKSfPHQDsdHdvPFVnUiLTEuiHKb3pfpvEG7wCMybidSOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307466; c=relaxed/simple;
	bh=TvNct0puZkUduc5sUbES816mFOXImptqyANagH2X/rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYlJtULaBsMEmhmflifAMepXSbj/g3NYnfVlQpkYRazEaAQtZs00aEV0IdWoyIaPe5hukKsRIYk4NXjXVw2xsaLfZymz/kW1f8deZAzdw7vx7C68gEymYc1JKpgVXHehpyxYoLeEazqdaMCXEudor5Jt8FhVNdDjkHyj/wl00MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3cUVJEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44870C4CEF9;
	Fri, 19 Sep 2025 18:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758307464;
	bh=TvNct0puZkUduc5sUbES816mFOXImptqyANagH2X/rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3cUVJEJqWFBU7ww0WmUJbD83nfjVDNdDRJtPJeu4fS51UMblHAO+y1IiOgLm2w/t
	 TUbpudm+KVhuUZBN44nNp+D8YU57QIok0SMUNjlWzyovX6d8n7Fv4r5utvbTcFzm80
	 wsREd6wbVor91Lf68a/PZROm7ttTQdnfeGEjXJ3POhix1+nAinVdjzdkxQC+oRli2s
	 VhBqmPEGC1qZJkDMLyBb2Z8h32wupJupI0gO+bMuua+R2hebikzvZwbHAWb/jmc24+
	 3yf3+/nPuXtNraKM+5mpi0YKhXJ3duaJ7nikdVjjcFh09+FOmsu5zGh8YRQrhL79kt
	 5Dw3rKMVLZaBA==
Date: Fri, 19 Sep 2025 19:44:19 +0100
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: catalin.marinas@arm.com, akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, dev.jain@arm.com,
	scott@os.amperecomputing.com, cl@gentwo.org,
	Yang Shi <yang@os.amperecomputing.com>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v8 0/5] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
Message-ID: <aM2kg49jBia4VKYr@willie-the-truck>
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <175822779944.710258.10028837182267037801.b4-ty@kernel.org>
 <fc43aa07-d4ad-47d5-8381-61d4a9b8c467@arm.com>
 <aM0-FQlepoxxGkRd@willie-the-truck>
 <ceaf604f-8ad7-4e19-812e-7eeace10d835@arm.com>
 <aM1E34lRjKg7nlRu@willie-the-truck>
 <38fa4717-9105-4bca-a2cd-914afc109570@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38fa4717-9105-4bca-a2cd-914afc109570@arm.com>

On Fri, Sep 19, 2025 at 01:00:49PM +0100, Ryan Roberts wrote:
> On 19/09/2025 12:56, Will Deacon wrote:
> > So how about we:
> > 
> >   - Remove X4 from the list
> >   - I try harder to apply your patch for secondary CPUs...
> >   - ... if I fail, we can apply it next time around
> > 
> > Sound reasonable?
> 
> Yeah that works for me. Cheers!

So after all that, the conflict was straightforward once I sat down and
looked at it properly.

Please can you check for-next/core? I forcefully triggered the
repainting path in qemu and it booted without any problems.

Will

