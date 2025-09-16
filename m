Return-Path: <linux-kernel+bounces-819690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E6CB7DA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501E91890886
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4153C2E5430;
	Tue, 16 Sep 2025 22:21:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C21E8329
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061265; cv=none; b=V9MuSBbHbCMxglH+VQ5RuwC9osdP0RCgWqHJsMmdgvwXffYj8ur+NMal9CrngGDlLctRE6MggEED/tnEOFqMJpzWdlPL8k3YIaYXLhvzPh6F/QnsELQpWgI6zgK1319cLvemNyvL3T2qybaFnCxRLp8S3hv53u//8ZBQgkj+dLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061265; c=relaxed/simple;
	bh=ZBIudhQVrYdfCcOUB9cO58N6p/Um/yARiCufpEOjarg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CgciuD38ff6B6Z7lZg+2lIocePvswZcEM/r7XI5aKAGuzilH5R3Sls5aROP24jfU4pE5AX7IIrOKlv3YJDjLZhqZj+mESh01mi3Vt1mC1SMcJJhY4ZQsWPJ7j6hVTs6VZxtcs2k7DQc8LfmrLAeAVOwxME9lV4lLfuw80F8hhYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-892df556b68so739112339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758061262; x=1758666062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuy4KewtRDjxjKMYRMIfw0ULUDnoQ15DxUc1MxtbTBc=;
        b=J3v2KQHFREic0HkixLUt1zDIFzeK79JH+UGRrh1DylsR1mM5BObTSnzyeTzIDAq7p8
         29MxovOIDr0a6MyPtHQX3qL9ZXJ3idm1Cj2vUNl5fKRO8SMEftnOVDCMGfx+R5iwXfWd
         f6CJR3Wk8/QJQ05siCdek9Bscs9J4PIAEUFUaKEs1DvotfhsvBufOamxCg9n3D+veE7s
         tcdaPw46gKiinRDxXwq8OLLbzrJqYFNJF/Nu10CAy5BbMHN0gB2pmxFIa+ThK8nNzFUz
         2F6RnNMLOhtEyitbu1Vgkikt8bbnhGlAnFe5TUw+kPf3HjUN620AB4UbBDDlp7g7BNmM
         NoVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVVrkEN44pVjYPCT2h7A64esRu0ssn0UdneLHBTlaYsL4bmknLTt56MDQ6KO983T1kT6DUcsbIuUHczhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUTq8XcSf/99HfZRPl/krCammHmdgl39fYN2oObOCn5GJMMQE6
	SuXimXnx1VSN9Huh+XGQPwQ+U0rVhlogIw4hgf5m7CU+UD8GNa6KLzlcmeioVc/qFkvg+5iezZp
	xKOaFGFGR/rKoWaX/hp+5IyRSMmM0zHtFSVrQnpJ6cKuWBbxLowhVXk3HzfA=
X-Google-Smtp-Source: AGHT+IE/99AVUSN3fisE2w+ifdN8vFFpq0rqhLd/A5gHvS/pil1024rmFgAFl4MGzcHMxY0PaMaN5MvVtNGQFcQ4xsrcItXRSlgY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1528:b0:3f6:6c03:18bc with SMTP id
 e9e14a558f8ab-4209f2bca6emr192739385ab.9.1758061262563; Tue, 16 Sep 2025
 15:21:02 -0700 (PDT)
Date: Tue, 16 Sep 2025 15:21:02 -0700
In-Reply-To: <689cd5e4-1ebe-4b81-8036-68393d61f4ce@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9e2ce.050a0220.3c6139.0e6b.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Tested-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com

Tested on:

commit:         e48b344c RDMA/core: Fix WARNING in gid_table_release_one
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=16844534580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

