Return-Path: <linux-kernel+bounces-819622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB78B5A3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CD418963A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983862F2609;
	Tue, 16 Sep 2025 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd8F8sR8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E6E2E090A;
	Tue, 16 Sep 2025 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057253; cv=none; b=W55tihYiox06gla82qnuouc4urSnHQbeFeAqAdNV4Pcp4Og/zr9L0ta22EOVsOdllTISwLWuw/xc/cvLpoOWlFT3vsodO0BpV7QpU1OLRC9HCWlBUuwvXAlzSbEnb6uLL8lzj8tBE1wHSy7nNYAqIhsQ2w52iGO0p8EFR/+8mdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057253; c=relaxed/simple;
	bh=mdYINkvVyjXkwJO8jrP2q0vlKqEFRhWRoX7T6rQ9uck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVRZmrSWgAaweaYtrN88UIf0/ffM7mseGcM1Sfqck7fyi9ZspbJK5Vj7gDge4+4Nv85e6KJ1IFrTXfV0Hrp/WrR824WXPEl+TlPbvwk61MVOOAFecP+45QozZs9wOxkk7oyl/qQAVCDtb0Llm6oRNBZ2M0ITSUjo2Sw+2WFru4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd8F8sR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BB2C4CEF7;
	Tue, 16 Sep 2025 21:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758057252;
	bh=mdYINkvVyjXkwJO8jrP2q0vlKqEFRhWRoX7T6rQ9uck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yd8F8sR8UCELdsM0SIvQnVBVgVnJmAQWFEkv7W8vtwtK1ZfTV9360qia1e36CpT5+
	 7R7hngo7AkjVfwVM1u9i1MSosbelkeulla58aIjMtXcmVKalw7/TXHz3ZHBsHz4P4S
	 8U9/MGTrStqRV7IX8hdQBVVs1aBWbvylfz6K6VWnmzr3OcOZlbD7JJBOF5kUjJta1a
	 iZ55ucTcLk+bL5d/2fVkQ7ID3iRx5+9u9WQ47gn3vbACtTNQP+myoiXFV3OAXtxvnA
	 /DZ6rnB9hUOmAzRuh7qm2TZQwy6A7juO11MrHjIPuEW7ZhbkcfRA2M8LFRESF0c0K3
	 PTdUMZuBsPZVA==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	patches@amperecomputing.com,
	cl@linux.com,
	Shubhang@os.amperecomputing.com,
	corbet@lwn.net,
	paulmck@kernel.org,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	Neeraj.Upadhyay@amd.com,
	bp@alien8.de,
	ardb@kernel.org,
	anshuman.khandual@arm.com,
	suzuki.poulose@arm.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rdunlap@infradead.org
Subject: Re: [PATCH v7 0/2] arm64: refactor the rodata=xxx
Date: Tue, 16 Sep 2025 22:13:50 +0100
Message-Id: <175805239499.269424.4665701509938991056.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250909033236.4099-1-shijie@os.amperecomputing.com>
References: <20250909033236.4099-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 09 Sep 2025 11:32:34 +0800, Huang Shijie wrote:
> >From Documentation/admin-guide/kernel-parameters.txt, we know that:
>  rodata=	[KNL,EARLY]
> 	on	Mark read-only kernel memory as read-only (default).
> 	off	Leave read-only kernel memory writable for debugging.
> 	full	Mark read-only kernel memory and aliases as read-only
> 		[arm64]
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/2] arm64: refactor the rodata=xxx
      (no commit info)
[2/2] arm64/Kconfig: Remove CONFIG_RODATA_FULL_DEFAULT_ENABLED
      https://git.kernel.org/arm64/c/bfbbb0d3215f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

