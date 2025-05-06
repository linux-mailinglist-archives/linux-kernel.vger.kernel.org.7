Return-Path: <linux-kernel+bounces-636040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F04BAAC54C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 15:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E9C7B3A9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C352280329;
	Tue,  6 May 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzGa3alC"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59E21773D
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537027; cv=none; b=YDWK4InNLYuQEytoWMJ513GpxLUyjfa8OJLlKPmF57d6iZQmNEaYaEzonFsofT6DgdxxJNAzV5PeeODQ0zKYwc3bjfTM9nvxDc0/p4qQfO4U3EV/pcAGp6lx7ZFc2e6B7A0kzmnvIKDuh0pgwh0BvOBB++uEB9bmJMuVLv9ngtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537027; c=relaxed/simple;
	bh=6mA6iTRXWXZ1yOt7qM2S0V/T0zHayKp4IhqSJBG4MFE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZjDBiqLcZshMsIhbV8dHJn6tB8PQfIHR0tTn6MeZtSuhYQ/xvhwUS2HD1BoxwrXnFjXR/Nu3B3b17xqtKX50EhpYqqIdAO8luDnx86iobcyN4CU+7qZx77lDsj/wC9uOH9OCtTi4C8Puss2h1rrWmCM22k7oer0ANr7whM6K7+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UzGa3alC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so4197743f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 06:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746537023; x=1747141823; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eVSozHIL1R1kO0geupLABCS2zCL42BF9GBcy5eQEopI=;
        b=UzGa3alC5N4eAV39c7+SsmDiWDtNzRWGK6seEdZ2nwyq0MFnb+163Lxk2noxlXlyzK
         yHvB9JopgUAK6Cmw5Jz7BErXkIshWMSwhPWs6DojM4dYMsZm4hNRoB04GkXwNEJ1efJS
         0ipacx84IpVPLY5+QG7SdMtERjq5ZtM5AiMj2lYLzDkresYriAH+e2JQtwAriNSiKqQG
         20Do67KbVOxXQEvlzUtFjZupt4HYnMtNbe+qfhPCw3kP4mlK3FqPXZtR+XRz/7SHM+K0
         CK2Hg2DkzjXsewHA1m14zn49gVvlSw6+38fLWIts2R3OpPTGo1++MPMOXGMvRYVmEPrM
         kNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746537023; x=1747141823;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVSozHIL1R1kO0geupLABCS2zCL42BF9GBcy5eQEopI=;
        b=GCGkmxPq7aqtKzCso6spEC5GM9XzRzxRyOVG6wP1shKjPuj7ssfquzyfGxRLfjuTQ2
         4Bp4rFxiNaY2f5doio2D6lTrm/Ni1MlIopT/WzSNXyfXv6Nsj/0w5IYdKrhFstme/+rj
         NWdJ2MC+4n3D1PyoQCGvjpwDX0N/iEBjykbyxNZSGRCtYuQgYaV51frjVI66/e/VqQh3
         ALOpezmJcduSFp1hdtAt3y73PVb4hf0fuCUeXNQlnSXpFPPQVLm/lnUTlNRTG8G/Pq/n
         zsaDavAVYLFntW1Vx9nMxGEY6waFC49XLk2EavlXSEODmZjyFExg/TcEZxK9XakPql8m
         OZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIExpa4VxanS6e9V7NofaU0K7FK9mT9NhMj1cWMW8MhblmBwfF+5QxOKIHDlhAjqYvQC2x5bBP75YG5zU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4HmbmiO4Ca1JT+N7mlfJtFwe/80hZW0UtnOxNPryUOQS7l4Ll
	vuG5zyItzp8ZwwIZSPFK9Dr36Ha+Sz9cgpOGO9zcpikPkN2/9memoLMtiqtlOh0=
X-Gm-Gg: ASbGncszx6cquRnP6tLQiIPfo8CM7p0SG0lnWeU6QjK1XlpTx6g4yxpfXiYKK2nXZxJ
	5+KeLLguG0GxUpNjJJJiPszV8mj9Pcw6XyMfPrsE1ODo8Immb2QEzU9kbI11gifaQOqhqy6t4q2
	SpUIu9J3J7CLRAVpNtiaRpCyFw+0rBk0EId2a+5du47dZbAnW4RwD8Mo8gum3XQHdWNTQGtEwSf
	FaTEVu26E1DTbbqEk+pKoFQqNeUh5ubNEWRP0YFOU/CD2DppH2OBkBcq0BY7ttqn9+6pw0FbXEM
	0r2duvLGd5zT17ZTlUNRsFBv4mheWsQoXSFVO7TJzJXNpFvp3pLGCw4=
X-Google-Smtp-Source: AGHT+IGvOKJR9bQjNfDvrDffZYoLtEjrjFfhbdpqa82uUo012ez5u5VvKrhfKfFZsatuBILBuKkHHg==
X-Received: by 2002:a5d:5848:0:b0:391:952:c728 with SMTP id ffacd0b85a97d-3a0ac0cb3f3mr2514750f8f.4.1746537023357;
        Tue, 06 May 2025 06:10:23 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:3f93:4614:996d:f5f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0af3255afsm1771268f8f.66.2025.05.06.06.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:10:22 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/4] mailbox: qcom-apcs-ipc: Avoid circular dependency with
 clock controller
Date: Tue, 06 May 2025 15:10:07 +0200
Message-Id: <20250506-qcom-apcs-mailbox-cc-v1-0-b54dddb150a5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC8KGmgC/x2MQQqAIBAAvxJ7bsGkgvpKdNBtq4XMUohA/HsSc
 5rDTILIQTjCWCUI/EgUfxZp6gpoN+fGKEtx0Ep3qoA3eYfmoojOyGH9i0TYsx60tf3SKoaSXoF
 Xef/tNOf8Acc6CglmAAAA
X-Change-ID: 20250505-qcom-apcs-mailbox-cc-6e292bb6d40e
To: Jassi Brar <jassisinghbrar@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, Georgi Djakov <djakov@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2

The APCS "global" node in the device tree currently combines two distinct
use cases in a single device tree node: a mailbox to communicate with other
remoteprocs in the system, and a clock for controlling the CPU frequency.

These two use cases have unavoidable circular dependencies: the mailbox is
needed as early as possible during boot to start controlling shared
resources like clocks and power domains, while the clock controller needs
one of these shared clocks as its parent. Currently, there is no way to
distinguish these two use cases for generic mechanisms like fw_devlink.

Break up the circular dependency chain in the device tree by separating the
clock controller into a separate child node.

The patches in this series should be merged together in one tree to avoid
potential bisect problems. Given the majority of the changes is in the
mailbox subsystem and the QC clock drivers only have trivial 1-line
changes, I propose merging all of these through the mailbox subsystem.

@Bjorn: If this sounds good to you, could you provide an Acked-by for the
two "clk: qcom:" patches?

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (4):
      dt-bindings: mailbox: qcom,apcs: Add separate node for clock-controller
      mailbox: qcom-apcs-ipc: Assign OF node to clock controller child device
      clk: qcom: apcs-msm8916: Obtain clock from own OF node
      clk: qcom: apcs-sdx55: Obtain clock from own OF node

 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    | 169 ++++++++++++++-------
 drivers/clk/qcom/apcs-msm8916.c                    |   2 +-
 drivers/clk/qcom/apcs-sdx55.c                      |   2 +-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |  16 +-
 4 files changed, 132 insertions(+), 57 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250505-qcom-apcs-mailbox-cc-6e292bb6d40e

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


