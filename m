Return-Path: <linux-kernel+bounces-797704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B8DB41427
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 827B57A8E10
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696E12D641F;
	Wed,  3 Sep 2025 05:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS40c5Po"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ACB2D3ECA;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756876187; cv=none; b=D6hQ6q0hgp6bxm0PxoYTWMjDPrNNuhyULwwV5WBpvbckJd3ANLyI+45mpOTYl2xpLLNPnf4bsTG2D5gE7g9j94EN713EOEpHekjFUx9MGy1XTmSnq+SQnF7N81NesNNnsbqAJsAAoKft/bss0DvigmszW/DVFmygIh6NUS5Q+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756876187; c=relaxed/simple;
	bh=+0mTKTtsuCB9dFm243PXtxnJL1c9wmKQIOd8m9PW3Kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JuQFsK8cnyNrUR3F1Lip0q20lpq3AGlEFnqgY+cpPe1R5w7pSK/sT3aUywo66vr6WYb+MWg01MaWeDS6PoNnwA1fBd5vGtL2KRsbhNiiMRR+P2eOup+1C6UKsi41/WcvSkwSPWChN2nvoGMWzy9bkkPOOEg9ZOQmOVSEYkniB9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS40c5Po; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 545BFC4CEF9;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756876187;
	bh=+0mTKTtsuCB9dFm243PXtxnJL1c9wmKQIOd8m9PW3Kc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HS40c5Po1oWGl3J206WXL9hfHDuG8uJODCBi2deOsOSZ+5vTBbDVsJzPHJZzCiGyY
	 1BVlzyD66fvzMin7cQx8TM3g7Uz/XSKwxld42QHIiWZzLn+R+E5HyBmb+bRu9/nR4J
	 fE8kWKwo5STCvinrgb6+bluvlCUKr6IRJPMjN0DaW/zavZyYw2LNf5Dgzl/02tLteR
	 7vc0WyKwUYsxJmvNHtQYGIAF7BEkLVUFqcMYy4xliqDPPKvn8ci5mxWgL5lMRExSZw
	 NjJqpzkA/B1QVK12TPV9Lb10zck0DwI0JMuF7L+T+3mDjLLIJNmH38ZGgZ8AzkVuHH
	 w74LH5iNvtKQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C71ACA100B;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Wed, 03 Sep 2025 13:09:48 +0800
Subject: [PATCH 4/4] ALSA: usb-audio: apply quirk for MOONDROP Quark2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-sound-v1-4-d4ca777b8512@uniontech.com>
References: <20250903-sound-v1-0-d4ca777b8512@uniontech.com>
In-Reply-To: <20250903-sound-v1-0-d4ca777b8512@uniontech.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Feng Yuan <fengyuan@uniontech.com>, Celeste Liu <uwu@coelacanthus.name>, 
 qaqland <anguoli@uniontech.com>, linux-doc@vger.kernel.org, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756876185; l=882;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=7pAYirEG6noZ5IXNpIYlyRGjI9vbDXOa2QYKKttvvvI=;
 b=G++rkHQVWT4ctoWBFWaBkDBP66wgyo7rvmHJAIrZIqjZVsBwYyoyP1LUt1nhxRDjgGa1RmAE5
 ebV8TrP6lF/CjRl2sNThL2XgI6qBiKNxV6CoZVjn9ubYedh7P/osLbW
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

It reports a MIN value -15360 for volume control, but will mute when
setting it less than -14208

Tested-by: Guoli An <anguoli@uniontech.com>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/usb/mixer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 5fcf1117777d1a1423806ea139a7692eea3c9ee8..34bcbfd8b54e66abc0229eefd354eb7bc4c01576 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1182,6 +1182,13 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->res = 1;
 		}
 		break;
+	case USB_ID(0x3302, 0x12db): /* MOONDROP Quark2 */
+		if (!strcmp(kctl->id.name, "PCM Playback Volume")) {
+			usb_audio_info(chip,
+				"set volume quirk for MOONDROP Quark2\n");
+			cval->min = -14208; /* Mute under it */
+		}
+		break;
 	}
 }
 

-- 
2.51.0



