Return-Path: <linux-kernel+bounces-776630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A11B2CFA8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7010B626DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A7E272E6E;
	Tue, 19 Aug 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dy0rrFeA"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF426D4CF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645228; cv=none; b=HUD5tWTfHEL2WmmzzMI+7h1EHcpnnuQkQPH6anmTstT/r8MasyUYYCzhBR61HIcdtReecUWIh7Hr7mp2zY9uGXKJlEEt00AHW1EHxdg+RICYyMrgGKq6Vrdn9DEAPDd6VZRUgBIjCl8TgvRJDudPdUJT6guZpRSIUTnPUHmqe74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645228; c=relaxed/simple;
	bh=cGNOTZMVGC8+irNnOZMJx/9tij9MyZWxTQqOv08umiw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=joK+UI/oKroY/jzusCum2QrzloeAQrbjVWPFEd0z3BLKEC/JNfUKFtcBguMyNigQ6DeNos4MTli3KAV9tOzoo4IeuAGHkATOgiDnFOOInbHW90L1SPYNrZiLGJ3YT1mnKGwkrmROFVkZWX8+hrbRpv+aERcQZ/gHTX7d+kFjQ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dy0rrFeA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266d8396so5350048a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645226; x=1756250026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=msUMnF7kfiP2kpaQ8gwocYWiZP7HxJwC7ohBJtbK3C4=;
        b=Dy0rrFeA9Gs/PAvq22/75hBjcAhs7qZePnONXc74q/nYuL8KMvEz/ovuw1N3mblD++
         g4WMIr3DKntRWinF6Bw+IDwqDGjkGGwexbOHrbCwN/kxcR5WbqVOQJzHAn+wmzmiQ+Wp
         63zBkDiEXX2H8KkfNFAf8fqOKYRayHRecx19HHdlq4/7KQQPRPuktFAxIWDiJbokgiZ9
         hSvOwsP1K8Le0Pnjsn1/2qOs1OJgdHMwLUZ5h3IbBJqEzXhy/+KnUTVQugjtpbAkBWuA
         i7bvPemZaxJtWQVlGdr9c4LCrcjx+puTbypT/7Nu2WCCexqxcTU40Y9sgifK1AouPnN4
         6F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645226; x=1756250026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msUMnF7kfiP2kpaQ8gwocYWiZP7HxJwC7ohBJtbK3C4=;
        b=LTiirsdA/WIbJ2Wp2Koq99IrSe9CB9c2eqUgzDo5RwEuSuC6uxy8TCJQ6LxXLpBzLW
         wBe+ZMW/BpE2yOd8+F2LlUPga1x3aTpdW8AXke80WXv//nZATP2YXbgbQ59Ud9reh7Ve
         gIJSYYl2a5lTlKdDgk03MHUTc81NDlzP1NCiCdhLtOmU1UaxpSbqwv/GiULzoM2d/sKa
         lvAQ0Cx+cCwfwop62Hwfc/wsBoX0fBucKyQdVcUR5ZsOS2mF5i9piDTmV5HUHtCosj5b
         Qbg1NfcHg8M03aVdK3Wm8CFR1f+OCwnVi1WRfeK+IYMBIGTw3MTcsT1gWI2EaINUdIdi
         V6SA==
X-Forwarded-Encrypted: i=1; AJvYcCVUPPyABSiSOvnv0P/H10MP/bbk+E0KUnSqBKvtep0sNMQ5tqNbDYELehQrck2+6zMMb/gF1Pyxe1fx5AM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhw8ghDTkPqY7SOJbnvy2r/x2KEYtQigKgh/jppwJdvTXBjZJD
	+cdOakXD4QlWm2WM0sU7XtgET1+WBcapj7JKEoQFBhRriv9cMYJSoxyerQGulnSEaYts01oh5vo
	GVP8VlA==
X-Google-Smtp-Source: AGHT+IEzrQ3E2CTunJTK0cD2CEbgpKYTdCc3ho6c674KY67nTnizKNX9Zz4wx9giYRjnRZd0mIVmjvJzo6A=
X-Received: from pjbqx8.prod.google.com ([2002:a17:90b:3e48:b0:31c:32f8:3f88])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5868:b0:311:c5d9:2c70
 with SMTP id 98e67ed59e1d1-324e12e200fmr1160909a91.15.1755645226282; Tue, 19
 Aug 2025 16:13:46 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:11:55 -0700
In-Reply-To: <20250812025606.74625-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812025606.74625-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <175564447877.3064634.10238926163407823114.b4-ty@google.com>
Subject: Re: [PATCH v12 00/24] Enable CET Virtualization
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>
Cc: mlevitsk@redhat.com, rick.p.edgecombe@intel.com, weijiang.yang@intel.com, 
	xin@zytor.com, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 11 Aug 2025 19:55:08 -0700, Chao Gao wrote:
> The FPU support for CET virtualization has already been merged into 6.17-rc1.
> Building on that, this series introduces Intel CET virtualization support for
> KVM.
> 
> Changes in v12:
> 1. collect Tested-by tags from John and Mathias.
> 2. use less verbose names for KVM rdmsr/wrmsr emulation APIs in patch 1/2
>    (Sean/Xin)
> 3. refer to s_cet, ssp, and ssp_table in a consistent order in patch 22
>    (Xin)
> 
> [...]

Applied patches 1-5 to kvm-x86 misc.  I still plan/hope to land CET support
this cycle, but I wanted to land the MSR refactorings in particular in case
other in-flight code is adding users.

[01/24] KVM: x86: Rename kvm_{g,s}et_msr()* to show that they emulate guest accesses
        https://github.com/kvm-x86/linux/commit/d2dcf25a4cf2
[02/24] KVM: x86: Use double-underscore read/write MSR helpers as appropriate
        https://github.com/kvm-x86/linux/commit/db07f3d0eb19
[03/24] KVM: x86: Add kvm_msr_{read,write}() helpers
        https://github.com/kvm-x86/linux/commit/c2aa58b226ab
[04/24] KVM: x86: Manually clear MPX state only on INIT
        https://github.com/kvm-x86/linux/commit/41f6710f99f4
[05/24] KVM: x86: Zero XSTATE components on INIT by iterating over supported features
        https://github.com/kvm-x86/linux/commit/c26675447faf

--
https://github.com/kvm-x86/linux/tree/next

