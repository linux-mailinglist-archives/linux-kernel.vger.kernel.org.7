Return-Path: <linux-kernel+bounces-874629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC4C16BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5D73A0FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D721434EEF5;
	Tue, 28 Oct 2025 20:10:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0539E34EEEC
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682205; cv=none; b=Ell7CMw540/6sL1UhJ17NrPT6eItb3EbDTVw9+CSdT6vYHA7sFKKncXBqvwfUHWevIdpwqErQFZYBRyYrEhaBG8HBu1hYqh3fspcPUTQkSTRthT3+hbPGQLXB2aARCa82cUKPhSi5mxytrWC6n6qRCnTDfM1EfQadi6Vq57iVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682205; c=relaxed/simple;
	bh=KlmOEm/m3sggah9RfhxSGNjyvJTPHcFzo0cUSFSwwnM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O0TTLZd5b4f5w+8WxoYkIMtah202bIcraQ7P0NyLDs+F0ORGfNubXFyYsau7xyZ5pVzaUNJjkHAYPSlt5iuu8OjUIQdnanEUnmmYm9zlHGBCFkLdJZSkcnb/cKOA860nNVl6bfy3nkigKlegIvBoLdpAKHDNWhPgbhOgpq8jsVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d4ed5cfcso230428155ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761682203; x=1762287003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+QA36rQgd6nYl2eUbbgQrJD6I8mgpFcF//O24FY9qs=;
        b=CvlyB5o8S2lkIJ3UoJkD/nZNXPWiayld6Ijcj9ndHQ79l3kbeu/UDlec17WKw6eeUC
         9uGlv2AFPHBKf+I9tLrHKJroeVmTq8T8HPRrYQvVJhnMgJQucSsN6soQfb+UnDCrzQy3
         sjU+7NsXYL0iXOe7wxFNwxK2l9Wgsx2A2FPeOK2WvPandQ7SKRD9xawFAO9OA2GOHa3h
         GqAwcpSt448Ph1T+BEx0xAvaHCW+Q7VEr+u168vCjL/jT3wxqlxuNTEhjy97xV3eFMRX
         oohDin6OQpxCGme1el22dd7blVyqIxCZhTjn9qb6cpcRF5CGtxIHbCJAkjHYTKNgU2pN
         1HJg==
X-Forwarded-Encrypted: i=1; AJvYcCX3/m68LTg4vE6TJYPi6K1b8YRZg0sQ2Ehp98NgVsNa/appF+LqCM7bEnsu+SIDmyjaU46S1u6/YqvEeYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAihGhG4lioWm6k0/LDze5KoOaKkweZx92jniDFNGhZYWIfGjQ
	exCGDK1t8bwOKPHeE9/Pc1eYu32JP+9K1FMBdqiv2CKJBxqCLTrklMPhiuYUl4CaQNgXRKfH5Ym
	yxbHryqehyddaihc0jv+khTxSnYmfBS3QWCTWmDX4QIJ/J7eMtMEn0C+g8FA=
X-Google-Smtp-Source: AGHT+IHlvLF4/+dqZDnIFdcqqcH8caAQ0ZHhbMq/qCIl30BMGGYYUife1+tjLvyBl0EECjEaXfnXe1JmU6QdGDum/njh3nhjVgda
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c2:b0:430:b05a:ecbe with SMTP id
 e9e14a558f8ab-432f8f81b08mr6792965ab.4.1761682203221; Tue, 28 Oct 2025
 13:10:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:10:03 -0700
In-Reply-To: <20251028181942.Oxouk%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901231b.050a0220.3344a1.03e3.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:474:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:489:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:502:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:646:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:659:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:807:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:943:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1030:39: error: expected ';' at end of declaration list


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=1234f097ee657d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d377e2580000


