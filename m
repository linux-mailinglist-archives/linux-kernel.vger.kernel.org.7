Return-Path: <linux-kernel+bounces-890696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C674C40AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761771882F64
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08A32E6BD;
	Fri,  7 Nov 2025 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRnwBL5s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FB32E15D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530842; cv=none; b=F2SpiBYFSViMYIwvCgsW4CsoxCzYsu2hG/PuHnPGrYl6GdwMcbRJ8wbTc2Qimdf/6CqrQn8O4bISd7LFdu0MsDIjp9N3OpjYDk9kr3zzRxiftWcVcfV+ehVo/eT7ojD3jB3sG+8K+wpySxS7MImphjA2R2OxkYuQCb1LGX1T/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530842; c=relaxed/simple;
	bh=lQKtc6BdFbB7ZvGXIikc/Mmj5z9LnBKsOwLvwGnv1pY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfvGvcfh2EX5XhDIJRLwVjhglZOEYcwvBlcFe/aIZOI+uR5+7edehGoyluh8CFxCItXUVkoa9D8inyaVfbOp9VYuK37Vt1UDE83O0khDoZ3cEKovLbKqHz/E7M7oIL3yGuMsox+56MKAFQ82n0a1PhYFWE0fgW3uFo6cyo4czkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRnwBL5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF71C4CEF7;
	Fri,  7 Nov 2025 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762530842;
	bh=lQKtc6BdFbB7ZvGXIikc/Mmj5z9LnBKsOwLvwGnv1pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRnwBL5s5J7coCWXOS2ZQz+cPHxb2arH6z9tBdk4nXvzFBK2nbiMjmODvznt9wLjH
	 kWJmp4PDF2ITpH5j3+vf0iV1d0FEYzfzpYpH7ckRY/oFSIQ4DOitXHGm3LeIRr1FEa
	 7Z/IdRO+HolNN4l71GtpCFUohxtNiF0hds4r726sz6+9hjMVeMxL7rWUpBgWnvN6Hb
	 kM/sk1oZLtPZdfSoKiGNDzR+9Ex1jh5kFXuZgch9uhiV0/3l/9Pi+JwjTcxyifHNW+
	 fDBcc852IkLdpdgAQi/UMq0k0JgvrTY21I3yA33aQ7wk049u7CXyy2c3DABvulm4nU
	 F3YUNQZR79Z2Q==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	Punit Agrawal <punit.agrawal@oss.qualcomm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Punit Agrawal <punita@qti.qualcomm.com>,
	chenl311@chinatelecom.cn,
	liuwei09@cestc.cn,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: acpi: Drop default console log message when using SPCR
Date: Fri,  7 Nov 2025 15:53:44 +0000
Message-Id: <176252541421.592251.6144901758020788544.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251031111138.1262202-1-punit.agrawal@oss.qualcomm.com>
References: <20251031111138.1262202-1-punit.agrawal@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 31 Oct 2025 11:11:36 +0000, Punit Agrawal wrote:
> Based on feedback, I've updated the original patch[0] to instead drop
> the default console message when using SPCR.
> 
> The first patch reverts the incorrect assumption about the return
> values of acpi_parse_spcr(). The second drops the logging.
> 
> Thanks,
> Punit
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/2] Revert "ACPI: Suppress misleading SPCR console message when SPCR table is absent"
      https://git.kernel.org/arm64/c/eeb8c1989695
[2/2] arm64: acpi: Drop message logging SPCR default console
      https://git.kernel.org/arm64/c/7991fda619f7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

