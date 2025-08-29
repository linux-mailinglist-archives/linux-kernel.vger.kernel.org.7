Return-Path: <linux-kernel+bounces-791385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741BDB3B631
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D435E7A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA79288C81;
	Fri, 29 Aug 2025 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Urlg8agv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA0B1E0E1F;
	Fri, 29 Aug 2025 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457189; cv=none; b=Bm7Pe8eixP/wzL4vyNii3dRwp76NSb5bgtW6Rmrtg+1yZceBIcjuxUQWwwNHpPT9w0Xx5O0gbUzUGN6gX+Y6ylTzys9xmG+A5XDnJElxIFQCgKxEgU6/4ZISuSHLBE/PLun0nno8v2c783FmT6QydticnzPiIXLrDUXwriOvFME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457189; c=relaxed/simple;
	bh=DialTkaZ2UwEoPpeuNzfbQp3IDqYgtAn+UUymBTw6Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QLrifNB62Z6PX6av6qt5mYGeq11a5ncxRaw91noa4JiH/M2Nbl3VXX0KNUwo3WQQ0sFbmSaG2QXC0BM80013R2pLJziTHIPF2Rcz9bcNWviPt2YqWRHnVBAXf0KKbNJ1qoARNNax6dhebGcaGFStV7IsShdnDB22WegbgMYDxwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Urlg8agv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A02D1C4CEF0;
	Fri, 29 Aug 2025 08:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756457188;
	bh=DialTkaZ2UwEoPpeuNzfbQp3IDqYgtAn+UUymBTw6Io=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Urlg8agveP3FzvS8aPPcBa0pIrmxh5TS9xYk/WTKKR/MJvNSJbvsqrhp7ciuMsfBx
	 /lyhPxVNe9nj41BlFbwGYy3JbB3rE9S2AuHMDDHk6vM6KHVDZ326ExkUhHahxxZkWu
	 kZUV7bEMEgH6HQjqRECYFEK1BPoxWabLLJiPx7fq7HO0e0mJ4zba7vct4Bk8XaSnC6
	 7ARztJKyhCglBs5euuaoSps8SLs0x0i7PzE9RkkI0VNAW/jG+wtbeoxMd1SDXDTqYA
	 j/v9qHDzngfiySRJN3okkEWQMY+vtSy6L0fflQkUmOeJVAetmI/UoQ+iFpqlPqo0C9
	 6d3e+xdAoCUPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CB4CA0FF0;
	Fri, 29 Aug 2025 08:46:28 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Fri, 29 Aug 2025 16:46:06 +0800
Subject: [PATCH] ALSA: docs: Add documents for recently changes in
 snd-usb-audio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-sound-doc-v1-1-e0110452b03d@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAM1osWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNL3eL80rwU3ZT8ZF1z42SzVFMTEwvLFEMloPqCotS0zAqwWdGxtbU
 AYedTW1sAAAA=
X-Change-ID: 20250829-sound-doc-73c6e54489d1
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-sound@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, niecheng1@uniontech.com, 
 zhanjun@uniontech.com, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756457187; l=3763;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=HE89odsIwYI1Vul0J0CIerepfkejArZ/qTv9Q4oEXbY=;
 b=K4pQlW5283gHmgF0tuapReYbIHgrysYjpS0ltdEVRBVl5YcdIkLPZNJiNbKub9gScdwYiODmH
 koJvJicRJ6jAAjgm5wFOaskFcTntv3F86uVw9M/5r+XCm+6sbPDOBHQ
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
  - quirk_flags[19:24]

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 Documentation/sound/alsa-configuration.rst | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index a45174d165ebdeadd89de5f556483465c5f6e808..77fd70ac12975a271600ebd542672a3afb443d39 100644
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
@@ -2284,6 +2291,11 @@ delayed_register
     The driver prints a message like "Found post-registration device
     assignment: 1234abcd:04" for such a device, so that user can
     notice the need.
+skip_validation
+    Skip unit descriptor validation (default: no).
+    The option is used to ignores the validation errors with the hexdump
+    of the unit descriptor instead of a driver probe error, so that we
+    can check its details.
 quirk_flags
     Contains the bit flags for various device specific workarounds.
     Applied to the corresponding card index.
@@ -2307,6 +2319,16 @@ quirk_flags
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
 
@@ -2314,10 +2336,9 @@ NB: ``nrpacks`` parameter can be modified dynamically via sysfs.
 Don't put the value over 20.  Changing via sysfs has no sanity
 check.
 
-NB: ``ignore_ctl_error=1`` may help when you get an error at accessing
-the mixer element such as URB error -22.  This happens on some
-buggy USB device or the controller.  This workaround corresponds to
-the ``quirk_flags`` bit 14, too.
+NB: ``ignore_ctl_error=1`` just provides A quick way to work around the
+issues.  If you have a buggy device that requires these quirks, please
+report it to the upstream.
 
 NB: ``quirk_alias`` option is provided only for testing / development.
 If you want to have a proper support, contact to upstream for

---
base-commit: 15be520ab00cfc9c59fa1623de6757f61ab42d8a
change-id: 20250829-sound-doc-73c6e54489d1

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



