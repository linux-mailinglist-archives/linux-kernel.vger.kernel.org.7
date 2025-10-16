Return-Path: <linux-kernel+bounces-855390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE34BE1149
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D4564E3235
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C24A21;
	Thu, 16 Oct 2025 00:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lach.pw header.i=@lach.pw header.b="c3SV+VEY";
	dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b="Ck7x31Oz"
Received: from mail.0la.ch (mail.0la.ch [78.47.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3D1367
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760573643; cv=none; b=qAucpwIU9XfAn6sB7Tcq6ksaRzvz739WJ5lPJSAl5FoOZsFj5W4drNuEkKaTO6UEtdjQjRwqkiHsADl/ClUqGwuoor69/zBag+S/YxKrV/oEGRNfZ8mC7zUIqd8Xc9AEckGTwnzk4llatymYvXWL4PVwQFiRtwQ1+i6w0SV+y+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760573643; c=relaxed/simple;
	bh=JHwsu4aQizAX4uFcmiiYEBYSTGes2iyvTqLt/JFyAOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edraJJD5SpCA0bcbQwJ/Tjpkt1CTnva5eeV9a5hgZ9Bxx9VUZRjQOSCn8/tVUkhPJ6G17VMIKT8TDEyFJwZlS8gO8KQLmzwXQ/bsoN9anODwfmVCrZ6PNl+RzDbpm0+QDs26yvDMQc/1D5v8T7x1g9NPHkqYYboZy9pDXg0Le/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lach.pw; spf=pass smtp.mailfrom=lach.pw; dkim=pass (2048-bit key) header.d=lach.pw header.i=@lach.pw header.b=c3SV+VEY; dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b=Ck7x31Oz; arc=none smtp.client-ip=78.47.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lach.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lach.pw
DKIM-Signature: v=1; a=rsa-sha256; s=202502r; d=lach.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1760573477; bh=1oNxC6V6cVor+Gg4OXUBoLx
	iBpnvcw+v+jXnVnkw1A4=; b=c3SV+VEYSnmkMjrP35FF/JPKJj6ziXCYnU35Xg0eGa0a1GBrs7
	mB+WcjORpV6z3NPrYd9//sZhD+dEYgQ0vebpEb8vr6TdWaRbZumy9ezj5o53BDZGpLTPzI/Y8fZ
	O5OGauysQDTZY0lmMPHOUyNSRaqHJnxPCIxO11VXfpJw47ftnm/6uFp4Z6FV86tWqydW2QUdBNh
	Ac9QIO09n6L2r5ZC9MRFG+bDv+u851Ooeb66dPZlK81TnHYKXvcLI9Z6hpHc0dqMDbrDth/8/9y
	s1YNmzOXvqjVnxIQgT+ciBdq9vvjNXyyB3nnFlGDcHhqbQgE6QaN+LGD5u15k4R0FVA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202502e; d=lach.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1760573477; bh=1oNxC6V6cVor+Gg4OXUBoLx
	iBpnvcw+v+jXnVnkw1A4=; b=Ck7x31Oz0haAxmOIULjU1JOV33EZjG3paceDvJ3Wn2XL1R2Fvz
	l+6ObPbLUc/GKPL9Re+1KDjpEiyNQoMhKKDQ==;
From: Yaroslav Bolyukin <iam@lach.pw>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yaroslav Bolyukin <iam@lach.pw>
Subject: [PATCH v4 0/2] DisplayID DSC passthrough timing support
Date: Thu, 16 Oct 2025 02:10:37 +0200
Message-ID: <20251016001038.13611-2-iam@lach.pw>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VESA DisplayID spec allows the device to force its DSC bits per pixel
value.

For example, the HTC Vive Pro 2 VR headset uses this value in
high-resolution modes (3680x1836@90-120, 4896x2448@90-120), and when the
kernel doesn't respect this parameter, garbage is displayed on the HMD
instead.

Me and other users have successfully tested the old (v3) version of this
patch (which was applying DSC BPP value unconditionally, thus incorrect:
https://lkml.org/lkml/2023/2/26/116) on Vive Pro 2 and
Bigscreen Beyond VR headsets, and have been using it daily, it is known
to work and doesn't seem to break anything else since 2022.

Previously, I didn't have enough dedication to get it merged, I hope
this time I will manage to get it to v6.19 :D

Regarding driver support - I have looked at amdgpu and Nvidia's
open-gpu-kernel-modules, and both seem to have some indication for this
value; however, in Linux, it is unused in both.

First patch implements parsing of DSC BPP values and display mode VII
timings flag which mandates that the DSC BPP value should actually be
used for this display mode.

The second patch implements handling of this value for AMDGPU driver.

The only thing that I don't like in the current implementation, is how
the value of `dsc_passthrough_timings_support` flag is propagated from
the connector display modes to the mode created in `DRM_IOCTL_MODE_SETCRTC`
handler (which is used for VR display initialization in Monado and
StreamVR), it feels like this flag should be initialized by the kernel
itself, but as far as I can see there is no correct way to do this, as
the timing constraints calculation belongs to the individual drivers.

Another problem with how this flag is set, is that there is no hard
connection between modes creaded in `SETCRTC` and the modes actually
defined by connector, so I implement an assumption that this flag should
be the same between choosen mode and the preferred display mode. Given
that previously due to the missing support for this flag displays
were only showing garbage, I believe this assumption won't break
anything.

Both of those downsides are due to the fact my understanding of DRM
subsystem is not that high. If another implementation would be proposed
by AMDGPU maintainers - I will gladly implement it here.

v3->v4:
 * This patch now parses timings support flag on type VII block, instead
   of applying it unconditionally. Previously I didn't understand the
   spec properly.
 * Now it also is not being applied for non-supported and/or non-VII
   blocks in amdgpu driver.

Regards,

Lach

Yaroslav Bolyukin (2):
  drm/edid: parse DRM VESA dsc bpp target
  drm/amd: use fixed dsc bits-per-pixel from edid

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++-
 drivers/gpu/drm/drm_displayid_internal.h      |  8 +++
 drivers/gpu/drm/drm_edid.c                    | 61 ++++++++++++-------
 include/drm/drm_connector.h                   |  6 ++
 include/drm/drm_modes.h                       | 10 +++
 5 files changed, 77 insertions(+), 22 deletions(-)

-- 
2.51.0


