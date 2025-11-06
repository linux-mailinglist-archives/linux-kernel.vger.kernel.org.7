Return-Path: <linux-kernel+bounces-887544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40689C387C6
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20B324E344C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E2652F88;
	Thu,  6 Nov 2025 00:33:34 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338BE20ED
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389213; cv=none; b=eXCWBWQrT++ZVYuKWR6xWeQHbfZ3DR1RA3RVOyiQDH1n6+I3DSmnvv6Crn6gj9ZAbS2HJCXOR1aLu9dD9JIlTR3qdtD7U/xPGd/sUUK5BN+S7IfuHmjSzhyGZUXwYsRjShV9k07AfIKqTaOoqzFo74zkZ9OZbXbbDjVRVsVTBdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389213; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q8kif82cck2QT0bWdA2Kl/EC3ueJ7Oer7f3nS/wFLTZ8dODTgWoDmdRF4lzX/g8AK/5pEPxp6/J3p6lQfD3pe8E0ir0Gg6/p+IEoS9k+EZlvO220CnYQKA8vySmDtjqwY6Wv71g2fpM1EO4TG8aEyib2NImh4dkXQKD9F8kEpW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4334affe616so4481495ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762389211; x=1762994011;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=mlO+MKEMeqKBCq9jV3sq+Lm4mvXxaiB9DFq1V8OeATqRQA6i7N9yWvzgt4Y/SIEdNQ
         kaE6PkgBnebTRzGVHhTDv6i1idyy+LTYNFNuhSfFFjhKPxH4CkYZ7AGTFz53yiwhLp9k
         rIA9EN+EY7OD+dOJZKpF3SD2dQnPUAc8yo7DYbIljhD2s0Qzl455kbNA2mRCSWnM9e0N
         lLJnwAAryhG86c5uu9Ep/KMcLBzblBa9ETsR2MUqNVERPRfG3Q9eSeWu1kBJCKeaHBqw
         5YB8RXl4CGafgo8ASUe//eyJjNeclNnoZU6RHugjV7zsqDhfPdTohJKrIlJTfldG5yv7
         a69g==
X-Gm-Message-State: AOJu0Yz/FMhgaxzeM/5KXT7mosS/AcKelIW/TlBeMRuxXURoP03D5otJ
	tL3TSLes/da7lSP+FgMdhXhP4F6/c1Qrgl8cgu2dirAT0s3FcuISM7qBIKMa9EbHoXoI6cV1mZX
	ZQKNxnc00Lbx17hkwLqzV5Ej1B2FnIJN6o62kqko7XKBje4tRtxFD15Qa4wI=
X-Google-Smtp-Source: AGHT+IGfg7N2yklpmECIrg6TZ/0/3W4u8pmZJyGNAYsJAQYD8N1RjW2xPvRJNUcJK/fx4dLgfkx2r4wVlQSBdJkhHUtposAIFobl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1789:b0:433:31cf:2c2 with SMTP id
 e9e14a558f8ab-433407905f3mr82075345ab.13.1762389211378; Wed, 05 Nov 2025
 16:33:31 -0800 (PST)
Date: Wed, 05 Nov 2025 16:33:31 -0800
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690becdb.050a0220.baf87.007b.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Author: yanjun.zhu@linux.dev

#syz test: https://github.com/zhuyj/linux.git 
v6.17_fix_gid_table_release_one

