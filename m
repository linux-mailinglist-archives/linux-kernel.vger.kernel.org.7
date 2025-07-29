Return-Path: <linux-kernel+bounces-749366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C98B14D70
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EAD3AB4CA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AD328FAAB;
	Tue, 29 Jul 2025 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNcZNtx+"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA242576F;
	Tue, 29 Jul 2025 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753790901; cv=none; b=t9P87uANd78gdlwWVMzWY2jMhxx7yf+Lm4p03lSkLmjz7tnuhz9mEFP2UrhzGRgohtOOyFUTrqKk2Cr9ydlxcyX3k+aLVugaJL4wZFKqAas/snEd63EiJAgD3CPabFIi/aF6eWEILuPVMPT1Kpxgf6Si41g9Thc5dlISCqj92eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753790901; c=relaxed/simple;
	bh=qs37rkgibd6LxZzc18w8QfLM1Wys7zyGOkYlpZga9SY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uP54IwwqGu9GcQ5istowGmbOGaJq/zttHSyipBpmS67gkl36hVLv3huPBkKMH9EiU+Kdoax/lA6lAbhlQ+rnkniEmpQ8Gltk17F6OQFVbNngM+0qQWPn6mLcEC1Y9v0vKw+Ae+Q+Cvp+OmLGahomUAdqq1zRDVm9szGKlXK7TQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNcZNtx+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so5821595e9.0;
        Tue, 29 Jul 2025 05:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753790897; x=1754395697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bijd6Fos7ixQBySS6DGwaj6sq+5gLEg3sXmxE/FwHKM=;
        b=VNcZNtx+CnZa42wu5Ti0RLXbe9cNQltDq/g8jV63KdwvUzR/tpBi+78CAW6D+ahOnv
         AG0b2aJLSCI+76PMLor+sQhYHEy1VhYCU2jZIv4e9KUKF75Xekmz240/6akSNDZ7lGQd
         1dC68G8AHGcVkSwdGnCFGQC8vFIfQJZHlUKp6HMrkb36UGLyshUGhLAPwf11oIxV1BSH
         R6wWBntFlJCbsD3KF2czcbOp3mUZG/eK4tdmviyKQ95eMr1k6ST8r4RwR74KVvGN/eno
         b60l+LJ1N6R37pPRTSJVGKfy+t8U7BuF5s4wmAcxIpM/Pd3Uhpb1B9vaDkjisuIvLVAz
         Q2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753790897; x=1754395697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bijd6Fos7ixQBySS6DGwaj6sq+5gLEg3sXmxE/FwHKM=;
        b=HjJNHMp1fqwrO7G8oRAKaQn9oCpebkpPV0QUAzmRFPYHY/o2262MVv9pVR3p88Ycmb
         v7L4fUCLK8+qsqWZOTBlQqXMOVqd4xKA0nUfkv0NsK2QkcUhQo64S7HZXZx+zvKySsCC
         5qiKqiabi8K3wpl0Ga9jrxUp6f0ff0YdB0r/wZK0W+itPCL3jHVsW1vGn1nZQZIylpEZ
         klNFSxpE52OkpC0V3dhmldXaD+KiUYXuxckOCiKwHfR9r1nKSnmtFFmBqeNiB/3xhvFK
         9NpsT6NSr86j2KlFV+tH4s738mZ93oJ9RJE/2IJi9OxsbDN6B8+/k+jY5IeuHm0NFWDN
         w59A==
X-Forwarded-Encrypted: i=1; AJvYcCVEhLokP04So0kRyUj6ib8CGLe/GXhifseMFV0VHXLtiyQZ8ZvXmIhUjRRcjz0y9YVZa/EkAxAmUjVnceg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNvNV2R9YnNENKOgru4ouZTRnPDNtFALFiXSnDqEieuln9N4Vh
	bwUN4wuAaPLfNhtX94gE4DwXalBP0n8iob3CSvF3Cz7a3Eebqvd6brjUkzHocn3hkPk=
X-Gm-Gg: ASbGncuJJBnAb9U2zDbcQz2Y+0rTbsoJ+o+5hlOc15MG6tGn0jFgaHKPYU9VuvIGkne
	BoUVA1Yx3WnjPMgwqyrAL/s5x6guWni3svMs9a7qSaRyF7Pmwv0oxCCPjVKhkm+XzgWJTKubN9p
	TDCenk1/w+Z6DmeRDDPNweS5CyO03p5RX15CTgmYvo9LHDcPxAF3tH16vfEG8vSmF6FCUOvW6a5
	u6/IZPw0BC0iw3U0+zyNQ0GKnu19juC9tAx+TkPNHeNvXpmZNVDd9ESv0X8zc7R6pSYoVj8s9hy
	KmJnUYCXIMkX+RDiXdN1NPnQE8vL9NHX79L7ZSrMOUnlfUPk4zWWnDxNo/CxZZauAd0KCT1U99i
	GVOI0gOYF1LlziPaGIg6O
X-Google-Smtp-Source: AGHT+IGX1QCZoNzzRDLG+nnNq5yYVN0YZ1viwt9OelUs1sQLmCz/Dhnbyp/5qUBoyiq5N2wP+jAg+g==
X-Received: by 2002:a05:600c:3213:b0:458:6f13:aa4a with SMTP id 5b1f17b1804b1-4588d1364c0mr18690885e9.6.1753790897007;
        Tue, 29 Jul 2025 05:08:17 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4588d873f80sm20510515e9.0.2025.07.29.05.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 05:08:15 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Matthew Wilcox <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ufs: Remove space before newline
Date: Tue, 29 Jul 2025 13:07:41 +0100
Message-ID: <20250729120741.1928313-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is an extraneous space before a newline in a UFSD message. Remove it
Also add spaces after , to clean up checkpatch warning

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ufs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 8361c00e8fa6..3675e45372a3 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -55,7 +55,7 @@ static int ufs_block_to_path(struct inode *inode, sector_t i_block, unsigned off
 	int n = 0;
 
 
-	UFSD("ptrs=uspi->s_apb = %d,double_blocks=%ld \n",ptrs,double_blocks);
+	UFSD("ptrs=uspi->s_apb = %d,double_blocks=%ld\n", ptrs, double_blocks);
 	if (i_block < direct_blocks) {
 		offsets[n++] = i_block;
 	} else if ((i_block -= direct_blocks) < indirect_blocks) {
-- 
2.50.0


