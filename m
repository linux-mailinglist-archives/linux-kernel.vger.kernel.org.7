Return-Path: <linux-kernel+bounces-851094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF7EBD5825
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D37FE4E0FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5FD2561AA;
	Mon, 13 Oct 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="nLR7goAC"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5A25F7B9;
	Mon, 13 Oct 2025 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376823; cv=pass; b=sY8uHruVL50jeUTwb1rT5CBQX9z4IK87F1HXEgxG30tUxehBBI9oMJFeiUycUmybpiVd4PH8Dl7VxciNjEgQxJ0q6PPJWe/ZnIE5KzwCf0GOoim70q7cTQwhdZbjsuHfgJaRy1N/W/p21MAjlspzCDGc7tyMd2bTI5LAtQPx0Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376823; c=relaxed/simple;
	bh=4iVdbM3/EGqXBBjdjgP1q3+S0c6scuDxL1vh5CrDzZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYMONrVi0uG4WfTc1WioBzGqz4fwi0I9JOgiRItRE8VOs6BSvDioA4VemfkQtwQnU8lasP0wIc9rMaZ4z0OPI95JEiKO91ZS1degoXJzORA8t5Gzm8Hf07I+1aJTH/EVSprjSayM8svci+nlzFuQ5ZCV0ek0OOqB3h6pCuOBD3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=nLR7goAC; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4clkw74g7qzyQf;
	Mon, 13 Oct 2025 20:33:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1760376809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=87OdUcrbgLReDVIP25eP2euTnGFsa8mbSEfIFhzlQqo=;
	b=nLR7goACOD3Fnf4sAxv7fdMmpOeN5sEwZB479WaaAsPaF9haBIcY+iiFvjKix9ejFwTxY1
	vbYWhqFjfyRcD9ZvLd/sREN5hAV1E3YHCDWHkqbnEDhCWRg5SWQDh0MDPbMOLSeqB/Sh8W
	66NoWCpLAaHHEPIoqzaFZoI1z7hyqrg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1760376809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=87OdUcrbgLReDVIP25eP2euTnGFsa8mbSEfIFhzlQqo=;
	b=yaN1ay/ODwtPbOhSJa82150b95ekNLuzBnhmg0eiBt53TwL5WG+fns4MBGonDr/AMfe6fR
	Rxj5y+2jZtyWSCe90RfHA2fmPAAz5RvYnCntZrR3uOoZOSW8Kll+ckv4fWkg3IuHiOE2bs
	0bnPZgUXvbuCmUYhA+d5OIWjnwHCDco=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1760376809; a=rsa-sha256; cv=none;
	b=n0MWxxJlbpvWUyCB5nI2NGmJouxPFsUI1JUfjkEphe1GXBQzJ+x7YBuThlzx6X1dzEdQgb
	Gk9fDmbyA3aOSnlpvIffCfoptF/Q+a2hP1jCEVO03gbLX+mvd1s6EvMyyV4P6fz7ZvSQqb
	5O3LJD6wj9QwLmoQ95csjwgfZGSRdoM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-sound@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: add mixer_playback_min_mute quirk for Logitech H390
Date: Mon, 13 Oct 2025 20:33:06 +0300
Message-ID: <72c83ff44985b3de59ad35189e6757212bb3998c.1760375830.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ID 046d:0a8f Logitech, Inc. H390 headset with microphone
is reported to have muted min playback volume. Apply quirk for that.

Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4929
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 634cb4fb586f..43793a5c3f51 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2180,6 +2180,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
 	DEVICE_FLG(0x046d, 0x09a4, /* Logitech QuickCam E 3500 */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_IGNORE_CTL_ERROR),
+	DEVICE_FLG(0x046d, 0x0a8f, /* Logitech H390 headset */
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x0499, 0x1506, /* Yamaha THR5 */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x0499, 0x1509, /* Steinberg UR22 */
-- 
2.51.0


