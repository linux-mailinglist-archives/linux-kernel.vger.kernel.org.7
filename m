Return-Path: <linux-kernel+bounces-809169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75DAB50985
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A680444033D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77FCC120;
	Wed, 10 Sep 2025 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="JuDYPhxg"
Received: from r3-25.sinamail.sina.com.cn (r3-25.sinamail.sina.com.cn [202.108.3.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D9FC148
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462647; cv=none; b=Z2xefWt5gP4RHXpIfFFYXgDPvlss1nFXvpf59WrlY6zk+AOGOfyLh3fv9jKxzPMYLYm4OYouLmADKelgrRtEnjfbtQaL0WYKVov7daAW7wrVCWjHvrEFWNlKP6QE3+pdX3iit3hrd7pqP2ikl7b72HLN+N9Ll+jPxDX31CrMhr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462647; c=relaxed/simple;
	bh=c/YMJ4aiAKivh5/bYvhSukpDrN5xJzfHNCd+pBXPf9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLFwiAqCpWNgB+sgRu4RBLc98nh9AsUH1nqrgHq8ZAYbEsl2ZunJSXEtxzpmr+05szIqahOCok2YpnXaYfuExGKPj2/buL/HURkfoZ5QG0azaqoihx9ebllGVeUI5w1vD4ajzr8jH+SqrpL3Aeoz7m+0g1PxSh7xei16VWS98FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=JuDYPhxg; arc=none smtp.client-ip=202.108.3.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757462643;
	bh=jDrDTq1IVzBDGEsVX/HH66JqsYBsLwmpiddeGS/SFxM=;
	h=From:Subject:Date:Message-ID;
	b=JuDYPhxgITWLWR5CfNZkUNbFZTb/i2PJMwgoLI5ulqMmAUtQZqQeFbqI7kLXQ5adO
	 moZqAdJiDCAwAxchJzIRS/b4lQYf5Kg6Q5zSW8zxZW6lvSbiYZfMQ648ByAFFaLMbS
	 7QXWdVf5uyPVY25piROIHEPeWza3c89qYt7PZPXo=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68C0C04500006052; Wed, 10 Sep 2025 08:03:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1548466816279
X-SMAIL-UIID: B15C2E1E69D4479AAFF0586463A98976-20250910-080319-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+cef594105ac7e60c6d93@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kvmarm?] [kvm?] WARNING: locking bug in vgic_put_irq
Date: Wed, 10 Sep 2025 08:03:09 +0800
Message-ID: <20250910000310.6672-1-hdanton@sina.com>
In-Reply-To: <68acd0d9.a00a0220.33401d.048b.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 25 Aug 2025 14:08:41 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7b8346bd9fce KVM: arm64: Don't attempt vLPI mappings when ..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b4e862580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7c53d3478750eda0
> dashboard link: https://syzkaller.appspot.com/bug?extid=cef594105ac7e60c6d93
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15860634580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1074e862580000

#syz test

--- x/arch/arm64/kvm/vgic/vgic.c
+++ y/arch/arm64/kvm/vgic/vgic.c
@@ -146,20 +146,25 @@ void vgic_flush_pending_lpis(struct kvm_
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_irq *irq, *tmp;
 	unsigned long flags;
+	LIST_HEAD(head);
 
 	raw_spin_lock_irqsave(&vgic_cpu->ap_list_lock, flags);
 
 	list_for_each_entry_safe(irq, tmp, &vgic_cpu->ap_list_head, ap_list) {
 		if (irq->intid >= VGIC_MIN_LPI) {
 			raw_spin_lock(&irq->irq_lock);
-			list_del(&irq->ap_list);
+			list_move(&irq->ap_list, &head);
 			irq->vcpu = NULL;
 			raw_spin_unlock(&irq->irq_lock);
-			vgic_put_irq(vcpu->kvm, irq);
 		}
 	}
 
 	raw_spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);
+
+	list_for_each_entry_safe(irq, tmp, &head, ap_list) {
+		list_del(&irq->ap_list);
+		vgic_put_irq(vcpu->kvm, irq);
+	}
 }
 
 void vgic_irq_set_phys_pending(struct vgic_irq *irq, bool pending)
--

