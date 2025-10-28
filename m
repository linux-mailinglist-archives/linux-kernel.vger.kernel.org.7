Return-Path: <linux-kernel+bounces-874525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65255C167FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8661C207F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7A334B1A1;
	Tue, 28 Oct 2025 18:34:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD4F29B793
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676445; cv=none; b=lYiyi9NI7sCKyHoD7fow/rAZ3tKY0YNZ9szKk1HUSIPlPnmIIl9OoV1JftYFaNu4NwmlUVI/wXL2FcT+euRvjlb/mGRuxOaAEjU+euf0B+ZoLxOJpiTSgR7xkmYCY/VOB15ryG6n39xi8+IoYtLB3zvOJ3zUWTMFRXp7hprOpJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676445; c=relaxed/simple;
	bh=tBTU5FyjJs+JwzweZd/E1m8cXRJ50mrhpR57KVD0OEQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fEHDe7cyiTZlPrv9ooTXn4CA5D3ATA8vFwounAedbXwEyLnbq3SCLhqLXoHje+zuRHxZr8QLk/6573ddBLGQStASc020+Zc4CtFsjrLzX71ENGcz9BwWfsXInXsMvi0+AERF4m76H1govS5ZjLiy3Ju6EP8X0nXfruuZ9XUib4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43210ca8e1dso14680125ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761676442; x=1762281242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gW1YPOwBQbb2MOsAP96Tp6PDEGuZZ/4jbXaw39UNULk=;
        b=QRx6/jds4L8ry7pnGg1i/F/8FJx4ko+a9xRERSbeLeOLjph5ef2vqLqADdTg/0zi1U
         FNtaFYNcKqWtn4+Q18WPp9Em4Mtxpul1wj0kCjkjWoGisb2i18wdMp7v4EB21v7yjiEO
         H3wwYY0jCstXkVohvJ1sJtIFYoEXgyzgYCe0fbaMtfH7RHI1TN4mdvh4I8BoPHT/wRmq
         0d9ykJuq9DNSR7PuftzhH0Xz+1lCD0hedksFSmPDbSTltyyMpnVbxNo/JvIhE2nNXdt8
         RPD/Me3qAl/W5NyrT9NfRE9cayJablzfOVvnrlomslZmi5NANfmXyORUQYayJDoCnRdx
         Iqyw==
X-Forwarded-Encrypted: i=1; AJvYcCWRHMyIPEUfHrQ833Yq90jnkvlzgviJ7Uj7XYimWtvqeE0dM9NV0JpSBGjL0EOZdHuqFp3gtbq+gVQX+X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE/o6Z4UADgMHSKE1VLgLHL044+1U1arVCuq6QcsEsa3Vp6j4F
	DXXyeNVmn7m2IH5alcjBaxiRXXyGdj4kp4W2/lWXcc9poG6DAD7mhQx25oX4E08lSGKON3ewBSM
	PpEPTd2bNDWpAs7oWj/xw8TfGoRjAfnUSIepnfrQwub7cRhbkz9HqTB75+1E=
X-Google-Smtp-Source: AGHT+IEy5RjWwY4FgkAhlhf3SFuIYuceCpk6QxILOfOhwfRUosFmETkyTT/Qb+GwussgWmK8kzQIh2+hLxhHSy8Le6QdjlhJ9tSd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1485:b0:430:9104:3894 with SMTP id
 e9e14a558f8ab-432f906644fmr2119435ab.30.1761676442004; Tue, 28 Oct 2025
 11:34:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:34:01 -0700
In-Reply-To: <20251028181936.web8g%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69010c99.050a0220.32483.01d3.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:474:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:489:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:502:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:646:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:659:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:807:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:943:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1030:39: error: expected ';' at end of declaration list


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=99cb6b007a8889ef
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15cc432f980000


