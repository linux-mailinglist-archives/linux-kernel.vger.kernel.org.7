Return-Path: <linux-kernel+bounces-859845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65751BEEBC3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B73AD4E6C93
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 19:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514502288F7;
	Sun, 19 Oct 2025 19:18:25 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB91F1517;
	Sun, 19 Oct 2025 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760901504; cv=none; b=Dww8cns5BC6d0dNxSVbe2FwImqGmg20a1pS+dzaHeT4MKX9cXy2PyhIq0s8xYdOXHaMfn+qskUpx6dLOCYYhJXPQ6Ay13wYl15NL4MTNox6NX7L2xVfQQlgQk8QbyOvMgLwQKRPN+Y+6W8P3suyf9PD5n3JjH2Jw8nXmA4ORUFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760901504; c=relaxed/simple;
	bh=P9mKEoh5Li1NdU6vReTugEXGJWFzP5Gs2NLQrMhAWHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nCAfRkNwJR/J4i0j8hItaaO9CLz0z4/1rB4rVK5mWwBFCnvv3phyCJu8yU7N4vMyrzmR8AAuvu+AJa8ufCwA8RB+aN+4LjaaewLyZ+ybcZdjAkDTo/UAkT4UysPYAfIN+hdtFd69yKR+wvBRJ7tGmdnWeWQtE9owMty/s1VFICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id AE112340F14;
	Sun, 19 Oct 2025 19:18:21 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Matt Turner <mattst88@gmail.com>,  Stian Halseth <stian@itx.no>,  Magnus
 Lindholm <linmag7@gmail.com>,  linux-alpha@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alpha: don't reference obsolete termio struct for TC*
 constants
In-Reply-To: <99f1a93cf8cd4f0ece8611be2860677084663aac.1759359610.git.sam@gentoo.org>
Organization: Gentoo
References: <99f1a93cf8cd4f0ece8611be2860677084663aac.1759359610.git.sam@gentoo.org>
User-Agent: mu4e 1.12.13; emacs 31.0.50
Date: Sun, 19 Oct 2025 20:18:18 +0100
Message-ID: <875xcaaef9.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sam James <sam@gentoo.org> writes:

> Similar in nature to ab107276607af90b13a5994997e19b7b9731e251. glibc-2.42
> drops the legacy termio struct, but the ioctls.h header still defines some
> TC* constants in terms of termio (via sizeof). Hardcode the values instead.
>
> This fixes building Python for example, which falls over like:
>   ./Modules/termios.c:1119:16: error: invalid application of 'sizeof' to incomplete type 'struct termio'
>
> Link: https://bugs.gentoo.org/961769
> Link: https://bugs.gentoo.org/962600
> Co-authored-by: Stian Halseth <stian@itx.no>
> Co-authored-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
> v3: Fix constants per Magnus.
> v2: Fix title.

Ping.

>
>  arch/alpha/include/uapi/asm/ioctls.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/ioctls.h b/arch/alpha/include/uapi/asm/ioctls.h
> index 971311605288f..a09d04b49cc65 100644
> --- a/arch/alpha/include/uapi/asm/ioctls.h
> +++ b/arch/alpha/include/uapi/asm/ioctls.h
> @@ -23,10 +23,10 @@
>  #define TCSETSW		_IOW('t', 21, struct termios)
>  #define TCSETSF		_IOW('t', 22, struct termios)
>  
> -#define TCGETA		_IOR('t', 23, struct termio)
> -#define TCSETA		_IOW('t', 24, struct termio)
> -#define TCSETAW		_IOW('t', 25, struct termio)
> -#define TCSETAF		_IOW('t', 28, struct termio)
> +#define TCGETA          0x40127417
> +#define TCSETA          0x80127418
> +#define TCSETAW         0x80127419
> +#define TCSETAF         0x8012741c
>  
>  #define TCSBRK		_IO('t', 29)
>  #define TCXONC		_IO('t', 30)

