Return-Path: <linux-kernel+bounces-748902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 251D3B1476D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AD04E3571
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394423185D;
	Tue, 29 Jul 2025 05:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xa7M7U31"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965DF224892
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753765544; cv=none; b=hUVqKvhGgVUtZEdEeT615NUmLOX9Mv93i5CxJqxUc/BOph4JamFZqzwGceBMcPiW4D8Fzjgf4/uFxNVtMgB056qKzV4aO3WFBlXooVKyp3uxCmdskGj8FHO6HMqkkOsZafKIF4YwBTNJyBX4g1ElAAMB8EoJHV05zOJ0ZnWByVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753765544; c=relaxed/simple;
	bh=ZZiUe00X7zQSTf/5Mt2Oq7NNm1mBkUe68Jw7+1UdMBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZRx3CLT2+epWJ2gTOfAPd7KalFWeBjeMyWKsrWjVyK9M4vSlvacwSSJ6I0d0TY5BF3wrioHe77/LwS6m9mj2Qsbmqyd/NwKBqaS4WQLvD4tpR4hn60V6FIZKOHfwgxr2L8pElpcXAqnJIwt/kBhZemZRmxrZy5zeuI/04ZK6PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xa7M7U31; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0e0271d82so973205466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753765540; x=1754370340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Md0VKAKCQGHOa5Dc6D/SdULDfFmlsD9zuh7egV7ZnFk=;
        b=Xa7M7U31dFGrGyW4FT6zp4FBEz0CuCqT22Tgoc1TvhCg9lSWGNed3cNz3mJCAipsRY
         4H+6K2aSob5H86KVE06ZGIfAtC34fghA4WuqjYHKDyzUnEkKJdHv0e191N00cAv92hnJ
         kM9zHC18n9t3ZSQqsEIE7Kduxul+vR8d3HjcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753765540; x=1754370340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Md0VKAKCQGHOa5Dc6D/SdULDfFmlsD9zuh7egV7ZnFk=;
        b=bsIzOZzlra8B6qqyBMdS3nT+UG3R6h4QhjZj8CkuofhFTljiT1F1ITQZJIeJTu18rv
         WTmhRmcSLKYkyGVNVt6bJl/0lbNhnohSPoGlk4nFhuqMq6xogc5ZoKbWrvBzegzhMG5i
         uMhRo6zc/Mdp9p+40D1wbbFSwgMph7FYK+yx7q1JU5b/2G/UlxFVrYLZFF6MzqBkuML3
         yY04qaHooGzj7XG1LOIENqHaaL8YHj6ZdeZvHsvqHBssIzav3YLkVMKmNNjok9aW4NP/
         st0FGP7ZkRLqaNOvl5gcxYbfljtgJHrdxwDX1VbGiNCJW6vZcHkUZmujDIi9Yx6BF/4u
         dSBw==
X-Forwarded-Encrypted: i=1; AJvYcCUXGcG+BfxBKyKONFX6tslBziCy/NpnE9N5FlbeSkq/cr64jWWrMU73awcyxf3KE6ddAJYMqu10DuK1feo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJwNZ+RNW5RvONwxg+1WGh3LZbmvUKIfhBXRQSaKWyS9ZYjcyA
	Qp5ZwAveqencb4ZGMd8qY0Y/HiWYf6VuGfcPNxW7i0tyBskhgPk+jCjaBkGv779/X/NudVCJYZJ
	199ONQ+E=
X-Gm-Gg: ASbGnctbf9YLxsRTynPxW9HWoUsvhNpiz1ovZuZutsKjZXz5HCx91y8RCYB7gkGnkgx
	DA2gvmo72h1anoRQUi+W8XpMq3CdDHiJPZlbKn3rX4dstKmTJ/4gFNv7IYYD6iA75zSqF3BDANm
	T5QDqK7D/vAYwOA9+pCqVyOADmwU2O8ClDYJHhx/K1YkwWA1xaERA7BWgvKB/SHQmxi4vKB2g1L
	pEa7GEE/6B4TuFMVfvU2gU6n+wXRQ5qKnr4t9gyJVduc6PeQW5RS+AdsQsVi9J+BQ5uUwjKuy/6
	IaksF3Gi0Q4ZJ79rLvbJIPeeZ2LXpZkzTec95qeowHjlTE6q5ouC+7dyAaXe1eMBXMzc5V5xE7s
	+gm55YwUYzSJphHnxpjjxNGVvMQd3H4sJEvSnoR6PzLKmmpCG0y8rFTvh7eXjUApLQ5yIwVOf
X-Google-Smtp-Source: AGHT+IHEZmCb64p8q7kKcipu0MC0DCJ223FhThJrAQ83VGS3qXHuAXmAV3Qu+/N/47cc+NNTkI11Qw==
X-Received: by 2002:a17:907:3f0c:b0:af4:164c:177a with SMTP id a640c23a62f3a-af617d03bacmr1774225566b.27.1753765539744;
        Mon, 28 Jul 2025 22:05:39 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635ad64f6sm519138166b.119.2025.07.28.22.05.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 22:05:38 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so1030017766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:05:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWghJVmjnzGHWzSu7YqcRom1k8ag3vobyYfxeb5iATdAqX/a76tLkpYqOm5hawCsBhAb02vRz0lFHqsO4=@vger.kernel.org
X-Received: by 2002:a17:907:c2a:b0:ad8:9e80:6bc3 with SMTP id
 a640c23a62f3a-af61710a468mr1620060066b.1.1753765538135; Mon, 28 Jul 2025
 22:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728101658.44311-1-brgl@bgdev.pl>
In-Reply-To: <20250728101658.44311-1-brgl@bgdev.pl>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Jul 2025 22:05:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieQsg76--QpUw8M01t-EYzUifZ5SyOekS3Negd5sRO5A@mail.gmail.com>
X-Gm-Features: Ac12FXwf2tjFTlx_2VaNtkhhywBF4ljjq1iS3roEfzdtwYIwOWMaU7SkmEIMg4I
Message-ID: <CAHk-=wieQsg76--QpUw8M01t-EYzUifZ5SyOekS3Negd5sRO5A@mail.gmail.com>
Subject: Re: [GIT PULL] gpio updates for v6.17-rc1
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Jul 2025 at 03:17, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On that note: the commit I mentioned above is already on the list[1]. I
> have a second one that also renames the new callbacks back to their
> original name[2]. This is a result of a simple sed over all source files
> and a skim over the changes to make sure everything looks ok and to
> adjust the formatting. I don't think it makes sense to send 4300+ lines
> of diff to the mailing list, Cc'ing 200+ maintainers if all it does is
> a simple treewide rename, so would you be willing to accept this commit
> too as part of my second PR in order to avoid hundreds of small renaming
> patches over the course of the next releases?

Yes, that sounds sane.  We do those big renames every once in a while,
and while it can be a bit painful for silly conflicts, I assume this
one isn't likely to conflict with many other things.

                Linus

