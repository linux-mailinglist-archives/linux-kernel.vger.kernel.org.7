Return-Path: <linux-kernel+bounces-869231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 395B9C075B9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34F344E9731
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DCB2DC787;
	Fri, 24 Oct 2025 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoJdqLrB"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A2C27EFEE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324019; cv=none; b=VFe6bti5m/7gvTbG0YAVAdBDJC0dvjw77H33nPYyhjszLyki9gFBY7LBHjDGpBAPxuahrg1QJ1rQvrQhwogy5lTPeoBSnZTWeuSDM60qt92zxlqurKZsCb6qn2jvYnlwPz5qML5Wxte7Px5Pu2r4iTd1OHFIxMdR4SooJqLqBAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324019; c=relaxed/simple;
	bh=zY1x8pkp3JHYvPAasZkIBLsCyF5RZpKdpI56ur2OAXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMgnv0Qm2iixRh7jh2Q54DtfCsCA3bYK/Zywvq9XnEH11zLf1OugN2WObm5RXubjpZDjc2Nm8v17ZT7u4jZfk5rVVoAaA7nJyTb5eB7iTwWTZBqPzMfB7+ZSRoukZ5hWPcTvSBMT8AkQDI6tT3TzRsMo4sX7Nn7Qu+0yvsWZruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoJdqLrB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-421851bca51so2040383f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761324016; x=1761928816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw97z5l4lnfusgi0B6gtX6tbHrSHKOvenq7yPMS/Ep4=;
        b=WoJdqLrB3advnq2v92IgL/pA3ZtUo6sAzCZtVF/Xeye9zXbar7lku3DtcZ4AJuKTUC
         l9lTTGPAFxLKLmjVxO8LAtINUmT0uFwoYKao7NOEYMiP/xymH7CNxnGLUPnEytAEx39p
         h6z+fy3eNFKHw07VFNxvYS7YLQJhQL75gSa1derXouA2hfavSdlH+VPIqxCoFybwLxTM
         cmlCzxcDfnhmXbMcUUQeM909u3Amhm2TsRjI+VtY/xEEOYE6tnaZfbZWEND08EKDp4Qg
         SftQT7Us/Tup9PKPWAPyILgtQmdh60pJJRRi5y3snArdgvWcHAY+T4F8JJysyoJUtW9S
         90uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761324016; x=1761928816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw97z5l4lnfusgi0B6gtX6tbHrSHKOvenq7yPMS/Ep4=;
        b=cOvTBaY3JBsh9bhG/E0SJOgHVhPaJUZNiAGyHeaL0XsaJSDnfZZGH7gjiu6Dtg//wp
         cLVZyyPsxX+el6PSLCALkiyY5CZCdbETpJ8mP61E7z3nfz75k6NVSyTAqvAtuolGhu19
         SzxMSlT8SuMJEddsjFgloxQkc0/DdlPPKmmsw9o52Sm7NjlysYh0qYH4vkEYRJPufsSc
         aYtlvoUODbbBc1yYMSyRcr0fkYG6V97+ER9OoQWG6HYuyNwHYF390ekBMs6lmPV7Dq37
         5bkbKkePlUD3qphr7Gv0UFIW4ECXkHEVD6hcQsjNauOba5fDWdUtk+ChhqcHXx8OKyTH
         quKA==
X-Forwarded-Encrypted: i=1; AJvYcCWOd/1YJ5MiD7vfFZiuzoyXkKZseTqxtS9E7IHZl5YhIWhuDsd7FL/gCCOLWh8+Y673C5gS3jmSMO54OkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIWkM3PccBWQC2Jgp7lEAp7mcBOFeeDaAtrnv/3jPJdz4UFmB
	097WWGkZnez3HcP+ucFjjNiF5xwJ3YmnyOAg3KIWr6rkSXT0H3uAfwn+6DUOhQWeH27r18XAbQ5
	INCAeCzXeUXURbALh3JCZzltHsyDbrsk=
X-Gm-Gg: ASbGncvq8aMQTkFciVMQE1MAJlgiC0O0zS+ribY+0c+GNLH6YuWkM1agsdj9PS+67VV
	J8Oc06MyTSworlrv5aPv3ZswBEwX6owTBebrHDcDiwa2eP62B36mOtfo41TcMC06ufU7Nf09SGv
	dfGp68xCB4XAGxpO5qRNWoSH1M195vcqvpQKPGkWdL0TVDvbgZd4GooTdJUcJeUwK0ZzjGbi8JM
	jd1AywGTIPwl6lRLSq8pn2gPxggSC2s3Y4TC9hPxLG0keez1qP4ViwP5O+8h+a8wzU0fVl1ow5p
	P0K4IddQ9mVEDfFNZeyH2KWkfJDF
X-Google-Smtp-Source: AGHT+IHK0BkHt6HouTHdKqbCaevCHpH/9QKhUnu5NxzFB/rtnIu+qPgnyrWQ6kfs1rdobk48tki/1cq52QndLNYq+Ds=
X-Received: by 2002:a05:6000:4313:b0:427:587:d9ae with SMTP id
 ffacd0b85a97d-429907105b0mr2238101f8f.9.1761324015674; Fri, 24 Oct 2025
 09:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022164457.1203756-1-kafai.wan@linux.dev> <20251022164457.1203756-2-kafai.wan@linux.dev>
 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev> <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
 <CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com>
 <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
 <0d267da41178f3ac4669621516888a06d6aa5665.camel@linux.dev>
 <f0a52150bc99aa4da1a25d6181975cd3c80a717f.camel@gmail.com>
 <b190c9b2837b28cf579aa38126de50e29e0add32.camel@linux.dev>
 <0d98a2c754884e94c3367209680c071a8df4279d.camel@gmail.com> <90ec497a230584b0e627d12eaf172236b7a5165b.camel@linux.dev>
In-Reply-To: <90ec497a230584b0e627d12eaf172236b7a5165b.camel@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 09:40:03 -0700
X-Gm-Features: AWmQ_bnzMe2UZMxHqVHpxQmyG0xzGNPfbsQ_TIE48YkMD_ZAtpOeTGKimriDelM
Message-ID: <CAADnVQ+Tt4GkhV74P_bekvCWbZOBgR5PEYt7sQHEzMTDeE4j9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for conditional
 jumps on same register
To: KaFai Wan <kafai.wan@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>, colin.i.king@gmail.com, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:38=E2=80=AFAM KaFai Wan <kafai.wan@linux.dev> wro=
te:
>
> On Fri, 2025-10-24 at 09:21 -0700, Eduard Zingerman wrote:
> > On Sat, 2025-10-25 at 00:13 +0800, KaFai Wan wrote:
> >
> > [...]
> >
> > > For non-scalar cases we only allow pointer comparison on pkt_ptr, thi=
s check is before
> > > is_branch_taken()
> > >
> > >     src_reg =3D &regs[insn->src_reg];
> > >     if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(s=
rc_reg)) &&
> > >         is_pointer_value(env, insn->src_reg)) {
> > >             verbose(env, "R%d pointer comparison prohibited\n",
> > >                     insn->src_reg);
> > >             return -EACCES;
> > >     }
> > >
> > > and in the end of check_cond_jmp_op() (after is_branch_taken()), we c=
hecked again
> > >
> > >     } else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src=
_reg],
> > >                                        this_branch, other_branch) &&
> > >                is_pointer_value(env, insn->dst_reg)) {
> > >             verbose(env, "R%d pointer comparison prohibited\n",
> > >                     insn->dst_reg);
> > >             return -EACCES;
> > >     }
> > >
> > > this time we check if it is valid comparison on pkt_ptr in try_match_=
pkt_pointers().
> > >
> > > Currently we just allow 4 opcode (BPF_JGT, BPF_JLT, BPF_JGE, BPF_JLE)=
 on pkt_ptr, and with
> > > conditions. But we bypass these prohibits in privileged mode (is_poin=
ter_value() always
> > > return false in privileged mode).
> > >
> > > So the logic skip these prohibits for pkt_ptr in unprivileged mode.
> >
> > Well, yes, but do you really need to do forbid `if r0 > r0 goto ...` in=
 unpriv?
>
> Currently `if r0 > r0 goto ...` is forbid in unpriv, but we can allow it.

Let's not relax unpriv. We don't need new threads with researchers
whether such things can be exploited.

