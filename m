Return-Path: <linux-kernel+bounces-866892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 355AFC00F65
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3B61509021
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C66B30F542;
	Thu, 23 Oct 2025 12:02:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB1F30AAC5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220926; cv=none; b=YonM9mMGNrPafNXGrgvoNoVRgaGfpyUNXLDmvEZFmVeFc2EAXRIJ9UQxQyVfA0wtENkLgFPooUPoiDYCvB1JIqAhNtmsp70tIRYPGYRWxHEvIOFx24T9qrqBFYlCLTPUEHgZLcYNHDuItg23THA6yDNaSR51xiDd4X2WyngAfWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220926; c=relaxed/simple;
	bh=72l94/gfBTysaclsv+Zg8RTpvQpLV6DhWP5MZfhXH7A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YbcucvjGk3ljhk3i0G1C2Vee9fK3lm7D2RijJkCErE+UMqUC0074qq624h+HmugbZKerE9ynXVniTjB+hXKlQScyJla5+Q/KS2SYFhezxO4zIZ+uRP4x05AILkTg9yfs7gY5HuNLUUKwcmaHRSntXgU63gEFioFZWD9nno4bRII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430c1cbd1f2so8343155ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220923; x=1761825723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v///CkENyNkIrGpbb/q7VcygpXI71MhcOsnuCxC3Oow=;
        b=nBVf3uOLEPbqDWXFs6cf7dS0aYqE4UitU9n3l8xoIPaSSl3w9vKh+9bNxjmTNH2iIy
         T29gTOkzyI3JwJoQtmSD4sfcsseEAaS9v2QvE/VvZliwMYoWbs17iNTuadgcYZHiVBeS
         /0Es1y9WjFufnpIMpAJfE/5yy6AIooCYYuE1vuOLjTBUNu9WhgUzDkQv7JVuiWFMced8
         fT/d6fpHSVwmUjXPbT259HtgoRSETuL05NroZSf6hAyDtCFeRkWO0B0mc/mKJhwDhfKx
         Wg0hyEa87Hs4uQSrP8Vxg0vNYQpRhjClfvJE4bW2WA4Mp7sx2gFnql4gBhPa+4tzB94U
         PgBw==
X-Forwarded-Encrypted: i=1; AJvYcCX+HE6lKJ6D0APZkIixH1WZKVX9zNrXDM07zhxlr/XJZiH6qbBadSyVRMBxKKqbkQokn85N75K9KMM17o8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn6L4D5+oTkuUl6Q1424p+f7x1mYhuxXZC5GrpiYGJWPKsD+1D
	2NG1r6awFmDT42y8936tzOq84XZIE4dJX54Te16EXtlvVXD7MMR/aV40+nI9kTG71hivkS99k7N
	3bLEYEcF4WNcF2+EM4rrzcusyBhGt9VEXv8BP0xEqGa1p32rQED4s2HJjA9M=
X-Google-Smtp-Source: AGHT+IHKffyDwKSiH2ppflZcxVQPrtlsel0ibFyRRPQy+yC65ysSWWl81Jl88NjxEbbvvT0QQvb6mPfW6zdL24bXA8YRQYsOCQmm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2584:b0:430:a4ba:d098 with SMTP id
 e9e14a558f8ab-430c526604amr363044875ab.14.1761220923661; Thu, 23 Oct 2025
 05:02:03 -0700 (PDT)
Date: Thu, 23 Oct 2025 05:02:03 -0700
In-Reply-To: <20251023113536.hzwsv%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa193b.050a0220.346f24.0078.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com
Tested-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com

Tested on:

commit:         43e9ad0c Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1010c614580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1215729170d20fc
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b20258580000

Note: testing is done by a robot and is best-effort only.

