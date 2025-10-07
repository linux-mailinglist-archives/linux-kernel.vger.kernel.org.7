Return-Path: <linux-kernel+bounces-844442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDF1BC1ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0103E2F3C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB7F2E6135;
	Tue,  7 Oct 2025 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+Vo2MQd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFDF2E6106
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850695; cv=none; b=mYXfh0k1xI8mjQ23GTR4X3YvL0pRo/4hla8B24cLq8Vf9dREOVDgt8E1moX+V0wyvyobnlRcJIQ4SxCa9r6bcqu8Z5ZyEDmEu6W4wEJSoJAUiUjRHwfBiA18j6O5wiMsuHIFsqBwGVWV5HozslHZbmkk3J9CrphBFNrkbh7+lHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850695; c=relaxed/simple;
	bh=/CHcWKVMwxgowr8PJiJHIT3nnFTt12BqAWCgkfyXQvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7zlCMEOSF2TdpPIsFph7xuxA6b1/xJcIGhkop78dfdZtxyD2tAS9hvXXqVbzUzg98BsM2EHScjIiir+0T3SxCgvixyKSDCNLRC8zVVbkhTb4/OMBqS3rKRSFKs+120aqr+TMS+C5wUYSGq/uxvjpxknWR90F4D4jrkUyO0imjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+Vo2MQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9D4C4CEF1;
	Tue,  7 Oct 2025 15:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759850695;
	bh=/CHcWKVMwxgowr8PJiJHIT3nnFTt12BqAWCgkfyXQvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+Vo2MQdX5dSNAiQ6Uor40vWtdzViB6enb+fuDFyelNsXOIyyGVPD/ldwvRrVLiRC
	 EhCUI6Gh+QH7dbxAypKi3SZ95y9tJpkDlQV/9YNefV6X+1ddv9ZpqT8pBNnNQpJqnh
	 aMQFb+/X13cL97skxzkf0LRjCSyrrCl0SMI5+yCpKvrAUumnrSkGkyEpxJ4qS/E50j
	 PGKcLTdQCJwEQkG55GAznE6J33qRHZ5quFnqVb1Ltb49zUr5ycDdxn1Jvbj/rdRlOe
	 tKTKXIOwwJryrjBEJlX0qMc9jE+F71FgEO101wZDoBjxMmyz+SkVQl45GW4s80ugaG
	 DHIjtk8mT4lZg==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Carlos Llamas <cmllamas@google.com>
Cc: Kees Cook <kees@kernel.org>,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2] tools headers: kcfi: rename missed CONFIG_CFI_CLANG
Date: Tue,  7 Oct 2025 08:24:51 -0700
Message-Id: <175985068859.4123460.6725896867453722456.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006225148.1636486-1-cmllamas@google.com>
References: <20251006220500.GC3234160@ax162> <20251006225148.1636486-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 06 Oct 2025 22:51:32 +0000, Carlos Llamas wrote:
> Commit 23ef9d439769 ("kcfi: Rename CONFIG_CFI_CLANG to CONFIG_CFI")
> missed one instance of CONFIG_CFI_CLANG. Rename it to match the original
> kernel header. This addresses the following build warning:
> 
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/linux/cfi_types.h include/linux/cfi_types.h
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] tools headers: kcfi: rename missed CONFIG_CFI_CLANG
      https://git.kernel.org/kees/c/b157dd228cf0

Take care,

-- 
Kees Cook


