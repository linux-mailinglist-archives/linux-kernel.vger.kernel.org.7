Return-Path: <linux-kernel+bounces-855377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B65ADBE10D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8226E4E24EB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F6031690E;
	Wed, 15 Oct 2025 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWU8nnuZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA58D1E285A;
	Wed, 15 Oct 2025 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571764; cv=none; b=r7Wxgh217IoO8VWWYdPoVqRNhExTY/sGB5ccR6nHaY69frzGFka9PA7+gwjvf/6801PwaeC0WhNa9kV8ITL/DzRf9feZ21BRtG7nO7XyNC/GywbMfFiBJwJ+amFJ/pHBUnlm1EoYChyb/NGEuuGV7E5O7teLze/MBdnmNDF5WjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571764; c=relaxed/simple;
	bh=fqb6FMuiy4SxNH5DzlK/l0sRcH4fE4DqcqbhrH9yIwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELjqOSmFmGGYsLi5Aho1/cIctu9JxCs9RzXJi7zf6dQwjoBMMKaOTR5HTQAZjhxfAqJ9hldLESvWcbbOL92PoCwoFNxrk1ihVHc6RrtwuBMuH+Bqy0n6oHlYC3Wzn3qYRJee4DwomEuTmi4KTrlYq/cNJ0xOMd5jH1Ta+s5EEBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWU8nnuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46B7C4CEF8;
	Wed, 15 Oct 2025 23:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760571764;
	bh=fqb6FMuiy4SxNH5DzlK/l0sRcH4fE4DqcqbhrH9yIwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWU8nnuZAbpjQeFDJe+tuZ4zK4ie91zzEzCEuJ7Ni35qLpdPEAXaVN90BCbiWUbfT
	 i1gqQ/VUCK0m9PiSpZAelB8xK1zGyX4lWtiDez8uTemwa9kaB0AQRkWHIuHzsV0CLx
	 hy23kl3XV84lG9O2UlsUoVe331p9MAknomoFTQHiH7FDV1PzzVnRYaIrfa8zbYmNuC
	 MfNFnLfQ1eQbMIp0YU60hsaiOpidSpLqSmTklzTHBBEJ4jeXuYlaTkX8iK6TmwVDhA
	 tHphSKBtPNWV6ll4guQXCzNMgSa/LnbQrx7XWOGWbsqp0+wwSV8i07OgGX+ahS7dCQ
	 Cp9jVZB0L4P/w==
Date: Wed, 15 Oct 2025 16:42:42 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Balbir Singh <sblbir@amazon.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: clarify PR_SPEC_L1D_FLUSH
Message-ID: <z5zeptd2yij7e435u4xgdqsvnqf6hwjkwixajlh3u4nggp6gej@ej743d4adbb3>
References: <20251015-l1d-flush-doc-v1-0-f8cefea3f2f2@google.com>
 <20251015-l1d-flush-doc-v1-1-f8cefea3f2f2@google.com>
 <202510151438.DA62BB421@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202510151438.DA62BB421@keescook>

On Wed, Oct 15, 2025 at 02:41:18PM -0700, Kees Cook wrote:
> On Wed, Oct 15, 2025 at 05:02:05PM +0000, Brendan Jackman wrote:
> > For PR_SPEC_STORE_BYPASS and PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE
> > means "disable the speculation bug" i.e. "enable the mitigation".
> > 
> > For PR_SPEC_L1D_FLUSH, PR_SPEC_DISABLE means "disable the mitigation".
> > This is not obvious, so document it.
> 
> The only thing I can find in Debian Code Search that actually uses
> PR_SPEC_L1D_FLUSH is stress-ng, and it literally just toggles it before
> restoring it:
> https://sources.debian.org/src/stress-ng/0.19.05-1/stress-prctl.c?hl=893#L893
> 
> I wonder if we should just fix the prctl to match the existing
> behaviors?

This feature has existed for almost 5 years, I don't think we can just
reverse the functionality like that?  There could be proprietary users
out there (e.g., cloud companies).

-- 
Josh

