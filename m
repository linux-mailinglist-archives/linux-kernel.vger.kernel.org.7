Return-Path: <linux-kernel+bounces-832821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF047BA07B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256EF382FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6948F302CA3;
	Thu, 25 Sep 2025 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLJsLSRf"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B73288C26
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815679; cv=none; b=IF0rD8IqdOqXSPjITkSQMvTLFRfyB2fTgAOzYu8bHMhoEg0ZyeaH7+jw7bDKHX+szBxybMoVzh8lZ30NDhRQeAGDne+fEh4/OBK7tdlt2GEE5Fl/CyhKYF7va3OtDy61l8hwhaq6L1FZmgw6FTAyB7PgYluZW2VNu4I4VcQYJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815679; c=relaxed/simple;
	bh=ojCNNYW52cZuOXTTZ1C9ikWFiXRXEas5maODIAHgHzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHlHXoUf6xtB+08ZbaoYAuXjfjX58ujfd4c7kKJyz5kCuDIiXc43SHKw5VxWT52L3k5tGnLH75Y7SeJvGcX+vfiGPfdR09eYGiLDXHWCozvRiJE/SxG/hWnTLlTHFbBxbTEihn/d7CA2dd8RkuiDopFjtc15Nnmqq1TAwpSi7Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLJsLSRf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27c369f898fso13373085ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758815678; x=1759420478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6unFOdw+25OSo9KKla+RTEP3PML4rL1MzRrdobrk3g=;
        b=QLJsLSRfGr3Xn6JteVlV6Hv3KJRmQLgdaEHBILafIiCbTAsrbnXqjYpJXVqbDHtGCb
         KxK2VgW0+Y0UuEEOCR8gUyS5woBzagnubLCc/lzzYpIQOJDkou7lINHCcEXq9efQMSVM
         k/FQ2EMFew/OCPLEBtb+hIs0MpLpEXAhmn1Q6fsNeFcf/sysGVT77jCgN8j7uGCsd36s
         A8L2BWG9TKAV/Mfa9r0zuVkLh93SpmqYZ1FzohSGyc96paZdBmhnQ1mD17gBW31SwqpE
         H/rg+JgZbGRZ4wYsQA8jm+NMjyKHSHyly0ICamOU0DqZvwNpr6HZJnNsqmjZ+y06h/Jw
         agQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758815678; x=1759420478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6unFOdw+25OSo9KKla+RTEP3PML4rL1MzRrdobrk3g=;
        b=rpF/Q5TGW822ClHVKa/isGD265yZ8psCNr29r6L0cQ1Y/aSI4P7mmHIYWIc+fY/Ozd
         lEQuQZYNOFlD/GFMccJH1qZFLnIS0TgP3bPMEbqSEgwVjIc2pYVdMkfoev0+TRGpAI/W
         yJevsJ1GYWCi+rb3889SI1gx0D+jsXN+456THlCGo0Sarv9sbjwsPX8xUq4LjHcYB9LX
         VpbDvT7CpuHci85EvSviAa4amtbXaM68I3ZEy5EJvwtmktfNXN+UpjkRgXP9cx1uUY9b
         IgVWroEwRjmY7gSpQnVizklZXSpsdRl1uZZYVjt7RzN9ftMq/mD8Hs1InALpSBQK2o+R
         pFBw==
X-Forwarded-Encrypted: i=1; AJvYcCXMjh9sZpjkj++YFquma7iTBNTuDcLQaztUeb1hpW6IB/YAekQRJtWHL3nZ3OxCHF0ke5ZR8MMr6YbSy80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxFAVZVCdJ8CeU1TZaiPlevgM9MgLze1EtF0geuolaX+CNIMd
	G6y63M5a4dee8hlCoh/zgamBta4ryjfIjdRgUJgZfxPmL9zHx/Pq3W9o
X-Gm-Gg: ASbGncupnpLfXrp8UZC1GTQEL4odMQBtn30/UkxFxasq0w1v3EOXY4Aa8VA7wzocn3W
	AcNZ82m0k8e0BTXN1MQMZpO9mGfMqx0/0QPjgGe/XzHCs6Bjw4cNfvP9ONt7Hl6vnQxoOp5pCsl
	ZkAfaBDFmS9Rws4X0VxgR8XugnpncUriMrpBOEIkKy9IdceO6EbFMURbE79mYmf3pFPTbP3oqwy
	8HHiPuTQ5VklZkjrbL+tZRFQVMyz/QGS8ggbDwL3PoY1ZfAsb6UHp4nC0NHR+rb56r/8dyYi/n+
	Osaiygs0I22I7wfCIW/EH8vTtvLAP5Nz0B/jBNoRvR8FrpJIKJuP+nmUbjZcsHwB9P+uAjj9iyJ
	aMicku7TOHRiwQwCzS0lYmV0zYnkS7+/Mc/NSmPtflVY8XbNobgtT+ozTxsA=
X-Google-Smtp-Source: AGHT+IHKoV/EsaWFkrx9mF3ourWO41vWtjCVPz6Q9L0J1SKmQKG2p4xEQAcHF4vrEpICY0p71LH0zw==
X-Received: by 2002:a17:903:3843:b0:264:7bf5:c520 with SMTP id d9443c01a7336-27ed4a56b3bmr39363515ad.44.1758815677577;
        Thu, 25 Sep 2025 08:54:37 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([2804:30c:166c:ce00:217:3714:c805:7cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ad15e6sm28447355ad.143.2025.09.25.08.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:54:37 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
Subject: [PATCH] exfat: check for utf8 option change in exfat_reconfigure
Date: Thu, 25 Sep 2025 12:53:06 -0300
Message-ID: <20250925155306.394763-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for utf8 option change since it depends on iocharset

Reported-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3e9cb93e3c5f90d28e19
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 fs/exfat/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index e1cffa46eb73..500eb9c20657 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -762,6 +762,7 @@ static int exfat_reconfigure(struct fs_context *fc)
 	 * inodes or dentries, they cannot be modified dynamically.
 	 */
 	if (strcmp(new_opts->iocharset, cur_opts->iocharset) ||
+	    new_opts->utf8 != cur_opts->utf8 ||
 	    new_opts->keep_last_dots != cur_opts->keep_last_dots ||
 	    new_opts->sys_tz != cur_opts->sys_tz ||
 	    new_opts->time_offset != cur_opts->time_offset ||
-- 
2.43.0


