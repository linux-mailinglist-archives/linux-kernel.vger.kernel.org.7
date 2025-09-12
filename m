Return-Path: <linux-kernel+bounces-813294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 639AEB5433B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B878E1BC6C58
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA5A2BD5A2;
	Fri, 12 Sep 2025 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i220trvz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F928725A;
	Fri, 12 Sep 2025 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659751; cv=none; b=EPSA9wgZOtj+Ei68pBmbH92ud1A5ihQ6KRpj1hiyHVk8B1Mby+Ci16m8deCBiWeJLkxWUa3eDdCxrGHR2bGdA+H1oBlRgAK4p8dAXuSsUA9IW0Q3JDmBix2IU3efhBsKGK4L0+BZsj+TF/S1BldHMpoomZFZa79/t1rq7qT0Qok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659751; c=relaxed/simple;
	bh=jpa6rq+2V3zYCzSXmZnw1ZVzdo6cU0uu6N1P0LBv+cE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T/O3IXtwwxp7yL8kcjemK0siE8Uul0xOvuNwQKBr5LPI9ZtZwfcUzaJRvFadkyecBJs0AF+J60zAUULUFVeBq46fmqikTuPyKc66NjHhMfd6ZHXzKVtxK70j3duQlIez4IoJkAOqAw3MQ/09Iz75Tdhba11oRZbTl7r/9k8krN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i220trvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04EA4C4CEF4;
	Fri, 12 Sep 2025 06:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757659751;
	bh=jpa6rq+2V3zYCzSXmZnw1ZVzdo6cU0uu6N1P0LBv+cE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=i220trvz+3CLXhOBy/WOsH1wSNjW2xg0Zs6/Y4giSQnX0/IdKJMeKMNubYd8An7CS
	 /yu99lTJg/rAhDhPbTIl9d86+wFkIkOHkGlguYGIhzA8f9zIBe83FI6jW7uFUA5Z19
	 dc1juQLVgVSPk70hPimFDUPvU2O9SjTRNnQmRBSmcNW+3im+Q0lXegjyguNs9ApNVU
	 +YdCt/wDdqiQzpv7+01YYN4SmOgoo3YWILqtRycIJ73wVnK0iP6UEQxn0svd0Bb+5C
	 uDU8hEEQRKnBhL0PyO5uv59Ms1s/lQiB1c7dXXxPnio0b4Vrvy5tpVhnzG7VPD7EKN
	 5935Sw/E1bB7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E533ECAC593;
	Fri, 12 Sep 2025 06:49:10 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Subject: [PATCH v2 0/3] ALSA: usb-audio: add module param
 device_quirk_flags
Date: Fri, 12 Sep 2025 14:48:57 +0800
Message-Id: <20250912-sound-v2-0-01ea3d279f4b@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnCw2gC/zXNwQ7CIAzG8VdZehYDTTTiyfcwO2DppAfBwEY0C
 +8uLnr8f2l+XaFwFi5wHlbIXKVIij1wNwAFF++sxPcG1HjQ1mhV0hK9ctbQ6UgW/c1Bv31mnuS
 1Odexd5Ayp/ze2Gq+61/An1CN0orI0uTthF6byxL775kp7Ck9YGytfQDyM5rMngAAAA==
X-Change-ID: 20250910-sound-a91c86c92dba
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Feng Yuan <fengyuan@uniontech.com>, qaqland <anguoli@uniontech.com>, 
 kernel@uniontech.com, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757659749; l=1787;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=jpa6rq+2V3zYCzSXmZnw1ZVzdo6cU0uu6N1P0LBv+cE=;
 b=dj/zGxlegARGAtOG6O5oa3GsH/z4iu8jDMZJrIn6DCVT9L6Z8PMg9UAzoH73Y3dug0FcBe1/y
 r3dxT4h7H8iCdvrzgpFAFBu+0aAOPXwDT7xVlz8FyYMmhDjUB7DYOEd
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

As an implementation of what has been discussed previously[1].

> An open question is whether we may want yet a new module option or
> rather extend the existing quirk option to accept the strings
> instead.  Basically, when the given argument has a colon, it's a new
> syntax.  If it's only a number, it's an old syntax, and parse like
> before.  But, I'm open for either way (a new option or extend the
> existing one).

I would like to add a new param. The existed param
`static unsigned int quirk_flags[SNDRV_CARDS]` seems to related to
some sequence the card probed. To be honest, I havn't fully understood
it. And it seems hard to improve it while keeping compatibility.

1. https://lore.kernel.org/all/87h5xm5g7f.wl-tiwai@suse.de/

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
Changes in v2:
- Cleaned up some internal rebase confusion, sorry for that
- Link to v1: https://lore.kernel.org/r/20250912-sound-v1-0-cc9cfd9f2d01@uniontech.com

---
Cryolitia PukNgae (3):
      ALSA: usb-audio: add two-way convert between name and bit for QUIRK_FLAG_*
      ALSA: usb-audio: add module param device_quirk_flags
      ALSA: doc: add docs about device_device_quirk_flags in snd-usb-audio

 Documentation/sound/alsa-configuration.rst | 105 ++++++++++++------
 sound/usb/card.c                           | 165 ++++++++++++++++++++++++++++-
 sound/usb/quirks.c                         | 110 ++++++++++++++++++-
 sound/usb/quirks.h                         |   5 +
 sound/usb/usbaudio.h                       |  14 +++
 5 files changed, 362 insertions(+), 37 deletions(-)
---
base-commit: 82ad508a85dc64cb4bd648edec5a4ce741648426
change-id: 20250910-sound-a91c86c92dba

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



