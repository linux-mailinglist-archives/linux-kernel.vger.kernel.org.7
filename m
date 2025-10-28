Return-Path: <linux-kernel+bounces-873597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE67C14378
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76BF1503D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C937430C621;
	Tue, 28 Oct 2025 10:50:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7891305065
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648606; cv=none; b=RLiD8iofla87Y39SKUvItl3CWLcDrChRTijrBjVqA6B6S50f6J5YWxhpPp0M7zAgOcxIeXfdTJa0O6W2bJxPbTmViXl1hYBChW9zs0dJ3hYMijs5P/R7iqL895NJf4FD/vPJaU1jWU/bONWAvt3O+ynmZg2C6Z+2ojPVtOfp5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648606; c=relaxed/simple;
	bh=TZrs4hBsqMGFjtdMDxT4Z+SxkNF9CmrogXb/aUZloNc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Gcn6wdhluNP+sIp74MEicWNeT0aMwivDc8Jp4SIRrq97o+5XqAV0gBXUUbL7TsZq+Fto8yATN7nGSRZt8E74mQMfDqaicsYwvJM1j2xg4Wo2HQeiMrVpGT/q4eb1SX71EC7QvsFwgUla+k7XgoLCFYzD1d7ASnKH12on8RB1YzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430c9176acaso76623125ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648604; x=1762253404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBNRjg3jZjjScD/HC38JbSRxO8LsGn4fSgkDMmZBjrM=;
        b=FrhhFOBMdKbQ7TqMv57kVCLgEsWzxhDRzFuMPJTbEX4haTttWIGHSDFvhAyaXbG5ar
         bPWgwHBqhST6L28AwV5DwARmwx5EDN24PLrYVyu/P3FUwCOLTv6UPuLgjmwamPrqcAzy
         3a+KON48an0H4PK/Dth+fF/pP1mDeHWn27ESQoDA8uwRk5hoGu22vLTOeUK+4/dD/V8Y
         hvAzPhsSh0zeJLfdCvG4u17e4WfAq93Ur7XDxW6kUpvYGhp2rHGxlwf0AHb5dRsD8MR0
         aKphFYlRcy/Ri4+G/jE5TzlzEYpDFjE5fzI+RzmB54b29zDyU9LXLeixOP54OT+GopAv
         JtwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqJedSjzry8N8VjQjB2oxtWoQPv6a3/gfb5fdclmIj1PsFfbjOHfuZN7vNu7f928C5bzVwHwBtPSY00Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKgJ1NuXLY2/xDL8YLKDolV1H6Cft31n04289mI+WlBq/47NaT
	eu8Yh31Du0rxw57HmyLzrKkCvZmBQ4IiFJvzvLnTWhE0+MuZufwtDcE9mv1xjgk3TZTcITCFLd+
	LsIcyRX5Id6KNsGwAs+oTJXHUUtQ/yZWJf1i4L/ydVkcrwqBTJOqSQYE1Hf8=
X-Google-Smtp-Source: AGHT+IEfHpzwW8xPrFt/sjuGoYchIQeHkwbT5VONGg4QL4b5OrzZvNwjDVBDZnmxajICAwzSbxqgGhWyrYcG5FgjOkfJtze3ezNN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c243:0:b0:42f:8bdd:6e9c with SMTP id
 e9e14a558f8ab-43210431525mr32073845ab.14.1761648604222; Tue, 28 Oct 2025
 03:50:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:50:04 -0700
In-Reply-To: <20251028104200.0Jsxs%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009fdc.050a0220.32483.018f.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dir_foreach_blk
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.12.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.12.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.12.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=b20bbf680bb0f2ecedae
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10463614580000


