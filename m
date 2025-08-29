Return-Path: <linux-kernel+bounces-791127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1711BB3B24E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F4216765C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11921217F3D;
	Fri, 29 Aug 2025 05:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFNmEHuU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE41DE8B3;
	Fri, 29 Aug 2025 05:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756444264; cv=none; b=fx/UAMWdM9S/FQw7K0QGrLxwKQDmfnq+d3XE0OZ6oBdefPTJFyRKW9LN2WnQJ30Wq581/XhFcAzXC0mCNfnPkUwwMp0v5S2LyXszpF9Ztib2xd5Hrh4ohxJU5MV58O0pvwKFCPb1NZtfezAEpV5bYgoWx/KRh8swBco5HebWj40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756444264; c=relaxed/simple;
	bh=p5ERxcDEGCnOK/ZpG59PS01c3gt2BiQFtvRT5CoGK6A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c97drSkydk1VlLVUNECZRXQGeXwS6JkQtrNoMQ6UZKh9aMFZkx8KJFJ9HN8eF3HS/p9O/O2d1MbFcq0sWF1GbBdohRUj4lr0cAEarNtyeVcX8e65d4jfMF74+skLut+GmKr+gifz1UzDc6AP617mUFDw6zHQBpMWJuo/SDzzz6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFNmEHuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E91AEC4CEF0;
	Fri, 29 Aug 2025 05:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756444264;
	bh=p5ERxcDEGCnOK/ZpG59PS01c3gt2BiQFtvRT5CoGK6A=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MFNmEHuUVWDrpYZBK5jYbtmJcPrmIL1cj1zTcsBHuOf7vyGXvgyVtXOPZin6PglYl
	 X7//Cdi+4B3wBG7LGSt9dNY9TOz1ruR/dzyOKwxOwOnEhiQQzXX5rEfpC2sABpszo9
	 pNTopGajnA81lZ7Ja+wj1j/pK8InDl1he0fn5waKpTHMskw4x+MmIZV+puWXvQQa+N
	 avpE4KOIGVIRQpOIQXs01DndVbSLCnJxSKM8377kwdpJWuA72rUnIMcYMOBDj5gk8t
	 L8WBEZWF8eGkflQx6ky/HrM4fMt8imgwhWA+EQ0BEfKGDlMaopPac6H/zNkoBExpMz
	 6i3ngM8z1mqgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA13CA0FF0;
	Fri, 29 Aug 2025 05:11:03 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Subject: [PATCH 0/2] ALSA: usb-audio: Add module param mixer_min_mute
Date: Fri, 29 Aug 2025 13:10:58 +0800
Message-Id: <20250829-sound-param-v1-0-3c2f67cd7c97@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGM2sWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNz3eL80rwU3YLEosRc3TTjlOQ0k8S0lLREIyWgjoKi1LTMCrBp0bG
 1tQBEMqnDXQAAAA==
X-Change-ID: 20250827-sound-param-f3dcf4afdfa2
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Wang Yuli <wangyuli@deepin.org>, Guan Wentao <guanwentao@uniontech.com>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Celeste Liu <CoelacanthusHex@gmail.com>, Guoli An <anguoli@uniontech.com>, 
 linux-doc@vger.kernel.org, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756444262; l=581;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=p5ERxcDEGCnOK/ZpG59PS01c3gt2BiQFtvRT5CoGK6A=;
 b=UTqTk7z0Sozu+v9q38u71swxk1Vq2XZYmgZD1ovK4YN7WfK7RxrYNgfCDhW5aGbPtJRT6ksZ3
 r7fid+myJ/oBViZdfaKVvTriXfc5CywdggqoZprdm/hCHyIK7fXo0nt
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
Cryolitia PukNgae (2):
      ALSA: usb-audio: Add module param mixer_min_mute
      ALSA: docs: Add documents for recently changes in snd-usb-audio

 Documentation/sound/alsa-configuration.rst | 35 ++++++++++++++++++++++++++----
 sound/usb/card.c                           |  7 ++++++
 2 files changed, 38 insertions(+), 4 deletions(-)
---
base-commit: 0c77ec32c041fec76268d46a1ae2628bafaa6a2d
change-id: 20250827-sound-param-f3dcf4afdfa2

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



