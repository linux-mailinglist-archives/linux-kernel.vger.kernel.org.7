Return-Path: <linux-kernel+bounces-748730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A870B14568
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DDF17F350
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A7F1684AC;
	Tue, 29 Jul 2025 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bBvs/Rkk"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39D3C26
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753749812; cv=none; b=OsT04I11+EsbCSGWkZU6KKY27z+5c9nU6VNbr7DPnDeb9Hi6GmpZgKDzNCO8vigBTFn1og5teSvoQuoZZhbh2PvzAf79AG2l0OX+L2L48VsJGGNrLfIyj64Z8FkEhy1xSMQu44N3BZMZsrq8bAyv9KtsI1C7SK8bVrfqV0c0OGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753749812; c=relaxed/simple;
	bh=60oWKT04SSz+ctsxendR9LuMK7LdoC7UYSPTr6WWHKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sH8j4ERMVGXGn/w+znkcLSRIpa+4unn5V6uQd3fYrxMRlSbIN6oAq6X1UMZBWxrMGxpE3OpcqnRGx/lQ2EYnd79wDF00v+Dv71BzF4HTrxILzmCzFYoSdAx9KQrLnMIa41+8DE48X2HxN7OiU0IikEH3NXIA8SAcXiKUVlB4a/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bBvs/Rkk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-614fd1a5790so4717582a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753749809; x=1754354609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UVireiPOVcPstcui7Y0JSsHO5B3XoBdIl11JQhh9yRI=;
        b=bBvs/RkkQTfcWeWQWsjhDA52bX8xULlB6YXFF3G61r2Ll0IDwwcW3o8iPeQh7ZGSnn
         z1Izyc8/4A6FVmipqQlntyLfYoV1+DDJWvyp45GQO/h4IjBLe9r2k28q9UZb/7UQhHAX
         ok9Oe+I13Bstv4xP92yf3w8RMJbqV5Znhb/lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753749809; x=1754354609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVireiPOVcPstcui7Y0JSsHO5B3XoBdIl11JQhh9yRI=;
        b=KBfRgwQk9P3n9og/f/IlxEKP93NAkQwbXWA4c50sC2Rg9gh08dxtnIJpa5hkOjhtRi
         jrHv4+dO0jR1EpOo1jPQ7kYwCWcDcniN9pYiLwyHf51RJIJEsjHTctbyN4vvlub6Z/oZ
         xPrSdW6JE8KmSn5G+oNEr/lx5MJB/uHst8rkdOOWbA5L03e0aE98WnkGJIhrdJADUzd7
         ruthkIbP31aQAzwsp4xMIZusVJPG4O1PfbkbzLrBzUfNEZ78RRjvaoDClwcg34+8dEQv
         HVQMtRQCrsR57yB0PNWU6PjzrxujpEXaukwKFIhJc1Az3Z1R9K3qURABH2CgEpLTvfQz
         WSwg==
X-Gm-Message-State: AOJu0Yytp8mD0v7beaWxmeQjSqGNS6aukajSKtZyDpbQg9u/MB9Ff+QY
	HCuSlVvIUA/F6P3YmN6DZMVjBNHVKnEClciiFW30bI/NgVf7j1aXK97lQfys/hKxtejOMs8rknc
	QWcMwfW8=
X-Gm-Gg: ASbGnctJRmyjvIlh2t0Hc1r4PwlnwsvEfDkHvXmi6J9Xyf3aCxCgVhUC3pSLSitkqnY
	hMpp+z87qksk6Nt87tZb0yuX2ixjtRQUBkonKbYeKZF/AZRk1GDLNIOt3ewaOx3gNB7FzDta6Rh
	4BIpL2KXZTS1/7f/hEXS9npBxmygOiHUMuomgyj6V5vmdyOAh1DCenYYK3X4mJKSBkFnWNcN+7f
	pGFAz1IzXAWty9dEUAj3wRtMnELQUVz2LRZCfdkh4tvwSVT5mqwhrBqY4Yxr1kIgFW+Js1v97cD
	CammIFtLoc8qqfBR14xwGLX4uNn+2H3fgI69LIq5APYOSO5paWBnNlbwkyRvdFBjw73QHlJ/vXp
	cerWKv3EjCRhklB4YEja7vI53aanH30TGtq+Wb/cGCkGnGHI4yLQCzY1MKxBQkewdM66RnC+i
X-Google-Smtp-Source: AGHT+IF2UdRftFWD8wkQG9xIK9YQIhHBkt8GJhVDW1fhxQhNxkKiHuDTkeVH/uuALs8FcRhnJjTpCw==
X-Received: by 2002:a05:6402:2550:b0:615:53d8:6cc1 with SMTP id 4fb4d7f45d1cf-61553d87017mr3317459a12.29.1753749809062;
        Mon, 28 Jul 2025 17:43:29 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6150058619csm3853679a12.13.2025.07.28.17.43.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 17:43:28 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61530559887so2693596a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:43:25 -0700 (PDT)
X-Received: by 2002:a05:6402:254f:b0:608:8204:c600 with SMTP id
 4fb4d7f45d1cf-614f1bdda7fmr13989710a12.3.1753749805062; Mon, 28 Jul 2025
 17:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202507281251.8989493D@keescook>
In-Reply-To: <202507281251.8989493D@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Jul 2025 17:43:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZkusqUg9nt66xYVeXxMcmeOw_-toc=-kwPi5Gad4y1A@mail.gmail.com>
X-Gm-Features: Ac12FXzRn8GMUOEMBvZ3vbziP41DSnA1xCz4zn-rANI2Uh7wdJ3ORwYzFRzsOHk
Message-ID: <CAHk-=wjZkusqUg9nt66xYVeXxMcmeOw_-toc=-kwPi5Gad4y1A@mail.gmail.com>
Subject: Re: [GIT PULL] hardening updates for v6.17-rc1
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	David Gow <davidgow@google.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ingo Molnar <mingo@kernel.org>, =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>, 
	kernel test robot <lkp@intel.com>, Lee Jones <lee@kernel.org>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Marco Elver <elver@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <n.schier@avm.de>, Nishanth Menon <nm@ti.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Jul 2025 at 17:01, Kees Cook <kees@kernel.org> wrote:
>
> Please pull these hardening updates for v6.17-rc1. Some notable things
> that stand out diffstat: there are many scattered changes across arch code
> to clean up __init vs KCOV instrumentation. Most are landing here via
> the hardening tree but 2 landed separately in their respective trees:
> loongarch in v6.16 already, and platform-drivers-x86 that is queued
> for merging:

Is this the cause of the new

  section mismatch in reference: volume_set_software_mute+0x6f
(section: .text.unlikely) -> tpacpi_is_lenovo (section: .init.text)

warning?

It does seem to be a preexisting bug, with volume_set_software_mute()
(not init) calling tpacpi_is_lenovo (which is marked __init for some
unknown crazy reason).

I'm just not seeing what changed to *not* inline that trivial
single-instruction thing. So something really bad is happening to the
compiler because of this hardening change.

           Linus

