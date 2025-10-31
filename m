Return-Path: <linux-kernel+bounces-880318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E6AC257ED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3050D563A94
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FEA34404F;
	Fri, 31 Oct 2025 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abxjRt0y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930D34BA33
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919565; cv=none; b=oB+9mkAWECxDW3BVC6BxoIdv7vrqpiZkEfxzOCysJz0q80GZOHto7WdB5OyMngKG9M2JTv8uGk/ektwKAD476Or0sZpEbe+T6SdI1UHUWPkMLKdlhk2oQfgrQr6H9aj3rGefmY0B/U2sC2cnSGyJC0XgFeE/R3MUycQGmeLixbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919565; c=relaxed/simple;
	bh=aWeZLFH5RpgoAv9utSwqm6Yp/w0k/N6YxdsEFm/omZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjvPsGecCB0M2zpSsIHRfvhA0VXsEL9lPDllnDuN6/dzp1bVff69NZGabADuJVILeoJSbZAgCGJBTG1xE4+czt+un6s6WvLWI9R9JWlVEwFbDa86oEJUGhcw5JMCQLJ8RllVEJ/JoR0twFCZlGAapJhtN5/KgnAsNLg/iqC2f7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abxjRt0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E19C19422
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761919565;
	bh=aWeZLFH5RpgoAv9utSwqm6Yp/w0k/N6YxdsEFm/omZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=abxjRt0ySxBJ4xYXAFBU9dhgABvTdBFl7LU+6Gf3bGyYJFlzw3fNnN7OEPbPB36HQ
	 f1ecGzv32VApuXP5oieVnrqzeJ5zOXeO9tXAa27FU18gQMGdCood3vIG5R+iHL8SA4
	 ZqeDk/kGPDsPGYQqD0pLJ+XmioxRHI7ZpSBfdvik72JTIaA8gL3pZv7OXDT8UFccUq
	 egVOsLvOOD5QgesUXdlelSyn8GXcs+HXvAy61/KVhXSEimaorpVvcaY5TargEqTCg+
	 5P6GLFFaW9g8uUp+rsgo6/uDsN1vGN1GFdwjqRmc1cHwIId4X7Z9Y715pHMOPNAD0S
	 6N4sqMXDgFBJw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59310014b8eso2471374e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:06:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+DDjC+4EsVKGFj+IRtg+ay1e/24WhtuTM4hQWJDs7KDFGqry7xZEUvSTMZKE85J2J+Z2yLDr+foyLuro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ndyctijL5lBeSOHT2DBkn0RqQ8abVCGR3hAuRsq8hiyIM1PZ
	nNnWDr3OvWE9kIFbfa8aE2DsK2k97mHo+6WviPn1AnFCNxuzFF2ekYD986VpEPUG78Wtxm9zrBE
	MBr9hQakrgLQ0LoNpCGxLdEsjP8LB54M=
X-Google-Smtp-Source: AGHT+IEp5m47JaUV3jVoZQ5XMFczaX0U7o/VOQHO5RGjNAQsdXQw+KNXcUYCJlrWBHGG6aoWOl43H+2qo/UwG+8ZTYI=
X-Received: by 2002:ac2:4c53:0:b0:591:c346:1106 with SMTP id
 2adb3069b0e04-5941d4eedadmr1292338e87.9.1761919563392; Fri, 31 Oct 2025
 07:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031103858.529530-23-ardb+git@google.com> <20251031103858.529530-27-ardb+git@google.com>
 <20251031135552.00004281@huawei.com>
In-Reply-To: <20251031135552.00004281@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 31 Oct 2025 15:05:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEJbnKuhEjBGxtH6ri9fkJ_AygfLFMXVRbnnVKqWzSrBA@mail.gmail.com>
X-Gm-Features: AWmQ_bkKphB_oRPPSkEzIfFAX2WH5E8Txm3hjePOvgQQIuD6R_hNOY7rI6PkH1Q
Message-ID: <CAMj1kXEJbnKuhEjBGxtH6ri9fkJ_AygfLFMXVRbnnVKqWzSrBA@mail.gmail.com>
Subject: Re: [PATCH v4 04/21] arm64/simd: Add scoped guard API for kernel mode SIMD
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 14:55, Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Fri, 31 Oct 2025 11:39:03 +0100
> Ard Biesheuvel <ardb+git@google.com> wrote:
>
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Encapsulate kernel_neon_begin() and kernel_neon_end() using a 'ksimd'
> > cleanup guard. This hides the prototype of those functions, allowing
> > them to be changed for arm64 but not ARM, without breaking code that is
> > shared between those architectures (RAID6, AEGIS-128)
> >
> > It probably makes sense to expose this API more widely across
> > architectures, as it affords more flexibility to the arch code to
> > plumb it in, while imposing more rigid rules regarding the start/end
> > bookends appearing in matched pairs.
> >
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Very nice.
>
> FWIW I looked at all the usecases and other than a couple of trivial
> comments on individual patches they look good to me.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> For patches 4-19
>

Thanks!

