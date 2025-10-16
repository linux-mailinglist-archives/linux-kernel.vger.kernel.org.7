Return-Path: <linux-kernel+bounces-855503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E728BE17C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F13124ECA00
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B7E21D3EA;
	Thu, 16 Oct 2025 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ2XtwIO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE363748F
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760591030; cv=none; b=c+WW6naVsWAxES8tMTnFJSBRnv20Md0Wrs8H1A2g1numMWWHW+49S6JMBoadFUGhmeIJjq7cjfMAhd9toHcHeUvl0a/tFFMgcsRsaHH2mkfkxVQ3HYRnCGzrpyVIMjhVZBxeqIUrdCOP3bIWq2iUfd8dLXgGuCJOykJdG/s5iic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760591030; c=relaxed/simple;
	bh=XbNOMe4WEb74BHJ6N5Hs04lus3m+FI+k+2CKQNndKIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTuw+Fv6nGPJMTOLerWmomWBusnmqWtbnIv/dsDMk3lGDEiTuXXNmZFmNEVfO/RVMWC2P90qrYxhuEBnewOZ98VQasTDCqrl02+xJNhs36WVhqWarwPfKEXVFiS7JQO1GzneEP1RbzKXgnqCLZ4sRyJ17VJj62MatfmKVdox9hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ2XtwIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871E7C4CEFE
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760591030;
	bh=XbNOMe4WEb74BHJ6N5Hs04lus3m+FI+k+2CKQNndKIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SQ2XtwIOW5a496hDI5LhvC+pIL2pP3HCMNGllZWAx8DJvtDkPrUdLtg2padS2IUhe
	 pXDyYWOtPg5XPwBRl/NsqzQCRgxNYtajIfjxsq0jRcToFlKZU7+2/hQDegbRtGSNFP
	 7QyME+f2uQVGjh3ZED8+LJo6Ro+xYAuZWjhdV1vVGTO8+1az+Wo98teE211D2qlBai
	 SmEKfMkUSi367OIzsSzKeUgN50thrxrClA2+FdY4c+kkIXQCbBQHBaS8j3wik05A6S
	 yBJoyoHGMT6CquyaKbPrmz68DomgdyApOWj46HOeJ8dcLv8DKxWEb2Pm0mx4Qab/lc
	 aF6h9HWAUMfSQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so95747a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:03:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3QgN91OoNTYec8WWQue8AgZHKFv4hmr2uRvu/Syp1AH0/ANH9EuP8zqNG1yUP67gddnjw5OFfeTLmHvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCnSQbreuYuSFTN0VDM+cfismYJdE97MAjC68axeqKcGFY1Lum
	vnPW2TkLPLW6XQ0Qp8/sZG1EM1rGydiml1ZsEgm/j9nDkOuSkcfPxY4JZP8LdHsNpRtzkLit1fM
	NhdoRxn5EKUvRoARpLiSqxra2cRISmZc=
X-Google-Smtp-Source: AGHT+IFzpxfaJt7i6obli67Opa1w/oEbET38t4nGIt4EeUTQd/GUGQ8+7gCRiLnd7tDeiWOapSwtCQ1xat87tumll9k=
X-Received: by 2002:a17:906:2a1b:b0:b57:3089:7f75 with SMTP id
 a640c23a62f3a-b5730897fddmr1679093566b.3.1760591029101; Wed, 15 Oct 2025
 22:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014231759.136630-1-ebiggers@kernel.org>
In-Reply-To: <20251014231759.136630-1-ebiggers@kernel.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 16 Oct 2025 14:03:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_TGeG3NJq_0-+1YUzaNf9c7swAKvkBoofcGrOXMZ50eQ@mail.gmail.com>
X-Gm-Features: AS18NWBYQoQ2mcTx3PfZzJqAvDUcqWD1yyifhPdmmDlwbizTMvXn4gcKgBk5DMY
Message-ID: <CAKYAXd_TGeG3NJq_0-+1YUzaNf9c7swAKvkBoofcGrOXMZ50eQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ksmbd: More crypto library conversions
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 8:18=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> This series converts fs/smb/server/ to access SHA-512, HMAC-SHA256, and
> HMAC-MD5 using the library APIs instead of crypto_shash.
>
> This simplifies the code significantly.  It also slightly improves
> performance, as it eliminates unnecessary overhead.  I haven't done
> server-specific benchmarks, but you can get an idea of what to expect by
> looking at the numbers I gave for the similar client-side series:
> https://lore.kernel.org/linux-cifs/20251014034230.GC2763@sol/
>
> No change in behavior intended.  All the crypto computations should be
> the same as before.  I haven't tested this series (I did test the
> similar client-side series), but everything should still work.
>
> Eric Biggers (3):
>   ksmbd: Use SHA-512 library for SMB3.1.1 preauth hash
>   ksmbd: Use HMAC-SHA256 library for message signing and key generation
>   ksmbd: Use HMAC-MD5 library for NTLMv2
Applied them to #ksmbd-for-next-next.
Thanks!
>
>  fs/smb/server/Kconfig      |   6 +-
>  fs/smb/server/auth.c       | 390 +++++++------------------------------
>  fs/smb/server/auth.h       |  10 +-
>  fs/smb/server/crypto_ctx.c |  24 ---
>  fs/smb/server/crypto_ctx.h |  15 +-
>  fs/smb/server/server.c     |   4 -
>  fs/smb/server/smb2pdu.c    |  26 +--
>  fs/smb/server/smb_common.h |   2 +-
>  8 files changed, 87 insertions(+), 390 deletions(-)
>
>
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> --
> 2.51.0
>

