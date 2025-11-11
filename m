Return-Path: <linux-kernel+bounces-894970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 865B5C4C967
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF901886213
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CC32E7F05;
	Tue, 11 Nov 2025 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKVSTcn1"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FF02D130B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852314; cv=none; b=hj8T6ggERfcwh3bGo/z3e3NrHrAeyvp2Q+iXUekLqQ+KHMKOWyELtExzTXGfssrRje614Tf8UOvtl3RBHsYa6F4uUIjtbg9/KUvTvf1oODIqPQtmUYi9wvaH3LeWs6z+kcEnaPlddNtHXsI1nGrIZxsEquGSVW2zr/bsQ2dSKiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852314; c=relaxed/simple;
	bh=wMAn9oTbF3Zv6YZXMFgD9SCNTI8yFt+ADFGBD5EQzqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6945gMCNeBPMvjf5S6QwhIBMjiFcElOyU9vn5mkhgzkcPmLQUi2SWXGivLZvcHinUZzLcdCGZWIdA+1EeLzRgCG3N2tCKfyxoHVPgbnWvg+4ble7pYGA3t9iQ/UOHrKpOru5MIQpNmM2TjqKnN9RKdXUzW3ypGEEbqMELqbPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKVSTcn1; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-882475d8851so25972006d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762852311; x=1763457111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMAn9oTbF3Zv6YZXMFgD9SCNTI8yFt+ADFGBD5EQzqY=;
        b=SKVSTcn1nqhQszrNr1vdsVjq8dSl9VoDABDmD7if+9Te7wJ6J6rDS7S50aJ5F69y5E
         k4E9UZLYEurZWvTFPpJtJmpQVO3sKLOFk33oROWR9PjaRKPOsNd9aIYs2Y4bP40twuFV
         y1wrJMuvjyGBhkWCw3NnHtMMBsAFT6HV5rwS0nU4gPbq3bG2iZG/R2yPw1hk3j+U4wY4
         bsViKBtjl6JHn12zl48f6GCXe8krAM52fMG1bqA0czRerGWV5m+KbPcl9pnvA5BYIhhw
         DYQCwvEA9PdZfsUncWAr0Lmvzq5AS371Eb5x39GczPqGUwPamAPNdAGl6KWLGNK/6P4W
         kvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762852311; x=1763457111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wMAn9oTbF3Zv6YZXMFgD9SCNTI8yFt+ADFGBD5EQzqY=;
        b=KC4ndJR8Y1SM5z/JlU2W/mxQtz1NAR2OMGJTGYTQ0NO1NEnf+d+8XYBMF3oCxSILox
         eznCbcol/NGpYLOElRKtQ29y+tcqhYuA7gqBSD+8h0R8HH7fqG1uJv7JAE2ks2zlK2Lp
         zYGvFS09QSO/3m6YTpDi/LE0V//e4zQpLwCP5STyhd+WSzL87fl5I8IHDwlXzqzNF87V
         7QbDRfg262Be8BhxULaNRtR0SyGHlg2pJgiKqRhIL1KQ6qkCxIsRiRh9LB067zNBcIdj
         XTc5u4S1y9GENyqGvqkqbB4bkfIOAuwlFAiBa7YP2IiAm977odHqh7XghCfz/dZNMZCO
         W+uw==
X-Forwarded-Encrypted: i=1; AJvYcCVT02AH3fQL9r7guq6rgo3daTSNikxc84ouBBeA+HtX+ryrERoM6MnjUs3vah5mnFl7Hw52SJrGLIN4RM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6UZ2s0fOCnbfWAalLjwwRSPsymKEX6pPCMfxkSrK1QT8oC4Hh
	nNupeXT2Q2kwzNGYP/jy14m1whOZKs1+uZP7l9wV5teQke5PUxowXicXnXPvzyrOwhL6QMFikJa
	1ynXl67RnakA/6ewWaOt8JcNThDi32hTfEOD6Atht
X-Gm-Gg: ASbGncvvlMhWrBG+tyy9mkKzmj3MeGb3hJao2JoUu2SfmAqCqh0yi650abebBYLUoU3
	kNJbHUpTqAeejXBfBbQ/J2lAQp7jgbHed6XFSx/tq+OiK/2A93EaGXCPJEwkf4kfQzMBbGvaBKP
	XCOtWtHnmmaYkk/GPY8OS9YD0GQQcYWQF4ugg8hoBHJW1v48upi0Hhhx2HblMs/lLmWkLQiZaGS
	yXRoFDU8Np8gjFow9Xk+5M5JfVVSlNl4eeIMRZ3f+n6f93VXl7oULcV+mWzgCZC+KC+je5Uaox6
	k5eg1bQpZUWLd8W8wyB1QkNu+5uaDjRV3WlL
X-Google-Smtp-Source: AGHT+IH+IyV5M3UDNVO30prt5PPyyx1n6sQAkg8H+r/cXESUVZ9Sxny0Upk5iwgOz2Gyh93ucwAfPrYSF2wYVT/cQJo=
X-Received: by 2002:ac8:7f84:0:b0:4d3:1b4f:dda1 with SMTP id
 d75a77b69052e-4eda4ff2f1fmr126391511cf.61.1762852310737; Tue, 11 Nov 2025
 01:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <f533bb094a566242ec196afbde222796c6d6c084.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <f533bb094a566242ec196afbde222796c6d6c084.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 11 Nov 2025 10:11:14 +0100
X-Gm-Features: AWmQ_bnrR-pK5Rc9D-XEScjrYr9MOeawukkWZRpWJ1yHRGagV2Ym8rHVDa4nqXc
Message-ID: <CAG_fn=X-FB6vVtDC8WhQzF7cNePS5AtmC4W1-YfTce+5jOc+wA@mail.gmail.com>
Subject: Re: [PATCH v6 11/18] x86/kasan: KASAN raw shadow memory PTE init
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: xin@zytor.com, peterz@infradead.org, kaleshsingh@google.com, 
	kbingham@kernel.org, akpm@linux-foundation.org, nathan@kernel.org, 
	ryabinin.a.a@gmail.com, dave.hansen@linux.intel.com, bp@alien8.de, 
	morbo@google.com, jeremy.linton@arm.com, smostafa@google.com, kees@kernel.org, 
	baohua@kernel.org, vbabka@suse.cz, justinstitt@google.com, 
	wangkefeng.wang@huawei.com, leitao@debian.org, jan.kiszka@siemens.com, 
	fujita.tomonori@gmail.com, hpa@zytor.com, urezki@gmail.com, ubizjak@gmail.com, 
	ada.coupriediaz@arm.com, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, 
	brgerst@gmail.com, elver@google.com, pankaj.gupta@amd.com, 
	mark.rutland@arm.com, trintaeoitogc@gmail.com, jpoimboe@kernel.org, 
	thuth@redhat.com, pasha.tatashin@soleen.com, dvyukov@google.com, 
	jhubbard@nvidia.com, catalin.marinas@arm.com, yeoreum.yun@arm.com, 
	mhocko@suse.com, lorenzo.stoakes@oracle.com, samuel.holland@sifive.com, 
	vincenzo.frascino@arm.com, bigeasy@linutronix.de, surenb@google.com, 
	ardb@kernel.org, Liam.Howlett@oracle.com, nicolas.schier@linux.dev, 
	ziy@nvidia.com, kas@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	broonie@kernel.org, corbet@lwn.net, andreyknvl@gmail.com, 
	maciej.wieczor-retman@intel.com, david@redhat.com, maz@kernel.org, 
	rppt@kernel.org, will@kernel.org, luto@kernel.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-kbuild@vger.kernel.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:07=E2=80=AFPM Maciej Wieczor-Retman
<m.wieczorretman@pm.me> wrote:
>
> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>
> In KASAN's generic mode the default value in shadow memory is zero.
> During initialization of shadow memory pages they are allocated and
> zeroed.
>
> In KASAN's tag-based mode the default tag for the arm64 architecture is
> 0xFE which corresponds to any memory that should not be accessed. On x86
> (where tags are 4-bit wide instead of 8-bit wide) that tag is 0xE so
> during the initializations all the bytes in shadow memory pages should
> be filled with it.
>
> Use memblock_alloc_try_nid_raw() instead of memblock_alloc_try_nid() to
> avoid zeroing out the memory so it can be set with the KASAN invalid
> tag.
>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

