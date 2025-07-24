Return-Path: <linux-kernel+bounces-744541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FF8B10E49
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA251CE5D51
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364752E92DB;
	Thu, 24 Jul 2025 15:06:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72899255240
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369566; cv=none; b=eOH53WoDy6MJDSALbnUUUkpXvjimh/Mg7bXNtT/+6ATiaxwJkm8w+zrqhEAKt2vt/Pd5PSVwWwnJ0kbbKRxMS29WwirOTsTtYpMtNwqzVcIng5ryBIx1wkeYx+adnk0nFwQttgVmZKRhF28XrhQzrzSktZbi5kQnffcoSblOTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369566; c=relaxed/simple;
	bh=eYCnNLXjJIUEHQF0BEo//N+W6lJC636VoDEbD4MCJPM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TiYFp0+19uHjzuIVBDOATcnYULs1J1qmJYtyJ+Xx2KWN8txoOiPW3wbeoMK77305zEb3qJpD26FwgvLl7fAj9EpJrwPeHyVHO7IB6cDndpVOb6H8DHUHVDF3oB1JXMz3VrVj+zs4vipyNnLnQZ0/mIO+q8+wg6+kRirgaY53TZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c3902f73fso139029839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753369564; x=1753974364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gW850alN3mPoAiQ4tT+dTncewR5VbtANycmQevwC04=;
        b=woUX5jqKcTahCSGb/ySdeTGml+nfIa7aq/Cim5uzQxGg3zTczVkl6lWScFB8RzVMhy
         B/jT+Mfl5ESS4eaEqGZJjrGc9Xn3diM57MECtWlv/lzMcqOJeKZslTnnO5yKuMH8qvAS
         kTGH6WfcPMc6dwX+9ZsomGaBuAoT2TEE0KGFPMVMCeIDfd+f5okGM08XA9IVtH3GTVF6
         e1uvasgHHhl6KHIy/xi7KN2bqT6kQcZJmIHNH3n9M8yR/tY0Q++8XiPgmeYsoLgcNNKo
         ytZJKQw2cqF7nVGYe156hpTZjvKkpSBnrGlysQjWFCajJHbDp6NU5586/c1GlU7c4drx
         bbqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+hcxk+EtaG5OoF3oX0JXizzEQQWwY8bAaw2tLFhKkx/Ai4oBI/Mx3IBZyNpbFzTfVhy85AZHFFhlXeWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHKBbNrWpbH71pWviv+w9ujjE6Ay6khXkM3OOCBmNmIdJCDkp
	cO1dG0jPYNXoBYTKjmv9myIUGlerkNKkFJwqrnn7zv9ioywruNndve00pPK896mHBjpsWij55l1
	9faMc6Cep6MXQ8vQmx6uFUK2HOFrO80ntjXhRaGuJIlvSpJbh+sSTlrS3xBQ=
X-Google-Smtp-Source: AGHT+IH2FOKX7gM4cCZLSnjpe6kDFEsBCgQUhg3QsST02LuysKB5W+CNKmDRUYoE0Mft6FsM5WfheAjqorrzX+7s0E0+kO+Qq4Om
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1486:b0:87c:1424:6189 with SMTP id
 ca18e2360f4ac-87c761bf0famr359879339f.3.1753369564519; Thu, 24 Jul 2025
 08:06:04 -0700 (PDT)
Date: Thu, 24 Jul 2025 08:06:04 -0700
In-Reply-To: <tencent_D1B2A5C90DBB9238DDD65DF11919CFA60D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68824bdc.a00a0220.2f88df.002b.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: out-of-bounds Read in hfs_bnode_move
From: syzbot <syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com
Tested-by: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com

Tested on:

commit:         25fae0b9 Merge tag 'drm-fixes-2025-07-24' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127b30a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=859f36d9ccbeaa3e
dashboard link: https://syzkaller.appspot.com/bug?extid=41ba9c82bce8d7101765
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123a30a2580000

Note: testing is done by a robot and is best-effort only.

