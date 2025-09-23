Return-Path: <linux-kernel+bounces-828755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042F8B955E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA75D2E0DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D24288C8B;
	Tue, 23 Sep 2025 10:02:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A665281376
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621774; cv=none; b=e2r0/iyXyYyQsMxMEbiPHqsrlYN81JL8SEG22V1dnhMzRpF+Zbsz9WN2r2jomNm8Ifam2rBjpQzu6zICLZl7VNHx5lhpSU1POF8phzQa3mXrs181TRa5vsDFgPuDmCzIUsGGmpT9TZi5ZOrba2U9NIxDoS1tOFiBaI2XAJsSqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621774; c=relaxed/simple;
	bh=0LpF4xQRiB4CwMPa9tbybpQQLe0CdZd8ZKsv/tQhcuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTXuknZVnYwDu9YjyE8IV39LV/zHHN7PCLlI18NW3u060SBjQJ4ZS8c2/6Yzw3Zuh4YzhZH1NOigggw38KXQQD2qSh3A4beLLOhmysUzfQMJ5/iWaf2VxGbnDvQFGydbs6fyuJxiGzAy0cZ0uAnJ8Zey9OQzydM0g23DWZ/jiko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7B72497;
	Tue, 23 Sep 2025 03:02:44 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96CEC3F694;
	Tue, 23 Sep 2025 03:02:50 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:02:47 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: catalin.marinas@arm.com, will@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, mario.limonciello@amd.com,
	Sudeep Holla <sudeep.holla@arm.com>, beata.michalska@arm.com,
	sumitg@nvidia.com, ptsm@linux.microsoft.com,
	yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] arch_topology: move parse_acpi_topology() to
 common code
Message-ID: <20250923-marvellous-tuscan-lemming-f13fca@sudeepholla>
References: <20250923015409.15983-1-cuiyunhui@bytedance.com>
 <20250923015409.15983-2-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923015409.15983-2-cuiyunhui@bytedance.com>

On Tue, Sep 23, 2025 at 09:54:09AM +0800, Yunhui Cui wrote:
> Currently, RISC-V lacks arch-specific registers for CPU topology
> properties and must get them from ACPI. Thus, parse_acpi_topology()
> is moved from arm64/ to drivers/ for RISC-V reuse.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

