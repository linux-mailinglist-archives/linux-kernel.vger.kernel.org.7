Return-Path: <linux-kernel+bounces-831164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CB4B9BBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7632619C47F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FAF2D6E60;
	Wed, 24 Sep 2025 19:42:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9911E27586B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742926; cv=none; b=l7d8A3t7GVlAjhMhkXTRVecxn1RvTMlxIZZVimo7Cv5aM4FSWH01QpmhgfWTT1iX7LdmbF7ew960s1KcRcm+bEI0sedNm4sWQ9y4yrKvTQBtqqHvWc9di+YR62iv2d9uHs77e+KOem0NNfhpCoKlm7ay31F9AMhZTl4oHuvao64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742926; c=relaxed/simple;
	bh=XlUQT6xBAo2NCtEl9g+MBBfeAbUI58Szx2ECBfm5ow8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dazyl61IuQ2BtitM8/MCjTXbq67VwW9LbbNzgBwK995+4/k+mbxZHIm/juc0OthufdV25FWL+21A+HbK4MXSFM31NbU+3TvNLAXkYJY+OX4sLqC5j6UQz9ArIaULV1cXnuos5DUxC3MuP+0K9mzlVUxeTFTMo5ddiQXboa98ipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4256ef4eea3so2527635ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758742923; x=1759347723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JoXql7muFn7FwyH8AltBZua3ey6HUsUw1nR8/dt7Ck=;
        b=vatX56xrK0NX/Q6Jl9fnVAvoTHIarJrFkob7jpF76G4LBThwTpdOsmHDzaYgXwbmmb
         l/97iQ2w63BkvXUh3dePOtSltD7SwOA0yPhklk/s2VfIhf3E0rrZQaJtyMEw2qczlYtj
         +ILbwwXufAjxAfaBrY6F51rSIEnr08SRGhMS+U2nZ9M/7ps3+QWl7p22zheTk10sXrRd
         yrQEr+GoZ3DQ6U8LsY5D8Lg+om1aQPy+eWsLfHyJhCanzHdJD6ZNQ8LTcbHc6wnZ36um
         iDnJUCB8VRY/iGc5HJwxU+PrOBinsBne2hsqxKLC8XQ+DhzzgVi4oTltt4qfgCewB8Ez
         w97Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTddVpiRkpdnAuGZ1Z3MtKHuxB+FpWQgXYRmujvklac32VzNSiZ3qflVniF3NtFduj8/MTy85Jcpfazr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIhN1HO/qGRvF7P79vTuqJr6wfLO7nyb5vVnLAlN0JpexUZ16c
	52nUioOvMRyIZshl6DSK3lNmnZhu8GHDCMllg7bHaoBTnh4H8Be1SfeAbeocrrYqWcZb0cuh843
	WwVNFldW+9O/Cfux1le1PEVkwHgV+V/L7xFXelej0Xio+bpaUX4kwgJKLZYg=
X-Google-Smtp-Source: AGHT+IFt+i4npGE//VZVBxR39ODNxMVwmJego48/oH9PTpIaiy3d1YVC6cq76IiXInYqgL7YY7QtaVtdoWVvGI/ugmSyeBjj0jGb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e8c:b0:425:799b:e05a with SMTP id
 e9e14a558f8ab-4259565519cmr12357755ab.27.1758742923690; Wed, 24 Sep 2025
 12:42:03 -0700 (PDT)
Date: Wed, 24 Sep 2025 12:42:03 -0700
In-Reply-To: <ca3d9dd2-f97c-4bad-a60e-4aef39e9cab1@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d4498b.a70a0220.4f78.002c.GAE@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: user-memory-access Write in __destroy_inode
From: syzbot <syzbot+dcc068159182a4c31ca3@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+dcc068159182a4c31ca3@syzkaller.appspotmail.com
Tested-by: syzbot+dcc068159182a4c31ca3@syzkaller.appspotmail.com

Tested on:

commit:         cec1e6e5 Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16951ce2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131dad34580000

Note: testing is done by a robot and is best-effort only.

