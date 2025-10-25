Return-Path: <linux-kernel+bounces-869861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC2C08E10
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4238A189F8F2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250792C0296;
	Sat, 25 Oct 2025 08:47:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6632BDC01
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761382024; cv=none; b=WHx0yyTZCRODs1mFJuyxcnSG8IGCoKw0z6HiQAHrjre/h3RNdjrFO+TmEvZWgka3wGFMbuvIsX7mVUfsMjI6V41792xoInMIHmMyNym49I9SWKvBJKa3GjLr1NA599KLtpzJ9sN44Pvi6cY/gp/IaFefXcgzNj+hI3ZCTccljeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761382024; c=relaxed/simple;
	bh=b45ZZ2D+y1QGTbiNMTaxp5mHB9oFCFrL6u4ByrZyX5s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k6E9jNtgfhUAJZ1E2Gp9TVRvr26rJfZaIw/p+//9y1Ms741tXDf0AiJhkYHDB0DA8sNwFpYqiMD14eHp6F+BmCRUGNCJO+kBI/eCQjmubboF4hGNHDh4tbwiB0CmwEcaCFQ8bia/v4TQIefSpldu0C6esklQIdfXVB9Bw+liRQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430da49fb0aso78017745ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 01:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761382022; x=1761986822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MPCznad0VYchQkolNt56130eXg9hyGT5xJpNd/BCac=;
        b=RfLq4y7Oiv7sUtPcAR87ZteuCXHwE85JeOWuhn9muWamkMpe7EhuEQWvkJ741bu9I1
         o4+HfDGPZ6+otuXV3VyqAU/2F6gKGSCxf189SpzwjP7XN2ebOw8GDxc2T1dImXGK6tnh
         RwUATZ1IRLW4cwhylmBbogtWwGdt9ICs7qOUG+5bkkLiyu5wUb7c52GJ+mzMPAUg/l7w
         5QMR71trgnb7K6OwJPvYx7ZZaJHtpwIJF61yYoDc5yYJUekx37mybkm6w9QNN7za5+lB
         ACMB4C5WjoeF6181wuvTYWdv34gNKb+O4m52UVwSuuflGFG1KQZFpU1zk/dxsiy/Nr+u
         Wfsw==
X-Forwarded-Encrypted: i=1; AJvYcCXrGruTIoCdcARcTep6MKwDaFkoBlL+sXDCyzxGo7XZDhrk6+e1+FH6gUwWconLTgAIZyBuAtAc2K27Rx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8smYZWOiJlrv0MWVTVtOeZ3b2X3Zl/Z56CrLqEGS/iJrhwEXt
	Os/8WGJsKMEXuK93BOjO6dzbNn5LfKZCz7hwLDXkZBNqI+EcuI7PnNr+TRf6qzc7l/4F/9Tkw/6
	W97T79ElKeyJ495tOyHtWhvmrVxdDgF0darRxmAoDh8xI0A1aUkIRMy397Zs=
X-Google-Smtp-Source: AGHT+IH7QSO2J3ERz84ibzJgXd4/BX4qVZ7e9EFmX4cIDKjxgw4WCRsJhAdhdySshmvh5DmvSO0B2aY4dfGFLhGeZQ73U5MXb8tX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:238a:b0:42d:8c07:70d2 with SMTP id
 e9e14a558f8ab-431dc1663b0mr129970525ab.11.1761382022507; Sat, 25 Oct 2025
 01:47:02 -0700 (PDT)
Date: Sat, 25 Oct 2025 01:47:02 -0700
In-Reply-To: <CAHxJ8O-1sE7rYwF9MEwc0Py92uZtHjQSf=wcx+MGFSTJ1wXZtQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fc8e86.050a0220.1e563d.00cb.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] WARNING in ocfs2_unlink
From: syzbot <syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com>
To: eraykrdg1@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com
Tested-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com

Tested on:

commit:         566771af Merge tag 'v6.18-rc2-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c65d2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc5bbbfae7909024
dashboard link: https://syzkaller.appspot.com/bug?extid=55c40ae8a0e5f3659f2b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=114d6e7c580000

Note: testing is done by a robot and is best-effort only.

