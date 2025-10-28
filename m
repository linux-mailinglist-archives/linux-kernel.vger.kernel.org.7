Return-Path: <linux-kernel+bounces-874631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC9C16BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25C644F7C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E1734FF50;
	Tue, 28 Oct 2025 20:11:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C234EEF5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682266; cv=none; b=A5WxNZfcL3Ng466rlEhs+jnRQZGv4dQ6dmvaCxm6Gq1//FhV1QSaVICJgwJ6lDkaqluYtTvBEBGChOte26cS8R5Apb+oX74IkrO6TY8V853OWrf0Y8RrymCtRvGvGzDef+ZIUpSxyatSbOmQvTLgC9WO3AXzNaQVp/s70l8L0kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682266; c=relaxed/simple;
	bh=76t7X4NtlKBoa3bhC4F39PmxIQyVWCPFEMu71njF7JQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jJxtH2JAzmdbu5WHf5AkGta0TV0LTABEe4PYBTO/qd8Z7W9UNrZ5T8TFGLzDsvgbw/1hmJA8A4lvFcEdzPf9rYtlpgiI96TvLY94dyDHSBBNxZq/M+GzbvW+flVVtaBbOnzL4lbswCxsfB+fpESyI+yeWIFXlnNcg7D//RUZdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430afaea1beso85295095ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761682264; x=1762287064;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snDiMXoIBqHxqZ1Z3cTd54OwNy2Ll8Rqdyd951bEoNk=;
        b=bgA2M8LBujtwHXTdrP/bZ4ZN9RswzOHDtLz+ehVDbeuKaiWAtJSMg09UBJuzjrMT49
         ZYS9O3QxyVve+Ex5CklFinzJCYEUNcPkqn/5nLL11iXXUucGNuL8sRbWWhWDwFeZ+bdj
         AbUtOCqDQkrv92hByuxUapZGXQozfLAyKSTo3eg4OhVq487VFGZNF/dp5ZpXdmoNCGsg
         33vHQIjrAI87MJGFHlfZdLrDSYn6MakVWMX+S8zOAdYKyiEL0pWcNYemiegtk/K2Ty/g
         yr9P69PM1vznktt+jLqkJ7LPLyRXKEaYPHYbguUs7mX4RUEEFDEXo1KyirXKJWxRhIj4
         x8/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUQtTw5VvUN+B7NFHPCxPWi13zzEEsrkf1RYVFCynod7dDo4yR8gpCyKrm62zdFhM4Pgwef+5CAFC0UwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Owtl7SDhuN0rTIcmML+2XSoIsO3VEqcVxXmlWzKAH+UqFWAi
	AuLRUdxA4BxA/MQUs/4DcqaIfPHOa+WVTVi/Hqj+wckn8VBBMnMoraHBPhOiwfe2mqbCbAoe5+t
	xYJe/WmExCfvUsvqAWCYks6GWwWEpcBdkHCHHGub5bycc/Kn5bYSnag1DXx4=
X-Google-Smtp-Source: AGHT+IGG/0dINSPTmUOb73GUaltDBc92SKzWgv/1NnnA1VxhhscrmAXZZCLOxXm+45k7OR9exyK9900T3I1Jxidj7gqgxfieM+wH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:42f:9b0c:cd84 with SMTP id
 e9e14a558f8ab-432f8f81c02mr8604245ab.3.1761682263781; Tue, 28 Oct 2025
 13:11:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:11:03 -0700
In-Reply-To: <20251028182257.xZmGA%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69012357.050a0220.32483.01d8.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_log_needs_flush (2)
From: syzbot <syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com
Tested-by: syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=11b2dfe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45603f6730eb4fd7
dashboard link: https://syzkaller.appspot.com/bug?extid=c24237f0eee59c0c2abb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11db57e2580000

Note: testing is done by a robot and is best-effort only.

