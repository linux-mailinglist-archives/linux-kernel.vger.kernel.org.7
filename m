Return-Path: <linux-kernel+bounces-879820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B13C24181
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AF474F68F7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF34232F774;
	Fri, 31 Oct 2025 09:15:53 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC625C822
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.87.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902153; cv=none; b=RZrMfAtEuxJFGZsvzDXydgIWeJzQa5yuhqvBYWIFK39DPJ7o5dmN9Pnw76vQQ92pJ4mK47umga8MQTa8PX+vwuEBdTU43BUhAkePnIe+cf7lHUlPXii1np6/vVldADypnYUY3HbkGEpok2ItHqbTtAns2hYK2vYfLJuBbGdpweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902153; c=relaxed/simple;
	bh=qxGajjMxzUe6qLPmsmmgiEaeJyORV57ONpuG7HCdhNA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOsxRdpPLwzdWx4DWIzgnQ66KFmdXdLi+ykjslIvnm4YhRe6Ke2nlEAsLiyzdshHVxQj8cKcY6TjjUSchA1xUqy924O7bDsoTkfL0sGmYYs0nmBNa5IvrgEAMW8shmHfUAwDQZnabeXhAznQYbdeqCSjzndYYgoQJWp0JxQRocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.87.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4cyZyg578fzB8NPw;
	Fri, 31 Oct 2025 17:13:15 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Fri, 31 Oct 2025 17:15:38 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <mark.rutland@arm.com>, <catalin.marinas@arm.com>, <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stone.xulei@xfusion.com>, <chenjialong@xfusion.com>,
	<yuxiating@xfusion.com>, shechenglong <shechenglong@xfusion.com>
Subject: [PATCH v3 0/2] arm64: spectre: Fix hard lockup and cleanup mitigation messages
Date: Fri, 31 Oct 2025 17:15:04 +0800
Message-ID: <20251031091507.1896-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <20250918064907.1832-1-shechenglong@xfusion.com>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03047.xfusion.com (10.32.141.63) To
 wuxpheds03048.xfusion.com (10.32.143.30)


On Wed, Oct 29, 2025 at 11:45:54AM +0800, Will Deacon wrote:
> Is the compiler smart enough to store a single string for the
> "mitigation disabled by command-line option\n" part? If not,
> you might want to use %s to avoid wasting memory. (I was going to
> check with llvm but I'm unable to apply your changes due to whitespace
> corruption).

Thanks, Will, for the helpful review. v3 incorporates your suggestion by
factoring the common suffix into a single const string and switching the
pr_info() calls to use "%s". The whitespace corruption has also been fixed
(restore tabs, no line-wrapped literals), so this version should apply
cleanly.


This series addresses one main issues around Spectre mitigation messages:

  1) Avoid multiple copies of the common suffix
     "mitigation disabled by command-line option\n" by using a single
     constant string and "%s" in pr_info().

v3 changes:
  - Fix whitespace corruption (tabs vs spaces).
  - Factor out the common suffix into a single static const and
    use "%s" as suggested.

shechenglong (2):
  cpu:Remove the print when the CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY
    Kconfig option is disabled.
  cpu: fix hard lockup triggered by printk calls within scheduling
    context

 arch/arm64/include/asm/spectre.h |  1 +
 arch/arm64/kernel/cpufeature.c   |  6 ++++++
 arch/arm64/kernel/proton-pack.c  | 37 +++++++++++++++++---------------
 3 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.33.0


