Return-Path: <linux-kernel+bounces-900068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB2DC5983A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 225603470FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4573112B6;
	Thu, 13 Nov 2025 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuLPZgLC"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C730DD2E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059102; cv=none; b=XnM3NaiUmvJtLMgd95WZWy4gOCEa69eZCodNwF4XTI5KwLvt+mEplvsBjYVQrPI9/c8ftmBPtIhSDvoEiQssxVLadrSO8iKPZyM6RkbamrM8X/vkdqiHfaztPOzpiBiCYAzLiNhXEBITfN2CnVcgSK7/V5pPkxKMDoBuAMJGsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059102; c=relaxed/simple;
	bh=GRip0L6z1TjJ1nD2v9eWpBy+v6fZlcUxO43j7XE8w5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLjyhZKq60j1FnVSvwDJcSafL+j8phjw8IyH0EcXEkHl68hON588Se72VvthE4LQvO0RbOI8EGcM9kWvyeRMnaN1bwJ6Kx1hPbpdWC87gTQC69QMPXZvvuNrSspMExPL9LOPjyEkUx0ONpRn2c6GoqmTarQ/xA4BC2wkmfgGSiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuLPZgLC; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37a3d86b773so12460891fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763059098; x=1763663898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuaLltO93tDllZeZpDO8ivNIqES1wnPSOVBcYNJ4uiI=;
        b=NuLPZgLCu7fQ/3e7XgTia862z3OL0R0hUL4tHqHgkPfoKU4L4TKcuRMefwPxJi1ftQ
         oWQe85mwhdmmndwKy77EniT/CLItbAeI3s0HTzrU4SE4OK6lL/7MDL+YLtvMAlUaFQKq
         ZW1xj8ER0Qyjm8451GJ03iOP8PItasfgjWy8986rgwiwK+vsbytr60t/Pw9Z7z9fhikf
         CNzUfpIY2NustU64p1roqXvsWmGFt+r0EhbqTZs1EOW/fb7nzyL9kSjGwlkc+5dW25DE
         iNwRfkyc3YpWCn/tAhQIQwdT6TSFA5h6K3nwxu/qvkSxrZwks7qDHGocaOs0EVTv/vQj
         h1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763059098; x=1763663898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KuaLltO93tDllZeZpDO8ivNIqES1wnPSOVBcYNJ4uiI=;
        b=v4uu/YQdrCMLKLGzI3Qqsvh9qF3XLwp/6zsMIZM41lvL0XGXDiA0pkSKtZdkFHOrCH
         NJIw9jUco3+QyfdrpXGhVtEOMPoPUEE6gy0I3PI5AzIyvrv4zwt20G7gS/kA8usEeDPf
         vK3IGMaQCfudy3Kn1Aanu+fZDhsWV3YU93lCi7bl5STIYBARuSbMeIC+u0W4cvhe0Cau
         eohfTcauL1FdQlIKtyhKsiui9z1SLX47e5947z/oAsX3da6qSIG8ieQewvzEg1h6oj39
         LzH+jWKKuiIhbRZ/gcikj1NI3LgRJandomO+Ei5BZUwLxtghw0zg3+nXj52jm5VxaXRm
         bIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkZd0XDMnbq/C17tPHYQRqysfGI0CNbNU6Mhd/HkUxZUbOMfv14wWwY8lNlP/MVqrSaT92XN2onJo6mLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7aY4Z7HsGX8BhFRhAYIO8yqoSN4vJXcXThn9PKD3oBCbmpQ9T
	bQoxJZxx8gjRB7Mq+gt9SJuPDGadULN+BNIBtLTYoEFJETeJORdQywEFNTBDm+PA+kLoEFxZWJX
	hTsGqpz9K2VLjee/yjj17W4ZMm5pdubwd7AI=
X-Gm-Gg: ASbGncuM2BTAx6lRRJmClMLjJlE9Q4E6sF/Yq98BpdwPzhUXajEIZkmFaNStIMjSNkE
	ZajLYAa7oPoDMtbp7oR0dUam5H6swbOSN4KBSgtoowz2Ppzya/E89jtYEa7vnAMbUS1E/OgDFLO
	6PinohaGGChvvOLBzId0xf/POilfoo4gzWjap2JDk/EU4Q5h44aNxRu6LczxoINYpTIkjlMTWbz
	q1x/PGLHdoleYVMwORFIHUUzf8Z0Zp38hxK66pAoiimilkGUtPBrRhQ1qRgGE52Ha5vUqYKFuY=
X-Google-Smtp-Source: AGHT+IFTNaY4mZM1ix3QYFEc82EzkpvKcUBcyp813LVZ4p7kn0l1FqFqSSvz0QMX9+tLUJN4chgtI95mLiddsP3Pj0c=
X-Received: by 2002:a2e:b952:0:b0:37b:aaf7:f007 with SMTP id
 38308e7fff4ca-37baaf7f224mr1618891fa.31.1763059098207; Thu, 13 Nov 2025
 10:38:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112202258.1310754-1-hpa@zytor.com> <20251112202258.1310754-3-hpa@zytor.com>
In-Reply-To: <20251112202258.1310754-3-hpa@zytor.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 13 Nov 2025 13:38:05 -0500
X-Gm-Features: AWmQ_bl8F5Gv6WqKGpN4l0omqbFGWN4-1qCrBCfwhQmjbk6-525Ibg67llMH-nQ
Message-ID: <CAMzpN2iwrzKzhif7WXsoQi=4OdBENZMV14Hm2a5ePukywNgh1w@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] x86/entry/vdso: refactor the vdso build
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Xin Li <xin@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	James Morse <james.morse@arm.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, Nam Cao <namcao@linutronix.de>, 
	Oleg Nesterov <oleg@redhat.com>, Perry Yuan <perry.yuan@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Thomas Huth <thuth@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-sgx@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 3:23=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> - Separate out the vdso sources into common, vdso32, and vdso64
>   directories.
> - Move the vdso2c tool to arch/x86/tools.
> - Build the 32- and 64-bit vdsos in their respective subdirectories;
>   this greatly simplifies the build flags handling.
> - Unify the mangling of Makefile flags between the 32- and 64-bit
>   vdso code as much as possible; all common rules are put in
>   arch/x86/entry/vdso/common/Makefile.include. The remaining
>   is very simple for 32 bits; the 64-bit one is only slightly more
>   complicated because it contains the x32 generation rule.
> - Define __DISABLE_EXPORTS when building the vdso. This need seems to
>   have been masked by different ordering compile flags before.
> - Change CONFIG_X86_64 to BUILD_VDSO32_64 in vdso32/system_call.S,
>   to make it compatible with including fake_32bit_build.h.
> - The -fcf-protection=3D option was "leaking" from the kernel build,
>   for reasons that was not clear to me. Futhermore, several
>   distributions ship with it set to a default value other than
>   "-fcf-protection=3Dnone". Make it match the configuration options
>   for *user space*.
>
> Note that this patch may seem large, but the vast majority of it is
> simply code movement.

Some of these changes (like moving vdso2c) can be split out into
smaller patches.

