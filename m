Return-Path: <linux-kernel+bounces-835367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD1BBA6E87
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 12:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0338017B733
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252742D9ED0;
	Sun, 28 Sep 2025 10:02:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4C4221FB2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759053724; cv=none; b=EdNzAD9HFcXC1qrIKI2qu5C71Dc0J+r8sXySWI3ofR8I+l/6wkEiWKwxegjheyXEHy2Zi/V9Dg9bdB2UBWITgG61QtvkExrkkw6X8CudU+B2Y2D/LKXscPshYGJD8oTH9EPKM/MLq++0mJ+q2N18/oQvkdVQkYA8B2lup68Znvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759053724; c=relaxed/simple;
	bh=7+FKWyt5Serdplp2JwbyVNpDai2nVLyWOqDfpr0nW6M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eEKbfkgK1wzDwmS1/7yrA3RndsXrkJQggYLnq5AxQKZapm+FgDS0P4GK5dDlOwmfXC+iIa/TvrUHVrX9FbDt+KuT3RsS8YHtURino5pwVIDr5BhJ64sK8N2dcgGTomYPPCeH/jTaGa5wRX6to9/O3XTYYEPJYuMZctjCiSppJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42571803464so97120385ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759053722; x=1759658522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdWvu8xuorNGsa29ZN8+pUiADJoPmkM4ADDtBXyRKDQ=;
        b=OqVDSdsstLNtIaIsQ2eCHV1XADg26Ng+OWQykhgzr5pDxUwqdsrBEl1qzu07OvPOCu
         4TwI2YFD6bylfboc8qWanufHcJDAcVSTYuzaZ3pwJL3AR/iH5K5IqZUokU/YdcnLBizg
         EXp/eWDoiBcWuTnkEVAsVD0Wor5AwdkyRD48uo0u3w2lmQn8O+DEsbbkmxKGpy+kd6EA
         U1xXcEXLSy8X7w8WopBF55DZxbTZFyGbS0eBvt8KxH4gW7ItixMWhoAMgWTPeWvGeJFA
         BVG8zGr4cKnkxouab5syr5k5PpKa6fsEKeckWKOErQboLKlJj3NCmCBNBMpZQj3a1BXq
         eR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3WlkShm0ZS+b63NnigisJeQzqIbLIIsJbTVwn9argYOl3NDHUM+wfjLr8CPEQUt1jyCGPK0qHQXhGpjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8bcjal+8wdIYydHvseSN50NGH5BISFZ+ZxPQ1pGKcQFX/22YF
	mNxCTwv8c7Z9qLVn5xbF3msJ4N9R6S4McwT1IISfcoojF5Uq/UxXmDcsxLxGKt1l2sewuYx/wET
	KPzfu9/uhISp71J6t6g0jjUc+yYBOMMt+w58uJBbDCpoLJA7Cog+v5IxOsKk=
X-Google-Smtp-Source: AGHT+IGqS3XX8AT9soZWWlG2zy4C41t6Yo/LeRTJopGSDAOiKvg4n8cycTWd/SbX1iUpLSarNw243shRejNtDnglrSBIvinw8nWO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2186:b0:428:a5f0:979c with SMTP id
 e9e14a558f8ab-428a5f09a9fmr71925735ab.4.1759053722373; Sun, 28 Sep 2025
 03:02:02 -0700 (PDT)
Date: Sun, 28 Sep 2025 03:02:02 -0700
In-Reply-To: <20250928094135.11584-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d9079a.a00a0220.102ee.002a.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (3)
From: syzbot <syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com>
To: =syzbot@syzkaller.appspotmail.com, kartikey406@gmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
Tested-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com

Tested on:

commit:         51a24b7d Merge tag 'trace-tools-v6.17-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a04ae2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17df8ae2580000

Note: testing is done by a robot and is best-effort only.

