Return-Path: <linux-kernel+bounces-842557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F84BBD023
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 05:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BA83B70CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 03:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E101C84D0;
	Mon,  6 Oct 2025 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvRJujTR"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30222AD11
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759721111; cv=none; b=YoXWK/+g05bvfxtVaJSvnsBas8SqVVt3wR28PcoGDacUYYU9osDLJV4SjNXPEgal24QFxwtS6HddcQYpKIARNYpqXt7TaFgkR1mKP91RZDQa217mTLEN3QjPENyimyah0K9ny4CzW+WkMTu4hcVHlZ2rfkcDOJ+4XaP8H9FT15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759721111; c=relaxed/simple;
	bh=z8IqgAmRwIqbtKfoAVNl/Sakd972F5o5LSJX1t9KCqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1DflkLHuo+u5HlFHjm26G4EPUS1k0esYuMDyq+WWK4LIxT5CpEg93li0NL4tQtvPPgTB1WOey9KaUfc9Svsrhquy15BZi5eaer0oQF1jBihFA0slc1KNQO1l6kYX49w2NfoVBOUvrxBEZQPq5T0G9h9cSVQb2dEG2r2SPWWKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvRJujTR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-26a0a694ea8so34378855ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 20:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759721109; x=1760325909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7eU+TlVGdYrtBkTiPkdEDgKNEIhbCLypCFhSeaigC0=;
        b=mvRJujTRcY+5iCOIKz8/k3awvi1bUFXVZBR+lrRqK8kJ2NY12t5dvOxGvxjSinW3VC
         AOgV1f5YbpfCayolSmlcidk402MeoQ/7n/5ZEcSL4/QONYcCiM6dHNU0OxfwexmgJonz
         1h9WdPDLRJeylV8P3+RHFkJLcKWnQzuzOosBI2QtWQy3aiE2ABDn8Gm1xczZUntVlqUc
         qp03yaaOwhq8FVMoJDdGiPkCgPCLJTOVZGB8TR+ciEztwyMuu3pOyrUfojUOxgpaIQ7P
         cxTmzzH4Rad3F0MU5mKVPttP3BV90seKuHWDkh4k8b3BCDlNr4U9chxnptDnlnLoXU8q
         Folw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759721109; x=1760325909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7eU+TlVGdYrtBkTiPkdEDgKNEIhbCLypCFhSeaigC0=;
        b=OC4oKKkMmiK0ThOUACWe+cw3WpAh3jAayXTPevGud2ZpJ2/PZ3qApL3JfIVimdJ1Si
         Xely+qRsACEjevHC2gUWH1mSylI/dVqiy48KUjGNcbCERMYcUT/sT5Jcv45Cud1xUpq7
         UEohS4R2VaQnSpBPeiYfj3f9eC6BFNu0GHphzAwQYfsgU06/UB4FF1oYM4g8eSe5Ngot
         C2XdBgnuzZbTXMGv8PGRcQ0cAKICuPUTsiQJYOIyhsjFWuo4HSVrxBCujOWJhWkCC4VV
         +zj4OUv1Bel9g7dDOT/p1e3FnqNRaOl3jdrwCLL+ez7pZmWANegAiOexTnHI25qykXMi
         fyeA==
X-Gm-Message-State: AOJu0YwGpqzJXIbbaDj61IQiMBWOYBiZbJSzIeuQUXDMVLhrstW1exMr
	SZR8n78PaFQ3xeCZyEpXOHYT3TWtw/hs3xn2n6rr2DVUIVhDSFaBYsW3
X-Gm-Gg: ASbGncsAlCbRiM9J/qQF8CSSF5D9sl4hBFignXHkqUHIurZUmdBQesI6LdzTeNgKTL+
	ZEgJfOQWIC4mw5VrutOFFJp+020A+EoiwXQIbKdi4khDMlzZcFruF927TpvbQPcZR86PDH5JZ1e
	H1Q0YkkB3G6nTamXxdiTwXY+s9xh2G0Qv8a0VBx0sx7kzZTeua9W4xK68MbMO58aphPHMMGGFiC
	iPZ6LmmEUGz2jP4FLKisMa7GH6ZNiB++D9o4SMOO6B+MwvOvkkh8KabiEZ0ExY7Hbb968Ubr3b2
	irwfYji+WbZmrjEA7Q3FeyW2KQZCvii0bZNw1ph23DpJ+hGq1f+kXXmLOl+ln1D2p6iSiSprRXK
	wrh8U0yaQZs8pNpQvPptYlZmtpFaCMyTWMPM7w2vQGCdGOQYpjie3Je1oPTsVBMc87ssr/fciG4
	1hZ47G/gXv
X-Google-Smtp-Source: AGHT+IEiW6aDijh4QiDt1151BDpVzBXu3HJmWsWN+5kIyhLBjdZ7QhBhJAMSoVwexHXz0Y0h53ySeQ==
X-Received: by 2002:a17:903:238a:b0:28d:18fb:bb93 with SMTP id d9443c01a7336-28e9a5cdce7mr128464235ad.7.1759721108887;
        Sun, 05 Oct 2025 20:25:08 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d126204sm116331655ad.40.2025.10.05.20.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 20:25:08 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] KASAN: stack-out-of-bounds Read in exfat_nls_to_utf16
Date: Mon,  6 Oct 2025 12:25:05 +0900
Message-Id: <20251006032505.366466-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <68e2ff90.050a0220.2c17c1.0039.GAE@google.com>
References: <68e2ff90.050a0220.2c17c1.0039.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 fs/exfat/nls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 8243d94ceaf4..a52f3494eb20 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 		unilen++;
 	}
 
-	if (p_cstring[i] != '\0')
+	if (p_cstring[min(i, len - 1)] != '\0')
 		lossy |= NLS_NAME_OVERLEN;
 
 	*uniname = '\0';
--

