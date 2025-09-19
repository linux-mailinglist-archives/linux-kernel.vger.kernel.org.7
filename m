Return-Path: <linux-kernel+bounces-825338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E7B8B984
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7EF67B913F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADDB2D3745;
	Fri, 19 Sep 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC8tFQCX"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDFB523A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322666; cv=none; b=IBLAgViI545nJoUzxKw10w+/bQkl+f4ffGrv66vwnwsbaLBzgtJJuXHk8TcLMlzMc5EH96xRHHct21B7QBKJcmH51iII08+C7Iq9kMBMIW/vcdXpjq6RpKDsACa6Gk/28dotf3ATfBfJkoGsDA2sNwe0HgzqPtcxUGQZ3zVfbjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322666; c=relaxed/simple;
	bh=2dFCaiQkZd//P5/iSPgSQB+4dqxRYavCcZaK1+adXQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fzWDvGJuT29bRUWaa3EuWi1vpCt+saxPFnlkeibexAvmwSo9NzxLkjMkHnTd/srHjzCym/wugbBMuUpP7AcRRultDGgjP3qaC8gjcBPs6jDsJHy3VfQEpQWNJiDMBJuB9C1Qimh02Pf2BFvuxwnNImUCNOt+2wxhTIPo4sW5sss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CC8tFQCX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f1a79d7e5so209338b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758322664; x=1758927464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NhIXosOdDy2EopoBUKjBrkEuu2zYbqQiI3aooKTa/dk=;
        b=CC8tFQCXc3EIRJ0K3Oxaw3F8gTfg50PLFq/Cs+Q8GY1xH2emRTC7EuY1Az6j4t1cLU
         noyJ2BsHuYyNgA2L7h0JWehWul6Ii0p244uHa6HZsk8uOfYSKDTsQfoXwukoRZBuh2cw
         qu+TDtE6J8gUkihgBEOGl9xSUSZ78QGYBuZdpBiPtQlGH4pg5sM9cmsa0sxl3oCRODQl
         7JehmgNXeF+PrFObecN7DURBsjIBAamHxRhBzUlg+bpex6LFrjCYUuxzKfweevKHTxTw
         WHKsZop/UIrGWVCD87jK2+dKiVxVM5g+3CfiA28wcwVhxZCEmSd0J+51e3hnhDhEwdPj
         xHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758322664; x=1758927464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhIXosOdDy2EopoBUKjBrkEuu2zYbqQiI3aooKTa/dk=;
        b=N2nZT+t1oV639RzHOz43c3yN8jEF1f6kq3B/lUR5C7AefLlFhE6zYu22HVbML+6kH+
         FTOq3e4I84T9YASzLUa68POXxqcVENRghjtdd+Yx0qqEb6MVCSsMW2JVunJ2OSEGco6t
         Gq6mK3osAx1hRR8wAWekId8VuUjPu/matDsEz1TcuJr8y5Eb2NyF0mwuidk8WjT21Q+L
         uc//qsY9XwHLKv+rVxr/dKNh7DxN25ugDFzrEa2HpcHS5VHKxa5HkmxhnbrYRvKXt/Wk
         WHhH7O0lWKPdhhSJhifhnLbcNczJH6MK2mnkwiS960DYeyNn0AiKiWeD8AQpR4RGR7jA
         RyNw==
X-Forwarded-Encrypted: i=1; AJvYcCXomNBnYCgoLS+FcGgeiQ8OpsnaYRuBZkU576XuWOQdwjLZ456s7OUBu6FOaETLqRgtBIyti1/+NnWuBi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFyhiW9Jv8QMsxYk2XhSbydjFGRVCYurSR9RFB6Cna9lQni2m+
	HhI+NMlJwXIfiTuGHLy1eQaSNTGvOIRcFTNOZPgvMauASof9n18M8YAU
X-Gm-Gg: ASbGncvfNv+Vw2KOdLYTO/IISRd4/Gzjrwm6hVM5F89k2aiS0B88oZaO9VBJ/gQrAtB
	60MXhgUQIlJ3kXqgH61b8duhRYkoXFhSzcvzWOj40Bd3vdJqb1LVBPNmAntwmHpUVvxj11kBV49
	HlqZ2UeYrtAt5KZ+nJm0Fom+GBwyiZINCczG3FMyBcRhoLtG/pV8Kf0Cka4i+DCBe+SQZpkiKtb
	auG9/ArnVsK4LF8GULNff6Dz8dyVz3VOaZs/ivXRu4ColqYeb1UcS+vyrqHVpQUGnHh6TgcHpti
	ACXgZwmpiemB3wyFa6ocFTlBntoeUEku7Etok5HWRRN1Gcp3kygsb7JxslJFw9VXjMV+rvWC3c+
	l2LJYBg5+LfkYmmH1vIOmcw+uh+4=
X-Google-Smtp-Source: AGHT+IEiOp5XpCYydQDo5Me1xAYoKRo7QBxD5eBN27cXRrzJb2ckyIxHseriZXp7yvvaw8Icx8AFHA==
X-Received: by 2002:a05:6a21:e083:b0:262:66d2:8250 with SMTP id adf61e73a8af0-29277f958f9mr7232957637.54.1758322663994;
        Fri, 19 Sep 2025 15:57:43 -0700 (PDT)
Received: from ryzoh.. ([2804:14c:5fc8:8033:e737:a742:1adb:21bd])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b5515eaf0ccsm3506376a12.43.2025.09.19.15.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 15:57:43 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: shaggy@kernel.org,
	duttaditya18@gmail.com,
	ghanshyam1898@gmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	syzbot+4f9c823a6f63d87491ba@syzkaller.appspotmail.com
Subject: [PATCH] jfs: Add check for array bounds in dtDelete
Date: Fri, 19 Sep 2025 19:50:55 -0300
Message-Id: <20250919225055.106808-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stbl is s8 but it must contain offsets into slot which can go from 0 to
127.

Add a bound check for that error inside dtDelete function.

Reported-by: syzbot+4f9c823a6f63d87491ba@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4f9c823a6f63d87491ba
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 fs/jfs/jfs_dtree.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index ab11849cf9cc..c200b37f4562 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2129,11 +2129,17 @@ int dtDelete(tid_t tid,
 					next_index = -1;
 				else {
 					stbl = DT_GETSTBL(np);
-					ldtentry =
-					    (struct ldtentry *) & np->
-					    slot[stbl[0]];
-					next_index =
-					    le32_to_cpu(ldtentry->index);
+					if (stbl[0] < 0 || stbl[0] >= DTPAGEMAXSLOT) {
+						jfs_err("JFS: Invalid stbl[0] = %d for inode %ld, block = %lld",
+							stbl[0], (long)ip->i_ino, (long long)le64_to_cpu(p->header.next));
+						next_index = -1;
+					} else {
+						ldtentry =
+							(struct ldtentry *) & np->
+							slot[stbl[0]];
+						next_index =
+							le32_to_cpu(ldtentry->index);
+					}
 					DT_PUTPAGE(nmp);
 				}
 			}
-- 
2.39.5


