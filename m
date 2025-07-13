Return-Path: <linux-kernel+bounces-728907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68E7B02ED6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 07:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6013C7AAB90
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 05:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6292A1898E9;
	Sun, 13 Jul 2025 05:51:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4C1367
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752385883; cv=none; b=dCEB0/9RiDQ+Y3XGda81hpCBgLCJptjOLxLTnGeESmP+WK+vj+7j9RA0ZWfzkoX0dbw0sk2FXD9phxpI1OYIh+ofNY0xaufjbvAw+WOk0uE4BVs3y/DNdN08BbilJ0jrj7lVk+CZaCOC74YlF6MpJ2Hh6Rt4Sj26wJY8RYjdUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752385883; c=relaxed/simple;
	bh=9GZt8D9mfiXSw/NxzE7bK0pqDojigi7inhqwisTN0uA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kSjQRyZWKOIjhf4sJHdojvL3vzNCQ48IjBt40TPXpwjwK+yCHVFWccNT8poVlPsisslf2Bv1k1OXsCIo2L6YUEJHpMl1aak1XuL/3n2VGc2C5jGH6iCWrgrsuiay83V6F9oCciA3RdfEA17H2m96HnUiCKzIqHbjX+IoBBOdDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df2d0b7c7eso33242975ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 22:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752385880; x=1752990680;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYppIC+ICiFFsg/JMZw50PJIJgEPgwBVwDBF5TDe0lQ=;
        b=h/0gHX1di72kd4y39mR8YqHOUPjkSQPYe8HoC+kOFeokk3Ok6Lh1BdPMwEkCtZmOv4
         pudJUJfzTz5quPoCIeiYzmR0OdXIAtHgeM7lzc4rbzdHheXm4yK7UXagakW/Czo5JcUW
         YWFzaLLJ3jD0X1N9i4Lafcxxr10DBptajDch6IpZm8nAO19chIKhLBLK2uzobgyZsebc
         NR9bmGCgQl8KReEZhxKoiz4GEdlK8BFFSiaUuP6UxQ7RHmgo5AbHezSkn/is7T0yd6Su
         39FZtg39aq65u9Bihd/Vdg5v1GpkiZgBFzYrrBnzxptRi7ma1igJR/XBcbVEmIHH93iw
         hBgQ==
X-Gm-Message-State: AOJu0YyGE2Twd5xkFp42DZIkmHOMX5wSEHxQTSoyy8o2lO7AJnKXSMnd
	TGVgOIVrUGP3Olk9eABlzT4pk7SsUWthCBcbhrWWoLsF2n5yFT7FzpizjvYnQ8Zvpx4y4sed93n
	k21jprOj2QS5nKPZ/pD1FXU6UVV7gTL8HKC79Hi3gy50v95smr4z2JHXKT3M=
X-Google-Smtp-Source: AGHT+IHEOJlyYr+gmzM+fNd9VWdtxu/3a3RKCnwkoNuU+jyJ0nZrnpL0cYq9n3fv/YZVTES8wpgL+z4MqNgYFwC38t3FO2Ipxtz7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:3df:49b4:8cd6 with SMTP id
 e9e14a558f8ab-3e254217c83mr89958095ab.7.1752385880527; Sat, 12 Jul 2025
 22:51:20 -0700 (PDT)
Date: Sat, 12 Jul 2025 22:51:20 -0700
In-Reply-To: <6872f886.a70a0220.3b380f.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68734958.a70a0220.3b380f.0022.GAE@google.com>
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

rom: Arnav Kapoor <kapoorarnnav43@gmail.com>
Date: Sat, 13 Jul 2025 21:30:00 +0000
Subject: [PATCH] arm64: KVM: Fix SError ESR validation to only allow ISS 
field

The current validation in __kvm_arm_vcpu_set_events incorrectly allows
userspace to set the ISV bit (bit 24) in the SError ESR when injecting
a SError through KVM_SET_VCPU_EVENTS. According to the ARM ARM and the
KVM API documentation, userspace should only be able to control the ISS
field (bits 23:0) of the ESR, not the ISV bit which is managed by hardware.

The problematic check uses ESR_ELx_ISS_MASK which includes bit 24, allowing
userspace to control the ISV bit when it should only control bits 23:0.

This creates a potential security issue where userspace can manipulate the
ISV bit to potentially confuse or exploit kernel handling of SError 
exceptions.

Fix this by changing the validation to use GENMASK(23, 0) which explicitly
masks only the ISS field, preventing userspace from setting the ISV bit or
any other reserved bits beyond the ISS field.

The fix changes the logic from:
  if (!((events->exception.serror_esr) & ~ESR_ELx_ISS_MASK))
to:
  if (events->exception.serror_esr & ~GENMASK(23, 0))
      return -EINVAL;

This ensures that any attempt to set bits beyond the ISS field (including
the ISV bit) will be rejected with -EINVAL.

Reported-by: syzbot+1f6f096afda6f4f8f565@syzkaller.appspotmail.com
Fixes: 0e5b9065dcf3 ("KVM: arm64: Inject SError exception into guest")
Cc: stable@vger.kernel.org
Signed-off-by: Arnav Kapoor <kapoorarnnav43@gmail.com>
---
 arch/arm64/kvm/guest.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 12345678..87654321 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -844,10 +844,9 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
  if (serror_pending && has_esr) {
  if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
  return -EINVAL;
-
- if (!((events->exception.serror_esr) & ~ESR_ELx_ISS_MASK))
- kvm_set_sei_esr(vcpu, events->exception.serror_esr);
- else
+ 
+ if (events->exception.serror_esr & ~GENMASK(23, 0))
  return -EINVAL;
+ kvm_set_sei_esr(vcpu, events->exception.serror_esr);
  } else if (serror_pending) {
  kvm_inject_vabt(vcpu);
  }
-- 
2.40.1


On Sunday, 13 July 2025 at 06:13:04 UTC+5:30 syzbot wrote:

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
patch: https://syzkaller.appspot.com/x/patch.diff?x=153d90f0580000 


