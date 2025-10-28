Return-Path: <linux-kernel+bounces-874186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8877DC15B50
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 918164FCD59
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BB8342C88;
	Tue, 28 Oct 2025 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6IVMUWl"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45760342C9D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667761; cv=none; b=ZzMRtcnHFF9JSdy2fcYbxqAedKJcfQue4usEM+vFlp9crF0pu3sCrjkw41wk+U8Cj5MGovTz4DoHSUJ8IvKyEQSAgLht7Ivcr+9kODd0VI3ZQ+66NbueAlmvLt2gXmEgFNARa5cAP5y/IILieoMKcPejE5AN5BdTyrnY/XLC1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667761; c=relaxed/simple;
	bh=dDjULkuYxSeS0Y4oU4SV85womNCpNWdft//C4y9afh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKt6oJozyqn8b5web9aFlODJ09Rwp19D8Tsh2TmtqKY0/MxIOVNMMJLpnOhvdci0s+MAzMbXSdl0yhpTUQLpWqYoXf+HHoOb3deMkfeOgDvMfE/iSVP7KXiyfogfRPmoeZDaJkqGiFJPxCXldqkPguDKe8u3QQGWWVoPfV1p9Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6IVMUWl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27ee41e0798so88026295ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761667759; x=1762272559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSbWUkP74jArjI30D0sAE5TvIq/zi84n0bjbO2j3uGY=;
        b=Y6IVMUWlaNg1fG/P/xP/rpsC+LayiWrpGg/RPfpE6OcoNX59m6/62RJidt4xNYDv0s
         UND9VsF+y21GwlP8hJOT8eJ5xdsdVXrX9B94FRxzd2IwcBpL7jYv7STW1GITg5K1Pq38
         go4ZvqRSSijYoGE77uGE841L/jeErIReMuhFzIuuQH9XigF13yxTA9k10RgKRVTkFn/4
         mI7eOdMDYw9ON6pcQ5cDtA8nCYsFlhhhRAm+Rv/qvj+2TiwIxBDZYbqLvfI8AkE/xq0D
         oDBPDr293xPN9NZcpPbh9cH5bA3WGKzC+b12J2+rGgN7v/oDUmIbCbIB1qLUKDLtvlsE
         IBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761667759; x=1762272559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSbWUkP74jArjI30D0sAE5TvIq/zi84n0bjbO2j3uGY=;
        b=hK2cuS/wOKQtqUvWe/bsm5nOcPKnuNhY22bJFOM4h5fOBEKL9suzXCBs5W8LId32/O
         qzMaxzNwAXvejYZplMCs3KnPNy5aH5DEt9BzvdR8hAUHSMmFILxhP6iZscmKZQQPV61l
         VcXJUiL0OoneAnhMSLVBOyViyFrTDNjA4dWsrfGYmwEFonwu5ZJ4oeRNgvnWTt9aW6SG
         HD/3ZDswYHTF4WeWPsJtpL34DRirLyLEjTh4SQMAgOx7P5KUI2LnyslZoruSLUXn8omG
         B9v01TyXgjMwWSLPh36LaWgNdjrSUJIsIuCQe4eRfbsp660C0MJfd0pyDVJHJoXP6Xzi
         Ex1g==
X-Forwarded-Encrypted: i=1; AJvYcCVAuDyV2wAcewYucGLAx4uG/Js1/RrYZBbskqi1NXvqHdgHjb6rFVbSMX4IiBLKLdqBBUki3YMRzLj3ULk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkUNVpC6z4zthQyiekbL7zYyR7KuqX7OGIi6vSDYPWqKLFrPVH
	LvH56S0d/n5IJxtKLMXUNbcjHuIcTVh40XwQGvsKopfhud6niOXWvHAurygNhx1XJVkoaqwTPo8
	U/35hwLpK3BK4IFIggUlTFPa/uBm9UKg=
X-Gm-Gg: ASbGncvVC2l54qRTEuVbYbg48syc2coOLhjsCQdAX/GyIiCJTLgd7bilM1Lfti6Skax
	USqGQ3bAe018882fbEPiTrHC88mn/IqrCTsPUr3Z21hDj5HvS5lzAhCDC+ygtd7BkffZ7x0pUCs
	9UNfMwvrZsHyTJvWCDOFhdoim+cPLuf0MXpZOWOKesXtKGQVBuN8RTgt1hGljkEBOQq3T0YNhMk
	L27ubQYdvMDhmCkEzKdK/Lgp1fWevYXAii7sVABWzTa20MEl6sTm0XNkcP4d+we0KLzsSPYDCdE
	4oazmr5+/4w=
X-Google-Smtp-Source: AGHT+IEt+jRXWPKMfkUhwdIG0jbgXiTN2/FnXGOF7GpfKVMtHqrZWr/N2HWc4lHOxmE0NYBa1VyI3gYStNqF+DUuve8=
X-Received: by 2002:a17:902:d487:b0:290:ac36:2ed6 with SMTP id
 d9443c01a7336-294cb3a1287mr46576115ad.14.1761667759122; Tue, 28 Oct 2025
 09:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020133156.215326-1-mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20251020133156.215326-1-mehdi.benhadjkhelifa@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 09:09:03 -0700
X-Gm-Features: AWmQ_bldhatN_kMnTkdHZ30UbwaQsKb7ZNir1RyLFpFR6qqrh0QB8XA0s5EslnI
Message-ID: <CAEf4Bzb6hhyyiAyyZZAA2pUZRNmfjAw_63ES8owfGvT_QXMyTw@mail.gmail.com>
Subject: Re: [PATCH v4] selftests/bpf: Change variable types for -Wsign-compare
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	ameryhung@gmail.com, toke@redhat.com, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:32=E2=80=AFAM Mehdi Ben Hadj Khelifa
<mehdi.benhadjkhelifa@gmail.com> wrote:
>
> This is a follow up patch for commit 495d2d8133fd("selftests/bpf: Attempt
> to build BPF programs with -Wsign-compare") from Alexei Starovoitov[1]
> to be able to enable -Wsign-compare C compilation flag for clang since
> -Wall doesn't add it and BPF programs are built with clang.This has the
> benefit to catch problematic comparisons in future tests as quoted from
> the commit message:"
>   int i =3D -1;
>   unsigned int j =3D 1;
>   if (i < j) // this is false.
>
>   long i =3D -1;
>   unsigned int j =3D 1;
>   if (i < j) // this is true.
>
> C standard for reference:
>
> - If either operand is unsigned long the other shall be converted to
> unsigned long.
>
> - Otherwise, if one operand is a long int and the other unsigned int,
> then if a long int can represent all the values of an unsigned int,
> the unsigned int shall be converted to a long int;
> otherwise both operands shall be converted to unsigned long int.
>
> - Otherwise, if either operand is long, the other shall be
> converted to long.
>
> - Otherwise, if either operand is unsigned, the other shall be
> converted to unsigned.
>
> Unfortunately clang's -Wsign-compare is very noisy.
> It complains about (s32)a =3D=3D (u32)b which is safe and doen't
> have surprising behavior."
>
> This specific patch supresses the following warnings when
> -Wsign-compare is enabled:
>
> 1 warning generated.
>
> progs/bpf_iter_bpf_percpu_array_map.c:35:16: warning: comparison of
> integers of different signs: 'int' and 'const volatile __u32'
> (aka 'const volatile unsigned int') [-Wsign-compare]
>    35 |         for (i =3D 0; i < num_cpus; i++) {
>       |                     ~ ^ ~~~~~~~~
>
> 1 warning generated.
>
> progs/bpf_qdisc_fifo.c:93:2: warning: comparison of integers of
> different signs: 'int' and '__u32'
> (aka 'unsigned int') [-Wsign-compare]
>    93 |         bpf_for(i, 0, sch->q.qlen) {
>       |         ^       ~     ~~~~~~~~~~~
>
> Should be noted that many more similar changes are still needed in order
> to be able to enable the -Wsign-compare flag since -Werror is enabled and
> would cause compilation of bpf selftests to fail.
>
> [1].
> Link:https://github.com/torvalds/linux/commit/495d2d8133fd1407519170a5238=
f455abbd9ec9b
>
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
> Changelog:
>
> Changes from v3:
>
> -Downsized the patch as suggested by vivek yadav[2].
>
> -Changed the commit message as suggested by Daniel Borkmann[3].
>
> Link:https://lore.kernel.org/all/20250925103559.14876-1-mehdi.benhadjkhel=
ifa@gmail.com/#r
>
> Changes from v2:
>
> -Split up the patch into a patch series as suggested by vivek
>
> -Include only changes to variable types with no casting by my mentor
> david
>
> -Removed the -Wsign-compare in Makefile to avoid compilation errors
> until adding casting for rest of comparisons.
>
> Link:https://lore.kernel.org/bpf/20250924195731.6374-1-mehdi.benhadjkheli=
fa@gmail.com/T/#u
>
> Changes from v1:
>
> - Fix CI failed builds where it failed due to do missing .c and
> .h files in my patch for working in mainline.
>
> Link:https://lore.kernel.org/bpf/20250924162408.815137-1-mehdi.benhadjkhe=
lifa@gmail.com/T/#u
>
> [2]:https://lore.kernel.org/all/CABPSWR7_w3mxr74wCDEF=3DMYYuG2F_vMJeD-dqo=
tc8MDmaS_FpQ@mail.gmail.com/
> [3]:https://lore.kernel.org/all/5ad26663-a3cc-4bf4-9d6f-8213ac8e8ce6@ioge=
arbox.net/
>  .../testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c | 2 +-
>  tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_=
map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
> index 9fdea8cd4c6f..0baf00463f35 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
> @@ -24,7 +24,7 @@ int dump_bpf_percpu_array_map(struct bpf_iter__bpf_map_=
elem *ctx)
>         __u32 *key =3D ctx->key;
>         void *pptr =3D ctx->value;
>         __u32 step;
> -       int i;
> +       __u32 i;
>
>         if (key =3D=3D (void *)0 || pptr =3D=3D (void *)0)
>                 return 0;
> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c b/tools/t=
esting/selftests/bpf/progs/bpf_qdisc_fifo.c
> index 1de2be3e370b..7a639dcb23a9 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
> @@ -88,7 +88,7 @@ void BPF_PROG(bpf_fifo_reset, struct Qdisc *sch)
>  {
>         struct bpf_list_node *node;
>         struct skb_node *skbn;
> -       int i;
> +       __u32 i;
>

this is wrong, i is coming from bpf_for() and is signed int

I'd suggest dropping this patch altogether, it's not helpful and
doesn't fix any real bugs.

pw-bot: cr

>         bpf_for(i, 0, sch->q.qlen) {
>                 struct sk_buff *skb =3D NULL;
> --
> 2.51.1.dirty
>

