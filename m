Return-Path: <linux-kernel+bounces-875273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AC3C18912
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 208D9347F98
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD15528850E;
	Wed, 29 Oct 2025 06:59:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1069A1CAA7D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721145; cv=none; b=giZP+QUjE42tWS0TUQ6MZ+vPwY2RLe3K05gPXmvo6/zImmD7qJyFzzmYe/BawB2ZZt2tTkkbemZlATI8zSJIbhjmNWpTahefXl0sulLdnfOqtjLh0p4kw/itF+ynmLfWjhLwZl0zrUYNbjqpQAPhRwt3+h4FVtMa4PC3UwoLsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721145; c=relaxed/simple;
	bh=SZwktRDId1iKXooPQEAzr+519npUY+5W9nYaeNaG7qQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OIERUcEtWgs0tdzTnQyrSBGHCmJf8B2QKJFJMpMatfLsMpTJfFcR169ZGbI89qcF/HlS/rvAdE/WZjeZb5qkqxuy0P+9WabOwS5n1fcu6kIghV3AKJ0O34+MVHr+Z0Sf0RhD1PDpwM+0H7XhVLgjdknlctXZFP2Tu9+FKLgsD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-431d3a4db56so295350275ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761721143; x=1762325943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZwktRDId1iKXooPQEAzr+519npUY+5W9nYaeNaG7qQ=;
        b=ghUQM0/t0LxvZLbyqhoJPw/N96TfrHF3n8gISKxchEiJrqol3XGytIEzIk7jPBg01H
         GLwTnAA7vSquSlqp2UDZ3YqMfqYEeSgn7dmdAkSRsFHdrjcJgMuG8ldKcTF+T/JqrhU+
         ZOVdeHgRj7UtQ/qRTYXnzGdr1HxfqlC7HvYBrLuR2nXTYfwAeukrNu9YVG72lRKrkIZj
         wzH+iyO8nID+O9kxcV3S4Gy88akzrQ7qArqQmncXnbpH32QVnPz8d3wsAzqskX3tsCdG
         ODaho7uw+z/nAU6oR8f1sNIE2/d4aYEl6gBwIvd3/Vm7IUClRvLdDuAx5dGyOIQGGvIB
         /ahw==
X-Gm-Message-State: AOJu0Ywb+DYo6niOb9Mgg8L8x2lRNrMb0AR9mnOKdDqL+WkTflsBXV7f
	Mgb6c4gvnySZWwJ2hRATjZvGQrdoQqdHWS9gFTgs1U0j2w8FbGUdpuQaelWjuZ1NpbP1XLmkjbB
	Xp2rjyL0x08HYblwdGjWrGVfXtnCKi3J0iRj80oqyq/qezBugakMxW7d44WY=
X-Google-Smtp-Source: AGHT+IGrEhMzMgWwPc34je3/KPRHG0zGU4OOhqB/xW+LgoF1Rmm03g4uvt/Y7ywccwCcrbjOKEd2XuFkDepzwZvEi+mcSOY1oMNj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cd:b0:430:ae12:c5bc with SMTP id
 e9e14a558f8ab-432f904afcemr22323885ab.28.1761721143247; Tue, 28 Oct 2025
 23:59:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:59:03 -0700
In-Reply-To: <66f0a364.050a0220.a27de.0009.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901bb37.050a0220.32483.01ff.GAE@google.com>
Subject: Forwarded: kernel BUG in ocfs2_truncate_file
From: syzbot <syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in ocfs2_truncate_file
Author: albinbabuvarghese20@gmail.com

#syz test

