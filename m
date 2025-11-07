Return-Path: <linux-kernel+bounces-891115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 62461C41DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0407E351F6C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CF5309EFC;
	Fri,  7 Nov 2025 22:50:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78651303C97
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555805; cv=none; b=fe5MLt3u7mfWPNIcgpATgfFcxdWOWdZCcOhE8kzBIDqYrRVHAT1wsY74oso/kMb2vqJuoOaKQJcQnoVby4gBAr8WywC+6owUyB+9GSbVRCUVEdKjPHOe9VKArHRCNmTLWoT9g7gomgBU5cJH5cqaREGD/T+3EoK/mmMcfj/8ZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555805; c=relaxed/simple;
	bh=THq4xuEPzo5++sBivy1huqUUbzFtk4m+53nkaRI19Wo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V+5DNfjNjdfNZUF30P/J5SOwMnszX5K/ZSBklrv32sEOptIKVvoFWYk/Ft30Dho+bH9i8FvMFqyAOkjIZVVP+d4rZrOtcmL4DdKU+HdeZR5dp6vT8u5kSEhtsp6EZe+5/IkDqOOk2ZvNd6A4bTMIDeBhbP6ECgoBqXb9xHWSJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43335646758so14822295ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555802; x=1763160602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvQeEUmMVGBlaWvSO3xuAaGtaxOnJdff2bOrZeo3o28=;
        b=jqEh2Hlydo7rbndMX9+d+csN6vUsMwAFlC7/UqKB/iOiTXt+1Vn2d7t8/UpMOUBQU7
         eA6kH7yF+LLN8QSZqhm3WQOaFVt9ZWViOir4HhxOLzIKTcma8YvLQ2LwGSicyEV3AcMw
         dlGIpn5OWZMxQMGt6IIxAk/f/KD/wXk8p7mSrBojVRXyindPevhx4vYg59sMG81Sm0Ma
         6/sF/4KQMtuy3+hyvMJ9yCgWJOpRg9L6UOo7lwIAhYc2lYtHcghqeAih0ibh85kMeiBj
         QmSNtF0awzuqzpeGj+YxFRsmQbiq+su/TxPYl4LWnbsIIfPNf5lOaKIYM8gGMifajFQP
         EEbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1wKHzHeE2Uz8Y3eZ4c/OwzfINUY7SNvgRqQnhAw1GtRD4bubdHlm+6OKem7TgoUOn1PDB0I+I4Du69S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUap9C86Mq1micnRQaqiBbCuhPyFAnm/9Pcvu5DB+mqwBzwNae
	lqWi0fn9GTXRtQJBmIi5UML2ncGJyDlFtUK40oV0s5n9jh05m/rH0fT7nEbZWN7weyWPue5ucqj
	0+TvOja8YaIhyx43DlId6sfIPjf4yYaO/KZCcDKkWz+ZuKxc84orhD+m4/VY=
X-Google-Smtp-Source: AGHT+IFG+d72RbN3JKETGD5NycX9hzpJmmOcoWuPoNz5sW833azUDv4GKYRr+TM6k9tXFrHLGICYtiRVr8El08BW+KL0Am42Mpmf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f06:b0:433:2dbd:e93c with SMTP id
 e9e14a558f8ab-43367dd02admr18751395ab.4.1762555802358; Fri, 07 Nov 2025
 14:50:02 -0800 (PST)
Date: Fri, 07 Nov 2025 14:50:02 -0800
In-Reply-To: <CAL4kbRMZt4xxD9frO+OGru9MjdeO8Rs60ihimUguJqY0uqDj-Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690e779a.a70a0220.22f260.0065.GAE@google.com>
Subject: Re: [syzbot] [rdma?] KMSAN: uninit-value in ib_nl_handle_ip_res_resp
From: syzbot <syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Tested-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com

Tested on:

commit:         38a2c275 Merge tag 'parisc-for-6.18-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e4117c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbf50e713aaa5cb0
dashboard link: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a23bcd980000

Note: testing is done by a robot and is best-effort only.

