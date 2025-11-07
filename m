Return-Path: <linux-kernel+bounces-890698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E29DC40B01
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB4684F21FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F143F330327;
	Fri,  7 Nov 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFJld62m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C233031C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530851; cv=none; b=nraEZ5821PEY6ogKgd/xFeH1XNDDo1Kvbrd24W9tPi5rZ/3puenAWlmcGteTNAFUEb810VGQZctdJ1gnqztY9e6CIr8dSJg76dqNMCk9RZfp56nUf87976+G7YN/e21o/qd+4sg/1ncGsoJ2ABcqMibpfM0WOmWvOwCdikXMj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530851; c=relaxed/simple;
	bh=ThVCjD0ZazmJiDGZYe6R+cB02JSMq5aoBRsaUWqYnxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fm5SPO45xkDYUMliwgn4g7QtnCPegdIuCfp5PrUm0ENyTMK5a6wQvDuzSW8VRB+ZHvApdt+yefCuEl30XmfmM9p/IDuaYvaGds2tKn2220dMZ+iIIhrTJZwyNuicejDUO08ThAjPiDQHzbwXQZ5e2GGApNOJuzdwgRLWoFMfp+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFJld62m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A98CC4CEF5;
	Fri,  7 Nov 2025 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762530850;
	bh=ThVCjD0ZazmJiDGZYe6R+cB02JSMq5aoBRsaUWqYnxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFJld62mhwNq7PWePzTFsedd+c5UTwWQFiRGByxCkJ+IZNn5h8Zzdmv6CHk8oGaej
	 9FHkSAMcm4JwiRYufuuayNXyahhJ6tJfgypUYG3AsfZbNu37tZpHDEneln6BJWT0Fq
	 Ams9nwLCngn68BtzCQyF/wjA5MyERiFikX9gR9S41r37mrA9UsDHbURahPPrP8H4Qp
	 Ch+8f2pS91tXQXlMdlyVXLjtEaNcNgko2C8IJHBzzeC1jY2Kj66i8l+9+vnzcR6T5x
	 ZzICbfcZ5LSoQ9e9/c5mOftmom3lZ15ON8/6MemLmdz2yslh2Wf6zxnA84UwzjtSsD
	 IR4ZYZl4hIfqQ==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	catalin.marinas@arm.com,
	shechenglong <shechenglong@xfusion.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stone.xulei@xfusion.com,
	chenjialong@xfusion.com,
	yuxiating@xfusion.com
Subject: Re: [PATCH v3 0/2] arm64: spectre: Fix hard lockup and cleanup mitigation messages
Date: Fri,  7 Nov 2025 15:53:47 +0000
Message-Id: <176252676626.598584.6910045504284939214.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251031091507.1896-1-shechenglong@xfusion.com>
References: <20250918064907.1832-1-shechenglong@xfusion.com> <20251031091507.1896-1-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 31 Oct 2025 17:15:04 +0800, shechenglong wrote:
> On Wed, Oct 29, 2025 at 11:45:54AM +0800, Will Deacon wrote:
> > Is the compiler smart enough to store a single string for the
> > "mitigation disabled by command-line option\n" part? If not,
> > you might want to use %s to avoid wasting memory. (I was going to
> > check with llvm but I'm unable to apply your changes due to whitespace
> > corruption).
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/2] arm64: proton-pack: Drop print when !CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY
      https://git.kernel.org/arm64/c/62e72463ca71
[2/2] arm64: proton-pack: Fix hard lockup due to print in scheduler context
      https://git.kernel.org/arm64/c/7f1635737823

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

