Return-Path: <linux-kernel+bounces-833808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCF4BA31FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55FE188721C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459A7273805;
	Fri, 26 Sep 2025 09:24:54 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6413FEE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878693; cv=none; b=lTGivvYZ7L7VSTbVCHdvKmbTOpf7u1jWdlGwW1eMz0GP9A7RNkFLUJvRl2IfXQHm5uTUjgbzUpuVsAnD8mKcX64CbCedrTPeZp7TQLWaSAmjgzPuxv7UlFFsuYT97t3giFUsbVixsQ6ZoNyMul0vJnhz8Y+o/Tfw4piNjlQFIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878693; c=relaxed/simple;
	bh=swfP+KXfulFeSbvNBtN3sK+wM+xnt2dlSOlEHsnQmDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVQr+UAOY0mHjwT1wcG0c9B4lYKSPPyY8n5I5gHPU244AK68HCPH+lgoZj+rm/iI1JcncAuPJeLMzw5WVpus27tLlWwsRGFUeJbWxSBEvm/4MvHpxUXo+5hTHSV5cI5Or83ktnDoxZbxbWQNHyApmhuEqrWDKNMRvhctBU3ir9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso11199455e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758878690; x=1759483490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15qqzO1/4D/fXvObyf6lxUzcRGeGiwoHvTPaLubu2a8=;
        b=TMHIJ8ZjlciritAJQH9GQmkT9rA4D4KHyM75ESbccv35H05uczCJFFGEiVbTm8G/KM
         Cg5TlOO8i3PTXd1wGb64bZM/c2sML2dKeI+LMFgUFHoKYPJW01dPkCSm7XcBktbrihXm
         VZoqKakw90q5docUV3BxnDMC2G3XPSDAcx1MlZHhmtd1pRmNznKoPaZMmJbno0Epf0KY
         L/zBcgS4lcr+tMphfHJR6+si8cel+T+O08u+Xy4xmtJMf/tWCcrOMhy40lJ8Fyvl7LQL
         R5uWLG8/aV3L/dxOBEr9kftkutg0WgwofNNyFBSy4wbW/NzsSB6LC5Zze0QucW7GCvOz
         blgA==
X-Forwarded-Encrypted: i=1; AJvYcCVY2FPsfUUr1vccsqnaepwm8t8AsAxKkivRSisFSA8BCAOsssbAiAXdG5GHfI+kAPcZywNBWUOdXqqY1zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSt2pszk1y7ipFENkUMvIzcrStVSFeE/NthibtgGefTvsAePFJ
	EI6F+qfSHAizViqxBkvaJSN4f4Zyi1p1VzWTisVg4gaP/NoqKaE1AkAp
X-Gm-Gg: ASbGncv4F6jjpo6JAO1BteCZMg/r2I1xfmTd5WfJ5g3X77veqdnPE1gRTwPD7IH1etR
	sWmBGcg2up2Wl9sertfvea5IcS6YUPpVF6Dd+fgHH1fycs3haTZDJo1azCjIVAuYdmWGBD3jAsk
	TbxoFetPuiex4aus8uLLI8PYDfmr+S0UM2Q4YiwWmEE6KRMRRmJ2E17IPADsRNeSES0qg6NLc/5
	97xFJQAL24+zdwF/hXQcCBFm0gvTuPjWCIIxd9VSBlPhd7AT/UnmDiRRJypTw2tyDA9nEqf4OCI
	pBtiIALq9oZeAEQzeLCQmSHXHZqBwqIc1H54P0BeMKkLGNw4mvYYLri0RBTLtQH9p0gX8eBS9M5
	MFvPo5MJ3RaD1YcYNYpC0Zt0=
X-Google-Smtp-Source: AGHT+IG4jF+clSglFjlTRLQXXovvviBd+u8T240DwlX27xdVKmc4bcBJNd8Gdkqs1y2zUe90wtCrSg==
X-Received: by 2002:a05:600c:5491:b0:46e:345d:dfde with SMTP id 5b1f17b1804b1-46e345de049mr68882005e9.16.1758878690199;
        Fri, 26 Sep 2025 02:24:50 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab48b40sm108503725e9.19.2025.09.26.02.24.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:24:49 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: elver@google.com,
	Liam.Howlett@oracle.com,
	david@redhat.com,
	harry.yoo@oracle.com,
	jannh@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	riel@surriel.com,
	syzkaller-bugs@googlegroups.com,
	vbabka@suse.cz,
	syzbot+60192c8877d0bc92a92b@syzkaller.appspotmail.com,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 1/1] mm: silence data-race in update_hiwater_rss
Date: Fri, 26 Sep 2025 17:24:26 +0800
Message-ID: <20250926092426.43312-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

KCSAN reports a data race on mm_cluster.hiwater_rss, which can be accessed
concurrently from various paths like page migration and memory unmapping
without synchronization.

Since hiwater_rss is a statistical field for accounting purposes, this data
race is benign. Annotate both the read and write accesses with data_race()
to make KCSAN happy.

Reported-by: syzbot+60192c8877d0bc92a92b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/68d6364e.050a0220.3390a8.000d.GAE@google.com
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6b6c6980f46c..dd93335e3a13 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2757,7 +2757,7 @@ static inline void update_hiwater_rss(struct mm_struct *mm)
 	unsigned long _rss = get_mm_rss(mm);
 
 	if (data_race(mm->hiwater_rss) < _rss)
-		(mm)->hiwater_rss = _rss;
+		data_race(mm->hiwater_rss = _rss);
 }
 
 static inline void update_hiwater_vm(struct mm_struct *mm)
-- 
2.49.0


