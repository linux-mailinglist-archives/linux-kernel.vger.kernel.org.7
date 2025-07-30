Return-Path: <linux-kernel+bounces-750184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E151B1582E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA179188397F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4627D1DE8AF;
	Wed, 30 Jul 2025 04:54:05 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387762AD04
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753851244; cv=none; b=Jgs/7jC4/dIonznwU7yfmF0eDMhlC8AnhYvjjL+C50QJqx2zqY8+RIfR7+CBYcNZp6SFgcxIHcsf9cbXRd3LA7wHlgGGWXRYkCWovPWr1/VtjvL3PtTP2RxxYhqe3AnrniCUZuSbwJRw468UOlRVyiMxQr6hfEkIl+RQzwVa0Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753851244; c=relaxed/simple;
	bh=plXHjP9aSSktLqFvN/AdZ6x+vIb0yKnHhsHjbDn9RL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HkFUQUluYBzY0NpCecUx19qhZX8NSfwaTsqjbrX8fQqhs7wjR6obMX3Q7iE3UJgwc6VmgbCWH/edN2DmaYR0s9qHP3aAgeBGhKI7xGONuTZasqfcHfH2/UzfP6yBAM7jowqCkawTgxdFzZgdU5hJxS97LGxrEaPVmikhlTfrOXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Oleg Nesterov <oleg@redhat.com>, David Laight
	<david.laight.linux@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, Steven Rostedt
	<rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [????] [PATCH v2] x86/math64: handle #DE in mul_u64_u64_div_u64()
Thread-Topic: [????] [PATCH v2] x86/math64: handle #DE in
 mul_u64_u64_div_u64()
Thread-Index: AQHb/vMPGLygQ+EChUi8iLsY24paWLRJ9SLA
Date: Wed, 30 Jul 2025 02:30:04 +0000
Message-ID: <013ffed7ba224294a69befe91cb3ceec@baidu.com>
References: <20250721130422.GA31640@redhat.com>
 <20250727123458.GA16775@redhat.com>
In-Reply-To: <20250727123458.GA16775@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.50.45
X-FE-Policy-ID: 52:10:53:SYSTEM



> Change mul_u64_u64_div_u64() to return ULONG_MAX if the result doesn't fi=
t
> into u64 or div =3D=3D 0. The former matches the generic implementation i=
n
> lib/math/div64.c, the latter doesn't. Perhaps we will add a WARN() into t=
he
> fixup_exception() paths later.
>=20
> No need to use _ASM_EXTABLE_TYPE_REG(), we know that the target register
> is pt_regs->ax with offset =3D=3D 0, so a simple EX_DATA_REG(0) should wo=
rk just
> fine.
>=20
> Reported-by: Li RongQing <lirongqing@baidu.com>
> Link:
> https://lore.kernel.org/all/78a0d7bb20504c0884d474868eccd858@baidu.com/
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---

Tested-by: Li RongQing <lirongqing@baidu.com>

Thanks for fixing

Br


