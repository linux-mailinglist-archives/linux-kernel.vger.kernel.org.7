Return-Path: <linux-kernel+bounces-837374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6B2BAC2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018F71898A52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF72BE7D0;
	Tue, 30 Sep 2025 09:03:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0372B248881
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222987; cv=none; b=HFFbr22LH2Mz1yzsewutxnaiZZvsLRxeSvo/aCTXgjmx3MIoD4cMEZwfWBZQfSQKrC7nE53HM59kMOgomlXhKB7koQGYYsl5Ee+Mc5gFd667UjRN94sd8WPhDLf0B6KyJOM2mKm7it242iD8pmcSe86ZNzqVVY9dtagc6fiONKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222987; c=relaxed/simple;
	bh=DKc3jbhCK/q5IExD8X7Gx61nmRUCFH1JwudqbI7dCNw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H8sqelNvaKNdmC2ElQnkKaUd16uGs8kNpRlSgtHvCAljFrOvtWqpeX6CHuE0jlHeKRfzN7x2l1KKY+FK8Ufi1seF+yD37tT9raldToNAFxxRGypReuTmIPcYeMQJrdm5ZnfzOCJOwSuwBmkqTneZ8mOOzjuNHWPtbBQFwjNylNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9143e8a4c5eso1061395039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222985; x=1759827785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGgMSSQSjMV1AtRpSgEwVRU+wWuiomfrUJwLIz9m/zE=;
        b=NjJAvQTuOIFqqRBKjPK42417Rl9gUGchkYr0bDnfe4EHFMkDy9xd9FD1PvvDlD8WQz
         M4bkW3dLNuiwVfI21vZ+0vOl6i90WMJf/aHDnbdPLpnpLOn2EIKLk6h4keAdLaeriKUh
         R5HXssDZP+XOTRJ092T/TPvLX+JVhdksBa188UCHWtkCXPz+DsHSSut8ls26kTVpylvz
         RETAhF/e1V8O0x2JF8KXmcYs0SubPJ32klfNvBs/Rw+uU4+SS4KUK9rFRA0FhpRF1oyZ
         jcALyQsQMkL5LHWaxagYpFUHPNHur6+Q2NhwJtXwfg20CQ9zQsHIWCdLWO3Z9Z3527dm
         cRPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNQzX/Jvs6lQMpZMlkBwozZQd7UQziuobgYNMfhoNY4negV6G87BuXDgoPdUui2kWCwow8E2rI11Cf0Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/XhHk+6gBne9brYCjaRvQVOnq3E0AHKBgkJQmE2GNr9S7rDeX
	5VSF6j5j+E6aYjSYCGOdX7lHqIquICrRbEM4TNvKC4a9Q7WTaj6brLCNk+QhBja9zrWzkrJs4/q
	ukBctsgwdLI+NrJbsljmSNhM39XAvdoF4fyH4fgYMk4BYMftYfg14eqbyP+M=
X-Google-Smtp-Source: AGHT+IHqYiJ8/QMcZdWzxIkMBcqMX7Zpt6SgxXGtHQuK+pt+7WfvaZgxBrjo+JnlA/bXSCElEXA1h2TDM1rdK9lLkQRgUCrQfB3D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d08c:0:b0:425:8744:de9b with SMTP id
 e9e14a558f8ab-42595614302mr219143015ab.18.1759222985024; Tue, 30 Sep 2025
 02:03:05 -0700 (PDT)
Date: Tue, 30 Sep 2025 02:03:05 -0700
In-Reply-To: <CAAL9DyBcAo3nP_ME++yw6feb5X-ZAcKPepfzBND0RYPYRLmWug@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68db9cc9.050a0220.1696c6.0024.GAE@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_wait_one_vblank (2)
From: syzbot <syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com>
To: chintanlike@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
Tested-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com

Tested on:

commit:         30d4efb2 Merge tag 'for-linus-6.18-rc1-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113e2334580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eb55ce880562a8c
dashboard link: https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12610092580000

Note: testing is done by a robot and is best-effort only.

