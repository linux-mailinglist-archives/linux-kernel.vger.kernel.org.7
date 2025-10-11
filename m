Return-Path: <linux-kernel+bounces-848911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B6DBCECD3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 02:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C170019A44D5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29A4DF72;
	Sat, 11 Oct 2025 00:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSqpPW+n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B53C2F
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760141861; cv=none; b=ET2TGC3i7B2P0kaRiqzy36ovpd575z6VNgA1cTWP76Ca6oCMWPow6gjSp5D5oFm5VkovsK+VjY9ZN3D5UUsIN2bbsYHRn+9PQNmB50AMWj18Ren0K4Jfq/8BhRPYpTJYXYeTeI2LofUFFTJN4CxAJPmFXyQeO7BovdrlyCVT+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760141861; c=relaxed/simple;
	bh=aurbYv/vTkfn9HIChUPF+R+B5adUjKdvTNF0+vMzUMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwunDDYuFsT1EIxmqdNpqV2k2za40xiTNa2vh0/ufzQqs5ToLzEfzWWAImRf8YKgpUtz0puff/n1Z3EKx0QO1z5b2oZNiGpBGpiisJ6OPMK5LDjhUAzGOhzMKXzrgOGbpwIV0mH9aao+4OkCZDMLPFQvZvw31TsdYgGrmfQ3KF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSqpPW+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4E7C116C6
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760141860;
	bh=aurbYv/vTkfn9HIChUPF+R+B5adUjKdvTNF0+vMzUMk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dSqpPW+nHOMzDlK4YBIAjoI+HWIfEPZOFSsVyRGg1Cv9hT5Yzgc4+3sl9yyPp371Y
	 8/5pfYgUH5MpAztQI92PHBlZTTPhXN0woqvSZD0ofbx0YA/LqzQKjSAI/fjHqcvOaQ
	 GhZMKh7swwUejL0SZZV+jVGYlHuEMFPbAKALMja/hVuUkTTid+YVyDPYtIufkOFJ7Z
	 +1/Ig8VliyZh7sigtaJvfXBqzXV3ix8wIx2JSh9j4SPLp71PZ7CgowF+n4GsSoWlcp
	 RxwDcFcrlvBuyiLehrTm9GWCwqrbxDRagQTqqYNn59QyxI3EY2GH8hrFikt9RslPQT
	 F9bPvtqEi6wVQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57a604fecb4so3317518e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:17:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXioE4ywGAPprNO4bYBHA2mT8L3yTjavtMahWMs/63jeyBlNjyWyByF9rYgdgRV8NYI4hC/DDaZAZ64F4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzPI9fJu5JxY92qR1GCfN2NpSizBUF9GLD2yRo75Az2jnejhIR
	XcFDS7eGbCucdt4jBgqLilLOwXoWYxvRpZTH7LmgycO69Lfw7mWILE0HO/PZAhHKZnouw5mmzFm
	IOqnvsjwoseeRDVKa+qIRa2lSDpcKHvk=
X-Google-Smtp-Source: AGHT+IFYoBXl8MLluMTfeFwJa+NEuCYmEcZBESbt41XDIJLh5zc+uZZNMpU3+8nz0NSO+UX0bF6jbyWWcJ32afRcmkw=
X-Received: by 2002:a05:6512:2247:b0:587:94d4:9f7 with SMTP id
 2adb3069b0e04-5906dafcef9mr4486420e87.57.1760141859021; Fri, 10 Oct 2025
 17:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011001047.51886-1-ebiggers@kernel.org>
In-Reply-To: <20251011001047.51886-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Oct 2025 17:17:26 -0700
X-Gmail-Original-Message-ID: <CAMj1kXEcVSbib2G9hByCcMqvGVvqCcvgLJR09kGpHfVUJo7Jcg@mail.gmail.com>
X-Gm-Features: AS18NWBgw-3ehwGSdcD9jpkVDhSrROiFc_n2ExAQIc6Y2SSjkNyUqzxOoNatpdo
Message-ID: <CAMj1kXEcVSbib2G9hByCcMqvGVvqCcvgLJR09kGpHfVUJo7Jcg@mail.gmail.com>
Subject: Re: [PATCH v2] lib/crypto: Add FIPS self-tests for SHA-1 and SHA-2
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Joachim Vandersmissen <git@jvdsn.com>, David Howells <dhowells@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Oct 2025 at 17:12, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Add FIPS cryptographic algorithm self-tests for all SHA-1 and SHA-2
> algorithms.  Following the "Implementation Guidance for FIPS 140-3"
> document, to achieve this it's sufficient to just test a single test
> vector for each of HMAC-SHA1, HMAC-SHA256, and HMAC-SHA512.
>
> Just run these tests in the initcalls, following the example of e.g.
> crypto/kdf_sp800108.c.  Note that this should meet the FIPS self-test
> requirement even in the built-in case, given that the initcalls run
> before userspace, storage, network, etc. are accessible.
>
> This does not fix a regression, seeing as lib/ has had SHA-1 support
> since 2005 and SHA-256 support since 2018.  Neither ever had FIPS
> self-tests.  Moreover, fips=1 support has always been an unfinished
> feature upstream.  However, with lib/ now being used more widely, it's
> now seeing more scrutiny and people seem to want these now.
>
> Link: https://lore.kernel.org/linux-crypto/20250917184856.GA2560@quark/
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

