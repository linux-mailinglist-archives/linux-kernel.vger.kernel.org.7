Return-Path: <linux-kernel+bounces-873560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F321C1429D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7523D19C59F2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9473112B7;
	Tue, 28 Oct 2025 10:42:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31230F943
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648125; cv=none; b=FyzSmswpTIKrHwBKnxZkDAxEe6bkpq7yGiw5U+g7/SG4wcV6rrZeCBD06pNa4Ne0GNX2sUTO8th+J/CQNQ/JxPtHCgW6d3GmprajLqsuj8EhJB1XMdWf7InUMiFL/GQ49IAFFjNw8/eDp/57X58bOulbFZyErFW3yFuICqEmKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648125; c=relaxed/simple;
	bh=JG5lqGBeQEJU3GjPUuNtkebhCmmk9+02rkPil5N82kE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TtfSs+a5XZnn5xhHuhmUa+l+l/9tkQb0P5roMXVPcDLoz+WPLvTrgnKJSDp1X0QMVKt7OjxmbsIgAh2kAJmHR2rBJiFZr32yYoCZQPZ5cArXU2mr3XH6EPtJoogvNtGtDi744zBDQXoAdc2kFyihEybUVJnOLNcstl47k32BqW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e7ece2ff4so1815432939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648123; x=1762252923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mbqPE1TPqcxA2dfTPwoM/tgwnNiPE0+wgrXShr44kA=;
        b=ZXsfdggYmaBWvNbtOQJXQ9Xuwpjlaniu7q1a2k0u6dRUwnEimBFRuTB0vkEkNOTz7x
         K7Xp2YuQ9sVg7iK8o3TZqzmHxZf9tngJMmw7iJ5+7LsQshwBSJ2SdDaJaLqO7dunt0/z
         4yeony0ArNfNFy4TqUxgAfRnRYEW477yGVmpu/tr9uewXRc8Y4GG/Hc0YxzYUYR8IRI0
         ppNW7k4bnQGhRRcJyYBEggHT4aKhPe2j2fTsHYDmPTDougqzy8sJjW5+M3/aYY0dgGJv
         F0p7EIO8XpEyI7yoYGNg7bIB4x9lwnuoLHhMcz10NYo3cR6NYsBTL/pUegkgS319mYdN
         iwkA==
X-Forwarded-Encrypted: i=1; AJvYcCX/7oBsKWDxBnynNzZGl0Uf4MM7qS9LYKDEqziShgXkGFRpxVlfhLYKSTS1ftBe6NyK5Toc07z2ejHe+5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCuWnsetWauHWuiiIlnXoWCwiFZs3tBCclNaCPaKACumFnfUBF
	YJwe3XzHfrweaMyJ14unDLpoETaWCllBKXluWN5W6GrNGU4uAf/sJAMkln+9QS+Az3U7GpC4srD
	BJNdDHNDio0tFkdS5Z6LSzjq9V1txnNA59+/JwERx3NwrVY/ZGJQlf9MejUg=
X-Google-Smtp-Source: AGHT+IGrraW9rKtOErpal7jhHH6Vts+HOeGZa/9DcuEJ98RfePdO8UpmhgbelBXrM4CdEvn5s1IAMLSPTHYa15qeoZ6ZHshHzVQ0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2602:b0:430:ab98:7b1f with SMTP id
 e9e14a558f8ab-4320f838a59mr51588455ab.18.1761648122886; Tue, 28 Oct 2025
 03:42:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:42:02 -0700
In-Reply-To: <20251028104006.wRL2R%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009dfa.050a0220.32483.017f.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_log_needs_flush (2)
From: syzbot <syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-5.10.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-5.10.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=c24237f0eee59c0c2abb
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16863614580000


