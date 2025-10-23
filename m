Return-Path: <linux-kernel+bounces-867581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7DFC0306D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423B81A66395
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA0F28643A;
	Thu, 23 Oct 2025 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/LqlZOg"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C221AC88A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244649; cv=none; b=nCJhU9jfm2k1wCTPFIhKUGE4zHXaIW/KUk4FZWyedpCm9RMsr9fGqLaf2xOFAYwERHzcVhxhFrQHAyShALQYqn6S01PqqkozUuELZBjZR+kv+3cqMhQ/B5zJ4l7Z2N9j1+dqJBQgtGMhr/NrAcCxGcw97rOtuL0qKQGAlNhB85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244649; c=relaxed/simple;
	bh=KRqUaIay42zUMMR+WlaGSAv3YkSsKZdFS0QWLd9/5XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyAHBPfTtDYZI3rtviAHGeLMT5YUPbG7BDDN4kUnTJngyKzoHWknUiXeUi+VoSgqNcceeBWvLptkmo1rb7FVPLU417t3Z/Ga/ePIdGPHdoQ+Xk+3ds4cn0n4B4fxaJ2KbXNKe8+v2LTT5zD+Xp/ZBUB65vVG6Agvl9Git6RqwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/LqlZOg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee130237a8so728933f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244646; x=1761849446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRqUaIay42zUMMR+WlaGSAv3YkSsKZdFS0QWLd9/5XI=;
        b=A/LqlZOgWhu+5tlrat+DsKQTP3ghnDp2jz2ng2mErFCLf006sjZU18Of1HEoaBuJOm
         HumY1iESQ6oEqoFkdbcfxp7Qz4+W0JjB2u16aqv9z0pXpfmtTrmSQyHUc/LaQ3oXZJpS
         NeQKO+djHhTbJ4V9Vl8z2x40hSDlKApi4o+YwaA2cZPjlATGTQuOqCQFwce2QEzp7qnE
         UCzHz9BsYBO15EgvSjAEGrIB0u+69e8wLNAXKaOWRsFuZAjtQbyTfbp2k06qfAPDZ5ta
         c01tUZDtZCku+h/gmJ9TnLE4X+Mz6OhV2oI9t5Q5JcvCz/HS+BWJwMFX7aORfiEuba/c
         mwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244646; x=1761849446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRqUaIay42zUMMR+WlaGSAv3YkSsKZdFS0QWLd9/5XI=;
        b=PGvEACZN+FIqsjj8VmRRztCB6Hd6DaXW0G+Qp09WgbmOdP6TQkgqs1/ymERVijjiIa
         FZvNqzrBKxhjFmm0fLMpC9iA0qOQ5qnP7wY/fiT2mcdBazD+tYa52gZgSpEwnZJv5D5M
         I8W+orOLqJ5bTtstSBSfUQl5J/kgtbYklFnl/ZXunFYQwUJ3d4l64O0GI9w8vWNftCfF
         1T+yubsfE1kIAwUODlrQTmMglDGRoR0ONxJ9yeTC/74nHYoSLem/u1cR23p8TvwlfBlI
         zQQYkfR/mclCpnjrjJazETVzn1X6DNMnO7nbNG196swCo/2ot6LlOnO7RM+Q7Cm+/EZi
         KKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQYKz45nb6c4Q4sm7ZyZFTKEW1GRFgj/32ACI4ro2OQC+qW1DP5FW/t/EXVcZ1JdCfYArDFijV+XBXBY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+xD6rm0hFSSuSCBHC9PW6c1P6wb5AE3Ei557mgGNXRO3LqEx
	2BIA9J9Qj4eL9JW8+7XENRmFOr65pV5u0muqiAB5jKxEgw6hWpm+IpxNMO3L+duwK9+WGa7uYf+
	NsVdQn0BtzXOS7ets8Ee1/rFCXM0Ex0s=
X-Gm-Gg: ASbGnctfLnHlL55UMgMxH0EKriEzu2p/nqAw3bawaaJFGfD+WwguhtcxhSwJY1T9MQW
	UrFRE9/bPb3zqhZ5K1NW/UhDGtMLjJXYgRLiTQU4GaQ7GWggizJRtTtwoj+FWHspfRsTasuns5D
	GtxhVWc7HZpkv1dvhoTOgnr3vF9btg25utg+1cp6WhG3Y1kz/rzWu2DZVZnZjzKGc0enMDLcWY9
	+Ptz9e7xX727wsd48AYq4z+MoeMH9nDk+Do1Ey4b7nekCcvCfH2DY9Z86zpMtioA1pVHWDAtxd6
X-Google-Smtp-Source: AGHT+IH4qsxJ7mUIL9zboxFt4pG9B3IJms50YZNQUEES4nrTzidPaOReyuWCPuy05NT2kA3v8XjMqzGJKcdLVVEvPMM=
X-Received: by 2002:a05:6000:24c9:b0:3ee:15b4:8470 with SMTP id
 ffacd0b85a97d-42704e07b7amr18102377f8f.45.1761244645680; Thu, 23 Oct 2025
 11:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-3-dolinux.peng@gmail.com> <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
 <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
 <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com>
 <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com>
 <CAADnVQKU0MnQHxxvnp9WCu_UO4fEtd_D6ckNmOd7pLg90ecF4A@mail.gmail.com> <CAEf4Bzajdv3Rd1xAxm_UZWBxPc8M0=VuUkfjJvOFSObOs19GbQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzajdv3Rd1xAxm_UZWBxPc8M0=VuUkfjJvOFSObOs19GbQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 23 Oct 2025 11:37:11 -0700
X-Gm-Features: AWmQ_bmQyKMJs6G-0_Lgj-Xl1X1ye0IBGPVkDkUPwvrDh9KvDzOfdTPLybE8VS4
Message-ID: <CAADnVQJG_tK18oxmjW37cbrxF2zPKPk_dvqXUTnOjUue7J0tLQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 9:28=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> Speaking of flags, though. I think adding BTF_F_SORTED flag to
> btf_header->flags seems useful, as that would allow libbpf (and user
> space apps working with BTF in general) to use more optimal
> find_by_name implementation. The only gotcha is that old kernels
> enforce this btf_header->flags to be zero, so pahole would need to
> know not to emit this when building BTF for old kernels (or, rather,
> we'll just teach pahole_flags in kernel build scripts to add this
> going forward). This is not very important for kernel, because kernel
> has to validate all this anyways, but would allow saving time for user
> space.

Thinking more about it... I don't think it's worth it.
It's an operational headache. I'd rather have newer pahole sort it
without on/off flags and detection, so that people can upgrade
pahole and build older kernels.
Also BTF_F_SORTED doesn't spell out the way it's sorted.
Things may change and we will need a new flag and so on.
I think it's easier to check in the kernel and libbpf whether
BTF is sorted the way they want it.
The check is simple, fast and done once. Then both (kernel and libbpf) can
set an internal flag and use different functions to search
within a given BTF.

