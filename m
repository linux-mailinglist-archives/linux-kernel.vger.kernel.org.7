Return-Path: <linux-kernel+bounces-890852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A5FC412D5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CF504EA856
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C880338927;
	Fri,  7 Nov 2025 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBllT/HU"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06543385A0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538228; cv=none; b=Wm3PppFB0vja1ztC1gQvaK7jKpbmzAmuX9ecLfQuiPv9GCMhFkWpCf56krBPXuyO/4Wy3LBo3T6x3WVdWC6OXjvxIM87+WIFi5SiO+MATXzvutTBELiFTPIlxM4cG6iXeWVKrESyNRjMS97SDChTA1p4EEo27O0votuA0sWXNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538228; c=relaxed/simple;
	bh=RSvet1hGFhNMSbzfn7C2gcX1x5+f+dd1m1faFTAl1dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFdhCASWSskqs4ZlmzMl0mYExAAZzdo9TsAVpJXvjzouk4a2xgzPxWfhYuvHRJ5zMD0IV+4fdiqF8Sff5TshjGE7XWFPfwQCsFDOAXBKXJKqQNISYRRgg961ecbfWI4mI5joWrxuQwoxB4trwBJOZgx/3CZTBpdBG8ud/y4z3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBllT/HU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-295351ad2f5so1288315ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762538226; x=1763143026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSvet1hGFhNMSbzfn7C2gcX1x5+f+dd1m1faFTAl1dg=;
        b=YBllT/HU9U2HMRsvk/QW5UCcY1GB3iXqVlopFi6Bp/DS1/aRM6S6gDM9d0DcHxY5qF
         Ba4c3+84uq3q0sfPTDK21dxBT3Qe08H0vYA8PpiIkU3PviP8aO39rQDe0iT/zLT5j4rb
         5z5crJe7yQAgFulHmS+rgUChA5oYfjmrBCJYkBlN0JUOZfJboHTOwGr/qwxmro2cfRIP
         BpKoKYlnUtmjLWqcOeB4EU34SwSuH3iDX6tEDCrKBqYMGyBQdjwE61feG2WGRSMkXCNY
         E4MBKuIP6geTsbQ7CcCaWXckrY8FuFzs7FrZd0nvuDBiXx0VNjDU1LbUpLNwsQiu/tpj
         bRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762538226; x=1763143026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RSvet1hGFhNMSbzfn7C2gcX1x5+f+dd1m1faFTAl1dg=;
        b=KQm0DyKCo530ysDsKvC7Q+YS+r2vYsP4C6C0bVRFmnGUDsfe+W+ZKrt8Pwuw784XAe
         t+E2wtc2ATfBHr+yMbe9O4WANaSY/V6gH/hUBhYPo+p8LTr1g3kFbJ6Fa3V1XA6TmZKJ
         J50DXEb5lZyVnCbkyadvGkN+kMfkBNVLWktye5LtdzCVYhEiHCJ9K8wJ1lb7LkyVtP6h
         ZZ5ryr4+NO/MsJkztkZbjq4XE30nzUklZEAo3krbmyDN6CuTAUWv+EWYXMNPIpRqRzZS
         pz69BOeNaaGm71ofN5yreUGo69c3l2UuVt92eIFMnSzIlFUkybpjq7NuZJ/KC226WpZa
         WqJw==
X-Forwarded-Encrypted: i=1; AJvYcCXlroSC//ZPTDD7AzGxOYf/Li9wm+aUcb8ZkT4UyrPyv5mxxfxQorpnQnGHpemeA07YUJr/xwuSIh0McjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3GyGzyA7xkgBgc2BnG6TQ7CmFpJcQOyt7lYnkI+G5ENKEa98D
	DmFetkvi6f7ADy9SvHJKELjCEvTFx00iTi6BGagBFNsk+6dARdamy8BJxAhjf5R+qbAL71GhQ4n
	XCLUzywH5NTLKTbeW9h5ezMUP0MIVBRQ3KydU3Uk=
X-Gm-Gg: ASbGncvW58TsN/MZQdPkhn0hpPbMvotMtb+zjJbWs61F2DghUFa20olVoUDu/+EXcdQ
	VJaMXT3rpIj/K+OEERRpKzkvDZTKMEqLJ1BlWBBG1fb9yEHkxepCzsmDz8VyctLkE4eQ0BznGNY
	+eGYqE5E5F9tF3Cq5wENql1JFZjKgdYRQKDFZMEPwlMJfqkVMHl4KaVmFikBtlCCTjhfiOeiPtq
	iDB1frS+zfAH2V6HjCe53q7NbB0eHdpjBgPm6ypYNW3f2/+1W5bLVNqohLTerOQJBYTCZasujUH
	hyuBrZKNBGAB5cN+BE24mKXqdsx6rzX/ZmLf6v77cUq4gxwyuHNHpG34VOWjZXhXr53QKFynXrz
	CgH8=
X-Google-Smtp-Source: AGHT+IEcZTSN4aKwKC5egIoA0UmNDa8Z3AvdE7wthF+TinMhFsnkvRKXfrW3Yysr5BNbtNDdHJ6Gn1gp8qQM4W9Hkyg=
X-Received: by 2002:a17:903:10b:b0:274:506d:7fe5 with SMTP id
 d9443c01a7336-297c03b1d55mr20192915ad.4.1762538225889; Fri, 07 Nov 2025
 09:57:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105062723.GA2341496@ax162>
In-Reply-To: <20251105062723.GA2341496@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Nov 2025 18:56:53 +0100
X-Gm-Features: AWmQ_bkgBWAnqAXBLtdQ6YJmXoxsa98i3NTbQ_nqWrZ4cr9q1bEnykYt-XXo5rI
Message-ID: <CANiq72k3WuXTyk-X1ye+7JThf2pNcgdKnqOrFieHqxOMZD2oZQ@mail.gmail.com>
Subject: Re: Prebuilt LLVM 21.1.5 uploaded
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 7:27=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> I have built and uploaded LLVM 21.1.5 to
> https://mirrors.edge.kernel.org/pub/tools/llvm/.
>
> If there are any issues found, please let us know via email or
> https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
> opportunity to get them fixed in main and backported before the 21.x
> series is no longer supported.

Rust-enabled x86_64 with upstream `rustc` works well:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks as usual!

By the way, not sure if there is a reason for it (e.g. a workaround
for a bug or you don't keep the old LLVM files etc.), but just in
case: the matching LLVM for Rust 1.91.0 (and likely the upcoming
1.91.1) is 21.1.2 from what I can see, not 21.1.3 in the table.

Cheers,
Miguel

