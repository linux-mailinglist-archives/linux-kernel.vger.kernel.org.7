Return-Path: <linux-kernel+bounces-851955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42803BD7C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F32401CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC98308F39;
	Tue, 14 Oct 2025 06:54:19 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0482405FD
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424859; cv=none; b=TyNnE+rBVm0283O2M1ZxmYZtnAVqL4OZ9xruJi/307gdNE35QnbH42XoZfPfsE9iIbT4MXmyBS26HUcCI9FH6jWnoJ1rGpIq03dSt0DRulUD4KZMk7ZR2KhdVjOTskog1l2Wd8SDmK1VXFh6wvVKW9X2D6zqKUMJ4vsVjqkNuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424859; c=relaxed/simple;
	bh=tqzwhNo1IWfDraFay+LYC+wpOQbn/Qdpr11j6JPhO7E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YLhsKChF5VeMunKFPxjoywPbWA+fq2abXO1Wi+Xt3UsfJ9CeDdUqlPz1nEAJCoDXn3vWhKCFl0XiIkR9RKw+gnUhJshLWgSRPe37gxj9PON9ZzxZdQ7XayGVjJ43K5i1rjaHYDNc7vg0Ktz6zY6lqTv6q8R2S80dwCj9zovP+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201614.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202510141454085612;
        Tue, 14 Oct 2025 14:54:08 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201614.home.langchao.com (10.100.2.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 14 Oct 2025 14:54:09 +0800
Received: from inspur.com (10.100.2.96) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 14 Oct 2025 14:54:08 +0800
Received: from localhost.localdomain.com (unknown [10.94.17.151])
	by app1 (Coremail) with SMTP id YAJkCsDwEnaP8+1oNfoWAA--.533S4;
	Tue, 14 Oct 2025 14:54:08 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <alain.volmat@foss.st.com>, <rgallaispou@gmail.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: [PATCH 1/1] drm/sti: call drm_edid_connector_update when edit is NULL
Date: Tue, 14 Oct 2025 14:54:06 +0800
Message-ID: <20251014065406.4017-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: YAJkCsDwEnaP8+1oNfoWAA--.533S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4Uuw4rAF4rAry7XryxXwb_yoW3XFX_WF
	y8WFWfXrsIkr92yw129r45ZF9avayruFWkGrn3ta4xtr47X3y5G3yDtFyjva17Xr4UtF9I
	k3ZagFy5Zr93GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?4D1F9pRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+Kbv0OT9rPYAOFMwQ4lF3QtMZ76xEoBV/ntrbBgynwF5g283VgfV0MswHKSjGP+0/JESk
	ZnH34Vg4+HwgcfDdH1s=
Content-Type: text/plain
tUid: 20251014145408de091ac489bfdb1d3b874b4e775fbbdb
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

call drm_edid_connector_update to reset the information when edit is NULL.
We can see the following comments in drm_edid.c
If EDID is NULL, reset the information.

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 4e7c3d78b2b9..31a72f7f4d43 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1008,6 +1008,7 @@ static int sti_hdmi_connector_get_modes(struct drm_connector *connector)
 	return count;
 
 fail:
+	drm_edid_connector_update(connector, NULL);
 	DRM_ERROR("Can't read HDMI EDID\n");
 	return 0;
 }
-- 
2.43.7


