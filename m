Return-Path: <linux-kernel+bounces-897014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3123C51D14
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0353A3BC5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9A4305058;
	Wed, 12 Nov 2025 10:53:19 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B8D2FE580
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944798; cv=none; b=UVD6SxMNfn8d3cNsxwEmHEJQTHJCZjXH95VlqXCuzi7bG2qgd7dRCIW7Eul+Wte2eDTVLyMW5o12Vkn4sfC+l4uWpjcBFGr7vQfgoxqWopIFnWnsS4kM0quVpP1jzNs39s/c+k6lmDP2zAxWH+fRf9jkM4W46k+w/QW0ZYFkPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944798; c=relaxed/simple;
	bh=MBkcIHaoTtJht9V7eELfMMFBFS/GZwbB162qFIHhEkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaxURnGzDnv8xz3gNj37do4yA0673iwQOWAojh6rARM6azcKNsVtfr9L/wmrYgWq6VGFcoeS11QjVCGfI31aM1eCO7wNGMyvvg3uOky+t/dtuUXdVP3l9aUxNL8W6b8c2ycl9n1IKgwObcqq7QHdSSCaJyamMZo7bgKYHZexk6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5dd6fbe5091so308959137.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:53:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944795; x=1763549595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22nv2YHVY20paw4fGOnUiWK+fXNHbu6IXKzWGD3lqAg=;
        b=WXlHd/qdPP/aggM8X/dgQmtkLvp83CVqDx4J32PaSBDuBN31UCDXTZpk6o04Wyw/tJ
         LtBnP/x/Z+MFUdYqMQepgGKxEE7hfOPPPvRlc9+SrrcVXSvLgPYbxot3LDoygDJKq7Y8
         NDOsSs9YPveyyl9s1U/8bMMQOfwtBirVL2uBZdhCHBUNDJve5tNws76X0oHoKZEiyTYJ
         IZNDgkT60OzCO0g8SQ1GTcYgmgq9/rQyPQaijdf99xMCR1EKVkEe8G0AYMswegVY91V4
         DcVnx9truqdituiedjg4kSnfG+vWRZjG+7lNMTXpZ3eNn/F6gN3+tn7yeb7RYjLnT8o+
         5D1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkn6/Yqa4AvHiwgmBzE964qtY+tT9u5O40AjxSUvMgqgHnWc1dK5dVjXaFM3JhWwGFthbhn+EksNA5+Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyy2kvahkJBUFLrvcV/5EafWgJXTq/wq0vPK/3mAY3iUMAFDRg
	6ev4YJYka7nJcw+maiGG3SImzGbqk4sKM+P6VXHH+k12klyCKrH56sO6E49yEPf0
X-Gm-Gg: ASbGncvT4/Bt/0qlxCEX2GLG8DFOLokLb4GNspKhHBWr3hI5m0uBRId3DRPeajN8hyL
	yG8kkm71/fLj6mpkta9gkRSkgTpcKjPgUltes5OrYq6szFu6Q/OXc1a5B7fUnwiZrQDl8aVFhev
	QfsrVqqFWsjHdNg/TX6NEczBeejP26dJ12NNGZy+FBdGHftMKp1bdEnW9IA/89R/OGyYSSYblPI
	RUH2MB4x33zDAlGB3AqOD8CGSxEXfGYreb6R5zWjmkmncAh22gJV+OsLNfMziIu2zyyMKZiPjDy
	JSc8273Pau9FX0/ptDfM9M2jv+Dbadod8lK/eE36lMIJLEBaT+mKmNKXQz1lTcjIrDr0F0id04m
	4NnGoAJeJ5p3EbvkTyK0wmMEb5ykV/s7R5X4mLEHRGXO8CrCG+23ZFnRZ7oVbppLlBlTDafBtii
	uKoJaiBYiXI2azuEnbXQN+YKPavED3svTua93wKVMiAw==
X-Google-Smtp-Source: AGHT+IHxRyhIhAgpsqz3kiOk9Aj6rDHAEWZ6h85O6mJvVDxLLkWIEG19TU6HXgm7p/yhFXWhBhsPfA==
X-Received: by 2002:a05:6102:c86:b0:5db:fe0d:7fd5 with SMTP id ada2fe7eead31-5de07d2faedmr472045137.10.1762944795281;
        Wed, 12 Nov 2025 02:53:15 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9370898d9d1sm7871511241.12.2025.11.12.02.53.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 02:53:15 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93720fd0723so226879241.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:53:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+fg+W0h75E8dhDRACAloX05hJGz0/BJK4wUclUePFOc0e7ykQwKy2+tOiCTngr4jkL2eij3GUS8iBo1o=@vger.kernel.org
X-Received: by 2002:a05:6102:161e:b0:522:86ea:42c with SMTP id
 ada2fe7eead31-5de07d2fa38mr570610137.11.1762944794864; Wed, 12 Nov 2025
 02:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112160553.171643d1@canb.auug.org.au>
In-Reply-To: <20251112160553.171643d1@canb.auug.org.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2025 11:53:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVaz7T=n64YJrv4QEa0dM9pMt+es6fFYxP-czZxhRpsPQ@mail.gmail.com>
X-Gm-Features: AWmQ_bn1q2yZFAdSThfGUme1Ea7R56WVwUCp_oiRj4_PbxJicN2lvoGKqu8c5F4
Message-ID: <CAMuHMdVaz7T=n64YJrv4QEa0dM9pMt+es6fFYxP-czZxhRpsPQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 12
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

On Wed, 12 Nov 2025 at 06:06, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Merging drm/drm-next (2a084f4ad727 Merge tag 'amd-drm-next-6.19-2025-11-07' of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
> CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h

This file contains a duplicate definition of MAX_DIG_LINK_ENCODERS.
Please drop the second, cfr. the resolution in drm-tip.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

