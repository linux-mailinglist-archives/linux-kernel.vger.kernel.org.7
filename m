Return-Path: <linux-kernel+bounces-890798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEB7C40FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F90034C739
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CFD333753;
	Fri,  7 Nov 2025 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrbbQchS"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0F832E735
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762535441; cv=none; b=ruHU+5pc0Y6CyVnv1rnUrzAZ89h+XaFWbfLUgYB7jWbvYONHIpNTaQLHz2V6t+ET1PFAJmelLnABZyHFG33hbMQZgnPcO5g/iL/bjaw3WulUfUlLnqfPH4709s44AVwBPWPGflCl2oDSOPcBBXwOjowNWSSmEmVFC/JPRciWNjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762535441; c=relaxed/simple;
	bh=8A9BRxfIadLLstZJaqh2jLmOYxbXBNkC9JUGLqPWC4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I0SZEEIYDpG7J2XoiHd78TmSqZq7vzwz+byf+qPpMT3xaxkL9ZsphyHZ2gjTdlFhcBwsaP6goXlzoFYtXy0GusNXa7kVAoR2Bvqe5Aqsa6BW9Z9h6xnaCktL/RETZx4z0kJt5vEvhgt8GL1+gQCaGoXA0bW5M2vyAhlVkYGxYNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrbbQchS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so1668531a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762535438; x=1763140238; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U0ITIL8vh3vRmPUIo70J+o1CGFBjFKpfRbW7a+qctng=;
        b=UrbbQchSlMnVCqb4zmEO6T+5R43UzAAffqrZ3OuY7mJ74HZYepeGQWc3F13gNQ2VxR
         PG/4stPR6XZdpi88tGYOBuUNc8vnZxL4MesGDCIdTXy2u//hY2mZLl6QymMrBw/lXG5G
         N0sKq9Dm6/FFeak2bVr7ZM/x+SYM5W6tE9laIG39MM2mh20Aq7bBvREXU5QCUN6CUtEW
         d2UXPhiJhQVwt4iI75XlxwjAXzRMROPQ2+q4PVx9AzblRRF7SPa/m8CPGUdsHaRGs9tX
         3UDfgbn663z65DD4hHpdYChOTHy8d6UhXw/nveodTgI/pmiIXOTYQVEGkL5B8hhGFdc9
         Borw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762535438; x=1763140238;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0ITIL8vh3vRmPUIo70J+o1CGFBjFKpfRbW7a+qctng=;
        b=mnsfj29fl9P0dQi8UsJ5fbm1+0Z8KWFHFRosqS8JFTqHJ2XRIwXCwZiOOMJOXZismz
         hzb7q75Bwv+R53N5lM239zUkXV+LKePkBJNByPK7UJhmcShpTj5kirHFCiy4qhKsmp1U
         +VqBuPgtgIMeq23t2LiT1r7pq4D793lWnbd0/fU6nMLPaUdkxDNwntgJZ0jUVaJ3N447
         MLIBqijUIFr+M8XwW+XY17EgxvaK9hE43JUj91q4uyrEop9tz9Bj92ynlzgfKkNefagm
         HR1C7DLCmdm6CLONJCp+IgfELvaqgi7hCeauOoIxQ8f2uvrzrQtrcpORIlm90b3G6u2p
         GWTQ==
X-Gm-Message-State: AOJu0Yz33XUlFB4yMkQSDvgkBtyqNGstz0FfhsMWGA+BXEZgpUEZCyaD
	W5j6fb4FRbdYqQOrfqqdEtVIsgwXkfyQk/uV3fhYto+UEpPQ68c1NkyHs1xarg==
X-Gm-Gg: ASbGnctlmbVfb3kbhZXzViaBYnksYiwTx7a7mOrFC1V+hkqKjdRtugOEciapphWmd/S
	ZXL7lb8eDeq53rUYrW9aZjEEm4wTkIlTn+c1rF4fRGDV0H4qCNyO9c1Vo/IJbv9kMavp0sSDqom
	t5ATzEbgvVv/zj+X5qfDm+WF/hlbzjfaaylbr4xubWMaJynpEZNpXYR9HaifsA+sQobCN3Sv0qZ
	OpHnXMmbwDGlxGgO7iEnvZvkohtHUPxaIik8k6DD6qq/CtBUjHiIY+OEbSe3PmaDO7/a2Ys0Mrf
	JEzTPqLiRS1eiiPaikarpCuX9ELQnX9ly4XPazJbTKbPFgLDHJCJnagkaPtMG1vY9tsQ1Nu/4k5
	XkTbjFGFYabmUy8vtsVHM0XlJ2qYzBA54wz7HGHAHI2zaOsu+pd0XSq9VKIMF1FCIymoefWfzjB
	fgmp5CFGniN01diKQ8QuMj
X-Google-Smtp-Source: AGHT+IGn38L4h0sJwWuOq6UhhE5armbJj5+sYPEB1aU0dOTm+kaOrqfGyrr3ZAd8dJZ2VtqClUyLPw==
X-Received: by 2002:a17:907:60cf:b0:b6d:51f1:beee with SMTP id a640c23a62f3a-b72e001b360mr6597266b.0.1762535437928;
        Fri, 07 Nov 2025 09:10:37 -0800 (PST)
Received: from [192.168.0.253] ([93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b72bf9bdf15sm294714466b.62.2025.11.07.09.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 09:10:37 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Fri, 07 Nov 2025 18:10:08 +0100
Subject: [PATCH] regulator: core: disable supply if enabling main regulator
 fails
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-regulator-disable-supply-v1-1-c95f0536f1b5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAO8nDmkC/x3MQQqDMBBA0avIrDuQSKLgVcRFqmMcCBpmamkJu
 XtDl2/xfwElYVKYugJCb1a+zgb76GA9whkJeWuG3vTeWjOiULxTeF2CG2t4JkK9c05fdMaTG4N
 b/eCh5Vlo589/PS+1/gCBM34LagAAAA==
X-Change-ID: 20251107-regulator-disable-supply-405e47a4c565
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

For 'always-on' and 'boot-on' regulators, the set_machine_constraints()
may enable supply before enabling the main regulator, however if the
latter fails, the function returns with an error but the supply remains
enabled.

When this happens, the regulator_register() function continues on the
error path where it puts the supply regulator. Since enabling the supply
is not balanced with a disable call, a warning similar to the following
gets issued from _regulator_put():

    [    1.603889] WARNING: CPU: 2 PID: 44 at _regulator_put+0x8c/0xa0
    [    1.603908] Modules linked in:
    [    1.603926] CPU: 2 UID: 0 PID: 44 Comm: kworker/u16:3 Not tainted 6.18.0-rc4 #0 NONE
    [    1.603938] Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7 (DT)
    [    1.603945] Workqueue: async async_run_entry_fn
    [    1.603958] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    [    1.603967] pc : _regulator_put+0x8c/0xa0
    [    1.603976] lr : _regulator_put+0x7c/0xa0
    ...
    [    1.604140] Call trace:
    [    1.604145]  _regulator_put+0x8c/0xa0 (P)
    [    1.604156]  regulator_register+0x2ec/0xbf0
    [    1.604166]  devm_regulator_register+0x60/0xb0
    [    1.604178]  rpm_reg_probe+0x120/0x208
    [    1.604187]  platform_probe+0x64/0xa8
    ...

In order to avoid this, change the set_machine_constraints() function to
disable the supply if enabling the main regulator fails.

Fixes: 05f224ca6693 ("regulator: core: Clean enabling always-on regulators + their supplies")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/regulator/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dd7b10e768c06c83d2a4fb5dfd0fce8d796c9185..fc93612f4ec0c3ea3a68db5611abcf9d538c8010 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1618,6 +1618,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 	 * and we have control then make sure it is enabled.
 	 */
 	if (rdev->constraints->always_on || rdev->constraints->boot_on) {
+		bool supply_enabled = false;
+
 		/* If we want to enable this regulator, make sure that we know
 		 * the supplying regulator.
 		 */
@@ -1637,11 +1639,14 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 				rdev->supply = NULL;
 				return ret;
 			}
+			supply_enabled = true;
 		}
 
 		ret = _regulator_do_enable(rdev);
 		if (ret < 0 && ret != -EINVAL) {
 			rdev_err(rdev, "failed to enable: %pe\n", ERR_PTR(ret));
+			if (supply_enabled)
+				regulator_disable(rdev->supply);
 			return ret;
 		}
 

---
base-commit: 636f4618b1cd96f6b5a2b8c7c4f665c8533ecf13
change-id: 20251107-regulator-disable-supply-405e47a4c565

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


