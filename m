Return-Path: <linux-kernel+bounces-872900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABB9C1290A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654B61A670E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AF723BD1A;
	Tue, 28 Oct 2025 01:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="u6lymN6+"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14AC23ABA7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615278; cv=none; b=MVDddhk9uPvG1Uv0LjaKkVqQSIwBN2JU2EDkTXNfxzQGlNB69Uo/+vgnBUAVIBq8ialsgyE6snVc4iCtacybPQBbaoR8rJP6ax6rZqbqKnt8Zg60efW0fCbxpHFniH8mzle33BGHWmszIjnKkF9jJVM5njnLEhuHAdlibJViUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615278; c=relaxed/simple;
	bh=qOmd380iXlJDWlWR9Xlc5Z0tovU3eJ4ZmmZbJEfhhLs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q/GV6fGA4ga8EKuWQeGdZILqTqqfyqmWpl8APnKYbP/ssDbSWQ5ik0vRiQWcn5n94ZQ6+SPifn7JJC9HI6BPzWAHpX9jCiW+/CbqDqMSRc9UYJTjS+JMaxBeoufCaNNwIIc3r/QVSJOC4I+UUvwMKHHoKAJ7+jHCljqNWurjXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=u6lymN6+; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761615150;
	bh=JV2sw478GwgVmAvh9ZYNj7weQN2ACESG19aqgi3tUF0=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=u6lymN6+F/hKZFtvGxt32zehYvSy1qFXPWG8ODZHkbpSVXvnlPkq/FRhWrtSJ5PCG
	 0i3A5nRQCwWti2dw48ieREbXcyRuwo0UjzfEoJU2ks526aHvqV2Dkmk2f9miU8E3sb
	 EtjZJvKj53dW5xKz5SdiVU+ftx6RMhYNAqL/zDQA=
X-QQ-mid: esmtpgz12t1761615147ta74469fb
X-QQ-Originating-IP: 8wCQ6xC5UakYb8SmmwWGhNtmwz8bc9zXXh/aSm36HwU=
Received: from = ( [183.48.246.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Oct 2025 09:32:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9672489745579195001
EX-QQ-RecipientCnt: 13
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v2 0/2] ASoC: spacemit: fix build warning and error
Date: Tue, 28 Oct 2025 09:32:08 +0800
Message-Id: <20251028-fix-k1-i2s-v2-0-a547c15ed5c3@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABgdAGkC/02MywqDMBBFf0Vm3REzGl+r/kfpIsRJHdqoJFYE8
 d8bupK7OlzOOSByEI7QZwcE3iTKPCWgWwZ2NNOLUYbEQAVpVVCLTnZ8KxSKWJIuqald23Q1JGE
 JnN5/7PFM7MLscR0Dm2uiuiYGI+jZ46YwTTvtFFvqKnP/yPTd87gYy17W3M4ezvMHD08po68AA
 AA=
X-Change-ID: 20251028-fix-k1-i2s-3253276f8796
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Yixun Lan <dlan@gentoo.org>, Jinmei Wei <weijinmei@linux.spacemit.com>
Cc: linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761615145; l=983;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=qOmd380iXlJDWlWR9Xlc5Z0tovU3eJ4ZmmZbJEfhhLs=;
 b=9G3DYpc2xt8cUtQdYiNu+NtFBEk+OlPqTrDLNxrZ3ciGpOv7smxp+5koz2bO0eHJpkmLFgtHp
 xHqPLE03bt1CT18jTzuBBLkaIamdcgfTR+wtiGPtwQentODahg8K++b
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MkhAA4qIuU0pDwuVRwt2UX2pTGBhX5CbyfwuHSmTwStj1XomJlXwvD0H
	HkHsWWXIWFLNatJEgwgj0q2xYVTCMZRXRvl/CqtbASLFpJYdnNubX2SmIpAZCG0mAIltLZ4
	7CwBqOt5QRBsBkDSsecff9cuUcmxg6ezL8uyeMsUcAO1pFZChnc5IONkQeOIV9tkOWaTtYs
	2Q8mzzS3SduS3m4dYmKWMXaZ1M/+MkhIA0eue15Tzpn/URNMNoVhq61gHD/gMCZRdmYoNTQ
	kC2xAUod3NcIxL+3EDzSZSzS8Rp98OAH7FBY4NiyrwZGxvP0I+3i3WoF1v2KtZoztOkeFAq
	X+AP8VWGCtL/5FgjOP526hAxk62qvAwWlos+hWbdAuHuSNkLIHrCQHG+132gR/Ay6B1GHJc
	Rjf+MjSPRFpD4pRppU+j/Z8BlzBTwP8DacjynXoxbCy+QgismiRfeut0Y63QPtMCYgLnpsO
	GVSY99UFs4r6AsvkDQYr6slKhfHkT3Bwso28gbqO0qwU4xQqlfYwwrSj3MHNCbwwWaSF9Dn
	C8+XtetosBbk9w89p7KTIBQihmYj7OcEV/FmlhPHvsoBWUR2Vf1BKDMZNnxaM4lFQYcIF4a
	r+1oDFSaqMY2TRVvvHhYM9VdpkYUseKC7QZ+39vjWtJFge/X7inpPq+iaHG1n2ysf3S4QcG
	ANZ9ZfaKXYwG5soEjkfKyfCKpYklUwr0gU+WgUr6iQXoK0mZiPyM2xR2YDLc5M+D2Rxb08l
	wZSWWJsOUxppTUQQ8Z5aglz4hMCEyIWdlb1Pkz7PmLW29bw1odo9QonIVoN7eJVtM1IKJi3
	eAG8g4oD127JPkVM+T3i7q62SEd53nGq9a2vdv1Yrj3slYfAdZg25YmmZdmdYzVaWxk2SuQ
	SilvdylIMGgqVcZ9TonnRQujTAj43XMBMCS4fSZgzzeITYThdaaPVg6Odih9bc5N/yx8iY7
	yPipDMmifQd/6tnWfdyISnxwmE4s/XL2mc2hKChG8ErGMXup+9zlECK4CqWrmPiRu7ZxWEW
	zR5zu44hey+dEqsc/AJlBTdRI6UEYQlAQtwlLQxD3fWbA7xRSFTxyt5CQyPo4+PtZdK0gf6
	YuqhA8MMGt6NGEHfO6BwEQ+zMTufooqWxd1u1z5OxkDX9J2V67bqOumsDd1rTBtRQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

After the i2s patch for K1 was merged, two issues were identified:
- Missing error handling for the init_dai() function [1],
  which is required since the function allocates memory internally.
- The Kconfig entry ignored the dependency chain of DMA_CMA [2].

This series fixes both issues.

Link: https://lore.kernel.org/all/aPtiNCZ_KBezL2Dr@stanley.mountain/#t [1]
Link: https://lore.kernel.org/all/20251022141705.714b19b5@canb.auug.org.au/ [2]

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Troy Mitchell (2):
      ASoC: spacemit: add failure check for spacemit_i2s_init_dai()
      ASoC: spacemit: use `depends on` instead of `select`

 sound/soc/spacemit/Kconfig  | 3 +--
 sound/soc/spacemit/k1_i2s.c | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: 507d05188939fd47c9a11c3ab647f7db1bbef58c
change-id: 20251028-fix-k1-i2s-3253276f8796

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


