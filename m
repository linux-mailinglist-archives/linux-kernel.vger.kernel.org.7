Return-Path: <linux-kernel+bounces-632995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1315AA9FAE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 00:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CA41A82B39
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 22:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6E2882DC;
	Mon,  5 May 2025 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvDF/ev6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC612882C5;
	Mon,  5 May 2025 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483344; cv=none; b=MJrvvVE3S5jXTRI/3mADCqGzps1TMPLqulWGBMvXwWcDYmm6c6IlD5FzdS0EQsU9tVtDzO0TMgfSYZlEzd0+Uj3P+RIh8NdhqMJV9LN78QhbvhE1fRVCDZubNyTx14YiYAEXNiUL9kzxP2NwUfAYTBNxpn9fgf+8/Z7K7Diz7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483344; c=relaxed/simple;
	bh=T4emcv9UCK38JyLGZpfgRsXa/UJf9WjXoVPBejbJkwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B6uylbG3sOQsm+OoJ6ANUFiLvI+85gS02RFNcDh74xl8YZO6NPOj/547S3hnMCVYtEaKSHq2ltT6mMVnc6QOWXBwhvUzvHd7lTLqaGC86SzB9nL54loJnh9Lm4W+D+qPPhJYJ9L/MhPCmnSe4JWA50Go0DZq4Z5johCBahkTFfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvDF/ev6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DF6C4CEED;
	Mon,  5 May 2025 22:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483344;
	bh=T4emcv9UCK38JyLGZpfgRsXa/UJf9WjXoVPBejbJkwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LvDF/ev6JY4mS+xCDW561idfG42USUpuIuMiA3nuoc/mxQpCdovBOA8HRX+aixOjH
	 oRlLWWaNSw3xL79J1/h4WaZ1KZ8dtoBeanYLGXW1xf8b2DPvA1PywwWXwqu/Wvp1AV
	 uxhK0R4llm0Xx+J33g3coYSZ6JH23mzmegYbWBGUfdVHFGPCVOxjYhAiKE2Fzt+KwL
	 CaS6q7rdlVz+W5OJ3+NL0Ip31OLYvhLXl7bJj5lUome4aI9TsoHYDRr+GcSqMB9mtD
	 bNLivLhVDqZuDmGcUprTqAtuPVeBHIpYEeevx0OF5FVRsQ4fsgldRgPw/R7NEWN4xR
	 vRV7swSa6fJiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pedro Nishiyama <nishiyama.pedro@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 045/642] Bluetooth: Disable SCO support if READ_VOICE_SETTING is unsupported/broken
Date: Mon,  5 May 2025 18:04:21 -0400
Message-Id: <20250505221419.2672473-45-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Pedro Nishiyama <nishiyama.pedro@gmail.com>

[ Upstream commit 14d17c78a4b1660c443bae9d38c814edea506f62 ]

A SCO connection without the proper voice_setting can cause
the controller to lock up.

Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 20d3cdcb14f6c..fa318f9ef40ec 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -930,6 +930,9 @@ static u8 hci_cc_read_buffer_size(struct hci_dev *hdev, void *data,
 		hdev->sco_pkts = 8;
 	}
 
+	if (!read_voice_setting_capable(hdev))
+		hdev->sco_pkts = 0;
+
 	hdev->acl_cnt = hdev->acl_pkts;
 	hdev->sco_cnt = hdev->sco_pkts;
 
-- 
2.39.5


