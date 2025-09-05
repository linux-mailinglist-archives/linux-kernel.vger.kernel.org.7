Return-Path: <linux-kernel+bounces-802873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3271B457D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1592170AFB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608E734DCFC;
	Fri,  5 Sep 2025 12:26:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D3B286898
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075203; cv=none; b=ioSOsEwOpyIRxRdgkkyvq/P2K1nve9XlQRYHbg1XG2anAjMbHY2v7jnYt87KC5dRsEhrDUU6e7JXkRC6AzFcpm84H0VaSlcFu5hJjziadtWN+YQ+TOiu/s7Sp+TJTmvcJ79KRh+19lmZI5HFMB6wBMNLM9IL9P/TCqX6sf0xZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075203; c=relaxed/simple;
	bh=yi5iDY/CaKimjYvqKYhiF0y+agbmmVD8KiB2arAoyuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cH2VWE7k23phEVdRvDWWqzcWaG5oHsaUnHmmaBw+7yPOgMZSctmpEtMpDzAAt1ND+oPB8Fc8gtlySF7efTndi5R9UJsSD3XV299sbsHN+KNTKWKqj8ydqpSiMY70kItJEKGZEAOq9IfLx0uDy/sz2IGz7M08tWG8lokv/z0813A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3369153B;
	Fri,  5 Sep 2025 05:26:32 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 976693F63F;
	Fri,  5 Sep 2025 05:26:39 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tamas Zsoldos <tamas.zsoldos@arm.com>
Subject: Re: [PATCH v2] coresight: trbe: Return NULL pointer for allocation failures
Date: Fri,  5 Sep 2025 13:26:30 +0100
Message-ID: <175707517468.1603863.4031069288262415474.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904-cs_etm_auxsetup_fix_error_handling-v2-1-a502d0bafb95@arm.com>
References: <20250904-cs_etm_auxsetup_fix_error_handling-v2-1-a502d0bafb95@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 04 Sep 2025 15:13:52 +0100, Leo Yan wrote:
> When the TRBE driver fails to allocate a buffer, it currently returns
> the error code "-ENOMEM". However, the caller etm_setup_aux() only
> checks for a NULL pointer, so it misses the error. As a result, the
> driver continues and eventually causes a kernel panic.
> 
> Fix this by returning a NULL pointer from arm_trbe_alloc_buffer() on
> allocation failures. This allows that the callers can properly handle
> the failure.
> 
> [...]

Applied, thanks!

[1/1] coresight: trbe: Return NULL pointer for allocation failures
      https://git.kernel.org/coresight/c/811e07b1812a

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

