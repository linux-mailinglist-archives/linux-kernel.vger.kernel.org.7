Return-Path: <linux-kernel+bounces-807889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EF4B4AAC6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB081C27E50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2A9318157;
	Tue,  9 Sep 2025 10:32:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627CF2765CA;
	Tue,  9 Sep 2025 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413968; cv=none; b=qkST6ylKxNvEH10Tr0n4SZVISdMGBI6fWIAWrGmJ4Eg/DOBn25ClsGzCTuL4YyG3+I0UMP1JvU6n+mC5/L8UWeZCUojP4k/hl+TdbiU4ZxJJ9JBBQsW6I9I8BEkkjsEcWRnr1qPtyuj5diQj1PJC7yqH6t3saiX6Af0VtjRlH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413968; c=relaxed/simple;
	bh=ZsAPaSFb4QtZg1NreJIEvMKmWzUX2F/c308tqXb/1ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqtlN2Z8fUr5KUWcrh0Xt6RRiCrFmggMLHEgGiEtu19/42V0VyFPsObrERa7ZSW/+SaXuc+vFo4gq/kBMdBika4D+jsIADhDdXecdrBO2smLsMgn5Fy4oQcsCA1KtcYb+6t5JpvQk0kHViopZu4aG96FrZlVCezx4vQ+wsMBIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72FCC113E;
	Tue,  9 Sep 2025 03:32:37 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6C9B3F66E;
	Tue,  9 Sep 2025 03:32:43 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	arm-scmi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/6] firmware: arm_scmi: imx: Dump syslog and system_info
Date: Tue,  9 Sep 2025 11:32:41 +0100
Message-Id: <175741387444.137822.14283463881745824228.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
References: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 04 Sep 2025 18:40:41 +0800, Peng Fan wrote:
> System Manager firmware provides API to dump board, silicon, firmware
> information. It also provides API to dump system sleep, wakeup
> information. So add the interface for Linux to retrieve the information:
>
> patch 1 is to add doc for board information which was missed before.
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/6] firmware: arm_scmi: imx: Add documentation for MISC_BOARD_INFO
      https://git.kernel.org/sudeep.holla/c/646c0c9e06a6
[2/6] firmware: arm_scmi: imx: Support discovering buildinfo of MISC protocol
      https://git.kernel.org/sudeep.holla/c/cc798b105070
[3/6] firmware: arm_scmi: imx: Support getting cfg info of MISC protocol
      https://git.kernel.org/sudeep.holla/c/d3e25c244d53
[4/6] firmware: arm_scmi: imx: Support getting board info of MISC protocol
      https://git.kernel.org/sudeep.holla/c/88d3671baf41
--
Regards,
Sudeep


