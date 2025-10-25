Return-Path: <linux-kernel+bounces-869898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C94FC08F54
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F38C40403E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33732F5A33;
	Sat, 25 Oct 2025 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uek+CYY3"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA94438B
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761390876; cv=none; b=JCbaiawEHPPSd3IP746s2iiP3lppPAr24BG3TTiDAp7InKVyYEdeb4S6cGDNfwe4/fvgIhu//faOBuMJDCQ0dhRybeZeH731SmkxzzHhoSTD5KObv0dgfORfSdiH640P64ofq3bkjNfiPmOFfDCt2+oUXO5NWK1xjizbef1iz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761390876; c=relaxed/simple;
	bh=s2JsTGJJhPRBobBrxl1HoHTSaGGJq5e20ABAYu7phpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9MaadiQ0bRlxw2ONTVhku532qa3ZAvbl1hXwaEf2auoJtToR9H/EzbfqmoHYPA71BOPCytIwsBecEO3wBOdYu9ptNiJtXEvKb9karWpMggZM+U0fS91EDskWv0eBngxsWHviPgmydEeFxjApmf4VG2868p8TBSAdF0dqKRqggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uek+CYY3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3e9d633b78so640000866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761390873; x=1761995673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R80v4yxlifPVzrQknKQdgGJrNUlwmjhmtAoakF1isME=;
        b=Uek+CYY3CDKoEhPzSi376poe+inSQcZcaBTgYq60YO8oxUKHdxH1Ds3Li6UfjxdkTF
         BIRrVD4lZHbbd2HSnxsbZmKtg1roHRiusyUI/5Z6dhMcCXbXomtO/9vvddMTwLxw0t7j
         9gQNJwrw4fa36ZalYEuDiBlujJffHInwFGgwmOUmTAq3ild727kBPb7uG1kVsv3xq34H
         OJ5nvjp/7DFjA0qhm/kBG0UlQGLLahta07bP02pB5HDFCSAvEcpsBQFR5+cJJtyaRrBM
         1eW4omdrutZztBegd1t0qBqDkTM4V1fDa4A8ID+XqyE8WiD71w23vxL87rE2RIz7vAQY
         sl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761390873; x=1761995673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R80v4yxlifPVzrQknKQdgGJrNUlwmjhmtAoakF1isME=;
        b=dOLIZnsXGNE6/rdRI0ARengsm5e++fmHS9whXJGNy8GY3byfjb5C/F8HORsQavajiP
         /oYUFZsAPcx4UwO7M4L8kTLis0FRgA4LVTP08+ffElXXahlFWglfoHU9VwFJFIn14bls
         7oC7S9qEPpFCVWqXoOIHOZkgx27MR/pr+a2tNGcvqa6k1GFt18o8nIIt6f0/tdLakz6h
         asKhkKZ7sVwcBS1NBcSo6x1f5fbicPgnWFnEGMNa5v3/KD0FsAP8jWkBESm3MWZPvVgT
         +LptEERK5OS5KfxcLC2EiKsuGr4vZ6+XdrUKgN4q8xL+esuWNoxa650Ert/1nEeVu7Pa
         qLfA==
X-Forwarded-Encrypted: i=1; AJvYcCXOKazwJq6owRS+wy0K6KrIWB4aHsCcs3DlrJlnWmFsQci23i6KZNviRiZdeR3aATQf/H+Q/fVt5FPPbrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx13+7UVfYPfnyTAjXpEDIdO9dlXh8LVFw42/lTJ1qal/BgwzXs
	7zdBo806Ym7043bDMvQZf9EjOmqvt20VRRAJA9im8tx0YFP03XBIt9z2
X-Gm-Gg: ASbGncvxCcipCKRfZwJu07uuVOIZT7sstuyT9S02JF13ANaG5dIow00bjmJv2gZj8av
	ZTUsAEukrU28rxMIHpINQCm1qCfhIqOL7C8kvRek8W2x1cz+rhvknnk1oSrTSICVfgW8PXsFsHc
	gDp1kDROegMAU1xN2kheoEkuDJAR4p287dlUICjZkUWzXTnPIpz9Eo/gMGSrs/os37aqwVkgvV6
	IIbjDZvMoWEQUPmVjwDnKJZHxenKXqxch0mS2niOIjqzcqQ63jz19DE8g/l8zTnZX1NJngfqKm1
	AJZx+vVXo/5Hpv9lGRmjIe1QzEkfT+697YnPQ3qqV+H8ezFvNva5FIAisK42/82sYSDqsi41VqD
	SpwlebCQ4MQzwfoLC8xmr0Q3LGWk0vMGJ6pOQXAFamVgGFMsNIqHJES8cQXLcdibvwZKmvHNe7y
	a5cA==
X-Google-Smtp-Source: AGHT+IGgKo+LgBDmphrQJh61ZlnfUrDa1Hl8aG+8kt1bR7ElILIfxo2UJgTRCkZE2FX4aOJP+gtAcA==
X-Received: by 2002:a17:907:968c:b0:b4d:71e9:1662 with SMTP id a640c23a62f3a-b6d6be49e16mr645586566b.30.1761390872508;
        Sat, 25 Oct 2025 04:14:32 -0700 (PDT)
Received: from eray-kasa.. ([2a02:4e0:2daa:1585:4413:c60e:7f80:c15f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85398444sm175638166b.35.2025.10.25.04.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 04:14:32 -0700 (PDT)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: [PATCH v3] ocfs2: Invalidate inode if i_mode is zero after block read
Date: Sat, 25 Oct 2025 14:13:56 +0300
Message-ID: <20251025111355.32045-2-eraykrdg1@gmail.com>
In-Reply-To: <20251022222752.46758-2-eraykrdg1@gmail.com>
References: <20251022222752.46758-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A panic occurs in ocfs2_unlink due to WARN_ON(inode->i_nlink == 0) when
handling a corrupted inode with i_mode=0 and i_nlink=0 in memory.

This "zombie" inode is created because ocfs2_read_locked_inode proceeds
even after ocfs2_validate_inode_block successfully validates a block
that structurally looks okay (passes checksum, signature etc.) but
contains semantically invalid data (specifically i_mode=0). The current
validation function doesn't check for i_mode being zero.

This results in an in-memory inode with i_mode=0 being added to the VFS
cache, which later triggers the panic during unlink.

Prevent this by adding an explicit check for i_mode == 0 within
ocfs2_validate_inode_block. If i_mode is zero, return -EFSCORRUPTED to signal
corruption. This causes the caller (ocfs2_read_locked_inode) to invoke
make_bad_inode(), correctly preventing the zombie inode from entering
the cache.

---
[RFC]:
The current fix handles i_mode=0 corruption detected during inode read
by returning -EFSCORRUPTED from ocfs2_validate_inode_block, which leads to
make_bad_inode() being called, preventing the corrupted inode from
entering the cache. This approach avoids immediately forcing the entire
filesystem read-only, assuming the corruption might be localized to
this inode.

Is this less aggressive error handling strategy appropriate for i_mode=0
corruption? Or is this condition considered severe enough that we *should*
explicitly call ocfs2_error() within the validation function to guarantee
the filesystem is marked read-only immediately upon detection?
Feedback and testing on the correct severity assessment and error
handling for this type of corruption would be appreciated.

Reported-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=55c40ae8a0e5f3659f2b
Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
v2:
 - Reviewed how ext4 handling same situation and we come up with this
   solution
---
v3:
 - Implement combined check for nlink=0, mode=0 and non-orphan
   as requested.
---
 fs/ocfs2/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..3feeaa475b62 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1455,7 +1455,14 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		     (unsigned long long)bh->b_blocknr);
 		goto bail;
 	}
-
+	if (!le16_to_cpu(di->i_links_count) && !le16_to_cpu(di->i_mode) &&
+		!(le32_to_cpu(di->i_flags) & OCFS2_ORPHANED_FL)) {
+			mlog(ML_ERROR, "Invalid dinode #%llu: "
+				"Corrupt state (nlink=0, mode=0, !orphan) detected!\n",
+			        (unsigned long long)bh->b_blocknr);
+			rc = -EFSCORRUPTED;
+			goto bail;
+	}
 	/*
 	 * Errors after here are fatal.
 	 */
-- 
2.43.0


