Return-Path: <linux-kernel+bounces-897399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5594DC52C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9BC24F4E94
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB792BD5A2;
	Wed, 12 Nov 2025 14:33:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E472951B3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957984; cv=none; b=VgF7ucpGLBlWblb4AM4v7vEAaTmI2zV+eCPPg63SrFeA/xeiUGaWgZ20QQaW749VGvheBwCDC5UxgPMXW4eWtF6WqAT4Cl4EeneR1oWyRSe5h0ThC5H+vFZax9//F7R3Wm5DLyQt4FIWY5vdG265J5eOoZiNiN5x0q9INwHzXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957984; c=relaxed/simple;
	bh=xevvpHX+08DiyYBAMRUx/o/HOGq9xL+xSGbaqSPW8AA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gg+HvpuSuWxyBq6t6b62MTJzehApck1YLY6k30SM7CnAr10LZr3RMvqbyjobstDr1smypmZRG29uoRzY809LSTEZbW8k+WWI4iFCSL6Hqfp88AN8yan9TJKkdAUAcLiMt/FtopoVMlcG1vLZxxPSSDL32iq/1xyZIYgOhMFG0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4330ead8432so9274555ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762957981; x=1763562781;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnZ4o88YluoYLm9Oo3DgIQgQQf8WpGAkivhIZEhFU+A=;
        b=GO4DDpOc/rkJ1moKQSi756QI+3TFHeoBQx+5UTo9xZoYQaH7xRCOZls3o9CStBtrJv
         1PIi98go0WwvT/mg6fKYr8QFKgvdz3rDMNf5lbTp6oTpWhx9SNXHoycDBNDkE0WQjmzs
         jmeINCKdcurwJpDWXfTWRqSD7tLN7HNxZfGXdwt3orfZukBqSes0gRa7P1qpRFlkewtb
         JAQQ+1ReqLJ+rNmd/4eUVV172VVM23yXOoEamfK18s/N/y4TagqsAzg63NRwxPkhLGUz
         b+KRREOm9uTbORHya6gWjtbFpMSrLRsbX1OJCnZHrSiFx1gB8ljLM6wNpHg5Gf+eWtS2
         /ljA==
X-Forwarded-Encrypted: i=1; AJvYcCV0uHOqgo8XjRo6U+8wROx26GpmWMNR+1BD0APC1s3NrGsQ/6Hpy/lKO5YY9sOy1ByngMj+1hhGi3yuaCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZDB3zupSbcHqZmEj2AZPbSx2mXmVY0GwgvMDpmaa+WAiDPQ6b
	b8/oc1HzfpocQUtXOJu1C5PtwFxvFUYDOafUgOv06DHha9ELtMVuBO3hiSOf61pFuR8qpSkGbt2
	gwJiSeyi3IPcsq+oxB51xMzOmbzJcab2X/F0aB5RGAJnvO13h+QtyvK2VlEk=
X-Google-Smtp-Source: AGHT+IGQoCSdgslJK3TS5v2MOWxkSq62xdTioOSd0saNTn6KUmF+0YLlshP+oFLvZKzn3GwLVH81VBgMJOKjolM59obYGgk0QV3z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cc:b0:431:d726:9efd with SMTP id
 e9e14a558f8ab-43473d1b84dmr42415635ab.12.1762957981718; Wed, 12 Nov 2025
 06:33:01 -0800 (PST)
Date: Wed, 12 Nov 2025 06:33:01 -0800
In-Reply-To: <20251112124054.2318311-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69149a9d.a70a0220.3124cb.0003.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] KMSAN: kernel-infoleak in hugetlbfs_read_iter
From: syzbot <syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Tested-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com

Tested on:

commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118dd60a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbf50e713aaa5cb0
dashboard link: https://syzkaller.appspot.com/bug?extid=f64019ba229e3a5c411b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e617cd980000

Note: testing is done by a robot and is best-effort only.

