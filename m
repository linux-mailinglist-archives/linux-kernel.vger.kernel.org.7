Return-Path: <linux-kernel+bounces-680593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFACAD4756
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 02:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8231D16C6DB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 00:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26CD18BC1D;
	Wed, 11 Jun 2025 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFy4PPMC"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64DD1537C8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749600659; cv=none; b=l+0ZqBDGkEi4h5Z5Dr/PosRCyq35fMMoPr1Y7zgQeizs/jt7adiCFsCott7mKMatfnoa54czpAHNTaUhkwPP17H45V6zyy6obABQsw93Q8spjNatbFLFeD/6KNc/zypu0acN8fLeukXA8FV2Zik3kuvKSr+EKcRGG+ShtR4da+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749600659; c=relaxed/simple;
	bh=KbvpWBmaAbSh8Vh7bcMGuAO93v+FYmozT636NWdRWts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ETdvnhlhspLs4pN6QXDVWpMAbB+5nMiGHjDTidCX/FbGt2sviDDtkJJOsMdzvq473PF5gzN6SuqWafMoBi4mKm3IVrdSWSdz4OJmtyUSNzXbo/hkeV8cQHMVVxQtBgyO807q0am5iUvzwB4X7woOKG84iVJIm3zD0LRCOlHu2H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lFy4PPMC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311a6b43ed7so5179180a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 17:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749600657; x=1750205457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VlZgeHA644QawbjAzxLvevk+0CPgkFNL80WvPP4oWa8=;
        b=lFy4PPMChNXXDTWtWIqS2PCjHXULZVQTDeur0OFhwhye3A37OpwxlA+BWEBn5GgTbH
         Su3fLJBIDF40xXd0ETY4WaSZXbvNMs/2oQa1rFwCn/QimUfmVwTis0JROJHr0tg649Sp
         VLuLu/Xt0km46L7sIkuL7k2t8iOyltddpfE5FbjeORITgg1TOJZiCMZ0Ww5s12Imu7jm
         Z4wT9LDGrBKJ56ozAduuPn9xK1xZBA20jwZfwLG99d1tL9lTkMuOR6wU+tE0GahVObOc
         oGz8C5Gk5moebua7oYLChm7eNFZlGfKlhjt9ycFHxZgVGDRDTVj2gNUn+xJ76uYW52fi
         JchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749600657; x=1750205457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlZgeHA644QawbjAzxLvevk+0CPgkFNL80WvPP4oWa8=;
        b=mS5WdwTt5LzISSEAx31Rm586o/PJ+q6jzTc7FHRGUTxuv0beKov+P+DOjPrZvZpr/o
         jxVneNTg5NzbGNxPRV1ma7h6TYKYTlDv8iSvL+h83tLW6VdAa87r85V5TBBDUgc9lETS
         wiCNgTMfa8a1ki0buVdwEaD8+k4nIiMx/zZMq4mejGIaxhC5vJB2pLg90AMg4+R/Z1+E
         HYHjqqqRc3bn4KANR14GuF9jvHmrHUiCuXVnPiGv9Ob82OnM4BHnUebKfTiPVOJ6mwXG
         fN1c2K1kMN3cJu5DRRqSrRPptoPIzIbyrJPvhLpZqreCW3in3u9waPKwW0jQK3bybKFm
         jSrA==
X-Forwarded-Encrypted: i=1; AJvYcCVLPc/YXfy9aUlFsdRqxFrmI3KRu4UNn0c2tQZxQ8iF8xiZGMq5H+xl044lG/MToc//B2wTxAU7QLp3eA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHmncodk8e+LolNp6+urJdjjWVSFDMsYSaCeSF5vEAkJhqt61
	3O6KXMfWST35ydNOAnadH0N5WRQ+ymP3XlZHzg+swzsziOjJVJU72lvQfGewXMgPpzk9b/KDxrE
	JImo/ew==
X-Google-Smtp-Source: AGHT+IEo+A1iKKp/d15/c3Y8CK62vwTvYQUmq5gUOhKzuXVKftWt1+9sRfxp1GZ6dnQl+d5j2tHzGoYEsqQ=
X-Received: from pjboh5.prod.google.com ([2002:a17:90b:3a45:b0:2fb:fa85:1678])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2643:b0:312:29e:9ec9
 with SMTP id 98e67ed59e1d1-313af1dd043mr2232849a91.24.1749600657225; Tue, 10
 Jun 2025 17:10:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Jun 2025 17:10:41 -0700
In-Reply-To: <20250611001042.170501-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611001042.170501-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611001042.170501-8-seanjc@google.com>
Subject: [PATCH 7/8] KVM: s390: Stop adding virt/kvm to the arch include path
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Anish Ghulati <aghulati@google.com>, Colton Lewis <coltonlewis@google.com>, 
	Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Don't add virt/kvm to KVM s390's include path, the headers in virt/kvm are
intended to be used only by other code in virt/kvm, i.e. are "private" to
the core KVM code.  It's not clear that s390 *ever* included a header from
virt/kvm, i.e. odds are good the "-Ivirt/kvm" was copied from a x86's
Makefile when s390 support was first added.

The only headers in virt/kvm at the time were the x86 specific ioapic.h,
and iodev.h, neither of which shows up as an #include in the diff for the
commit range 37817f2982d0f..e976a2b997fc4.

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/s390/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index 9a723c48b05a..b742e08c036b 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -5,7 +5,7 @@
 
 include $(srctree)/virt/kvm/Makefile.kvm
 
-ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
+ccflags-y := -Iarch/s390/kvm
 
 kvm-y += kvm-s390.o intercept.o interrupt.o priv.o sigp.o
 kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o gmap-vsie.o
-- 
2.50.0.rc0.642.g800a2b2222-goog


