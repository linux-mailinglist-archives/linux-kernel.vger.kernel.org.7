Return-Path: <linux-kernel+bounces-820771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332D8B7F38B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52205422FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFEE316182;
	Wed, 17 Sep 2025 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9yKNAho"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A62FBE10
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114668; cv=none; b=Qcm94u0cpaUiQjOHD3Lm0z+m7HeCVXvNnmOXTGUeO5fM9FyroKSxH01MoUKwSsY46xlhEcPs5CZZN4F1twJyLzi4S98/Q2LRyDIKKwlHKK7QLg3UnnwGwf/qkxk5zDED8yeJqAZh/A8vfZ6JUBNAVOcuOGJqwHfZR2GBpYYqkCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114668; c=relaxed/simple;
	bh=gWZGfNC7pX5QddCjdXKm7e7z3+Ak4TjPyOiVnFbUjyQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=my4v5/OsyaU4A5ZhwUotWL6BY6ohS1DQeLvoMlfQoovsoRBE62G5vIS3be76SBuVxGSci/1GC0TyaN1fUtWDpnsde/I66K1mir31spINngJL2TDDOedOkMyzL7fBLtILYPn9I10C/YbWXGue5OZOVMlHc0owO4zMJVpfRVMt/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9yKNAho; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so45666995e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758114664; x=1758719464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u5armhQOM8jH/c09cO6Ee7h/dPMKBYiYTW1VQzfn19g=;
        b=F9yKNAhoBpOU7bScxOyh2nz4P+R5RynBv4AIbS2gFTSftdyCsTsfNob3h4C7CS/kBQ
         Ox7MflZmvprZaMSh9pN/t+9TnO6LrBys2CrbKw02GE3tnetdDfvN3fnZZRppfUkuBI8s
         7yBCDA0K5d8HApJ0pJRCxaK07kAPpher3KWAGUDRyeq1vJ8kC9UP49WAZRSkiIxGRj88
         WQr3A3I7Y+NiLo1k6cPmedvufK0rk5HkPha8YjU1K9cm9WXdzhg/h2NyM2JdtAvFdtF8
         5rR68MXdA+8uKNb8+eOHKEQ71fN35+CokyF56n60YkzoJhMnKUCm632NYbdDqihhI3Uo
         pLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114664; x=1758719464;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5armhQOM8jH/c09cO6Ee7h/dPMKBYiYTW1VQzfn19g=;
        b=dpwUHf65lzPkk73QZOkRJ9SwKJMf0XkkpEgJ874/J6xTDwCPvdohq++QzhAZ2GzyeU
         TASq+iC5B8Mg9PGsV2fX2gQA5gfi2QkL8FTYVDZG3sHar8iUDLeJaOzmfhAvhFFqYR5n
         ezwHF6VQDK7vETVD7s9Dk5AZOlXZ1gLeDx85RerCM2FURI2JMMicWPyD/LZ5qO1QcA0i
         aYOT/z0j/z6D2GrtDGBvhti5FTrJCYs6AxZPoF8GYTE909ra3jqrVoWqtVbd0ZZllHzB
         7UHCiDUF68nNFRIbmEL0D/UaAD2szuK+G98owbJAyHY5M8PL2PTc4lRwUdNJHs5RXSJK
         nOOA==
X-Gm-Message-State: AOJu0YyxHYWVqRyzyXoo9g7+h2+MSVyjwXsMNGg0hcCgE0isecMdDY+U
	hxKbF9WBNH8uCLM4KIKtNoMpZ7IsM4zGLNZ/O9mAwIb/57mHVJzV50BbpjmGkkwJ
X-Gm-Gg: ASbGncvAy9AHsKow3z/y0GjbvA7PAaT+QsSVVgj2KTbeB3oRM3xf930SeDjj9LCm4kP
	w6z64zzfsKFxP92It+E3ejnA8+BDBamWmlE7nKuKbPjpuTujC5IwGrDGDRmLscLkELoHP4qcr7J
	e6ohmbWs9n1RLlGVShy5NV1u7jwAaM9kCcjeuGc0zFmkNv5Nr6IRJAoz3eDjlxWrjBMSKDwu/Fk
	AyG5n2qe6rI/9ec0ceZD7Hl7MTI1lzcs0bVRzrDrj8O0dZ3+aYk4qjYSIpPOKV0piyDlEd9VKzw
	IdqMZaQUstd322CC0boGRnvnJXCGlTPGewumGhQ121g3UvshXlJbfL/e+CsJmxopQ/UZJNjAA28
	Jjq7dNUfj6X8bkepjAd+9CTt2cpxBCS+RXWc=
X-Google-Smtp-Source: AGHT+IE2Oe9hCBiEfQpkUIK4eSUt8A/CvmlobRbAPyQJj+DI06B43ga/vzp7iPXdW0MZfGPBFYElew==
X-Received: by 2002:a05:600c:4692:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-46206f04fa0mr18436655e9.32.1758114663850;
        Wed, 17 Sep 2025 06:11:03 -0700 (PDT)
Received: from [192.168.100.3] ([105.163.156.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ec486e6193sm7647218f8f.25.2025.09.17.06.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:11:02 -0700 (PDT)
Message-ID: <64c3889e132a96853a361791c44fcea1a0aaac8c.camel@gmail.com>
Subject: [RFC] coccinelle script: scope-based resource cleanup
From: Erick Karanja <karanja99erick@gmail.com>
To: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Julia Lawall <julia.lawall@inria.fr>
Date: Wed, 17 Sep 2025 16:10:49 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,
With the guidance of my mentor Julia Lawall, I have developed a
Coccinelle script that assists with scope-based cleanup in the Linux
kernel. The script aims to convert lock/unlock pattern to use guard
cleanup macro.
Link: https://github.com/Erickkaranja/scope_based_cleanup.git

When developing the rule some key consideration was taken to ensure the
correctness of the transformation. This involved enforcing some strict
rules and not transforming some patterns at all.
For instance though, some transformation were correct to use guard,
CLANG raises some warning and thus required a strict use of
scoped_guard in this scenario. Refer to this commit

https://gbmc.googlesource.com/linux/+/97f4b999e0c894d3e48e318aa113013203181=
5b3
=20
In cases where no transformation is applied, it is because performing
one automatically could risk introducing errors or unintentionally
changing the function=E2=80=99s intended behavior, so such instances have b=
een
deliberately left unchanged.
Examples
case 1:
In cases of inversed lock  pattern i.e where unlock happens before the
lock.

case 2:
Scoped_guard implementation uses a for loop, transforming code sections
that braces a break statement within the scoped_guard could lead to
unintended changed use of the break statement.

case 3:
In scenarios of conditional jump, if there is some function call before
the unlock, there is the danger of moving the function call to the
critical section and if the function sleeps could lead to deadlocks.

Below, Is a link to blog posts that explains in depth above cases and
provide examples of functions which are not suitable for transformation
using our script.
https://erickkaranja1.wordpress.com/2025/08/07/from-lock-unlock-to-scoped_g=
uard-conditional-jump/
https://erickkaranja1.wordpress.com/2025/07/02/from-mutex_lock-mutex_unlock=
-to-scoped_guard-part-2/
https://erickkaranja1.wordpress.com/2025/06/19/from-mutex_lock-mutex_unlock=
-to-scoped_guard/
Regards,
Erick

