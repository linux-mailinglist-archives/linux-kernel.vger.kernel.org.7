Return-Path: <linux-kernel+bounces-813254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8D2B542B9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BCE480928
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE342857F5;
	Fri, 12 Sep 2025 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmkcJ+57"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE127146D;
	Fri, 12 Sep 2025 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757658158; cv=none; b=GoVIkwkI39Cp8vzVOU6h8D2DOwUo3PwZSjFDYcNIJ8HqBuA9lu+gaH8DuB4x/hlj3+iKxwtCMgq+KFdwFaNKh99+mRw1eltsJ0wpzf5DnQHTMxzXuP2kp12CySLPXKtTFhTww4JKUeGs1bMLme8vAgqkajC3yz86sbafky2wV0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757658158; c=relaxed/simple;
	bh=20/cF58CH1PFpX46nEf1I3/pIu4rVHQWTarHqJ4eiNc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YnEgKSJez89vpzdAmWHi7/emEOjC3EJgiaBLyaCX8XQRgEe35ZDEpOAPa7peQAG2t/mQH5p3eKlklDQLkLB6SbzJuWuYCOWhv4KJEucScqUImza1lcmqA4IHG4VcBvkmolZ0sqeQZIdp4z0d/pvMByLHT/ibtKSiW3okozyKEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmkcJ+57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B5F0C4CEF4;
	Fri, 12 Sep 2025 06:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757658157;
	bh=20/cF58CH1PFpX46nEf1I3/pIu4rVHQWTarHqJ4eiNc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=HmkcJ+57pV2j4owxSo2WmFn2gM4/F3kEzoAAr9rC65QMNIztf6bgjezZPoMJnhXBP
	 YkknZhMo+AR62evuvJPZNNT0foUrNNg4cCtsgPxGDk60ULEp2mZ0hGpRotpf0ftJHg
	 LZkAJIcEea56vuvQ4xIlQmEHZo3VxTjOnwq/viVKom+ReyXeFfHht4HsllyAWcDqCI
	 KBH15jV2a1yBj76XiM1xfF06jGP07bpyfOtNidL+RWO+LheYQPV2/bLbSa5zyklsg3
	 7eTzCh6GdsPeMUCpv8L5ckVtgs3bDi1pYbO2r9/dyjYA7zAJQPgCVqTvpv7qyToB64
	 Wjl/MunrdodGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A03BCAC593;
	Fri, 12 Sep 2025 06:22:37 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Subject: [PATCH 0/3] ALSA: usb-audio: add module param device_quirk_flags
Date: Fri, 12 Sep 2025 14:22:34 +0800
Message-Id: <20250912-sound-v1-0-cc9cfd9f2d01@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACq8w2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0MD3eL80rwU3URLw2QLs2RLo5SkRCWg2oKi1LTMCrA50bG1tQAPszg
 5VwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757658156; l=1620;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=20/cF58CH1PFpX46nEf1I3/pIu4rVHQWTarHqJ4eiNc=;
 b=nrMVuVYuy2JKA5q8gznNSh34wMvBgIboi/CsPkYTFjchFjjFmQRb4AOD9+WDNMvkBqiQoYDL5
 9Dzfq4OGDMnCK14AoamBBspsLB0tYkKKcXjKb3xdlwnedYGTQe7HOUM
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
Cryolitia PukNgae (3):
      ALSA: usb-audio: add two-way convert between name and bit for QUIRK_FLAG_*
      ALSA: usb-audio: add module param device_quirk_flags
      ALSA: doc: add docs about device_device_quirk_flags in snd-usb-audio

 Documentation/sound/alsa-configuration.rst | 105 ++++++++++++------
 sound/usb/card.c                           | 165 ++++++++++++++++++++++++++++-
 sound/usb/quirks.c                         | 135 ++++++++++++++++++++++-
 sound/usb/quirks.h                         |   6 ++
 sound/usb/usbaudio.h                       |  14 +++
 5 files changed, 388 insertions(+), 37 deletions(-)
---
base-commit: 74423aed9d7db520f788fc5dcdb0e0a035e0b28f
change-id: 20250910-sound-a91c86c92dba

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



