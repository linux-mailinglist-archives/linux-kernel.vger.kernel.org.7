Return-Path: <linux-kernel+bounces-828427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D169EB94971
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 987094E2C99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA5A30F81A;
	Tue, 23 Sep 2025 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNxV5Mdu"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F17081C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609660; cv=none; b=KflPD1ac+r/+nXbujVFYVTKy7jaVFcm3SU8yGCqkM3697JdRP57v8FukGqxgJhYRu8KOtgfhgf8RTOtgzhSFf6ziuHSyyjW4BTATLAnthnH2AOCAlaZZoza6oI8sZgA60G17lSzO7+h0jbn5e3KyzCEz9eWixxPMXl2fCKj9M6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609660; c=relaxed/simple;
	bh=eAnQ3leTSF8Ab9KgIwHZdQwYj5FPMkNUZRFEH4T1CzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vvb+i5FetL/Ta+CwLpB4UnDfxzWWjByJhyZYz9K8te4X/xkHh7e556C4gFv/WGe5SiVZ5K2NupVa8+kGGWpSNDXlZ8nGMm5aIcvtFjH98WDeYeKMV8d/FHO/2jmL5gNDJMtG10l8ERIWz1/nuk9/Bn9XZnz2haZ6I6Jy5SvTEKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNxV5Mdu; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso4169408a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758609658; x=1759214458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3nTw98tKK7P7tEgubOAzlpdmS6udUpljFE7G8gB7lBA=;
        b=DNxV5MduRqwN2R1Y+wsOXoviVA1y9y8RJPCX7+MNTYs60TLNbVALm9JcMJNQVMAuHf
         +8zGrtDSKWZN8SmqxPD3OiOQVHZNPy8jWGx7eaursdoVYPhf4LeDa7EvH8fRB/sAZjhv
         IkEFSxN/qcVUUP7a2c7FQFSkgVIrqRYi+h4C8r42tz1Otasv2FZFIRkT1ekGhY9liyXr
         PuCU3bewN4yHa99IhDbrPH8SoT/Cmz8E/ANxCCI1AeO/IyLDyPJMV3BqUPuptdrSwgPu
         qZ7K7m8lMLV/kjdJ0y97sal1MXINcG8yHNvObE5TB+Y04Iv4EX117Sw4pBkNZAn/eqmH
         umJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758609658; x=1759214458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nTw98tKK7P7tEgubOAzlpdmS6udUpljFE7G8gB7lBA=;
        b=HnaLXZcvorYyrVZ//4Q2zu/ndEoluptzcfkWtu2Ys8YS/o3+zA+30nya7Qaw29LiDF
         cwVt1u+TqgPnklnYoo1V1o86pysWxtulNBjvFqprCqzeRqohlbEqcPE4xaCVbKLURUKN
         uP4VGcWtGn5zAch2NlTqwkjMc/gWgshNiuSASpnc7KL27g3n1YqMz9nOLaHz6+v30eUP
         BWKv5nF7sLKlpCD3vOms0MywhdVUcly8S+gT7TdkPhS2rawaoIBwHdE7g0rJ4C7TM5I3
         mxI9IDwjch0ASKZz+soxQo5n06LtXMgJTWcO5aCS1CwH5DKE/nC0xnuYYGuYYgo2uGLZ
         P8PA==
X-Forwarded-Encrypted: i=1; AJvYcCXMpITo6tN1agVULwBwLNIlK8nDbkLmBj7dUdnuUFwa0a9nHI9DfJEwPKP3WR4cqzTXV+6Okr0MvLuHUv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPj/HGiUuaIPvk1pFeRRrxHLohcnuZSfU60/NWlwefbptF1/N
	yBsuKxuQMYBvT6Z4XFUKHUcgmbpLYymGtd5bsFbTAXQLlTWwkphLWdHB
X-Gm-Gg: ASbGncvirxKLGWF7TJEaRAnWmbM68mmenhDu7lKXF4xIQ/U1Ankc7JPxhHSsMTvf2o1
	IdGngE7K9NP3REBXFnLukw+kaR831MWJJPpH8tJJlvaTmX9j0OXukYo5y2ZFiJxDr8LCLMUpL3L
	8eF5wVC1UEbgJgtakEu+ABO//X5EfFWeM6PCDxiucvkcGBlmA0AAF8WfruN75Rpd1tld5F2vt0K
	U536UHYnwlKMn0blj+Czku1+280sfy8MEeFWGcIjWNAtAy05mc7AZ68STukUuVqokT7zBMMpINY
	KXZXHiSoWBZa5SGTj7MQDC4zvOSOkOlU/t2JmKfdy0TXTSOiEvQbpDIjxw1DRvvjglB07ivTgeY
	/VVAgT0/BlahMV1uFDrspI86u5vp7
X-Google-Smtp-Source: AGHT+IFK6RgS/JTJOAGBgBQ9nadK6aL449oMQckP6OC7pzz2TDJ4o81VHWX5cGBkkmJaH/3/4JAmvw==
X-Received: by 2002:a17:90a:ec84:b0:32e:8c14:5cd2 with SMTP id 98e67ed59e1d1-332a95e8f03mr1673948a91.28.1758609658420;
        Mon, 22 Sep 2025 23:40:58 -0700 (PDT)
Received: from y740.local ([2401:4900:1f31:8167:ea30:c04b:15e8:3036])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed268813bsm18141932a91.1.2025.09.22.23.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 23:40:57 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com,
	sidharthseela@gmail.com
Subject: [PATCH v1] ntfs3: Fix uninit buffer allocated by __getname()
Date: Tue, 23 Sep 2025 12:10:16 +0530
Message-ID: <20250923064015.178554-2-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix uninit errors caused after buffer allocation given to 'de'; by
initializing the buffer with zeroes. The fix was found by using KMSAN.

Reported-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com
Fixes: 78ab59fee07f2 ("fs/ntfs3: Rework file operations")
Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>

--

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 37cbbee7fa58..6b14c13bda68 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1716,6 +1716,7 @@ int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
 	de = __getname();
 	if (!de)
 		return -ENOMEM;
+	memset(de, 0, PATH_MAX);
 
 	/* Mark rw ntfs as dirty. It will be cleared at umount. */
 	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
-- 
2.47.3


