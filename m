Return-Path: <linux-kernel+bounces-723357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24EFAFE61F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75A9173085
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6C0292B28;
	Wed,  9 Jul 2025 10:41:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983F428FFDA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057702; cv=none; b=Z9N1w5F9A1mPudxmaXLjBkZekwNtMUqy1h5or/ZEp5WTmkmFbomuBM1iExMeE5a0GU4QOd7Dt4HcUfPaKOE7/l+K1H/vlh+JL26IHC7eH9lbMZo8d9TGZ0vfhJ6LF+c/JymHaiesHL/uw8XbrGxOIja3i994q/BuGLco3Yi8pQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057702; c=relaxed/simple;
	bh=ks2Z61NIt6N8O3U5rSm7x9/tHCWhosuVtN1SOk4Hcos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egl4YDUZrgSwbaY8YezvSx1IQPYjgw0pOJ26xGh2Nr3y7jss6eMFcBgU8pLCX6/Pa22PN2UJVFcSMrmc9l/h19sJhvIluINVa1/sT9TiVxrn+qOOwTNeREWK8gbn//2Mm7QuYZy/CamAVJbiKuKu8YL/EuadI+aPwtRmGzBCIKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29263150C;
	Wed,  9 Jul 2025 03:41:27 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A9BC23F694;
	Wed,  9 Jul 2025 03:41:37 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwtracing: coresight: Use of_reserved_mem_region_to_resource() for "memory-region"
Date: Wed,  9 Jul 2025 11:41:26 +0100
Message-ID: <175205766742.267347.15415211395025557807.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703183534.2075569-1-robh@kernel.org>
References: <20250703183534.2075569-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 03 Jul 2025 13:35:33 -0500, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.
> 
> 

Applied, thanks!

[1/1] hwtracing: coresight: Use of_reserved_mem_region_to_resource() for "memory-region"
      https://git.kernel.org/coresight/c/f0148bd7

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

