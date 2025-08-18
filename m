Return-Path: <linux-kernel+bounces-774456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C05B2B28B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0115E5125
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10992264B1;
	Mon, 18 Aug 2025 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkwwyTJM"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAC7212B31
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549427; cv=none; b=sfe6DtEu9XpD5B3i4SsSnZYKz6Yv7omOgPb2XDxzjZdyXUyRb++NIgoI6pSt9uO3z/tRWaB2yAICl1+JTzvlO/XT+sgY0wIQXs6EZjnFeyQ4j2f/MvCE4239Y0TaH5I6xKSBEhCzFN0FvOWDIem8cMLEa6qCgDEYTPzKMRQTDX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549427; c=relaxed/simple;
	bh=Vj66AWCAWkWqt19voOVEdR3CQ9sDld01IFc7vmBChzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XDFuIGvK+Uze45Exmg88cAN+faNs5CfTEDf+xinZUTN/18zGYuUyrXO0U7R4hgC0hA+i9p1O4qCO0y0XMZtk84XtgRjD9HtRrfs+NaVeqM94ydkSUIfVgW8CvXnNG6hls4pJlwnp9K1rEqs2eOxOKsncs70ZIk/Z+Ph0spRcs9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkwwyTJM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eac9faaso3975799b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755549425; x=1756154225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7dawzvGCBiAPuEMUMtXvLGeCA/3cfR6/2h5LOabfFI=;
        b=qkwwyTJMq3IlFNKWrKQP5XSeyIEbMQvG7AeV3SNMpmIPRn43bNyihMr6h7uN75DZe+
         Wg0VnrqYO2EZP8DiNuFBdh1gvl5lpbtYoE0vw9ZYRebD7PZc/TS8VPVR/EeE3Qzb5vam
         mqEdjNeHMnrBnBVSPO6KmJB3cHVA1p3RdI6lv8VHg6r0qQ3RNuTXn1j2gbxiWDONGnOU
         F7k7fRHJZnOpc8bdCd09nWnayUj6RbH/cxU3rBAvJoHn0PCIXYwUOUbY90r1JM2wMEmn
         ZrdX9Er/3dmP0zyoLl0xTNBb4eHN24PNw8CSoveAWNdbUxV3J4OQTOiA5gO/xpLQ3RmC
         GWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755549425; x=1756154225;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7dawzvGCBiAPuEMUMtXvLGeCA/3cfR6/2h5LOabfFI=;
        b=DP3CCOZTVKBXqilihzvtoN08haNP2wng16VWACTOaekSvOGzBXG0oKGji0Ho0PEERM
         0D7mL8RKQWpoOGlG3XB8tkjyrOnfsWrh3l3W4EdpmKhwNNaY1j8ZNlkiJM0pkmGSxc7J
         Vr2jLzJS0Uk6d2Rsl6kvb1kBHoWZE0ohaTNitfONrWsEO7o4KehRWhKFcjm31b3GEsRa
         Q3EBkBNv9j3LrAU+qI64hyBPfzyiqE9wGVuj6ClnX+vReB7HqAaAIx7tL0QQkUsGM7OK
         ZNiw6ZVOZQcaEGB87uE6250L0aBu3q7wr32bqJfp3ykxkIPAdh2laJdbX+EP7n+1n17a
         9oEg==
X-Forwarded-Encrypted: i=1; AJvYcCWnLcK0EreZVYwK7QSMdtKvEuu4guZmKmnwK04tEreAgDraijokZXlB1o/6EG9CETSJsBnPY3iH/5UBJmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsnPJ1SBvnALg/8BlzUXb0c4WQQRZb6Ju6C/5xU+1EuqKcfpaD
	NFPCyOZ/c+QRik6jwwkic7dePGwRJwSGFEVGp2AmzdAyQdjoPzdvGYlkvUFZ+5UXNS2W86ddk+2
	D5e1wjGHxmw==
X-Google-Smtp-Source: AGHT+IFx616pH/hifIvZOcO9GElFeWpdmZeB5VOV3vN2fNEopFh2K9VKEc3MbyekKtcAfiYfR5NvxJF/h1ft
X-Received: from pfhr4.prod.google.com ([2002:a62:e404:0:b0:76e:114c:8942])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8d5:b0:747:b043:41e5
 with SMTP id d2e1a72fcca58-76e447f51e8mr19467267b3a.16.1755549425114; Mon, 18
 Aug 2025 13:37:05 -0700 (PDT)
Date: Mon, 18 Aug 2025 13:37:01 -0700
In-Reply-To: <20250817135034.3692902-1-cmllamas@google.com> (Carlos Llamas's
 message of "Sun, 17 Aug 2025 13:50:34 +0000")
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250817135034.3692902-1-cmllamas@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8ldngpdsi.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH] binder: remove MODULE_LICENSE()
From: Tiffany Yang <ynaffit@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, John Stultz <jstultz@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Salvatore Bonaccorso <carnil@debian.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Carlos Llamas <cmllamas@google.com> writes:

> The MODULE_LICENSE() macro is intended for drivers that can be built as
> loadable modules. The binder driver is always built-in, using this macro
> here is unnecessary and potentially confusing. Remove it.

> Cc: Salvatore Bonaccorso <carnil@debian.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>   drivers/android/binder.c | 2 --
>   1 file changed, 2 deletions(-)

> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 312b462e349d..28634f786e70 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -7088,5 +7088,3 @@ device_initcall(binder_init);

>   #define CREATE_TRACE_POINTS
>   #include "binder_trace.h"
> -
> -MODULE_LICENSE("GPL v2");

Reviewed-by: Tiffany Yang <ynaffit@google.com>

-- 
Tiffany Y. Yang

