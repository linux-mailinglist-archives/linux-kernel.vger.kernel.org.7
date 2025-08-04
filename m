Return-Path: <linux-kernel+bounces-755547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D12EB1A83A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12691883D05
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3718F28AAE0;
	Mon,  4 Aug 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWA+iEtb"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFBF28A71E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326463; cv=none; b=a6GlP1C2cEMg47L9HpCo6IaKGY/vtG9Lq8I84M0Qyd7jXgZS99QfpgqnRhZXilxo4Q0zSu8z8EWfKgjvQEEZmYNqSb/X6m2TW/0zQGbY5dKuzMYuh0IBf/H3kqrcJSZ+zJoVx1y/kU85PN/47bBQ5vzqVClKYMgRuhmM0DWcwpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326463; c=relaxed/simple;
	bh=pYdrVmuKfCYuHtP04Qcep2eMXDKNiDtgvNN2V0DypXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UtIkMZXEKrGhzao6jdFpCGiFV0GSOIJuQ0G/XPiJEgnoy+DqRwGTvxExz8mAKsDFTmerkKoIZb3UrXirL6oy8csRTk/+po91b7PXVxX2ZcJa5wvPhBN6T5OIHRlIGTG+et2SdflPUMXbKn7Fhym5XE5ftkUzg5+bi1yeTvELC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWA+iEtb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24014cd385bso41794185ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754326461; x=1754931261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICfl/qoL04oE9UApJmf+6JtByCVhnGLy1JybjuiZ0gA=;
        b=LWA+iEtbVq1PUzKbD1fqfRXDV6rgY9l7RRLiwxHvy8zdyIIbV7bsGFNvYgcI/aJKvi
         yPbCV6CttyZioELCpoJNTuKj9ZS8ln9g82QnZRebiExTs88+Tk5PER3kTadmNZHH3gZS
         fwu8dDoGrVu6p+1K8OQLwnNs+uJlPSQ5ACBO0BP1OePVdJ235XmaD6+CCLCUDkYLT+nq
         YA++osmUzhCxQBT2IlUvyRScFAiXVb6f88091V+yFJiJwvW6cYA8uc+VbY+LIqM/BccN
         X8lnkyKY8o0L5MWFBp4KQ/byS4DqGnn4uulB/DWHGOFt7VS7Uf0mbgu4kv3UcXAagwN8
         eI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754326461; x=1754931261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICfl/qoL04oE9UApJmf+6JtByCVhnGLy1JybjuiZ0gA=;
        b=OLx0ng7ALnwNZ6FscSzoVrKNLDnVJlU2dfVz1wh3NB/FfOUW2QKD6INJoGfotzosMH
         c4uUFkOU99A45yptPwdtZMl5DaMvsan9hY5TTQZifd0m6RkhC5cLE763s+DTpNBooH2V
         qltAUKiSlFE5swV/7pkOr/3bku1tsX9Z3tG+yxPch3I5nTwQXRBDcgPax8O+nwD0+QdZ
         J11lbC1rR1kgg08FcndqXXL4cjCA9GOZ2noi8rK+Ep3cTBOaOrKdbCVqcK5MyZVpsD53
         Hzu8q3JuBQvsOnOF7iCT1SIKqxTZJfsDwz2iOYfdsIo4HaW+1bEb0qB11CkknNYEsWcX
         ES8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPCkd9XghcFnLRPsweCu7KtYll4LANLZwihxLuo1vfdWzliHk17ochWTBcTRA5e9Vxp7f2Limdd3AVxQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX0z2GMr6wyGboXzIhVHeTC2ew0G+Uv7/nszH3X9WikfPqNCIG
	YtUoK0txsJ/ae5bUm5uYayh++/cfeNRm+j8cOSrhSd3B3s4ZLvWnGrLW
X-Gm-Gg: ASbGncuVF3rvo79WASHci646CiF9KbodB5cut/e7dHV11Ois7k8Vd4ZsQ8zhwg0QoSg
	XneNDiaQkdobidAh7MWCR4gx4YCiwuBInhUBz/ufYXoLxZ+kxSkknv94Jgc9rymSeaNq3b/lRXI
	QyXVudKz69ZrLZ7RE4ZV78PchE+VB+eMoWV5bEtGyi4XL0gf6cLlaoTFlW/pj14uFkez2fcGC+5
	6HysxWCmDMapySni9BubbtE0dWDYIkHxafe1Ju/0hIMr4/achf4NsKDCrIrSq26Pdb9czmmBi5h
	OTf9WpK62sUqQIBiSz2MTd4kRumfz1bqq1lIUUxX1GY6xClVvLTd99w9MljE/RAxN22I1bSyApy
	lfsJdIQfC/qy+4kWpM8+M04lvvpjgmg==
X-Google-Smtp-Source: AGHT+IG0ibKqUSHM/8m3tlwLSbk0uFSxqJT9mds9uYVNFnRLIrRFD08YM9xM0Jup3KB0aP88r7ED/Q==
X-Received: by 2002:a17:902:ce8c:b0:240:aa0:1584 with SMTP id d9443c01a7336-242470302ebmr155898125ad.38.1754326461470;
        Mon, 04 Aug 2025 09:54:21 -0700 (PDT)
Received: from localhost ([61.152.197.68])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241d1ef66dfsm113523415ad.29.2025.08.04.09.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 09:54:21 -0700 (PDT)
From: "mason.zhang" <masonzhang.linuxer@gmail.com>
To: chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	masonzhang.linuxer@gmail.com
Subject: [PATCH] f2fs: fix CURSEG_HOT_DATA left space check
Date: Tue,  5 Aug 2025 00:54:11 +0800
Message-ID: <20250804165411.3441-1-masonzhang.linuxer@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix combines the space check for data_blocks and dent_blocks when
verifying HOT_DATA segment capacity, preventing potential insufficient
space issues during checkpoint.

Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
---
 fs/f2fs/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index db619fd2f51a..d8dae0049b6a 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -649,7 +649,7 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 				get_ckpt_valid_blocks(sbi, segno, true);
 	}
 
-	if (dent_blocks > left_blocks)
+	if (dent_blocks + data_blocks > left_blocks)
 		return false;
 	return true;
 }
-- 
2.48.1


