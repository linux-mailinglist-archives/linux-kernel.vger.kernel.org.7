Return-Path: <linux-kernel+bounces-864153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 384ABBFA0BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE65818C1B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770BE2E7F25;
	Wed, 22 Oct 2025 05:22:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340A22F74D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761110527; cv=none; b=KWmmHQirfsdp0W1G85vV2QVhRBYXwTTO0SwKmBUXkWuyMUr3MO4sjRcc+mA3Vm4gYaY8ETmwPeP2QkpMSYP4syI6FIjwW5Yk2ZvMT4j69FQOgqeoBl/0PfBEtgCsD9QekCleFrBEQJVsOLq4AydZntAs+Q9egv8njrYP5CojwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761110527; c=relaxed/simple;
	bh=2sznMRp/bdPRVJkd/g0tMpcu+dGdQSOjQYO8U2XlRPA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=giFUj3WxwYt3s41SuTq19EVHvyFs9nyzqHb/rc8Fazp4ryyKFlCK11mLno+NLzoZtTu4UUEpsgczZmHmWa6Ifx5hJ3ZsLnSyjxRN7Ic/nO36Irf0W+pUFCj4c0ULJbHZmAdnwoHPyBu0bSnTZMHjdGg68Ra/qZVfv9yPuqPiZdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d83d262fso135587555ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761110523; x=1761715323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nioKUxa+xaBTezQGJbEueQ6vMMU8as1svR/9k3DuJtI=;
        b=nJhMuOSWVibaqdNb9gUiJUmwshnPX7S08w4breFIdsqpkKa8d3r9AA9wUVPxILqvsT
         wyh8u6MHJStjYn2gubSzttvM6dATN9R4ziGbUGP69dy8Sjpl8gKPTIxcxuhULcAMKRgC
         dFHdamhuoeIWGbz63w3Kndcx0X5E8CbYdTOKFyBwKs2Fm1vf7pNo3vpoFOtxauxOy7Ey
         WUs1lGELE/voaxkzHcJUqboMjgjwoVl97kL5LZ/SbFgAnruU90VOwDlCrW8O7gXNDwMv
         qtq2ObDyYo9/1dyX6wCT2x+2vh5cT6nu5AFv4qGO1OI6C3adUK1bYPZYQ+z6PtNwI4vU
         Xmbw==
X-Gm-Message-State: AOJu0YySYZPn7f02apVRAcYsc6njyz8o4sn5jIQGf6pw1+ch+G0b5ltB
	TfNUiOWaD9kGLa56xxqy1E2OfyjGM/252Z0nJBmrPggOe/rtpYYc4Md3C+DooIKE22UgaSjkNhj
	vo9uAC8tFO4whR5DH2iQCcx1UMRhhXipJaC2dQd4vg0Y4jg09BPiqPXLHsGw=
X-Google-Smtp-Source: AGHT+IHnuMeqNByWsh7bPdj0NStJL1dKHai73XL1q359yZA1IeMydfvg4wMp01GeKj5552+bu4nlZ1DLEfsNTzsBBJLmUr4Mo19m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fca:b0:425:8c47:13fb with SMTP id
 e9e14a558f8ab-430c527bc9amr294639925ab.17.1761110523548; Tue, 21 Oct 2025
 22:22:03 -0700 (PDT)
Date: Tue, 21 Oct 2025 22:22:03 -0700
In-Reply-To: <aPgEdIAnSTBroJuS@rpthibeault-XPS-13-9305>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f869fb.050a0220.346f24.0035.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_cmd_complete_evt
From: syzbot <syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rpthibeault@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com
Tested-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com

Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b5d734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed2b1ae1fa9a0fdc
dashboard link: https://syzkaller.appspot.com/bug?extid=a9a4bedfca6aa9d7fa24
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16f98614580000

Note: testing is done by a robot and is best-effort only.

