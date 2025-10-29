Return-Path: <linux-kernel+bounces-877273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D36C1DA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B8E1899272
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB932E5B21;
	Wed, 29 Oct 2025 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W2OUB02P"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A452DF6F8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778440; cv=none; b=BM/Nk/IksxdyN9GCGNEeDh7dTu6dn09OULuyPN9NzVXyTEnl8XQoOA/PRyfAslKKvvwJ9WK0dnqyHm9rNbVz6ebnx7eeZcnHNHlCgXRgPPSjzHSxnmaKBtrzvd9kyR/ej9MRJoSqiyWjwH1aqvnv16RX61omAa39qkPna1nSYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778440; c=relaxed/simple;
	bh=kdNNBM6lcL6vwfZAgX0UdbIS/fpKRmbsinz5ctbBKFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coLLMiCmvAbwsz78IpfqHHRicqVkwnvVEeBdO9wDcB0LvUHvpkLKYW0roAj4p3nhRohnvPfgaPGEkBqr7gXtwexYrk+9AeK7ZDIb0k6KUOh7Gqlt2wm75WfY7EMtU6Cwb2mJ6jYP7VVIY2h6ei+wbAlSsIafdfVSPcTj3T+JawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W2OUB02P; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so574319a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761778437; x=1762383237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iI0bSg1UjmEl/K8c5bJoL0kjm3B4I+PTE1O53XpPOgM=;
        b=W2OUB02PlxmA78otsU4tr/AxrMnTRWUkYHnivbbBXVEWo6hj8TNonZ7uM7KcmrqHmV
         YCTnV9Vvct1mW6P1I/PApKTvI9zv3v4pXN4nODcW/XK3h0Cw4wS83cgwyWooktAIxdtY
         ot4Z2dOT5ejTzfPIkyLOOs3JEY2KyjrnH1zRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761778437; x=1762383237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iI0bSg1UjmEl/K8c5bJoL0kjm3B4I+PTE1O53XpPOgM=;
        b=kJO1Qqz7I7i4BkgoPH2IoiDFSP96eabh3Qy1jSLTk6SvwGHNZMcUpFe6UsCQZ8gM1L
         Bop8aqXZ52x1vepmAIpOzItqb4EJtPOPJ39Z1JardC6b1Cx4CUdCj+1bj5K+gzCfPeSL
         5XBt1VnvJI+0mfQfWMu/mDOI9e0bIpt3DyycRst+R6Ggwviys9znwNeYsZOXuW+6mmmA
         mqBQ7P4/TOQDD59YF/uNZhYyMspXEo1j8le+wPoXBc6FdZ5fCiIg35nB6Y6fgO2xobAU
         4bp70DbNaKv9FY5xsBWa94LjUfV2yRHcbCJHM5nRRRoZ5SeGv1RuUJLzgjCcDVdVl24H
         tA1g==
X-Forwarded-Encrypted: i=1; AJvYcCVeM7mVOCE6mR9bXoukgm5JTQc3kQvVXd62ZfZut972cK2ko12qllraEgGnxL02TWyn93xkQn6NieJiXoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgGfgnHVjUJlvRghSdGPr4FtVRmUL8R1G0A3Ep9rruUTUIJBje
	Hlb9QI8E8IpVbC1IKCzW6gYKlG6HZ+p+PyTBE5vYldTB8Di/wPM/XYvbOk2sQgMwfFp5BtvXy4x
	qZD6TSNs=
X-Gm-Gg: ASbGncsYKP5bs85BOfuY7VUobvvoXeNGHvSmIIa9fgUN5QWOcQalUYfPWwIBtrHdv/x
	DFAW5nLISaeoBfgC972jv3BrgXc8AGdQyNEuZW8zRxpB2IFjivhPm7nQje8tOZ2lB+dLFnGA3Ie
	eWlI3J3YVUcL6cnJ5u4dXJ0Z2s4alZT9ABtgqNwbOXT0K6GZOpHoKaH3Neod0bY6tzn7qz0BIiv
	C9MGt9m0TLGZBW5X1C4m76ufeDYrTjH6NghSWfQ0nZW0/pYnQMBnCofpTkA+k1ukk+h1UrAd4mY
	9YFcyX2U6d7x27/txX+4pYhKDVaVlgDtrTTF3B/kIV14zsKLfZpIkjYDBJuth3xfS0GOgLIo+O2
	7eg2e6WN1fMByrlXB7DmJKRwZM4muHqNPAnxyyp032f2K9bxMDKvrod3aJVCjdW415ylF3ORWx9
	/dvWapTYHtOn97FAui4AUco/9ZfHxGjxAHbBlke4OH7UwyQmYlHhrCDvliGynI
X-Google-Smtp-Source: AGHT+IE2r5mc63KW9fwY4fbfZmOylizoHkmnKY4frEEWeUJ2ggDIhb3ivlDlhp5WFop6NnB1+SVpWg==
X-Received: by 2002:a05:6402:324f:b0:640:50a1:89a5 with SMTP id 4fb4d7f45d1cf-64050a1b821mr2264066a12.35.1761778436627;
        Wed, 29 Oct 2025 15:53:56 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64043e05a5esm3385531a12.4.2025.10.29.15.53.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 15:53:55 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so574278a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:53:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxifRiLBGbzrYbXsCKJScrql5JJAqK2jvuXrxosQtnTOE+eVYsUQhh/60ZuebLDXqg6QDOMrVSO6VC630=@vger.kernel.org
X-Received: by 2002:a05:6402:2794:b0:640:2f98:c00a with SMTP id
 4fb4d7f45d1cf-640441c6915mr3749620a12.13.1761778435389; Wed, 29 Oct 2025
 15:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023082142.2104456-1-linux@rasmusvillemoes.dk>
 <20251029-redezeit-reitz-1fa3f3b4e171@brauner> <20251029173828.GA1669504@ax162>
 <20251029-wobei-rezept-bd53e76bb05b@brauner>
In-Reply-To: <20251029-wobei-rezept-bd53e76bb05b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Oct 2025 15:53:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGcos7LACF0J40x-Dwf4beOYj+mhptD+xcLte1RG91Ug@mail.gmail.com>
X-Gm-Features: AWmQ_bnilKb6JtBCLxMS2OjuS6zTMwl7TaRmJaxYXYP0hjivAWUl2_eMnvUSCbI
Message-ID: <CAHk-=wjGcos7LACF0J40x-Dwf4beOYj+mhptD+xcLte1RG91Ug@mail.gmail.com>
Subject: Re: [PATCH] fs/pipe: stop duplicating union pipe_index declaration
To: Christian Brauner <brauner@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Oct 2025 at 15:25, Christian Brauner <brauner@kernel.org> wrote:
>
> Meh, I thought it was already enabled.
> Are you pushing this as a new feature for v6.19 or is Linus ok with
> enabling this still during v6.18?

I wasn't planning on doing any conversions for 6.18, but if it makes
things easier for people to start doing this, I could certainly take
just the "add new compiler flags" at any time.

Alternatively, maybe Rasmus/Nathan could just expose that commit
778740ee2d00 ("Kbuild: enable -fms-extensions") as a shared stable
branch.

That commit seems to be directly on top of 6.18-rc2, so people who
want it could just pull that commit instead.

               Linus

