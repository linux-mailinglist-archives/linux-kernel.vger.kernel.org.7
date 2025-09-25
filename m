Return-Path: <linux-kernel+bounces-831666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B27CAB9D468
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E28F3A831E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D8B2E6CAE;
	Thu, 25 Sep 2025 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym9KgULS"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6912F2E610F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758769608; cv=none; b=ohDg1zoTbeGrLXEnCgRo+0nSgVPV4eTZH//WutHqtkQI8In2OQSyTcMWfFVyfZwOFmzKDTpX4vLjdtnOG9pdAwoUgyruUQEH3sPevWG1IHBglQRznoRRAUOohJTtkK+DrVEdIbAj928diqybRGw4Fsk6GhXxaHnLYNHH/MJcXiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758769608; c=relaxed/simple;
	bh=rH8P3qg0K5dMS5StqkrnMCVVr3KD+o3NYBukhn3mPYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aA+bfObNi7ZVYkhQLtWcPxjEdPws+UoO1PSNQjxUcERfgOMEWsG5UQ2mRCrXjaHVPMKvmP/2rtqGZtBHK9nn4ebxvVq0mojqDr0giLYK97yc21vUvKy3a0iFu0eP7naK937ALT7W03UohBC+8K0TMgtAVnL5g6hgDRpfaQRQbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym9KgULS; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so539343a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758769607; x=1759374407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FUYHClQS0G+S0WCTqbPbr6zqw1HbxOG9lfCaJDm6n0U=;
        b=Ym9KgULStldYvpwbz5S4yhRdx/GSokrKDhsy9Nk9V90N7zMkDBLeFzk1QHF7rqP0v5
         3MuzQeFoaOb9sxfaPsCk0oCw8wTp/Wu0bAFF6w2qJv4q8GlkwMLyHPXTM/SpxkjqTdCk
         M4F4dTYQLx67y7KNkO+92NIaUzFa0Td8iwc6n+5WC9m+iggkhmDxndnnBtfJLXBJVHcp
         EfJr9R5gh09RNw6eneLCFPszVj0LD/cWVZOQEm3VQxB/y0/Vqa2APexod+IqLRRuEsS1
         V4sVQm5lWAtMdObzwsQzeixib90lzVXHH+oGFg5sQ+qHrtaCLHyxgBMFqVDzu28sZsge
         5bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758769607; x=1759374407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUYHClQS0G+S0WCTqbPbr6zqw1HbxOG9lfCaJDm6n0U=;
        b=vlFj5LdAbpLz7ADK8RRi82x7Y13RWrfu9zm5wV58l4NwvlF2eGndY7QWtrbmYpG9X4
         VFD8cmNws9d9yKOnxo5DstChZNREMigkD2BBr16MkSMlWz27opcSo+6ab4cYm3mk3z+d
         9t1gumvzGLUAZYoal9Jy30SsZI+XigPQA0pVHUJFMqwBnYLr/yDpI2O0KIr1decCudpB
         KH430jXlI6KcDiBIy/ejwtsdAkyvL3HecFN3hqKOAur1QTjvTB4R3TvmS2VaGsml5CXH
         g+yI3Lf7jiiq+ucq5/7saJwHeAxm8QKRJx1tD5w88HFtoEjeVdBUhaeUeOvjYI64Jt+X
         En1A==
X-Forwarded-Encrypted: i=1; AJvYcCVeNQ2mg7iVknV7vcE5MeIp2uewxqWrKkzLMvy/V1DnXGoY11XyVpioSwNe55ojpwJPtDPhYn8q7qU/Aek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/WfwfA+rECvzx/eA1cDwHEMaMJ1zo2EopDUOjT8QjUpk6oky
	4rPPTvygC8bKYQODsnneoED7PGc50qTxsprUjDLkLutTgFxj8AiSyKQkd2HmfsCq
X-Gm-Gg: ASbGncvjD+loPYUkO15V8W2ONzrtWb5H1chBAFzvcar6XI1N9iHpAIZxxpZTazjeJHY
	sB9u/a/rQ6zz9Ytf1htiFtFDNFwCyZBCEvsUR5Z/80kB6/nFUxsr9EOOPez+B6E8YNMHawuky4g
	jIU7F9e0UNMg1uq/u9VbRQ1peSmpjBpyfLwB2H980xJEtJMZISRvL6pn1GoyCydVHrFbXT0NiHQ
	aiHME0DEk5HwUSJvJdAQW5pkuu/8H1n1yZHqZhjcSgvAMeEIFOaQ9imSRi/nKfAoRYAjc2egN2T
	8RKE8AVfsQO0NTkYgjqPdbCNFbZSCbbHAh5xT+WH9bDJY+RL42u0+z3MvTfzfhTkGCKtkasz3ed
	teCQuQT6+CZyZdpiFp0SuGLw1//CwZ0Vrqbiszw==
X-Google-Smtp-Source: AGHT+IEQknUMrk+Hu+MnB2H8vzIQ0PVZiqSxzWqLwK4eimCwRKAxen25VgOT/kPDY9BAgpEVHW1bFw==
X-Received: by 2002:a17:90b:4f4b:b0:32e:859:c79 with SMTP id 98e67ed59e1d1-3342a15e6b6mr2041639a91.0.1758769606572;
        Wed, 24 Sep 2025 20:06:46 -0700 (PDT)
Received: from ryzoh.. ([2804:14c:5fc8:8033:da0e:8d21:9269:33ba])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33474f14e4bsm571669a91.28.2025.09.24.20.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 20:06:46 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: shaggy@kernel.org,
	duttaditya18@gmail.com,
	ghanshyam1898@gmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	syzbot+13ba7f3e9a17f77250fe@syzkaller.appspotmail.com
Subject: [PATCH] jfs: fix im_l2nbperiext shift out of bounds
Date: Wed, 24 Sep 2025 23:58:54 -0300
Message-Id: <20250925025854.8061-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading im_l2nbperiext from disk, check if its value is valid.
Since im_l2nbperiext is the log2 of a 32 bit number, its maximum value is 31.


Reported-by: syzbot+13ba7f3e9a17f77250fe@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=13ba7f3e9a17f77250fe
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 fs/jfs/jfs_imap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index ecb8e05b8b84..6abeb78c9eb4 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -124,6 +124,10 @@ int diMount(struct inode *ipimap)
 	atomic_set(&imap->im_numfree, le32_to_cpu(dinom_le->in_numfree));
 	imap->im_nbperiext = le32_to_cpu(dinom_le->in_nbperiext);
 	imap->im_l2nbperiext = le32_to_cpu(dinom_le->in_l2nbperiext);
+	if (imap->im_l2nbperiext > 31) {
+		jfs_err("diMount: invalid im_l2nbperiext");
+		return -EIO;
+	}
 	for (index = 0; index < MAXAG; index++) {
 		imap->im_agctl[index].inofree =
 		    le32_to_cpu(dinom_le->in_agctl[index].inofree);
-- 
2.39.5


