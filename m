Return-Path: <linux-kernel+bounces-876139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92232C1AF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503FE6604F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB592D6E42;
	Wed, 29 Oct 2025 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbOM1L9h"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24722BE7A7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743680; cv=none; b=Q78T1BO6HskANaW87Txxz4V+6uZHH+0rAuf96XG6sfTvDviADoFunCsXMDLVgvD8/sEYUJ8bqUPBctDFSSDa9JlB0jJQN3A7zJk91Lo7MtB1J5MSAGgVktgni8JfeEWXxsJ26xQyOECkBkuv8nLSYoEwgbQ2+/hGEEb1ZkISKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743680; c=relaxed/simple;
	bh=Bs2aNP4TbRyZDZpueTzP2CRA8p/I1ZXMSqkyS31vJuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEnKAziqQuAj0XRocxb9PckVj2yWoX3cNL01oJY7sITUJjpgwSyAUW0HPpKxmCzv8y+sKwGEAPbCmZpD99ItKD1027X7UnNGJsFH04GmozaC5TJKZCyNMIVtTYvJfaUMX+lw9d8YdHNu9yXuAdKCTK1oAp5ku0sr6dA5a3sJN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbOM1L9h; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b70406feed3so66377766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761743677; x=1762348477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNptwftA6qXI1uXJ5WhqR8qfOzZwZcqLImk6T9du9b8=;
        b=HbOM1L9hU0WCun2aAiSzKe5Cd44pazjf4GRtMmgMyr1d4O7wzHuBkPdC2rVY32tAf9
         zcoFxzmYzoo88t1hg0/rK3avpOphV/kbtGbmZmUAdJ2qCF66cUWTUdeQriUvdYIF2dGe
         2JoA8yVySMGZGvwt6+lcd5O9CpJcc5ftE/5j/tGENRIL9UDD3/X4GRCXejaf0YCorMFR
         y5HF8zzbgYMfzoqVNKkZoqxP6j0GJ81NIwXFVN/EyIKLCbaBsb2cvBlXYdHJlYBwVIS9
         +QSghfvtzP4oCaM8TNXMxiNfIVjhyny0W4n7Dg+UU6o7VoWejOqGxzuS/JkSui8tCmQr
         dcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743677; x=1762348477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNptwftA6qXI1uXJ5WhqR8qfOzZwZcqLImk6T9du9b8=;
        b=IQddTwugrD6IeVqiMKXzImNYzYMsDzfamZ1TA+nM0Vc5QCX3/BTW4GPddGHC2KyApt
         NfZZ3TRcxx9eZxZEOs7VbkzQC7o1zEUI3IigPsQrxxbugJrktX3wIybaWbGoAElladiG
         RiB3o4emkNbGez7uhVDqcJLPqcxJKSkzuGTLiUi1ufgBrmlSUgfFXDddwlDwLpzLPxkh
         vPHiGGwyQn68H7/8NmxYtWe8Nvk/aI1jvmNWZRh2Ape2viqRrrD2S4Slxh1SlwgHKEUC
         fgyAh667tqxmB1bC5PxQ0t2bwIFhxjqx83pWs+4gO3/1B8VWtnVd+t/H1mE/aorAk3r7
         Ppgg==
X-Forwarded-Encrypted: i=1; AJvYcCVnEADfkovYd6HJtHFwNOL4w635txgFehgiZQGPjJDPrdLw//PkmLXQO2w9diP1jsIYPJrp+m9f3au8V78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0z0Q6K8DPuzAL4vd7tZT3ubj2yx7Ib/ez3ku9EZVsDvTcB/A8
	zEsc2fCiZQXut7BG+lukO+XfcclM9TfS+01kaDKF99GQQY/skQe9SJ2q
X-Gm-Gg: ASbGnctpUEqSDFzLykHgZ46G4cPfGrn3QJxlOCiW5qBmWwjZ4GXm5RXwxI3FPb0Ngt/
	tMm69/aPguwCSO9iWJYwBFWmVjorY/DcANnFx0LZBbaxbqgfY7aYJv/JBeS7rlAtpTj4pGnyyHw
	D3tF2hB6JazNYBryLHk2HWhr3zZWB9yUjZRUMV3wgI69pmLtwiVVva+zIcaB4hPdHCjSV4GQZkw
	4vLtC0eLOySXMsthcB+T3PrkSKkDuGxHKnpX2ENS30h38Oze9/4e9lbiShmg7fOjz26nXRtyhEx
	voPX34xfQ59j/JemweVC173TDPoysbeIW8NBc0mnGxr4QcKAx2ujipOxUZ2rEfcEPw3qB+K2yfK
	z0k/CZhtRZNwcFr3pwlZiMSFcz06paWaCmeRvhA9DA7L5CcjatndaLSXBOcwFbYi2d7eDuKN5Ds
	QBoWClfhuJw0QJibvNuHUeVrfoPVFAI0ixj1npd9p4T+0PQsXuwMTrQSBqWc0=
X-Google-Smtp-Source: AGHT+IHVtHIdZ2ky/5bjC1MvT8sxsNCpYJpQ/+gGoxQ/iDVsMSO6E2C7S/XUZYFkx8AFTD2zqZBBUQ==
X-Received: by 2002:a17:906:604b:b0:b6d:7f84:633 with SMTP id a640c23a62f3a-b703d311be6mr227117866b.20.1761743676960;
        Wed, 29 Oct 2025 06:14:36 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308c82sm1451840566b.5.2025.10.29.06.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:14:35 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 1/2] fs: push list presence check into inode_io_list_del()
Date: Wed, 29 Oct 2025 14:14:27 +0100
Message-ID: <20251029131428.654761-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For consistency with sb routines.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

rebased

 fs/fs-writeback.c | 3 +++
 fs/inode.c        | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index f784d8b09b04..5dccbe5fb09d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1349,6 +1349,9 @@ void inode_io_list_del(struct inode *inode)
 {
 	struct bdi_writeback *wb;
 
+	if (list_empty(&inode->i_io_list))
+		return;
+
 	wb = inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 
diff --git a/fs/inode.c b/fs/inode.c
index 1396f79b2551..b5c2efebaa18 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -815,9 +815,7 @@ static void evict(struct inode *inode)
 	BUG_ON(!(inode_state_read_once(inode) & I_FREEING));
 	BUG_ON(!list_empty(&inode->i_lru));
 
-	if (!list_empty(&inode->i_io_list))
-		inode_io_list_del(inode);
-
+	inode_io_list_del(inode);
 	inode_sb_list_del(inode);
 
 	spin_lock(&inode->i_lock);
-- 
2.34.1


