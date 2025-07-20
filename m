Return-Path: <linux-kernel+bounces-738253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A23B0B661
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6071887E6C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275C21E5B7C;
	Sun, 20 Jul 2025 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SONE3pFM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A5F15A8
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753021086; cv=none; b=JfSdPxirf3mF3bw4mYnLYXgjnHBLTXFUiSKx10iLE+7+taBBoI1dkJr/03bkJL4G0q2gdCQBUt2oqJFWxXIFXXTdZQG/mcvtmmfz5hFcoC6r7LEBUTMw7T9i9mkMCpoklYx9JB0+I1oxO78vqnybnGJBzZ/Q2puuc9oHeRbs4Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753021086; c=relaxed/simple;
	bh=NegR/8ttlL9wPvl72IFXS5T8d9wP28mME4h33PqnSeA=;
	h=Message-ID:From:To:Cc:Subject:Date; b=YWgNNVv/P527IsUcJ1ycaxF5Bmc8FFvKYDOOpr+v7tBqWdKIG4y9hR/TS6do0kcfU961ErqvliRY4opPdKWwkpSw5os5HebFAbT3Cw7LcYM6m5My37PFMnY7AF0SdSZQYWV1ESYjfkWdjRe2S3lDripzDBBNMzjmgZ9wEIh0AfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SONE3pFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB03CC4CEE7;
	Sun, 20 Jul 2025 14:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753021086;
	bh=NegR/8ttlL9wPvl72IFXS5T8d9wP28mME4h33PqnSeA=;
	h=From:To:Cc:Subject:Date:From;
	b=SONE3pFMYD8GEkWMLSMVQPGJNM55/7Rnms/oT3AX8oHFxGPwKeXp8l00vu6fq4IiT
	 YbxRj33yGEeL+KnCDTFTiXhnVlkuJJnMiw4mOfbn25WOOFEzym9dSqWXB9jo16k+VB
	 uBAKweUw50MeXQqF8AHynypNKTlanqDEYW9N3Vyosq6Dldn3ETZLKckzfahIe0kZ+x
	 4qo4b6fRhjSm+aPhQ34c8QkU9xYPT/HvIyXWTNGx9KHexuXVAzbbDddq47AtQizeuQ
	 80nThbuipx52ZEIyzWoQ/szfArBRmMiVBXeRhQZL2mgeguJ9Pei+k20R8IYPde8lom
	 mZ1u3HXhNrqfQ==
Message-ID: <4fc0f5d3fe86cb5c2d1faa80b619fd53.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.16-rc6
Date: Sun, 20 Jul 2025 15:17:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af:

  Linux 6.16-rc4 (2025-06-29 13:09:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.16-rc6

for you to fetch changes up to c871c199accb39d0f4cb941ad0dccabfc21e9214:

  regmap: fix potential memory leak of regmap_bus (2025-06-29 22:10:36 +0100)

----------------------------------------------------------------
regmap: Fix for v6.16

A fix for a memory leak when we get an error during regmap init for a
bus that uses free_on_exit to clean up device specific data.

----------------------------------------------------------------
Abdun Nihaal (1):
      regmap: fix potential memory leak of regmap_bus

 drivers/base/regmap/regmap.c | 2 ++
 1 file changed, 2 insertions(+)

