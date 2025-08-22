Return-Path: <linux-kernel+bounces-781928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE16B318C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE416B05C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7414A2FFDDD;
	Fri, 22 Aug 2025 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOJuITsm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07312FFDC1;
	Fri, 22 Aug 2025 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867490; cv=none; b=gKIyUOoVt8wy7/oAbnjQiL/RqAhqcJwfJbas20W0FTP0cCoWRzCfsUzksD0OZ1Se6pt19DMRDFZoOESxoZK01ugZ0MuBwIi0Z6Ho8Wq6ayJ+YpjovQtFd6woXnRFVAmbHLrrO+ZphwbI19IvzzKIuJWxRvP3jNIAs9BfpoeOgfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867490; c=relaxed/simple;
	bh=4/1ip04GTUVjn+DTl6JTM32LsyVUAI+Y7eDrGdATaYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FLJJVsg2eskZPKfE4bxCMgBaxCmn/oMl9fVPU9H7pkd0gObQ+lv8ZeuLpiwqyyj17XxMJ3NHMPjpDFA2XQh6UbS1qIt4wYhzKSY+Vw9KwXWRK1qWXnYROARDtUdS/FEVIeoWr3Vp904S45Crif/L3lspf29YmaGoxyVcHZ7QSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOJuITsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DE0FC113D0;
	Fri, 22 Aug 2025 12:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755867489;
	bh=4/1ip04GTUVjn+DTl6JTM32LsyVUAI+Y7eDrGdATaYc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jOJuITsmR/VHBSrsLLxE08s9zp0o+Uwsm48EoIlO+2UlKCp3uTraJHWow9JS8g5Su
	 0kMgW+9owV7tvt7cGe581O++3UAmPF02XspSudcLtJbd4GJGco3FgEUshDBOV/JF1H
	 P5IrzgTblzglQgNXgh53N4/yGgf7gtVt88DqsEMPS71VjWHLew/tbn/Ju/00R8+QtS
	 GbNGbX3Md9StxQHoyBdULNjaO0WoHfrUwZOCvGNIGIjBJNub7utrNNatD2FBkSx06h
	 pPKEg0urZvChV4Ff3EYmVyIv7SPumAb64VwCwu5fHkBPeShUnUL9gTuIymBZRxSRZW
	 PNI52gjdP8yFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8AFCA0EEB;
	Fri, 22 Aug 2025 12:58:09 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Fri, 22 Aug 2025 20:58:08 +0800
Subject: [PATCH] ALSA: usb-audio: Add mute TLV for playback volumes on some
 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-mixer-quirk-v1-1-b19252239c1c@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAF9pqGgC/xWMQQqAIBAAvxJ7TjAtjL4SHSrXWiKrlSIQ/54dh
 2EmQkAmDNAVERgfCnT4DFVZwLyOfkFBNjMoqRrZKiV2epHFdRNvAqWpnZmM1UZDLk5Gl/V/64e
 UPo8oZktdAAAA
X-Change-ID: 20250822-mixer-quirk-e074f7b7d373
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 guanwentao@uniontech.com, niecheng1@uniontech.com, zhanjun@uniontech.com, 
 jeffbai@aosc.io, Guoli An <anguoli@uniontech.com>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755867488; l=1344;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=CbanlkJhMdYwPVYycxuiequ7kNqYRPxDyM43A/LEFUw=;
 b=yCxulBPx293iMhoZV+mLoi+fq/AH8+tHNDLBwFVMn6E6UhqhkD30MdIhEOftKafe1+gSimyE5
 xepKmUPCykeB7T9W26JQvqix9eJaJpzL+4fglwhO8G5xr614LscM4pD
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Applying the quirk of that, the lowest Playback mixer volume setting
mutes the audio output, on more devices.

Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/2514
Tested-by: Guoli An <anguoli@uniontech.com>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/usb/mixer_quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 7cc27ae5512f07d5318443a7e03c1da7943bfb7a..6b47b3145d2cfd84bbadbe9e2b3e4383ed6828b4 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -4609,9 +4609,11 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 			snd_dragonfly_quirk_db_scale(mixer, cval, kctl);
 		break;
 	/* lowest playback value is muted on some devices */
+	case USB_ID(0x0572, 0x1b09): /* Conexant Systems (Rockwell), Inc. */
 	case USB_ID(0x0d8c, 0x000c): /* C-Media */
 	case USB_ID(0x0d8c, 0x0014): /* C-Media */
 	case USB_ID(0x19f7, 0x0003): /* RODE NT-USB */
+	case USB_ID(0x2d99, 0x0026): /* HECATE G2 GAMING HEADSET */
 		if (strstr(kctl->id.name, "Playback"))
 			cval->min_mute = 1;
 		break;

---
base-commit: 3957a5720157264dcc41415fbec7c51c4000fc2d
change-id: 20250822-mixer-quirk-e074f7b7d373

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



