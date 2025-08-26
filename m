Return-Path: <linux-kernel+bounces-786481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38F2B35A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9141B630E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33862798ED;
	Tue, 26 Aug 2025 10:47:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6303226CF0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205225; cv=none; b=A98h1tY5PHMWoGZOXSofNRTjyAATg4xYwrAMONyOBBSLb+yaJ5uLuMamwVAx+m56WK3QMirI4bGC2wUsiPi3DzYm6T0+LqSe1tRjV9Lr1+mOwqsbsTCbyOqZZetTN/nsRzwi+H3CbnydEFdZ+8vWCKXKlm+pLUzhdzYSrZCx9dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205225; c=relaxed/simple;
	bh=cF+l0UruSNFa9T/mRmAQj64I4y6hJHLuVhP3qaZXm3s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WB9pgHGVOeoD7VUKuf2BUcc3X5gJca47Vd6u0jBb3Vt7JycOhmJkdedUXN76jJvy1itRRcG6lPKkSMCYVNJindOtdqTsA9/MdQgC2NpM4o3DlkLamUE4x7eY8qQpG99mxND6Smq2gfFTs1iIF1FXqxRIrH971T2DhPkHWwI95vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ed6502add9so15528995ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756205223; x=1756810023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpeDqpVhuFu0oQbJjmkLh1Nlk4LFF/d4j9SXobNWHOg=;
        b=DNZ6UmV9cIWIRWcF1hFmvQEAS9ZyeEUbNhe4QCyMUZ4sbSWQMQRVwXcFRhQRHWOC4N
         qPrG8rGLxJxz3/naa/jTyHaFtcTjdi3gy5RP4zpb8OXoyKWoppXbS7DOVD3YciUKICA7
         vl/wp9qlAE0Gl2MVlhQM/eCiupLwzGuVXhWPWqJvshuAMocSHsbTIk2hXG/6f7i8+bdx
         B+vKwnxj45qGxqKq1lN0JDPB+nziHBeDyK5Ad4edicwogHaE2azGglkntdKZtQjlQoCo
         zQkvG8W9yb1TrVrjZhyYd7Il1yAtEMggcypkDwedx/wRju+oAsPj4dOJ2NHLvh0AWSeC
         tqPg==
X-Forwarded-Encrypted: i=1; AJvYcCVq67QY4EBNnUb+tHQVldAGUv9mDG9pUu16Bks8H7XhdfLZ46e2vdhyWFWgHcgK+jyoezI2XYGj3iaBnTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu5xw4lI0nPwcIdos3PeqkwdVI5h3lYnQICEjHeFd1cj7Ley1v
	LhxlPD7iXPjr7CZ6YfUny2oA8qTpbyqnBF8aLspZIlbz1Bg9Wz9+MCZJwBlOSJiG7SiKeBjlCA2
	v4e8RkXGnBtxBqQqFfFkzeAcn753/H73LtwnaZVcmVUNhcS747Ri/fXrBiCY=
X-Google-Smtp-Source: AGHT+IEj+r77VVnEnwu8eIvfRI4QGUYBSRTWi+eFuJf+95WeOXZ9HW5V8c1qAPfbp0KjH9KQ+N+LfOiOcF3EalN7+gcNMScmgCLJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cb:b0:3ef:175e:fd20 with SMTP id
 e9e14a558f8ab-3ef175f026fmr10002065ab.8.1756205223017; Tue, 26 Aug 2025
 03:47:03 -0700 (PDT)
Date: Tue, 26 Aug 2025 03:47:03 -0700
In-Reply-To: <95cdfe52-cb32-44e8-87ce-1f23710b5f21@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad90a7.050a0220.37038e.00ba.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-out-of-bounds Read in igrab
From: syzbot <syzbot+a77d690840e60bc2ddd8@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a77d690840e60bc2ddd8@syzkaller.appspotmail.com
Tested-by: syzbot+a77d690840e60bc2ddd8@syzkaller.appspotmail.com

Tested on:

commit:         5b1ae9de Merge branch 'for-next/feat_mte_store_only' i..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=145d8634580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cdcc9c8b78c6d0f8
dashboard link: https://syzkaller.appspot.com/bug?extid=a77d690840e60bc2ddd8
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146af862580000

Note: testing is done by a robot and is best-effort only.

