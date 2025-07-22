Return-Path: <linux-kernel+bounces-741103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E04FB0E01A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7963B26C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D190B2EBDD7;
	Tue, 22 Jul 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpuCHzal"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3F28CF4A;
	Tue, 22 Jul 2025 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196949; cv=none; b=HHVbejW29LrV7f1d9l4O726GXItCmcSoCw1rOuKP46FLNQsmi+Rp0a/4mEtErj4QkzAsBW0naIFdw9+7pyRtRPdXV0qRlxsTrRym9ZzOIGNJ/7/sxwqiGHbs8M+xUmr9vX4etd2EMyJuu8OEJyis7hqtFXynjb1YGS+eZSIuRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196949; c=relaxed/simple;
	bh=rKPG+II+FZC1gD6MPdJE3Wtz5Pqku5GBbLlV76yOR/M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FKtStVcK2ZLladD7nCewEl2tpZVFGX1ROKSESCeGjvnKGVleTNCZzLc6jiTOmyqz5Hg3qzYFkaEhkIysv7m4IXEs0R9IITUygFXGFtMq92NOmp1aQSN9JC4/3xvlYj3BjABbDIAUQiiqQzfsZkzYENlaqG0o1g5fPAJWGxNdXm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpuCHzal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3F0BC4CEF1;
	Tue, 22 Jul 2025 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753196948;
	bh=rKPG+II+FZC1gD6MPdJE3Wtz5Pqku5GBbLlV76yOR/M=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=kpuCHzalb6gfSMk6BbwoyLE9Col9dehNeBQwWT5zsiMLRwl9113ACYxDLN/6xnlKC
	 h05XcWPUbFaWzd2AGhHbkNzevtH4V6OeMmPjv3VXnMxkmQ90QnftKSV487JiKjmRSK
	 aJMKgPMiW34lLAQzzUgtOaQGMSrUkyTWYUpKUKS2J3Rj+FoUV5wnt1W7hnO8bF/5rm
	 lI1gyvMsARlWq5Lh+p2b9qmE5mpvkOjZ/hw4HH/qiJNib11btn2dZMr7kLcILr9ezO
	 YkJXzNoTiu/KIR/NUukHxgahO0j5SXsrTS83/i/jYu+wCrKmSGkRNbZxHFq3eGxSld
	 SsIhYy3JpaLZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD8CC83F25;
	Tue, 22 Jul 2025 15:09:08 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Subject: [PATCH 0/4] stratix10: Add Interrupt support for asynchronous
 communication with SDM
Date: Tue, 22 Jul 2025 23:07:50 +0800
Message-Id: <20250722-sip_svc_irq-v1-0-c5b9e02c1ce6@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEepf2gC/0XMywqDMBCF4VcJs26K0XjLqxSRGMd2FmpMNBTEd
 2+q0C7/A+fbwaMj9KDYDg4DeZqnGOLGwLz09EROfWxIkzRPyqTmnmzrg2nJLbzqUMpBFrqvDcS
 HdTjQ+9QezdUOly2i6zX+TcVOUWTiJ27Wrw71yLGs+srUncyyXIX8K3faIzfzONKqWCjuouDOl
 NAcxwfOCLYxwgAAAA==
X-Change-ID: 20250709-sip_svc_irq-8be44f46ad9c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mahesh Rao <mahesh.rao@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753196946; l=2078;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=rKPG+II+FZC1gD6MPdJE3Wtz5Pqku5GBbLlV76yOR/M=;
 b=I5x4qmb2dFuKnSxRRUlJRds/HZyQnRcPOdkY+KaEFl+nYE/juNyepr/ugRABHM1a3W9KgkVIA
 qZ3VhwJqtaeCVijmZ57OKIUk82Ik1jycRXlrxQyhS9xLazcfcdC5o3Y
X-Developer-Key: i=mahesh.rao@altera.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=
X-Endpoint-Received: by B4 Relay for mahesh.rao@altera.com/20250107 with
 auth_id=337
X-Original-From: Mahesh Rao <mahesh.rao@altera.com>
Reply-To: mahesh.rao@altera.com

This patch-set adds support for interrupt from
Secure Device Manager(SDM) to Stratix10 SoC for
asynchronous communication.

Following things are added in this patch-set:
- Add support for interrupt from SDM to Stratix10 SoC.
- Add documentation for SDM interrupt in Stratix10 SoC.
- Enable SDM interrupt in Stratix10 SoC.
- Enable SDM interrupt in Agilex SoC.

These patches were originally submitted within a
different patch set, but were requested to be
separated into their own series.
Reference: https://lore.kernel.org/all/df8db66b-89a4-40d9-bd44-6705fdbb4517@kernel.org/

Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
---
Mahesh Rao (4):
      dt-bindings: firmware: Add interrupt specification for Intel Stratix 10 Service Layer.
      dts: stratix10: Add support for SDM mailbox interrupt for Intel Stratix10 SoC FPGA.
      dts: agilex: Add support for SDM mailbox interrupt for Intel Agilex SoC FPGA.
      firmware: stratix10-svc: Add for SDM mailbox doorbell interrupt

 .../bindings/firmware/intel,stratix10-svc.yaml     |  10 ++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   4 +
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi      |   2 +
 drivers/firmware/stratix10-svc.c                   | 117 +++++++++++++++++++--
 include/linux/firmware/intel/stratix10-smc.h       |  23 ++++
 5 files changed, 146 insertions(+), 10 deletions(-)
---
base-commit: 75083cd99c8261eec695596813cc261a523ab32b
change-id: 20250709-sip_svc_irq-8be44f46ad9c
prerequisite-change-id: 20250131-sip_svc_upstream-e78d8c9b4335:v5
prerequisite-patch-id: 6a4223bd2c01a0fd20925e597c906dc64e11ec2f
prerequisite-patch-id: 33ca4dbe8b8e18d3e51145c6bcaae55170878b22
prerequisite-patch-id: cc72b86440a07b6311c0ac8cf2212072d2a0c561
prerequisite-patch-id: 5c3dc9849364a5c6573b032b878459be252305e5
prerequisite-patch-id: 5db2eb9fe78188c2dbc453d0d2d6e45c8d8e1be7
prerequisite-patch-id: f7ffa416aef888c30d3fcf875e7b2f79e333dbfa
prerequisite-patch-id: b827c6490b3ebef5de4ad67e3150e318df79a08e

Best regards,
-- 
Mahesh Rao <mahesh.rao@altera.com>



