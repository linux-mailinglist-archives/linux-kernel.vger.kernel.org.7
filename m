Return-Path: <linux-kernel+bounces-874541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A1C168A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F210918950E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B422B34EEE8;
	Tue, 28 Oct 2025 18:52:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35CA346E60
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761677525; cv=none; b=ZZQjDE3W9I4nhOW073Vr7irvdXupPV5Rd2tavttITlwtb2jdtPVJsjohE325GE7rUSccUcaLkBUw7XrBNVSfQKHoUubUQzXpsK8pDrJ+Jzi5la7NTNdbZm54bo6JYiJCOKWDwGG/Xw6Trk/VluJIvhdthKAEUrnBYoH5Kx3v6TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761677525; c=relaxed/simple;
	bh=l8SWDxHtTJSd6qkBhsJv9gB2l2+mja2DPKU7hoqkXGc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nh994gmQFsIoqazfl69uRyz0aWvFrG56UCZuNM1wCUplY0TRYyPz9WzVl8bex7Jn/gDHY8u7YEFbqDj76NuFz2N8fyjVS1jHxabaYVROGlM8IOnDrsbkjXBzcokWO7/1UTWhTlkiloUZgIgLVV88L73X8piifZwt2YbzxcrBgTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430e67e2427so86543085ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761677523; x=1762282323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRxB/AMAgAQcL6DTWvD+Z3N8CO1/c2QJ0QvhG43gQZY=;
        b=Q9hBa55bdzCGHXOE2rIaVtt52SK+Ovnr/XrF3IPmZWVkPYq1/gcQ5LrM8ubz0ykyPf
         WAoYe2JjaXUBRrXs6HY2+QPycCzowlvWchfg2bJO3JsJGMqmBXpQt33mcdiourDLCkOn
         8z2zIUVdzSBgQz5bI3vODVE/8hIvO3xE4gDOycdYe1c5FPcJmkufFhZkGg+M7hfYEw2t
         odAWzso+D1hQRune0V5Rf5bi4K3a0YWtSNgBSHcoQfdLt83HuwzCeFiIjON14G+b3UO/
         /zf+Rz8r/HY4IOGk//VXWBpMGAkNVLJW4O4+qO2zywNyMsAkDQZv3c8yG5DsesmwKFAb
         Geqg==
X-Forwarded-Encrypted: i=1; AJvYcCUOI/ttfie4a4uoOuhLsJeqJOU/6mEJ8Lqxb7m+MjORLakGEMh47UN5rMrfB/Z4R4nhkRXGG19zy1a42MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytp8qD/s3HjeOGUsdKkMiiuTrbsPIICOsiBNR2aaK1XuEAECVf
	ZIJHFuCpEgTdoogMsBB9EEYJsW2zm5TcVvkxv2/nf4WChBxxjoplmGOwrUrQsPEqoRBA1kTzheP
	NPRDDJaBOkJEfQ0qh0BPlg1D+fWSA7V63PC5ca8OxRUcnkRBllmLX4EvuWhM=
X-Google-Smtp-Source: AGHT+IF2q2mvZnfaFP1Hqb4kOJrYS8v7pLo7ehACrgT+CNmF3a/bg0FRNi9McrCdeaURrf3pKtaV1y6U5Rte5og/t4cKw2l7HzC5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3420:b0:430:a793:88d6 with SMTP id
 e9e14a558f8ab-432f8fac738mr4776775ab.13.1761677523229; Tue, 28 Oct 2025
 11:52:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:52:03 -0700
In-Reply-To: <20251028182101.6rEOg%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690110d3.050a0220.32483.01d5.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
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
kernel config:  https://syzkaller.appspot.com/x/.config?x=99cb6b007a8889ef
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11584704580000


