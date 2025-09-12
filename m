Return-Path: <linux-kernel+bounces-813296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F3CB5433E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCCCA08A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEDB2BDC16;
	Fri, 12 Sep 2025 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGkd3b8O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221C28726D;
	Fri, 12 Sep 2025 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659751; cv=none; b=nPTkC2Biuw6qPgWAkrJhv/SRPc2U/GnPfv1sK4No3yS+gaYCURsWhffDLtmyOFVU1MXL/pwXCEmQxcn1aIyekuZISorcleCcI7X2Oe1IFB1zbbXXrgYQaV6w5DEbTM5Tz17bjZf+TnhVCbOYvhiMZ9y9vXilYm7R74rf8+4gDro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659751; c=relaxed/simple;
	bh=niQWF1wkWxTNHpw5prHOgNovhde76RsAWKwkEaCR3sQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QBI5kjR4BA+CabCTq1Y2wzynIj6TR2kKeOUh3vDO4pCs6+K/TgYouOMpjqlnXNY57cZojbl3z5XgiTKIjXLvgMJp4PKY86p3gyl6SQJUyZuq2btcd2RF7DFM4q9jngyWL/OQAYjsiBnbF5QoLysJvEKu0hZUyls6ri2H4HMtr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGkd3b8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A72CC4CEFA;
	Fri, 12 Sep 2025 06:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757659751;
	bh=niQWF1wkWxTNHpw5prHOgNovhde76RsAWKwkEaCR3sQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VGkd3b8OeSmmUozbt5+QZx5XpeZ9MMm9PduNKTbJzBE7xCkTzUtIsjW1Nb2vvSjKZ
	 DFFIC32LAcRUot6dnSxwmUYT0nTKydvtgzqfl3cooG5IpF4+FsF2FJgk94txy9Bx3b
	 4tx3QQUFf8YayUxnTleCIfR6m7obC3lnxBZP9xagPs0wvUBYNFQUbx8UcXUuVMSrKO
	 +JJ5Du6jJmcI9dwayym0rUHD6Zf9/tb29nDCWq1isTg7jOVfcNp/08v7NhBg2KXdbq
	 h7jbMAyaFSAmukEk2orx6jwIkmWY3GzHbFmENdVXCR388lIzUcww1jbDrt+kGI6Y+S
	 7as0y5+rfe4JQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED4ACAC595;
	Fri, 12 Sep 2025 06:49:11 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Fri, 12 Sep 2025 14:49:00 +0800
Subject: [PATCH v2 3/3] ALSA: doc: add docs about device_device_quirk_flags
 in snd-usb-audio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-sound-v2-3-01ea3d279f4b@uniontech.com>
References: <20250912-sound-v2-0-01ea3d279f4b@uniontech.com>
In-Reply-To: <20250912-sound-v2-0-01ea3d279f4b@uniontech.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Feng Yuan <fengyuan@uniontech.com>, qaqland <anguoli@uniontech.com>, 
 kernel@uniontech.com, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757659749; l=7115;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=s/0dZ04dkumVF/ET0AfUgOb4GzZPo7Sb5MusAYIlxoQ=;
 b=MzHSOU9T94yHiBeBcOyihqZ8o2FViu1+bHrllNTq/IVFuryeOQEIR1P9Axf6Tb+3H2KUZM8IE
 Rli8GvTTN2uD5E3OLkngF0LIFxxbIa/EwtajnfFJMOWSP6fzgWr1nzy
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Just briefly described about the new option.

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 Documentation/sound/alsa-configuration.rst | 105 ++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 32 deletions(-)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index a2fb8ed251dd0294e7a62209ca15d5c32c6adfae..060dfbd4197d3134f20d3d86300d97b14071eee9 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -2296,40 +2296,81 @@ skip_validation
     The option is used to ignore the validation errors with the hexdump
     of the unit descriptor instead of a driver probe error, so that we
     can check its details.
+device_device_quirk_flags
+    The option povides a refined and flexible control for applying quirk
+    flags.  It allows to specify the quirk flags for each device, and could
+    be modified dynamically via sysfs.
+    The option accepts a string in the format of ``VID1:PID1:FLAGS1;VID2:PID2:
+    FLAGS2;...``, where ``VIDx`` and ``PIDx`` specify the device, and
+    ``FLAGSx`` specify the flags to be applied.  ``VIDx`` and ``PIDx`` are
+    4-digit hexadecimal numbers, and could be specified as ``*`` to match any
+    value.  ``FLAGSx`` could be a set of flags given by name, separated by
+    comma, or a hexadecimal number representing the bit flags.  The available
+    flag names are listed above.  An exclamation mark could be prefixed to a
+    flag name to negate the flag. For example,
+    ``1234:abcd:mixer_playback_min_mute,!ignore_ctl_error;*:*:0x01;``
+    applies the ``mixer_playback_min_mute`` flag and clears the
+    ``ignore_ctl_error`` flag for the device 1234:abcd, and applies
+    the ``skip_sample_rate`` flag for all devices.
 quirk_flags
     Contains the bit flags for various device specific workarounds.
     Applied to the corresponding card index.
 
-        * bit 0: Skip reading sample rate for devices
-        * bit 1: Create Media Controller API entries
-        * bit 2: Allow alignment on audio sub-slot at transfer
-        * bit 3: Add length specifier to transfers
-        * bit 4: Start playback stream at first in implement feedback mode
-        * bit 5: Skip clock selector setup
-        * bit 6: Ignore errors from clock source search
-        * bit 7: Indicates ITF-USB DSD based DACs
-        * bit 8: Add a delay of 20ms at each control message handling
-        * bit 9: Add a delay of 1-2ms at each control message handling
-        * bit 10: Add a delay of 5-6ms at each control message handling
-        * bit 11: Add a delay of 50ms at each interface setup
-        * bit 12: Perform sample rate validations at probe
-        * bit 13: Disable runtime PM autosuspend
-        * bit 14: Ignore errors for mixer access
-        * bit 15: Support generic DSD raw U32_BE format
-        * bit 16: Set up the interface at first like UAC1
-        * bit 17: Apply the generic implicit feedback sync mode
-        * bit 18: Don't apply implicit feedback sync mode
-        * bit 19: Don't closed interface during setting sample rate
-        * bit 20: Force an interface reset whenever stopping & restarting
-          a stream
-        * bit 21: Do not set PCM rate (frequency) when only one rate is
-          available for the given endpoint.
-        * bit 22: Set the fixed resolution 16 for Mic Capture Volume
-        * bit 23: Set the fixed resolution 384 for Mic Capture Volume
-        * bit 24: Set minimum volume control value as mute for devices
-          where the lowest playback value represents muted state instead
-          of minimum audible volume
-        * bit 25: Be similar to bit 24 but for capture streams
+        * bit 0: ``get_sample_rate``
+          Skip reading sample rate for devices
+        * bit 1: ``share_media_device``
+          Create Media Controller API entries
+        * bit 2: ``align_transfer``
+          Allow alignment on audio sub-slot at transfer
+        * bit 3: ``tx_length``
+          Add length specifier to transfers
+        * bit 4: ``playback_first``
+          Start playback stream at first in implement feedback mode
+        * bit 5: ``skip_clock_selector``
+          Skip clock selector setup
+        * bit 6: ``ignore_clock_source``
+          Ignore errors from clock source search
+        * bit 7: ``itf_usb_dsd_dac``
+          Indicates ITF-USB DSD based DACs
+        * bit 8: ``ctl_msg_delay``
+          Add a delay of 20ms at each control message handling
+        * bit 9: ``ctl_msg_delay_1m``
+          Add a delay of 1-2ms at each control message handling
+        * bit 10: ``ctl_msg_delay_5m``
+          Add a delay of 5-6ms at each control message handling
+        * bit 11: ``iface_delay``
+          Add a delay of 50ms at each interface setup
+        * bit 12: ``validate_rates``
+          Perform sample rate validations at probe
+        * bit 13: ``disable_autosuspend``
+          Disable runtime PM autosuspend
+        * bit 14: ``ignore_ctl_error``
+          Ignore errors for mixer access
+        * bit 15: ``dsd_raw``
+          Support generic DSD raw U32_BE format
+        * bit 16: ``set_iface_first``
+          Set up the interface at first like UAC1
+        * bit 17: ``generic_implicit_fb``
+          Apply the generic implicit feedback sync mode
+        * bit 18: ``skip_implicit_fb``
+          Don't apply implicit feedback sync mode
+        * bit 19: ``iface_skip_close``
+          Don't closed interface during setting sample rate
+        * bit 20: ``force_iface_reset``
+          Force an interface reset whenever stopping & restarting a stream
+        * bit 21: ``fixed_rate``
+          Do not set PCM rate (frequency) when only one rate is available
+          for the given endpoint
+        * bit 22: ``mic_res_16``
+          Set the fixed resolution 16 for Mic Capture Volume
+        * bit 23: ``mic_res_384``
+          Set the fixed resolution 384 for Mic Capture Volume
+        * bit 24: ``mixer_playback_min_mute``
+          Set minimum volume control value as mute for devices where the
+          lowest playback value represents muted state instead of minimum
+          audible volume
+        * bit 25: ``mixer_capture_min_mute``
+          Be similar to bit 24 but for capture streams
 
 This module supports multiple devices, autoprobe and hotplugging.
 
@@ -2344,8 +2385,8 @@ report it to the upstream.
 NB: ``quirk_alias`` option is provided only for testing / development.
 If you want to have a proper support, contact to upstream for
 adding the matching quirk in the driver code statically.
-Ditto for ``quirk_flags``.  If a device is known to require specific
-workarounds, please report to the upstream.
+Ditto for ``quirk_flags`` and ``device_device_quirk_flags``.  If a device
+is known to require specific workarounds, please report to the upstream.
 
 Module snd-usb-caiaq
 --------------------

-- 
2.51.0



