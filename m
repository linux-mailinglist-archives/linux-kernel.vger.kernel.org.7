Return-Path: <linux-kernel+bounces-836822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE955BAAA5C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633B33C61DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3761223DDD;
	Mon, 29 Sep 2025 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oS6+xOE0"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969A62139CE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759181622; cv=none; b=VfvVlWNNBw16TH0gkN9T9Ouw5ovqGBZ3uZIv9/E8tzt/OQ2/ujyeSIWi70V4o1iIMdCrBbhIYdoGjZ5GLO9m+IXv00s5oyAFCokq7L//2Amr09ahUXZSVsNmgc4joq3z6W7/R5XkKgqt6h82r+PpJDZAClAOf0R8eUg/6/PV/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759181622; c=relaxed/simple;
	bh=dfXKvQ91TOlkjdrPXceY7rW+DXPRQb4lDShzbaTpGOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BDEwTlcaYdmL1B+XmQtpXA799i1sHC5nduLyCzo8B+31u9liinG1BuFY4xSO0vpqaZvPlsxnl+7XDtPTRsDufpMC2cBhqY73kHUP2mY9oVCtA7TONICQBXB49cg5RxPgQIVzXiDdIitmXwbv2Nasqdi4ni8mIjr6xqIsAD+rXi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oS6+xOE0; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8e286a1afc6so3022579241.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759181619; x=1759786419; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7DndpbGnaGr647nqjLPsyXZsnXaydKUcV/c1eXt3NA0=;
        b=oS6+xOE0IsOGn5UIFJp8S0+wwW44uHm2Rh96CKwanCWDX/Z1D8vat81V+owytOtard
         6oxuyML2mg2hCi0wanyodcmOaKKCywYfNwsqkO7+6HIF+1AdgMH0o9TU1stvcWm4/G35
         NBmo9nyrHh7um5LzumsVqK7TC//7ZYgFE2G8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759181619; x=1759786419;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DndpbGnaGr647nqjLPsyXZsnXaydKUcV/c1eXt3NA0=;
        b=JTKS8es+/jlvfx2VhZtyMim6HHXp7d0pdv3lz/NvJj594DHsqFYoOtMsW+Z60S/rjV
         mDc3UiHW+tSvR+6G9ybfeTFRqaFsKZRT4YmhBP6xxm0iemlb0o0XffCYitGHZ0VyNQSK
         csGlD9aStVrx+tc47QDpR36M/tcmfCfVf6SfNPOuHG25lTel4/q+S7VCWa0heb6OpxzM
         SdJA7AXAnDtcqBKrSZ77HfK8MP5AADzXdxZY2SZlD+4FgTLYt7/Ljv/Tsqa3LuikNOb9
         l/+HyvfrDXD0whSTNQV7zBs7xpTrzX7qvFEJ+H0g9kmVZ5zjvraQfvJwyrJ/2AZFXpSo
         hjCA==
X-Forwarded-Encrypted: i=1; AJvYcCUoT48k3WpsroZgWWIcZJe7rW7Z+KQApNpv8Ton4ABh1vgozZ/aRYX/tAfDn+XpPrEJH/UoKJgBd0VLO9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRibaU3W+LF3zewxDu8tH2hdpCBDFvROLGU3DW5Ur/2xGLrr/F
	qQxOYBn50X6oPRkhPrSd+9PiHm3Amj4SWA5yc5pjT0a++jVF0QS8eRdED1WODVTbtQ==
X-Gm-Gg: ASbGncvViQ9kq0BZjWvPIlGWY0v8ng/WjWPXw+m5RvnYs3jl9oGsk2I3oLL/oU73wcq
	cMfcXfUUphLVS/KAO+B0atDtZU1IHK8Hrf3k1eoA2VDYKokpJduWpmEWVoEzwueJiPvPVkJ+hGa
	f3I/0pAs3EHNxY48hulRQKQ8rj2M+UOwIOQZIw5/Hg4YYlDzo8pRs+xRuFSzfc9dgQLiwteDa09
	84ELFrObvWrL2CAuNcBaeuKeECeZ32ibepzzyfCq4fc7d9jlHtVOIknc+3E158qX+KemzkCtDI2
	YJTR4LXa/yifNQz2lcJO/2a8Z4uFEuxDY7oVxbtZSNjfcszFpIN3Ay3Pt0MYBlHS6tOandrUrp/
	b14+0ge3GW9tqcNbkIGyMV1u0ls6OLKXXFlvNOAEyIpZlD2VN5gNcjGLE+8k+V1EItWpk9CHi2w
	I+AL2Xw2MM9kDR
X-Google-Smtp-Source: AGHT+IGBcKDX6t5iDAMqyGpZDqjCIaqn4UqgrhOWcA2rKa6QvdAjhZ5diuFuPMe6votfx/4yDSiOLg==
X-Received: by 2002:a05:6102:304d:b0:52a:1104:3029 with SMTP id ada2fe7eead31-5ced60fd25bmr1445401137.17.1759181619470;
        Mon, 29 Sep 2025 14:33:39 -0700 (PDT)
Received: from ripwilburliny.c.googlers.com (62.37.48.34.bc.googleusercontent.com. [34.48.37.62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae3b232a01sm3687131137.16.2025.09.29.14.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 14:33:39 -0700 (PDT)
From: Steven 'Steve' Kendall <skend@chromium.org>
Date: Mon, 29 Sep 2025 21:33:34 +0000
Subject: [PATCH] ALSA: hda/hdmi: Add pin fix for HP ProDesk model
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-fix-hdmi-hpprodesk-v1-1-f4a7e714ef11@chromium.org>
X-B4-Tracking: v=1; b=H4sIAC372mgC/x2MQQqAIBAAvyJ7bkGNAvtKdEhdc4lKFCKQ/p50H
 JiZCoUyU4FJVMh0c+HrbKA6AS6u50bIvjFoqQdptMHAD0Z/MMaU8uWp7OhG1/ugrNXOQgtTpmb
 903l53w8HZqtmZAAAAA==
X-Change-ID: 20250929-fix-hdmi-hpprodesk-c6c3df1bb2cb
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Steven 'Steve' Kendall <skend@chromium.org>
X-Mailer: b4 0.14.2

The HP ProDesk 400 (SSID 103c:83f3) also needs a quirk for
enabling HDMI outputs.  This patch adds the required quirk
entry.

---
Signed-off-by: Steven 'Steve' Kendall <skend@chromium.org>
---
 sound/hda/codecs/hdmi/hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/hdmi/hdmi.c b/sound/hda/codecs/hdmi/hdmi.c
index 44576b30f699511c79a298af5d79be81ec1fc0cc..774969dbfde4573894d87d603d64a7854a786fdf 100644
--- a/sound/hda/codecs/hdmi/hdmi.c
+++ b/sound/hda/codecs/hdmi/hdmi.c
@@ -1583,6 +1583,7 @@ static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x103c, 0x83e2, "HP EliteDesk 800 G4", 1),
 	SND_PCI_QUIRK(0x103c, 0x83ef, "HP MP9 G4 Retail System AMS", 1),
 	SND_PCI_QUIRK(0x103c, 0x845a, "HP EliteDesk 800 G4 DM 65W", 1),
+	SND_PCI_QUIRK(0x103c, 0x83f3, "HP ProDesk 400", 1),
 	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8711, "HP", 1),

---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20250929-fix-hdmi-hpprodesk-c6c3df1bb2cb

Best regards,
-- 
Steven 'Steve' Kendall <skend@chromium.org>


