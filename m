Return-Path: <linux-kernel+bounces-828143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F0EB940C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6313E7AB27A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FB5265CDD;
	Tue, 23 Sep 2025 02:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2e7WA2r"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2972D184
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596029; cv=none; b=R9rkV1SL0o0WMzUplAsCg2yt17/TQcapnwNMVET59Xf2oHrN3haH9cgqE0QrS3mZdPhSfsOZCqsFKT09jeK6fetAjCFzXBiwArehH7hvcMwUY8GcxUNRCKRx2fEjrj7Wc17cMa21ZNkPzjKaRmTIdIl2ZdtUT8HE/qwEMntihCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596029; c=relaxed/simple;
	bh=4KL5v3OTEDwbPW2YYJKsjCzONjJMxy1fcQiPQrMYEq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuUtGfJPHrMHAOCPnID9T0iIqhqynB0riIAadsTQypF3vuYShLZlMaRE/gbcFJqCazIxMlcJ0h1ypFCpAvJtGL4cucHJFi3QnfF9u2O6llA/S/U3ZKoq3pbL3FVc9z6RBppuoSkAe7seV05dEh+sAFgBu2TuMgsz1GvpKfedRVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2e7WA2r; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso2607772f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758596026; x=1759200826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woHeSz+wN8VLZBX1PJ6mCkAi00YzbMjWoGGz/eAoJTo=;
        b=I2e7WA2rcN/NthinaUjp0Vr/GE3zHducsKM0DvTj9ZB4DO3l/GzIxby72VbegFqeXa
         YkNRu8b+gATiCxEFTrrTrxeC0k/laOP/csWMozRecNgplquJcmOXV9i+fwidcW5uenV6
         EF9wlUF/xOy2WJy1DTAWlfeizlh/oqRZoANb9Dk1aOK5n50niMQAa79r2Hg/wQGPL+Zx
         jLGTskPt4WH7VCFongQN55TP85a/acNIu0eV8eG51aFEtHDGWfR5Ahr/mjwhuNFqLWqL
         WLRQLS+ZpUiIqnla3wKA5Vn8FzDS6DW1t427QPUQSfiS4kFFLhQj8x5PmH3DET5SRm3i
         nPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758596026; x=1759200826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woHeSz+wN8VLZBX1PJ6mCkAi00YzbMjWoGGz/eAoJTo=;
        b=PQ8hL+hE/kQrRTMnJbmU3IyiAcy5R4W9ruHRhaHmf59y3pViD4X6VWH+qB5XsFS7Kv
         FUNMiO1CIH5Bfg3Q0Yuxcml3m68Guuli01Ls1WH/FTWaEeE2kJeDsgccfdpcr4YjFAip
         AlNEe3hPaJlmBbjrnjJ23Df5zmxqjhlnZOBzoTAPcN/Q3bzXHmpYUH2bzbM2/Tv18uOi
         agY3W1pVJi/F6I1vup2h6mUgrGoqbA7jCPVuPuFnCULqyKAaJ2q7emx789L885JQTLZK
         wwzNZZWTRjvssAwZdc6SikvycS4mm7xXFc9t2DwJvUnw1XCWAsHEQ9P2UViSZVQjaE4d
         Hyyg==
X-Forwarded-Encrypted: i=1; AJvYcCXD7e4cwblSOMI1ECy3IG6eoYUZZJwVwFw9iX7HTS0swIzUdNUQmjyurNZDa1W/+lAk29txgQZOyNvuG40=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiio+8hTJDXxQ4ufCoZ2D+YhJLwwDt36vKqa1wFMH98stiUYck
	Mspw0WEep4SHr4vIfQLVP+0h1qMs9+skJYH9r7RwuqEklgnT8yWkrHuq98On+HJJX2qKYAY6458
	kZwDM79aop0/YKZH4hVQ7DFNloWRdQp4=
X-Gm-Gg: ASbGncvkfmKCHcKdN7nceGq8GpxfojPBpnaW5Y1rn4rbANguROYaXPI8JCH/ma4+O8u
	dFROXC4eweK5oXObt2AaoIiaNobbp6BFWYYvkK27JpI727aU7kClz6yeNVzq+MQtcSvvjmP2AmI
	kG0W/yod4viXSTXCY2pQCPaxXZvPh3r8WPXKOjmtgpTXE+KaDzxhEvozNhY0EXZE7Xjmc2jJdW+
	mfdEuMV0I8uYSWeRT1XCHyigss2q5HNQdgsSL+V
X-Google-Smtp-Source: AGHT+IHCLyj57vgWvMHGuc9+n8xyMBPrUAj3lSER1jbbCPJgW8Up2JuNBFO+TEIk+iCTBVYGf1v1oerNxYwQ1LGj0Gc=
X-Received: by 2002:a05:6000:40dc:b0:3f7:4637:f052 with SMTP id
 ffacd0b85a97d-405cb7bbb1bmr605565f8f.44.1758596026347; Mon, 22 Sep 2025
 19:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922075333.1452803-1-chen.dylane@linux.dev>
In-Reply-To: <20250922075333.1452803-1-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Sep 2025 19:53:35 -0700
X-Gm-Features: AS18NWC4b7F3GzLWN_qWwWaDX6YXSurSDS7Ypc-IAWe_3G5_P_08uwhLNGAtxwk
Message-ID: <CAADnVQKtOCXdv-LJ-T6K_meAS26C_i4Yc0hOpYS46umsPmuQAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add preempt_disable to protect get_perf_callchain
To: Tao Chen <chen.dylane@linux.dev>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 12:54=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> As Alexei suggested, the return value from get_perf_callchain() may be
> reused if another task preempts and requests the stack after BPF program
> switched to migrate disable.
>
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 2e182a3ac4c..07892320906 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -314,8 +314,10 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, =
struct bpf_map *, map,
>         if (max_depth > sysctl_perf_event_max_stack)
>                 max_depth =3D sysctl_perf_event_max_stack;
>
> +       preempt_disable();
>         trace =3D get_perf_callchain(regs, 0, kernel, user, max_depth,
>                                    false, false);
> +       preempt_enable();

This is obviously wrong.
As soon as preemption is enabled, trace can be overwritten.
guard(preempt)();
can fix it, but the length of the preempt disabled section
will be quite big.
The way get_perf_callchain() api is written I don't see
another option though. Unless we refactor it similar
to bpf_try_get_buffers().

pw-bot: cr

