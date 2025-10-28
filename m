Return-Path: <linux-kernel+bounces-873537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3C0C14267
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F6B34FDEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84593064A2;
	Tue, 28 Oct 2025 10:41:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE23043C9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648069; cv=none; b=smbojHMiRuW70h5Y2LkqjuBwWpqlAhsR6zJcLU/nL+30crs5lJ+iLo69ELLlYSmLv6ZaEja3iXLkzevDGR9AbO3PMbayqgprb5oiDudJuESK8vDS/skrF5TZpcYGA8h7WbCyu52fns6WjwK3zDRByhHbAfw1fKd/Q9hu5rujo0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648069; c=relaxed/simple;
	bh=IUMePCtlkRqFvGftfQekGaHzniI4vVLDQNcvvEXZVgc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eIjMaHGILSiiwqhrCl0ziWIGLgO15Kz7LTdUSgwuZEaegCFbBr1SLYvyWj3OxqApPS8bkhjqX1tqNEir/GTWQwr/oms5N11/n0og2zH2AYjxKv4uLTref6bzPbT4JQvp9buIiqh9zLpLFYfzUMqU6Fxj3hpzXZvO/O57Xbhr2JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-431d8643856so239958785ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648065; x=1762252865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47UCet0UysTh1gYK+o/R3YEPNCk3IRCsCH9yuC3SxZw=;
        b=cg1+lGFQOPlswmIuUg9lwKCmOUioUr4M4Thz2e+OILCP45a6al7FHx4pRzXJ1ErtU4
         RV9yQsQROS/Zmb490qI1oSEB0ZjDxpl/bs7QwsScKbgpvFS7hZNsOQUxngyTTEAOOTEu
         6bJL8oJxvwvJob2worYGHMGbd2s4ZeIyN3YnAThEasEPZjrsSzEdHFMc696Nm5MHEpdZ
         X66fpEMuHBUxW80y9y9ZpmbFdjj6zYGzXVIC+/cX35fAOdNXOZ5AZ7ASjc62V2m16QHN
         WCbTqmCPbb8j5jqETFaCEtirOiUEJCuz8EYcr6ZzflQivZhe/l3YeU51DSKLRvlixTTA
         xsRA==
X-Forwarded-Encrypted: i=1; AJvYcCXVGfCttFFKwib5LSrMxGUO4QVNrt5fU5bWcy5eoYBcpWpDdcRRmxBC8FdLabc0vrCY2xkCAhRmV7qwaAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaOZQloFPuXA+RYCMGrp8H8HQj85LkI+xaKeOZCnhV/sj2uUos
	KrVfSU8q9L+ymhflAaFFkTXiGgwk5EJXqPfEdMcNKExOa7sAO/RhJ8DqzszDDaiyTHhE0S/CF8b
	D3fT9eLBUoqW4EjO6lB+acTis0EGcsj0FqfUvxco8zwez6Q635jquQUBHGxc=
X-Google-Smtp-Source: AGHT+IEFZGV0ZS55VdfCQ/uLskbfBVQ3VoLkNXTXHggO86XDeXKF6G0gIkFS8d36ZPa10rknQ1vHzzqufiJd+cKDATyWyHyscS8N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:430:ac4a:4dc7 with SMTP id
 e9e14a558f8ab-4320f696048mr45637965ab.0.1761648065131; Tue, 28 Oct 2025
 03:41:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:41:05 -0700
In-Reply-To: <20251028104003.OE-Gy%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009dc1.050a0220.3344a1.03b1.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-5.10.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-5.10.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b46932580000


