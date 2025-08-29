Return-Path: <linux-kernel+bounces-791126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B66BB3B24D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 692577AB4C1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F410F216E32;
	Fri, 29 Aug 2025 05:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWKBH1wS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA2ECA52;
	Fri, 29 Aug 2025 05:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756444264; cv=none; b=IeO6ChSy03RO/itOn9cYdybWwfoB9NM/9d5q4GAwpquRdwGKPcQsPkE+ratFYvcG61uwqw/FZUaJt/fuWYGHA2Sr8RpAw00l8wjcAz0c0gnBasvrxb4IWtHZiue69hhDfq28sN1MHJzwSuLr1CqxBgvhb90E9Eh6kLVfjM1aVVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756444264; c=relaxed/simple;
	bh=6vLrdCJFaNsRzlk7G9yfns7UswYZoLn7qkCqbcJ/dfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXh3zOQIwLGriXbqUpvha5CqSo/KBVqBD6fTK+q/xdT0mymOsDMs3k51lsKx4tloJ/sD2qpVruey5tkgpRHIicHNo0gjcBaMw3OUDv24ShsHvpl66yJkPtSFlkS4w8PIJdd6DruAsSURxSG+0afoXdk8heDRHz5bWWacLiK5z7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWKBH1wS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1004CC4CEF1;
	Fri, 29 Aug 2025 05:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756444264;
	bh=6vLrdCJFaNsRzlk7G9yfns7UswYZoLn7qkCqbcJ/dfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JWKBH1wS9DfSdRXjIOBN4zY286LuwjYSgASN+ixMacmrTzXlfYdiuJhlsC6Ttl4Yr
	 V+acYpXSRtGll2NkLtu2Zg1qPtNL8MVZ0cF4ST3n1yrj80u9IYP+siSfQoCj3a51do
	 Gh7xyrOLPyz+XjB197LTPwihFLkCdnnuvsWgIQyixC3K8J/6iVxXyhfYgtRAqIF2Xf
	 CfPniNV5+j3eIsV/OalOnYknud7DArZP4Rjd+ebAVCPKkKciFktCH8WmPc2LIJtI7v
	 05RkAiswSh6E3oJTeXKjmIXbqsgZs7d32uOumiW2Gfi/7G22E3UBMmqm8v1nEZBG45
	 Q97fSL4L9Fc3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F29CA0FF6;
	Fri, 29 Aug 2025 05:11:04 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Fri, 29 Aug 2025 13:11:00 +0800
Subject: [PATCH 2/2] ALSA: docs: Add documents for recently changes in
 snd-usb-audio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-sound-param-v1-2-3c2f67cd7c97@uniontech.com>
References: <20250829-sound-param-v1-0-3c2f67cd7c97@uniontech.com>
In-Reply-To: <20250829-sound-param-v1-0-3c2f67cd7c97@uniontech.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Wang Yuli <wangyuli@deepin.org>, Guan Wentao <guanwentao@uniontech.com>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Celeste Liu <CoelacanthusHex@gmail.com>, Guoli An <anguoli@uniontech.com>, 
 linux-doc@vger.kernel.org, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756444262; l=3978;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=PnwZqS87di8Y9z9VFeETvAhxUw8n9nVXa6bBVHC+NIs=;
 b=1FLVNwx95G+yVtp4/fasPA4XQBJc3r+8xRhBSwg8yIwZ3YmsKuE2573PUMH5xjyv7HEyMaf3u
 ZsKLWGrnag8COq1So7judM/7g1YnsUZqMnLtplXSvddjnIYep9lFRwz
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Changed:
  - ignore_ctl_error
  - lowlatency
  - skip_validation
  - mixer_min_mute
  - quirk_flags[19:24]

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 Documentation/sound/alsa-configuration.rst | 35 ++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index a45174d165ebdeadd89de5f556483465c5f6e808..35b288a22e2e6d869f79ba12914b4ee6b538a6c6 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -2253,8 +2253,15 @@ device_setup
     Default: 0x0000 
 ignore_ctl_error
     Ignore any USB-controller regarding mixer interface (default: no)
+    ``ignore_ctl_error=1`` may help when you get an error at accessing
+    the mixer element such as URB error -22.  This happens on some
+    buggy USB device or the controller.  This workaround corresponds to
+    the ``quirk_flags`` bit 14, too.
 autoclock
     Enable auto-clock selection for UAC2 devices (default: yes)
+lowlatency
+    Enable low latency playback mode (default: yes).
+    Could disable it to switch back to the old mode if face a regression.
 quirk_alias
     Quirk alias list, pass strings like ``0123abcd:5678beef``, which
     applies the existing quirk for the device 5678:beef to a new
@@ -2284,6 +2291,17 @@ delayed_register
     The driver prints a message like "Found post-registration device
     assignment: 1234abcd:04" for such a device, so that user can
     notice the need.
+skip_validation
+    Skip unit descriptor validation (default: no).
+    The option is used to ignores the validation errors with the hexdump
+    of the unit descriptor instead of a driver probe error, so that we
+    can check its details.
+mixer_min_mute
+    Treat the minimum volume control value as mute (default: no).
+    ``mixer_min_mute=1`` may help when you find the audio mutes when
+    the volume is below a certain threshold.  This happens commonly with
+    USB audio devices.  This workaround corresponds to the ``quirk_flags``
+    bit 24, too.
 quirk_flags
     Contains the bit flags for various device specific workarounds.
     Applied to the corresponding card index.
@@ -2307,6 +2325,16 @@ quirk_flags
         * bit 16: Set up the interface at first like UAC1
         * bit 17: Apply the generic implicit feedback sync mode
         * bit 18: Don't apply implicit feedback sync mode
+        * bit 19: Don't closed interface during setting sample rate
+        * bit 20: Force an interface reset whenever stopping & restarting
+          a stream
+        * bit 21: Do not set PCM rate (frequency) when only one rate is
+          available for the given endpoint.
+        * bit 22: Set the fixed resolution 16 for Mic Capture Volume
+        * bit 23: Set the fixed resolution 384 for Mic Capture Volume
+        * bit 24: Set minimum volume control value as mute for devices
+          where the lowest playback value represents muted state instead
+          of minimum audible volume
 
 This module supports multiple devices, autoprobe and hotplugging.
 
@@ -2314,10 +2342,9 @@ NB: ``nrpacks`` parameter can be modified dynamically via sysfs.
 Don't put the value over 20.  Changing via sysfs has no sanity
 check.
 
-NB: ``ignore_ctl_error=1`` may help when you get an error at accessing
-the mixer element such as URB error -22.  This happens on some
-buggy USB device or the controller.  This workaround corresponds to
-the ``quirk_flags`` bit 14, too.
+NB: ``ignore_ctl_error=1`` and ``mixer_min_mute=1`` just provides A
+quick way to work around the issues.  If you have a buggy device that
+requires these quirks, please report it to the upstream.
 
 NB: ``quirk_alias`` option is provided only for testing / development.
 If you want to have a proper support, contact to upstream for

-- 
2.51.0



