Return-Path: <linux-kernel+bounces-663285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D42AAC4643
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 04:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2254E170F30
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 02:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B4F1AF0AE;
	Tue, 27 May 2025 02:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD2OLDfr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B111A8401;
	Tue, 27 May 2025 02:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748313460; cv=none; b=qiLhi/I8Qbz/5NNv2/k/77a5jyvNWFVGboAM6YkNllHRMeXQh3eC8G/3CYBvEwPNeqd1UaM7dB/RfMJXMRnioe+91QcP+951yom1+n21PGG7yT1V/FH/QyKzDQLWZ861dOzoyLf1sM/Uboub5u+pC3u0F7LSA0QRkZyYqH4POK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748313460; c=relaxed/simple;
	bh=4068hxbCAmggoE1hsd0cGt2lSl6xQ8bqvsTGFeTzWdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LCjBMket51o2D7DdXSuN0hOUjkAKRevDms78j1W/mlJWpv195ZDVmv30e8cxQb7chU3dGpI1g8PlH/jmUwmjMLO0doFvZZ82tRBcHwG6dn1V09izY2w9ndhYr/My1FqSiRtstjeEopqK7hP1vSMoG9fphHr8DIzV/Sng60RqR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD2OLDfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EA6C4CEED;
	Tue, 27 May 2025 02:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748313459;
	bh=4068hxbCAmggoE1hsd0cGt2lSl6xQ8bqvsTGFeTzWdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nD2OLDfricuWRN+Cf3obSvvPiZMGBWWD+E7vFletdnMO82zRN7Ny7jDV2w6ebfW5t
	 WvLX81+YSb9fR9e6gl9Xgx5FqpeTTJlDZt61QSymBxJqS9c0JIc3bBx4KnEf09g4ex
	 KUIVFzAVpjPAiAOOH9rM0IFnbUNZG8Y9Fgi9tbWCq2BWtM5gZnhqwukclD+qFrAqjh
	 UyyqQYc5npdJXMcJekGKrhTAlcYwdXZ9KfS390CbK+EgUn6zGppyudVFxSMKoPmUru
	 XEsguqsD9WKzcxw4cvHQ3n+FHyiHQE4POGrzf6a6nd1wAZhxoLty4T1AAbzdlN6nYO
	 Xi28VdHFKpJ8A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 2/5] ALSA: hda/realtek - restore auto-mute mode for Dell Chrome platform
Date: Mon, 26 May 2025 22:37:31 -0400
Message-Id: <20250527023734.1017073-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250527023734.1017073-1-sashal@kernel.org>
References: <20250527023734.1017073-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.8
Content-Transfer-Encoding: 8bit

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 5ad8a4ddc45048bc2fe23b75357b6bf185db004f ]

This board need to shutdown Class-D amp to avoid EMI issue.
Restore the Auto-Mute mode item will off pin control when Auto-mute mode was enable.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Links: https://lore.kernel.org/ee8bbe5236464c369719d96269ba8ef8@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2ff02fb6f7e94..3421a3c69b49a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6810,7 +6810,10 @@ static void alc256_fixup_chromebook(struct hda_codec *codec,
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
-		spec->gen.suppress_auto_mute = 1;
+		if (codec->core.subsystem_id == 0x10280d76)
+			spec->gen.suppress_auto_mute = 0;
+		else
+			spec->gen.suppress_auto_mute = 1;
 		spec->gen.suppress_auto_mic = 1;
 		spec->en_3kpull_low = false;
 		break;
-- 
2.39.5


