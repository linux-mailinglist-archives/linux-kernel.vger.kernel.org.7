Return-Path: <linux-kernel+bounces-882234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A76C29F08
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5491188EE35
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A950288531;
	Mon,  3 Nov 2025 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7xofzxX"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3722F74D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139961; cv=none; b=aXk37m5YN2+D1w2R/Bkl0ahCmSe37jCS+F4JzLuep4aQoQVx4aaQ0Vk/vtBbzFsiFUCGhcKpEhyAeVxl/zjMk/OsBOCMXlsDcEMaYf6TEOeZl3/Tl6+bJcGlWT+e+0JszF2PewJwMSozmW1UZgwMnuMTI4YwrU4PIgovNDwwCHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139961; c=relaxed/simple;
	bh=ziBDk35TYk7YiW6K7GPffNVDP98Fs1iA4htR5FdmfDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XyvXcuIELvOxE+688hHB6Axa3enAJrF9ow953qsF2Me/IBLHDtiLJwsoQezBQgv4S4vRSopyz9shoVZ5SC6Vyh+R8nKfUTxIOI4KUh6teF/CUjCT1B+WiP6OA5cj0mOTO6MhTYG0m612MoKqLVNBkU7avjB6YkWU0qJB2N5vaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7xofzxX; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8af121588d9so102061985a.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 19:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762139958; x=1762744758; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QiKTLSU3N8p12FQc+H8NuC8MRpkLZYq4zZdU+gN4fiI=;
        b=F7xofzxX03sjA9SZdz74C7lHYox4yBgkOuvCR/vcuQfh5Gi3Tz6fGuSvyTQppcgfrf
         w3nxUVJNSoWs2tc4PhBMX8T0NpCyMyFHhnrx0LEftfJoHI4ha1vLWd959DxdXClxDjow
         jZtjA9+U8tSmwgjEc0DTyo9+NdCCxK3o/xUICQmQqoF1uHR+8jTkCHK4nC71Pw5+EG95
         qivn6Cm05uAcSf8k3mU4vZT7vslMK/bXYPxA812PjXzQnf1wq3DzRYl7felUmBEkOGmI
         naMiozt4/fyl9cg7pElGxsNuzknwCve/sFur4ZE58vu6sfOqYeP7oRPG1hEmJDr3j7ve
         FVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762139958; x=1762744758;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiKTLSU3N8p12FQc+H8NuC8MRpkLZYq4zZdU+gN4fiI=;
        b=u2COzCjn3HpGNMb1wSV46HEgPTMRshkaOzcSnYewXA/cYYk69dzhv2A1h59x3M8MOr
         /kuYQZElb0qyLozIs7LT7Mca32aUcNgjGhQC/82bY08sSDEJBz30lcig6sWREMgY8FPB
         DY9QjfBdPJYmHp3rC3YIqJUv+NuXfAMrgHivVg8J5VP1rzi+LlBXV0XLV/9zcxp27j50
         e1IXqQyf5kZ/Nsghkbh1cvBkNqkjid4hOr/fVGLjtKqrqJCgmKviP94d3FINxJJSe9dB
         P1eDUkxTXb69iq0GD0vBFT0Jfse89in2OMPvJ5t83Jw3iVdWomu4Lef+CLSmIC069Tke
         a8GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe+TerExCoWRon1wYcFvjmnL1reaLPLHkM+OjXG25zKbbh8+LppuzzT4dGnHZM5aIh8rjV9dJ/OmYoNcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVClG5/o8H90sT3w4R0nolCXkStMh6HNzu4kQuVG3GJEcOSqFn
	VhejsraHE74c4pNixzoeJdE9e67zTT9VngNMc/pvQaFC3Ce633q/tBQS
X-Gm-Gg: ASbGnctLZJGpZNixMNJhPLYWIp26MAPmMFFa4ONivBePh+YKJfAkfNOs/KX0vot/Gyt
	S5CHsGZ9rGUwoxcbA431G7u0UdZcz6uUUhiBtQTzXOFG3HfHFtOtPeMmyvUzZgmqwUUBLTy3kfs
	Rv+Dr8QmHPvwcxtvkpMA+baPW2pILk/KvhFbAcq2zVx5PU6ynnMMuhxTnQpFDMNNWylrpjQ2AJ9
	BEEbX3OfeqfJWMAEesitr3+7u9kdChASbA8a5m629O5zlZoIjYnYAUYayQkbT4oBi32g+VQsHcV
	NVPynTsO3keDlZxHOWcHo76VpOdzylwyIer9WMvQgQcFGB2TXOJEG/dVbJVaCY+iyuNmsOYgNHj
	YToz9zNM7msmudURTA0p9UnMF3gJEjFioTM9h84oUL+YQ71ZvjEBK2ksnRUHlIR5zON9F3J9OxA
	4Nx3nUKA==
X-Google-Smtp-Source: AGHT+IE4NH3mqhfFMGevhbXMAQxKll+ttwxjlpittKvsFjn+CaMQpOl2cv8RmzF3ghkopKQb71oVug==
X-Received: by 2002:a05:620a:370f:b0:892:636a:5675 with SMTP id af79cd13be357-8ab9ade53ffmr1387887285a.58.1762139958109;
        Sun, 02 Nov 2025 19:19:18 -0800 (PST)
Received: from [10.73.222.215] ([142.182.130.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac03f50616sm586898685a.58.2025.11.02.19.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 19:19:17 -0800 (PST)
From: Samuel Kayode <samkay014@gmail.com>
Date: Sun, 02 Nov 2025 22:19:08 -0500
Subject: [PATCH v3] MAINTAINERS: update PF1550 driver email address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-update-email-v3-1-8e2c4a4507f4@gmail.com>
X-B4-Tracking: v=1; b=H4sIACsfCGkC/3WPQW7CMBBFrxJ5XVeecWwMq96j6mJij8FSQ6gdI
 hDi7p3AolWlLv8fvac/N9W4Fm5q191U5aW0Mh0l2JdOxQMd96xLkqzQoAODW30+JZpZ80jlU+d
 AQ48JyPFWCXKqnMvloXv/kHwobZ7q9WFfYG3/ES2gQWcbcu+IInJ426/9a5xGtYoW/IHBwB8YB
 YaNS4jAsTf5N3x/zqr8dZbn5uc2NVBjLfexzLuONsmjc2SGbA1Gg4GiD8b53ltLXga57AGSyO7
 f9chebTEBAAA=
X-Change-ID: 20251029-update-email-f8ab42d1a5e9
To: Lee Jones <lee@kernel.org>
Cc: Lukas Bulwahn <lbulwahn@redhat.com>, 
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>, 
 Samuel Kayode <samkay014@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Sean Nyekjaer <sean@geanix.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762139957; l=1937;
 i=samkay014@gmail.com; s=20251028; h=from:subject:message-id;
 bh=ziBDk35TYk7YiW6K7GPffNVDP98Fs1iA4htR5FdmfDY=;
 b=ziXHDkBCkPPalk7Y9MwodVSJGPE4Eb2svQ5s3l1Q1PdMrCt3OHBJY5qgsSHpibllG+gdqqxfr
 mgZ2ua0CkxjCFisZ5ZJczWkKvmrDNjmZgKgh+KP6FptmivPHA4+Zeaa
X-Developer-Key: i=samkay014@gmail.com; a=ed25519;
 pk=favoK08ilD1j62PrGf+RHihBzbqJGWMC6f2nszR5UIc=

Update Sam's email address for the PF1550 PMIC driver.

Signed-off-by: Samuel Kayode <samkay014@gmail.com>
---
Changes in v3:
- update .mailmap
- Link to v2: https://lore.kernel.org/r/20251101-update-email-v2-1-175d221ec40f@gmail.com

Changes in v2:
- rebase on ib-mfd-input-power-regulator-v6.19
- Link to v1: https://lore.kernel.org/r/20251029-update-email-v1-1-f38f45aac2e8@gmail.com
---
I left Savoir-faire Linux but I do intend to continue maintaining this
driver.
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index d2edd256b19d6d68e2f4268b098b1845b9bddf08..857054460bd9f971421082b958e207ebdedf63cd 100644
--- a/.mailmap
+++ b/.mailmap
@@ -686,6 +686,7 @@ Sachin P Sant <ssant@in.ibm.com>
 Sai Prakash Ranjan <quic_saipraka@quicinc.com> <saiprakash.ranjan@codeaurora.org>
 Sakari Ailus <sakari.ailus@linux.intel.com> <sakari.ailus@iki.fi>
 Sam Ravnborg <sam@mars.ravnborg.org>
+Samuel Kayode <samkay014@gmail.com> <samuel.kayode@savoirfairelinux.com>
 Sankeerth Billakanti <quic_sbillaka@quicinc.com> <sbillaka@codeaurora.org>
 Santosh Shilimkar <santosh.shilimkar@oracle.org>
 Santosh Shilimkar <ssantosh@kernel.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 2a9330f05e2fca6b8661bb698dea17dcfd7fc254..c44d2cf7e7b85104a6eb09142da8ef3d9fa7e55d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18608,7 +18608,7 @@ F:	Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
 F:	drivers/regulator/pf530x-regulator.c
 
 NXP PF1550 PMIC MFD DRIVER
-M:	Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+M:	Samuel Kayode <samkay014@gmail.com>
 L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml

---
base-commit: a7d6255a0bf302c028ac680564633a6aac5f611d
change-id: 20251029-update-email-f8ab42d1a5e9

Best regards,
-- 
Samuel Kayode <samkay014@gmail.com>


