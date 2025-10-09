Return-Path: <linux-kernel+bounces-847533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 138D9BCB1E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 487C44F86D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B31286D63;
	Thu,  9 Oct 2025 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz8SruKs"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3963CB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049512; cv=none; b=UcOyQpskXsqYPVT982T/BqPGF8N+3VyJLzENo8qIc3Y7ZZpPZxNnaeYlcsOFDxNnSju0PBnXDluNYCrK6kvnfQHJ/YmhyoOpuLGxX2ULad4EMOC/rTcqq24171MyTG9u04JKs0fOEyc0tEGcBm7wjtSQJ+JphW+e+H/PzQRiUfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049512; c=relaxed/simple;
	bh=SGVEequXzpQlmwTnv/DQGNo4OQhhE2kPDPP0GHhqP8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9MYHEWj1j1mGHnVjWLPFbelrdVKoADLWO3burQIM9tQCLkTtgAnNFSXEk0kXJSmiA/JP+jx/WL+1V9piM3xEs7SGeGPT5VjJDg/fjcpA/um6pj4wc6Ur9ZEX6iRvw+Hg2v6tv+hc8//VihspEojomTSFvId9FqcxFBFfIZleJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz8SruKs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so14184605e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760049509; x=1760654309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pX43H97TMHIdwtm0l5tv/67eOJTCXZOrCI+4u7I6kR4=;
        b=Rz8SruKsvbo3GP6qvQqm/H5fGnIxTFL+QdUNxiZGydcmoZ4p9ZB0hY3Ljj2witUzD4
         YKxRV4q/50E4BoeilQ2gTyaon1zVZuWykLv4AqrH0er2hKatB3dfWVgi128TZyGBigtS
         XjJOBivxGatOhY9qUhZdu/eGr534iramARvS8A9sWXF3BrIkG1WQO7cHknUCSyqSb/4w
         du/CxixrRnaTPuCb4Ltl2Nx9Y8pkx+WYAVCi0IPDpzCaPs/9Cun/JVgoKNR5JB3bc2aQ
         09IVxI3ykgcHSJgM8T/iGmyVFKHzxP4Zvhp8Qh0uO2o4hE4w1CAsXjwgQY9XII4yqgWI
         Mt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049509; x=1760654309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pX43H97TMHIdwtm0l5tv/67eOJTCXZOrCI+4u7I6kR4=;
        b=dK7mcWeN2H6Lzpp10sVKPnnk59OKq7LFDCzx/PB+zkAaErXgVmtj+oUMlfyitaoZ8y
         QjldY8zeyAJpw05QIv6z26932CwST25gQzGwRGKA4gBqmUxlLSsGHDnghFgogWsl5A4Y
         uORKASC0tfkV3nGQSIkkfV+X8WjvqmXvQTGBv0PvZA5hhWjHvNC67Y4p+YwFkOZc8y46
         Tta+Nr9ISAH2pR4sCdeNjWB01TAW2QuV9DZX99eYwB8eDnNjoH3Da6VtPAiQgmOogmmi
         trUdw9nVpgWxrLpPj05o4JSOfLD56FD8ImvKp8bAuhPPqIrlTkqfJPo22cqBTBQ7XpGu
         DmiA==
X-Forwarded-Encrypted: i=1; AJvYcCVEAVQFsMQJpEQrG8rlsWSxaLSDujqQJxx9QsaayXblREA4Svkm3MJMwdGCmVFXJv4lNTRQRo7OvamYVPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNaJoJhcTMiyknY99IKQtSFVPx7ODQ/04K7D0y7KDAj/U9JZ/2
	7SjGtzLnbpMoWzHxgZI3776IyBVsi3b8P3NLp46spOlw1JU6Q4fb3Ctt5fyDXG2fWiSzeCyUWgE
	fqPLsaSwTMC7uvkxVkZCsiBSEOhXY9G8=
X-Gm-Gg: ASbGncvIxmujqfOBRwZog/Lj+hjipFMeAL6JUp8vjAWLqoN6Kwep4pHI/KXteV+10eQ
	gwKmDgy7XMCMDJamjMHgABuPzFlS04EkTXpuxWoG3cOdwv7kgtNqSyx/U00f3PqrXh1Y/2ViDud
	XctgZlczXWPV4ypG7k8imkKBK4+7OjfJdB8ImRNF94H1D82jurQY5Rg+Yk7cBlQD5EQCewS6RjZ
	YYduR+twbUJ7Ur5j5OrNObTEHgDihJXM34qFp6yShJvAyPmEoHnazINABAxiNc71GjDbGvxPuQ=
X-Google-Smtp-Source: AGHT+IHCGAek9aLYnqO6h6qsaegIprBP2JhFgyiNZ2Akv0snlWVmDL6rPA/XdN2zodvDo8rNlXjq2b+YANheSLZaO04=
X-Received: by 2002:a05:600c:6212:b0:46e:27f7:80ce with SMTP id
 5b1f17b1804b1-46fa9af8f39mr64662065e9.23.1760049508783; Thu, 09 Oct 2025
 15:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68af9b2b.a00a0220.2929dc.0008.GAE@google.com> <20251009222836.1433789-1-listout@listout.xyz>
In-Reply-To: <20251009222836.1433789-1-listout@listout.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Oct 2025 15:38:17 -0700
X-Gm-Features: AS18NWCOSO6I5mHnXsHQEv_1ULrRUw4sT_HIqjSgrJz_CypEeQ9hbJFdbnIG9cI
Message-ID: <CAADnVQKbmTgwXf5WvXACKUNbzs8r+Cvgx6KyyD7Xq1SOL9gLmg@mail.gmail.com>
Subject: Re: [PATCH] bpf: avoid sleeping in invalid context during
 sock_map_delete_elem path
To: Brahmajit Das <listout@listout.xyz>
Cc: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 3:29=E2=80=AFPM Brahmajit Das <listout@listout.xyz> =
wrote:
>
> #syz test
>
> The syzkaller report exposed a BUG: =E2=80=9Csleeping function called fro=
m
> invalid context=E2=80=9D in sock_map_delete_elem, which happens when
> `bpf_test_timer_enter()` disables preemption but the delete path later
> invokes a sleeping function while still in that context. Specifically:
>
> - The crash trace shows `bpf_test_timer_enter()` acquiring a
>   preempt_disable path (via t->mode =3D=3D NO_PREEMPT), but the symmetric
>   release path always calls migrate_enable(), mismatching the earlier
>   disable.
> - As a result, preemption remains disabled across the
>   sock_map_delete_elem path, leading to a sleeping call under an invalid
>   context. :contentReference[oaicite:0]{index=3D0}
>
> To fix this, normalize the disable/enable pairing: always use
> migrate_disable()/migrate_enable() regardless of t->mode. This ensures
> that we never remain with preemption disabled unintentionally when
> entering the delete path, and avoids invalid-context sleeping.
>
> Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  net/bpf/test_run.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index dfb03ee0bb62..07ffe7d92c1c 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -38,10 +38,7 @@ static void bpf_test_timer_enter(struct bpf_test_timer=
 *t)
>         __acquires(rcu)
>  {
>         rcu_read_lock();
> -       if (t->mode =3D=3D NO_PREEMPT)
> -               preempt_disable();
> -       else
> -               migrate_disable();
> +       migrate_disable();

pls search previous thread on this subject.

pw-bot: cr

