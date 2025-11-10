Return-Path: <linux-kernel+bounces-893399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F362C47435
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F0EC4E6B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B344A312838;
	Mon, 10 Nov 2025 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO7KsOq6"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04491B6CE9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785618; cv=none; b=M7QUFnHOCfYuoNO17BdJuwm8Jhc47lu8hOk55II5H9NIVjDwppaINL5vhCBZTVQ3tYA8eviwMtvbhcXikDE+Rl+dxxfXTrAQqn1AzLGKgDGhPAPjaT9NUmASS7Hon/6WDOXxtYwhfoDd0A/e+1v0ZmdnyIysFbjihTbe0eLCIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785618; c=relaxed/simple;
	bh=N7+b0a5/X1E9lNvZ+Urqf0BEC1dp6Bsa7Gn5/uzSjgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNivdzbOvBVSrvK8vmHwdpYRv9TmXolS/5geyGr246o1+8iWjN9W/g5HbbuqnQY6jJ88aX01NcJXr9Gt+xKAZwXVbG+vr8xeYgZvNuFAvazu/nwbrkoj8EOVbHh7F4cGIYsiisYZQekc4K7y2OYPfSprobcw5m1CRwoybMTisJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO7KsOq6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e982506fso21649375ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762785616; x=1763390416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XefgILuYx6ntZN/z3JsLYMzO3kPPenvRodx9fKY3emM=;
        b=TO7KsOq6mFTvK68rToLKWJgT3FyP+zz8AywfJdZw4gBeoOrVj+xgUsNc7jKGvadcsk
         LLbTpMWuCpeXEmX7rZV20QGafDcE3bAHuQ/aOhkNuBZJPzNjxU/+gZl9R19aXyJHlluj
         2/zxtSGQ10Z+FlyxkjnJdHFK6CBxW3DtzQeU+kOAXEtVzSfC/yCjPjMG57CViNZa4D+q
         JW0bSCyxMBab/ue8mhuugGNZoyHiPlNN1bDI9w51p0jy+doDGAAGGgnZAZvHOvzdAiLG
         49Jus8RM594YX5yLY3vJn7OG0KboSm9p7t2kQIQkH6bm2/u5ymH9Ej2NB/pmZrECeu6c
         vL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762785616; x=1763390416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XefgILuYx6ntZN/z3JsLYMzO3kPPenvRodx9fKY3emM=;
        b=uvx9XKbpTIh8yHczQnbMAlNabmYV4AGVKCZJ5qhiAP26IWQzfgCTaH4htIxxUWQUcG
         Ls7bIv/cO//lqvhBECU7y1DTMu2dzDFwkLdTEue6W/tnXY6k76zVQwc6VMZAAh11zLqy
         NtVvQLt167SaePFaD9wfxKLqyDKHglgF/ClMX3/TTx/Oe0weIthZrs7Qbxa+2D/x7Ypz
         0E+VeDlPaRjw560bQlyi6W7QRmvAbkeNeTixdUknBvxvMKyiGkl2wG4pkfRLP4cLCGKJ
         TiCzXWc2FaqvZOL6L3tnVR1W6foSMyjLrrpxs9f8P2MuH0fh1F57BJ9qxdyqF62GIX6u
         ZXzg==
X-Forwarded-Encrypted: i=1; AJvYcCUT7i4KO2B6YiFHSbpVtdwrl5hYI8JLecvYQ59rM9ZFn3DaNOU7QMg6XSSo+woQcZiDNdAiz8UY1kIcRuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyghuKenU2r4dYbkxYBQoPbZR4KHAmgsL1M9VKpLrRbpOjIahKz
	M9B8TfHNiPPwVGLBdyv82EaYxtH0hWZdByLXACXaQu1Cg7xgtxuBWEey
X-Gm-Gg: ASbGncucacDOESCK+7nnuN30A5EJZxRHCs2FD2jO8jlaLSKBrmattpnNO0WPvPWTUXk
	KlHW8X+jqZpgpxrwpmRGw/wToTEDfHc/Ol7OsD7xxLbSO5HS8GSE39CP6nPFiCjrev1GazfOPDK
	r33OEsMRaCJE9cMzKTKPcxEPn8wURfNPqbr48AY4ehOgs0tZaoijWfi6ZUeSLH0D/e7alYsiLrQ
	+S55EWDJwqhg7Ij+1KZHkaFecnUuM8YoOz3dCVYhnELgmhHUO5gkksoaibYZG2C62w2nUFt951l
	L/iH0vDt2edMUV4M+R0lrSjvEFS9jog4EayIRCMAX03O6zyTaMqymHcHoYHYZO3nssJl7rhi+AK
	dVNYoJrfy+ixkgAXGOzLscwEZ+OhRYN1B2qVRIp82LM9+asGFw6DZa53uOAKc3izyvqsz2iFEnL
	L8rFnkVl45KVszkTqoNnrXnXQH
X-Google-Smtp-Source: AGHT+IEuFgYeAoKVwFkEPaKeztVQ/uT+Ye2WDAIhodBNVFVuJ6jHc7hLNsDatLVqZvHFI/ZRCvYRMg==
X-Received: by 2002:a17:902:da4b:b0:290:9332:eebd with SMTP id d9443c01a7336-297e53e7d29mr104763085ad.10.1762785615842;
        Mon, 10 Nov 2025 06:40:15 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c9c2a2sm148276165ad.93.2025.11.10.06.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:40:15 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: akpm@linux-foundation.org
Cc: jack@suse.cz,
	justinstitt@google.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	maninder1.s@samsung.com,
	masahiroy@kernel.org,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	qq570070308@gmail.com,
	will@kernel.org
Subject: Re: [PATCH] Fix redundant judgment in WARN_ONCE with clang
Date: Mon, 10 Nov 2025 22:40:04 +0800
Message-ID: <20251110144004.347-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109090317.4261cff25a497bcc8a358a7d@linux-foundation.org>
References: <20251109090317.4261cff25a497bcc8a358a7d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 9 Nov 2025 09:03:17 -0800, Andrew Morton wrote:
> It's a shame you messed with the whitespace.  And I don't think it was
> necessary anyway.  Here's what it would have looked like:
>
> --- a/include/linux/once_lite.h~fix-redundant-judgment-in-warn_once-with-clang
> +++ a/include/linux/once_lite.h
> @@ -16,7 +16,7 @@
> 		bool __ret_cond = !!(condition);			\
> 		bool __ret_once = false;				\
> 									\
> -		if (unlikely(__ret_cond && !__already_done)) {		\
> +		if (unlikely(__ret_cond) && unlikely(!__already_done)) {\
> 			__already_done = true;				\
> 			__ret_once = true;				\
> 		}							\

Okay, thanks, I will send the v2 patch.

Xie Yuanbin

