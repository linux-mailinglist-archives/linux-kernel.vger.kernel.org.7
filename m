Return-Path: <linux-kernel+bounces-879348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C239C22E74
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D51DC34EC3C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ADA2586C9;
	Fri, 31 Oct 2025 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNJN6Q7x"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0BF2571D8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874950; cv=none; b=lpdbFbQkpDnFiYgFSLoZkfl1LaOWzI4AzLzc6lQ63IPC/yBNHjdL9U2p8+pA8dgPI1jY0LN3cnLy10SxCvTGHDjoB9ykmM6N4q97depHn7hi6RU4CB8D1OjQptwpgDiSMDtGhCopBPN4O0fMmrXLZcUzrEqi38Olf4TbIjHFx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874950; c=relaxed/simple;
	bh=2ATUNGgbaZSw6y4sW6ppozk2GJl7GnxzpyFCiq20UPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGK8D9b7Xi3ayHn6GzBe+XxjoPqu+FkwWgzMsg6Ty8Uii4lRM/dY/8tSTNxPLWaP20YHnBaPtEEFc8yT6JBnArZbDEja4YA42qCpYVgqgWuiybtYnp5Ctk2dCG34dW3KknNcNu0Rs34iGZoDR4XWaXw9uRer9MyDURhOyseeA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNJN6Q7x; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710683a644so15724525e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761874947; x=1762479747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcA2fuPv0nibJjY5gaLuKw0u8MBZgVhL7lh4erE+P+w=;
        b=KNJN6Q7x+09HFG1z3MRfzLk5FkOv6YDPSRQArFOZ442yfP95jQFd7XArxq4CLY5qfM
         QI0S/3GFJ8deigXQw6yTyKw0zoojJhB0LYW6n1U9oUr2vJFgPdClFn2MC0JjeBQ6sUOz
         GRGSfQ/agjxJqFY3d/rlNmt6eafl6z49Bh+jsiCDFj5gHmIm3IihV8VqJRgCtFkUKzHh
         yxp09M+j4DgO9UNwb5V3rnhsJgPnXCJkoTHB0yPC408aPpG9ILjgf1Lg5kPIwTlnwdFA
         jqRqnocLf9DcOMbA3ahzm92CfbmSqZENsOq7LsBwmFWkOzL4iWC3VbZmQvoyAHbtN6LO
         L0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761874947; x=1762479747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcA2fuPv0nibJjY5gaLuKw0u8MBZgVhL7lh4erE+P+w=;
        b=ZikOdGBwIlI3eU+vAXXv+DVTRQfvgkAAQ3STuaL6+Ko8OJQ986iPgi2C1yDboakiqO
         MjqCtMfu+PBKVMN6+Yq+Y6S+PNSqFMrDORrG9SBSRxmSl7dOepZmO0TD+jM0Gjg1pudi
         27R6V1mLwv+3/W6/eJ6e3L8w707Ntz9mXsT4CJv1Z/tciUolK3yijqzHnyU3u1NiAppw
         0+Qf7lsqelpOwa+0mt5QHKCwRgMs5+0tGuyejNYn1Kzkr7/3lq+RA1rxjyX+UL4cfPjb
         62L8MkI6RPRz7vu5jcCLsfkKYBt0BhYcP0DAqtkem/lnmRqFqcA1Wq55XaLabAu7fe2z
         oIiw==
X-Forwarded-Encrypted: i=1; AJvYcCXEqZJj7BFlnfTJ2O4bqilUY5oOVfr91nyaRp1bRkFtzhzWr9C6aBpr5LsBXFQeuwOjBxjEAQxhr3INHXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+MAGIOLfwuZInPJvDNIlzykRMqxls1TT/qEgXCsWVzR1sKpH
	e0yRuqaRVa9IQGttEic/jstzeJpUZ9fMAvivqjZ4uWEcEjzerBfGELk3IIwaIerW6MOqEMqfBj6
	/u+Kak0qHG5wj3dGQsHhUUGfvhcKRYtc=
X-Gm-Gg: ASbGnctJvg0YkDFIYYWhRx3OnW6A9RKhsXDf3Dxnsy/1gFShLjV71o+xmQbQ9A0VQvd
	X7l5dntFrEPN6A2NHkxqtO5qRJVn7m9jJAanI6sddFInMeJPGuBoUpinNqYWQ7VNE9V/bqefB3J
	AaXt9/iIO+lwUxtyUAUXj/2K8N3ruMfOc/DVwQqjidvaOGjIWSKD5TjXe1Ca+MjpnT7q0ADBxK+
	sIxkmAmvk0PkhVuEWRK8zo+oS0Ygm7lNFwySeQaS7sr6dy17af14Mx6h2Z55FF372+YC5oW5td8
	LtCU1hOIWxxTBuiP9A==
X-Google-Smtp-Source: AGHT+IHjgEAGnr4nfdh0LhSmnH+sRjuCT8RoVd5GbtltDrO5Kk8/oATSx8VT/19HA2xAKXMbh+mARs050dlD33ztYz0=
X-Received: by 2002:a05:600c:8a8:b0:471:793:e795 with SMTP id
 5b1f17b1804b1-47729701baamr22601315e9.0.1761874946389; Thu, 30 Oct 2025
 18:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026030143.23807-1-dongml2@chinatelecom.cn> <20251026030143.23807-5-dongml2@chinatelecom.cn>
In-Reply-To: <20251026030143.23807-5-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 18:42:15 -0700
X-Gm-Features: AWmQ_bkU5AnX8Bwj31yvGuqNgMmOr74c9fvilG5ffkhrLd1xgPSqCBlrOWUn840
Message-ID: <CAADnVQLfxjOUqbbexFvvVJ4JTUQ2TKL0wvUn3iHv6vXvGfitoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting
 for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 8:02=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_session_entry and
> invoke_bpf_session_exit is introduced for this purpose.
>
> In invoke_bpf_session_entry(), we will check if the return value of the
> fentry is 0, and set the corresponding session flag if not. And in
> invoke_bpf_session_exit(), we will check if the corresponding flag is
> set. If set, the fexit will be skipped.
>
> As designed, the session flags and session cookie address is stored after
> the return value, and the stack look like this:
>
>   cookie ptr    -> 8 bytes
>   session flags -> 8 bytes
>   return value  -> 8 bytes
>   argN          -> 8 bytes
>   ...
>   arg1          -> 8 bytes
>   nr_args       -> 8 bytes
>   ...
>   cookieN       -> 8 bytes
>   cookie1       -> 8 bytes
>
> In the entry of the session, we will clear the return value, so the fentr=
y
> will always get 0 with ctx[nr_args] or bpf_get_func_ret().
>
> Before the execution of the BPF prog, the "cookie ptr" will be filled wit=
h
> the corresponding cookie address, which is done in
> invoke_bpf_session_entry() and invoke_bpf_session_exit().

...

> +       if (session->nr_links) {
> +               for (i =3D 0; i < session->nr_links; i++) {
> +                       if (session->links[i]->link.prog->call_session_co=
okie)
> +                               stack_size +=3D 8;
> +               }
> +       }
> +       cookies_off =3D stack_size;

This is not great. It's all root and such,
but if somebody attaches 64 progs that use session cookies
then the trampoline will consume 64*8 of stack space just for
these cookies. Plus more for args, cookie, ptr, session_flag, etc.
Sigh.
I understand that cookie from one session shouldn't interfere
with another, but it's all getting quite complex
especially when everything is in assembly.
And this is just x86 JIT. Other JITs would need to copy
this complex logic :(
At this point I'm not sure that "symmetry with kprobe_multi_session"
is justified as a reason to add all that.
We don't have a kprobe_session for individual kprobes after all.

I think we better spend the energy designing a mechanism to
connect existing fentry prog with fexit prog without hacking
it through a stack in the bpf trampoline.

Sorry.

pw-bot: cr

