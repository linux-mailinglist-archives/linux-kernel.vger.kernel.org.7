Return-Path: <linux-kernel+bounces-866025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03775BFEA72
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BC8188996D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34372CA6B;
	Thu, 23 Oct 2025 00:03:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A85BA3D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177786; cv=none; b=ZfaN8DwSDt0MDskUQ5XDJbzo4Y7j58EYg9Q12EO9HOUoAQrAvPkVMHZKeb+AvtU7+s3mNMgUzVMCDlGPEBeZGYts3DMpNHJMsyjUKGrb2GPvbFxeo4RKxu0fpnZu6m2kRIXSdsKlpTng6yF8BnYWIVagMJwbiHYUeDMtbo5m4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177786; c=relaxed/simple;
	bh=Ln9GKL/wQtQA1N2xmWLA6UB3cZRCHR8L7hfTVtEtJyM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HfjtajjfGf/HiffbjZhVhjiXr48mgvNULQZq4MQU4Nc+9TBsCVzb6LDEnfJTMLx9kQw7T491LNB3dUdW5TIn9AuDr/Sj7byykpcwI4XJmAFyMOVZZR1AY0avpa92AKOODyY0ozQoSLDXkNpwpTCR5tQh3mpgOtx/szgQVUvWhXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430c684035eso17981595ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761177784; x=1761782584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/q5oVCntKzKTyIhjMc2CnLZGqjT1Syhs9ogyNl3IU4=;
        b=L0rPkfWPat6PL6MuQlYqfZ79rubg23AaBeU5vJ+YPXPrFDStDCGf1DxT13UGd2yXHb
         PVmLVZFZP7+uYwuP3pZCMoI2NsbdwmvtAkDC8daQY0EJEkH6Q00TTosDgnIAZxq8phH7
         Sw1BkgHRZ7BoCCqrttwkp5hd/6uTLz0++OqIBigFRI+UaQL3W0QZB7r+GKjtMidSrfvp
         Za5AuQoSoQm4ywGJOs0pt+BdFLJvrpvUJHVthbSGOo82RM2m9zSRZwlzXUiStGi0Jl5t
         29W01+Sm53cYcglF6Qo9t6/Frb4STQayUaICrHR6CoCEL3frBgMiV2cQhA+0vj4faAmP
         YF+A==
X-Forwarded-Encrypted: i=1; AJvYcCUvgEuYNyA4Lr2W/p7LoYghij4P65QmWKfdeHEvfy//VVCHRfYOxyKHj8/+RBdX/Qv9N81zr5+grTa5pAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysNpvkzDZdIUXV0NWIl3OwW/KjyKHOcofBzThkFgxosKk4HHmt
	YmLxWCdxxumtbH02kDPaR3nsRN8SWFMsBbUnnWMwXTT+qWbiesKAJAwn38vECErlj/CRxiLid8k
	qcJwXzSWSc+SRYnIsRNkH0EvlXuFazTL+0bma1tExrcwYQ8zIWUTCVbAgBs4=
X-Google-Smtp-Source: AGHT+IHmvRIDvIBsT6dFuRLDvq460Cvxs3iTI9pf7JdqhNW5BsKXLatpAkypEAfxYuk5KUWGOIUzp1jfH/KSIfom8iM4ASgAhnIN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c8:b0:430:d14c:7dba with SMTP id
 e9e14a558f8ab-431d73431e7mr54405185ab.12.1761177784282; Wed, 22 Oct 2025
 17:03:04 -0700 (PDT)
Date: Wed, 22 Oct 2025 17:03:04 -0700
In-Reply-To: <CAHc6FU6i+9iRYc4h5M8B1sABGQMf3ViwyhBoVVyzR9ptD9Zztw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f970b8.a70a0220.3bf6c6.002e.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING: ODEBUG bug in gfs2_fill_super
From: syzbot <syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com>
To: agruenba@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com
Tested-by: syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com

Tested on:

commit:         a7f1196a gfs2: Get rid of had_lock in gfs2_drevalidate
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1713e3e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f8c6bdee6738c0
dashboard link: https://syzkaller.appspot.com/bug?extid=19e0be39cc25dfcb0858
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

