Return-Path: <linux-kernel+bounces-749456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA61B14E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D949188A3AD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356561A23BE;
	Tue, 29 Jul 2025 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBgCXs1B"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6EC19644B;
	Tue, 29 Jul 2025 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796645; cv=none; b=OgGCXDwDwavmDTBVYSmHMKRQ7OpxQmv8fRRbuVVpWeBKOAOeU9FzhX2bbVQJTPYC06e4lhulcGd/OBYDHNm5LK94LNNbkb6Div7/WsCMD2JFOe3d6RnTFjN7KO/+vDpjhf0Wo4VvTL3CLlsiuuIQesDVTaHWEW7zN8GMdG/VLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796645; c=relaxed/simple;
	bh=zCI0H9uZE9yysxPFMADdtF2YkW6hK/FddsTqq4LFs6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ibXopHAonDde6pCeUeriCmh9/aXrTGr5H55I2sZkEXQD9FbBnqkWJL7k7w6uf3oLUN3so5N2Taqfit9sxKl2D3zyE/CVf+RD4A65B2eVPPENAwzeNZvFWGhzvqmh2PZX1qq7JLOV9n6OoYfXGaJdhuLNrmuo5EfYKtmJMiRIJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBgCXs1B; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b78bca0890so1107088f8f.3;
        Tue, 29 Jul 2025 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753796642; x=1754401442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nFsz2UHtorJJsTYKHr5ZAg3v318PyN1bhW8UxJDcjho=;
        b=UBgCXs1B1g+FJ4mKAM5+NyPVAC1tIqEhZJDcPfW4i0bqEtGxG23kfLRSz8z+poxPAR
         GOmqpqxIxm9A88HchLCIjpfdjhynF6NSl7EVMyGz/Uaq8CUiCnaePO6F1g4j0X+FHuLA
         tYvkEJHhLKQ0FySZK9qAdo/2bmNNmh46iqtZYXCGOOH9gW2/+HyaVYWTFvhfJpHZE/Ib
         fXoIeUYZTPbnGs1AZRiBJjf2gm+CeC84qr7YzNhUajSFpPrEiWpdERJzZLDjGP2kr7Wb
         4dthCYCuiIvH/FO4BVTIiUWSjKUN+A/QSwUvuOkvzIYo8hHlUAP2gwaHAwdn1stykus4
         4rzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753796642; x=1754401442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFsz2UHtorJJsTYKHr5ZAg3v318PyN1bhW8UxJDcjho=;
        b=jjunel7mFdEtXp2hsaMAVDOGu9LdUq+iqg5LOI4DmjvQN7t/M1Gcxi8kwpNyjr7iPw
         7Gx9ACze6jcdllpsa2evbbNs9rRAJErxHNjhapWVqZVQlj5S2kaGXWBKT0QUkyzLDpts
         My7oxzwPZcc7zCAdVeeD9Wxk0Fk1DxGCUXVAHzj37+7zeR2RZvBEQqsRatpCve4O1mQj
         kAXNTOWUVekCCA+4eGalP/PdeLMceoCQe73EAz0+YM6fg2gpu594/0NOmRiWDXGoAD3y
         VpBRWHadqurnr5SQQn5LgoTLDU2TCS4WpnpIJ11xW+N7rd4pl7mISCrWqL0ZpWlcl25E
         h3jw==
X-Forwarded-Encrypted: i=1; AJvYcCUKzajI3h+x1sRmT2epPmISn3CEtQH3Mw2bMuTgiovmgfcgriX/Wh8yeThvXGAyucmu1y6Ab2gx+kp5aVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ7lX7wQ/Enox8uxRXSSUcqRrza8aAoCC+cyflIvb0539Eygxq
	rmn7PQkCg7CHEViMrnV6QYIjbjia/pwWUR13QOqGZDApeMgmmLATz7am
X-Gm-Gg: ASbGncseY1R+z50UpEVuZZwttq59RlTBNYyuHaOv3BoUbvcsmBja0l3Oumkuz6tUacu
	7txSTLikc1vWLNvzI7+vCF/SBGvb/LcTZQJ8G96bI+z/tyin+z77yiA9t6jP9jfk90a1S8GPVle
	Ouffmm0q0Nr2JVgYFoLhrFtdJiAWbMcVQ1IOnwZDzTngjZTTnFGQk3J1irFXk0x4jajC7+Y8yLA
	WFzBVM18XhbtarP7dXnYyEV3vue0Uy//rZCLZgFRp/xRH+dThFbk3aOJrCVq2oltoZSv9+VF3Zd
	N9mQuT5vN+R5RteEZYVX8r83xstvqpbFqL4CzB1axu5PKsFnWBh2tm4gYnuOICouRrhJOimSMtM
	TsgKWtcb24R9/JxvPH+6d
X-Google-Smtp-Source: AGHT+IGUDDCTZFd6Nu6hjYHDPeBMUaySJz3sutucWDvbnC/FjKn0QB0RI5umqEZ11eOIoZstnOmNgQ==
X-Received: by 2002:a05:6000:2503:b0:3a4:e844:745d with SMTP id ffacd0b85a97d-3b77678ec4dmr10246893f8f.56.1753796642230;
        Tue, 29 Jul 2025 06:44:02 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778eb27besm12419531f8f.9.2025.07.29.06.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:44:01 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Artem Sadovnikov <a.sadovnikov@ispras.ru>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] jffs2: Remove space before newline
Date: Tue, 29 Jul 2025 14:43:27 +0100
Message-ID: <20250729134327.1935856-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are a couple of instances of an extraneous space before a
newline in printk and debug messages. Remove the spaces.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/jffs2/erase.c   | 2 +-
 fs/jffs2/summary.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index fda9f4d6093f..5b7ddec4217c 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -252,7 +252,7 @@ static inline void jffs2_remove_node_refs_from_ino_list(struct jffs2_sb_info *c,
 	D2({
 		int i=0;
 		struct jffs2_raw_node_ref *this;
-		printk(KERN_DEBUG "After remove_node_refs_from_ino_list: \n");
+		printk(KERN_DEBUG "After remove_node_refs_from_ino_list:\n");
 
 		this = ic->nodes;
 
diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
index d83372d3e1a0..a0c1e8b2a02f 100644
--- a/fs/jffs2/summary.c
+++ b/fs/jffs2/summary.c
@@ -615,7 +615,7 @@ int jffs2_sum_scan_sumnode(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb
 
 	if ( je32_to_cpu(summary->cln_mkr) ) {
 
-		dbg_summary("Summary : CLEANMARKER node \n");
+		dbg_summary("Summary : CLEANMARKER node\n");
 
 		ret = jffs2_prealloc_raw_node_refs(c, jeb, 1);
 		if (ret)
-- 
2.50.0


