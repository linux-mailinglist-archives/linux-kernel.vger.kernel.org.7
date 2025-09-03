Return-Path: <linux-kernel+bounces-797703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA24B41426
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04DB3B098F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7730E2D660B;
	Wed,  3 Sep 2025 05:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYfThl1S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28712D46DB;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756876187; cv=none; b=ZkC/pjWEJ4vvYrd7dTxo4aUSkLfGUWLA+y533khecS1OKNCcYp26KzuurQT99SLxPsVqzMzR9454JnuojajNh9yOhrXU6ecnNL7wCn8ticHYhgreBndK+QheeERXhBPWe+afArC/huG42JBOTdrk+PqzrYdbB/7nIN16SKIex54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756876187; c=relaxed/simple;
	bh=7YzpS7WGvT5+wxyBAHrWRvHIPIj/UBNdEDTvQ4yz1Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cei7QJc8pSmYEk7uSXamMvDOmUp7rVzE0CFOACwNhHkvRB72ACU2W+yc1uNzm/MqdhaLijIhq0qxHEti2yjSLPQz2ZJPeCseNuX3MzT9ucVwKfxuoNg6A0yjFkFR1vIQq4GWNMx248NcCOleWcunWDDEHGyj1k5YfwI+fMIt2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYfThl1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47121C4CEF8;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756876187;
	bh=7YzpS7WGvT5+wxyBAHrWRvHIPIj/UBNdEDTvQ4yz1Hg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sYfThl1SUtkj9kfu23NUYmj0lC5NtEmTPkG9BvMaGX4DVq4OtxSYNUfHU+N8EjK7s
	 mLKNblCZzxB7WXdm07Yk2ZXlmc9ZM32iaMVdsA7pVLVapQA/1JRqJ4XtrQimMDcoEe
	 xhiebPsVr0qNopq1YHTcPyP/cOhsdQ5Y/Vzm9HWaYW1huLrGIAvrYEVw5NQCrN/PzZ
	 vL2Pz85t2Nb8l4M9iWDWiTi385jXTVE9r//Iifwfqf4CFBvgj9+TNk6X78yIsDpLPt
	 NsnC3Po9GupP2UH2moN4bcTUPqpS+742+O+jUriftHXz+yrM5VTn0qqiHx1KuBpSem
	 Ej76i5uAXMlGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAFFCA1011;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Wed, 03 Sep 2025 13:09:47 +0800
Subject: [PATCH 3/4] ALSA: usb-audio: apply "mixer_min_mute" quirks on some
 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-sound-v1-3-d4ca777b8512@uniontech.com>
References: <20250903-sound-v1-0-d4ca777b8512@uniontech.com>
In-Reply-To: <20250903-sound-v1-0-d4ca777b8512@uniontech.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Feng Yuan <fengyuan@uniontech.com>, Celeste Liu <uwu@coelacanthus.name>, 
 qaqland <anguoli@uniontech.com>, linux-doc@vger.kernel.org, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756876185; l=2765;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=H41Y5MiAPmIzKR0KIqAt9d3/JLqaw8uC28jKyIpFimE=;
 b=1CHb8rMmE4hnWZhp4HI2TlFa19Re77zQ4+7SQPrj9hFdtAFeN5wJq1McJEn+fTT/cUvN2JkAq
 CpDd6HxXiCUDlNhRxrjT5lXUDr9DpBFDcmWEieqOHjWRXn/k/eg+cBR
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

- QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE
- QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE

Suggested-by: Guoli An <anguoli@uniontech.com>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/usb/quirks.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 0fe31af3158f08a39849f8df99dbbfb10c5fdcc1..d736a4750356597bfb0f9d5ab01cdaeaac0f907c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2243,16 +2243,20 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x0951, 0x16ad, /* Kingston HyperX */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0b05, 0x18a6, /* ASUSTek Computer, Inc. */
+		   QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE),
 	DEVICE_FLG(0x0b0e, 0x0349, /* Jabra 550a */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0bda, 0x498a, /* Realtek Semiconductor Corp. */
-		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE | QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE),
 	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0c45, 0x636b, /* Microdia JP001 USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0d8c, 0x000c, /* C-Media */
 		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
+	DEVICE_FLG(0x0d8c, 0x0012, /* C-Media */
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x0d8c, 0x0014, /* C-Media */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
@@ -2264,7 +2268,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x1101, 0x0003, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x12d1, 0x3a07, /* Huawei Technologies Co., Ltd. */
-		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE | QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
@@ -2356,7 +2360,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x2a70, 0x1881, /* OnePlus Technology (Shenzhen) Co., Ltd. BE02T */
-		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE | QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE),
 	DEVICE_FLG(0x2b53, 0x0023, /* Fiero SC-01 (firmware v1.0.0 @ 48 kHz) */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x2b53, 0x0024, /* Fiero SC-01 (firmware v1.0.0 @ 96 kHz) */

-- 
2.51.0



