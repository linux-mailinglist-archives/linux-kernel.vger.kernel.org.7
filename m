Return-Path: <linux-kernel+bounces-806269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F8EB49472
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC453B509E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD5230EF63;
	Mon,  8 Sep 2025 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z38RrBL9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0872E8E11;
	Mon,  8 Sep 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346941; cv=none; b=vElJdRf8tgs00+oW17fj9GVoV0uJJy/o2k1ruWI0nu8cSG0TIuZ5iWMf17feWx9gVPOkHXk9eguEkz4fkrGztkrLnYCHSXxi50dbTp62TyTRXkP4Y9Z6eelWxXDJ6DPxa6vvyE/KAQfgWpA3EWcktSOaGyRWQKaCcIk8XSGajI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346941; c=relaxed/simple;
	bh=DizzKg5VIDcP8L+ZEfS/2/xa/RROiz4nTvz9DInCpd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aS0TzFNu4k0OE3B5beqpWGeMd3bBHMMoR766Kwm8iQj8tLzfhQLvtDk/iBaAzeli7R78RPrTTAwT5uAP4+J3E0yfce8+oH81eU3F1/YVD7Ilj3HKXVkUvsbCTxrd7+puKOMSGWFkpE6q7zqVhUJJuB2jdNeAUCZfX9004SnGlrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z38RrBL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1B5C4CEF7;
	Mon,  8 Sep 2025 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346941;
	bh=DizzKg5VIDcP8L+ZEfS/2/xa/RROiz4nTvz9DInCpd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z38RrBL9jOJYM/P5tXNOiS2jkhaKwHC++0XXyY4dJwVsQoZEhoPnL6VRhO1z7JIjl
	 gi7CMBaaseAKOPFPvNc4UOFiCIM+t0V5lh3CwNOYYDA2SJY/3Um/FcmfDWfy1hwQ7H
	 xrOPQQLlx8HKtnAaJKPbeNWQRHPFzbZKP19T7giN/qOaq1wh9/dBn52gnuItDY7ouO
	 5XrOCkQaj6S37PiKUHES/udqHEvUbJ1c4pYH0A6A1npZGyJP4GD0U8f6JO5ycUSWsA
	 5esj0uCbcmB9Ou6e7e9J91dN0YsxhCFJIeWCvDGpAhFId8RJGLSKhyaX/P7J/myefr
	 uNo4v4BXjdFvA==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Drop inaccurate documentation of streaming mode switches
Date: Mon,  8 Sep 2025 16:55:27 +0100
Message-Id: <175733401206.91195.12940628509924658208.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723-arm64-sme-mode-switch-doc-v1-1-702bb484b4f4@kernel.org>
References: <20250723-arm64-sme-mode-switch-doc-v1-1-702bb484b4f4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 23 Jul 2025 13:27:45 +0100, Mark Brown wrote:
> The SME ABI documentation contains an inaccurate description of the
> architectural streaming mode entry/exit behaviour, just remove it since
> this is better documented by the architecture or with the rest of the
> documentation for the specific software interfaces concerned.
> 
> 

Applied to arm64 (for-next/docs), thanks!

[1/1] arm64/sme: Drop inaccurate documentation of streaming mode switches
      https://git.kernel.org/arm64/c/3c0979c64481

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

