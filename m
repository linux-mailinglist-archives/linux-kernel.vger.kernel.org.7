Return-Path: <linux-kernel+bounces-791217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525FCB3B38D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075C216D599
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA7E257459;
	Fri, 29 Aug 2025 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2YTYQwU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00842AEFD;
	Fri, 29 Aug 2025 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449670; cv=none; b=fyBdWZ1sn1zAmcWrzC8WuB7H5eZkTuslHCz8pAff1tnhpGCVR6Yy6ETm4PhY+Jkb7zWYClGlHgrjfy1Q4U4pk4k2+/HAH+LDD3tkZ6HtLjsvhKH9TFzZ3uRbLJstPEbB+BKarru2scbV92+jIK6DgQPGPExySJHFYhLxUqV0F5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449670; c=relaxed/simple;
	bh=8i6fbXOb5z0SkuR45STk52XtRArKAtCKXukEnXHdhT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=szOQdpeqPQQQ5mUeKl5TsnkTRxpNDD8+5Xisw/o2kN9EEbnaiYB2/p5tIqwwj2f7HMS+Hgbr+mIKxMK7xcLsHc8QyjsHDtNfr8gVM46NoUTc1ZabHlhfHMR9WJ1ftRh00dYqLcoCYlFtumf8lGMxkNpYYWFUibiPB+gRyUESsFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2YTYQwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FF36C4CEF0;
	Fri, 29 Aug 2025 06:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756449670;
	bh=8i6fbXOb5z0SkuR45STk52XtRArKAtCKXukEnXHdhT8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=S2YTYQwUBysvH9gtvO+FKfA6L9BMRTzjIQpHrpX0wY9xss7tc58d7/2rMUmB9rPOI
	 qTSa3mpjP/VsQXSNGUpy31EgPie/8sY4i5MmjfhApvDNQQKqDgaQyCfNxthJfpB6PK
	 4ARLhWAAoAr6IeP7rN5VMuGMBDIjCuAroqbanIS1Vl6Bfz0FiiUgiav4p+bYJ+7/U6
	 HWCNuPVVLVh0Ih4WS5bmBfvh5YwH3/Su5Bkzn9A5jpRIHdG8bd3iDXclBOscmfqzwP
	 V4WPycFdp7jkeC8GLb0QkYrVa5XUnUDa8GpfhiMNf/L0jp4gUYVL4dTdToZIHuc3Z5
	 zU3D/bs7FCEDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44447CA0FFD;
	Fri, 29 Aug 2025 06:41:10 +0000 (UTC)
From: qaqland via B4 Relay <devnull+anguoli.uniontech.com@kernel.org>
Date: Fri, 29 Aug 2025 14:40:48 +0800
Subject: [PATCH] ALSA: usb-audio: Add mute TLV for playback volumes on more
 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-sound_quirk-v1-1-745529b44440@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAG9LsWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNL3eL80ryU+MLSzKJsXRODpNRU02RLY1MDIyWgjoKi1LTMCrBp0bG
 1tQD9alItXQAAAA==
X-Change-ID: 20250829-sound_quirk-40bee5c93502
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Feng Yuan <fengyuan@uniontech.com>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>, 
 qaqland <anguoli@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756449669; l=3151;
 i=anguoli@uniontech.com; s=20250829; h=from:subject:message-id;
 bh=Hpktb+CQ4vd5dzIX+ki+zIh0ybyRu/1SRUs42KE6TK8=;
 b=LV4XUBokc49WaeVA5A9i9im5sdmxa1hF80JhOMs+Lb+JYP0H/clCAxAn0dvwCaQQbFgoWqYnk
 lO5adVEN5lBD6tfgMn0b2u3TEW5W5xxKtXR3MOcvNDmZhbQX8cX+OpS
X-Developer-Key: i=anguoli@uniontech.com; a=ed25519;
 pk=boYZUYN5CUcKxq2lHODsag4XCrry/KC4N81H4GYjPpU=
X-Endpoint-Received: by B4 Relay for anguoli@uniontech.com/20250829 with
 auth_id=503
X-Original-From: qaqland <anguoli@uniontech.com>
Reply-To: anguoli@uniontech.com

From: qaqland <anguoli@uniontech.com>

Applying the quirk of that, the lowest Playback mixer volume setting
mutes the audio output, on more devices.

Suggested-by: Cryolitia PukNgae <cryolitia@uniontech.com>
Signed-off-by: qaqland <anguoli@uniontech.com>
---
 sound/usb/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 8bc1e247cdf1af0a3e9c506830d8428a86c25595..766db7d00cbc95984afa834200ebe3adfdf182ef 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2199,6 +2199,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_SET_IFACE_FIRST),
 	DEVICE_FLG(0x0556, 0x0014, /* Phoenix Audio TMX320VC */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x0572, 0x1b08, /* Conexant Systems (Rockwell), Inc. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x0572, 0x1b09, /* Conexant Systems (Rockwell), Inc. */
 		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x05a3, 0x9420, /* ELP HD USB Camera */
@@ -2243,6 +2245,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0b0e, 0x0349, /* Jabra 550a */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0bda, 0x498a, /* Realtek Semiconductor Corp. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0c45, 0x636b, /* Microdia JP001 USB Camera */
@@ -2259,6 +2263,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x1101, 0x0003, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x12d1, 0x3a07, /* Huawei Technologies Co., Ltd. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
@@ -2349,6 +2355,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x2a70, 0x1881, /* OnePlus Technology (Shenzhen) Co., Ltd. BE02T */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x2b53, 0x0023, /* Fiero SC-01 (firmware v1.0.0 @ 48 kHz) */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x2b53, 0x0024, /* Fiero SC-01 (firmware v1.0.0 @ 96 kHz) */
@@ -2365,6 +2373,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x30be, 0x0101, /* Schiit Hel */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
+	DEVICE_FLG(0x339b, 0x3a07, /* Synaptics HONOR USB-C HEADSET */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x413c, 0xa506, /* Dell AE515 sound bar */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x534d, 0x0021, /* MacroSilicon MS2100/MS2106 */

---
base-commit: 112f7d3cff02e357c2f7a116fd7ab6a366ed27f4
change-id: 20250829-sound_quirk-40bee5c93502

Best regards,
-- 
qaqland <anguoli@uniontech.com>



