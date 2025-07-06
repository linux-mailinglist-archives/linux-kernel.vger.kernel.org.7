Return-Path: <linux-kernel+bounces-715838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61D3AF7E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 19:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A60564E06
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B3C25A2AE;
	Thu,  3 Jul 2025 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OY1d3Aj0"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7D11FDA94
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751562411; cv=none; b=oDLVXv8kqxDU4S/8tOzv1d/lmOaCH1fhy4lUvq5ZjErTIdJAqSOxrPoI/T5t6XmHafmBYSp1adJcWPNgU9Xnf8304WBFPlw7KDdOpo3dXKA7X3ZHehFtqXCACkJAk48C4dqKT+iaLuh3aYCYYzI0uDPoPZur4f5CFvCwYUdchI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751562411; c=relaxed/simple;
	bh=XFNc6xwG91kOZJ6aXSGb8CW72Hy9fPOUos38JJjfZ2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5n6PkJQraadau24DLRHBCCM1XJgnMvYiHI7t6T+VpXPadPsxCz+4KfjvRIx4qtyhD0QRNo3rFpiSf+GPTpyebwWsGqiVD/QjzhOxDzTpZ6ifuDvifAHr3E6HVRy0K6S4WjtVOEw7sbsQ2XXyO5DHEafuTrwKpnRa2v0NJrQd5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OY1d3Aj0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-237f270513bso181255ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jul 2025 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751562409; x=1752167209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSF4ELCBcv/ejvNBGx8gge/whzb89lSTMsKN5499Igg=;
        b=OY1d3Aj0iw5mbQ740COCI8giWXRoFvZfX+og0zTyUWIE1/m86YQrk0z45uQHGAQ58W
         N12EUnnhJpAUKrX3GI3wxSe5xVgvDEUdqC/3Cfa0e+zF6RIdGQLJV6w0te69okbWWA3O
         b+px58PehJNqUTMpg5zK32DwhNwD5aGCo0awqzeDLIxA1HOijYd0/4GAPbCFHTpBVS6z
         P4/UxhIskytLXfavh2fdPEvrWEa3JhWaE76OVryl0/MFBNVIt5Kl/HB+ZVnD3h8NDNea
         Zr9O5WSBASCaXte7Z/Sa69dcyKKhXF4CjJ4DuNqT/Q0cKKcDxRqxzEoMHcrot+TACERV
         hjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751562409; x=1752167209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSF4ELCBcv/ejvNBGx8gge/whzb89lSTMsKN5499Igg=;
        b=ISj31tOlhjSjYKSWUmgBVEXlVgHelBLvMq4YoZ1Ac+4BKzOGOC5ebx/FW8477WEagM
         LRXWvDZT0QPCZpfaqoq5GnWZvftfAwVhkrJl4LwcXuM9yWOjfy3crF2DSYzKnMM+S0LB
         f4jHmbtI1G+67kXIM0ETgOweU9aMcweHc0HSt0vz/h/pFrqPirrpkeadrEW4y5KQViPN
         xK8Fk9i6MfPJkAWYyYXud2Vbbl9zrlf2va0x/5NfAQ5xbn0EFz2ItzORNt1J87sOKTR6
         rY7F1VfXSG5pMgKlqt8oKBjk9ioF4jdZxRTWCPVx9QMMGG5eAadvb5LvbhesDSw66iVJ
         vGwA==
X-Forwarded-Encrypted: i=1; AJvYcCUdFoUv8aatutfh5KjUum7OvqHIHeP2TpgvETAREt8hQtfnGFS0IXOJ4fPqCdmepAfrgYfPEHMYJJzdpmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcoFbH7LTfRZSKUB6UTv+JhixXfPnEq3OhOCsWRko5WiLoWQR6
	+Ie4THadb/VvEUiCYXPDw+fHheHNMbI+tfGc31faLJNDS9OiMYWc7SjMrT/lc8kwXC48MKO3SXA
	B3TUQIZZYOujOA8v6+rC/Zqrn4Fddn+f7cKkkczO/
X-Gm-Gg: ASbGncvW8D8Tpc2xTgGkHQTMQXlgSGo0HtRkVmGp6Fa5gcqgFyDcMhA0WxwwuLvTLGO
	OlKOmx3qci1tODdq4o24yGE7Nbq2qVMufvpETy3Gtaz/9BexRb8VCmMlHT+P7D6EK1zyDshcLMv
	/4puO9zMNpBViS8qkLSMA5qVvNpW3aVOb12kuBfQdvnDl2VhWs7j2iBg5YjNOwE9mirMXhnmAWY
	LX4
X-Google-Smtp-Source: AGHT+IHnnWGdf8QmGd8Hr11wufvvjdMxb9FgDXbu5zs80+5lo9XttQnuQtD5i4SFQ9YHInr7O8nelhdPZGUB0tytAnU=
X-Received: by 2002:a17:903:204b:b0:237:edb8:21c0 with SMTP id
 d9443c01a7336-23c7abfdd72mr1670955ad.11.1751562408792; Thu, 03 Jul 2025
 10:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703153712.155600-1-adrian.hunter@intel.com> <20250703153712.155600-3-adrian.hunter@intel.com>
In-Reply-To: <20250703153712.155600-3-adrian.hunter@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 3 Jul 2025 10:06:36 -0700
X-Gm-Features: Ac12FXzZsjzgSZaYmWaV1ygqhrAm5h_0gcwl11dKry4BPYHYYH2L_GTimadldqw
Message-ID: <CAGtprH8boLi3PjXqU=bXA8th0s7=XE4gtFL+6wmmGaRqWQvAMw@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] x86/tdx: Skip clearing reclaimed pages unless
 X86_BUG_TDX_PW_MCE is present
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, pbonzini@redhat.com, seanjc@google.com, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, H Peter Anvin <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, kai.huang@intel.com, 
	reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@linux.intel.com, 
	isaku.yamahata@intel.com, yan.y.zhao@intel.com, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:37=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> Avoid clearing reclaimed TDX private pages unless the platform is affecte=
d
> by the X86_BUG_TDX_PW_MCE erratum. This significantly reduces VM shutdown
> time on unaffected systems.
>
> Background
>
> KVM currently clears reclaimed TDX private pages using MOVDIR64B, which:
>
>    - Clears the TD Owner bit (which identifies TDX private memory) and
>      integrity metadata without triggering integrity violations.
>    - Clears poison from cache lines without consuming it, avoiding MCEs o=
n
>      access (refer TDX Module Base spec. 16.5. Handling Machine Check
>      Events during Guest TD Operation).
>
> The TDX module also uses MOVDIR64B to initialize private pages before use=
.
> If cache flushing is needed, it sets TDX_FEATURES.CLFLUSH_BEFORE_ALLOC.
> However, KVM currently flushes unconditionally, refer commit 94c477a751c7=
b
> ("x86/virt/tdx: Add SEAMCALL wrappers to add TD private pages")
>
> In contrast, when private pages are reclaimed, the TDX Module handles
> flushing via the TDH.PHYMEM.CACHE.WB SEAMCALL.
>
> Problem
>
> Clearing all private pages during VM shutdown is costly. For guests
> with a large amount of memory it can take minutes.
>
> Solution
>
> TDX Module Base Architecture spec. documents that private pages reclaimed
> from a TD should be initialized using MOVDIR64B, in order to avoid
> integrity violation or TD bit mismatch detection when later being read
> using a shared HKID, refer April 2025 spec. "Page Initialization" in
> section "8.6.2. Platforms not Using ACT: Required Cache Flush and
> Initialization by the Host VMM"
>
> That is an overstatement and will be clarified in coming versions of the
> spec. In fact, as outlined in "Table 16.2: Non-ACT Platforms Checks on
> Memory" and "Table 16.3: Non-ACT Platforms Checks on Memory Reads in Li
> Mode" in the same spec, there is no issue accessing such reclaimed pages
> using a shared key that does not have integrity enabled. Linux always use=
s
> KeyID 0 which never has integrity enabled. KeyID 0 is also the TME KeyID
> which disallows integrity, refer "TME Policy/Encryption Algorithm" bit
> description in "Intel Architecture Memory Encryption Technologies" spec
> version 1.6 April 2025. So there is no need to clear pages to avoid
> integrity violations.
>
> There remains a risk of poison consumption. However, in the context of
> TDX, it is expected that there would be a machine check associated with t=
he
> original poisoning. On some platforms that results in a panic. However
> platforms may support "SEAM_NR" Machine Check capability, in which case
> Linux machine check handler marks the page as poisoned, which prevents it
> from being allocated anymore, refer commit 7911f145de5fe ("x86/mce:
> Implement recovery for errors in TDX/SEAM non-root mode")
>
> Improvement
>
> By skipping the clearing step on unaffected platforms, shutdown time
> can improve by up to 40%.

This patch looks good to me.

I would like to raise a related topic, is there any requirement for
zeroing pages on conversion from private to shared before
userspace/guest faults in the gpa ranges as shared?

If the answer is no for all CoCo architectures then guest_memfd can
simply just zero pages on allocation for all it's users and not worry
about zeroing later.

