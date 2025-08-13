Return-Path: <linux-kernel+bounces-765792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E252B23E50
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B681B61712
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0C41E9906;
	Wed, 13 Aug 2025 02:41:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCCFC2D1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755052865; cv=none; b=ahMY4XRJnsrrpTDbPHdsOn6jQIOUgzyvZMniQZfU4trA2eihGQ4ps0Cf9wrZv3h1bX4FjAxSL3vrFxlrepNpNunXK/5SjLTgovUf/Ykzx3/vKEv/nmDRRzlmwIZ/JO2Aitc+wNDfCN/VueOeCPXczeLueC5o8MB83JTYKU9j/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755052865; c=relaxed/simple;
	bh=VsKyD4w9ND4Q7HUqeebbRH0Rfey+QrywJ4y9uBYbgls=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mLWSZoQtFoiw1yX81Q6TpZQWWugpzzHX7g985eMgl7uKNraDYW/JXpCWTaoBMya9FpAmaCdVhMchIfr42Qh1Q787y4iRsTxXH34wy4rmMfPKYKTOl5U5L5rMtoDvr5gq9OXyRlHoCihny4d5GZ90PNHviFu+P4fKTmKqZyUtmqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-881776a2c22so1507130239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 19:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755052863; x=1755657663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOKjVnYuXgqPaa3yg2VZdRRdIXKDXsEBOmFzzU1fh6s=;
        b=K33AMEFzqPsrt03DQJqPzY8tRVPXh9u5Eb8XyTsxVJ28wyPkW/YPz+zOZrVa9cv7Fg
         WYHxVriNOxMwMZ422pyBE3ZcrY+7vPjThhSBnEXfieqFjzXAXGU3O0FVmzYdNQtxhrw+
         FeqiM/jjhPpTcYFVMXd/9fq8vVIPij9L0Eu9BeDwm9LRKMgOqytkl3YQwlecm0KmkpKH
         a7rk2lUwRkQK2U8Q95lnXCCMT9ATS7XBk31DXpIbGKNud792KNcS3d7OCgzOOsTOXycc
         9aS8Vmvq8Gi3thiQT3eahmbtciE82NqWZzJxAF3lPw7acVx82kGFf9IBCiIKETBKP+Yo
         L+BA==
X-Forwarded-Encrypted: i=1; AJvYcCUV4JcGoPOD8YNBmr2ZSRBu9lxQhQ+z0aiYqEaeh5Ti52KZ5hojOyH26RasaqECFpJEwM36g4xiDZRRgDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcVEiVmcFt4P1Tg89ATvAEUhwWkrFkPszm69T85wC0V7HMHXHV
	SH519e60Z+k/XHazHB9P6AnytuQefrhG+FQPZ4sFpVf/7LUvxhIpOy+D6Pk6WTmYwDON02DmdJJ
	p8gJt2xWrjfqtoE6O6vQwaUS4CYwIWuwwyR5lLbuzxz9ALqpo0EropbgxyDo=
X-Google-Smtp-Source: AGHT+IE78i0L8Gbc2hUUPZVqCdf3/NIu9NoKr5r4DJS96qBoGN7g33icJnejqMKT3NsKeGxo5KY3mUjP6m3F+ezdHb9Casy3gIWl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c8b:b0:881:6d77:6d81 with SMTP id
 ca18e2360f4ac-88429655830mr302881139f.8.1755052863610; Tue, 12 Aug 2025
 19:41:03 -0700 (PDT)
Date: Tue, 12 Aug 2025 19:41:03 -0700
In-Reply-To: <20250813014658.4404-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689bfb3f.a70a0220.7865.0044.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
From: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Tested-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com

Tested on:

commit:         8f5ae30d Linux 6.17-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16786842580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
dashboard link: https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f5caf0580000

Note: testing is done by a robot and is best-effort only.

