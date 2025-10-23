Return-Path: <linux-kernel+bounces-867882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB43C03B99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AC53A557B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63D7285C9F;
	Thu, 23 Oct 2025 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzRz0FBH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF6C2E0;
	Thu, 23 Oct 2025 22:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761260078; cv=none; b=huDK8vDx+xIFK5+F9L8xc9v8XBgG/lvcSMbadkGntLbcjW0DYVAqsa5g9X1jGvDfqI7Onevexi4rRbyEhPEjaxKjsRwz3DW+dszBLhGrUhcnLOdH/K8atwCc95p2AeBv5qSCMI5nQeVPhsuXxfrsmA3+85li2B21H6HrviGJaYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761260078; c=relaxed/simple;
	bh=74kCrMQ1VlyHYL4uF27ylILtQO9Fepi5F2e2P6zeNLA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L6qwZ0kIIaqIrzd8giiXyHsk2dkzIAZLSZ6VkjfowgbMmP6auuxitD3VlXjV8pBnbc6TDjAvV+8edNJyKLWGT2DKiCcMC8S6Zb2WsIqrgaD0dm85hdWh5GStQ1xVu41WZJcR+tewdPDhap2PQAuxBohLGFViYppvsPw68rFhoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzRz0FBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A12C4CEE7;
	Thu, 23 Oct 2025 22:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761260077;
	bh=74kCrMQ1VlyHYL4uF27ylILtQO9Fepi5F2e2P6zeNLA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OzRz0FBH/3+1K6uFggczn5ZDznA1FBZJrIDPlpOIMyM5A2R93wqdhpnQYWzQuNKyn
	 hL8sGCBJUVOv5hyK7Gcl5wE3JA9Spb4dhj1izLpXFj/XLvrldEvxPevevXxP65cDjC
	 FD5eAGd4GDPWX+g9WsAUF+r30GzhCMWFHcpvtYdIyKOaRAGpD59uloNOz8ZnVWeHAJ
	 KZY7QP+wJ91ipic47MuTSdun7ggxZd0k68e/mXt+mg/GKfe3R78PPTYeso8XHUcWTH
	 cyDTG67TAbqXnTlvAybZ0t3s0bfyrTbk7WnWff7kFfdmkGPuD/wfpMi6+KFIaXlmN+
	 RaQynf2YGphVQ==
From: Nathan Chancellor <nathan@kernel.org>
To: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Kees Cook <kees@kernel.org>, 
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
In-Reply-To: <20251023-fix-kmsan-check-s390-clang-v1-1-4e6df477a4cc@kernel.org>
References: <20251023-fix-kmsan-check-s390-clang-v1-1-4e6df477a4cc@kernel.org>
Subject: Re: [PATCH] KMSAN: Restore dynamic check for
 '-fsanitize=kernel-memory'
Message-Id: <176126007537.2563454.16050415911756189258.b4-ty@kernel.org>
Date: Thu, 23 Oct 2025 23:54:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Thu, 23 Oct 2025 21:01:29 +0200, Nathan Chancellor wrote:
> Commit 5ff8c11775c7 ("KMSAN: Remove tautological checks") changed
> CONFIG_HAVE_KMSAN_COMPILER from a dynamic check for
> '-fsanitize=kernel-memory' to just being true for CONFIG_CC_IS_CLANG.
> This missed the fact that not all architectures supported
> '-fsanitize=kernel-memory' at the same time. For example, SystemZ / s390
> gained support for KMSAN in clang-18 [1], so builds with clang-15
> through clang-17 can select KMSAN but they error with:
> 
> [...]

Applied, thanks!

[1/1] KMSAN: Restore dynamic check for '-fsanitize=kernel-memory'
      https://git.kernel.org/kbuild/c/a16758f0142ab

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


