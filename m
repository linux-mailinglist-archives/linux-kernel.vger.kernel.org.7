Return-Path: <linux-kernel+bounces-858529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0280BEB115
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5B71AA7A48
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C441305E1D;
	Fri, 17 Oct 2025 17:29:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA2A29A312
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722175; cv=none; b=TIoKeSCYpmEi9q+RPxdU5i54HS56Ev4eo2ZhSr8rD95Lko3Eo396qnNL+QRJGUtzwyoobbfd9XNdeVqe+jT6szqcP5qdGaVeRuz+r8DrY5trzdSL2Bt8q9rtYzA+HgndOUN0EW8ozXy6XsiChUf7M/NYR2r7fPz8bLRHjMyqF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722175; c=relaxed/simple;
	bh=VI2bZhdGBW6HtwUwl2OHZKXbbT6mnebifxFQt3IfFgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQuqska0kdN4spzxIIbrE9vkoqq0MQdGDXWZq5VqxDDni0ENkaIU9/qivKxQl0stzsZFAg9u6nN6Fvz8DWjJVX+bq6JaSQzf5PoOChWvXSyz5gEWn/yi6NwFvx1RPqT32yQUXeVcBdEnPHrPdGm1Eim6528u4JIy5ray9Vd5QRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D53C4CEE7;
	Fri, 17 Oct 2025 17:29:32 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] arm64/sysreg: Fix GIC CDEOI instruction encoding
Date: Fri, 17 Oct 2025 18:29:20 +0100
Message-ID: <176072211691.2071457.9418354818305517831.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007102600.879337-1-lpieralisi@kernel.org>
References: <20251007102600.879337-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 07 Oct 2025 12:26:00 +0200, Lorenzo Pieralisi wrote:
> The GIC CDEOI system instruction requires the Rt field to be set to 0b11111
> otherwise the instruction behaviour becomes CONSTRAINED UNPREDICTABLE.
> 
> Currenly, its usage is encoded as a system register write, with a constant
> 0 value:
> 
> write_sysreg_s(0, GICV5_OP_GIC_CDEOI)
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/sysreg: Fix GIC CDEOI instruction encoding
      https://git.kernel.org/arm64/c/e9ad390a4812

-- 
Catalin


