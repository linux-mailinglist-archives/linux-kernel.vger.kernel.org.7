Return-Path: <linux-kernel+bounces-843031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 008AFBBE3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2458348467
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C16F2D3A94;
	Mon,  6 Oct 2025 13:56:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2026B2AD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758968; cv=none; b=n1fFbB80l+5bi/a9SNJWxtvQJSyekUWcvjOI1lN/JzDM60DvNqiBDVUXi02A9qdPxe2mrAAlGhtzEg1J2llClR68ZNW4VU+PMUrLsaA+EjMeHc/8Vi3fYDUYsvRDi8OMXJVu1g6IbDB/VaE1dLwrzKr/N1akBnz2T1wf8OvOTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758968; c=relaxed/simple;
	bh=hvnFTWtXYxAYwiIl3NINdSip0PO+EKJuTi67PG1cy4o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T6yjRL5WuCqMZmP0LGdGSo8zlmvuvJ9iQ7NOi4us37bq7yr+BnBMguARaumDkJmVLEg2HWsKlSX2N2GoBYbA3AZs/KCKKHFTZ7HIrM9GZBpECkl5CTef3RYhObiqLe0l3vW/QgdVfrpu+D43SjPAykWQKt/d/fq1vPaaeBzJW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42f64261ab8so66422795ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759758964; x=1760363764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmhtZKPL9EpyZMFM7g4xygudUhkt6cXpezwPi/wRWns=;
        b=vGL48TjGbpc415x/iSlt5DoLBJdMtb2v5Sj4abbZA493HGdu8VpcpHFVjKHTm2HHwh
         KOY8gGKB0rTKfM0PbB8Ks/c5PhWVztw0fH8Po7PPIbA6n2jM21uvKifMOYmfT0jwaYXi
         gg4YwOc3iyEnXR49qMcd4LCnUrDPEwjIbOwHW/d6sHJkcUscdi8R9pCjnLprx84gm1jL
         l4g3Ls6Eo1RL3B3ZomxU8eA2YOlt9kSgHjRWVCPJ7XtcJQgdUQT+uu9ANDCnmYJxY3Vt
         g1LJGYiG3W7XL7zDWiBdeqia4oH1xVJ7mn4jy9Oo76j7srtv8g1/Y/X4LZ9rKLPt1zSC
         9kEw==
X-Forwarded-Encrypted: i=1; AJvYcCXbhHPqk2YsUPL3/F6qt03woutVZoAMoJVHt3sZB67465i3yaZzWXNDixgMYKwpAkD+iw8isErdC5ibxa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOD06UfujV8xHyqO2y8/SudY0zgnKp85hqqoPqQp7iuHVt9bNP
	SnLf6HfXQUn+iNFnzXbSJPZnTjGivuDLsxUi6QGji0V4QrrEJe8PCXBaOQbLDSKsqvOMQVMxWfk
	gvPvsU8FtrHvQ/sK9jOBKHtjDDVOa9xycfeXq/NzqnknPM/S/v1MJNPY7QNM=
X-Google-Smtp-Source: AGHT+IFQvm0KU0WPfZ+CWR6/bv4QqeKRfWBJLs2Oo2UkS+wj+n4Zt6zOS6sbsJNuJs32XNMOb+XaZ+3UswvJ8IdfrA9f/k8mXF1R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26e:0:b0:42e:7a47:279a with SMTP id
 e9e14a558f8ab-42e7ad16edamr164696685ab.8.1759758964489; Mon, 06 Oct 2025
 06:56:04 -0700 (PDT)
Date: Mon, 06 Oct 2025 06:56:04 -0700
In-Reply-To: <CAJ9gUkF5H81CWD434JaxVb1+6E=hmBfOq9dqb7wubyU39Bsdag@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e3ca74.a70a0220.160221.0001.GAE@google.com>
Subject: Re: [syzbot] [scsi?] UBSAN: shift-out-of-bounds in sg_build_indirect
From: syzbot <syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com>
To: kshitijvparanjape@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
Tested-by: syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com

Tested on:

commit:         fd94619c Merge tag 'zonefs-6.18-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f8f942580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=666754c6a9e50ba0
dashboard link: https://syzkaller.appspot.com/bug?extid=270f1c719ee7baab9941
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147bd092580000

Note: testing is done by a robot and is best-effort only.

