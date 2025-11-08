Return-Path: <linux-kernel+bounces-891301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DED6FC42625
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 04:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64165188EBED
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 03:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60AA2D593E;
	Sat,  8 Nov 2025 03:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmxX7+Kd"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1222AE7A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762573501; cv=none; b=TIDY3dj68zbR88NVySBF16E1P++D0/vsEKX6Z6Gqsxd6ohV+t1kmrKaWmeqO3b6jxW5fylnUEit+VsjDQdrJcyECSPNu/j2UhMiKuieuOQYYQciAWKQtkzHL4IheAGygiL3iYVyCxOKsmGL/iGqbooW0fXRbb9aFj6+xDQgabpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762573501; c=relaxed/simple;
	bh=F2fx+HzxmOVd0BPeYHQEx170LF8XktKX/4tBnnAb5ns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VuBQa27h0romVOmVw1+pBnUTi7WIoq2h/7R0Oltx58YoGrHvuYJxgJFjiJ3hhoNY5PwVgGCfPkHXcZF6GTcMzWIrGs078H6iJO/wLrQJtwpdJ/QyIUvQX8znzXE1e52NEbXbXvPC+rf/jYnkYquvxFIrACIhhfxVxfhh8OFQcRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmxX7+Kd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso1243370b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 19:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762573499; x=1763178299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xw52pDoAHz0z/WxrLuYi8EsZ2IV+tIXBY5PNwoamZ7g=;
        b=hmxX7+KdyYX9XqCxteAT57j0FTsRY9OO/tplM9B3rl9tiO0kkNTU+T06yr8fPMsY8X
         LOZVbUOKJmdEAFfeiT0eKGXwDcC9yCY0iw9Q3Udov76r1X8VDjKny2yNsZoSI6fTCHOO
         KDeMinT7PoafOmNOwhX9MVqR0CllEV8+GGbM+rG7BBeizodBsB7J1Ot86Z3G3dkPhrfI
         CzWS5OuXpOFalaUAMTPxJjDzUiXTYnVGpn+ifFvDN3CTKR+7voCWByDAq8y26D2nmlM2
         HJM5HhXqeyk/ModnpiVSPX57wTFa5xTbwg2S0077soPVqE6hnJW3cbVT3+vgCWpCMVBn
         JdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762573499; x=1763178299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xw52pDoAHz0z/WxrLuYi8EsZ2IV+tIXBY5PNwoamZ7g=;
        b=o4oYkA/fT9athJEc1E2ft12ovo/+6FfvaT9Sp5DBo8SYGRrrNS6TgbRMYc6nC0Aw5W
         kSbOi4Z+2EC3RKSyLieF5Sj9L8tda+CM35ca6DQL0H9k6zxuJMYTF7X8mFUbKn4im39r
         HENwnnOhF8OCJXpbn2RG7BeU3epPpW6DnPl8RIg5wz9vU6jy2FwINEq0aMf26G6MaHNx
         9BUo6Im/j/V/2j7f6GhTxTel4SL13FsodpJvx1pgL/mgjkHQX6MP81bVJu47oqyXEJth
         amPIqNxFQWLMLTBM/fobKhnEmRAvhXf02N8ptvdC2UKYhNbCbI9IpG7ggwiF35ix9Klu
         RGJA==
X-Forwarded-Encrypted: i=1; AJvYcCWHS3fntgyXkZokEvGd15vBRdco2vuvOlW5QqeN+IJ3AMT5oCw7SphiNaxJnkKebmgzzjNaWnGtlUbDo6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFvhRyRC8lbhTEblGRidtudWMKnMF67TJJVvweE+Zvyfbpdm4j
	iBfixya7Ng84sn642fYNkydxeL5OQCZ95mO2zxmagcTmzO8IgPCWGD/R
X-Gm-Gg: ASbGncsJRtaVLlu2RYvr4tR74NA97v5+h2pdArt9gIuL5nnnVPggYYpwYdyvM/LCWhO
	uS3tC+hxrDfuHYmkF+EH4QravABYl78wSTdtYpwYmzXqor9y6ZITyjmkxLG8s/sFnbZ9WL6BAxH
	/wSpI/kA5puW9pznKyBCdI1YD3B+nvYYe1ujYy+/xIzmbgpbyF2U/DcAKyNkGr1ZmqUigQzHrB1
	6UMskuvotyZBt9QeKUMunzAN/brz9SkWUgt0Vztr+PVBrCFb75+FePyYVboyrj3J5TiOQbDCePJ
	uZkO7AxlChJ/pijbPympH+uV93Z8JXSGNuoqwu15IhBOsL/aWooa7krLtJhgPdxAO+Aj6Fl79py
	3DWb+csiX33Gv7r5Pjy851/Su6qabUbenHL/HtwvkiJMDgzSw23d/g2Er5WRC3jbvkiFb02shb7
	E4OYVpZRodeVdm9NBStAFy3Sj0Wh4=
X-Google-Smtp-Source: AGHT+IHcQ/8zB+xoNbLUGjvnoe5rYBWJ5mzsPDX7sB5J/oExEn8lZG/37X0DJp374Kji4oF/aP+lJA==
X-Received: by 2002:a05:6a00:1a86:b0:7aa:4b8:179 with SMTP id d2e1a72fcca58-7b225b58c33mr1736322b3a.1.1762573498929;
        Fri, 07 Nov 2025 19:44:58 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a956sm4506809b3a.44.2025.11.07.19.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 19:44:58 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Subject: [PATCH v2] RDMA/core: Check for missing DGID attribute in ib_nl_is_good_ip_resp()
Date: Sat,  8 Nov 2025 03:43:36 +0000
Message-Id: <20251108034336.2100529-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported a use of uninitialized memory in hex_byte_pack()
via ip6_string() when printing %pI6 from ib_nl_handle_ip_res_resp().
Previously, ib_nl_process_good_ip_rsep() used the 'gid' without
verifying that the LS_NLA_TYPE_DGID attribute was present.

This patch adds a check for the DGID attribute in ib_nl_is_good_ip_resp(),
returning false if it is missing. This prevents uninitialized memory
usage downstream in ib_nl_process_good_ip_rsep().

Suggested-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
v2:
 - Added check for LS_NLA_TYPE_DGID in ib_nl_is_good_ip_resp() to
   avoid uninitialized 'gid' usage, as suggested by Vlad Dumitrescu.

v1: https://lore.kernel.org/all/20251107041002.2091584-1-kriish.sharma2006@gmail.com

 drivers/infiniband/core/addr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 61596cda2b65..dde9114fe6a1 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -93,13 +93,16 @@ static inline bool ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)
 	if (ret)
 		return false;
 
+	if (!tb[LS_NLA_TYPE_DGID])
+		return false;
+
 	return true;
 }
 
 static void ib_nl_process_good_ip_rsep(const struct nlmsghdr *nlh)
 {
 	const struct nlattr *head, *curr;
-	union ib_gid gid;
+	union ib_gid gid = {};
 	struct addr_req *req;
 	int len, rem;
 	int found = 0;
-- 
2.34.1


