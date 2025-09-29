Return-Path: <linux-kernel+bounces-836514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD064BA9E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48401687AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8056930C11D;
	Mon, 29 Sep 2025 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWJBQvKT"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A01309F03
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161530; cv=none; b=Md8WrfPHozOT054hdCxLIXUyreo0le2akS2+EP0ivmlT0mhnnvV6Qtggbbcu95QkolG3LPN3qLKC6K9iQGgSxn+rg5SXRyfmJjUpxTI2Jq8T9IJhRw3P3dBJGDHgLKtVBFFLtScfkjfPsCpCBvKGhGxvJLFPy6slnj0bo9dGxss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161530; c=relaxed/simple;
	bh=KP5kx0VRuRBxNT9JPTkeTOUgylYmXovvWpGXUsY+dqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHzddW5bDGDf8FfzZvkWxeq4TQnxd+e5Sy4gWgb/IuvV6Hl4HP3wEwI2imZ0p8lQbKnueaxhbmh8Gw85diNhFAPtVM1hgHhpGTW7IP7DqKWWiujRC/if+TkZokCYOgh/CvIslmiHWdh+NT74MpNAuptQ6C3vv1HHct+ZINFiuok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWJBQvKT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b41870fef44so39264266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759161528; x=1759766328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP5kx0VRuRBxNT9JPTkeTOUgylYmXovvWpGXUsY+dqk=;
        b=ZWJBQvKT9Qc5PmNyldyHZaLCt3fwNojyu977328l5tFx8x1FT10gVhl8DQFhgpBpuW
         wKoP8TajHfA3LEezjyvdudvDtyJpPLd4nQ1l6EP3rMvjgRT97rWShu2jP6YgeH+jMSiT
         jZGaBmt3cPJneNkKbaLPDm/T6/JnehPZQNrw0DV/+8/BVclpkEUyexlc1wjjMhl8OX+c
         /JNPJQD4vKsVnFs+StQM92uXQWiyG2+KlJVF+8Fwd+Yg/b6SSUnbiDnUC+4bwW+U1pSh
         4rDQpya8OMl10l91QqpUNLfYXD2bEYp8XZQ+Qh25jHzLL9NnCZ5RcRJcAbVMJFDBzaNO
         /SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161528; x=1759766328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP5kx0VRuRBxNT9JPTkeTOUgylYmXovvWpGXUsY+dqk=;
        b=bw46FUIoIQi/N5LBEjyKjs/T3w5XI+yKwni9MjVIEla5Naz6i/mkCGrtS3QjFgJdHU
         /tXSr/XweGBWh2nJnA+7GNQrAaWrtwC+14elfGUVuAYh0gf/qFFzZPsp5zj9naQTMRFK
         xlm/GD06J5BOtbglw0sSTnjQGrxj5VuAJxYYX53XQqziqXdyYuXhemCZGbmxJSdIm438
         uj7MX7pTlcBItanxQz+8jBhmyTPmaabD9ZDRsfdPlwKP4IJDtKw6HzrdtvIjXb0A1pPw
         n19vh25QlEg7aQhdfpqJg+cmsgUV1kujKIQXozgM3ut9cHfMiEgyLsWjSvUEqgxSGwmp
         TKbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWIEcafEIMpNH0XHLRMqsYtfzMfHSwymIbnTYEbZLcBiS2pJEN2qfDHlP5ATKbPgQLoSkfdP6noER5U9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdnGmYjEcn7sRE8pBdAlORra83IlBt93AqfCghdunPMHFzuv8C
	fW4kBBKBY3v2pMPElRbwusf8KhuNz2iK5i8QmCFYN+y90INhDLMSRZXW1gKFd0KfhAmxabbR5Kz
	fo2JfTC06gRWaCoakFZlqFssl9HlNWi8=
X-Gm-Gg: ASbGnct9y5WX+++Gs2d/lWzsdjMGusepa6alEIWO3fRcdP5gU/0Pqr/3hE1inz7Yrtn
	F24VurgXVcgt1LU1JHbe6n1OqlQIsyBxwZfKXlJtx2IWPVqV0ZKTHQWN2ks0mXdBY6d7JU9yKPk
	GNGLp0pPFEAWWB9aCFFaKKNsdU5NMfO+mTlew8G9FZUO6sjXXkwh5wxbEabIslnZN13xf+kXPTS
	oXBIfxzycQ+Pw7FGC1coSFTIa4acKsOA+QTfxp20g==
X-Google-Smtp-Source: AGHT+IEyCADO6J8WiEBVdrcDX+0EvoZzPtvlyZ0fcAEpiz0fGzu77FQXIwzegr8XJ0+/55shLRsQasieeKC3kMA42EI=
X-Received: by 2002:a17:907:9706:b0:b3f:6e5:256 with SMTP id
 a640c23a62f3a-b3f06e527cemr412737666b.32.1759161527436; Mon, 29 Sep 2025
 08:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929114356.25261-2-sidharthseela@gmail.com> <willemdebruijn.kernel.a37b90bf9586@gmail.com>
In-Reply-To: <willemdebruijn.kernel.a37b90bf9586@gmail.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Mon, 29 Sep 2025 21:28:36 +0530
X-Gm-Features: AS18NWCgnPycz7t2entTrmTu5YC-DafC0Q0uYk2zgNL_KC7OWEjNYY7xyUDcjPI
Message-ID: <CAJE-K+C9_En-QWYrTJmMH-H8CP_1wgpREjFst1ybiE-bJtF13g@mail.gmail.com>
Subject: Re: [PATCH] selftest:net: Fix uninit pointers and return values
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: antonio@openvpn.net, sd@queasysnail.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	kernelxing@tencent.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 7:49=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> [PATCH net]
> and a Fixes tag
Thankyou, I'll add that.

> Does not need a fix. The default statement calls error() which exits the =
program.
> Same.
Yes, you are correct.

> Agreed on all the occurrences and the ovpn fixes.
Alright, I'll send v2, with improvements and a changelog.
--=20
Thanks,
Sidharth Seela
www.realtimedesign.org

