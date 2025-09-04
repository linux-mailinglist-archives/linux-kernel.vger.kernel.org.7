Return-Path: <linux-kernel+bounces-799807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79EB43080
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811E37C3593
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B2127E070;
	Thu,  4 Sep 2025 03:36:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82B8227EAA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 03:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756956966; cv=none; b=rEmLcdeqsHNT84eOnnjFwRNd0hG0yUVSsWJZSzvmEtPUXpoYZQCngVbYPmjL50RE/GWVQusK6t6HzcSPAEoj7UhW/FxLATpxVhJDk9ag47HVn6+dyUtoIaYl2vuJOmDihtSo+T1SMLKS6Jz+L/AzB3rKEt4s3QgpFXZ5ke7c0kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756956966; c=relaxed/simple;
	bh=qUFtkn6JT/DGGqhRFbGzvOE7gkdqEhagwYHqw1cSGlo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sWlL3Ohcz98ZW47vMBR/Z/RAGwdGblU96dcBZd+vxwhi9GwuUIxaSW1lEB/IvGmR6EPAohUGJVWQIdaQ45w2kRielZxMTpT8hilsQbGZwH53LEWYO2v+nYWmrrEgUISPjANPVYNUkhQ1bKzAFl+p9ZsRoueJ66qqFd/07ElUJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3f0b5f6aa32so6771735ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 20:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756956964; x=1757561764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kJIQbdDjMaKIwu8/RgGFYQ3IVbCoHpKFlYMG3WTfzE=;
        b=Cg1cawpik4HmbIsVQIoqwjDQaIVV5aSRgCauIoKx1ajlQVT8s+tEMiNZR5RLoCMBqR
         YC/kHcD0dfKkC3Uxrc+V7I6B3wd1XKOiAQBJV0HoXvhmsxegeNVlIPHEmQThjtyBmTZm
         FmzxZDSgmZvpBHZwh0nAs9oq7JPC5LF0PwxJrn3J7rHifCuHusTkknuAa43XwyXVBRpA
         4eOpTJFKwUkU6aqZjRa/710yoYn8GJwXSydFMO2S/YtWtelnw6YcMnUe+22lqoce1oMD
         hvYh1Gto8skfGkDxmdjNCXfB+oFFQn3SxYZV9wXuhZEDOJG+xrg65BhgGBMHmwjlsCeP
         OMSw==
X-Forwarded-Encrypted: i=1; AJvYcCXXkCIRY9/qNaIrIXEGKgSGXqKEkfzxvWdfGJG6rL97nrKA1CMu88ERStyjWghJftvIYWZ3LqHxH1liB40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrOf1/YayirUs0p37X6MNgiHf5sonbmQxw6QJTzrIeQLBRQo6x
	H8R26cjsfgoUs+/voQOXK/1xx4Rb2xIa9+X721f+YVXH9H2i1BBC1QWmMuVP05CEIsvBPlCg1x0
	y9NA+RTnAvxkQFrYPmu70MhSa7HHO/PXnsc2kSeGuSQt+GjFQ3slEayjDNE0=
X-Google-Smtp-Source: AGHT+IENXRrLPWSGUnbbTdfTn+b/gxfZBl4CNs9GbenLvGkYX09pwt1Lb4WmWZmlu0cLEj2iQB+7N7oCHFhDvtU1eW4rQU/TouYe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4903:b0:3f6:5621:fbde with SMTP id
 e9e14a558f8ab-3f65621fe5fmr164563825ab.6.1756956963928; Wed, 03 Sep 2025
 20:36:03 -0700 (PDT)
Date: Wed, 03 Sep 2025 20:36:03 -0700
In-Reply-To: <000000000000939d0a0621818f1e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b90923.050a0220.3db4df.020e.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: task hung in hugetlb_fault
From: syzbot <syzbot+7bb5e48f6ead66c72906@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, dvyukov@google.com, 
	elver@google.com, glider@google.com, kasan-dev@googlegroups.com, 
	keescook@chromium.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mcgrof@kernel.org, mhiramat@kernel.org, mhocko@suse.com, 
	mike.kravetz@oracle.com, muchun.song@linux.dev, osalvador@suse.de, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 2ae1ab9934c785b855583e3eabd208d6f3ac91e1
Author: Oscar Salvador <osalvador@suse.de>
Date:   Mon Jun 30 14:42:08 2025 +0000

    mm,hugetlb: change mechanism to detect a COW on private mapping

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1289ea42580000
start commit:   87d6aab2389e Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb6ea01107fa96bd
dashboard link: https://syzkaller.appspot.com/bug?extid=7bb5e48f6ead66c72906
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17dd6327980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d24f9f980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm,hugetlb: change mechanism to detect a COW on private mapping

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

