Return-Path: <linux-kernel+bounces-731857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85891B05AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA921AA60B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8432E0403;
	Tue, 15 Jul 2025 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOcJp/QR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6171A2387;
	Tue, 15 Jul 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583903; cv=none; b=Stuy1R4KC+dJ6P4mr0Q0xrfeTgRcxf6Q49ZNqL4BApkbID4MSbI1F8cOK2DjOZ2P/aBwnD5N7SPnG90Y9Zk+JCeJU9jS2JIsnddAuT62yly0eVdAGElygxxFVPvcSCb2gBpvsN8fyPa71UaOj75CTdP5irnya82ChrSlhek6mj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583903; c=relaxed/simple;
	bh=yFg2ugs8HM/Q5rNkrVSdyOTr/8/Q68sOdBl3U9jUuK8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GJNCGSiv1EK/Fl7AjrGy5GdOayEkFBtQtsk8Kav1g4zRXuiHsCl03lrnMFXtXcvk1Edd7n8/3V0pVFObC07pJ2MDFM77YlIYjhgFYp6hxA4ivAAwQ0GQPVMWRmo7Atsnejv4oWvOKnfObnKX2Aa7C7oNr4LVI7YvllkUQoSZtAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOcJp/QR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54931C4CEE3;
	Tue, 15 Jul 2025 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752583903;
	bh=yFg2ugs8HM/Q5rNkrVSdyOTr/8/Q68sOdBl3U9jUuK8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NOcJp/QRZZqq5oxyjU1RuK66tNWiAsY6Qp+P+e5Kh/0et0sel/x2CT2RdDIU5wZu7
	 txzrn16KXbJ5vAIghp0QJ9bxzudmfXQ8HEC+3adO1vrMTXQWmHBGmBEn3YisX7cJ3y
	 jUdx8nPZRdpb8l4rvic1/bBwRs1nuGh11hnERtCgGryEDZPQsQ39LbfXGhR6dZTLDK
	 xJcrJhW97Lbw689OuokaFHUX08qakX4rFxUsg4pNuEbvaLMbpVfggYdmL6bJ9VHLKI
	 1J6Z29TOmHzmphMtyNX0VvPeIk9gH/k5yoUafmSEncPjZtCP/H2FydW8nkkRplssdH
	 ccfn0SLM4vJlw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4659AC83F17;
	Tue, 15 Jul 2025 12:51:43 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH 0/2] clk: amlogic: add video-related clocks for S4 SoC
Date: Tue, 15 Jul 2025 20:51:37 +0800
Message-Id: <20250715-add_video_clk-v1-0-40e7f633f361@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANlOdmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0NT3cSUlPiyzJTU/PjknGzdlGRjiyRTE1NLA0MLJaCegqLUtMwKsHn
 RsbW1AAXN6ehfAAAA
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752583900; l=744;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=yFg2ugs8HM/Q5rNkrVSdyOTr/8/Q68sOdBl3U9jUuK8=;
 b=W4jZvTGQHOHnuF5HvnTlxXyeeoF86/ruiJc65Bn+nIcrd9WrmBfPCnjbAanuw4uT5pIFFhF9J
 mc0bndzU4E1AHtMxH9tcsskTF7giz0GZPo3RaUwVV1hGhXjJS/rdV0g
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

This patch introduces new clock support for video processing components
including the encoder, demodulator and CVBS interface modules.

The related clocks have passed clk-measure verification.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Chuan Liu (2):
      dt-bindings: clock: add video clock indices for Amlogic S4 SoC
      clk: amlogic: add video-related clocks for S4 SoC

 drivers/clk/meson/s4-peripherals.c                 | 256 +++++++++++++++++++++
 .../clock/amlogic,s4-peripherals-clkc.h            |  14 ++
 2 files changed, 270 insertions(+)
---
base-commit: 8a65268500b00ecee5402ef9f80618ff73f30707
change-id: 20250715-add_video_clk-dc38b5459018

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



