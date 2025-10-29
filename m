Return-Path: <linux-kernel+bounces-875382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B24C18D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4115A1C80F16
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A0E3126C0;
	Wed, 29 Oct 2025 08:03:10 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A872BD5A1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724989; cv=none; b=a3zLDAWLUS8BrmWjqkWJBFHfBFl16/x0FfWdcJoOdmHKFDCwtwSJZKcgffQmXgP9cWfCWK5TdWUWU+RZ6vzEnC72yv7s8etL0b0Vt8HkuDoPFh2/CEXWKuPVgHyqiL1dHBqR6i665qK4HUr401SLeEXBiP423fMRNrDTmBzYbQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724989; c=relaxed/simple;
	bh=TJ3ijOMYsovYWj2x8PDeGndAwDv7wazLL+PEAm3T8gM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mywql9jxzhzzFnrj7pdUcov6w51YZAJ4PVZjWDNt9YbYA7F8MH3fxhfG6RpqaeD1Kvb7baErNMno6z4Na4293XgsxlMFLU+GF3IAErWTyLCDE+5gLLoRZjLoGCiO9a/FJ1zd6YJeGEeq9VHiHwt9s7hVP098iNCn05cNPuvDt1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-945c705df24so87571239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724985; x=1762329785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wv0RiS1HVl3pb+BPuaV/WfQyuYTaUJ3Em23uQSBdCjI=;
        b=sQ4yg0/JGdBqpavrOkydmJDOPAfvjz5Hd2CT3pb4Mk+HRBMWfp3nfOgT2Lpp3lYKVT
         2aDqX9MlVFeu9K7gvCSZX92qFimyUqJnH20pNok6fuzUL6qKHnpL8LVOdDfCV7VUJb4C
         nTL3RomtPdGaoIGclNDI5lg8rNEEdxVKFevi59bt9zXT2PgGSgradcZ1WeBrEeXk1yIx
         hs6S+RJF+IO47h9WSdLcpUaoiv0xtDCSK9Yhc8HDzt1OdBypuiTUDH2Q5ojczzgLX3fp
         0ATKx+u/lskWfohO7IwcJP4Y5OMzqeRs2ZoZim3e6r/FSjCuLawuOgIjgYHuzbjcjuak
         ZffA==
X-Forwarded-Encrypted: i=1; AJvYcCVw/p2wqIw3c2iER8akU8f0DBjBlBsf4ondoY0HMs2oJQKJc/VZLdpV2fPcth/zHcopQbMtPIut/oKL4E8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8PzNwcakwdNyg/Gj4t05Fvl+LOhVyIoWCRIGvHRVLMQrtZKh
	oZQtCEnsjjwDCMofu8SjE6mzi+KKuGEEugMXEzVymVFRHjMQPzXhX/BSaPYhsx3GtKqYOfr7sEA
	zXjVV6VFJEjuGS+wZAgA8oBgHS2RtzAkU9AWpfFgaRBj7YQWyxI3DyCryCn0=
X-Google-Smtp-Source: AGHT+IFT+wp5y3T+cA07De2wBQ8PF8pLvOlSqRnWLX2dafxiFvMBca6PK5dyGQD0V8+cNHhr5yZwotAssAk252iX7qUjEPwgqKTA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c9:b0:42f:8bdd:6e9c with SMTP id
 e9e14a558f8ab-432f8e532e5mr27409095ab.14.1761724985180; Wed, 29 Oct 2025
 01:03:05 -0700 (PDT)
Date: Wed, 29 Oct 2025 01:03:05 -0700
In-Reply-To: <20251029062549.LY59_%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901ca39.050a0220.32483.0203.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
 (2)
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com
Tested-by: syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=12aff614580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c404ae8bce817b30
dashboard link: https://syzkaller.appspot.com/bug?extid=ded9116588a7b73c34bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1763dfe2580000

Note: testing is done by a robot and is best-effort only.

