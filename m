Return-Path: <linux-kernel+bounces-859939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8453CBEF003
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2A8189625D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CF717A310;
	Mon, 20 Oct 2025 01:31:51 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E06241AAC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760923911; cv=none; b=Awjn6Y8JVsL3xbb8SATQnGnUNO1Hw9YGnPaWJ2c9jrw59AxqlY26taUKDoBEtyYMOJqJMH4R3g+CHfU7QEPBs348/MbS5LAUwBL69+6VfK7erhuO8R5nKzDAtVJt52EJ9r2NZyAqPib4cxe6XpERMzuCzw6LUyIBpY8XCoTo4uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760923911; c=relaxed/simple;
	bh=qu60w27mAWi99XYIwPGmRHPKOVsU9dm/CBNvL9wBxRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZ4jmoUs50OTXQrnEKuyKv7UxTtngntJrKaiAxbRMyaJ1Xeihc1nbCs0noSDiIldZ9MyBj5AmGMxRbYgBDmNKp0lM4MmpFI+GTg8g3ofEryolSrme8KNTEe7KZrdAcoRtw0Qg7snk5dSaeRinaDU5HFLUszGba4c8kB8hgVGJvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201615.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202510200931350950;
        Mon, 20 Oct 2025 09:31:35 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201615.home.langchao.com (10.100.2.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 20 Oct 2025 09:31:35 +0800
Received: from inspur.com (10.100.2.112) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 20 Oct 2025 09:31:35 +0800
Received: from localhost.localdomain.com (unknown [10.94.6.246])
	by app8 (Coremail) with SMTP id cAJkCsDweM_xkPVonp8FAA--.3685S5;
	Mon, 20 Oct 2025 09:31:35 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <alain.volmat@foss.st.com>, <rgallaispou@gmail.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: [PATCH v2 1/1] drm/sti: hdmi: call drm_edid_connector_update when edid is NULL
Date: Mon, 20 Oct 2025 09:30:39 +0800
Message-ID: <20251020013039.1800-2-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251020013039.1800-1-chuguangqing@inspur.com>
References: <20251020013039.1800-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cAJkCsDweM_xkPVonp8FAA--.3685S5
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1ktw1UtF4DuFWrGFW8Xrb_yoW3Arg_WF
	y8WrsxXrsIkr92yw129r45ZF9avayruFWkWrn3t34xtr47XrW5G3yqgFyjva17Xr47tF9x
	K3ZagFy5ZrZ3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbmAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E
	0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67
	AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48I
	cxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxw
	CY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWU
	tVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqkskUUUUU=
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?SuPnyZRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KRKcCvnU13bfTavh8qDh7wpVeTP1+UOyPMuJaEqgFRzKPJ3x6eximEcQXY3QjC6OBhQE
	uc4sWHR35ub3F0GruH4=
Content-Type: text/plain
tUid: 202510200931356bf3cea568d6eba256712eab3259955b
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

call drm_edid_connector_update to reset the information when edid is NULL.
We can see the following comments in drm_edid.c
If EDID is NULL, reset the information.

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 4e7c3d78b2b9..e0be1be8bcdd 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1008,7 +1008,7 @@ static int sti_hdmi_connector_get_modes(struct drm_connector *connector)
 	return count;
 
 fail:
-	DRM_ERROR("Can't read HDMI EDID\n");
+	drm_edid_connector_update(connector, NULL);
 	return 0;
 }
 
-- 
2.43.7


