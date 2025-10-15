Return-Path: <linux-kernel+bounces-853603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCEBBDC14C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974BC4231BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C172FD7A3;
	Wed, 15 Oct 2025 01:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czvnqr0N"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186E25A2A4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493296; cv=none; b=DPTluJbcHPFb76NIswrkf2fSEQ12/ByVp9Op4MqYDpdCp7b+fjG7efBbkV9rPHzl5+BQc9T1nj5d58jT199rgIQ0MQlex2Ds9qawfv4ZbjdjeK9UvnrOlQuv9iP+fWAuxi8716sVAQTp6Nemalw6ohuBhkjmUetawS04+P4z5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493296; c=relaxed/simple;
	bh=XurOG7TpFv0gfvogsJdszOTmGbj6A3F6k9kfoi2F3GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWRZuNCnK/T3sOx1ri3Nwq/iftjYY4KiDv7XcdHpY4lGpFRYjtvJ9qyvuabrk4ExZEWpKZtMwm3hxG5XO+T68K7+SEm6CRmLJgSxUP9nPITZ/Q1Gn1GqzIo4nm/sUwByEkIn+l9+KGrU/IXv+ChbGqgjBMI57wfva7GlXFqqwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czvnqr0N; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e2e363118so50406065e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760493292; x=1761098092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26KQWOidOOOMncfnnCBb0/0PyMIloM67l5dPnBfFpNI=;
        b=czvnqr0N+eerJQJje/D9zgReXoCqNulL2VXNWGCfXQVudLbXRhpBBF7YmuXQPPZsX/
         gwqPz+dRamW8b0IrM7qXvag9sTtTB2Kinrl5LVOlkK0Pd410p1o083PYQyoRp7Hyik5Y
         6IzUg42K36rOajl5Mo72GBm0excCb2CflRNcpQVCAxGzfeId4zFPyKW9uJG7w5ktjiEl
         UTBQyVVaNNzheeSZe7o7Z+7c5JNRTT8cT0FEptwWGE/WsANYHPdXXxbuy9IM7NAMw6cX
         Oy8MR0Snt33xXmbduFw6CcYDhWw5eO2VPXkGnZL0zTdrkDrv6hUWxeXQsmLhBf3RDocf
         bfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493292; x=1761098092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26KQWOidOOOMncfnnCBb0/0PyMIloM67l5dPnBfFpNI=;
        b=OYu71plkNJGLaq5ejpjBgh0EaSDHMbnBNYqV6ZkmtFZeOWQi1BC7e6rXKKsb4kZ3zW
         0MpK7hA/ISMkDBpfbvZyjtJ5HtlHpe0VvVGgnbcBf93k7gtjYWShKawFhWZRq5t7cxiG
         VeWO1IWBxy/CPhtafIb7NzG2gBc+IE2IO5EHC9Ewas9IN3qtghu40lT+h7zfWB9rCYHp
         DvolZI6tEvPowQA22krfYKSowvFHDdIdfcS59w8bcTg/MBkbwgex1RcrYSrHhry/wDr5
         l1jabLI4atHAyVuCg8oss1hjRAAr5Sir98dT5hVIN40RC5uFzS0CP3JMu76RZ6JjKBFd
         2QNw==
X-Forwarded-Encrypted: i=1; AJvYcCWI0bdxC8K4cFVPqu0eTE49xEVeHXJz5E1PYaUzQxSl2t9bz1H1KZexm1e1kiNUcwj5qqxlikU0hfVpA8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfP+pDy6iXp5KlDAbjwsx600akqPfL2dJdIvik/hKyk9XySpNC
	mgt149ae3AWff3WzZUjAJ1ZR9HrdWykb5WlmdqDyaeY6mlFHHrX3fGvWnzcWvDoA8unDlx3eOd1
	qlAWax/RYG5klkPpRkRRgbDKw71mLfTc=
X-Gm-Gg: ASbGncuyosWq50CsC8+bUhzoDBFDiApo7htruDLms5sXgf/973P/cs9u4aSsdVncUE5
	cNeLjsDt5Jj4z1NxFUjHRePldaOTO0JO4OvtA/EZt2dZvUyDtwmQHNtIEHoXvdK+J7hQBsHMXA0
	jb5ov4DywTdcIwhZwxA0qu1dNrn3rVDLFHw0/MraBVmvSz8q/3OfFd30QKC3Yq69DXcZz2R+9GU
	j0e0880gJSGfv3M1LVL2zMSI4U3rV0sYsfKQ3ASC6cA51vdGWcem3oH7h3aaFrAAKy+M7T19JsO
	gX3R
X-Google-Smtp-Source: AGHT+IFwtktUuLWBY0+rVfzsz1di7iWK0c6AtHOqKHIJNThUvRz/7fvIWwgTANA7fSwebNkxx9UvlZXTBs5LRF3356I=
X-Received: by 2002:a05:600c:529a:b0:46e:4912:d02a with SMTP id
 5b1f17b1804b1-46fa9aef4cbmr167355365e9.23.1760493291529; Tue, 14 Oct 2025
 18:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
 <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
 <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com>
 <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com>
 <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
 <CAADnVQ+2JSxb7Uca4hOm7UQjfP48RDTXf=g1a4syLpRjWRx9qg@mail.gmail.com> <CAErzpmu0Zjo0+_r-iBWoAOUiqbC9=sJmJDtLtAANVRU9P-pytg@mail.gmail.com>
In-Reply-To: <CAErzpmu0Zjo0+_r-iBWoAOUiqbC9=sJmJDtLtAANVRU9P-pytg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Oct 2025 18:54:40 -0700
X-Gm-Features: AS18NWCKhuwcHSlUElwUIAzX8T7zdY15gvsdXmPJO09MLBADQKHWSXQwuUBXyho
Message-ID: <CAADnVQLr0iSzV24Cyis0pconxyhZJKAuw-YQVoahxy-AvdNTvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 9:53=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> I=E2=80=99d like to suggest a dual-mechanism approach:
> 1. If BTF is generated by a newer pahole (with pre-sorting support), the
>     kernel would use the pre-sorted data directly.
> 2. For BTF from older pahole versions, the kernel would handle sorting
>     at load time or later.

The problem with 2 is extra memory consumption for narrow
use case. The "time cat trace" example shows that search
is in critical path, but I suspect ftrace can do it differently.
I don't know why it's doing the search so much.
Everyelse in bpf we don't call it that often.
So optimizing the search is nice, but not at the expense
of so much extra memory.
Hence I don't think 2 is worth doing.

> Regarding the pahole changes: this is now my highest priority. I=E2=80=99=
ve
> already incorporated it into my development plan and will begin
> working on the patches shortly.

let's land pahole changes first.

