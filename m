Return-Path: <linux-kernel+bounces-890695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F344C40AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438EA564A2C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EDB329C59;
	Fri,  7 Nov 2025 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxplMiDs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED3432E142
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530837; cv=none; b=g46dQwS6JRO7NCF/Z3yM4fT2OvcAz50Z5oJ59h8h14lbEUJbKbGc81l6Y4/nggyM+P4UfkIrS6sxBEEbYTuxltsLrItW6FP8BJUcJDAW4xshMzBr/d3uw/BevQJMSGGE921AerzOKyCNHFnOWfPIiOUj/mt118JFpI1M37NsQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530837; c=relaxed/simple;
	bh=ettcBPzq9vc4d1Q2YzwL5tu0nxYFQpwu/MvrU+Xm5OY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1IIi+N9DPIsgs8fWWPk3ZwTT6fyfZi9ZuYtUAlwGn3kcqSZHv/379AVz/2RNq72c8K58M8bdnRKmY7hUI4dKJ3VXdZSFhuJjihpCVsX/erxcH0o0XX+LgGJoi10aFBIGhomcESBmWl/DGawNQzZJ7AGh5v1dyR5oSygNNKmJhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxplMiDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FAFC4CEF7;
	Fri,  7 Nov 2025 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762530836;
	bh=ettcBPzq9vc4d1Q2YzwL5tu0nxYFQpwu/MvrU+Xm5OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lxplMiDsGPW2hmIqOmG3M/34/cHrntNpLBakDz8CGs09Ju7aioqGhBVXUiEaOdMMU
	 rsjxWJIsDBBJpzxXPX7b0B4px02H130YHfddFe6GVGcohU3s5F/wYS4QPqM/0GFh6j
	 t2rlVnta2EhUvPpaCXXXuPSg19DwBV7c9yJkGSjObvt0d8yKZgcqq4sgvA/e5F6l/c
	 sWxSpNs9QqdeqZ9G9WYsd4fszlCoxx2ZLuSQ9wH5Jy8/Hh6U3PoK8466RX5+ALmy49
	 6EjBQ5ixXvm7Ubf1ikeCUeblmht2MXhvB41+o9cgjkdb4oMUpRKeusUcKfxWKvqvJM
	 7BS2bsd86M31w==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adrian=20Barna=C5=9B?= <abarnas@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 0/2] arm64: modules: Reject loading of malformed modules
Date: Fri,  7 Nov 2025 15:53:42 +0000
Message-Id: <176252752075.602788.16693792309857347530.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922130427.2904977-1-abarnas@google.com>
References: <20250922130427.2904977-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 22 Sep 2025 13:04:25 +0000, Adrian Barnaś wrote:
> Here is version two of the patches I previously posted here:
> 
>   v1: https://lore.kernel.org/all/20250919122321.946462-1-abarnas@google.com/
> 
> Changes:
>   * Renamed the parameter `is_module` to `skip_dry_run` in scs_patch()
>   * Moved comments to module_finalize() and improve justification
>   * Instead of rejecting all modules with callback, reject those with cb
>     pointing outside core kernel text
>   * Replace -EPERM to -ENOEXEC when rejecting modules with incorrect cb
>   * Fix missing return in apply_alternatives_module() placeholder
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/2] arm64: Fail module loading if dynamic SCS patching fails
      https://git.kernel.org/arm64/c/6d4a0fbd34a4
[2/2] arm64: Reject modules with internal alternative callbacks
      https://git.kernel.org/arm64/c/8e8ae788964a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

