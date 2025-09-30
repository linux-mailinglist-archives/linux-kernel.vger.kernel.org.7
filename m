Return-Path: <linux-kernel+bounces-836900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8089BAAD53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B20C189E45B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A232199939;
	Tue, 30 Sep 2025 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XLG3kTMX"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6017A31E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759193979; cv=none; b=qzZLUA23qEmCz+lKoG4Jo6o6SoX+5tMyvY/ubcpnJJ/yWpQn4LL3/nDcYj7hj9dVBMHppbT3bMYwZg47vFMom5b9bpsMPU4YJDkJylMc2zzOMZQWewpTqVqqK8tBwfo42h/W1PSeunBIEXPJ//gFSIwdnrq9KgJ47l9MxyyyvHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759193979; c=relaxed/simple;
	bh=1F3MN0K00u9l9XfFX6T33t6JCa1yRRUGLOUwFWHyjeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMk9mr71thmX4WqNnXWfBMKw0hfkQC3I9OaVVgSyLyXa4HxaO73DDY1r0fqQgTDSLmlewoDyQkl6zANXJfshpPtDIcbMXmZmBYznouYAtcLoRr1+BLeWzkdb0XGYBdnhK+1Spv0GF2gSbnRTOUKRDrkEaWmWu0B1Lh3LKqQrvXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XLG3kTMX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso11700847a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759193975; x=1759798775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j05T+AJ5ug0YUQt+mHprRkkIcXfR5RS/STZPsts5nrg=;
        b=XLG3kTMX7jb3qU+rS+jPy3/0lRCR42X+zUCs4vssBosicfBOZzfhZ33WG1j7lOW/Zb
         UueIluJk3YDAGpDaVt3oDB2yssXbQ35vwLIDdUzzM0lBhVIhhitQN2ConH+OsTIazvYj
         eTxuxssS8nt5Naf6ZqzbdVPCn5vKrHyPnGaUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759193975; x=1759798775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j05T+AJ5ug0YUQt+mHprRkkIcXfR5RS/STZPsts5nrg=;
        b=vdb1FS9HN4e2rNR+GpC/Hl4pb0Ruco3ok9ax59qYpAQfhb/kzUdVcdBbQqqNSBPPMI
         HULDasFwSsQNnpkFr9nbkGzq/mE/N8qUEHtX2t4Y/y3LymEybJZaomZhFNXxsieFAf8X
         da+zDPXjuf+4uUng6XNzvzU52ma7pkkIZ4e3yKvbHf5dbtNBTCyWDtc1NhXCcpiHlTYq
         U9ksx9+msIaltMgBam/A6v2YpRLXUM4Rf3NSHzHbI1lnD4Wf5E5em+EQBkP5uCiXxqEc
         rpl6fEJ+PXoCk3oiN+n47H7koHBC3I1sLRZNGyE9QxbC7N72lVsuC7Adov6bo+j8sSzo
         V/qg==
X-Gm-Message-State: AOJu0YyvuyS8AGjcrGpGfls2HVTZIs3YoTDQd2iYbFaVw80LB14MtqqX
	br3Nwxdeq8gPV1JbOmLj8pm79MTOdr+I0o+UQVvWCXR0fOlftXnyB/X1TJEwHiJRWcqPuamqlyY
	t/+cFOeANzA==
X-Gm-Gg: ASbGncu5j5cFePEN9QKzmvhgP4mlP3Eh5rWzLx2CZjuHNxWyKBgJa5qyLAHdbsWwhCN
	ZckemUA+vAXggIA1dkrbmhPOmizdXzOEsTHfyzEhVBuW8EWkmHIk8Jx9lW4WGMX6WAxxEv/UYbP
	sQ1p3FoOkJqZvwAOa1mpx1KKSJfgGIZF9PSsyVai0ftXj3fAFpBOwHC/MU9sCIuV+ScY79k0xxc
	+tEOARgNtshVd18pO4IZlQkmWACkon9WwmQCdKMUcTy+JNfU+aKcuVpxLig3vnBjTc+6vYzSl67
	sH3oHv6tYh9bWIPjquhXB1vxyfvztYi9P+hWUNxp9MdidMLZyP5NAj11rVdUCi8uR2WlQCwTCI9
	o3Tnlx7/knRGeQzm1p4baXMr5w//V/I24XPSkGnsXvrX4eNYzVml22Ofvd0PVqrGD1XzwRWer
X-Google-Smtp-Source: AGHT+IGnfupixRE0QoXXx9Z2MGGwWMH1MuS4tEwH9vaVaOoaFAbO1NfobNX3isRf2SGBWuvPV9hdLw==
X-Received: by 2002:aa7:d697:0:b0:631:e73a:e9e9 with SMTP id 4fb4d7f45d1cf-6349faa6c60mr13458379a12.35.1759193975367;
        Mon, 29 Sep 2025 17:59:35 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3339b63sm8615542a12.0.2025.09.29.17.59.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 17:59:34 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso10876555a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:59:34 -0700 (PDT)
X-Received: by 2002:a17:907:3d93:b0:b3f:d9e9:bac7 with SMTP id
 a640c23a62f3a-b3fd9e9cdf0mr493524466b.53.1759193974066; Mon, 29 Sep 2025
 17:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202509291213.E313986EE@keescook>
In-Reply-To: <202509291213.E313986EE@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Sep 2025 17:59:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZjUk4Cy2XgNkTrQoO8XCmNUHrTe5D519Fij1POK+3qw@mail.gmail.com>
X-Gm-Features: AS18NWA9dW65c6X1LeXdXqb3pPU4V_71wyUQszVN0JsRA_T33KNti1ILAP9vwuA
Message-ID: <CAHk-=wgZjUk4Cy2XgNkTrQoO8XCmNUHrTe5D519Fij1POK+3qw@mail.gmail.com>
Subject: Re: [GIT PULL] hardening updates for v6.18-rc1
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Christopher Fore <csfore@posteo.net>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Junjie Cao <junjie.cao@intel.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Sept 2025 at 12:15, Kees Cook <kees@kernel.org> wrote:
>
> Please pull these hardening updates for v6.18-rc1. One notable addition
> is the creation of the "transitional" keyword for kconfig so CONFIG
> renaming can go more smoothly. This has been a long-standing deficiency,
> and with the renaming of CONFIG_CFI_CLANG to CONFIG_CFI (since GCC will
> soon have KCFI support), this came up again. The breadth of the diffstat
> is mainly this renaming.

So I really like this addition conceptually, but it doesn't actually
seem to work.

My clang-building tree config had

    CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
    # CONFIG_CFI_CLANG is not set
    CONFIG_HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG=y

but then when I pulled this and did a "make oldconfig" I get Kconfig asking me

    Use Kernel Control Flow Integrity (kCFI) (CFI) [N/y/?] (NEW)

anyway, in order to get

    CONFIG_ARCH_SUPPORTS_CFI=y
    # CONFIG_CFI is not set
    CONFIG_HAVE_CFI_ICALL_NORMALIZE_INTEGERS=y

and I thought the whole point was that it would recognize the old
Kconfig names and transition them to the new ones. And it very clearly
does not.

So I'm a bit disappointed. Possibly because I expected the
"transitional" keyword to be doing more than it does. But possibly
because it's buggy and doesn't actually do what it is *supposed* to
do.

Hmm?

I've pulled this because it doesn't seem wrong, but it does seem to be
less capable than what I was expecting / hoping it to be.

In other words: the long-standing deficiency still stands tall and not-so-proud.

           Linus

