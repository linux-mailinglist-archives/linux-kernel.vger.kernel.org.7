Return-Path: <linux-kernel+bounces-797700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629CFB41424
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290F7547268
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E8A2D63FC;
	Wed,  3 Sep 2025 05:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORz436ma"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B7017A2F6;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756876187; cv=none; b=dV7CWeFlwECzcaJx6DRGpAXktJpI8XSsFzWnZaFrFQ9hbsCCKMVMzKWSxKHSPbqjCkYndKtvaTg6++8krc7GHPIDCDHqIGST4vSKUX+3M9w8pTNSFI6goQMNDLCY3aB8sr6+LkRfbm3zALZNxaOfS0tbBuS9jBGCtg8NuzrcPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756876187; c=relaxed/simple;
	bh=u9cu7HB6ZKQ+UYVov00HqMXQZI5HNQmOImREMoKCVsY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y4bIMVE2e5IoN5E6mRwIxM2Oy9926b3PuU4Xmynwv9tTM0tulwMZAxyeSwzfkTbIym+eWNUuNO0BQvswRsumUz2kQ/7Xlgmzf/PvSUB4JUaYW33Zj2fLgO5LgraCvnfn5YJeIrVaYL8EBwUWCyiKz+rjvlP+Vk4LFUzYGh8Zt+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORz436ma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E785C4CEF0;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756876187;
	bh=u9cu7HB6ZKQ+UYVov00HqMXQZI5HNQmOImREMoKCVsY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ORz436marcCxKXRmkC2uegM99CJOZtok3Vi6GaKhZiIGU6Vj6fnW70mh6+uJXU+eO
	 eFBKRyMR4+zlJ4zQoDi9aFkjlrgqVg6MHdUqRZr29VE6jz6jCemNpwnNS97c7wL+XS
	 SeDPT068yiA9Bz+AcuXNtBBlRBTOESTcQf8vWuA1YEdoDAvJaxr8m91HHUyOw8I8Km
	 xlVmtxMT2jBfS2WRvB+ihl7btMqwpfc3c7v+dDMu0oNWmGwBsu3BcCf0iM6CNjOL1N
	 8JC13B7HSkPDw7pkiXL47xtJ+iI3Y4TbgwtH0TfBN+0i9l4ho7v9+DIlMUA8BfG700
	 mt/3F2ubOGeUw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06408CA100B;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Subject: [PATCH 0/4] ALSA: usb-audio: series of improvements to min_mute
Date: Wed, 03 Sep 2025 13:09:44 +0800
Message-Id: <20250903-sound-v1-0-d4ca777b8512@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJjNt2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwMj3eL80rwUXVNjs0Qzy1Rzo0RLYyWg2oKi1LTMCrA50bG1tQByimc
 vVwAAAA==
X-Change-ID: 20250902-sound-536a69e72a93
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Feng Yuan <fengyuan@uniontech.com>, Celeste Liu <uwu@coelacanthus.name>, 
 qaqland <anguoli@uniontech.com>, linux-doc@vger.kernel.org, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756876185; l=908;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=u9cu7HB6ZKQ+UYVov00HqMXQZI5HNQmOImREMoKCVsY=;
 b=jUtYH3kvO6z2XVRsiRLHqkmWO/5NbLP1jz2uqcxBJyuYHw7amEwAOdh+Ahdp6mguSCly8YSxW
 c+QqF3s1hLPDfk4A9kRnC+Pg3HjdubmwOztGjpw6HypX47rSh78agEL
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
Cryolitia PukNgae (4):
      ALSA: usb-audio: rename QUIRK_FLAG_MIXER_MIN_MUTE to QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE
      ALSA: usb-audio: add quirk QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE
      ALSA: usb-audio: apply "mixer_min_mute" quirks on some devices
      ALSA: usb-audio: apply quirk for MOONDROP Quark2

 Documentation/sound/alsa-configuration.rst |  1 +
 sound/usb/mixer.c                          |  7 +++++++
 sound/usb/mixer_quirks.c                   | 14 ++++++++++++--
 sound/usb/quirks.c                         | 24 ++++++++++++++----------
 sound/usb/usbaudio.h                       |  7 +++++--
 5 files changed, 39 insertions(+), 14 deletions(-)
---
base-commit: d414194eefc275bd17ad059baa23f2cd29c7d213
change-id: 20250902-sound-536a69e72a93

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



