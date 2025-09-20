Return-Path: <linux-kernel+bounces-825468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D13B8BDBC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 04:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06101A06405
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE2A202C5D;
	Sat, 20 Sep 2025 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Myu2MLxj"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47DF1F582B
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758336994; cv=none; b=g8AtA2nBpmcQPJmpmhevJx2oT1h6Mb7KKJMwjSD0cZcEV5HYicK/esAnlz+A4nvzBhASqVWZhaJ9W0cDlExwJT1kvo+4fxrI96x6OpXRt2450Zg58lXTWA4izfhTvtrIdbog3ah+R+9Xf6mCc/XDEoBHAOlxuIENyVYb3cgRBqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758336994; c=relaxed/simple;
	bh=SABrXAfD/yGBv4BOgjgu3huM+0XurmfkG7O4hOZ1p5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZhsPWYYIZef+HG55pVZ1Yv3TnRM6z+sCb2BkiSlwtSdTi9OLxQI9eeLLNqPRqazav0pvnXJCEH9EVImd/C+3jd0kk9FDjhaHQrGelKadrv4xECt97cBP7qdAgd0OG89HgyQwz1Tsf94eNtkIYo+IdQLPo2qQrA5whiYjdJ68z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Myu2MLxj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so1870622f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758336991; x=1758941791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+JSfjQG3dPuPVsnceUeFZXrh8/X6Psk2dyqFGUkfL0=;
        b=Myu2MLxjcSzKdG1GiIkbYLRZidy4/J7LYDYag/LWnxuos+0nMnEFdgPo2RnzSSspft
         LmXzyixFRoPIYSgtrPOeGwYIYasE9MJvKO9lJRIJXJ2JIb2vYH5BTGktLgzOvd2N4NBF
         GD/a13vnhh66UfJp1onuDSp0euLd2yvAr0XVMj/gy88OwoIZxNiobujLiXFSju9ieEbY
         LO2zQWkgKfXP8gLaHqcryVe1/0xPr63pFai6zuzJrR4JtP+vvWITNt2L0XlqpVZZO7eI
         ULGvv491ffJq0PJUz2fIVYuELvufogbb0x8b3nCOeQRs/ghzLlKtOAJRnti1Jo0Xw3Vu
         fpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758336991; x=1758941791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+JSfjQG3dPuPVsnceUeFZXrh8/X6Psk2dyqFGUkfL0=;
        b=H0vRzAU98Quq7/U2a4HzOKhPO/Yo1TpPlzIboj6nzchDd6azNKE6iwnvmxWmhE5V7K
         UaejeHI4A6GoEIv7JdYNLJDrEVD6eL9jHI0o2tdNt2hhovL+4etC9htvCLayJDFOiyEK
         OK3OFF7tTfIPigdvdlBE8sqROYCe3f0GPfVRaqteEvg0szn6UjdZCU0/qXK0wKECcPD1
         FIlcVFuZuHnVevVXLlNxFpcZJqqMUL4Bj+v4YaYKlRVRIQ/8XxD5isy/pLo6VnQ4UKUd
         Ef+g0S2R270fzgBx+q9u4v+/2GctgvfYZ0b+oe3NlLNvk96U6HMnWZ4n4NVtNc1k2FEc
         4SvA==
X-Forwarded-Encrypted: i=1; AJvYcCVGXs3HFwfgkXTAD6vMJYQraWpRGoDadulOh15U6SoI6wHRGFxX2hZugWlCXL+HN2Oehuhc0wb/spRrV2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5dvgzI4oYCxRzNRSqMgcjoydj6sZ2wTkZKdSgR+ac1XUz2FEj
	76omO9M7Q0ne7SnaGLynAcfA6SIAJzMxblPJOgAybe9FBas2vIzauTKa/VUOw91ut9Rv1dKjtz7
	6RBeVxjb43LE9lZS5Ohsjt103tEFBRNh1210d
X-Gm-Gg: ASbGncu3lBZxrv8n8tspwqpPTSUyMco2tNywHhKnD5st/7yJ/86kPbIshSTE9CM7MbR
	sFw5Qhyb8UvtasmEz7K3yRDtKmcl5eRYG0pwuldBk7Ed5sqNwsPaf1YSVnIiQkEiXkFwHpbp+Jp
	bo5I7s+gOCzCSjQXfNYDn1KhgBSzuZ7RVEfuTl7epulT925skhD+TU9NKHhIp69BTcg/6BykPtD
	DwCcPVNCsg2XtbFj2YOFRNHOWhNXbnL6vxa
X-Google-Smtp-Source: AGHT+IERAcHZfTN6VLJmmNbMRxg87FE7AYDMD8mBCCmzVyFm3fyh8f+KisZCrkCo2ZtgOPFOA9so43qHA5KIJr1Z9YY=
X-Received: by 2002:a05:6000:2c06:b0:3ec:e276:5f43 with SMTP id
 ffacd0b85a97d-3ee7e1069c3mr3959667f8f.18.1758336991216; Fri, 19 Sep 2025
 19:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919071902.554223-1-yangfeng59949@163.com>
In-Reply-To: <20250919071902.554223-1-yangfeng59949@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Sep 2025 19:56:20 -0700
X-Gm-Features: AS18NWC_zRwQ0ew3oT6b8x8FGxU5FvpZ1QgwjLnU8fS_VUvLw3WzNDgL7YILOro
Message-ID: <CAADnVQKrnYCaUCd+BNvZQmR0-6CSu2GBa=TCCCjPLSNfb_Ddvg@mail.gmail.com>
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64 architecture
To: Feng Yang <yangfeng59949@163.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 12:19=E2=80=AFAM Feng Yang <yangfeng59949@163.com> =
wrote:
>
> When I use bpf_program__attach_kprobe_multi_opts to hook a BPF program th=
at contains the bpf_get_stackid function on the arm64 architecture,
> I find that the stack trace cannot be obtained. The trace->nr in __bpf_ge=
t_stackid is 0, and the function returns -EFAULT.
>
> For example:
> diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/tes=
ting/selftests/bpf/progs/kprobe_multi.c
> index 9e1ca8e34913..844fa88cdc4c 100644
> --- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
> +++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> @@ -36,6 +36,15 @@ __u64 kretprobe_test6_result =3D 0;
>  __u64 kretprobe_test7_result =3D 0;
>  __u64 kretprobe_test8_result =3D 0;
>
> +typedef __u64 stack_trace_t[2];
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> +       __uint(max_entries, 1024);
> +       __type(key, __u32);
> +       __type(value, stack_trace_t);
> +} stacks SEC(".maps");
> +
>  static void kprobe_multi_check(void *ctx, bool is_return)
>  {
>         if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
> @@ -100,7 +109,9 @@ int test_kretprobe(struct pt_regs *ctx)
>  SEC("kprobe.multi")
>  int test_kprobe_manual(struct pt_regs *ctx)
>  {
> +       int id =3D bpf_get_stackid(ctx, &stacks, 0);

ftrace_partial_regs() supposed to work on x86 and arm64,
but since multi-kprobe is the only user...
I suspect the arm64 implementation wasn't really tested.
Or maybe there is some other issue.

Masami, Jiri,
thoughts?

