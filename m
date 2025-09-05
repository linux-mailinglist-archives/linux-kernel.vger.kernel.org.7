Return-Path: <linux-kernel+bounces-803373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87330B45E57
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D967587DA7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4BB309F02;
	Fri,  5 Sep 2025 16:39:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2AC306B12
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090347; cv=none; b=oB4ewd8gT4tlvGyvxq1JhbWJDog/8RViITcuot3k9OeKrjfSZYdTxLIzejRqsaGK3ln2G/mlchrYmNX6Z9W08xiBqUQe9DgLA8byBILbrRmHS3KyaosN0n2j35+P0NKt5wS59ghek/67EgI2/RA5uYT/aghKeuQqOn7PcQWC9IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090347; c=relaxed/simple;
	bh=/FFeZI7QdUkhcuzbEYE5FKUgrVEK1ZE2ssX+lyyiL2Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NKBhb+sdp7vYMXxKadICPgyzed1AFXfofL6uzLyy9Gb2FMEGeZ9MrtYBi+s8uKKhpMDHKbUh8F5J6hvEAMp2X33rGnkzNtxvmSQhOp84pie6iRc3el4FtpzbkmJ7JlwIq/D08eoKbCDqsCBv0vDzhyG28h6FWzZTSgYGrJdyCmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8870345ac41so482867439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090345; x=1757695145;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xjY4OL/WtLFThU2GJmksldyVS+4jgC0MSLxl8k1vWc=;
        b=iXmDhmWUEY2b0rfKh0yx6T9B/fA+b5uUr+jOgZnm0WqbXhrPLnAyIFQ1V6bUdMS/RG
         yzWsM8x6+zNpDD0uJkQaqAAAlOcmHvbcwSA6JtWAyTnu9vD8RruizYTdBr/iSzS1cRBw
         3ulpRRASivzsUM2ZoQTJ2hNBrxrbIPgbciUWNSxHwoObulhbI/XsMxwMsSLEnob747bs
         lC0hh690cj2aM+hEPrjvlP2A+vAPpbdSRjuYvVumi2xoNv5tQAgirj4oqKS2dOb0Utap
         sLZ8L7mFLsphFGT/aF2YMOR8o/uqarTtlvKyrPoWGRRNDXOxVxKlHYoWf3GZ5U9JTk+T
         0dXA==
X-Forwarded-Encrypted: i=1; AJvYcCUDtnNHx9cO4clM/5VyPh+strYzcQMJvZtlIxtU/upQMU2emKEa/Erdyzg7TUNp3ZYt0JvQp2vS86UvXx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvI9gYFcWE6l59jk6FbgTTPLpv3770rrqp3DQuIE+Cl0p9BP6i
	KymQwNyBJ19Uq9pImakKeo1xkgT3aGdj4jy0lBg6sEFJItLjsCfjqX2O/0ue8XF4M9+VmaXLfMG
	FIITJQ90pGo3QNYFNbZ5DT9DkHdDaI1G6yoJyE1LnLzd1x2nV4zt3C5WJyPE=
X-Google-Smtp-Source: AGHT+IGNstnM/s2sSf9/8RpanNHE1iJ0lbodvD0nHxbzVnhf3Kkd8ZCCBfzyCTWdxuDM9LneEO8NOl5MaeCmbg9emOy++9kyK7t7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4f:0:b0:3f9:8e24:4ca2 with SMTP id
 e9e14a558f8ab-3f98e246731mr26316375ab.22.1757090344926; Fri, 05 Sep 2025
 09:39:04 -0700 (PDT)
Date: Fri, 05 Sep 2025 09:39:04 -0700
In-Reply-To: <68bad556.a00a0220.eb3d.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bb1228.050a0220.192772.0194.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_btree_path_level_init (4)
From: syzbot <syzbot+55c84106264e92ea9ada@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f11ca2ab18e369a662c2f60d53b8bea46c54e312
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Thu Nov 28 03:29:54 2024 +0000

    bcachefs: Guard against backpointers to unknown btrees

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1663c962580000
start commit:   d69eb204c255 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1563c962580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1163c962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=55c84106264e92ea9ada
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1788c962580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b0887c580000

Reported-by: syzbot+55c84106264e92ea9ada@syzkaller.appspotmail.com
Fixes: f11ca2ab18e3 ("bcachefs: Guard against backpointers to unknown btrees")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

