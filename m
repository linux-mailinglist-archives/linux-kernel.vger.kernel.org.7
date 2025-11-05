Return-Path: <linux-kernel+bounces-885625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3811EC337EE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F2004F2AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DB523BF9B;
	Wed,  5 Nov 2025 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ+N2tMt"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F7239E7D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303265; cv=none; b=VxH2MR6nGvEpXZkq8Bkj585qJyPX9E6Zv9+7IRx+HwaRLcoEvfdSoXmUeUsNn6a6h8t517UWoszKbGN2BI9nv3xNnCyR0Sum13xR1obDAtgSR8J6Y3reWmm5/ckhY2NNLag/eCsF4rXurfOWl+BfdT4pQ36o+iipqGQHEKC2bm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303265; c=relaxed/simple;
	bh=iB2rxoQs6LHNjhiJgmkA5Yc78itROwORHlUrfQFQHXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewEmAGhd3X4s1HxY/CnHKbyM2UoWVu41gBEIJ6unPk5K0ddpPRZITkH76EJ2h2cT6zVK81TjeYbtNMHiHVo8vgmzYxz7dle9/7oi9/wt80ShBjK8TYBcneZJBIBaHsAxb7oGtalxKjwRBgiC/R9Pmvbjqe/8rIaQ5vMfKJ9JkBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ+N2tMt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2951a817541so68906875ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762303263; x=1762908063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lY3hUxzseeyKTtHC+1V232znjyrt/mx43bxK4gMo3E=;
        b=AZ+N2tMtFMDYsxGQgMMAAS5kLBe9euC9xNNBygxInEDAHINlgZTpzyxbDH7F33y83G
         R6XiohF5bRaEhtQsXIq0LusqrK1SLLH2I/yZ5p4XW4/GUoPd0kJcjzwzgWDIex3bVnoG
         caFWi8tNlqf/gGsUG7YfAoeZE0PxkMBf5HtwWrf7HVPaCqKwNizW5f2IAePaGX9ygODO
         st71Wd//W8o+nYOWoLXzNiJXSKd/cvTQwT42Fw8wGcSWHE6eXTjrTPTSy+P0nnVFvqXX
         HHC+qGXO1IrU+9JCSSfVluhLQXFN1uvLs6QXrYvIHmcvC3KL4Keu3easK8EP8zXGyt3Y
         YxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762303263; x=1762908063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lY3hUxzseeyKTtHC+1V232znjyrt/mx43bxK4gMo3E=;
        b=dwqttF4yGXInbCMHEiqrq+TK8hZNRqyA7yr0PZbujHgh68mkOJfNiBhXSuXpZzVH/8
         wyy+cSZWQ5QfLT3/01OnGb5+6ovGwmYTEQzeeunyHVeGYPtrlWqrNh2z06seaFB1+pB8
         IYdVjTGWzr9jpqIReaEYDY0ohCzxU2uCBCb7tIeueLM+rafoQ3gEeTmN+KmBV8lef2IZ
         SptFNOwT6rsiWJwfOl3RyRzwFmoFAjORQVaX4LKlXOU8iqGcHS5/hG7UzBdzOteriw3L
         SA4WOZd9ixR1pwBrxvs9WrwrNp1lVJwv9V/URmKDCwA/PPKdCj2eWT1hI3f4kX7CyLPK
         r7jA==
X-Forwarded-Encrypted: i=1; AJvYcCXcC9dzXQvWELTYYzarrgjkHNXgOu+B7TPlmDzPLJHprMdVfxFSxisQRdo6KcBmNz8uSFGmC8Ivzgpn4Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVOCLktQKh0qv+N+6/FyK19XhpOcONiiqmyiDe6m+SDfMCJD3S
	MHWou2Go48N7f6ooWyPTMyQE4gHuQ9zUuaNEO8MC3mUf/+BaCxhAECBYEw4oM7rm/C9uqhEkr5L
	ZAdTT5R97j4WifPBYJM0dxOl+AjJ2tHU=
X-Gm-Gg: ASbGnctJZPOYJ7n8oF1tTmFdgxvFa+1u8ChIKNpF113KySdnoSjngnoqOW/dCkST1bR
	xmPyHyq/MBgk1zrHE+9cVsJtnoF4dRxnw821nChRKguT6AvYNwo9hpbFhXBs9zY82Ea2NBo5vfD
	zCEs7FVQcArWaljIa0ZX1QLpMxwiOuVzVUvueE77q/9jHA/W/LpOK4J5waBBDge9b29kc3k4Wgr
	5IWJ+17dhD4qfiqqoiChc8zCnkt9E/lKsHmXmp8HbijMYJruOJ6oX8WI274FRc57+SFuREbo6oe
X-Google-Smtp-Source: AGHT+IEU1E4MP5M572+waRD//phAEiALlYub9Hv2jmIr2Y/tWZXbS9wfZ+oS4MlVnNllbjwb8B0DR0MpRyvGDsfjouk=
X-Received: by 2002:a17:902:e5c5:b0:28d:18d3:46ca with SMTP id
 d9443c01a7336-2962adb62f9mr24024215ad.49.1762303263212; Tue, 04 Nov 2025
 16:41:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026030143.23807-1-dongml2@chinatelecom.cn> <20251026030143.23807-3-dongml2@chinatelecom.cn>
In-Reply-To: <20251026030143.23807-3-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 16:40:48 -0800
X-Gm-Features: AWmQ_blOfoM_l2r0lt4A2bvCtaXDmFSafOTdKDG85Hyl1uiyuVpe-mxuHnQsoBo
Message-ID: <CAEf4Bzbgqse2mSmGWd5ibJaDYgPw-WpLQp_XiF3fguw147qgPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf: add two kfunc for TRACE_SESSION
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, jolsa@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	leon.hwang@linux.dev, jiang.biao@linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 8:02=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> If TRACE_SESSION exists, we will use extra 8-bytes in the stack of the
> trampoline to store the flags that we needed, and the 8-bytes lie after
> the return value, which means ctx[nr_args + 1]. And we will store the
> flag "is_exit" to the first bit of it.
>
> Introduce the kfunc bpf_tracing_is_exit(), which is used to tell if it
> is fexit currently. Meanwhile, inline it in the verifier.
>
> Add the kfunc bpf_fsession_cookie(), which is similar to
> bpf_session_cookie() and return the address of the session cookie. The
> address of the session cookie is stored after session flags, which means
> ctx[nr_args + 2]. Inline this kfunc in the verifier too.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> v3:
> - merge the bpf_tracing_is_exit and bpf_fsession_cookie into a single
>   patch
>
> v2:
> - store the session flags after return value, instead of before nr_args
> - inline the bpf_tracing_is_exit, as Jiri suggested
> ---
>  include/linux/bpf.h      |  1 +
>  kernel/bpf/verifier.c    | 33 ++++++++++++++++++++--
>  kernel/trace/bpf_trace.c | 59 ++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 88 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6b5855c80fa6..ce55d3881c0d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1736,6 +1736,7 @@ struct bpf_prog {
>                                 enforce_expected_attach_type:1, /* Enforc=
e expected_attach_type checking at attach time */
>                                 call_get_stack:1, /* Do we call bpf_get_s=
tack() or bpf_get_stackid() */
>                                 call_get_func_ip:1, /* Do we call get_fun=
c_ip() */
> +                               call_session_cookie:1, /* Do we call bpf_=
fsession_cookie() */
>                                 tstamp_type_access:1, /* Accessed __sk_bu=
ff->tstamp_type */
>                                 sleepable:1;    /* BPF program is sleepab=
le */
>         enum bpf_prog_type      type;           /* Type of BPF program */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 818deb6a06e4..6f8aa4718d6f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12293,6 +12293,8 @@ enum special_kfunc_type {
>         KF___bpf_trap,
>         KF_bpf_task_work_schedule_signal,
>         KF_bpf_task_work_schedule_resume,
> +       KF_bpf_tracing_is_exit,

we have bpf_session_is_return(), can't we just implement it for
fsession program type? Is that because we need ctx access? But we can
get bpf_run_ctx without that, can't we store this flag in run_ctx?

> +       KF_bpf_fsession_cookie,

same, we have bpf_session_cookie, can we support that? And again, we
can just make sure that session cookie is put into run_ctx.

And if not, let's at least use consistent naming then?
bpf_fsession_is_return() and bpf_fsession_cookie() as one more
consistent example?


>  };
>
>  BTF_ID_LIST(special_kfunc_list)
> @@ -12365,6 +12367,8 @@ BTF_ID(func, bpf_res_spin_unlock_irqrestore)
>  BTF_ID(func, __bpf_trap)
>  BTF_ID(func, bpf_task_work_schedule_signal)
>  BTF_ID(func, bpf_task_work_schedule_resume)
> +BTF_ID(func, bpf_tracing_is_exit)
> +BTF_ID(func, bpf_fsession_cookie)
>
>  static bool is_task_work_add_kfunc(u32 func_id)
>  {

[...]

