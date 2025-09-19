Return-Path: <linux-kernel+bounces-825096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0F9B8AF32
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4B01C87CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09CE25DAF0;
	Fri, 19 Sep 2025 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tI2ZhMvS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D2A254AF5;
	Fri, 19 Sep 2025 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307114; cv=none; b=C81ZzhwETn6zNpviD6xx9wAk5O3/5Ch/jR168d6RgagBbujVMY6jwpEB89ou+weVJo+7WwK8rDdvkY5GnRvBoL8loGQ9V8I8DTezdHvSO0kdUnQQYHgehHdQVOFADVeXlZm8QYtruzThT8TkU/ecs/xtzs0MtkjMjyPdDy5mdyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307114; c=relaxed/simple;
	bh=g5XD20gFfrYjZGNjDgzk53Skqg5rf5+ZLWDimhdGRRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcCPMCb/abKC1G8RjD9L0tvULX7idO7cy6UI0ZJi+J9CZYm7rFAXc8BJy9IezNsB7hdG5OiQGiDJMEfMAY8RhjmA1NE0c2vlTsV5P+DFVpUUEQaks/StCrRi1RWFUdY76XcVb/Mh3ZOduns+/stfEAuKvn9s3R/lRmFdcKhJyns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tI2ZhMvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD77C4CEF0;
	Fri, 19 Sep 2025 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758307112;
	bh=g5XD20gFfrYjZGNjDgzk53Skqg5rf5+ZLWDimhdGRRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tI2ZhMvSIF1eJc2Yzz5mRzFmeosSr+i9E2m7UPtkUCBrr/zfTPOWyIPbktNRpVjJr
	 +uMODDpuw/f3KRCY+BVfTi5c2yAfHVCcg8einyftvYrJF98bmvJFNS4NusdFyQy8zn
	 SQZilDuw3Tgrf09sZKtVwDFxIpMXSDOYoiRkCTEokyNksn5waxstRLsr5QX7zBP5MC
	 hXkCd5/MPd/K2gcZuV799je9y3ES/dYq/q+TveH1WSm/Hiw/2+AKjGkue6Ey8QbWmP
	 GytqAHSpd+Iji9+LtsU6VOfj9NTj14sBZg4GVi8LN+MMRq9utMjC0hMICsmdvwcXlA
	 V/K83YFDRq8jQ==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	gshan@redhat.com,
	aneesh.kumar@kernel.org,
	sami.mujawar@arm.com,
	sudeep.holla@arm.com,
	steven.price@arm.com
Subject: Re: [PATCH v3 0/3] arm64: realm: Add support for encrypted data from firmware
Date: Fri, 19 Sep 2025 19:38:18 +0100
Message-Id: <175827312255.1088160.4082411097275002683.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250918125618.2125733-1-suzuki.poulose@arm.com>
References: <20250918125618.2125733-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Sep 2025 13:56:15 +0100, Suzuki K Poulose wrote:
> Confidential compute firmware may provide secret data via reserved memory regions
> (e.g., ACPI CCEL, EFI Coco secret area). These must be ioremap'ed() as encrypted.
> As of now, realm only maps "trusted devices" (RIPAS = RSI_RIPAS_DEV) as encrypted.
> This series adds support for mapping areas that are protected
> (i.e., RIPAS = RSI_RIPAS_RAM) as encrypted. Also, extrapolating that, we can map
> anything that is not RIPAS_EMPTY as protected, as it is guaranteed to be "protected".
> 
> [...]

Applied to arm64 (for-next/cca), thanks!

[1/3] arm64: realm: ioremap: Allow mapping memory as encrypted
      https://git.kernel.org/arm64/c/fa84e534c3ec
[2/3] arm64: Enable EFI secret area Securityfs support
      https://git.kernel.org/arm64/c/9e8a3df3e7f7
[3/3] arm64: acpi: Enable ACPI CCEL support
      https://git.kernel.org/arm64/c/d02c2e45b1e7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

