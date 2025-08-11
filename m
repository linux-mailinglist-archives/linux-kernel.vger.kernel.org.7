Return-Path: <linux-kernel+bounces-761863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD01AB1FF66
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82DC162249
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043AA26E6E2;
	Mon, 11 Aug 2025 06:34:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297DA8F49
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754894044; cv=none; b=TqcsMPAvVWa5zVYAnUTv5NSiQ2AScni72CVGDfQtrPYaBpUx8xlt1q/GFRHoNrSVleuyj28Uy7UcMVLLYKUMteib0TmsvrS0GstGbVTjC59GfT5NdKmMpyXvnbQPt3TYSg+ulPRx9BJ0hs7itykqKF5+G5m5fo/X/0+JTS67InQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754894044; c=relaxed/simple;
	bh=gTS5UqT+jqlnjla7UlNBZA4o2KGMCzFHaPJX+saP3M4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bED6ZsD0XcGkmQjcXmYy3GCQ1nWTDMjHG5/AWV6Yt6PbT02J69UJGap75fzPCqUc9giYdSTjSV9yiQcIAmVXqtz9HAysF9r2CNYlSuB5ryuvUP1JNUYpyRYPCL7aYef1vGAskqj0WJnwqmz02wfsTb4mm8YHIzGikkjMe2cWWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-881a05b0846so375561239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754894042; x=1755498842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lueyKpG3qSnRqyQBRa/f+eyP2haOh7ZzxMzQPgpt8JE=;
        b=coZY8b8DU+vnpI+IFoKHZXlDpjrqwFdGtUeSNjCr7gggupbDGEDCpWx8yMzwwKpp8q
         YzCSW3p7kBh27u+wCUVn93oBCFCMEKrVgkGkkiEFSnOdXl7bOiEuOCoh/y0SR337G1zP
         RvH4pVVbjxXteR/eQ9OG+7sM816+0m/aE6GzTbJU+pVQID35/M81QLTK+haatEFvmYw1
         c+NKHIa/7Jv+fRNiNMjxRAK0RdHxvkVAlq6FUawdyNItl0dsrxDd5GYPIWzZ9a/s8yVU
         ftC1/ijieRdiktzRj1PgsiDxqUO+Wd7P3mRRZtaG3C3K+J8X862ZQmnB6IuALgYzONJw
         khHg==
X-Forwarded-Encrypted: i=1; AJvYcCXF1ZoYTp+UZUGHRFKBKHkcbxRwdCavp2JCGe9g3F29hhvPuNjQYl3gchdgq3iowJV6LVBddzn+2WlvEhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyowWfKqGGJgDiD8qjk9TO5EzKE/aXojVYx2v3W7LOH7avY6m2W
	97U5UOGKakZHRWa19a6jodE6cbJ9APxZ8G41AMZ+2OK+R4SCDSgbGmRxyQ2BeaD3p7BVhJ3jMwY
	NWrLkot0wjUMEydunPe2ozwf/KG3eF7anl6bJLWjjH8P7v+hOFKS4+EsrU0c=
X-Google-Smtp-Source: AGHT+IG3xy8jagJ9vH7W92qmqcjKaaAKPwz3mDsXTxdcBqcE+W9gl4eLh9ctjRc3CmOcEA+jq9wFtYrUeLy/CFCY7oT9Zpvtl5wL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d82:b0:883:e4c9:93bc with SMTP id
 ca18e2360f4ac-883f1259016mr1921419739f.9.1754894042175; Sun, 10 Aug 2025
 23:34:02 -0700 (PDT)
Date: Sun, 10 Aug 2025 23:34:02 -0700
In-Reply-To: <d9b1c0c8-cd60-49fe-84aa-814b0191d3b7@lucifer.local>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68998eda.050a0220.51d73.0099.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in try_to_migrate_one (3)
From: syzbot <syzbot+63859a31071a369082b1@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, harry.yoo@oracle.com, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, riel@surriel.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+63859a31071a369082b1@syzkaller.appspotmail.com
Tested-by: syzbot+63859a31071a369082b1@syzkaller.appspotmail.com

Tested on:

commit:         f1f00681 mm/userfaultfd: fix kmap_local LIFO ordering ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-hotfixes-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=11990af0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75e522434dc68cb9
dashboard link: https://syzkaller.appspot.com/bug?extid=63859a31071a369082b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

