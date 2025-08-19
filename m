Return-Path: <linux-kernel+bounces-776444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4345DB2CD5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D551C258C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A282A310620;
	Tue, 19 Aug 2025 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YToC+FKT"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C1028489E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633224; cv=none; b=hJlERE5ix3eO9dTgvtduI5TdfLD/qxsK7H2SPLpWIm0efJNj1S+refMn5OKStURjs+WqpNbGFzguXyAGcfA/ZhL/NdMUAkUjAf3lfJYxuN0uB3PJtMlAGrOMiA84AvbY1T9urx7bfY9jiY3E6hw9I+y/pj4rjZUg4O1kx5go7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633224; c=relaxed/simple;
	bh=fS6j4mgWa9VcBbnm1aYEVqbu0SbI+LKwaOyUx0Dl64w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hs8IyDVP/d/jtpqtp6t+9BFE6a91g6ui7bFHLvYMWZZ/ule15D/VF/SFpxvK6cqwL6legrT9QW9edvX6AH+IjiAM6L+9H8lXlH11W5CM6I0iSXiZKsjPqoD4wrtB7KpfBLXeaRP0ZU1LC96JzbbkyQxsB6nAovtAYlNndkTi8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YToC+FKT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-242d3be5bdfso40385ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755633222; x=1756238022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNbjqk8ttaB1ro/8zTt9BTLxqyHuv5ELRRxuG73JV9U=;
        b=YToC+FKT+vj5xe3mYSuiQrxDnA9d17Mbog75ZSu9LgZ2hcwfro5NxeATdJuPyoXPa9
         2HaDCHVZlLHfYLr+ignzGbiRUAdS2tfn9n3QXNfOmDIwxQxUTUkucyeLLE2ir5uyRwUT
         uCi6WByZu2dJw06RJCv6mnCtxGTsuDmtNv89nrBpQFH656SNVE0K2y0a1iUTAn0U/cH4
         tTsnILM/C7B1wMWoHi1JGOgolywRHggsGcqpMMGKhdW6+eLBhwHTl1/HJsrZeIYR0hLl
         1mYvEVDT9epJJFYL/KUxhKhT0vdAYTSD+pNOe+6VKyW+gXhHlWzQT7QfXS+C7i7sGRMF
         xlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755633222; x=1756238022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNbjqk8ttaB1ro/8zTt9BTLxqyHuv5ELRRxuG73JV9U=;
        b=VoH/8VgFj8pVZGKFThV/w1NKn6g7sfFqfOZWubH7dWc/8l2/5gppcDM51SLDAQupOj
         Huhudn/AD9a5TSdV1E75zVaX2o+hxyEQ4N/BPPt/Ivrd8RT/05lZRXS+fwwcYifnsPUZ
         i1f0JIfkD0aiejWg6LYHEFpSKiEPmTxMejsyjXty7BS73UB/PHX3E6ChmC2JdAekJHvA
         X0bPdiywU9/Z93//jl/tqikgOPS+9ycVKR7FS2sEe97cdN6Btqs4g+3e5itAsEfn81eH
         TOULucbQERlOLhQmXiOFds1hJRTMuhnzoGYQsguHosC4eFFwl14lkxl9YMvIzXhQInBO
         fw3g==
X-Forwarded-Encrypted: i=1; AJvYcCUyQRbTqpmQiarzLFyDTdAp97OEGIAXn+mwCMWT3KN6J8HphVdk5J1ZSoOIIVPh4k9/XAD/pKh1C0al2B0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx115Nt4ckmtIL71imc8W1Cys2zxLgVBcLmSauyUsbxu22roB+f
	V5i/UeQ4NDFDfcly+yIT0f9UkrbZbZvoASP+YEdpEMT+QH8e+qyeURCXsr+Jj7XadGNVFyftaSx
	R8FwSCrsF5vGCVa9MhzT8mG/gbUctFUmluKD+eNZL
X-Gm-Gg: ASbGnctwp/CfrJ9/zsUw4GVGmud3gjJi/MZ3K2NR02JnZZSHaDZr8Ko9bpxP11kV6DK
	GTbuXL3HQrte8lABq45D1MiGLAginLvRm0uEMDlvyPbR/+ib7lkhOF8CoqXojZHTWr56+mNHz1e
	gcZgTjHWy/cRQxaJsCfL2ahJFyxiqGPQdBZts7lB3mvbGrCMHa6PgrrOVW9pSSAZlqXnrDOkS3D
	/p9pXl+O7s41XqRK+EXF2oR4DWpk70OvpY1LnZ8ksAO
X-Google-Smtp-Source: AGHT+IG4CJE3FrmMgTu10qv+0+tLItc8I/b4fe1ou2jr3vSGPnHMMk3cVAozTTrsTuTDIcAYq5uyhlT4NUWU1Gr5ayk=
X-Received: by 2002:a17:902:f64e:b0:240:3521:1345 with SMTP id
 d9443c01a7336-245eeb80067mr604135ad.17.1755633221217; Tue, 19 Aug 2025
 12:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819155811.136099-1-adrian.hunter@intel.com> <20250819155811.136099-4-adrian.hunter@intel.com>
In-Reply-To: <20250819155811.136099-4-adrian.hunter@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 19 Aug 2025 12:53:29 -0700
X-Gm-Features: Ac12FXxiS5LogQBLTdGRUCr_RpTV5puNW2fnnQ0DolA4sVJEIHlcEAIFzo6FHOk
Message-ID: <CAGtprH-es5yyNYQCBhwpq2sJb2ET+Jvq+YNB+zvrdatCXqhZDQ@mail.gmail.com>
Subject: Re: [PATCH V7 3/3] x86/tdx: Skip clearing reclaimed pages unless
 X86_BUG_TDX_PW_MCE is present
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, pbonzini@redhat.com, seanjc@google.com, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, H Peter Anvin <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kas@kernel.org, kai.huang@intel.com, reinette.chatre@intel.com, 
	xiaoyao.li@intel.com, tony.lindgren@linux.intel.com, 
	binbin.wu@linux.intel.com, isaku.yamahata@intel.com, yan.y.zhao@intel.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 8:58=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
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
>      access (refer TDX Module Base spec. 1348549-006US section 6.5.
>      Handling Machine Check Events during Guest TD Operation).
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
>
> On platforms with the X86_BUG_TDX_PW_MCE erratum (SPR and EMR), continue
> clearing because these platforms may trigger poison on partial writes to
> previously-private pages, even with KeyID 0, refer commit 1e536e1068970
> ("x86/cpu: Detect TDX partial write machine check erratum")
>
> Reviewed-by: Kirill A. Shutemov <kas@kernel.org>
> Acked-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Vishal Annapurve <vannapurve@google.com>

