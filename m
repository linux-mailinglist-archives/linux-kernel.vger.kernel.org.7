Return-Path: <linux-kernel+bounces-788695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56CCB388D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67F3462A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5702D7801;
	Wed, 27 Aug 2025 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="k4EbnvCo"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720A921019E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316785; cv=none; b=IJLtbgXI8S+W5YqOv9QocmchJ4MJfWUNdvHSlCb7wey9bp6bOs5Gy8cECInlYPamQ6UZxF2a2cGue1ZflqcQ+VhVxBbSvotGOk+u2re5Djm5AO0i1gdF95sUYkqjk4kIC00zSjQ2o/HHIUCgMh114SLxN47DKMAkSoUw26rBLjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316785; c=relaxed/simple;
	bh=WLaSPTN3UuQjplEVIYv3UQ03LXzc0NlBFOgR7X33iNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omurbBzGv60HD14yuDd/rLnr0KWBQL5+hDkAHDuovYGSbLPcZFcre53MirR7oTas5ibM7VaqvGbZiRWpjsNKHXd05TF5fWWUmWj2vAky2RVOD8lP6IuPm/ZuhzRfeO1LsvsTPAdj8YqDRF3e6AsgrFZ+jXobEvM03z5E2NQtvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=k4EbnvCo; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id BF7CDBDF2B;
	Wed, 27 Aug 2025 20:46:15 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id C2506BDF20;
	Wed, 27 Aug 2025 20:46:14 +0300 (EEST)
Received: from antheas-z13 (x5996a855.customers.hiper-net.dk [89.150.168.85])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id E378B1FDB98;
	Wed, 27 Aug 2025 20:46:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756316774;
	bh=ovIlQIJ/aDzEgGzWDIhAbOQYJNwSDIEyyKKca+iKvF0=; h=From:To:Subject;
	b=k4EbnvCogg/nr50vOSRViGYMFDVyrncsj/j+0ZZUTch1JQcgMxPOQ9my4E0HN4QY/
	 NWVTY/oXrc35dtBXezX9sm6o+Hn7hfKoLorcjwVAtNKF2iz0jNPE80bHFHtq5Xjg1W
	 QpuRcVRNJ/sZzJFazDcPFC1R1GJfB8UqalxHdDKfcayGC7yDe+O6pmixcSvW8epR0s
	 1Z/ki72jyN307478djS/suHbvazhMGPqrvf8MbddKLUFTJ9OOXISfHmlAIU2VD9QWv
	 +4CYp17MyBPWxeBeGRktuDEP/OVtAOjUqCc7F3jomXGtjbuUlc+QF0G1pssSRkF9Q7
	 jnKev/YQuE+eg==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 89.150.168.85) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	philm@manjaro.org,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Robert Beckett <bob.beckett@collabora.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v2 0/5] drm: panel-backlight-quirks: Do partial refactor and
 apply OLED fix
Date: Wed, 27 Aug 2025 19:43:55 +0200
Message-ID: <20250827174400.3692549-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175631677444.1365124.8667478652151918942@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

This is an alternative to [1], since Phil found out there are still invalid
values. We need to reconsider the other patch in that series anyway because
the latest AMD firmware update might have fixed the Z13.

This series refactors the panel-backlight-quirks code to make it easier to
add new quirks. Specifically, it adds the ability to bind to a secondary
DMI match so that the make of a device can be specified. Then, it makes
EDID optional, for devices we know the value should be applied universally.

This is then used to add a quirk for OLED panels that have an issue
when their backlight is set with a value that contains a 0/1 value in their
minor byte. This issue affects four handhelds from three different vendors,
three of which are in the field. This quirk applies a |3 mask to the
backlight value, which avoids this issue. In addition, the value change
is minor enough so that it is essentially a NOOP. There is no need for
ensuring it runs only on panels with faulty firmwares.

Finally, since allowed by this refactor, a quirk for Steam Decks is added
that lowers their minimum brightness to 0, matching SteamOS. This is
a nicety commit, which allows for mildly lower minimum brightness, so
there is no time sensitivity for having it merged. Mario noted that if
that quirk was refactored to use an EDID match via the current interface,
it could go through the fixes tree and land sooner, but perhaps it is not
worth the effort.

[1] https://lore.kernel.org/all/20250824085351.454619-2-lkml@antheas.dev/

---
V1: https://lore.kernel.org/all/20250824200202.1744335-1-lkml@antheas.dev/

Changes since v1:
- Remove leftover quirk from patch 3 (refactor)
- Add dangling comma in patch 4 (oled quirk)
- Add the next generation Zotac Zone in patch 4 (currently unreleased)
- Reword patch 1 and 5 subjects

Antheas Kapenekakis (5):
  drm: panel-backlight-quirks: Make EDID match optional
  drm: panel-backlight-quirks: Convert brightness quirk to generic
    structure
  drm: panel-backlight-quirks: Add secondary DMI match
  drm: panel-backlight-quirks: Add brightness mask quirk
  drm: panel-backlight-quirks: Add Steam Deck brightness quirk

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  19 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   6 +
 drivers/gpu/drm/drm_panel_backlight_quirks.c  | 113 ++++++++++++++----
 include/drm/drm_utils.h                       |   8 +-
 4 files changed, 115 insertions(+), 31 deletions(-)


base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.51.0



