Return-Path: <linux-kernel+bounces-722538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D91CAFDBCC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9860F54212F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67402356CB;
	Tue,  8 Jul 2025 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njGOOaa7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F25E22C339;
	Tue,  8 Jul 2025 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016796; cv=none; b=WzXAWA2fYD82P5tpGF9w1eWyquk2v/5Glec4Qv+mKdcsSDHzAWeZOBFRSUxhGdKL1ek9ZLi7CE1xu5QxHup5d2fOjrqNQRWxkTyyW+taiq+MMXq87wx8Xl2ZyQ9kzf2y1c5RJMrSwZkQ5X/O8a4HHzSsU2TDkDz6pOfO3C72mek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016796; c=relaxed/simple;
	bh=yGk2hIbUU8nqBat0b7HjvVPnWzRAzp9QCNCVRm7eJ0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PW+QFYnumWld4qkpqzu6hX19tZtjzMi2UdX6ajh6ziTylKLxRjUTxehDdn1+4ytz2tGuHcZevWsSdY+bMH3LlfNRAcGr+g+HeGvvPVzDYkCy71VxYF/4Gd+2WbNBS/txKUy/+e3QqrhN4D00isQqfVl8ZAqtu8g0RV/PHOGlk60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njGOOaa7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB84C4CEEF;
	Tue,  8 Jul 2025 23:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752016795;
	bh=yGk2hIbUU8nqBat0b7HjvVPnWzRAzp9QCNCVRm7eJ0A=;
	h=From:Date:Subject:To:Cc:From;
	b=njGOOaa7r2snOxdR9RqYyyA0ATqegW3jktoU0QmHp9cco8GEnQSOpuhm4D+hDHLq4
	 lKZZySIy5//2GNbeeNbmKO8nzfVLoBY1jFFAzHgCGY+9KytvZhk3p9Rbr/68V3mHyH
	 X48X6MIlJ2d9oh3vfi2l9VNHQI72tcwRNwGlQ8eVI5EXnY0d3xEO4o0c9RikbEFpTa
	 GHGf/3fq8DZpmc3lYwx4T0JXNW7qZCvAx+xzE/KYp/jBzNOVk5PWx/iCkScdZKWRhZ
	 K/L/WW59DklkP4zpezdFqoE6ED19qgbX6EfOeE2ou40ePjYyrBdam6nckDI+WT6Vcb
	 EYAsb2X6hgnoQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 08 Jul 2025 16:19:50 -0700
Subject: [PATCH] firmware: arm_scmi: Use modern PM ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-arm-scmi-modern-pm-ops-v1-1-14bc9c352888@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJWnbWgC/x3MOQqAQAxA0atIagPj7ngVsZAxaopZSEAE8e4Ol
 q/4/wElYVKYigeELlaOIaMqC3DnGg5C3rKhNnVnBjPiKh7VeUYfN5KAyWNMita11FvX2N6OkOM
 ktPP9j+flfT8ExVcpaAAAAA==
X-Change-ID: 20250708-arm-scmi-modern-pm-ops-9c4e69c39698
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Peng Fan <peng.fan@nxp.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=nathan@kernel.org;
 h=from:subject:message-id; bh=yGk2hIbUU8nqBat0b7HjvVPnWzRAzp9QCNCVRm7eJ0A=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBm5y2du+jzRy/nFPqUVDlyh8Yxb/c6tTJ10+kTe5SoPF
 snHxzaXd5SyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJTGlj+MMTW/JgttOdd0Ib
 PaZ57ZnGEKIZnuvRGbS5x2/p01vCSi8YGT588E/pfpj1PX1SotMjcxnxs0z1N3Jsf23xntBd1Jz
 vyAoA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building without CONFIG_PM_SLEEP (e.g., with hexagon or s390),
there is a warning because scmi_system_power_resume() is not used due to
how SET_SYSTEM_SLEEP_PM_OPS is defined:

  drivers/firmware/arm_scmi/scmi_power_control.c:363:12: error: 'scmi_system_power_resume' defined but not used [-Werror=unused-function]
    363 | static int scmi_system_power_resume(struct device *dev)
        |            ^~~~~~~~~~~~~~~~~~~~~~~~

Use the moderm SYSTEM_SLEEP_PM_OPS to resolve the warnings, which is
what SET_SYSTEM_SLEEP_PM_OPS ultimately expands to, so there is no
change in behavior.

Fixes: 9a0658d3991e ("firmware: arm_scmi: power_control: Ensure SCMI_SYSPOWER_IDLE is set early during resume")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/firmware/arm_scmi/scmi_power_control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/scmi_power_control.c b/drivers/firmware/arm_scmi/scmi_power_control.c
index ab0cee0d4bec..04202ff8094d 100644
--- a/drivers/firmware/arm_scmi/scmi_power_control.c
+++ b/drivers/firmware/arm_scmi/scmi_power_control.c
@@ -369,7 +369,7 @@ static int scmi_system_power_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops scmi_system_power_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(NULL, scmi_system_power_resume)
+	SYSTEM_SLEEP_PM_OPS(NULL, scmi_system_power_resume)
 };
 
 static const struct scmi_device_id scmi_id_table[] = {

---
base-commit: 990e0418abe33d34e51a04cd7a71c2e044985836
change-id: 20250708-arm-scmi-modern-pm-ops-9c4e69c39698

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


