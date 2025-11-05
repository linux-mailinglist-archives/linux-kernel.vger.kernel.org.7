Return-Path: <linux-kernel+bounces-887506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D5FC38658
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3F41A21F96
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E0A1FA272;
	Wed,  5 Nov 2025 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DbINAsOv"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AD86348
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386421; cv=none; b=n6QzPEJ5NuXVY00ZV7Yqm3hE5ztG5PWGR3M+cWPoySz3RYvm4BNqiCPjU53GHBKjSQ3It2UQnn2SN9RlFj7T47HOfiTLOejvwTI0s1k6jYL+eh/SPpLbgO9LWFo8GoWQggt+3cFbnfuJxR6ocyeZeHIV2e6Gzg70NGvH6LVPUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386421; c=relaxed/simple;
	bh=N/oz1BwYzcHjoOXQYB622IPbG7xDXwRBab5WrG4oiBI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Z/rv4W29Z6nXQ+f9I9ypQcGlPwIE2U6pgbL5YOO/w4WdDnEqHPupKtOfrnXQ5aBB+337ebbl0XQiluPhJXZ6ZiG9hoCgEkmIwjoUv6zEcJPV07/OziRPMcatI1vwr3NcPWMzLiwddpmC9BKZHlM27E0dE8HioIs818vxqcJzE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=DbINAsOv; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5A5NjUVl734367
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 5 Nov 2025 15:45:30 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5A5NjUVl734367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762386333;
	bh=+sD3cR5EkgBX2XuKar4xekMLsFZG/qt5a6SebmtGMpc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=DbINAsOvhOGP6HgboxGgAgLEG+4cnl/UbUJFuB9DGpNzfxyy3CPvslxF73iUcSANe
	 z4w/Gioihh+o4AeoGIEFxm65XPCAfUibJjiDff5HbGULgZ1pligWvzDO9+fL0d0Nif
	 uxZb4TLnEQ1az8uOF5yHyRt0TpF90rAmCxmAR5N9KvqRqHK0D31MOokfUxQR2zh5yO
	 EN31oMI/fFAvrCUEUBZZLaWhRr9+LFfE6iiTOk2GO5Dqddszk6mwX7+FOIgNoeCcCc
	 TgA25cVXNBovZJ1TGzvRQoqkY3allhEZA1rGt/DQBiH+CJmUtqHPPaJZOUK2dMIgSb
	 QCnT8vGpXHzvA==
Date: Wed, 05 Nov 2025 15:45:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <david.laight.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
CC: u.kleine-koenig@baylibre.com, Nicolas Pitre <npitre@baylibre.com>,
        Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Biju Das <biju.das.jz@bp.renesas.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Li RongQing <lirongqing@baidu.com>,
        Khazhismel Kumykov <khazhy@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_next_7/9=5D_lib=3A_mul=5Fu64=5Fu64?=
 =?US-ASCII?Q?=5Fdiv=5Fu64=28=29_optimise_multiply_on_32bit_x86?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20251105201035.64043-8-david.laight.linux@gmail.com>
References: <20251105201035.64043-1-david.laight.linux@gmail.com> <20251105201035.64043-8-david.laight.linux@gmail.com>
Message-ID: <DE009601-0605-4A6E-99B3-E8A789F85BF6@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 5, 2025 12:10:33 PM PST, David Laight <david=2Elaight=2Elinux@g=
mail=2Ecom> wrote:
>gcc generates horrid code for both ((u64)u32_a * u32_b) and (u64_a + u32_=
b)=2E
>As well as the extra instructions it can generate a lot of spills to stac=
k
>(including spills of constant zeros and even multiplies by constant zero)=
=2E
>
>mul_u32_u32() already exists to optimise the multiply=2E
>Add a similar add_u64_32() for the addition=2E
>Disable both for clang - it generates better code without them=2E
>
>Move the 64x64 =3D> 128 multiply into a static inline helper function
>for code clarity=2E
>No need for the a/b_hi/lo variables, the implicit casts on the function
>calls do the work for us=2E
>Should have minimal effect on the generated code=2E
>
>Use mul_u32_u32() and add_u64_u32() in the 64x64 =3D> 128 multiply
>in mul_u64_add_u64_div_u64()=2E
>
>Signed-off-by: David Laight <david=2Elaight=2Elinux@gmail=2Ecom>
>Reviewed-by: Nicolas Pitre <npitre@baylibre=2Ecom>
>---
>
>Changes for v4:
>- merge in patch 8=2E
>- Add comments about gcc being 'broken' for mixed 32/64 bit maths=2E
>  clang doesn't have the same issues=2E
>- Use a #define for define mul_add() to avoid 'defined but not used'
>  errors=2E
>
> arch/x86/include/asm/div64=2Eh | 19 +++++++++++++++++
> include/linux/math64=2Eh       | 11 ++++++++++
> lib/math/div64=2Ec             | 40 +++++++++++++++++++++++-------------
> 3 files changed, 56 insertions(+), 14 deletions(-)
>
>diff --git a/arch/x86/include/asm/div64=2Eh b/arch/x86/include/asm/div64=
=2Eh
>index 6d8a3de3f43a=2E=2E30fd06ede751 100644
>--- a/arch/x86/include/asm/div64=2Eh
>+++ b/arch/x86/include/asm/div64=2Eh
>@@ -60,6 +60,12 @@ static inline u64 div_u64_rem(u64 dividend, u32 diviso=
r, u32 *remainder)
> }
> #define div_u64_rem	div_u64_rem
>=20
>+/*
>+ * gcc tends to zero extend 32bit values and do full 64bit maths=2E
>+ * Define asm functions that avoid this=2E
>+ * (clang generates better code for the C versions=2E)
>+ */
>+#ifndef __clang__
> static inline u64 mul_u32_u32(u32 a, u32 b)
> {
> 	u32 high, low;
>@@ -71,6 +77,19 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
> }
> #define mul_u32_u32 mul_u32_u32
>=20
>+static inline u64 add_u64_u32(u64 a, u32 b)
>+{
>+	u32 high =3D a >> 32, low =3D a;
>+
>+	asm ("addl %[b], %[low]; adcl $0, %[high]"
>+		: [low] "+r" (low), [high] "+r" (high)
>+		: [b] "rm" (b) );
>+
>+	return low | (u64)high << 32;
>+}
>+#define add_u64_u32 add_u64_u32
>+#endif
>+
> /*
>  * __div64_32() is never called on x86, so prevent the
>  * generic definition from getting built=2E
>diff --git a/include/linux/math64=2Eh b/include/linux/math64=2Eh
>index e889d850b7f1=2E=2Ecc305206d89f 100644
>--- a/include/linux/math64=2Eh
>+++ b/include/linux/math64=2Eh
>@@ -158,6 +158,17 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
> }
> #endif
>=20
>+#ifndef add_u64_u32
>+/*
>+ * Many a GCC version also messes this up=2E
>+ * Zero extending b and then spilling everything to stack=2E
>+ */
>+static inline u64 add_u64_u32(u64 a, u32 b)
>+{
>+	return a + b;
>+}
>+#endif
>+
> #if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)
>=20
> #ifndef mul_u64_u32_shr
>diff --git a/lib/math/div64=2Ec b/lib/math/div64=2Ec
>index 18a9ba26c418=2E=2Ebb57a48ce36a 100644
>--- a/lib/math/div64=2Ec
>+++ b/lib/math/div64=2Ec
>@@ -186,33 +186,45 @@ EXPORT_SYMBOL(iter_div_u64_rem);
> #endif
>=20
> #if !defined(mul_u64_add_u64_div_u64) || defined(test_mul_u64_add_u64_di=
v_u64)
>-u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
>-{
>+
>+#define mul_add(a, b, c) add_u64_u32(mul_u32_u32(a, b), c)
>+
> #if defined(__SIZEOF_INT128__) && !defined(test_mul_u64_add_u64_div_u64)
>=20
>+static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
>+{
> 	/* native 64x64=3D128 bits multiplication */
> 	u128 prod =3D (u128)a * b + c;
>-	u64 n_lo =3D prod, n_hi =3D prod >> 64;
>+
>+	*p_lo =3D prod;
>+	return prod >> 64;
>+}
>=20
> #else
>=20
>-	/* perform a 64x64=3D128 bits multiplication manually */
>-	u32 a_lo =3D a, a_hi =3D a >> 32, b_lo =3D b, b_hi =3D b >> 32;
>+static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
>+{
>+	/* perform a 64x64=3D128 bits multiplication in 32bit chunks */
> 	u64 x, y, z;
>=20
> 	/* Since (x-1)(x-1) + 2(x-1) =3D=3D x=2Ex - 1 two u32 can be added to a=
 u64 */
>-	x =3D (u64)a_lo * b_lo + (u32)c;
>-	y =3D (u64)a_lo * b_hi + (u32)(c >> 32);
>-	y +=3D (u32)(x >> 32);
>-	z =3D (u64)a_hi * b_hi + (u32)(y >> 32);
>-	y =3D (u64)a_hi * b_lo + (u32)y;
>-	z +=3D (u32)(y >> 32);
>-	x =3D (y << 32) + (u32)x;
>-
>-	u64 n_lo =3D x, n_hi =3D z;
>+	x =3D mul_add(a, b, c);
>+	y =3D mul_add(a, b >> 32, c >> 32);
>+	y =3D add_u64_u32(y, x >> 32);
>+	z =3D mul_add(a >> 32, b >> 32, y >> 32);
>+	y =3D mul_add(a >> 32, b, y);
>+	*p_lo =3D (y << 32) + (u32)x;
>+	return add_u64_u32(z, y >> 32);
>+}
>=20
> #endif
>=20
>+u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
>+{
>+	u64 n_lo, n_hi;
>+
>+	n_hi =3D mul_u64_u64_add_u64(&n_lo, a, b, c);
>+
> 	if (!n_hi)
> 		return div64_u64(n_lo, d);
>=20

By the way have you filed gcc bug reports for this?

