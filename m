Return-Path: <linux-kernel+bounces-819623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE3B5A3B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369A11896801
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29AB2E090A;
	Tue, 16 Sep 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAtbUKfw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926E2F83CD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057255; cv=none; b=FDJbVRXrlcZ5s+ACAv4BUN/YpiF6PzsnI2fN6AQyWcAHgQt7twUeRG2VuAoaFJUPaM/R1kA8IoXRA5aUIEAXRLExgp1+yVogG2aiBbp4WLOfg3r78SZHmfjm4oZUwy3zepyVFdJOzZuUvgzBz1deF4tT/1vmcX0/RI9VRRHsWbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057255; c=relaxed/simple;
	bh=ZEX6epiYDS4/Irj1nhsUQcUfxGCRNCiyjKALsXvsM8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0/GKzeHKt4j1M7GzZjjHbJzw+mhRagKigAwUpOzWp/pLsrneOpdZ99KPrVZfBME7UTGhke67/OWn1rprd/49UyBKJlwJwL0MJ9R44PdLNXicPg0jFODBomm49doREz52UXlTm/yyJTZR3wj1wDTKsQeFBS4dtJDy/LKhzBe9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAtbUKfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC51C4CEEB;
	Tue, 16 Sep 2025 21:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758057254;
	bh=ZEX6epiYDS4/Irj1nhsUQcUfxGCRNCiyjKALsXvsM8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DAtbUKfwOJtwHY9Inm8sU+7/3dyYEgr0481WFZ5JSiVjt4/I+g8F/Kn2RK3sRoY2A
	 CRfLXiil0gr9O60TdrSaMX9lwMWDAIWZYWHa2lTPa7B+Vi049/RzylkHqlXUF8T9RE
	 ZqRXbsGPLBfL7xO4c7Jv+37uNfnDf5ZeadeM1RLEi+0W+0aGijhqBbhlqCPYoqJNdj
	 7+onD/uAtFZaHz0gRom30rU5it4jDyiGsJgyWgLXwpx2A+QYl7E3SZ4Ji3JEYnsj5q
	 V0YadLMsGhtO960hdQXShmdF4x92T2JuXJGr+K8aUMJn1qvPV4zJCFLve3Lt0GEBea
	 3Kt4YyInSviKg==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64/fpsimd: simplify sme_setup()
Date: Tue, 16 Sep 2025 22:13:51 +0100
Message-Id: <175805314947.272606.2121581069783124442.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250913000906.67086-1-yury.norov@gmail.com>
References: <20250913000906.67086-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Sep 2025 20:09:05 -0400, Yury Norov (NVIDIA) wrote:
> The function checks info->vq_map for emptiness right before calling
> find_last_bit().
> 
> We can use the find_last_bit() output and save on bitmap_empty() call,
> which is O(N).
> 
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/fpsimd: simplify sme_setup()
      https://git.kernel.org/arm64/c/19dd484cd19c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

