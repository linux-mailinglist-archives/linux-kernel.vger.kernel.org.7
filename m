Return-Path: <linux-kernel+bounces-722633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0765BAFDD26
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FBC540A40
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B404E191F72;
	Wed,  9 Jul 2025 01:54:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0916DEB3
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026046; cv=none; b=ZY7itVBZ5elr7sz95dXu30VXwRf7ITTMyR1QJlDeqPJKSYRvPpucifo0FnsKC0ffTWJasxmifhyrze8MWlfxbTPl87QD0BXS5t1wjdaJ56UqZqRUXlDFIMPqUPmK655TufBYBH6FGRWBz8JtZZQAqw76MY0FbNlKEe77KllIkGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026046; c=relaxed/simple;
	bh=tirYke7pWKcAPYnNrT6FUsmBFoBHqMsotPOGqaal/B8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CmyC1mvbl94qPyvAkAg+2ftLWn9btTOd9kzVLlg5E5xOIfF4eof66Yaz6962HzKCIirr0X2b/eM1Mu/1R84Gpu2P0vbjtbHLJjiWlMOGhsyu8CMk2EukJPhxPxj+xTTk8ZNxToDOtjegUM4YG6Qz0aarEuR81zHEuD3gSh3TV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86d07944f29so1025124939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 18:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752026044; x=1752630844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQ0A60G6oa/Kw1lEvyxzPPc2EZxzUMc70M30T8nvIY8=;
        b=bva9oUs0ywijrK3CRfWkSQQGjcOEKX82oPI3RMyTwu4QM2PzjqQ+5PJGSGMbwMpNfB
         sAb9oCctH1WQJ7ui2Jdj3kSGdeo4vFQz+OcnoBfO6F+hWZ9XJqO+qBbHfBQ1//pzTgln
         TjVDmrOBLAbqOb0zBTOa84YYeUnwkVr+aaEUwWEEvBDxI11/MpW0h5RCH+lVe6QQ+OP/
         fgitQzkWm2SI/ZxygLyw8WMR262knDwJ4ll9+slXEbSE5qdCHmKF7gl+G1f8+mVlI9CV
         zCfo4cKv6+77rBbxkWkczXLKkRXm7Tilv7h4DwouKDac/ZSk47QXso7CJ51PBSwth5nm
         AigA==
X-Forwarded-Encrypted: i=1; AJvYcCVQbxM4q0gL7Ncq5InPcljbst1XW60MnWc+6AOx4IC8p5J5S23oENTx5AajKIYrSvnCrNg6vn/V/JHJOu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEHWi0hpn8lFTsCQSLYNdT+iEAAGb8Q41TAZ0UfwbZ9LTF8B+l
	YwZvXGMIt9e9ekznw4JI97Kjj3r1yuXQ+aZ+JHpdfR0+u0b1vUfSRgigxHQgEaDqkwon4WGJd3T
	+ptciwWRdJGvSr6HFQ5b3csy/zoBV+P4fUex+kncu4tHKpDhIwd8fD69XSQI=
X-Google-Smtp-Source: AGHT+IEGK1F13IGVCd6u2oUgZb9vgWq3tU1Tg1Cah9eRSzdOxwJEcN/LoYVynH1vVGyqHVKcXDPt7tz43YOyFXwMxn2MutEiXBlX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6429:b0:876:8bf2:e4d2 with SMTP id
 ca18e2360f4ac-8795b08dcb2mr94479339f.2.1752026043914; Tue, 08 Jul 2025
 18:54:03 -0700 (PDT)
Date: Tue, 08 Jul 2025 18:54:03 -0700
In-Reply-To: <686d5adb.050a0220.1ffab7.0019.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686dcbbb.050a0220.1ffab7.002a.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
From: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, andrii@kernel.org, 
	anna.luese@v-bien.de, liam.howlett@oracle.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, shakeel.butt@linux.dev, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 6772c457a86536f3496bf5b3716f34a5ac125783
Author: Suren Baghdasaryan <surenb@google.com>
Date:   Tue Jun 24 19:33:59 2025 +0000

    fs/proc/task_mmu:: execute PROCMAP_QUERY ioctl under per-vma locks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=158fca8c580000
start commit:   26ffb3d6f02c Add linux-next specific files for 20250704
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=178fca8c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=138fca8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4f88512ae53408
dashboard link: https://syzkaller.appspot.com/bug?extid=80011ad33eec39e6ce42
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1124abd4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1099df70580000

Reported-by: syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com
Fixes: 6772c457a865 ("fs/proc/task_mmu:: execute PROCMAP_QUERY ioctl under per-vma locks")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

