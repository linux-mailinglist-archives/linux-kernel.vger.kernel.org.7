Return-Path: <linux-kernel+bounces-839645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9128FBB2113
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 01:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D6819C4B3A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 23:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD2529B8C2;
	Wed,  1 Oct 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecRRil3P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683420468D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759361393; cv=none; b=AM5LThzY0m31VfzbdNh9jewoZNmDN8FgKmU3YksEqtYNEjRKiPJ85ojysr2L/yAgWO+3ezzGhmTyGLqvlU1T10iZGqUSwH7d53tc5hdULYcXrr8z5n7DkzFTLhTDsyBYpqMUZaXbmtUKqz4PXON6c6ShKIEnAKF/A5RBZ8qJTRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759361393; c=relaxed/simple;
	bh=617KNU9/aNteQ0j9EEeSrR0h4jvaODyG/9hpeG8wTj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBdURR59MDD1YUpBABMcvgQ1Cwqip8cz5BToa3nR2l0mu+uKhWQyvYjBfJx2/t8zVsrzAEgSSPYu7UK0ants58JFiChNgQmTLulwsNa8Ex7vGYQ0rZoTTJIUY+E/tajkMD3B00b/BE6DPOX7BaJ4x+S/VPH58w+54tBoPFflz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecRRil3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96563C4CEF1;
	Wed,  1 Oct 2025 23:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759361392;
	bh=617KNU9/aNteQ0j9EEeSrR0h4jvaODyG/9hpeG8wTj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecRRil3PqIsR0vQHl/mscr9XQjDmofsTeuiYxUw/Vd7m/D0iO57c/0qNzC8cm2tLU
	 Wb/wzqqq//kIgQTd0i3QZgzn3iccY7KP7VNbZwDQh2JT8Om7CiSyrgIfnqRvcirr30
	 CvRyaK38pyY/MHJxdB842Jb/iaxjsqCqC5mvmywvcqU+kOmbPiHbIFWpY/9V5rW1lu
	 JQ8inLBFsvmFJZYS1juaGiyuBT2cV72tttL9qL73mCqwWOelDV2J+pg2y35kK9aCV+
	 g5KaJKMbL+Q/e8Y/7UOsNBAuqWYf33tRMUHctk3FbO5Meq+DtBzdU+GWTvjGAvcLZp
	 bTdMqTF2p9Vqg==
Date: Wed, 1 Oct 2025 16:29:50 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Dylan Hatch <dylanbhatch@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Weinan Liu <wnliu@google.com>, Naveen N Rao <naveen@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Sathvika Vasireddy <sv@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Let --hacks=jump_label read special sections
 with alts.
Message-ID: <oiq5rp7vmbfav7gus5kv6pytqhzypiw2tzgeyuyi3pootzk4kt@mjkj72xszhe7>
References: <20250923004941.982086-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250923004941.982086-1-dylanbhatch@google.com>

On Tue, Sep 23, 2025 at 12:49:41AM +0000, Dylan Hatch wrote:
> The objtool command line 'objtool --hacks=jump_label foo.o' on its own
> should be expected to rewrite jump labels to NOPs. This means the
> add_special_section_alts() code path needs to run when only this option
> is provided.
> 
> This is mainly relevant in certain debugging situations, but could
> potentially also fix kernel builds in which objtool is run with
> --hacks=jump_label but without --orc, --stackval, --uaccess, or
> --hacks=noinstr.
> 
> Fixes: de6fbcedf5ab ("objtool: Read special sections with alts only when specific options are selected")
> Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

Queued, thanks!

-- 
Josh

