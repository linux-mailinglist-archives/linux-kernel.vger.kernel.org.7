Return-Path: <linux-kernel+bounces-726578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA597B00EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CDA644B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3072D2C08BC;
	Thu, 10 Jul 2025 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OdG/ekYj"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE682BD013
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187258; cv=none; b=SXukeGFJJKx1ZRAxx4diqZMzAO27zrdjPJG7i3oV+KLHHjYM0Ezl5/BCSdAeUIypYFjvKxVjGOxVfeVbwBm9sQrpQbiLfHefUTXmnuXQAqcenmZiW73tXVg2d+oUu1ARTZU5aPMMnDTpAw2bQ3Y4yj0ptEYTbCcp7SnbB7ZeNSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187258; c=relaxed/simple;
	bh=rkYvC/hLm1zxzUDW2ngueVIOPaIZfje0rU9DgOXSYiw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TE50TPjXV0iGxunugmWQ/8hNDfA6WFSC6kn90XBQMCfmnFi0mF3rtyJ91Wapwfhxl/Tp6op9TBL+c303AKwaz5vU5zM/jAxOcLBdLWqwEkXHDWE2YTTO8OwHzjIamAx2ZEhBQYu4vZA/oyXGfGzHujrcVmysNGJzmLswA7sQ4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OdG/ekYj; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31cc625817so2087592a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752187256; x=1752792056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg/zpR/MVBtYaD2VmbJBetWuckcaW+z6F/PTphqosL8=;
        b=OdG/ekYju2YLVQ6LrcDVPcXdyffTBRGNf4BO7d+t9Ps3B+ZyPdCLUrPdYcCMea2pVS
         OhoMbhQus+P/1VI6XuIO1pbGmDTYfVOJ3baQDsWbTOnTBGbF9ybQUJLymZ9FDxnyRUns
         TCIBOjKHjhKbJ2N5E1nM3KgrQ+2gP1C8l8DHCcv7LKNdlI69b3vmHkFDLHmOsUj/9/Bb
         Mt9d5+FkKxFIiUaP78U8hQZHeW4Zn+GSMY4g9e6thZM91ZbuzVSt4Rkxa5UJPbs7wRhz
         88hAuaVAF8xTfyEDOayj8C/dxkx+081SekTWYKldLxnG38gkWHhMXLhG31MZgSZvgiU+
         etiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187256; x=1752792056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg/zpR/MVBtYaD2VmbJBetWuckcaW+z6F/PTphqosL8=;
        b=waa5OtBdDlgIOWI/voLydrMMT5bEaRzzGwKidJRd3+UmKTPKODWYsPT91wi0QvNtHN
         yCNlceMDOZtVRlH54DiW0f0RS/SxgHICntLBP+6xSBFEBQwNlGF6LIxVvvM30WcELidJ
         IQVuLLLP00gzUm6V6CiB5kRNeM2kbl31ooV8fWJm1vl34iS4YngRXHIM92MqhDYMJd1l
         1lE+yhkZTlYawIBqroe6w53Gj+KazRjwLil9IrwYksH94zeYoJl3aN9OAgWk7MlVXdHv
         uMIs7YTkIuP3YF+7hZ5Ei1glKIYGq4O577tKGJcy8FQppIopbzqtU+cOiGpOqcU1g0pE
         Xlmw==
X-Forwarded-Encrypted: i=1; AJvYcCXPeLvfVp83IpcKr9S6nUlx/s9Af+/0//gFbqqI/2uEH1PetLwHDP/oZrCBTukshDAx5H617cJJlcDuKj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEEr6G/OGVdBZXSoFRAaeTH/W4qa1JECMKb5Y8ww1TtO/p0n3u
	IM7dIMs3wGrGtqfPBaoXPd2lvWAyttV68j3QaN0z/onUeA8geREoGx4snAkWB6Jceh5atS9QJb3
	DjmK6bw==
X-Google-Smtp-Source: AGHT+IHc742ruSye4OoTb/Au/x7eNNBjWEEHnHH3qF8Iq8txWo1pUscyTPynkoiHx7x2Py13DdMAWa9XgTE=
X-Received: from pfbbj10.prod.google.com ([2002:a05:6a00:318a:b0:748:da37:7e37])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d85:b0:220:2fe9:f07a
 with SMTP id adf61e73a8af0-2312551f2b1mr1418967637.6.1752187256024; Thu, 10
 Jul 2025 15:40:56 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:40:54 -0700
In-Reply-To: <d7a11ebd-48d5-48bf-abac-317d5da80a6a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612214849.3950094-1-sohil.mehta@intel.com>
 <20250612214849.3950094-9-sohil.mehta@intel.com> <aG1laKXYu7Uc4Tsb@google.com>
 <d7a11ebd-48d5-48bf-abac-317d5da80a6a@intel.com>
Message-ID: <aHBBdmdMGHbv5lSm@google.com>
Subject: Re: [PATCH v7 08/10] x86/nmi: Enable NMI-source for IPIs delivered as NMIs
From: Sean Christopherson <seanjc@google.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Tony Luck <tony.luck@intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Andi Kleen <ak@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-edac@vger.kernel.org, kvm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 10, 2025, Sohil Mehta wrote:
> On 7/8/2025 11:37 AM, Sean Christopherson wrote:
> 
> > This patch is buggy.  There are at least two implementations of ->send_IPI_mask()
> > that this breaks:
> > 
> 
> Thank you for point this out. I should have been more diligent.
> 
> 
> > Looking at all of this again, shoving the NMI source information into the @vector
> > is quite brittle.  Nothing forces implementations to handle embedded delivery
> > mode information.
> > 
> 
> I agree. There is already some confusion with NMI_VECTOR and APIC_DM_NMI
> used interchangeably sometimes. Adding the new NMI-source vectors with
> the encoded delivery mode makes it worse.
> 
> 
> > One thought would be to pass a small struct (by value), and then provide macros
> > to generate the structure for a specific vector.  That provides some amount of
> > type safety and should make it a bit harder to pass in garbage, without making
> > the callers any less readable.
> >
> > struct apic_ipi {
> > 	u8 vector;
> > 	u8 type;
> > };
> >  
> 
> I am fine with this approach. Though, the changes would be massive since
> we have quite a few interfaces and a lot of "struct apic".

It'd definitely be big, but it doesn't seem like it'd be overwhelmingly painful.
Though it's certainly enough churn that I wouldn't do anything until there's a
consensus one way or the other :-)

> 	.send_IPI
> 	.send_IPI_mask
> 	.send_IPI_mask_allbutself
> 	.send_IPI_allbutself
> 	.send_IPI_all
> 	.send_IPI_self
> 
> 
> An option I was considering was whether we should avoid exposing the raw
> delivery mode to the callers since it is mainly an APIC internal thing.
> The callers should only have to say NMI or IRQ along with the vector and
> let the APIC code figure out how to generate it.
> 
> One option is to add a separate set of send_IPI_NMI APIs parallel to
> send_IPI ones that we have. But then we would end with >10 ways to
> generate IPIs.

Yeah, that idea crossed my mind too, and I came to the same conclusion.

> Another way would be to assign the NMI vectors in a different range and
> use the range to differentiate between IRQ and NMI.
> 
> For example:
> 	IRQ => 0x0-0xFF
> 	NMI => 0x10000-0x1000F.
> 
> However, this would still be fragile and probably have similar issues to
> the one you pointed out.
> 
> > 
> > static __always_inline void __apic_send_IPI_self(struct apic_ipi ipi)
> 
> Taking a step back:
> 
> Since we are considering changing the interface, would it be worth
> consolidating the multiple send_IPI APIs into one or two? Mainly, by
> moving the destination information from the function name to the
> function parameter.
> 
>   apic_send_IPI(DEST, MASK, TYPE, VECTOR)
> 
>   DEST   => self, all, allbutself, mask, maskbutself
> 
>   MASK   => cpumask
> 
>   TYPE   => IRQ, NMI
> 
>   VECTOR => Vector number specific to the type.
> 
> I like the single line IPI invocation. All of this can still be passed
> in a neat "struct apic_ipi" with a macro helping the callers fill the
> struct.
> 
> These interfaces are decades old. So, maybe I am being too ambitious and
> this isn't practically feasible. Thoughts/Suggestions?

I suspect making DEST a parameter will be a net negative.  Many (most?) implementations
will likely de-multiplex the DEST on the back end, i.e. the amount of churn will
be roughly the same, and we might end up with *more* code due to multiple
implemenations having to do the fan out.

I think we'd also end up with slightly less readable code in the callers.

> Note: Another part of me says there are only a handful of NMI IPI usages
> and the heavy lifting isn't worth it. We should fix the bugs, improve
> testing and use the existing approach since it is the least invasive :)

FWIW, I think the churn would be worthwhile in the long run.  But I'm also not
volunteering to do said work...

