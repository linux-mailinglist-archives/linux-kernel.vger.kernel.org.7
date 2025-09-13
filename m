Return-Path: <linux-kernel+bounces-815045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83911B55E8B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 07:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36168AA4BAB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F002E2667;
	Sat, 13 Sep 2025 05:13:16 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9552B1E1DFC
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 05:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757740396; cv=none; b=c70YoJvnjF26Hxza/mV+Vmiyf+rf2AhfR2isYtLorEppgjpbf4P2pN1zMwo7McxidMUtabmCYYQSh5y/BfdQ3Psh/5UyGV2DrTc0M95aVheCKPhk9uM7CIEEeZEHgZVy7GWeI9sMVO7aaakYXmQxEsAtiuZPPEl3bLKR22lL6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757740396; c=relaxed/simple;
	bh=Y1EB1F7wqkcKdPGiWFAgzT1vD3kRNCXKoWFSPsBJMuk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NbjQRifnXM8e9l89qLlaYm99uTyFaDcLwrLLb6Rkt6YnDCJJwpXLy/yeAmz+GCsS4wY6545p7szYwfMB/X3WH37xjyDyYomh4+hgps2NVlsSDSuh8rABCH7YijnoWxw7ELdE+TsrZ+yMDuFR1G628q4qv3DtNRxbKUFalQgGafQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-889b6f1d015so240846339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757740392; x=1758345192;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bciVpENkkAQl1Nb9KiU787KLtYJt4sWwL8kSht62TpE=;
        b=Ax+YWXy6PcA2jYdd1joLtOGLFt/ey3DasEuBq1Ek8enzeyViKEAzn4MtvRI8Not8j0
         C1iEPNNoGoq/4Z6W6pydxboHRWOr+q96E5d15qGgNFN4YpU2lghG78Z9jp2d6QSYuwz/
         i/6BeV5HSFMCfLSNTCt0G8wT+8+UrbqnUoBNcld7IJ+ohfscXoi5DgCATmprEdIq7ml1
         d6jStmCEck4tXSH0ypXUGZH7Lq6U95SQRmuZioE0z1T/B7jIxJjOn6yExkWGwNvVCYus
         I1W50VQg2AOIFRDtzli3xtJYShDBg1Ap+ixQLkcjkZAfO3mqUav0R+Q4RBalQf22crVM
         OlgQ==
X-Gm-Message-State: AOJu0Yx8pbNfz1MwCmSjn0CJzY7GROYr99QjQsLNZOoVv7wMwmRpNK+C
	BHNRqZCPOQu4/pKflteQ/uFiIUFOeyNdlgNzEAlLUGEt2MFnoGLnHdC0NnCdplD3Gkt3Zxz/Z6O
	9fPF7BRFa1768XFGOhCcQUHQ4TBboAMKLIOJDjHKqV2C4hQww5xkKfuhTGkE=
X-Google-Smtp-Source: AGHT+IFYSYbSi5+P/xy9Hrjzt3Zf2GjNc1dP6V5iCD/ugs9Wmc2ixiFyCQ7YNGXv3mS4JyYhmVvu+b3JDk2LJ+zl253FbcwCMXO4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1492:b0:887:133a:c9a8 with SMTP id
 ca18e2360f4ac-890330c472bmr713788939f.1.1757740391775; Fri, 12 Sep 2025
 22:13:11 -0700 (PDT)
Date: Fri, 12 Sep 2025 22:13:11 -0700
In-Reply-To: <68b87c9f.050a0220.3db4df.01fa.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c4fd67.050a0220.3c6139.04c0.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [kernel?] KASAN: slab-out-of-bounds Read in change_page_attr_set_clr
From: syzbot <syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [kernel?] KASAN: slab-out-of-bounds Read in change_page_attr_set_clr
Author: chandna.linuxkernel@gmail.com

#syz test

--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -305,6 +305,9 @@ static inline unsigned long fix_addr(unsigned long addr)

  static unsigned long __cpa_addr(struct cpa_data *cpa, unsigned long idx)
  {
+       if (WARN_ON_ONCE(!cpa->pages || !cpa->pages[idx]))
+               return 0;
+
         if (cpa->flags & CPA_PAGES_ARRAY) {
                 struct page *page = cpa->pages[idx];

-- 
2.51.0


