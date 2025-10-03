Return-Path: <linux-kernel+bounces-841158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EBEBB65E4
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D2DC4E37ED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456FE2D46BC;
	Fri,  3 Oct 2025 09:30:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A72C08A2
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483804; cv=none; b=nsv+gUQQms6kfrPqFLOO8JAx6mMjgKJDdDHU+DpFFG3ZDUXMkDBdNExKhvFK/Py//MHc27ArteNa83rJwHEGgEfhInm4Pw3TaPwjhPxtYWuQTtQx0IYj7B3s+CeqTivG7WhrSFIPvoDQuQqwIFp0KzOPv2O5Qt4qeYw614G24YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483804; c=relaxed/simple;
	bh=ia0SJHK032bGDVqi/okj4bBSHNyMSCgQKL0zIzH+mIw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q8xohZXA37rt7TOE2V5b9Jf+/Yl7WzKUzvyeU+ph2HxnN73Y6HQbr8VlKD1PJQ/rAhv+2gIOf/DPBvudlESoFQXalyZeciLjNgTJ4XRmnq5OemcgPIOb/9dJCEYH8967P8nhwRxnNM+WFoVWVBd2F/RYEgd1aO0I+hKWxWzHx3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42594b7f324so35115155ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483802; x=1760088602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50QdBzeIqr7aHf+gPBU34331Nr/bKsv/YcBNVeBHNaQ=;
        b=GDlIFsEthsBOELzibI96QovPs2Kpg0gZlBrGL1B5GyHrwd47uRUIMVctbnOJ/2V6Tm
         6+TGRrr5E8XOLhRM2utl63xjHnsOtPRjZyNQHk/H23nCLKWI9+UzF4RXw4Xup1JcNqWu
         Ls5QMDrFVNVGwUfx61Gm5JpgzjnCqG2vHKAVPr0102Kw6nNu8BeHTgAekEUSFU2GIS3d
         s4Unv8TNxgmHF4OrOkZ1MGGD9zcQ4Q/gn8kMBirsRbFJF3jwQr4YRfMFMORKxDKzkic/
         sngYbtM1Y74oNpTjCEulLjnrr3nL+og8qJuJ6oA/l4/+zvOqHNpm7fnjgw92r7Fz+UO7
         dkLA==
X-Forwarded-Encrypted: i=1; AJvYcCXuBtGJIvO4MX9eQzRNBS3SjO1VmLUcG31+ppqK62uMv9ey6kxKTngXYnq+2sBK9ZN6hLWuL+hvoDtFgfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/1M/LJ8GFqTNaTtFGZ3/N4J5toKn/P6L91L17GONbpo9tuWvI
	AcCE5DymAnOssEwtgV2Od8APeDVJONtz/Vp4yioDB7eXf05yS+SUTL03kEhA+SIvX9AK/e7C/+a
	WTXfE9NKIuE3P1MKwYan3P0fDIAkVoOKIRNZgC/zCG25eTqderPhcyGVhGqU=
X-Google-Smtp-Source: AGHT+IEXm2y1xmZgvG3zjRhB0qTc0brSm31zIO3zSF+HReuUHme/Php+VZscRPPjjn6nXErf5ydBB0DxroyZskuyUe1a4zhnTL39
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd82:0:b0:408:6044:8d1a with SMTP id
 e9e14a558f8ab-42e7b1ad923mr24437435ab.5.1759483802641; Fri, 03 Oct 2025
 02:30:02 -0700 (PDT)
Date: Fri, 03 Oct 2025 02:30:02 -0700
In-Reply-To: <20251003090932.2559979-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df979a.050a0220.2c17c1.0021.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com

Tested on:

commit:         e406d57b Merge tag 'mm-nonmm-stable-2025-10-02-15-29' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142d76e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84e81c4d0c0e900a
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163e9334580000

Note: testing is done by a robot and is best-effort only.

