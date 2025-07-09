Return-Path: <linux-kernel+bounces-723248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF555AFE4D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7312816C804
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B3A28934C;
	Wed,  9 Jul 2025 10:02:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA30D2874F3
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055334; cv=none; b=ssQKgmnr7rEwVVUG3x/bi7wjBWaAqsF/ijBgfjwzxbER7W3kW5WjltT14cAZWTe+nq5edI37i6h/SYD2odG7pI+0AQkiLxXaIbpDhATvbKYH3hz+Pjw6O0GboYLjFo7n3YJQ0l+yAb+qSfKpBwBGwbUWYxVgIsg2T5MyzhUe/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055334; c=relaxed/simple;
	bh=lLYdcpP8l0sl3j+g2NIycy9mtatAw6nyMR0wV+3DwnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ip4gfqspU1ItqZ8n9KGUx+XigBxEuSnc4E/6XV1oPScKBy8CkNU+NmkQY9yPla/YgY8CgqkcebVcCodauv6bODSDEduf4BSxGlhdsIAXGJfm8pZKyrOosW6MEdeiQgCiklq/iepvuwAsdERP6/R9jDfu2AQwb0ECeG0smyzCSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99E881655;
	Wed,  9 Jul 2025 03:02:00 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28E383F694;
	Wed,  9 Jul 2025 03:02:11 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: trbe: Add ISB after TRBLIMITR write
Date: Wed,  9 Jul 2025 11:02:03 +0100
Message-ID: <175205529062.223753.14752038288806898687.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609-james-cs-trblimitr-isb-v1-1-3a2aa4ee6770@linaro.org>
References: <20250609-james-cs-trblimitr-isb-v1-1-3a2aa4ee6770@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 09 Jun 2025 11:19:05 +0100, James Clark wrote:
> DEN0154 states that hardware will be allowed to ignore writes to TRB*
> registers while the trace buffer is enabled. Add an ISB to ensure that
> it's disabled before clearing the other registers.
> 
> This is purely defensive because it's expected that arm_trbe_disable()
> would be called before teardown which has the required ISB.
> 
> [...]

Applied, thanks!

[1/1] coresight: trbe: Add ISB after TRBLIMITR write
      https://git.kernel.org/coresight/c/ba3264a1

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

