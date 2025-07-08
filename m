Return-Path: <linux-kernel+bounces-721892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4562AFCF3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472583A6896
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F2A2E11D7;
	Tue,  8 Jul 2025 15:26:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524B92E0B7C;
	Tue,  8 Jul 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988370; cv=none; b=uPzNCmaHSacTOTM4MvROe2dcrrfIDaKauTKCjuRJqHsu0CpMH3hU40HpeVihcAa33lX9iipaaLMBOqGZZDMZu6CSHA3/wobGy4BWZW0ZdEjr/cJu410nv6LCbUwFSv4j3jY8ClTqXDlew2AS0rcgXQhGys5qGTchnHotqkKu+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988370; c=relaxed/simple;
	bh=vGnNBHokt2cN4ticDDpECNitDllhZ3Cs910v4LNMOHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYMdIh633f06lXeIw52vVg9tiqNLtOmg1jU3OLYHQf94Wo/GeRxokACYzVVhIIzrLooGu4sx0RLxKR/L2gn9+qO5P1JkaxB6USzFU89eKV9QL+xQs01/g2dCLRQvDEkho3Udwayt3O1fMlXvoNZ8wfmaFescyyibLF+DZ/tmHCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A77DA1595;
	Tue,  8 Jul 2025 08:25:55 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 167B83F738;
	Tue,  8 Jul 2025 08:26:05 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
	Chuck Cannon <chuck.cannon@nxp.com>
Subject: Re: [PATCH v2 0/2] firmware: arm_scmi: add pm ops for scmi_power_control
Date: Tue,  8 Jul 2025 16:26:03 +0100
Message-Id: <175198830381.785998.16571714646012056824.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704-scmi-pm-v2-0-9316cec2f9cc@nxp.com>
References: <20250704-scmi-pm-v2-0-9316cec2f9cc@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 04 Jul 2025 11:09:34 +0800, Peng Fan wrote:
> Move information could be found in patch 2 commit log, hope it is clear
> 
> When testing on i.MX95, two consecutive suspend message send to the Linux
> agent, Linux will suspend(by the 1st suspend message) and wake up(by the
> 2nd suspend message).
> 
> The ARM SCMI spec does not allow for filtering of which messages an agent
> wants to get on the system power protocol. To i.MX95, as we use mailbox
> to receive message, and the mailbox supports wake up(interrupt is always
> enabled), so linux will also get a repeated suspend message. This will
> cause Linux to wake (and should then go back into suspend).
> 
> [...]

Applied to sudeep.holla/linux (for-linux-next), thanks!
(with some commit message changes and removal of #ifdef)

[1/2] firmware: arm_scmi: bus: Add pm ops
      https://git.kernel.org/sudeep.holla/c/76e65f7a0e0f
[2/2] firmware: arm_scmi: power_control: Set SCMI_SYSPOWER_IDLE in PM resume
      https://git.kernel.org/sudeep.holla/c/9a0658d3991e

--
Regards,
Sudeep


