Return-Path: <linux-kernel+bounces-889010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC58AC3C85B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF29A4F8BFD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FB534D4E1;
	Thu,  6 Nov 2025 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ed/MdcYF"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DAD34C804
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446598; cv=none; b=SQ8km+xfEAkzwgrtK/CNBvZcryNFv2wBlgMOl5NBLpoKz3wN6xLjD9o/l9PTy0ALH9qsa/iWSopmfKgEk+og03ISuzD1dnbjmN51ZIXSMI2BQdGpBi0KlxXK6YQzDMiF5L+TY6L9yuI3zl6GU9ze7X83hACwReNpylzMb3m8mmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446598; c=relaxed/simple;
	bh=jEkS0wS9JdICTaCzYvZx0OjcAUCfKSnRc9lNZ08RGwQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BMAGTWY+K7mS9/l36ePtpvtUF/zOZG1Ohr8f72JgkuC8XWVlL7FMBlFBRcoOL988kdQRHCo5crLy6CtotJU9EiXotZASe7FRiCWY5VCWAYRHFTiaWihKWFF9QW6nOm3+lZIk92J549vJfrKO2eCG1KjxxR3PHZNIhpPiGnnaHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ed/MdcYF; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34182b1c64bso800049a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762446596; x=1763051396; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EMufvlKZanMTIZvbWWJIkNimyApBJZflYRWdIy87U/A=;
        b=Ed/MdcYFf0bE13i+lCUqEh61uYXZIRFsVri+LZVomCRwmAuWXJVvLQ6mrDubJbKC/U
         vgzdb5uvdJai6GSmlEbySoX2SUCrdlDoz2F9sx1SWdbzdQb1CUxPXT/gtK8D1XUm+uXo
         j0rAiZJ0MNULiHXmz1XEGw05ynjQVlhBxUGfxDUKihjbB22zhlJodUfyutsQ2QKzHe/B
         hA6rKMfalhvvFRHacfP1Ml7PV6yUAAlVMMDPtTvKJ+rNXJHvAsUQu7bL0GCDGXaUQfwp
         vXAO6e7LM+ffXLxPJcsgLhhaDz+7HRmkQkGY8eqQcBvoTaaUIefuchT0dpju/c1ZhgCM
         x+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446596; x=1763051396;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMufvlKZanMTIZvbWWJIkNimyApBJZflYRWdIy87U/A=;
        b=C05JQmh1cm1wkstozMMmjwzihpbH3EuxcmSGcpxTH+OfSUz82jAUSr0Gc2x1S95uPp
         19veoSH5r2qhOV84HU3eb/XDjBwyhJt/TBJpifcpKIIvceHmeaOPB0PcwIfR5daWWirq
         v1Oi2kgXXydHacNtU1LsJ8WxZSwWVoSSylqWbph2Nw2NhgUAyXQfMaj+CZdVSmaraUhU
         ySr7gTnG8WE0znWk5V8ewDywM1HvUpHYQKINPhY6hUlLxMb1HK+5dFI+/lzf9OgUe/dG
         Cb4pc2lSYtc66WbJvozPWv+MVuGzCGaYdMhMYUk04nn4np82VjZ1l4/oOWaumND0ydj5
         7BFw==
X-Gm-Message-State: AOJu0Yxrl8J9EvqLfRUp/Ja2WG1BpZ497xIdZYJ4Y93WArzWH+qWZjvY
	E1FsxXt7gJePSFRZZNq6495lpmKG6UXhNyrptS4/aFa3IH4FIJRuOcuJ
X-Gm-Gg: ASbGnctjbpeA/ikW/tQsC53eaNjzlll8nyMy0ezdUPaaLbV6+c93Q/k98JgyslcQ6G8
	Rwgt8BQLt9nRbYLLXKW5k8T9QGgbjmQBXrCnPuTLpWVl/eP8f+9g39Ec4EIi+RLBpdV9IHXnAfm
	3g4PtOPAsulrXSXE7gj1S80Ic+3bqi/FmEGQD59oSlOFFrzHgYXBVFAvWdo0/4ALxIW8fhp2Hw5
	s9nvFbcfHXzIpoWk4LsvnwYaCKNoyHM5IWPN9Q2AhMtdrG7VU7xC5IucS+5rDMF4hhGN3rgLDrE
	MOoWKo6Yllf8evLa6cZ3CJ7JgHaO7Q445fcVzDIs+0NOcF6ELCfrWpG2hXup9c21W9rlLx9nBp2
	dWXfaE3RglZrCxZYdud3QN24d5lmxMPU4NYc/Gbk4QwAsjqCGiZJqAttbxPU4Zsz2foIwqDOjLF
	XL5PmcN51IMQeuD7OMfybRO7CMqvkzAqJ0iHPR+Ungo8hOw+OZDLCzfv/NdzituRuE5CnClw==
X-Google-Smtp-Source: AGHT+IG+/YJFa+iN7B35iE0D3sOPdQh3iyKV5sn/uuCGaHI5yvaeFznbvQBUEeV5BmhRnHB0H5TLTA==
X-Received: by 2002:a17:90b:3607:b0:341:abdc:8ea2 with SMTP id 98e67ed59e1d1-341abdc8fdemr6666428a91.37.1762446596409;
        Thu, 06 Nov 2025 08:29:56 -0800 (PST)
Received: from ?IPv6:2401:4900:88f4:f6c4:12e8:f050:511d:31f3? ([2401:4900:88f4:f6c4:12e8:f050:511d:31f3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68ad143sm6652545a91.3.2025.11.06.08.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:29:55 -0800 (PST)
Message-ID: <67e28fadf4c20433c964d13d96dafe3514457656.camel@gmail.com>
Subject: Re: [PATCH RESEND v3] checkpatch: add uninitialized pointer with
 __free attribute check
From: ally heev <allyheev@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, Geert Uytterhoeven	
 <geert@linux-m68k.org>, linux-doc@vger.kernel.org,
 workflows@vger.kernel.org,  Joe Perches <joe@perches.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Andy
 Whitcroft <apw@canonical.com>, Jonathan Corbet <corbet@lwn.net>, Dan
 Carpenter	 <dan.carpenter@linaro.org>, Dan Williams
 <dan.j.williams@intel.com>, David Hunter <david.hunter.linux@gmail.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn	
 <lukas.bulwahn@gmail.com>, Nishanth Menon <nm@ti.com>, Shuah Khan	
 <skhan@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar	
 <vireshk@kernel.org>
Date: Thu, 06 Nov 2025 21:59:33 +0530
In-Reply-To: <221c2b9b-4809-48d8-af7d-f290d1c2a7fa@web.de>
References: 
	<CAMuHMdV+12MoAGNHC9kf==Bt0cLuJ39Fs+W61DN67sE_p-u=og@mail.gmail.com>
	 <221c2b9b-4809-48d8-af7d-f290d1c2a7fa@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 10:18 +0100, Markus Elfring wrote:
[..]
> * Do corresponding source code analysis requirements indicate a need
>   to perform data processing with other programming interfaces than regul=
ar expressions?
>=20

not sure about other source code analysis tools, but checkpatch
predominantly uses regexes

> * How do you think about to mention the possibility once more that scopes
>   can be reduced for affected local variables?
>   https://elixir.bootlin.com/linux/v6.18-rc4/source/include/linux/cleanup=
.h#L142-L146
>  ...

The docstring talks about interdependency issues caused by assigning to
`NULL` which are very rare

Regards,
Ally



