Return-Path: <linux-kernel+bounces-887542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84CFC387B4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260E73AFE4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F5C165F16;
	Thu,  6 Nov 2025 00:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cYdNqKVc"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877111891AB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388820; cv=none; b=qai08LW1R7/rTIbyFJEGh9VubLBhRDC+54KzOivFt9Y0zc6SyEeGmKoPxY7nRHcLEg1TBWWgK1ErJziMecA5qJz/YrcCirTazZ91L8aLj1evLM+fxzBwiZtxS9oPg4c7EogfJfCTu5UjSX1DUpSEJi5SCWknWIkN9j29ZC1ZKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388820; c=relaxed/simple;
	bh=2RccvUb7XJUT/2d3d/TOtrM4akK/I7QprNe4Lii3AN8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BDabSUdKY1lJxLZdpuRyOZfteR71mXQrSkZCPwRvKUMcGHdCF1U+UE6sTBu93D4dp6undSn0dfIQe/05FKWXNkLuzvHeWa4QAYYNU6l6aQwjooSeByVE8FKn2+XKDXUC02dG6viM0vE9ZkoDAcyiqW2F08NXG23W2+kcUG0tfUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=cYdNqKVc; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5A60Q7oc751608
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 5 Nov 2025 16:26:07 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5A60Q7oc751608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762388769;
	bh=3onwbObq7kt4uvm9quoDuPPWpqlzWSstC/IyMgBI4eY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cYdNqKVcs5cbrJ/3nzCtgAmw1T8jQYL4PIQgPi58DD+/ZvyYmcWfeONuP3xBCBjMP
	 6qaVV4WPKHecNzy/iIk5Tz9Z5TQ+lXNtz3srJQevjjKF0J8DF3OBTQDjlTe71n656t
	 WtFTk9iljWcwz4kF+f2pig/flLafaHrvnqowz4TeYkD9z5zs5eIzpOtHtyt2FLiOcX
	 +soqvesrh4RdEwETZ+TB0imvb/+Y54A/tCLQ3zwH+lzurj6vGfbK+GudyQYhySFw6d
	 gVINW3Em0VDzqMBFSkUL4PYsfzfMbzi3FBqPu7xgUFvaOUlQ5xr6Yw8R/SYm9Y9GDg
	 bSeQC3ofFK4Ng==
Date: Wed, 05 Nov 2025 16:26:05 -0800
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_next_4/9=5D_lib=3A_Add_mul=5Fu64=5Fadd=5Fu?=
 =?US-ASCII?Q?64=5Fdiv=5Fu64=28=29_and_mul=5Fu6?=
 =?US-ASCII?Q?4=5Fu64=5Fdiv=5Fu64=5Froundup=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20251105201035.64043-5-david.laight.linux@gmail.com>
References: <20251105201035.64043-1-david.laight.linux@gmail.com> <20251105201035.64043-5-david.laight.linux@gmail.com>
Message-ID: <128901BE-2651-4335-935F-34A5B50D811E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 5, 2025 12:10:30 PM PST, David Laight <david=2Elaight=2Elinux@g=
mail=2Ecom> wrote:
>The existing mul_u64_u64_div_u64() rounds down, a 'rounding up'
>variant needs 'divisor - 1' adding in between the multiply and
>divide so cannot easily be done by a caller=2E
>
>Add mul_u64_add_u64_div_u64(a, b, c, d) that calculates (a * b + c)/d
>and implement the 'round down' and 'round up' using it=2E
>
>Update the x86-64 asm to optimise for 'c' being a constant zero=2E
>
>Add kerndoc definitions for all three functions=2E
>
>Signed-off-by: David Laight <david=2Elaight=2Elinux@gmail=2Ecom>
>Reviewed-by: Nicolas Pitre <npitre@baylibre=2Ecom>
>---
>
>Changes for v2 (formally patch 1/3):
>- Reinstate the early call to div64_u64() on 32bit when 'c' is zero=2E
>  Although I'm not convinced the path is common enough to be worth
>  the two ilog2() calls=2E
>=20
>Changes for v3 (formally patch 3/4):
>- The early call to div64_u64() has been removed by patch 3=2E
>  Pretty much guaranteed to be a pessimisation=2E
>
>Changes for v4:=20
>- For x86-64 split the multiply, add and divide into three asm blocks=2E
>  (gcc makes a pigs breakfast of (u128)a * b + c)
>- Change the kerndoc since divide by zero will (probably) fault=2E
>
>Changes for v5:
>- Fix test that excludes the add/adc asm block for constant zero 'add'=2E
>
> arch/x86/include/asm/div64=2Eh | 20 +++++++++------
> include/linux/math64=2Eh       | 48 +++++++++++++++++++++++++++++++++++-
> lib/math/div64=2Ec             | 14 ++++++-----
> 3 files changed, 67 insertions(+), 15 deletions(-)
>
>diff --git a/arch/x86/include/asm/div64=2Eh b/arch/x86/include/asm/div64=
=2Eh
>index 9931e4c7d73f=2E=2E6d8a3de3f43a 100644
>--- a/arch/x86/include/asm/div64=2Eh
>+++ b/arch/x86/include/asm/div64=2Eh
>@@ -84,21 +84,25 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
>  * Will generate an #DE when the result doesn't fit u64, could fix with =
an
>  * __ex_table[] entry when it becomes an issue=2E
>  */
>-static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
>+static inline u64 mul_u64_add_u64_div_u64(u64 rax, u64 mul, u64 add, u64=
 div)
> {
>-	u64 q;
>+	u64 rdx;
>=20
>-	asm ("mulq %2; divq %3" : "=3Da" (q)
>-				: "a" (a), "rm" (mul), "rm" (div)
>-				: "rdx");
>+	asm ("mulq %[mul]" : "+a" (rax), "=3Dd" (rdx) : [mul] "rm" (mul));
>=20
>-	return q;
>+	if (!statically_true(!add))
>+		asm ("addq %[add], %[lo]; adcq $0, %[hi]" :
>+			[lo] "+r" (rax), [hi] "+r" (rdx) : [add] "irm" (add));
>+
>+	asm ("divq %[div]" : "+a" (rax), "+d" (rdx) : [div] "rm" (div));
>+
>+	return rax;
> }
>-#define mul_u64_u64_div_u64 mul_u64_u64_div_u64
>+#define mul_u64_add_u64_div_u64 mul_u64_add_u64_div_u64
>=20
> static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 div)
> {
>-	return mul_u64_u64_div_u64(a, mul, div);
>+	return mul_u64_add_u64_div_u64(a, mul, 0, div);
> }
> #define mul_u64_u32_div	mul_u64_u32_div
>=20
>diff --git a/include/linux/math64=2Eh b/include/linux/math64=2Eh
>index 6aaccc1626ab=2E=2Ee889d850b7f1 100644
>--- a/include/linux/math64=2Eh
>+++ b/include/linux/math64=2Eh
>@@ -282,7 +282,53 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u3=
2 divisor)
> }
> #endif /* mul_u64_u32_div */
>=20
>-u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
>+/**
>+ * mul_u64_add_u64_div_u64 - unsigned 64bit multiply, add, and divide
>+ * @a: first unsigned 64bit multiplicand
>+ * @b: second unsigned 64bit multiplicand
>+ * @c: unsigned 64bit addend
>+ * @d: unsigned 64bit divisor
>+ *
>+ * Multiply two 64bit values together to generate a 128bit product
>+ * add a third value and then divide by a fourth=2E
>+ * The Generic code divides by 0 if @d is zero and returns ~0 on overflo=
w=2E
>+ * Architecture specific code may trap on zero or overflow=2E
>+ *
>+ * Return: (@a * @b + @c) / @d
>+ */
>+u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d);
>+
>+/**
>+ * mul_u64_u64_div_u64 - unsigned 64bit multiply and divide
>+ * @a: first unsigned 64bit multiplicand
>+ * @b: second unsigned 64bit multiplicand
>+ * @d: unsigned 64bit divisor
>+ *
>+ * Multiply two 64bit values together to generate a 128bit product
>+ * and then divide by a third value=2E
>+ * The Generic code divides by 0 if @d is zero and returns ~0 on overflo=
w=2E
>+ * Architecture specific code may trap on zero or overflow=2E
>+ *
>+ * Return: @a * @b / @d
>+ */
>+#define mul_u64_u64_div_u64(a, b, d) mul_u64_add_u64_div_u64(a, b, 0, d)
>+
>+/**
>+ * mul_u64_u64_div_u64_roundup - unsigned 64bit multiply and divide roun=
ded up
>+ * @a: first unsigned 64bit multiplicand
>+ * @b: second unsigned 64bit multiplicand
>+ * @d: unsigned 64bit divisor
>+ *
>+ * Multiply two 64bit values together to generate a 128bit product
>+ * and then divide and round up=2E
>+ * The Generic code divides by 0 if @d is zero and returns ~0 on overflo=
w=2E
>+ * Architecture specific code may trap on zero or overflow=2E
>+ *
>+ * Return: (@a * @b + @d - 1) / @d
>+ */
>+#define mul_u64_u64_div_u64_roundup(a, b, d) \
>+	({ u64 _tmp =3D (d); mul_u64_add_u64_div_u64(a, b, _tmp - 1, _tmp); })
>+
>=20
> /**
>  * DIV64_U64_ROUND_UP - unsigned 64bit divide with 64bit divisor rounded=
 up
>diff --git a/lib/math/div64=2Ec b/lib/math/div64=2Ec
>index 4a4b1aa9e6e1=2E=2Ea88391b8ada0 100644
>--- a/lib/math/div64=2Ec
>+++ b/lib/math/div64=2Ec
>@@ -183,13 +183,13 @@ u32 iter_div_u64_rem(u64 dividend, u32 divisor, u64=
 *remainder)
> }
> EXPORT_SYMBOL(iter_div_u64_rem);
>=20
>-#ifndef mul_u64_u64_div_u64
>-u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
>+#ifndef mul_u64_add_u64_div_u64
>+u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
> {
> #if defined(__SIZEOF_INT128__)
>=20
> 	/* native 64x64=3D128 bits multiplication */
>-	u128 prod =3D (u128)a * b;
>+	u128 prod =3D (u128)a * b + c;
> 	u64 n_lo =3D prod, n_hi =3D prod >> 64;
>=20
> #else
>@@ -198,8 +198,10 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
> 	u32 a_lo =3D a, a_hi =3D a >> 32, b_lo =3D b, b_hi =3D b >> 32;
> 	u64 x, y, z;
>=20
>-	x =3D (u64)a_lo * b_lo;
>-	y =3D (u64)a_lo * b_hi + (u32)(x >> 32);
>+	/* Since (x-1)(x-1) + 2(x-1) =3D=3D x=2Ex - 1 two u32 can be added to a=
 u64 */
>+	x =3D (u64)a_lo * b_lo + (u32)c;
>+	y =3D (u64)a_lo * b_hi + (u32)(c >> 32);
>+	y +=3D (u32)(x >> 32);
> 	z =3D (u64)a_hi * b_hi + (u32)(y >> 32);
> 	y =3D (u64)a_hi * b_lo + (u32)y;
> 	z +=3D (u32)(y >> 32);
>@@ -265,5 +267,5 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
>=20
> 	return res;
> }
>-EXPORT_SYMBOL(mul_u64_u64_div_u64);
>+EXPORT_SYMBOL(mul_u64_add_u64_div_u64);
> #endif

For the roundup case, I'm somewhat curious how this compares with doing:

   cmp $1, %rdx
   sbb $-1, %rax

=2E=2E=2E after the division=2E At least it means not needing to compute d=
 - 1, saving an instruction as well as a register=2E Unfortunately using an=
 lea instruction to compute %rax (which otherwise would incorporate both) i=
sn't possible since it doesn't set the flags=2E

The cmp; sbb sequence should be no slower than add; adc =E2=80=93 I'm sayi=
ng "no slower" because %rdx is never written to, so I think this is provabl=
y a better sequence; whether or not it is measurable is another thing (but =
if we are tweaking this stuff=2E=2E=2E)

