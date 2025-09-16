Return-Path: <linux-kernel+bounces-819688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D38B7D5C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9C73AC6A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAF92BE7CC;
	Tue, 16 Sep 2025 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxKy4Vrc"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500520E6F3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061004; cv=none; b=pv2b1RVxCOTCz2j+GyhYxqpFp9QZGkEFq9vMLKRYwLi5t7GRuIXxVOjO/vLJTe+bWh+tFTONglDTrR9DmOJvxPSVCsXZRE+vPSmPkAxPJScEROXaDGWwwvHRi8+bjFP9fCPC3zaabsTpF+Wf2ewDNjyeG9g/y6d9iLtSAa1iVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061004; c=relaxed/simple;
	bh=ZhrtNX2kW4+SEm0NDR3oatPjuXJvSmAGowa5Ma02sfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jQx5QARNO3SYu1/HrIN8JfxiVGJGnpi5y/xfpwfhK4cLLXaBeok6Wxs5xf9UVNcohQ1B+qjMJAT8jani1fECga8ke8FybAIHqlXlmOBf9BK3Mpmucy7IuDAKHyew3HgMx8Ke60T/lDHAzxvQigfQwwsXDS3ldb+gBOfdXNkE5fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxKy4Vrc; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3318dd36a8fso3051002fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758061002; x=1758665802; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ykbi9ORR6F/chC/kV2ctSfLFRdnZlKnXwUjsJoavaTU=;
        b=SxKy4VrcMoh0eYAxDY4MNWX9pcdyCoEU1I/knjhVy4Gyv6q2WMKcgyaLgu8fcMmpIk
         21C0dobTWZluv6lDhyonKKqpL3Unf/xSfT3uA4mG2fD2rwuU+ClLK4g1kUOD7AuBVJNo
         I03OBZpoTnd/a8NdvdO8XrMhZUxw2nYgyBztTETTU3XJYs4huj2OB+nVXtviwEH2ApQl
         Wwvm7g07JGSgJ7SM2n9kMRtC7R3B+RXOH1g/YPczazQerjq4ON5AKE6Och+qeA3KSFl8
         JegJq42pmGzSvK/xh5nia89hTI3A/M6gChlrE+6fgoskzRRM/UQzTAdyReEci8q4/O/s
         MKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758061002; x=1758665802;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykbi9ORR6F/chC/kV2ctSfLFRdnZlKnXwUjsJoavaTU=;
        b=BHJxoOEAsz2Ed1AD9EXHxP6TdGd0ekTpi0GlH6DWJIKOhm+CcWsfv1aoMfwbEQpyal
         ZvOkpeIbfT1rir2LZ/wilZwiNnW3AlKkm01deHxi9oPH8ifuYx0vN6DgEii3SO/ZhASr
         Oo6vgukYGhVaYdAYng8G1u8OibUqg6121ONqGDhqR8SkkUtOjzTGZJW/sisE8lIEj0k3
         7XmI+rIZ3EbBKMl0t6K06pIWWTGaAMKU5ALR3RDhDekbMBax0GX7Vs6VMtIk+faVP0fb
         DVWmAGAzIj3k0zNzzMUO9Xxc0M/MXk+giXdnUZJqWzDQi3XDAKUtDuFfAHZW4htUE1fg
         GTsw==
X-Forwarded-Encrypted: i=1; AJvYcCUX2MyHA2BjvABxasV9xdPIbIAfjBbeQ9c9yGJXZX1pKmW+NC07T3S2wQ9BmGazYMMfZH08x/r0hUb2oJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jbBtU2TwIlUZjAfJJaH0btcXJitzFTpUe7KPqFl6cy+8gZq6
	Eo8nqYzmgCcXAMf8UyLWR0CUCSIPMsOL6GpKE8d7OV9xSLfWtEC913eh0AMZqfOiLSIubg==
X-Gm-Gg: ASbGncssp8kMNz7AWi3CYHZqh3NPFdHFkSkvHaou6VXGrP0xPzYqqioDTdN5xs5v6eS
	3+PJ+SNQlhD8mTZ5Km4VyL4Nw0P1jLPLXgnVJYH4qCeHP5wzVkDeInhGvFjN4JPZTDtA2x1tJbK
	IOAs0ByFL25Mh+WB7GICFJzds76DsM/Ppc5/PWCtj5Vmf024jB6OZy7I1brcsrAOphuKtqxjJZQ
	b6VjETDrtGrJHaoIu15cM71FgOJ8hIxknl6JRR56rPQ/tIwdAxZGrB9Ej7a56hKkqWl02eDvbAE
	0LlHLPUot/NLiGDP2h0408siXaExe7pHorwHv40Clw/LJwTz+xfz+WgJDMuZ5rf+yu63iWvKwl/
	pSeK0byrVBzHUCuEzL7nubkzF0CdIjSGhhbqCY+esc5sjrqHE5hfti8pwjkX5Sl9DQIDmua54GZ
	20gJVxcaeMk7QAm2si0qX5rKjnh8U9ycRqJAc=
X-Google-Smtp-Source: AGHT+IEZnSDUvYgihKJtLaN2Xpm1odOGPMiQ/3sbr28jrHO6rgLxPXvbdax1sAYKsoitj5HevBF6BQ==
X-Received: by 2002:a05:6870:b251:b0:2d6:6688:a625 with SMTP id 586e51a60fabf-335c014cba9mr29867fac.37.1758061002296;
        Tue, 16 Sep 2025 15:16:42 -0700 (PDT)
Received: from [10.0.11.20] (57-132-132-155.dyn.grandenetworks.net. [57.132.132.155])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7598664d715sm1707318a34.0.2025.09.16.15.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:16:41 -0700 (PDT)
Message-ID: <c36676c1640cefad7f8066a98be9b9e99d233bef.camel@gmail.com>
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
From: brian.scott.sampson@gmail.com
To: Kuniyuki Iwashima <kuni1840@gmail.com>, christian@heusel.eu
Cc: davem@davemloft.net, difrost.kernel@gmail.com, dnaim@cachyos.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
 netdev@vger.kernel.org, 	pabeni@redhat.com, regressions@lists.linux.dev
Date: Tue, 16 Sep 2025 17:16:40 -0500
In-Reply-To: <20250611164339.2828069-1-kuni1840@gmail.com>
References: <58be003a-c956-494b-be04-09a5d2c411b9@heusel.eu>
	 <20250611164339.2828069-1-kuni1840@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> Thanks for the report.
>=20
> Could you test the diff below ?
>=20
> look like some programs start listen()ing before setting
> SO_PASSCRED or SO_PASSPIDFD and there's a small race window.
>=20
> ---8<---
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index fd6b5e17f6c4..87439d7f965d 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1971,7 +1971,8 @@ static void unix_maybe_add_creds(struct sk_buff
> *skb, const struct sock *sk,
> =C2=A0	if (UNIXCB(skb).pid)
> =C2=A0		return;
> =C2=A0
> -	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
> +	if (unix_may_passcred(sk) || unix_may_passcred(other) ||
> +	=C2=A0=C2=A0=C2=A0 !other->sk_socket) {
> =C2=A0		UNIXCB(skb).pid =3D get_pid(task_tgid(current));
> =C2=A0		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
> =C2=A0	}
> ---8<---
Just came across this when troubleshooting a resume from suspend issue
where I'm get a black screen after suspend. Initially saw this with my
distribution's(Linux 6.16.7-2-cachyos) kernel, and confirmed the issue
in the latest version of the vanilla mainline kernel. Bisection is also
pointing to commit 3f84d577b79d2fce8221244f2509734940609ca6.=20

This patch appears to be already applied in the mainline kernel, so
this might be something different. I'm new to mailing lists, so wasn't
sure if I should report this issue here or start a new email chain.

--=20
 Brian Sampson <brian.scott.sampson@gmail.com>

