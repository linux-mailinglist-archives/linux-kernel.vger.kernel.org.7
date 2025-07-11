Return-Path: <linux-kernel+bounces-726836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86555B011CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52141644C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29351A0712;
	Fri, 11 Jul 2025 03:56:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FE18E377
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206164; cv=none; b=XP3h78wY1AEEyExm7B0P08aML35PXthyCNPhLYM3ssTOzwjq1Hy5yhOqONvpwwlMSFQQ+HAfWawV62EbAy7om78JEyd3+wNLl66VFyTromgBWJ8c0OH1V422du/8StBiQWElo/cuXshTbOlia82jAED0I4e29ybve9wpPrszFJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206164; c=relaxed/simple;
	bh=qrvVnD7tsAlGdor8GsTJApC/AF2fAdAEyzL+zbw5X6o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JqYbxUnEBuVI4mAmUpmp0EBgDnTJG9mQEpIyNabkIQEzlYSucnvuFWo18YRBDL2c6OTs8DdregOh/mrx6TXFPytXVovFXLj6CbdmZvzKuLtXaF5CNUmmWIprqM6nD2a32KKe+yZOAo73GvkACb/Ov1OfUC+LOR6n5qKZaHzIPPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86cf0364dd2so293591539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752206162; x=1752810962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZp4CnX1jisEr5X36+fTaZKz+Hv044M+bjZ2ZKEoiUs=;
        b=gI90tjZuQCYR1dSn8NJNIGMtA4v/PrkFbMr5BOh3rdCAtxCd6FjNIgBtoR1irw1SeA
         4wn1ydumF2/Q8EhDDXnNXd/HQfKgNnVt5sNZz8o02E2p4jSQTD3jwCjzgbG8M9fn9qmK
         kBOcGoZMWi8h4kL6uaR6mXY9uQ1Lz4zIIa1Pnii4gHbXQuXCHUei1TjycXdd/NykGthb
         Xhk3rXIXmX+JV23jTISjZ+4r7o6keF1sHFKxu5GHZkd2SiaXG14t1PdYUeaCwsWLznYa
         oLxFbjDvJP0cbmhBN9i4QI5ziQF1pm8S/tCvdIIAhqYvBIHQ+d5/sj2On6ZK4/5DGZS8
         xhLw==
X-Forwarded-Encrypted: i=1; AJvYcCWpI8xsCw1T27tNZ7H6KqdspJEkZogCR6SnikzbJQmk2TDZ3nyiare4pC2DNxKDizTP9X5qsS8v3TPS1CE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7RCjm2cMn6jy6KjC1OVZtwos/O6uGI5QLxeFM+yYDnDWW5NC
	ZLkxKr7vDWka/9Ate1gVILwLsw9MB3ORUjH1LfQ0tNwDK9JpyTcsu+Z/d4LQj5pD+6iS84S5ijU
	3s5HgzDjwuaEKRcwdQvbTHBBo0cOVLHNaZdPeeaoWK2lSPywAJb2bnAVmtYI=
X-Google-Smtp-Source: AGHT+IG6znb7UfgkNam2LGs/PJR2qYWzy5DZtGoZUssfWfldTwfTSts9ze5LeNTQ3z/OSGkO/0Jhg1PadlVFuLnl0uu3m4VBrr4X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6808:b0:875:d589:5b0b with SMTP id
 ca18e2360f4ac-8797aa2f686mr68831939f.11.1752206162209; Thu, 10 Jul 2025
 20:56:02 -0700 (PDT)
Date: Thu, 10 Jul 2025 20:56:02 -0700
In-Reply-To: <20250711035418.3336-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68708b52.a00a0220.26a83e.0034.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
From: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master: failed to run ["git" "fetch" "--force" "c7d0fbf060793662bad7a58c248d99da187d8f14" "master"]: exit status 128
fatal: repository 'https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/' not found



Tested on:

commit:         [unknown 
git tree:       https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4f88512ae53408
dashboard link: https://syzkaller.appspot.com/bug?extid=80011ad33eec39e6ce42
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b0ba8c580000


