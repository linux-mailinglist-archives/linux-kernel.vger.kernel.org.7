Return-Path: <linux-kernel+bounces-887998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E445C39870
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479443B82DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE763009F1;
	Thu,  6 Nov 2025 08:11:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71FB3002B7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762416665; cv=none; b=FKJpkv6uE4UTYojduPebXc/uT4mTEX1Owt2KDNmeO/hQrLKPEVMqjdezrh10JQdeKHRseoVtW1iJlnW48mz7580gBErWSoBD0GotiL77EbR2VY8G7SfgzU27xEpYau6CKmGOuuVDVHwW0CAE1QlmUdaOOkcQKDxcbBgOtK2s1bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762416665; c=relaxed/simple;
	bh=wvOXS2QMcbHUIYNr2DUBkmLRmV9kGxlkAaJHbNnSg9c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HqR8S0dfHxOJeoYIbHsWnPGcer6mb4OK2uNGotWPAa6xA6ItLVUv+V27aZ0268AP+30EDtqIYw+Ji+R4fD045O+J2FNTo4KQo7VsGCn+C87bU4uKI1RIDQaEn03xNf2lYXWhQRhTr1O5mlL1hCzKR3jak3IlIWyAm2mCEfI2e+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-948610ae935so6619739f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 00:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416663; x=1763021463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eqf0fqA5dUIe9t+BiNYgWEZW/paRMesfPdsOCjy5yMA=;
        b=ZeroTUmgvtFCCrIoy+5UK1EHToTvIf/3kxvDP6FpSXXULQsELmGEku2c22U4IiJT7D
         NyPofCeX0vmxISV0UN6rMExo8xjaK3UQJAuroKLxgYIt61En5SMpsUAy4wygJ/UrsRVV
         2KadK6sTCnhkhwSqwbn1bd+NWcCVYG9RmzVx80BrRIUlvD6K6G8kH4vR64pEzepHMpZm
         jKNu+V6fQRTsH0LsmZPWe++XbV1nVCGLFtwrTLXIhCtQijA4JWvHhG5/j1y9dyQZfWxx
         oauP8O1qJPTuc3JG3/XEim/7eBm3t4roOlJX4nLJBBEcsQXSo29gdUGBwHs8X4O7Lsvp
         6A8g==
X-Gm-Message-State: AOJu0YzLEFbnwiSEVi9AVdJwsiQj9VfPt+Sa8jjPe6ivqEMBZsjPw7bX
	gPPnsPe+5SN24Tmx/M9s9SoNvCsVTV0ygZtO4sPKybzTcTXXRMreN7IB5FyeRAjHeZrVtQgq8dZ
	oJyDlo6eMRSuDUvUZ8hz8qWA+n1hD1LN79BgiKm532XSI+D8RRDG/fEupWjw=
X-Google-Smtp-Source: AGHT+IHczfHheGvFp0PZEPJ3Ofli+WbiLKje1OBoFUDUjZimn+BFmfThZru7Rax4vK7lOgAD+Yv/op9X5SPS5xZVA983/cP0axAz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c8:b0:945:abea:9f67 with SMTP id
 ca18e2360f4ac-94869d22d17mr872521639f.5.1762416662858; Thu, 06 Nov 2025
 00:11:02 -0800 (PST)
Date: Thu, 06 Nov 2025 00:11:02 -0800
In-Reply-To: <20251106074957.2742443-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690c5816.050a0220.baf87.0082.GAE@google.com>
Subject: Re: [syzbot] [sound?] [usb?] KASAN: slab-out-of-bounds Write in copy_to_urb
From: syzbot <syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
Tested-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com

Tested on:

commit:         dc77806c Merge tag 'rust-fixes-6.18' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16335812580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12764a92580000

Note: testing is done by a robot and is best-effort only.

