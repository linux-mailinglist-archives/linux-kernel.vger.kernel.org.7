Return-Path: <linux-kernel+bounces-772314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C15B29129
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 04:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E523441522
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 02:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4B51DC9B3;
	Sun, 17 Aug 2025 02:33:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525447F4A
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755397986; cv=none; b=d+9oFPr2QJRf6DEfn8TLUQth1NNQj40dF2KoqVJtbkI2wkQE/uotTyquJaJqT1QTkvZY7OaetbuI9T4OCifQjsulO54hYCn4RDbPIV1gCYjkt1YW2NbmI8Xrov05S3Nk4ifR1Yz+xOAD4FcNw+Mfd50Zfqf4RbawwwiyjDSSX5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755397986; c=relaxed/simple;
	bh=hem+gqTapKSkExrbWk1BIT+OxcJ6H38hQ7DFm06EJ/8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uHMs3mVXvdREBs9RmaM98vfb+i7P0LSX3iZymBzbMNsmse5Tp2zoblz0/AjjrmtxHBbzeP+kPL7X7BqXLorGjPDXAKR2gCICCxzhtIeiySXrfHG8L3kmAfxCzJroucQMzvPq2ecuMj1laS50MOikL/lVfa+UsKYnrQXs4WjzLVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88432e5aa43so363982939f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 19:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755397984; x=1756002784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fidfw4hEAX3VkGtp/Pp4H/YxJryq0AwM+8/g7q+8VOs=;
        b=cIT+i2TJlGQhGLw4EP3BiAxtwUHswavi1ObyBtKUt23m7CsL80yTOh5XJNZMCQc8gR
         CmaZFG9Gm3iYa6AKetiq1LLgT/YPcF8iJzjzlMbQ/UHgRDWPkQXN6HALFAYeCzrtVWhG
         C+wIryaWb/vtfJtf4SB4nbifQgNhUfSfdFuU4JC7KObotjdXLo6iCFpuQG8fApq6fmQw
         0u3loiSF0AF11Ifq7IRu9DDN3oDpEbOnU0ncgAlHrIcJYw1dZuIfOH9BGROiUP+mTLVp
         6R0fF3UQBVTXXPftTPjoa9VDMVIwJu2vlKJm0RH7pEtT9TGYRE4TT8I68z18nDsGTdIV
         hB9g==
X-Forwarded-Encrypted: i=1; AJvYcCUdd1uHFdR6HK/h+UJBhiIhyw2QvxE0CLdn+bCMrsFZ00pplHguZEJZancvu8IkbPsOsl/bHH47szPNCJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaDAU1hnjn1+OsZ8FAo2AIW/QnuxZfqQkoCi4YmJii2PHmt6yi
	UdhBMRXtmX0fdKhWih0qGQKafL0uU32mYsk5tj53LYZAgIqfJFBpC9OIfGmd7WlRbNhNG3JfioK
	udwlsZ5GCXd07ZDIg9JLUs6ca7/otfk2XQuX4EMfprDnPBZFb/KcPXtjzcNs=
X-Google-Smtp-Source: AGHT+IH4flHtDpG3ZMt6EtlwxFTdPrHHo3gbkajgw22v/JlJvmZZ8rAJflJdhTNpeevampa/Ig10U0IkcQYFz7o5RhJTFDV+nKxr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26cf:b0:881:739b:e575 with SMTP id
 ca18e2360f4ac-8843e544283mr1744787639f.14.1755397984431; Sat, 16 Aug 2025
 19:33:04 -0700 (PDT)
Date: Sat, 16 Aug 2025 19:33:04 -0700
In-Reply-To: <20250817020836.4788-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a13f60.050a0220.e29e5.0052.GAE@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in usbtmc_interrupt
From: syzbot <syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/smb/server/transport_rdma.h:64:61: error: expected expression


Tested on:

commit:         1357b264 Add linux-next specific files for 20250815
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb7fbecfa2364d1c
dashboard link: https://syzkaller.appspot.com/bug?extid=abbfd103085885cf16a2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1233b3a2580000


