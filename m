Return-Path: <linux-kernel+bounces-819618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEA4B5A3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60134324646
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D131BCB6;
	Tue, 16 Sep 2025 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6/LBoli"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E5281504
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057118; cv=none; b=tVYt/Sr0eJLVgzaTfgKVNvZ3lA2Yc9T4+GjsjNMQy23sDl32Tqjtddu45jsArg2ril6j1P1qzORepLnWp6+adgBT1AUScNR9RhAbiXA/OccxKwhKM4saYsFJSZyYZfbjvHBYLkSEOr/xovpiHfgTg3YJW+a2RKM/sHLhqxkIlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057118; c=relaxed/simple;
	bh=/X1+d4fPZYg5WlY3eWsxQCEy33DoviSKQ12bu1Rup9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qjE7ZHqt3qCfvnFPBis0qvZuSRRCeXxqIf1pfgP0tfvQLf+itodGaq7uRZYWhlApY0irDTKgIIBAIpxzg1jy0X5KQHQ6pS/8KZWfAgtEC8L1KXMMeTCJGdlZ6QBLH1etAmdV5HXYgfBngOyqi8bP8/pEcZttf1jHlM64O9vgsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6/LBoli; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-267a5aeb9f1so16417475ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758057116; x=1758661916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+ixVYr8upbpH7CrsttocUgzYRa/3ZZldB6b9tE52LA=;
        b=R6/LBoliuhe2Ybl6CFiE3vdr/sJDeiZpGRXfuVBSuGOt9/jWeQp1nW/CL0USn6E0u8
         5lrpf8koR+o0debzNLxX73GeJ67kVRWRzOHRtm6BMWeNUyjwBlv6GEFLV+31qF3SKCVZ
         OogGYUmFF0ZVW3Tdo48ojyXTWK041Lwrzf6/6e5IhsN1jXmvaBoGzrKemzg5YL5ZAPma
         t5yp9hbKd0tX2R/F3DrroBOZi6wU3wRVPI23xr3WACJ9jSx/CR84XZx+RmpbT1m0lYAI
         nUnBtHi/Qjd4P5QX0TwQJxpTtaMnsyMDe1Uq6Up1dRPycIg+L6AFz1ulPRWcqVTGCvS0
         cyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758057116; x=1758661916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+ixVYr8upbpH7CrsttocUgzYRa/3ZZldB6b9tE52LA=;
        b=BUPIWB+WyjOp9NItrrGtQEsC8DH1KJATf8C8ugjTpIPnbrLysRbAPH1r7p/YZnR6zg
         fKZeQ4nKXJdlNn0YAvA5BDqsGgUh9BI3KXww9pnwf2TMWAFjpS7kMEMWkAcGA/XMirw+
         /TCMynxCD8M575iVwLveoeFUHyvP7la25bGupcFJCcLwxeHMtBwuHhbGdfjdK/YC1P2B
         dubEbtlDMF5TfdnR2X8G3bX7Y90sLUEzkGbybWL6gVwbOqlOtXKdZOD4tpvbOvPpp6H6
         PQzPanoz7rwGmynIdZZU25pbaijzPBugGRfzOy6yWndG8TcPqrCJITIw0T/bkVh+xPRP
         938Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+kdju6vZs99v3yv6+nGIHyVw1E51R701ldwBiKuCwfRa07LYMSEbIX0MZcrzwwV7CAh1Z3FywjxcEix4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJOTjWHdq2RvPSU3XH9Q7MfvN5s7e6SWRo4i6xkK58llw++8Im
	h7dec3a61wFTR9DWPMmrdG94vIZhjpw4nvSkg5FmlmGC31I8hJZdyfgstWcJeOdp7O4=
X-Gm-Gg: ASbGncsNV8KWcEfPtWKnE3pq/DUT22En5y2DpAnMccaIsQYPCBkDq8EpsbglFQqWev+
	0ED4CWmuKRIOjSQon8AJfjOmywzA0Wof8ci39+hRO6dEmsfJ55rkGqmw7IYewIswBR+D2oofnCs
	KDCOc40gtAKpkZDnMn6KMbmbwymcf4kZ/FRvFdoWoK8WsUhsN5R4x/TkGsyVFib5+5JPXa3LsNE
	UvuL7/BmLBn8jUYwnOYQFGu1klANCfPFScnj8Hejs+IFJd+MFJTEFarAGq3GLmn8ilucY0eIbAo
	9Ezq6aCJ8N0gQjtKOjSd/8l66NzJNph/uyarDHknC+lRgTKtlgFqjGCNGEMxry971AEMzHMLhT3
	Nl8ACNCOyaZOjLFylhOOaFXLp0mhwgCel2jLdB4x2PzxAP3hho00w+zKtcDL986SMm+o0Jocz5a
	PS/SirKguyzOgIJVykBWRaOMdiNQ==
X-Google-Smtp-Source: AGHT+IGco/HQJ2rpL6BeHKbb2Of3KcipzzfaGC3skxSIK0EMw9tQi0DGONyvjGFnhtZVrjzGBluKKg==
X-Received: by 2002:a17:903:1b4c:b0:24b:640:ab6d with SMTP id d9443c01a7336-25d26e4872dmr240903115ad.49.1758057116364;
        Tue, 16 Sep 2025 14:11:56 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a36c78b5sm15524738a12.21.2025.09.16.14.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:11:55 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: avoid %pS in pr_err() fallback to prevent vsnprintf crash
Date: Tue, 16 Sep 2025 21:11:08 +0000
Message-Id: <20250916211108.1243390-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While debugging a syzbot report, I found that the %pS format in
dump_holder() can trigger a crash when we end up in the pr_err()
fallback path. This happens because %pS goes through symbol resolution
inside vsnprintf, and in this case that isn’t always safe.

I switched the seq_file case to continue using %pS, since it is useful
there, but changed the pr_err() path to use %p instead. This way we
still print a valid pointer address without risking a kernel oops from
within printk itself. The idea is to keep the debugging value but make
it more robust.

Fixes: 590b221ed425 ("Add linux-next specific files for 20250912")
Reported-by: syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa7122891ab9e0bbc6a7

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 fs/gfs2/glock.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b677c0e6b9ab..903844a6ebbc 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2284,10 +2284,18 @@ static void dump_holder(struct seq_file *seq, const struct gfs2_holder *gh,
 		if (gh_owner)
 			comm = gh_owner->comm;
 	}
-	gfs2_print_dbg(seq, "%s H: s:%s f:%s e:%d p:%ld [%s] %pS\n",
-		       fs_id_buf, state2str(gh->gh_state),
-		       hflags2str(flags_buf, gh->gh_flags, gh->gh_iflags),
-		       gh->gh_error, (long)owner_pid, comm, (void *)gh->gh_ip);
+	if (seq) {
+		gfs2_print_dbg(seq, "%s H: s:%s f:%s e:%d p:%ld [%s] %pS\n",
+			fs_id_buf, state2str(gh->gh_state),
+			hflags2str(flags_buf, gh->gh_flags, gh->gh_iflags),
+			gh->gh_error, (long)owner_pid, comm, (void *)gh->gh_ip);
+	} else {
+		gfs2_print_dbg(seq, "%s H: s:%s f:%s e:%d p:%ld [%s] %p\n",
+			fs_id_buf, state2str(gh->gh_state),
+			hflags2str(flags_buf, gh->gh_flags, gh->gh_iflags),
+			gh->gh_error, (long)owner_pid, comm,
+			(void *)gh->gh_ip);
+	}
 	rcu_read_unlock();
 }
 
-- 
2.34.1


