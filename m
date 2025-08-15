Return-Path: <linux-kernel+bounces-771102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC870B282E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D56C5E6859
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496B12C3240;
	Fri, 15 Aug 2025 15:24:35 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D12C0F91
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271474; cv=none; b=JGo4ZDaedP2JmkeEGfxicObEI3a+ggBAA4KEEAZNXFuLHdqZOIlRX2Z4jda4OH8ikrDcVXOcg2zIucMohjjTuQnx1fqU/wVslm8A0kOkDvp3nviLxAtD/vmicaygNjffS3EIHMB/tOpcqc+NWQv6FdX+bMpHCdlfiZh+Phl1pQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271474; c=relaxed/simple;
	bh=tQ1PHm9SWlFPoQSw5LhxX2Vf55dtCDNr9DNH1mD2vQk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=RoVNwQuZBJDVIlCqfKJLDZVBc9sqCoujA70MGXEP6mDnv/OLLqJ8RArfBvSc/Oncxl5JYn/vNwvhLQxCNknA5O21chNYYHN0DoC6wS8KAR1Zg/+1BwAZvX79S0K3c6FEVpKpfA1cPKsJoaRz9PW0CHCd8agaE69eGJOIYqrrwVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88432e64477so232942439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271472; x=1755876272;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3An1IRlggyZJ01ddy564k2J0NFqGWkP3JTvHFV9nJ1s=;
        b=XLwsqB/KltWn1TVlXDFVeHL3IN1qpsT2ae4P0YGYyum6qVrsQpGWqDcVcFtqr+ycSq
         jzHZVKTx8EYzm3dsHfglB50/waH7brbMQyvaXX7Djqo2hJl1kZWfFuMuVF13Gvka2aQh
         C+DqlKAD1cfIGZLhke/FEfmLycspVZ9rQ7OtYBea8/T0XxWaEb+ocENW/Ib9VGFSjbO7
         UyCG/TevjiuaETxwkEKoXrBS5tqA9GFhensdQ/46Vj0PSapdCjgWMX3ZQ6jXj5fQ3peC
         vXyRiqowipxzI7BEBVc950aI/ZRDpUX4XzCINfYCmUBhhkHM950B4yno312rSxC5OBJ4
         4p5A==
X-Forwarded-Encrypted: i=1; AJvYcCUVMqab1RSx7/XW0mxba8EPVme3L53VFmYFY/877iz2wFDqrbSDseUBGJEs/0nRC6Q1rXE8XnEa63CuvCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl9Nx3ZMVB/uu78Urq5ODqSoPl3Cf2ZEeUeotaEZnnR2mfbYiN
	3YOUW4c6ILuGKVO7oj3xfS9oFHL+m/9QVEIMd6SLx+gVO0SQCrVe7LlsNS+eU8BQ8sKBTIGUn0d
	iaI7b0rhLaC/4E3Xr4HSjHxEKMAQwwaFGsOF+SxA4f8VDZ8EOQu9g6TzV7hc=
X-Google-Smtp-Source: AGHT+IEakOhgxRRfPY5H+tcDUiu14RwKBGYJsspvG2JWF62Kfi/uJ9cHZ/es+6WI+rEO1p7QmdXuW6Sxt9pIBEwsWGvL5PlCj6Rj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2196:b0:3e5:51bb:9cd9 with SMTP id
 e9e14a558f8ab-3e57e80ddbemr43145025ab.8.1755271465045; Fri, 15 Aug 2025
 08:24:25 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:24:25 -0700
In-Reply-To: <20250814120237.2469583-1-dwmw2@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689f5129.050a0220.e29e5.0019.GAE@google.com>
Subject: [syzbot ci] Re: Support "generic" CPUID timing leaf as KVM guest and host.
From: syzbot ci <syzbot+ci156aec4dff349a40@syzkaller.appspotmail.com>
To: ajay.kaher@broadcom.com, akataria@vmware.com, alexey.makhalov@broadcom.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	graf@amazon.de, hpa@zytor.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com, 
	seanjc@google.com, tglx@linutronix.de, vkuznets@redhat.com, x86@kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] Support "generic" CPUID timing leaf as KVM guest and host.
https://lore.kernel.org/all/20250814120237.2469583-1-dwmw2@infradead.org
* [PATCH 1/3] KVM: x86: Restore caching of KVM CPUID base
* [PATCH 2/3] KVM: x86: Provide TSC frequency in "generic" timing infomation CPUID leaf
* [PATCH 3/3] x86/kvm: Obtain TSC frequency from CPUID if present

and found the following issue:
kernel build error

Full report is available here:
https://ci.syzbot.org/series/a9510b1a-8024-41ce-9775-675f5c165e20

***

kernel build error

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      dfc0f6373094dd88e1eaf76c44f2ff01b65db851
arch:      amd64
compiler:  Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
config:    https://ci.syzbot.org/builds/590edf8b-b2a0-4cbd-a80e-35083fe0988e/config

arch/x86/kernel/kvm.c:899:30: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]

***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

