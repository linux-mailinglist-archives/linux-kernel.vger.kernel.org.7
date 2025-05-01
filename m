Return-Path: <linux-kernel+bounces-628610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 260B4AA6009
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 16:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2641BC613C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819181A2C06;
	Thu,  1 May 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhgNNZkf"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4329CE6;
	Thu,  1 May 2025 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109870; cv=none; b=q+AEcI7nPW+ois9h792kfi5yz+I5OeAQmocn0ytaJRBVFYXc2rpItRoc2izl+BlL6Lj+olm3Dggo2TaP+9XKsYNxK1jkfpArza4I07Cs9I58ypkhMweSB5cmOaYH9/LwsMD2+jiWEamqcLVnWmolT/tX4yVx6DMIVlr2zukjYwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109870; c=relaxed/simple;
	bh=2U+HvMZCQBKFfXxcyHKnBbd6XO0ppA1oX8u1vk2GEIM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mFwie1rDbDQj2dY0V6YxKSW/tp3mUWN0FCuwExXa4qFbclTrF3hlU5BtJX7HPNi5TsGfQeltCzj2aXlDU/4uAa2BcC5Ht6lSbbfJwgFM+nGTjDfs0JU/VarR62V4/Tw7hkGkQJe4FN4DTizn3kn+dkGZAW+MlPu6f3TZbEgdNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhgNNZkf; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so862721a12.3;
        Thu, 01 May 2025 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746109869; x=1746714669; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/+xbe7B9WnLsTW32QSPO2M2Qj4XtkaaAcx8/Jq8fxo=;
        b=lhgNNZkf5CnTFrM6GqoVubv2AKMrgZzv0sSIzQ1KZBxiOyY0uh2UmxWACTJkkzGCEd
         Wdmq0/aR/CFqOvHXdncmjeNGezpHTKj321e12wYZIvqbLrCkihIbM3bQs/QYOJ+Y5CTt
         6WSh7KbdJyTGEgPhvH+y/1uXMkXlwiqhMmWXN4ZXT2/PueOxsevg8I1tZLhPQk/IOEOy
         qa8lzZj9fxwxOszjevFJusRkeX1GbwPys4cPyJYMIJ4Z4MkifAKiLERk0dZ6dDEmkJU/
         DgeoXogp7qa/STMyy+2+IE9lwoR013y2EmWfvYntZTCYqBtN/ICXCXGfjA8VVKk3CutG
         IOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746109869; x=1746714669;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/+xbe7B9WnLsTW32QSPO2M2Qj4XtkaaAcx8/Jq8fxo=;
        b=hX0btV5Sc5hA+iftSNQdWODFVphZZ44McqIQy6ty7OhzohRxyAVJqVKSGYe9CW0yQm
         HvgFw+RJnGxajl9pL49z6O4hc+2UTPVLjgKQw6n+4QDt68W0uYQXErYPkRjy5KOkXUqs
         Ys5s2AgLd3YJt76HE2/1bd2Vk5ypAo/wlKhWYZVGumW6bFOMjG/jHinC4dZ1suygPLjf
         +RysA82VYobw07Tw76Qu7ZCgr3EAOZfxdsqHIPBlaaEDkvR3KJruj5sgq0xHB9TI/WK9
         soxvKVI3bDiAN/n2fZrg58Y/9/WUOHVgiyx0Oi7TNO46G2YGa6B8W2mzS66hxxkt2UTr
         p63A==
X-Forwarded-Encrypted: i=1; AJvYcCUXqw30s7/dZ3OXC82dbdMu/foRMMzeZLs3+UXAfL0B3nXjM21DSwE2XgaQsqMWBRHbsoehkMM+LRg+Wlhw@vger.kernel.org, AJvYcCW6+16wv/5gI54I79AUNrFXqfjIyRUmJ1Z+WTfhvBlOlrHQ2t0AyY8hfrxOmWWYA/DPE7BJ54r51wYyCQH0FA==@vger.kernel.org, AJvYcCXt2zLbs9FhkWErAwC8B5LdxluKyJRozGb38fuihAP89EHy33L7/Rq2IDRDMZiS/93yJzGqo+GwM1IeznDeS5WT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1om2KvJwk3URD9Tdx5aJ/DxVFfVjJ9aayO9EYaMs+TEgeikfG
	j3DkQncHahKSzy1I8wQh/HQQDfJGV9jfdz01XoG7yOJKTsdqQze8
X-Gm-Gg: ASbGnculL7o8etOVsKUnRc4C8wTend0g4/p1P6e08QG6IXjpe15zoYxjrriMxoWYCiS
	Ll4m+DuSgpPo849A0B32+602CE/Zru6SbvGq8iPVBVKnjTRS66ni112Ycs2hCr/M7I09AvRFZR4
	zd/bbk2S0FMI/261qRvdQuAbvnkr5X9AC4+D2IAx4C/GtotpbdXgZJX5aGYvkxGhtVl7GchcGBm
	vCOLoIuinGI2cJtaEhxyl5n2eyBDoDOU59fCPvb3B8WpQ6Zzx5z7KWCOjCPGLAwHYjKOE6IuBOe
	1eXhDXCMoxSEjczFoNTu4syO
X-Google-Smtp-Source: AGHT+IFaThBWopxzXAgncPpLv3TrOr/bq9r8uKV8fSRutm8p2FAw//3a9JPoEboHo5oMj7t7b2P0mQ==
X-Received: by 2002:a05:6a21:339d:b0:1f5:5ed0:4d75 with SMTP id adf61e73a8af0-20bd81404cbmr3786093637.31.1746109868458;
        Thu, 01 May 2025 07:31:08 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1f9d4ec7afsm676628a12.41.2025.05.01.07.31.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2025 07:31:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [REGRESSION][BISECTED] erroneous buffer overflow detected in
 bch2_xattr_validate
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <Zxu4yhmxohKEJVSg@archlinux>
Date: Thu, 1 May 2025 22:30:44 +0800
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>,
 Kees Cook <kees@kernel.org>,
 regressions@lists.linux.dev,
 linux-bcachefs@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 ardb@kernel.org,
 ojeda@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <775D7FF5-052B-42B9-A1B3-3E6C0C8296DA@gmail.com>
References: <ZwNb-_UPL9BPSg9N@archlinux>
 <CAGG=3QUatjhoDHdkDtZ+ftz7JvMhvaQ9XkFyyZSt_95V_nSN8A@mail.gmail.com>
 <CAGG=3QVcsuN0Sk79oZWjY_nNTo_XfGYsDT3gc7vEmLyS8OK3rA@mail.gmail.com>
 <ZxB-uh1KzfD4ww2a@archlinux> <20241017165522.GA370674@thelio-3990X>
 <ZxWvcAPHPaRxp9UE@archlinux> <20241021192557.GA2041610@thelio-3990X>
 <ZxpIwkfg9_mHO3lq@archlinux> <20241025011527.GA740745@thelio-3990X>
 <CANiq72nbyqrzGr3Uw_vx-+8DLiv6KbeULrxpyK8Lh4ma15cq8g@mail.gmail.com>
 <Zxu4yhmxohKEJVSg@archlinux>
To: Jan Hendrik Farr <kernel@jfarr.cc>,
 kent.overstreet@linux.dev,
 Thorsten Blum <thorsten.blum@toblux.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

On Oct 25, 2024, at 23:27, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>=20
> On 25 10:10:38, Miguel Ojeda wrote:
>> On Fri, Oct 25, 2024 at 3:15=E2=80=AFAM Nathan Chancellor =
<nathan@kernel.org> wrote:
>>>=20
>>> on the official submission.
>>=20
>> Same -- please feel free to add:
>>=20
>> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
>>=20
>> One nit below that is fine either way:
>>=20
>>>> +# clang needs to be at least 19.1.3 to avoid __bdos =
miscalculations
>>>> +# https://github.com/llvm/llvm-project/pull/110497
>>>> +# https://github.com/llvm/llvm-project/pull/112636
>>>> +# TODO: when gcc 15 is released remove the build test and add gcc =
version check
>>=20
>> I would perhaps move these closer to the respective lines they are
>> comment on (i.e. `depends on` and `def_bool`).
>>=20
>=20
> Done, thanks!
>=20
> config CC_HAS_COUNTED_BY
> # TODO: when gcc 15 is released remove the build test and add
> # a gcc version check
> def_bool $(success,echo 'struct flex { int count; int array[] =
__attribute__((__counted_by__(count))); };' | $(CC) $(CLANG_FLAGS) -x c =
- -c -o /dev/null -Werror)
> # clang needs to be at least 19.1.3 to avoid __bdos miscalculations
> # https://github.com/llvm/llvm-project/pull/110497
> # https://github.com/llvm/llvm-project/pull/112636
> depends on !(CC_IS_CLANG && CLANG_VERSION < 190103)

Hello,=20

Now there are users using gcc 15.1.1 came across the similar issue (they =
are fine with gcc 14.2.1 ):

	=
https://privatebin.net/?a0d4e97d590d71e1#9bLmp2Kb5NU6X6cZEucchDcu88HzUQwHU=
ah8okKPReEt

I wonder if the __counted_by(x_name_len) in struct bch_xattr is needed, =
since there is also a value after x_name.

Thanks,
Alan




