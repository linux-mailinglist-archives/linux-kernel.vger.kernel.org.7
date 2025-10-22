Return-Path: <linux-kernel+bounces-864308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D00BFA7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B33566F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE712F49F4;
	Wed, 22 Oct 2025 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="COLcNWdn"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241172F361F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117231; cv=none; b=GNzRlzNfQG+2EtoBd+QqAkPEVJVIOapOmQ3W5oo6SuUt3dLkeROVePotBYjN4uPB34UNf9J1B4SH5nnUal87bqJ/TiOPVr1KdoHxlMDuNx+Sdsk3A6oGw+JKk+XQv+Up5dCsPdnDg7szElW/3qzGe6b/QANzaQbNRiPBQUC23Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117231; c=relaxed/simple;
	bh=GFk25FyWkR2PK2GtgENMZnxIVRPhxbKh6/48P/XqkdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ku8gQ17UZuk3BLANJOt7rLTFvzcqVWzDEWJl/o2mv9eNRhj52HgpMwyiW2rFrKiYmpP1z0hTN4FMseVac3llqSw1nw8yS8lBFtwAn5csVOX24zr2rcO6vPLadUwycuptWNkIjCHyJVjLGCAHMqoF2r1C+17nduPhXiWwZy5ZBa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=COLcNWdn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so1282267766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761117227; x=1761722027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9zwPnIO3NVOP/cmDlK60nRyQdcjIpG1DboYa2VeDdU=;
        b=COLcNWdnwI0b5sEGt/LYp+rk0hugU/i818wCTPcodoa6ZdaJFmVj2BlFLQbQ2lokcL
         +2AsaZ/+VACu0QyhTwkegzIMEaAWxlXVwqjcnMY5wAYMFAG8sH/ziV48hSSaWsalaEje
         Ie8LKe36OztylFBf8nIlGQR37zy2ONnU6SK8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761117227; x=1761722027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9zwPnIO3NVOP/cmDlK60nRyQdcjIpG1DboYa2VeDdU=;
        b=l8r8GXrIhnbWCzA7249rCQf8IjsDDyQvFUR/olVC4Mue4VLdlz+Wl12mebbLZkri4a
         Aghydz8vu0maVb7hqbRTHGRXcmYV45eyate5dpfVnnI57e/EBgrYIJqfJAqQnhiQuVzv
         MsPq//AuwgE1F+xbLg9DISxtMV+tnWCAD3K/Ko0uyDcrRUUBDO11P7m+k824l+GrGBD/
         MJ45YorfABgE0X6dKVW764zmAVL7PDy2RBdg1QIaJGCKqL8zCb9i7QkqGBD56/i387BC
         A1R1SBK0LVTDXlv+kjYWRaNTRXTe8Waf0ThFe2EzMX+HB64h+c8npw/Mbq+jS92B26wL
         QiuA==
X-Forwarded-Encrypted: i=1; AJvYcCVz42mWtwHP/iC/otpbeiRjiRvAUmIvbAHCgkaI/+vGRCpG51/rx9WjKy5pm7Q2MrJzj/eMxrTAlz7Xf6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMYJxmAIVD0dlDQrLF8+U1xjWRBX69aIxVGUS+s9fKY4kN1DXl
	C+gEx8fOVXoCdA6zIacKj4jame9QF8xM/T5kQAg+gFrHd5U9yiXCxhv6rn9XOxTruHhydGOvmdK
	sP8ZvTmXG2Q==
X-Gm-Gg: ASbGncuoRM5+y0jK1p+Ho/VwwRB4rD+JEKN3vIAU0QrBAA1jPb6OrUOFkLC69r7LkpK
	adrwUV98Oe7ggRHgJfx0G8sbYWO4+JZC6RSCsR1bVElIk17sHfKNWjzVQyH4pnIJb5JVtY2uk1Y
	0cWZ3QLiTUltuHiKT2aoioDeHT2hYXJAFzhS2qBYiE2cm2EvJM6/7DcCNybNoWyBgLy2g1DzFeg
	EaWwxzgTTiWmY+skYtqm5dj0LB827VmTiL6WtR9o/TMRz/6a9SGlJ8y1HlEP9v/HMrXIANylP1z
	y6HVn+YAPwVoNt+FPrYz7Hd2+1OsDBzi+o6l6+W0ROrlWD6vnfw7KjP56hEMvUEy+ahq6IFbNaU
	D9WMUUwYW81tgdvTBhzUX/a1NZvu72y7XRGoNU87i1rIm9TcOMfEX30yWK3oa9ioUaS9cAQ2PAu
	UXS799APDU6vtV7wSr64VROpKVN/xKbEyUtFongCXQxowdL6JtA1vq4i5O+5L6
X-Google-Smtp-Source: AGHT+IErPH3M10nyDzPmQRO1VvAg9Q0vuwWGffpCjbkRWzvGMQMOO1hJ23Rz8ZFF0RLCJd8yg2CfUg==
X-Received: by 2002:a17:907:5c8:b0:b40:2873:a60c with SMTP id a640c23a62f3a-b6472c5c6ddmr2346629666b.3.1761117227193;
        Wed, 22 Oct 2025 00:13:47 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8395c52sm1255933166b.30.2025.10.22.00.13.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 00:13:45 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so9120680a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:13:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxgT6R2yTb/7afjouxZ4lCtAWUHvKqxhemqO5Ozz+EY32EeVntfAnZyIr4pM3llu6t5RNSrzL0V+E7t0A=@vger.kernel.org
X-Received: by 2002:a05:6402:2706:b0:63c:3efe:d986 with SMTP id
 4fb4d7f45d1cf-63c3efeedb0mr16580891a12.35.1761117225052; Wed, 22 Oct 2025
 00:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <zuzs6ucmgxujim4fb67tw5izp3w2t5k6dzk2ktntqyuwjva73d@tqgwkk6stpgz>
In-Reply-To: <zuzs6ucmgxujim4fb67tw5izp3w2t5k6dzk2ktntqyuwjva73d@tqgwkk6stpgz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Oct 2025 21:13:28 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgw8oZwA6k8rVuzczkZUP26P2MAtFmM4k8TqdtfDr9eTg@mail.gmail.com>
X-Gm-Features: AS18NWCVkJF1NOqKWFU0gaSGK8tjMxXG8WT0XdrBzJSO5Q7qcLLOOQSVewmJNPE
Message-ID: <CAHk-=wgw8oZwA6k8rVuzczkZUP26P2MAtFmM4k8TqdtfDr9eTg@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Pedro Falcato <pfalcato@suse.de>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 21:08, Pedro Falcato <pfalcato@suse.de> wrote:
>
> I think we may still have a problematic (rare, possibly theoretical) race here where:
>
>    T0                                           T1                                              T3
> filemap_read_fast_rcu()    |                                                    |
>   folio = xas_load(&xas);  |                                                    |
>   /* ... */                |  /* truncate or reclaim frees folio, bumps delete  |
>                            |     seq */                                         |       folio_alloc() from e.g secretmem
>                            |                                                    |       set_direct_map_invalid_noflush(!!)
> memcpy_from_file_folio()   |                                                    |
>
> We may have to use copy_from_kernel_nofault() here? Or is something else stopping this from happening?

Explain how the sequence count doesn't catch this?

We read the sequence count before we do the xas_load(), and we verify
it after we've done the memcpy_from_folio.

The whole *point* is that the copy itself is not race-free. That's
*why* we do the sequence count.

And only after the sequence count has been verified do we then copy
the result to user space.

So the "maybe this buffer content is garbage" happens, but it only
happens in the temporary kernel on-stack buffer, not visibly to the
user.

             Linus

