Return-Path: <linux-kernel+bounces-782854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FE6B3260D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA933AB9D1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B001487F4;
	Sat, 23 Aug 2025 00:55:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B762CCC5
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755910506; cv=none; b=Ue7VbkqYW4tjdnUiu8UMyi6ESi3rKyTCKh+ilu5oinPU3llm0kzxDeIyMn9EAZzKGBZs1FAz1xF9a18b6f0dPfEFrxAIZhPi1HNtekMLaIgAPXpKrd9ZFXDxWqDo5wtxcfPpp6Y6TIzm4yOJxF+0xpy2av8asEt4EJAoapGAn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755910506; c=relaxed/simple;
	bh=dwQqBhkiv3gdPqNBg1N//OwTQuhOxMwSaRIXEgWrBK8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Shcfak+h+UULfhXuLq/nl3B8xdalQvtyqGKv+oudBfzeQBzBwr/v8aDX1OD17ozxNVuhyvlLNjrqzPIvknN2kI+7nXwoR2v6Tv4BBgYbn1Hm57Cf56QsH8YqoWHwCKXI0tzz1jpEG/HTqdjgpo0rIeAVB76PJhffpENiS5enMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e570044f0eso66076245ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755910504; x=1756515304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaiZLTdnzU20S2gEWsZVd/beFN16MGW5MuUPgJmjQ14=;
        b=Kz050M2eumRRM7EIwoAblHFsohg5Uae52j52f+F9pASDT8wP36P/AiPGX2gAMEm7Nz
         ukl76bERFHf8mvCGefA1/GdJRGsFbewm/RisXbQh2Z/b1ADyDcdhOGwV5aElMMuh+Lfl
         srbif8J1FrdS+Y7sd/IQAQ0G2mjQOJwBDRL2K6yZDEc+d6ZOZyJsTDky8Yf3l9ztOrwz
         hKxMx8pA3iY4Jj69JcLH8c3B7BEBHHSTvakUBZFGkW9zGJhKMMtMntFhwTascIaA+3uc
         ulyQmPcjm69QDZcNJ/WcsB2dTJfXXmp22cwS8kB98c09dJVOUeXTEzOwo+auZY3Pb74J
         VEDA==
X-Forwarded-Encrypted: i=1; AJvYcCXumsX6+j4X2AOq8BfJRfB00dOGLLTQespat1DzaBASk3VEbwCiitDAA4p2x5wePSc/qfAjzv27MeGFq5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Hm9GRv3k9JA6UhRxQe62BLDNjytuoES9+GHocrUj44uuvqBw
	3k3JSQRXy1Kbx4YiKcPpTu2kLBtJHeCAQI0+YOhlp2aD2BKwLr13iLGT5k5flUh3V0he1vDFREP
	dnTRbgRkTSZyC3Qa4eIz1zvy/LnAYysJj3tlF0c54gAY2suhd9Ps6SgL1LWM=
X-Google-Smtp-Source: AGHT+IEulvgYYxLUbIAT2ZGCEo6uzPF5ZYh9bP6wBfxwiNL273lg5Mb1AdYubrIf9hK30VZ4neqQ7PTu1ZAat4XQR+oIsw6NpEF4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144f:b0:3e3:ef79:5a8c with SMTP id
 e9e14a558f8ab-3e921a5c9b6mr78062675ab.14.1755910504422; Fri, 22 Aug 2025
 17:55:04 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:55:04 -0700
In-Reply-To: <CAJnrk1bSD+HfwLqbFv8gsRsPt0kRsr8JZcEXdqBWuKh2Qnz_yA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a91168.a00a0220.33401d.02f0.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: slab-out-of-bounds Write in fuse_dev_do_write
From: syzbot <syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com>
To: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/fuse/dev.c
patch: **** unexpected end of file in patch



Tested on:

commit:         cf6fc5ee Merge tag 's390-6.17-3' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7511150b112b9c3
dashboard link: https://syzkaller.appspot.com/bug?extid=2d215d165f9354b9c4ea
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=116eaa34580000


