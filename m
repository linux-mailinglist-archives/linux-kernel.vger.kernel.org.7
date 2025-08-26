Return-Path: <linux-kernel+bounces-786464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48CEB35A28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655E63A9E88
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDE82FF659;
	Tue, 26 Aug 2025 10:39:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F113120B22;
	Tue, 26 Aug 2025 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204748; cv=none; b=XQRx6FMUPhiejWhVCgURzcEZFS3ErvTrxPha2YWA/j0UJwzFHI62L3gApadCec7OGTKJRGnpzUN0q/px05eQ3lVgFrHtgDshFpFsu8LUP9u4o2rQ8Nr6SFxFMUIDsPU6kzzLBuI4o5AnAn2lHqUvafT5GlGAqlcQwJ3qHsqNjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204748; c=relaxed/simple;
	bh=VkHVvn0B93qyCntmeeuGCGRnqcrFBcdFTZFR7Jd9ebQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLSPjqPZhhtoyQ94juTGbT7I9D1NcwbtaHy4G5Wd8uPKvmqcVYpDWEHcL5axkbJI94ELAXN4V0pgYWrD58kLZJzfh4wvmYFEiQQrprzG1YT/hKLD0PKpSyaA8e2jDo0jB4hDo58waCj6adFlEgFxM63MNGji30UbnkHrbpxAQ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14D151A00;
	Tue, 26 Aug 2025 03:38:58 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B1E423F694;
	Tue, 26 Aug 2025 03:39:04 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: cristian.marussi@arm.com,
	Junnan Wu <junnan01.wu@samsung.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	florian.fainelli@broadcom.com,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lei19.wang@samsung.com,
	q1.huang@samsung.com
Subject: Re: [PATCH] firmware: arm_scmi: Set device ready before register scmi_virtio_driver
Date: Tue, 26 Aug 2025 11:39:01 +0100
Message-Id: <175620471163.1762592.13282724135201643997.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812075343.3201365-1-junnan01.wu@samsung.com>
References: <CGME20250812075350epcas5p1cc4533582704978ec3a4a8b73dc1535c@epcas5p1.samsung.com> <20250812075343.3201365-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 15:53:43 +0800, Junnan Wu wrote:
> Fix irregularities in scmi driver probe.
> 
> After 'commit 20bda12a0ea0 ("firmware: arm_scmi: Make VirtIO transport a standalone driver")'
> making SCMI VirtIO transport a standalone driver,
> `scmi_virtio_probe` will follow `scmi_vio_probe`,
> and during `scmi_virtio_probe`, it will do `scmi_probe` which will invoke
> function `scmi_protocol_acquire(handle, SCMI_PROTOCOL_BASE)`,
> and this function will send message via virtqueue and wait device's reply
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] firmware: arm_scmi: Set device ready before register scmi_virtio_driver
      https://git.kernel.org/sudeep.holla/c/e8faa8a466f6
--
Regards,
Sudeep


