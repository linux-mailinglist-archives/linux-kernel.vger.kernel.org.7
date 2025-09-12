Return-Path: <linux-kernel+bounces-814071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED616B54EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492AE1CC2163
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C6330C62B;
	Fri, 12 Sep 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eak4uGpY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D22DC793
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682734; cv=none; b=Gtw3i3qrS/WWP1MsmmosqFtbM9YcrlkNzRwSqyg4hjL69FxgdgodgjpJpZvwnT96BtrV+szSw22KTKCeeOviOukeKWWrdQ1Qa41751XLmhDGOuY6xUpBscCb4Kr0eqRj3S6Sb7HM3leVVEx8G/7RLAq9b3ts0tdYjb9dj8HwwAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682734; c=relaxed/simple;
	bh=4dZBbVdQPEwuXgfs4M96vQiAhQ+FTlBePsljf7ZsLLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELRhO3yOM/vbwq0PizWSpwjekXQUZTUJnnYNZ5tdx5Q2it3Gpk/y/LVxcgDZC09Xo+RF6YuYNPmHWsNiPPYt9ZWAaeg6Kw7bENu6dJ6fBLi4znFkLlrInUYcf55KU1UdsuPkeF6yD5k3ixfMXhhnzm0FJYKb+YiG1KHOS7/+p9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eak4uGpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3733CC4CEF1;
	Fri, 12 Sep 2025 13:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682733;
	bh=4dZBbVdQPEwuXgfs4M96vQiAhQ+FTlBePsljf7ZsLLc=;
	h=From:To:Cc:Subject:Date:From;
	b=eak4uGpY0JanMJz2aNQxTj8V5FL7P1pcAYVBEm0jWeATi0mh0xpnH0CXGHVSSdmf6
	 vFqiHBTJn/VqKaBlY1H6P24gIELTh5HJxmZmJL5meTfk+QUk7slO4RJdyGwnEMCngX
	 7eG0AvE7BV1jerpxjRtRHbYRwN1M2OrlUudXRKgIQEndqEZci+OTxqEt/PHRSuvGjl
	 46jAcEYr6OO8Aic6leIZun3D2XhAd5y+RrhhwtGvU9bKDPxcwf2GVHG9h+TGSucCvL
	 OePAXlRpYPYrnOE7p8EyKXC9D8E03RzctNfsKRTmIHAMiJZhHS8NH17NrvjAY9Hu4U
	 JfZhRXVMoOQ/w==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 0/3] slimbus: patches for 6.18
Date: Fri, 12 Sep 2025 14:11:59 +0100
Message-ID: <20250912131202.303026-1-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srini@kernel.org>

Here are few slimbus patches for 6.18, Could you please queue
these for 6.18.

Patches include:
	- remove unused controller driver along with its bindings.
	- a typo fix.
	- remove some redundant code.

Thanks,
Srini

Qiang Liu (1):
  slimbus: messaging: Remove redundant code

Srinivas Kandagatla (1):
  slimbus: qcom: remove unused qcom controller driver

Xichao Zhao (1):
  slimbus: messaging: fix "transfered"->"transferred"

 .../bindings/slimbus/qcom,slim.yaml           |  86 --
 .../devicetree/bindings/slimbus/slimbus.yaml  |  13 +-
 drivers/slimbus/Kconfig                       |   7 -
 drivers/slimbus/Makefile                      |   3 -
 drivers/slimbus/messaging.c                   |   4 +-
 drivers/slimbus/qcom-ctrl.c                   | 735 ------------------
 6 files changed, 5 insertions(+), 843 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
 delete mode 100644 drivers/slimbus/qcom-ctrl.c

-- 
2.50.0


