Return-Path: <linux-kernel+bounces-880592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D888C26105
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE2F2344899
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391EC28BAAC;
	Fri, 31 Oct 2025 16:16:36 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B82828D83E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927395; cv=none; b=kgQBEb5D5lIxB+n3km9bnP1u/kAsLHAtCwOCcOFLHCfq/HUvEgDVzAQEix3lXf0xnfpXEL2ysIivdoDpWn4b65KxV/Z+QjwjxEC9jjw80CFTwS98vhkp7vm3E51IC5FvPp3ncS+tW1bPrXjMDX5wwZKiClIxqVfBkDfFBXzuEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927395; c=relaxed/simple;
	bh=M71T/ZJ+3xq/7S9fMBH541aTzoNX8hQXml3aB8Tq6G8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CXvIh/q+LyDkAhJawex5+oD8LqGW/2dngVCetbebCR6Tx5wubBdkOMCtUlE09/xQtfUKs/2Yp0heirnKxBFg5ZcSD6N+pzP06j4ka9v+NB3QUfjaXC2rxlTnfHp1lia3ky3AZF74vCHVuFuuLTD7w5tbIf6TjD0IchTTRzgoDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43300d247e4so25105515ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761927392; x=1762532192;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M71T/ZJ+3xq/7S9fMBH541aTzoNX8hQXml3aB8Tq6G8=;
        b=uwPvHwquI3IB11MzpOlUa6F7DXoOjY3i58JPhlzvVFmuLCiawrN+FYY1pa8NAYY5jY
         TFTH3iGlikCecDsIbcVeNuE3iBAyNPUU2zvH64cLSDF6dU2YAQQ6S8Ew/zgFHplyHGdR
         N6+haLDyPRSMMhIPla1MctIfgQE//hz8v/ZM99OhsvYekmALFumPfz3jGWopZ446wqUQ
         7h9JRDriEG330UCf2Pk8GHBvDB9XGCj3JrL9aPnJYv0AZjngFfcj6bdRf0KweDnodbgB
         ikkI6PcWA7fGoDjmuGJOWjY2mGgTdiax6BCOCM1SBSyQ5DH5qYu2Y32ITGXWIzX47sOE
         QXZw==
X-Gm-Message-State: AOJu0YxczrRJTH7WK63lzV0nVx8r7nf524+UXdbrGksa/d8Cs5J6YymO
	f4PKsltpNwbH1a5ujvk+RMY+2NwKxpN7F5nvUIdUWIgAzlATzSQPW3RidejIwlmpKjHb+UZ5WEH
	F515b+1PLABBT+FY0Pt2Phf8bzvK+qaPyIb6vgbjd/17ccP1jCzeQ5WsJdVQ=
X-Google-Smtp-Source: AGHT+IH6XDQ71pbfzlv0VWESrCNv1Cg0kmbc30GDlvT7n3Hc499VsXyFphfbLiOqtQEg/WYQPRyzMX/38PrjqRKq8KazZLAIggq/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1989:b0:433:d08:3c87 with SMTP id
 e9e14a558f8ab-4330d222080mr33655305ab.23.1761927392361; Fri, 31 Oct 2025
 09:16:32 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:16:32 -0700
In-Reply-To: <6889adf3.050a0220.5d226.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6904e0e0.050a0220.e9cb8.0015.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook
 (9)
From: syzbot <syzbot+78ac1e46d2966eb70fda@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook (9)
Author: phil@nwl.cc

#syz test

