Return-Path: <linux-kernel+bounces-890581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAF4C40677
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DAE44E46B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66742328B48;
	Fri,  7 Nov 2025 14:39:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6F17B425
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526346; cv=none; b=IJDWOTemgzEMvMlQIqxtqiT/5YELTDiGFn0vn7IIsdbOyuITj1r9rHeihA3rhQHUTZZV2X8H1oODE4cdIzYHDHIfpaRpHyEJa9eN4sUog8gjHmUxjMzGXW7IPJSnBIyekCkn6MNwUKT2ueTw4lbyGweJpgUoZDO3zkLdmyjUjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526346; c=relaxed/simple;
	bh=l4NUM9A4y8eqWuu5c3iTUq5n9Snmq0EEz9saB3KeQTw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qJB3TwxkalhDrwkjPqyEmjqbPo2Oo0EXyXZfHoC7R0Ja4FAgUuld62QroHnntrG1OIKtaF9zlJ2mNv+xYZ5KOEKfTj1PALIuNJaQcpexMjxAtnBjGS9TtvXalrB9B4RTJwbRq/i3vbV5I5eJoQWQaat7mHy1/0zXD/na7tvKy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43331ea8ed8so7489855ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526344; x=1763131144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FR3ckK3TeDgbADSNzGIGrZezDioAU2f4J5g5yr8DNhI=;
        b=B7Bq6TZb0Dk2FH70uVucpQDolEBYvCiW3scea570mf1/tPcZy9YxcDlO119OA5qSvp
         4Tzlxhb1f1ViP6vDaXmesDzlrPD0iOpA/um7lhQTt/BTlPlKRGzIs3Gxe9ZfcsyBfewG
         1czMCLqgDOUKdi2oRmes0NYE2Tl0K4bauUNGp21AmpJJlTlokdoNC5fTjYkZQ64MtrmO
         qw39o3W+8I3LDrGI/gN0wVaJuIHgpY644YWXxSb+7a1DzF3Dq68NN2AoBd5m/xJkoIQT
         8MiFLRjhiwb2K4DXLiaXZdNta06ELq/ZDj1xx11YgiInknPbdu96zhtQfqHmG4Nodyhf
         DNPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJaYn4uzcuIVdHcPcXzPv65dQyJSXHj1ewlYAsHZhDhk5jz8+kX+2/8A8hxlP1LCg+Klkl0IARvliQQLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbLquQFSIOmHOVOCa5z2zZwO9XCtqG+dqtVyjqAqLltdJmcAc
	LC12Q/UDYUVvOytx3OPG8zPUPz4vF8M4ONBPg5+QSdNUGAUOkXGMHNg6Wck1OazvxW80rL8stKL
	MVLdUFr/NZfUmBzB6OBdaNRt+Wv5YAfsQq7BFMtQJmG7uEK8TbXrAN/Vxgvs=
X-Google-Smtp-Source: AGHT+IGFX8NJAG0UU6t9ygAYIlqndedmn9MG+yuu43dgLW0u6AUSim8y0YTm/R2FKkUrW0LJLbVsSP2ZRTmUT84Rrc0GRc2D6L7a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c23:b0:431:d7da:ee29 with SMTP id
 e9e14a558f8ab-4335f46d880mr43191315ab.28.1762526343708; Fri, 07 Nov 2025
 06:39:03 -0800 (PST)
Date: Fri, 07 Nov 2025 06:39:03 -0800
In-Reply-To: <tencent_884C1769576F66DEB36003674976C3A32405@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690e0487.a70a0220.22f260.004f.GAE@google.com>
Subject: Re: [syzbot] [cifs?] memory leak in smb3_fs_context_parse_param
From: syzbot <syzbot+72afd4c236e6bc3f4bac@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+72afd4c236e6bc3f4bac@syzkaller.appspotmail.com
Tested-by: syzbot+72afd4c236e6bc3f4bac@syzkaller.appspotmail.com

Tested on:

commit:         4a0c9b33 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16097012580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=72afd4c236e6bc3f4bac
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14915342580000

Note: testing is done by a robot and is best-effort only.

