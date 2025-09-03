Return-Path: <linux-kernel+bounces-798256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB48CB41B52
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22833561764
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BE72F291E;
	Wed,  3 Sep 2025 10:09:39 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78B2F1FE5;
	Wed,  3 Sep 2025 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894178; cv=none; b=B27f6Ivn+BvU4v1AApTafmqRoCXlFiwu9+d8QnXObfTv1537JrC4rJTOEREXkaXRFCVmHKmopqJq1tYMWzL2XfPv9v/Ckhcv67lZQx2JCnL5f+6fVS74fOK2Dys3/CLq4Z3lgk8jLp2cjG/5oE4QHhEWnUZBOwRo99QE9oRaATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894178; c=relaxed/simple;
	bh=mx+WGmMtDhfLsYJlNFvQ2dV7FpAt6QrAPy3KA2pq4Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H9gYvlzUcsPmUvNrlR+jTAca0jxpS/sUgBCfJ4gVMI4WMQG9imLGyAdXPw+EueKS2pExPYKVKFRLHZhwP1SXmt1g9stEx+ThSgVV20q+4Mnwr/FU9eb38jBZBr3WYIIH8R3vl3hbePb1+XCMPyfBjWwDE516JFtkh4Qk9dSSrkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.harnackhaus-berlin.mpg.de (hh-wlan-01.rz-berlin.mpg.de [141.14.51.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3CB6B6020D50C;
	Wed, 03 Sep 2025 12:09:04 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: docs: Remove 3rd person singular s in *to indicate*
Date: Wed,  3 Sep 2025 12:08:41 +0200
Message-ID: <20250903100842.267194-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 78811dd56def ("ALSA: docs: Add documents for recently changes in snd-usb-audio")
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 Documentation/sound/alsa-configuration.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index 062b86522e4d..accaebbdd642 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -2293,7 +2293,7 @@ delayed_register
     notice the need.
 skip_validation
     Skip unit descriptor validation (default: no).
-    The option is used to ignores the validation errors with the hexdump
+    The option is used to ignore the validation errors with the hexdump
     of the unit descriptor instead of a driver probe error, so that we
     can check its details.
 quirk_flags
-- 
2.51.0


