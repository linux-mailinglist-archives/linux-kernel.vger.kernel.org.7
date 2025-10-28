Return-Path: <linux-kernel+bounces-874559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336FBC16934
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA7D189B751
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE9A33A036;
	Tue, 28 Oct 2025 19:12:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888C25F96B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678726; cv=none; b=K/s97D321U95f5w5QBStFTOclmRfJLEaTALg0tJuQ3KA3O9PcTFnc8bvDazqi3i2RYuGisZRmseLI5fnV+TUMcjD11ixGrjvcsHbaqGgpoiIO5uq1ryOPVY2b1hMZDtYt2VlYhSrWsnOud+J5fE0Lbp0A+oBK+KJvnSd4SwF2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678726; c=relaxed/simple;
	bh=YWbyk5M4ogi0WdzESfZ4KSUgvuWgpeCqcZQYMnFGh3k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pWA7fihodAfqjJar8LLLgH5OU58wFhvi/CLcOyG9MNol8yjMowdlLeYs+hAGm0ZpejGc11j+fTRSPrH6CnLQiwC5yncvHJ6E+QSUZ3QuQ3FI+qwbF50xOlSvfnLXa03ndvwLT+VivX7+O1vl3pRmjzeQo+b8LPRkVniRle9RP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430d83d262fso250047445ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761678724; x=1762283524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tFzHYZEaLPIxaN//ycb7vrJsGofeKIsFQu5nLaTjzU=;
        b=rj8SioPo7FiwNpUYwyle5eNuiagtPGNQkyf5PaESL3VM+mVzxwWnyY4saEd4Wg8jrm
         yET0yIWvjEoCt06RuwiiVJlXs6TwrRoWyXq2nhqwqCOMn3TuY8S7J2GKziBe6Kh6qkXD
         3/fJ9D3CD+gRRAd02toEsA6Jmgzl/lEv+DA7AZZOrRLU5LUFWfZrWf7RSWSGBHVAOjys
         mYVxl78Z4ImWe/pLgnh0N3sjwPzm+pOmBzfHF5xaN/QUuREiOkjfsZL1UQQnAnI+bJ46
         h9rew9GWKmjBxP2qaxKuhZFalJWW3MtvmHEYBUItb+h4Fau1TfNK8Fq33f83qOceIOqZ
         L46w==
X-Forwarded-Encrypted: i=1; AJvYcCVTOntNZyKXJe69sCiJ65cYlzmS2JDGjtMnEdX1C6PFF4D9Cx+T6Rs5WH3g6dJ8SC81lkQFMLpFv9po3rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFxv8YBdZRpSObIWrntqZAzthUrOjMJ3gtpqxgYZMjW1cU4Pqz
	KUnMzodaNxpDM0OzUW1O/O4oPFmO/ibp+nh0s0aV3MPhImTPE27erZ3eeGm8/9Iz8zDyUtzKjZk
	XMHK0NMK7nBXvQBhMfwbs5UpX8JKqSQFqJH4gNqIc+cBbxYyj3X7YGOByyi0=
X-Google-Smtp-Source: AGHT+IEUHTEJWwpEuSkpXyuchzO3/Fa8QGC8miJSmr4Ce+9vM2XhO377Gi2Jl1JTkS7mJHAqfasjDGLLs8nq5H67xuXGWxJmU6Xy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:89:b0:430:b167:3604 with SMTP id
 e9e14a558f8ab-432f8fc7f31mr4961805ab.4.1761678723804; Tue, 28 Oct 2025
 12:12:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:12:03 -0700
In-Reply-To: <20251028182109.Pw_cX%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69011583.050a0220.3344a1.03dd.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
 (2)
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:472:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:487:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:500:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:644:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:657:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:805:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:941:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1028:39: error: expected ';' at end of declaration list


Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=73696606574e3967
dashboard link: https://syzkaller.appspot.com/bug?extid=ded9116588a7b73c34bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ee6932580000


