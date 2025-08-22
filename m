Return-Path: <linux-kernel+bounces-781679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58115B31569
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F73516EF1F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3856A2EF673;
	Fri, 22 Aug 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6v8eDwk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056219307F;
	Fri, 22 Aug 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858518; cv=none; b=p3EiBIhMYqWcYkuCDO1/OLDCXCHiUdzMZ39b4VG+O8K7ozMNSyqqR4/REDzITHWqqVWAIWZj6nadD2h3gUf9b2Z65ZpNp5cIJ/3lMc4hZq5dD9JtEA6UVYMLwCT//0+dKFZyKHzSS7h06ziJag/jm1lOB9tol167Y7o8tE8gh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858518; c=relaxed/simple;
	bh=UhhnLcGKdARCqcQkNb0PZAh2gumC9LMMptQdei1s5io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F0DIDRvXsSV7ICHZdXL3K+vtDiPYtiqLzfU1jxka8EE6vClXdE5pGlgtRLuvX7vHPuWF/wn3aTqBfuFyGHZ78rAzXX393/oIqiIvNT3KhMknxQJCG5qIpkSkObUFZ/ChmYTIAB4Qj6Y/ZSeu5syucNxblzWaRSJIhGNrPkXWDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6v8eDwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A3A7C4CEED;
	Fri, 22 Aug 2025 10:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755858518;
	bh=UhhnLcGKdARCqcQkNb0PZAh2gumC9LMMptQdei1s5io=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=b6v8eDwk4t4M4v+Kkn5FVe+lZSC0Rimai9aqmkuRWXOxLCOqch5YpdKZMgrazAlOf
	 /WT8WMqdKNfFTkQwOw1zbNM0Rodopx+mIHjFkXoyR7kbHZKt853iQqnY5EEELJDep8
	 c7GMjxnzwmiWa6bFKSQTnjBskKm9kQ1A+V/FEujQIGUiZdk26Atw5mgPdSe84OPcgb
	 m/QsKbYby3b7DlR0wVxpwvUCOu+n9bapkq8QJZpK1d2Z99jdcJhUx/gk704x90nu2+
	 1DIjSwF0nnjgQ+nKJGyo2NDwwE+FOOrRso3ommdR8g1U1JZNg6sTIyTmLWtQw+Mg5L
	 TjbiG3Ayr53lA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0554DCA0FE1;
	Fri, 22 Aug 2025 10:28:38 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Fri, 22 Aug 2025 18:28:33 +0800
Subject: [PATCH] ASoC: codecs: idt821034: fix wrong log in
 idt821034_chip_direction_output()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-idt821034-v1-1-e2bfffbde56f@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAFBGqGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyMjILfEwsjQwNhE1yDJNDnJwizJINnSTAmovqAoNS2zAmxWdGxtLQA
 pAZE0WwAAAA==
X-Change-ID: 20250822-idt821034-0b5cb86b0c96
To: Herve Codina <herve.codina@bootlin.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 guanwentao@uniontech.com, niecheng1@uniontech.com, zhanjun@uniontech.com, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755858517; l=1022;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=Xf7JFZXRbt8rXAX/IFwN/P7Ba3v6XdLGbf2wZX2q3kI=;
 b=utMVbNOaZjz16DXuia93Q7alE05P+SVaph8G790DbgkFgWzfz6oObdvp6v+qBHq16mbFeEGLp
 kPtPjee41xpAEHHkEpSeIBuVuIH8Ij2y3+4IgS0Z4TyyvsTUSalebt9
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Change `dir in` to `dir out`

Suggested-by: Jun Zhan <zhanjun@uniontech.com>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/soc/codecs/idt821034.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/idt821034.c b/sound/soc/codecs/idt821034.c
index 6738cf21983b0dc58e162cbfaacaedb5edaaa245..a03d4e5e7d144195622ea0cbf6b6c6ba95642aa7 100644
--- a/sound/soc/codecs/idt821034.c
+++ b/sound/soc/codecs/idt821034.c
@@ -1067,7 +1067,7 @@ static int idt821034_chip_direction_output(struct gpio_chip *c, unsigned int off
 
 	ret = idt821034_set_slic_conf(idt821034, ch, slic_conf);
 	if (ret) {
-		dev_err(&idt821034->spi->dev, "dir in gpio %d (%u, 0x%x) failed (%d)\n",
+		dev_err(&idt821034->spi->dev, "dir out gpio %d (%u, 0x%x) failed (%d)\n",
 			offset, ch, mask, ret);
 	}
 

---
base-commit: 3957a5720157264dcc41415fbec7c51c4000fc2d
change-id: 20250822-idt821034-0b5cb86b0c96

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



