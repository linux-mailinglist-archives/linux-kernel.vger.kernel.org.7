Return-Path: <linux-kernel+bounces-863992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE8ABF9AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0F494F3D94
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66DF13959D;
	Wed, 22 Oct 2025 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="m9mNLPVB"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031EB652
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761098424; cv=none; b=BX9xosqL+VchjK7xiZtGYc5uoCeC3Rq4wKIARRXREQl947LgmPywj1Qxkff5OWDwrsGDhgaTrqxjzhai3Nbhf5BhzfApnuvXdsP8rY75b8T4hncytn4XKNIfWCpiMohCEmnpyfF9Zx48Wj9K06m7OuG5DZjm+fDdDQFn3KbCpFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761098424; c=relaxed/simple;
	bh=PD7yEkPGAklmSGlrlki1NY4UYflEx5rWR/HZANJ3w60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sSgF7ENt8o1Rk5W0wfR8YSkmTIpMbg8AIC1nQtg3odYfBOguvRefPS1YTAaf+6CMgqPCvalJT6R2bR/yQ8C7hc3wyKYi28UA8MaL9BA2GbtutvDzMtz8t0Ho+k+i4yo4jUY8n8Kd0By/tlJugxolbDm2wKwD8Y80bUlb0RZmO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=m9mNLPVB; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761098349;
	bh=SyGZyMLIKrMdERbfgHg3j+Nq1VVp/eWFMTGPVyHMtnI=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=m9mNLPVBxMWfwR6QO/PNzMFTXYg0wN/YTYlT77nFNgLTahSmajbpe5v7VMMP3J8rV
	 GPI1DKIsVPPd866oxR4odm9Tn4uaI/RRt5Zj+3HASBjQUDgnbOl4Q6bZ6MXVGrk3MD
	 mmjXgPNZK+qtEbVaH4bYrRNI5kz7E0UCQuA56Fm4=
X-QQ-mid: zesmtpgz6t1761098342tc3490975
X-QQ-Originating-IP: Cklzy8kHGAwOqZzVLHHNpblhtpwHCYPjxH0LvhM3KPU=
Received: from = ( [14.123.255.147])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Oct 2025 09:59:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2133142105877688065
EX-QQ-RecipientCnt: 8
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Wed, 22 Oct 2025 09:58:48 +0800
Subject: [PATCH] mfd: simple-mfd-i2c: remove select I2C_K1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-p1-kconfig-fix-v1-1-c142d51e1b08@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIAFc6+GgC/x2MQQqAIBAAvxJ7bkENo/pKdMhcbQlUFCII/550n
 IGZFwplpgJL90KmmwvH0ED2HRznHjwh28aghNJSKIlJ4nXE4Nij4wdHq4yerRjM5KBFKVPT/3D
 dav0AKUNnfmAAAAA=
X-Change-ID: 20251021-p1-kconfig-fix-6d2b59d03b8f
To: Lee Jones <lee@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, kernel test robot <lkp@intel.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761098340; l=1223;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=PD7yEkPGAklmSGlrlki1NY4UYflEx5rWR/HZANJ3w60=;
 b=/S4nZiaQVv3tCCnurnMx+ofSPeEI092LxcLb8iHHVQboONJc8uDDhh9xmCr+Ju4ww/GeWoozh
 M4aKR5KHvyeDt17CPAGH4LTszCmSvZb/g/uMRrqvSnptFr7KJrtJWZr
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NI7LLrmLuCc6+kq67em8YHiGCNlEpXDBMoBEcvykqIuyaCxECQIVwXZA
	iQ8g5JysowP1lvff4mHxqCvWBIOWH2oYkqc0GQa12+yR4rm2o/d5k/YIk7p0o2/o/5IjQm9
	W0uGUtjL12RdD0fD9y5/KuNBy+7+tT68vvSPqHOWGGgKSVnbjgNAUHsB9GScdkBoNTJfgiG
	99ONpm+vcMHleE02ynhiTcw9ItYpB7rjSwBwXNPogk5b6bY48tUXm9phvtVXwz8BoeTPVbR
	m1iF6m/GfNT04ybMkFmgGqDlEsubBBVAs1COlojBZ7+CFfapltBL2Mxn1CyBXW/sKvjvGah
	7ggmdwi8x44e25YDzDx+SCQyhfJ50+hYGatJzdhCCY+3A9mi+W107H/PRGbW7YkNZrtodg/
	Ps1AkeNB8pgWErxQdTBYFZDe9DUNXlVsDCwZsIAQdDtwbUHpTwA3oEqVEFWgU53ioO2YF8Y
	Bx4SI6slysuzSVHvd4yWiXdv6PevC1tmqRY5J4BygVaWGvMe17aq4duvVw2xp6xe9hH4a9S
	V9XdUsdI1Ri083OJZAYKitbjN6gcGo5ZxGO/NeMmoekNyYslm1n/G6laHCk3nMED9nCpCpc
	/Cer9KNm/Qcl2WcBb0puYlM8MFuuB0c/qMRSK5O+p4pwPLNhY5H4M7qz9siYpOp34EecuEi
	RVRgHe5mccwcXRBFWK79yE3tBaN8/CGsyBmJ7RL0OSMFqRV7WnLGW/0TElqXp6Owgy4PRoh
	HYzvCQRzIHExxiN1ZuO/cTYmybVlBgPt5tvRmHqxqllyG8u4xp7EaQfeNLakkmSLWAafu+H
	nEhlMH5ySIS/3VQifYWHHcA+JJcuNiAE646S+meoPJoBRvRQ8XGlWBoTMZtMFwpDzQ+M2Cp
	KfuXrQt7+nYF9NuzMp44YQddClTqC7QmtE62l/pOZTTxsLEidOjrjomXPu9svjcHQCB+sI4
	nJ8PrE4t1xmqYqCF7bQf4bKcNxERD6II5oxXcDjEcnAqqZsc4aOkkZqsicJ3bDkIPsTZRdd
	AghgUTNHs6/f3vLSlOD1DTIaShyIRvPC6Xiack3zZqHJaMNnjfLcLdfI9Klm800VcDRzDym
	HRE72+xNXn1wDiMW5MW6nwthcCY4pk/5knzTyQcfzycodrBlojvsfLT/7j3qSare5oDPCZM
	RZMb
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

select will force a symbol to a specific value without considering
its dependencies. As a result, the i2c-k1 driver will fail to build
when OF or COMMON_CLK are disabled.

The reason for removing I2C_K1 instead of adding a depends on condition
is to keep the possibility for other SoCs to use this PMIC.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510211523.sSEVqPUQ-lkp@intel.com/
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 drivers/mfd/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6cec1858947bf7ab5ee78beb730c95dabcb43a98..ea367c7e97f116d7585411fff5ba6bcd36882524 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1258,7 +1258,6 @@ config MFD_SPACEMIT_P1
 	tristate "SpacemiT P1 PMIC"
 	depends on ARCH_SPACEMIT || COMPILE_TEST
 	depends on I2C
-	select I2C_K1
 	select MFD_SIMPLE_MFD_I2C
 	help
 	  This option supports the I2C-based SpacemiT P1 PMIC, which

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251021-p1-kconfig-fix-6d2b59d03b8f

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


