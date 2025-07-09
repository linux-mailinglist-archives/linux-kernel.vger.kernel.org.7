Return-Path: <linux-kernel+bounces-723317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE42AFE5BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF97566BD5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6C4257AEE;
	Wed,  9 Jul 2025 10:31:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E816226173
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057069; cv=none; b=if7rDG2xCpnloHA3SxHOrhIpaRiS5GQ+6CgqSf2Cc5rzjXjAwqFcdx/tWONdt2ymz1WN4dUksbeGi7EulOSpmKPb+VjUsHnNhyCNEI7WQOJoNP4byZW8RLlaOEcqJRu7CVxpGWLwVYj7/xU5aD2hcjGGHPDUmnqDmrcfSUvy0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057069; c=relaxed/simple;
	bh=HNexYqal1pihYFkf8lbm4usmzQr97OTMY7vfR9DysUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEr4LAgk/a+3aSx7DoG6Zn47uUs5MvBh+70Wvyt5GeLgRj1KE+5xKLQ4cU0bdSsi1nFebImKeKYwvoiVIIwD3HJTjifPihFk8iZ/nG0PPhI43dFXeL0+rEUCIHQCE3WSRBEjw+Pw+FMFYOqApjy2SfgbNCTGdxOf7FNFT1ivMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02059153B;
	Wed,  9 Jul 2025 03:30:56 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19D1C3F694;
	Wed,  9 Jul 2025 03:31:05 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] coresight: Fix missing include for FIELD_GET
Date: Wed,  9 Jul 2025 11:30:56 +0100
Message-ID: <175205704483.263858.2108474286820746939.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707-james-coresight-bitfield-include-v1-1-aa0f4220ecfd@linaro.org>
References: <20250707-james-coresight-bitfield-include-v1-1-aa0f4220ecfd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 07 Jul 2025 10:55:27 +0100, James Clark wrote:
> Include the header for FIELD_GET which is only sometimes transitively
> included on some configs and kernel releases.
> 
> 

Applied, thanks!

[1/1] coresight: Fix missing include for FIELD_GET
      https://git.kernel.org/coresight/c/82e20f5e

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

