Return-Path: <linux-kernel+bounces-859027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E8FBEC81D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 07:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 230DF4E2613
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AE123D289;
	Sat, 18 Oct 2025 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAEQwu6R"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B87B17C91
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760765539; cv=none; b=IlCWvvU+cknS5i7FXlpYwX6+ytdJeaxFyrF2KwacfP6TmzYl1lJ5Vkek64tcp1ts9DPdkI1mcVQ/KEtDzkTmg6filgxNZmGs17Zuw5CNgAYeNq36ZU3L58RqAHx7zj36CTCj+O+himzitI/0V3Hg7Th1BMBDASdDPtM0GTHwGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760765539; c=relaxed/simple;
	bh=b2B/3oTYyw6RAwxBMIBDcxG00Uy2Ld0dXSebooEZ90Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKR0QK2DxwMAttRYzwXUnX68fL+dn+zBiWgbcSNjs+MO+Y2HqfZNy3nct2lI6i+iNoE7FtGAObEBKmBOFsAOyvrMVl58dnzn6W5aabfumqDAEaVILHSFvCK0kvH0K8m8HWBncyephOjUayfhLg0NYmHASpsRqXqcNSMl6S/KGXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAEQwu6R; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so2492498b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 22:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760765537; x=1761370337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+bXCpDXj8HH06scRdWgHTF1ypEvgil7o5Jk+cet0PJw=;
        b=DAEQwu6RukQbeYjpDdaC7s5Jx9DMghvBJ4h5M5lw2kbhAhWIMzDKd3Km5WdID9k3nD
         tsZJSMdcbCj7lcK3fxc7cZThaea7LCYPJPNgjm4Y1eFWQWrIxp6euCzTf41dUjyI6SWV
         jLKcMY7LPWYM0CkAmDjwJ3sday8X1ZyNdBSXypr8RQgreenSUDppjdMBRPh9pRRAGbwj
         ljAkTCkYGHsj0pR7OaUWxVKIwmJW2/3SoYN1DM3HKcFqug88r2DVoBogqtLk2OY+iEs3
         QWbkhY4yupTMEGVIEam2Iy0yy478lrh7XWDGqo/2U4qRL1+rFINNAdQ5wP9ODwNG465G
         WHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760765537; x=1761370337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bXCpDXj8HH06scRdWgHTF1ypEvgil7o5Jk+cet0PJw=;
        b=YUUpdInq3X+pkyKp5t0aTAbBrBUVZz8JRNQszs1El4ckGIiDK/tt0mhxYmLuRaZVuA
         KSr7wPmqh3axeXqP05a69s1eAKe1AmRzTcqfx9wjC4PEZdGWpc8ojM4p8nMqhgfQEPir
         Ver4vflO27JTRB0RanCttUk0CeCdpHIlchOhpICEqFZSAVy2YFdPRlDk6PtKN5JxPOFL
         eyMoefb2/9sz+0cT6M4Nfmy5jLUPb39ITLf9qI9ro9D0tbTDYBpUEQPXDWNkbqzrynAY
         Fk160iQx+hytudVfDXAE08gYUzm/92Q7mhE9/q5Kl2y9nr6k2soh/wDCD7UOcqN3Uyu9
         oE8A==
X-Forwarded-Encrypted: i=1; AJvYcCWPn9NOwiUQ6ikJB2ljOdVG2TVXEtituQa8/9DTBYUOPVoeuwBJLn2TMJRuERgWN2VzOBjmfVWPD4gNaoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43vyvLpnSARNjOiN3RWu5RM7HI1RsAJNeQMav3OkOwTAQaxBE
	ZlYjArAabMI2mCucon8CMC1OO0p6Jn+98JCN6QNAURD0BXcl48gUEnM5
X-Gm-Gg: ASbGnctzOb8C032uSg6CZ+jJ4P6k/du22UwQ72a1OQtjn39ViXSe9LfXuh+hn8vzX5N
	4l+M6C8KNd8ya9itlc54X7pcncg54gy4/6/hVyCo6FgAP3gLXm8K1wUP0JR89A0Szm18r6Jehfr
	Sz2GFuRavSJK/Rb1Wj2LT9R3h+KNKh+U5N45dneae58gfCP3MXOGp6Iul7webKYqEt1ktGaE4w3
	m74+H1TcFYX4xDk0o7uCSE+NqlaE9HePvCKWV820VyDil+A9yuwu2bgZMyZTa3Pu5Gg/HYOtj6W
	Xs936jVqDVzEk2tq3Abxnz8cWDPEyQ2Vfd4oL/TbXMGCvc1FgQ5qAAY2upg9alj9vWLL1j0ZhJn
	mmCWhLxKPxzG35WFinOnEOgpyFyBI9wmY5xb/fpqNKeHgBXvqsWvokpQgZWsDke6MizYGiA0rN+
	zGM4hvG+g/d1OJjPnwwg==
X-Google-Smtp-Source: AGHT+IEjMvi12xV9bwndjFQ7hKA5aVscwafh5tgtTUAt+A6OSKb9FUIMqGNsBgpmwqJOzSYcW7TWOQ==
X-Received: by 2002:a05:6a00:b8d:b0:781:7e1:a315 with SMTP id d2e1a72fcca58-7a220aafd59mr6902392b3a.22.1760765537239;
        Fri, 17 Oct 2025 22:32:17 -0700 (PDT)
Received: from hsukr3.. ([2405:201:d019:4872:bd32:daa5:57cd:7884])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f25cdsm1520149b3a.35.2025.10.17.22.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 22:32:16 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	Rand Deeb <rand.sec96@gmail.com>,
	Edward Adam Davis <eadavis@qq.com>,
	Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	Nihar Chaithanya <niharchaithanya@gmail.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Sukrut Heroorkar <hsukrut3@gmail.com>,
	Arnaud Lecomte <contact@arnaud-lcm.com>,
	jfs-discussion@lists.sourceforge.net (open list:JFS FILESYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linux.foundation.org,
	david.hunter.linux@gmail.com,
	syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com
Subject: [PATCH] jfs: validate budmin to prevent shift-out-of-bounds in dbAllocAG()
Date: Sat, 18 Oct 2025 11:00:25 +0530
Message-ID: <20251018053029.226506-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported "UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:1440:48
shift exponent -1 is negative".

The budmin value can have a negative value and cause shift-out-of-
-bounds from UBSAN.

Add a check on budmin immediately after reading it from the metapage,
and return an error if it's negative. This prevents UBSAN reports and
correctly treats corrupted metadata as an I/O error.

Reported-by: syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4b717071f1eecb2972df
Tested-by: syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com
Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 fs/jfs/jfs_dmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cdfa699cd7c8..76f4b9322034 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1372,6 +1372,12 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
 	dcp = (struct dmapctl *) mp->data;
 	budmin = dcp->budmin;
 
+	if (unlikely(budmin < 0)) {
+		jfs_err("JFS: dmapctl corruption: budmin=%d", budmin);
+		release_metapage(mp);
+		return -EIO;
+	}
+
 	if (dcp->leafidx != cpu_to_le32(CTLLEAFIND)) {
 		jfs_error(bmp->db_ipbmap->i_sb, "Corrupt dmapctl page\n");
 		release_metapage(mp);
-- 
2.43.0


