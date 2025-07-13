Return-Path: <linux-kernel+bounces-728866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C80AEB02E42
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 02:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F136C189E1D9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 00:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AC75223;
	Sun, 13 Jul 2025 00:27:01 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810174A00
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752366421; cv=none; b=IqTTi4DOeyTVK4/SpJqmxXsZcElSgvOG6ux3VPSswrc2kxLdWALIn2eqYe3T2iZLcZvAArQCT3z4WZQl7yEbXe5n7DYgeoFabxCoR/ezmsf9b4CuH/geXRTSRlrnyoU9AGKU0qFynf3BblyC8b2GrT8jQAuixrehzQgDTK4oCEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752366421; c=relaxed/simple;
	bh=D9g/Zx1BErkf3Fm6QglNh+FzVToRgsbyS+XTOTLzoec=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nY4EvdKDhrFxh8Mi9VUeirgyY06Ng7AnP8CNMxE7XAiCtXCvFRiD4a8ZnQm2+KCakQSJ1BMPCnSxxwkbxs4xTdW0/3hOtckLcvDg7KjitjYi2yZMnu9bSrwH4slh69Z/iP0AqIigGO/WuMrkGBJ4nvBOGsJLIFawEjz6nTkv0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-875bd5522e9so302073139f.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 17:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752366418; x=1752971218;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eD5FlCrQSSk9w/F89/1jFJW5rVn05CSrcpa2z5vZT2c=;
        b=H1C73lhptKBOMQ0M0d/TXbAEOJp3lgeBVCGKE+6gsMUylp7T9FCP3uczhd+rafnK4J
         hq2nJkwWh6YgWK4BGPnUbtrgwYGwa4G3I6v5GuQRaOjh8/0aI7NmuB9ybo2e6Xy96mFn
         KOVT9Cw3I46Ukav0vtJTk7Nrtzp+1fc0Rypi+bnY84owRzNx1SBeZg7jNC4QpuPjCqLr
         hTPSOsqOGQnDKO1QY2tL2/1dY6hU1+mZhsOqx0yve/+kr8UbbS4y+AiYtp8ShI+dRG2x
         qKkqN2ogZyzhwKC0l5hfMN0dWsV4uBI8DPfkn0Pdamxf4/Lg1HGzyKnSa8ggZIQIqPum
         ls3w==
X-Gm-Message-State: AOJu0Yz4u4A/5L0IeQDu6uJVRJB2HJy8DgRO3rsmXFs2erLJHobcTjG3
	ejZDSEXA3e/QxNdREiYWWhnH6EWr0ADlG6v9pY9o1EKBKzu5bqdrb6h3X7Dr+18vW/3O+/lHGsq
	DI+XXyghr43sCYcq+PcpUJ6gfDZGmF5oED8KBqt689dm0lZli7Lpx1nLSEJ8=
X-Google-Smtp-Source: AGHT+IFlGtZYYQDQ6c1d2aQYZzWOmFsItvFlKakTD2HMytRTT7ygzVDckZ6NQ4JqHMHTM8+2C6i+cr4rYkWU6P67azp+3y53ToxE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2786:b0:3dd:cbbb:b731 with SMTP id
 e9e14a558f8ab-3e254182042mr84282045ab.9.1752366418718; Sat, 12 Jul 2025
 17:26:58 -0700 (PDT)
Date: Sat, 12 Jul 2025 17:26:58 -0700
In-Reply-To: <6872f886.a70a0220.3b380f.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6872fd52.a70a0220.3b380f.0012.GAE@google.com>
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
 arch/arm64/kvm/guest.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 2196979a24a3..abc123def456 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -844,10 +844,9 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
  if (serror_pending && has_esr) {
  if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
  return -EINVAL;
- if (!((events->exception.serror_esr) & ~ESR_ELx_ISS_MASK))
- kvm_set_sei_esr(vcpu, events->exception.serror_esr);
- else
+ if (events->exception.serror_esr & ~GENMASK(23, 0))
  return -EINVAL;
+ kvm_set_sei_esr(vcpu, events->exception.serror_esr);
  } else if (serror_pending) {
  kvm_inject_vabt(vcpu);
  }


On Sunday, 13 July 2025 at 05:51:05 UTC+5:30 syzbot wrote:

Hello, 

syzbot tried to test the proposed patch but the build/boot failed: 

failed to apply patch: 
checking file arch/arm64/kvm/guest.c 
patch: **** malformed patch at line 13: 




Tested on: 

commit: 15724a98 Merge branch 'kvm-arm64/doublefault2' into kv.. 
git tree: git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git 
next 
kernel config: https://syzkaller.appspot.com/x/.config?x=82bd3cd421993314 
dashboard link: https://syzkaller.appspot.com/bug?extid=1f6f096afda6f4f8f565 
compiler: 
userspace arch: arm64 
patch: https://syzkaller.appspot.com/x/patch.diff?x=10844e8c580000 


