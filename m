Return-Path: <linux-kernel+bounces-861217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 326D2BF218C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7500E1889B09
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4A626E716;
	Mon, 20 Oct 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZQ3MC10"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7A26AAAB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973932; cv=none; b=I9ZofcN6uba+4irSOTd/f8jB2UAY4Na1v6yQ/raIkF4h8FhDJUhdQuvYKJSUuSbxQTr2vzGZOSIlQ3T2zr64Dn0r9E/Q9mpwjVVGQC2M+PJINRZj3RB94CRxj7OkbN2dcv8vb5AinUQu16MdiHCEbeT/y2fjtIAugL+m+17LckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973932; c=relaxed/simple;
	bh=X2cNT2jodYHE9VXEpV2Jc+n9s/IGEDlBeAa8Q4UPTyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dIQeBo4w8mGLE7/lNUGjvTmB0fGPBL7YkaF3WUEret6B7e0h16pPdY4mNiHYictReZT3OT7jxK49mvJiVljViiXO/DKDEi/tlPQxNHy0l0ZJqaLH9WjXZD7kXinNhig4f8ThMGE6EOxCf01gqtVDeMA4qIqdbeAXG7/BsHi2rK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZQ3MC10; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b557abaad02so7508703a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760973929; x=1761578729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8duMiPUW3Ov9cGPKQdSL4cotcPZI8856r/Bae2VnHbg=;
        b=OZQ3MC102imDjjy7y7+21WZgroY+0QHEwH2ceetvgvGjk0KWlWJ0pQqWiGE+etRcx/
         Js8ys2eFoTwW0j6EJasNYn4DvXQiZZn9vMuZ9BfGcdm1Aj8jFnmT7Ir9jBSZi/4T2A4X
         D9KSTMI4EKjBKMBm6N2w/ffq8ySX8y+U0FNIHsQ5Vks7NvSuB617s64ZQtjE5+K35/IB
         DBdQDln17mlL/YCH501RQYHbsAU4dca2scg7VX/CUzpJc3JKIWoLZmKGGtJUytSUFT4l
         wQawmRhYJoc1nJAvrMZrvyJm2ZNg/WNPdFoiRoR0ykTkhrGeJm0OYjI39jA8TdaUYtXE
         d4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973929; x=1761578729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8duMiPUW3Ov9cGPKQdSL4cotcPZI8856r/Bae2VnHbg=;
        b=bK41JPyiSl16Tv4JAUS+M9PgZxBVnsO8/51Kx7mvXcV3cfxU0BedaN+uXzq2P11+hE
         hCSsSOGRYZNrsI2Q2K9QC8vau0wREsyiNP+oe78yCfp60GzpYYsy3r6kxf4ib+kfnzR9
         A3xpZFn+FgB152C4B634qrtkOXYxB60e9kRhVwjgtIxHmZo1E0ekNzGZRHtt8cwE8NfU
         QLbXJuZSW9SETBBSQTao1FOpwyLHSKy+X85f4jk2kpIX82a29+Rkaqp1yUVeOYKGfbsd
         s1CiqXoB1lUBQtQixoQTKjXP73Uvgdf65N0faa+MZYwI6fPmK5F6tiW4Krzwe6FYmScx
         VUiA==
X-Forwarded-Encrypted: i=1; AJvYcCXCe6PzfPkalM0XZV9d1hEmU3e5DxB66gC2x+BMKqAyENcUpeXE+LxURRLj5glupBYYrzJy7IrWCZX9/Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWU+S8R+MxSXJmOl2bS5FEpPs6vqk38nZWnOX03xGu9enzKiMe
	B23/pp5wikB74niVjMI3w/1GJhj7PeYdlIownth7l291JMBZbbvMbQpiBh05AJJvxTFV7mXvv/g
	U0nd7Aw==
X-Google-Smtp-Source: AGHT+IFqW3qIYEVTbpVnhf/SO53CXDCgtTQdekIynQUGkmgpYGTVsnP6gv23UN57ly+8fm7EenYdxfMTkTw=
X-Received: from pjsc19.prod.google.com ([2002:a17:90a:bf13:b0:33b:ab21:aff7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c0e:b0:330:a228:d32
 with SMTP id 98e67ed59e1d1-33bcf86b401mr19164126a91.10.1760973929211; Mon, 20
 Oct 2025 08:25:29 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:25:23 -0700
In-Reply-To: <033f56f9-fb66-4bf5-b25a-f2f8b964cd4e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250910144453.1389652-1-dave.hansen@linux.intel.com>
 <aPY_yC45suT8sn8F@google.com> <872c17f3-9ded-46b2-a036-65fc2abaf2e6@intel.com>
 <aPZKVaUT9GZbPHBI@google.com> <033f56f9-fb66-4bf5-b25a-f2f8b964cd4e@intel.com>
Message-ID: <aPZUY90M0B3Tu3no@google.com>
Subject: Re: [PATCH] x86/virt/tdx: Use precalculated TDVPR page physical address
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kai Huang <kai.huang@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Thomas Huth <thuth@redhat.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	Farrah Chen <farrah.chen@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 20, 2025, Dave Hansen wrote:
> On 10/20/25 07:42, Sean Christopherson wrote:
> >> In a perfect world, we'd have sparse annotations for the vaddr, paddr,
> >> pfn, dma_addr_t and all the other address spaces. Until then, I like
> >> passing struct page around.
> > But that clearly doesn't work since now the raw paddr is being passed in many
> > places, and we end up with goofy code like this where one param takes a raw paddr,
> > and another uses page_to_phys().
> > 
> > @@ -1583,7 +1578,7 @@ u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_page)
> >  {
> >         struct tdx_module_args args = {
> >                 .rcx = page_to_phys(tdcx_page),
> > -               .rdx = tdx_tdvpr_pa(vp),
> > +               .rdx = vp->tdvpr_pa,
> >         };
> 
> I'm kinda dense normally and my coffee hasn't kicked in yet. What
> clearly does not work there?

Relying on struct page to provide type safety.

> Yeah, vp->tdvpr_pa is storing a physical address as a raw u64 and not a
> 'struct page'. That's not ideal. But it's also for a pretty good reason.

Right, but my point is that regradless of the justification, every exception to
passing a struct page diminishes the benefits of using struct page in the first
place.

> The "use 'struct page *' instead of u64 for physical addresses" thingy
> is a good pattern, not an absolute rule. Use it when you can, but
> abandon it for the greater good when necessary.
> 
> I don't hate the idea of a tdx_page_t. I'm just not sure it's worth the
> trouble. I'd certainly take a good look at the patches if someone hacked
> it together.

