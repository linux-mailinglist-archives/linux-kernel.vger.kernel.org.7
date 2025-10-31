Return-Path: <linux-kernel+bounces-879515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C25B4C2349E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B99D3A93BD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425372D8362;
	Fri, 31 Oct 2025 05:28:24 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25202D77F5
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761888503; cv=none; b=KLmPfcjJp31gduEz8XI4E6L3mMZxuTrpI0NdVz/0MKACyr0+KEnUaZvzuMEwDeo+g9kCz4ObZipEEXQaFsvi1M+Ak9yxPpS6+SSOF7ncNIyOnIycAtMZUfdEgFZl9NW5Ku02RR4T25F/JSj9ui7KNbxG9gn1BVsam77+mksjwns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761888503; c=relaxed/simple;
	bh=pqE9Rb4ICM67LXGEhPtxtgsqOngcvbeqlTIxwrpVoxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQ/elX3AN6+D77wtJt1kcM0agg2mTKbRtSyMH2XJ6HcgypN08ibpMgvKAcBOUaiAUM2aK5cJ5LpxB7I78ZpHV/AL92G+jAjtj1Bj3DysPOSfzUIqcPK4M17bvgOmkodCWn1VZ+HEJyIPFSD1+aLT44cZ4Q1AnbcZ2DgSjQ9Xsig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-934ad40c2c2so816790241.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761888501; x=1762493301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqE9Rb4ICM67LXGEhPtxtgsqOngcvbeqlTIxwrpVoxk=;
        b=jn++aBi6bRsqyhrlkhmAWtDBtrZFxOJ3OUScEz1XY71Y9nHiRbQiYm5WwvXIj2T+Vh
         6SJtD5kGzWrL00dA8h2BQx3nsi45v4lBs//Cc8ws/tYpn80IXcO1z4wiAMYEGj2GdKrT
         O6BoZlOe0TQFGfVxm/LjUp3JtY/Y0f12QGVYz0ZM2XR84jwX+kjS0D482RblEmT09uqw
         vv4ZmmyZ6gDLrL1JsrJF5/SyR5bw5zOJ9ia9PhfkjZaK+/G9R3ed2ALb26VMUfCnNj3Q
         vsS3S79eyi+njG9+mCqesYohfZtokA2fVfWg3S9/3zdE+Bnd4Dn6wK2qCW1PrUeOCt6F
         Jj0A==
X-Forwarded-Encrypted: i=1; AJvYcCWUCK0MEs4yoXtpnRpW8tKnFHO0WJTq3SFavXTgNAFv74Y4P6K9QOpCxw/HMSt9wRigI0sozTyrGV0F2UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMTVRerRyyq0SkJISAtOMe8HvnfUl4VhO0VuKXpOtjr3McGid9
	DdWFJSbPdqfMr2DXhglrkDanerVxKR6BvOyC7Q9Hq2qog4/bW55cD8B9wL4GlA==
X-Gm-Gg: ASbGnct1qnFnjLVzqVJ7T7oPv32aA1rA1eSLiigu7dLJ7kZmgTmGgwV7a7I4sqFl2Bu
	qbCdfPmYgNT9N8DnltjMzg9eXz8RQOFNMCEnV8jbQOPOH1Z+YHNsqXTMfnpWhxwHzUQzgbIL09X
	0FRkyvLhs9tiNYnpsbN5keq3JAPaJ8vil1HzL23XcBRhWXq10NbUfM7eM8thqP0pGtCRSLo8izE
	1ADQB7ET5lvOG2NpN1nq41jV96aJkUf9Q7n3zcqkwro4dyIFYs5+D+50l8wbch0tcc7SUsCqeK9
	ytJP+W6P5kjren2v8BWY25T1rCTShJHEiW+QYVuDlMkN2hE4Mgx4+VvDB7xi0S3tovONTOMDX3y
	hLGOVy58OeL4SU8tX9nmUO63W1sd5ndfJWU2aK1SnDwjpT8bgqn1Inzo+rSZB4cIplL8TEEo5NP
	Vv/4vlDGtnByvL5kT+6sAtSVWa136QNduj9E8KzXG/LPgmpCc8pfs=
X-Google-Smtp-Source: AGHT+IEO4qyTYXVH+NkLC8Gov1rIKLMvRVeUQxjachcLV3E75/yb2Gwz5B9F+TZiyTYx+UrKQzdjWQ==
X-Received: by 2002:a05:6122:3a1c:b0:557:c50d:6a14 with SMTP id 71dfb90a1353d-5593e4e9335mr807948e0c.9.1761888500589;
        Thu, 30 Oct 2025 22:28:20 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55944993ccfsm305963e0c.7.2025.10.30.22.28.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 22:28:20 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-89019079fbeso961734241.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:28:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcjGdTGcqs23aMbtwsiyPNDlElgR7KQMygWWHmuHGDUf0XPQKO8UDZKAoZwUfcqkvuxKogPHdlA/hE0J0=@vger.kernel.org
X-Received: by 2002:a05:6122:80aa:b0:557:c97f:f987 with SMTP id
 71dfb90a1353d-5593e5962d9mr775699e0c.15.1761888499850; Thu, 30 Oct 2025
 22:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
 <CAN30aBF3MofmVTjTZ9KFq9OBM0nA16amP5VFv+VAEJfFkLx0qw@mail.gmail.com> <20251030133323.3a81c02c@gandalf.local.home>
In-Reply-To: <20251030133323.3a81c02c@gandalf.local.home>
From: Fangrui Song <maskray@sourceware.org>
Date: Thu, 30 Oct 2025 22:28:33 -0700
X-Gmail-Original-Message-ID: <CAN30aBHs_i=Vp0XMRBLgHVtLLCsFCHTRXQFDAeoqpmCgqhST0Q@mail.gmail.com>
X-Gm-Features: AWmQ_bkkCBb44J8qydEViwGcv7ZrA-RSfc0m9YrKRUVjSWUbtdYeuweqQzkIKto
Message-ID: <CAN30aBHs_i=Vp0XMRBLgHVtLLCsFCHTRXQFDAeoqpmCgqhST0Q@mail.gmail.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:32=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 30 Oct 2025 09:48:50 -0700
> Fangrui Song <maskray@sourceware.org> wrote:
>
> > If SFrame is exclusively a kernel-space feature, it could be
> > implemented entirely within objtool =E2=80=93 similar to how objtool --=
link
> > --orc generates ORC info for vmlinux.o. This approach would eliminate
> > the need for any modifications to assemblers and linkers, while
> > allowing SFrame to evolve in any incompatible way.
>
> I'm not sure what you mean here. Yes, it is implemented in the kernel, bu=
t
> it is reading user space applications to get the sframes from them.
>
> Every running application would need this information for its executable.
> The kernel is dependent on user space having this.
>
> The only thing the kernel is doing is reading the sframe tables associate=
d
> with the running applications to be able to walk their stacks at runtime =
to
> do profiling. As Peter asked, the kernel cares extensively on that walkin=
g
> being simple. If something goes wrong, you compromise the entire machine.
>
> -- Steve

I suspect your concern is primarily with DWARF expressions (the
DW_OP_* opcodes), which are needed for complex, unusual frames.
If the perf subsystem ignores those and focuses only on standard frame
layouts, ensuring safety becomes much more straightforward.

Compact unwinding formats are designed with this principle in
mind=E2=80=94they don't use bytecode CFI instructions or DWARF expressions =
at
all. Instead, they use a binary search table (similar to
.eh_frame_hdr) to locate the frame descriptor, then decode it using a
straightforward nested switch statement based on the compact encoding.

For reference, this is llvm-project/libunwind's implementation for
i386, x86-64, and aarch64:
https://github.com/llvm/llvm-project/blob/main/libunwind/src/CompactUnwinde=
r.hpp

