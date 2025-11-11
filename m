Return-Path: <linux-kernel+bounces-895741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D421FC4ECEE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687613B9077
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC97366571;
	Tue, 11 Nov 2025 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU+jyq/j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD59365A11
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875233; cv=none; b=Xsyz2Vb76AA9y8VjnCDolJn6G8hU66yqGs/bUv8xkJ+l2+cOSCPp0IPCsnUOTiLB5z5VbuYJWnD/VrRLC9l5IILOrJ+X5zh2ShGgep708Tj29gX3g/oNWkuWdK2uxNXxOgox1YVmI3DhHVd7Fcw47nGIUW/U4rRfvZO8jokkmmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875233; c=relaxed/simple;
	bh=2jMDg+QHdHlRTSJ0zg2sQJ9ilhg+oF6rX46V3GXGO6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJYnIwhJQfiyEUtZOLPv5+iw280mSJ7VLW5BtXUheS7gf/ivtrrIiVoQWxlVygpYeTnRPmpPqjFktXxPQb4gd60mGya0R2PpChugP7mvQFL4iknQynslosTW1ckIewnU5TuvGJ346ALmO1UKU7nO86x21s2i3f1r40w8ZuIcsEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU+jyq/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C6CC2BC87;
	Tue, 11 Nov 2025 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762875233;
	bh=2jMDg+QHdHlRTSJ0zg2sQJ9ilhg+oF6rX46V3GXGO6M=;
	h=From:To:Cc:Subject:Date:From;
	b=cU+jyq/jUAmeRp+/80kFvwNRZQzAKoH9GZTIc47ufg6tCL2fnw5pJldjWdiavKuci
	 x+VYX6nWoKQe4aKuvLo3wfeTWyD14h41r2sH4SpRJwiyB5pJJ14X6fHrjEmTmoAlEE
	 w5yHwD6F/7hhF61gsvvb+UWBkLWcyIlH3jZdsHwIs0J7QhmnjI9M4d60Jzj/x6D1Qi
	 tyqdPRTcXMsbrniFozEcSDR3mS1CLhjAG1eNYAICgTqLkD/haNAiCjWOPYth0QCHHm
	 Gqd5co8exlUVGt3Uz9y+zUFjD7/dWWqsfUnCDFyEeSd4+6HiJ+OZAZOiKEbD6nB46V
	 MntJX4orDQCYA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIqNW-000000000B4-2Dk9;
	Tue, 11 Nov 2025 16:33:55 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] clocksource/drivers: Prevent clockevent driver unbind
Date: Tue, 11 Nov 2025 16:32:23 +0100
Message-ID: <20251111153226.579-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clockevents cannot be deregistered so suppress driver bind attributes to
prevent drivers from being unbound and, for example, releasing
underlying resources after registration.

Note that the NXP STM patch depends on the recently submitted section
mismatch fix. [1]

Johan


[1] https://lore.kernel.org/lkml/20251017054943.7195-1-johan@kernel.org/


Johan Hovold (3):
  clocksource/drivers/arm_arch_timer_mmio: Prevent driver unbind
  clocksource/drivers/nxp-pit: Prevent driver unbind
  clocksource/drivers/nxp-stm: Prevent driver unbind

 drivers/clocksource/arm_arch_timer_mmio.c | 2 ++
 drivers/clocksource/timer-nxp-pit.c       | 3 ++-
 drivers/clocksource/timer-nxp-stm.c       | 3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.51.0


