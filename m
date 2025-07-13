Return-Path: <linux-kernel+bounces-728870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BADB02E48
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 02:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17DD482C45
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 00:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4F18F6F;
	Sun, 13 Jul 2025 00:36:02 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49778440C
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752366961; cv=none; b=pWiFoP8oIW/FDWhGa47lnPOrojHF/s4f3fnaGcZKBNAyC28ddJN97qj2qH3oddGUUTPGNMnpgekBm+0x/gTdYI3Sl1LD3jsmsWO392jU8PhDUmrjv/WOVdW9f62zz/iIkK8OAPYKi1rpzWs59XqFNwrSGQLkk9TGKhN68ZEuGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752366961; c=relaxed/simple;
	bh=o+Knsiczz7eFInKSHDnFhQa85xBxIyn2BG5Pp+GRM/Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L8u3ikTbvQQ1pMpbEY009XTZjskYnFJFGFbCz3M6usB/lFoczNIKQkuzrJNT1TZaZsxDtGAojKQdchqh7aHticIYV1tV9gts+CcMqi9YrN+L63uFsr0EvAQcou3ZHe4pX6o3fNRAkCh7VmK8BeFoPhPuECi4eExlLRUbS/e/KIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86cff1087deso659992239f.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 17:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752366959; x=1752971759;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TA654FcYeEns5+2hd4JzSt4xV1ciTTaLRE0FIOcQJCQ=;
        b=pAWqXiXdE0sUnmw73HTz7GABsuu7Nn/MaOK2NJXtISaw2gocVkSuTqH+zaPNjrOswn
         KBIQvRArUsTRMtFHgOVnbiMr4iu7bFEnhpw9LXh3tlyTpJfZ71CDVS5TjPc6FgaSDg2f
         G5kgU0Gdkd4PXwfbBfUMywrxzWbwqtmdoLfExq33U0t4lCb+Eq0PrwasDOvFHhGkIUw4
         FEkxnHFNM/kjvILwzapGI+byTjtxQyvVEdUL/IIAEyy+qW3CtUTms1FkbQhDbEQUiCzc
         fZ2T6GYfCyFygGpARtItewinQGuSf1qZmO7MO5FBRfP0AjLY65tZTUZ5/h9Gw19r+xMH
         eScA==
X-Gm-Message-State: AOJu0YxOmyvkHhoGs1MWIBNkjZVn4xC4IL5Z03y02Y1V1gQ2ACJhNJ/8
	cxIF9Gg6EtYBJzsQWLwzFoBncrZ1kYLhRN94azhYtO5tl2qL92o0GkNqiVGXzgaIRnbL3nnZ6qy
	ozIrnG3liEwIImWCQ0QhtaJqJpGizcL7qAtu+StJHxCUfzjpMYOzaRvE5JqE=
X-Google-Smtp-Source: AGHT+IFdMi33x1f4dlTEG1Jj2cZh/onoEuDWzZ1uxefHGBb9N0QNVGLzv+iPa9cAs4csWXqWG6KD77e6uiZfCcjpu59dt/dMpymZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:36ca:b0:873:f23:ff5 with SMTP id
 ca18e2360f4ac-87977fdd3e3mr1022874239f.12.1752366959354; Sat, 12 Jul 2025
 17:35:59 -0700 (PDT)
Date: Sat, 12 Jul 2025 17:35:59 -0700
In-Reply-To: <6872f886.a70a0220.3b380f.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6872ff6f.a70a0220.3b380f.0014.GAE@google.com>
Subject: Forwarded: Private message regarding: [syzbot] [kvmarm?] WARNING in pend_serror_exception
From: syzbot <syzbot+1f6f096afda6f4f8f565@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Private message regarding: [syzbot] [kvmarm?] WARNING in pend_serror_exception
Author: kapoorarnav43@gmail.com

#syz test

From: Arnav Kapoor <kapoorarnnav43@gmail.com>
Date: Sat, 13 Jul 2025 20:30:00 +0000
Subject: [PATCH] arm64: KVM: Fix SError ESR validation to only allow ISS 
field

The current validation in __kvm_arm_vcpu_set_events incorrectly allows
userspace to set the ISV bit (bit 24) in the SError ESR when injecting
a SError through KVM_SET_VCPU_EVENTS. According to the ARM ARM and the
KVM API documentation, userspace should only be able to control the ISS
field (bits 23:0) of the ESR, not the ISV bit which is managed by hardware.

The problematic check:
  if (!((events->exception.serror_esr) & ~ESR_ELx_ISS_MASK))
      kvm_set_sei_esr(vcpu, events->exception.serror_esr);
  else
      return -EINVAL;

allows the ISV bit because ESR_ELx_ISS_MASK includes bit 24 (GENMASK(24,0)).
However, the ISV bit should be set only by KVM itself when calling 
kvm_set_sei_esr(), and userspace should not be able to control it.

Fix this by changing the validation to only allow bits 23:0 (the actual
ISS field without the ISV bit):

  if (events->exception.serror_esr & ~GENMASK(23, 0))
      return -EINVAL;

This prevents userspace from setting reserved bits and the ISV bit while
still allowing control over the intended ISS field. The condition is
simplified since we now have a straightforward check for invalid bits.

Reported-by: syzbot+1f6f096afda6f4f8f565@syzkaller.appspotmail.com
Fixes: 0e5b9065dcf3 ("KVM: arm64: Inject SError exception into guest")
Signed-off-by: Arnav Kapoor <kapoorarnnav43@gmail.com>
---
 arch/arm64/kvm/guest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 2196979a24a3..cbe1e310f477 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -844,10 +844,10 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
  if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
  return -EINVAL;
 
- if (!((events->exception.serror_esr) & ~ESR_ELx_ISS_MASK))
- kvm_set_sei_esr(vcpu, events->exception.serror_esr);
- else
+ if (events->exception.serror_esr & ~GENMASK(23, 0))
  return -EINVAL;
+
+ kvm_set_sei_esr(vcpu, events->exception.serror_esr);
  } else if (serror_pending) {
  kvm_inject_vabt(vcpu);
  }
-- 
2.43.0


On Sunday, 13 July 2025 at 05:58:05 UTC+5:30 syzbot wrote:

Hello, 

syzbot tried to test the proposed patch but the build/boot failed: 

failed to apply patch: 
checking file arch/arm64/kvm/guest.c 
Hunk #1 FAILED at 844. 
1 out of 1 hunk FAILED 



Tested on: 

commit: 15724a98 Merge branch 'kvm-arm64/doublefault2' into kv.. 
git tree: git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git 
next 
kernel config: https://syzkaller.appspot.com/x/.config?x=82bd3cd421993314 
dashboard link: https://syzkaller.appspot.com/bug?extid=1f6f096afda6f4f8f565 
compiler: 
userspace arch: arm64 
patch: https://syzkaller.appspot.com/x/patch.diff?x=10644e8c580000 


