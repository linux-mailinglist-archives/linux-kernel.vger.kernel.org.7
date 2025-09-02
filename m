Return-Path: <linux-kernel+bounces-795802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D249EB3F7FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F03117E3A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BEA2EA165;
	Tue,  2 Sep 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvFlM7ZS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9CD2E974E;
	Tue,  2 Sep 2025 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800841; cv=none; b=l9a9SIRtU6OC1Lkl7tZiAQkJX2TdbIO6WOqhmfjwmHY9WkhSb1JB5cmWwFTFrStujdx77BHJ00umPD6AncG/dxVTAO7IBOteQorTYsvo6j88jdkodsZMCcbmW9OUbYu4NQ7d1dcQHBTQzb8v6pFefudFcRo8LOYHvpbAw0skzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800841; c=relaxed/simple;
	bh=HWyqnnpUQ0RMOPKfJQXAPWxuH4TZHiX9DPbsyXAvzbI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XGMgK79mA1p8+g8b2Pm7mvD+qpMo0o4JHNA0f5sd7v98abfhppeeiWFgLxXnt1tAOyOU11w9uI4tHqWd5sSRFeEgJupMZ2wIOgOODopWfrPU85WOjNeLBwrqezoLfn2QU5ObjzOBmc+pIyPso5x4s8kEiyie9EcDzLbT1xK4Ca0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvFlM7ZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5639C4CEED;
	Tue,  2 Sep 2025 08:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756800841;
	bh=HWyqnnpUQ0RMOPKfJQXAPWxuH4TZHiX9DPbsyXAvzbI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DvFlM7ZSYxpCGcYGhREx440CmfMmD26hWCb2Li88JwmndSOhT3akmsY32Rx6UCgfJ
	 5y3JViivp3Nbvt2iuGys3uj//e6cOslQziAfarMbVgbxYh9t6+k1pPh2I/h3F/vaYh
	 0oOEflXHBJbNTen6rRIhf+2tNrS4FtPBSrzj0MIReokz/UxUdeVpXz1M3ZFRkkrc3M
	 G/A0E2QV2Nygu+4ZpD5MPqua//2Ty15mFOBOwWxFN9N7hXKqHkE4pbIVqPTssHZ3fz
	 eM5lqva4fDEprJ65at5tG5QbCnY0rrvT3HgEPeZ29b4TYLeL5YdkcP2W9B6TQuPK4C
	 /21F2Ag3/H53Q==
From: Lee Jones <lee@kernel.org>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>, Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <pnd8qjym7td.a.out@axis.com>
References: <pnd8qjym7td.a.out@axis.com>
Subject: Re: (subset) [PATCH v2] mfd: macsmc: Remove error prints for
 devm_add_action_or_reset()
Message-Id: <175680083942.2184860.11235957894379015646.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 09:13:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Tue, 05 Aug 2025 11:33:34 +0200, Waqar Hameed wrote:
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
> 
> 
> [...]

Applied, thanks!

[1/1] mfd: macsmc: Remove error prints for devm_add_action_or_reset()
      commit: 342c84507bfc197a0a9fddd6f076befefd5e6c25

--
Lee Jones [李琼斯]


