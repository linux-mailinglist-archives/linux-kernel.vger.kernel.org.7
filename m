Return-Path: <linux-kernel+bounces-873593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3CFC14381
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E1F1A61EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B037305E02;
	Tue, 28 Oct 2025 10:48:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966403054F0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648485; cv=none; b=WAaAVvysWkQpZ6LWzvBp4tn7zj/5DykFVwilUAwPcRWyHN6c1OPFte3DBXHBpj8IsN9R+Cf3JUNBh4U5czwHmAstV+G4JNLPRsyiXDhrSLcl0AeuZLsbIJNGUDeLjR4FMpZf1oBKXEm8j0hDcgFS0/J7yYJHuvpF+Hx/MhEWjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648485; c=relaxed/simple;
	bh=Rte+136ltZSbkgVrGtZZVAf0ifZK2tEiX84SuXsm1y4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eFXV0ihe4GrRWxNitLLdohcjWOgPICWpjZkM6HrI1Z1LoZJBvitCXuuL3w0f7mezgcNYpTYHMbgxpumfEtKJQ7rqKDSKDHzSKCOxAcju//0pt60A0o2iVH5ywKwBREFPzy45nvUYaO6CrJIDyd7luJi23hLzsG8rE8VgTrMfhhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430ced58cd2so209620525ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648483; x=1762253283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yFYT4CdKqoDsd8W0glrUEl/pbrpKij3aYqiM+pG/+0=;
        b=JhSAnVt+YtcjpQn8hPe0hl+YGHR0towW49my0fbnS40l97syHLUWtmFJC5zoxhh0Ra
         bvJfSGXNAgfKof2WNgXWgu75o/q46JVIxLiBVn/Oc75BHoMXHKBYQbwtdXy6qlL9Ly//
         a/9HKE8KnVjs089sUHRg8Zn2/v0wvb/H3yKuc43C2Cmwj5YRvif/jpcQ7tE52W9SDEiV
         /UuWMVaXgFLHEJC57LXiHLr0jMXBk5NCF7dJsaWnrgHDi8n7jYQoFoRk5vGiTS7qXl6V
         PqCGdURdlkwYI9sOXtL225OkDYRQjTV49GF2wYx3fbQOGJFrU4v40GpQouk0ETtyS+63
         D7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ6EBt6tP2yIggcMUjh8f00qV8sczQ2LFOcW4T2n7FvZU/rnGFlGPGBwiwbRcvAP8c/79H3ukLUAjE4kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUfYO3EyxeNc2dIIAgjmRftSY8p4HcvYkOODAEhZEzBBBhXug
	w/tVbLYvR9nLr4U8Thgalm1mmtk/iMHzGYlZAhTr0Wy0JbFIDiT3GoHnTKe386Y0HcL3YTC4Y8q
	apOmoy92sR7EeTqUAnfWrBzyS22bCZPwihZMhzf5xA0ia5MqanLdw/bn+OdI=
X-Google-Smtp-Source: AGHT+IHAIo2YX84fMpNYEbVq4rsDCeRcQ8H5O0ax5/QnOqCOYAPZey0GQIHz3MsVFZyZ4xe7B11Qw3qx+WSruFUQO5Fgqc5Bkht1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2409:b0:430:a14f:314c with SMTP id
 e9e14a558f8ab-4320f7a5e53mr45161765ab.7.1761648483062; Tue, 28 Oct 2025
 03:48:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:48:03 -0700
In-Reply-To: <20251028104157.Q4CES%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009f63.050a0220.32483.018b.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.12.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.12.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.12.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=cae1291240e8962a
dashboard link: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10781f34580000


