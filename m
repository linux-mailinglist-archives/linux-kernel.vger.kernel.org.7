Return-Path: <linux-kernel+bounces-873574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 153B9C14311
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9E6C5429C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1A430C600;
	Tue, 28 Oct 2025 10:44:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585630506C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648247; cv=none; b=pwwqw7f/8Faav1p1BCxFLTeaxAWXWqXMqXyMtBB2RGI4SdNKURCwICTaH5VoWncFCeJY00be1WyMK3hROsLK7jHvmvqRPIiZuoeHaTo7jvd5ZUjgAOLKUuEd0oXzA8XdQkG9tbOb302b/3SSYs/pb9Aj2bbbKuynDii87WMdqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648247; c=relaxed/simple;
	bh=F2GizbiuAl4yPa0mT1R5E931FZBmGvPfBLTR7bfPzK4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TCIwcJZ9HpeAoezCWDKMuuMboVvpXfjNkEsRShmKvWvADo+Q2qrmwb6/vpEjQqh4Fqx2WVlCJXP7WlTUILvw6JQc7DzvKhfN+DeySVXcQO/XaoQtiveqwEDjWNUUHCO4WUs2TvEOETaXW4tjrGrXwC/ilve8qp6JydNapPk5HFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430c9176acaso76560595ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648244; x=1762253044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1XTDNWucIXmHe4kCSRH2ADmpXRkI5UwG9jpOsVEyUM=;
        b=BCrA7d3A3jAemJUiZfxFavbkL0kL9TTNzulvKDn2dzjfz0EXTM86E3Wox1JnEE31RD
         4+6T8bW0F7ZLaBwLuTeLSpKDMFPP2AuUaMeeffYT4O0ZXuQ3dcQc8o2Y9iuLm6oZ3r4D
         lr6kOKMj7waYzr5DG35x9IY4sD0rm4plxW7vZnVX4a+P45ZOboVI4SZM5DK1VhULhX8J
         zWpqEpkn4BsX7D9y6PJvNOCAIKcvU+yEOeBZfijNiZNVATrrzbKdsHVDQj6iPTACdaT3
         /cM3/P650cBEI7P3EnLJXDnej8uVirPdDG2waPmIWM24Bg5b4kI6moKo+8pnAKsQ1YKs
         dCww==
X-Forwarded-Encrypted: i=1; AJvYcCVcskYhA2VetnVwJP5UQ/HnzGkuF32OsJL+ZjYsiQcHADUndB1FTEddOTNTA/UUOHDUq2FZ4a1H6rnAc+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YygsilIyqMBR4Q7FxrRFhZPv5PbFjiPf3fNyLkCj1H7G7GxkRHY
	EDNN5SMSRmtcGbi5HT1c5kknNZoMbgNQhCe5GXRldcT7q8LYRV8XDcXL72G857IAAXF8cVAlvyy
	1WC6B3HpGa1Z3fJSrVlmr40maxS1eIP3he0a0FxZIHfowC5byL4PvcysBNjQ=
X-Google-Smtp-Source: AGHT+IGR64V1/9e1Qs0m51JBpcyRmcGdC+S1oa14gwiYkt5pXEiSJaGbEWWkhSPnfM5y+KmPo5vsbMMx0YWo7DQBwePLDiv+0L+M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a06:b0:430:ab8e:9db5 with SMTP id
 e9e14a558f8ab-4321039b638mr36662035ab.3.1761648244664; Tue, 28 Oct 2025
 03:44:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:44:04 -0700
In-Reply-To: <20251028104008.aUH8N%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009e74.050a0220.17b81f.0012.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dir_foreach_blk
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-5.10.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-5.10.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=b20bbf680bb0f2ecedae
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109ed3cd980000


