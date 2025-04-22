Return-Path: <linux-kernel+bounces-615108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16659A977FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 22:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D116D3AE52A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 20:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8DC2DAF6E;
	Tue, 22 Apr 2025 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIK5RtJT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5FA2D29AB;
	Tue, 22 Apr 2025 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354933; cv=none; b=uq/ZvKX8AyW77e0I+qCSPg0BPrNuPNDDIYX/a33RpDFYLKlLFiO1j+6sWgHBoyUKJcuylZdYNNUpFYwICiiMPuTOwQjXXckH1oHCFNKnVyzY1Z3ijfGntF0ddGNa8kQt+lAj6YDflkwM7hDNm4dYugH06mPX+iE+XrKMptaLWfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354933; c=relaxed/simple;
	bh=XiHZ6WMBQhXpFYTCsfBy+mcTPXtx1RxkDLOlWiiyxVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7R23HbuSq8LwFJdrf/q0IRK0IkdBCxIfs/42jxU/jCLCLwSs3sAuVqayqTxaohQwAg2JMTnN1LCk1/rEKg4NLF9cIJmJ6gkjefoz5Rhc8EU585yCN4NyqnYerfWT7IAHCQnlBy0QEhhn/Jh2EvmGnz8GBSgHF9PoxmQn2qeBQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIK5RtJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36F4C4CEE9;
	Tue, 22 Apr 2025 20:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745354931;
	bh=XiHZ6WMBQhXpFYTCsfBy+mcTPXtx1RxkDLOlWiiyxVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bIK5RtJTZRxYnLmobdh91041ZSb2+a40MYm8s1dKTDd4MErLiB6YK7uJULrOtJO18
	 rXvQqn+GwIc7pK08y9WHWemMdc5YZLtHxEfH1q7lSq1lwXVPsOUqotQjQ1Mlic2eI1
	 tyYbnx4Hr8I9EaUlN8jM2hUR6SwLX/tL6Hr6jRUrjVb+hzdgpEwxqc/7TT1mkF5+XH
	 TnLLLwoRJxBWc5hDM9X6kOnyzXgt1KqRtEbnSetjRe7bKEgJxpgMNhbgA2R02XiGMi
	 l2m5yiwRrRqmFFEuxo4mwP/x3BLYEdQpyZt6D6qL98BgagwatROaSUBjiW+dNK0nSF
	 nOesdNYp089aQ==
Date: Tue, 22 Apr 2025 13:48:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of Linus' tree
Message-ID: <20250422204847.GA670608@ax162>
References: <20250422204718.0b4e3f81@canb.auug.org.au>
 <CAHk-=wjsMVpEvwq=+wAx20RWe_25LDoiMd34Msd4Mrww_-Z3Fw@mail.gmail.com>
 <54c5930c-4006-4af9-8870-5d887bae7ac1@t-8ch.de>
 <CAHk-=whv79F+zTKPa3yygTWnC+z9gRtPOdj_aBegWXtWB3D9=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whv79F+zTKPa3yygTWnC+z9gRtPOdj_aBegWXtWB3D9=A@mail.gmail.com>

On Tue, Apr 22, 2025 at 11:20:21AM -0700, Linus Torvalds wrote:
> Heh. We have several other cases of that "disable warning" pattern
> that does *not* use that cc-disable-warning thing.
> 
> In fact, right next to the new unterminated-string-initialization case
> (just a couple of lines above it), we have a
> 
>    $(call cc-option, -Wno-stringop-overflow)
> 
> thing, along with several cases in loongarch and riscv.
> 
> So they are presumably _also_ broken, but perhaps just happened to
> silently work due to compiler versions (and that stringop-overflow
> case is gated by a config option that might also have hidden it from
> people).

Indeed, there were a couple of patches that flew by recently fixing some
of those instances for that reason but I guess Masahiro may have missed
them:

https://lore.kernel.org/10b1ebd8-5d32-41a2-9454-1b40e98d5187@suse.com/
https://lore.kernel.org/4b19fae4-ba5d-45b6-ae4a-8b59c178f529@suse.com/

Cheers,
Nathan

