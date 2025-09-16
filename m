Return-Path: <linux-kernel+bounces-819582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF057B5A363
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5835B167C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B94D31BCB7;
	Tue, 16 Sep 2025 20:39:23 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D4331BCA0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055163; cv=none; b=n29xcTTWaNI5XppBuHXvHvVO8ctO4FHo/LKtLFB80sosXmTxf74RD0yzDUyKwMZDddKIWGrA/feJt/UPIbufkPCRUasez1ia0+kGpcp2GbbuoN0wJyLZX7e+SH90beOwI6mZzpTHrrKO8Wk45bwfIlE2eyW9qHFZIaSPaYCCLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055163; c=relaxed/simple;
	bh=BNxuCjjE5Nenim91sY537LrE9PhB3E3c7bbcC14g3qU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s5V1alTkfKrCm85aLtOU17zCuksVtjED0VgEiElTzMtfaMVD9IvLCrEnBNh3CETIjEIx7Q3QM+vZnNmgx+i5IkBVrTiEncyutaceVhtQJW5P8feXfrpWm3yE7V7lghe5prIc5ftZekUgy+BONog1ZbrMHbjp8FR0CA9JrTzDURU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4133da01bdcso4015445ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758055160; x=1758659960;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pooGVqUShEzSIQ/Q8tNz/1BJRoCcqFTGn7Quh3di/Gs=;
        b=ZOW1UNJjqnrA31VEw+8qQhIDQjrbPm9+0U2/QiZ4q083WYccYuh0CbatGBSi/XOoWC
         qoD31o1MgQVGbchpld7KfKm0EiwRkmw5HHm7G4/8M6xH9+rGrR+zDPMxSWUgdhHRi1kR
         8HrqQ1dBArC4s86GmPRbtfQ5XmxEKzCGKXkaii/dghFP7FiIOZrCRCo8aTfk8kv8G2zi
         LTFWLkDxoqoazHa//RP2l3W0Z8X6mAGNm4cniUQLNbyh9wSJ2BJ4QexZabl7u3vsjZIU
         RXmBE8hyWr5dTCE+L8Jrb27DW9uBku4gBNOyGt7OKRRXAHP2KHnI+SLY1gj9oYzH1mas
         YEWA==
X-Gm-Message-State: AOJu0Yy6PUuF7CrFRomHsDGrYyhIlr8McyZ8N9LPLi4Wl+fT3iQujPNC
	6gB+bNUQV/VeO/NRzZ3L/wdSa824w2f0dwUiZ3SKZu6vJf+18EOpuNhm8XnLHXGOc1ugazMXjek
	SsDsx4UlExqWzUhRRTZmmrep/T7NOH1pZtthSfr4L7ecTxqubNGFrP4UrcDA=
X-Google-Smtp-Source: AGHT+IE2jSuLDB2rBq9NBgr8wGyeuTKpZrBtUhSGIVt85Xh/HHH0UO0nT5ninfJRaSvB6TPGKvxgfDxS2+mmqzodH1qEtFmneKHT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2786:b0:414:117d:3186 with SMTP id
 e9e14a558f8ab-42411492154mr29353875ab.13.1758055159918; Tue, 16 Sep 2025
 13:39:19 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:39:19 -0700
In-Reply-To: <68c85874.050a0220.50883.0017.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9caf7.050a0220.50883.001f.GAE@google.com>
Subject: Forwarded: Final testing
From: syzbot <syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Final testing
Author: kriish.sharma2006@gmail.com

#syz test

 fs/gfs2/glock.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b677c0e6b9ab..a74806003715 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2284,10 +2284,19 @@ static void dump_holder(struct seq_file *seq, const
struct gfs2_holder *gh,
  if (gh_owner)
  comm = gh_owner->comm;
  }
- gfs2_print_dbg(seq, "%s H: s:%s f:%s e:%d p:%ld [%s] %pS\n",
-       fs_id_buf, state2str(gh->gh_state),
-       hflags2str(flags_buf, gh->gh_flags, gh->gh_iflags),
-       gh->gh_error, (long)owner_pid, comm, (void *)gh->gh_ip);
+ if (seq) {
+ gfs2_print_dbg(seq, "%s H: s:%s f:%s e:%d p:%ld [%s] %pS\n",
+ fs_id_buf, state2str(gh->gh_state),
+ hflags2str(flags_buf, gh->gh_flags, gh->gh_iflags),
+ gh->gh_error, (long)owner_pid, comm, (void *)gh->gh_ip);
+ }
+ else {
+ gfs2_print_dbg(seq, "%s H: s:%s f:%s e:%d p:%ld [%s] %p\n",
+ fs_id_buf, state2str(gh->gh_state),
+ hflags2str(flags_buf, gh->gh_flags, gh->gh_iflags),
+ gh->gh_error, (long)owner_pid, comm,
+ (void *)gh->gh_ip);
+ }
  rcu_read_unlock();
 }

