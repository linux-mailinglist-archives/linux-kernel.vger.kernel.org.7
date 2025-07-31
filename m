Return-Path: <linux-kernel+bounces-751603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24864B16B62
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238DD4E6F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A6A23D2BB;
	Thu, 31 Jul 2025 04:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KWllwRnJ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0E1E51D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753937949; cv=none; b=tYloF6pzwCRCGKvWpQg4LFWk39cLcnIwRnnOZjFQCtmg1mB01jhhWkpbMKEztF+QV8Yt6ZwHqdvbxn43xoJVJI/RbTy3kNQdBi7iPuCup6wCdt1O1Y7S0cFXlmoE66LYGiihYzkYwJQ1nCvw4fRWAIEBS/QPzQXiYOj26ZAGN9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753937949; c=relaxed/simple;
	bh=MZcWI5S8NCtqHLwd/m35/eHqUCiEkomK7D/kt1cb4gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MENxvjOAji42iXb1eymoCugX0GvKuM8SbtFZthOjTKhIwyyK5khr0Yh1rcei1dp3jJXZiONZcsf9CLAckSqpg8DGQyOH7obgCJdyn9z9o8QulLyTVcIBWe0lN2rYlzcmisiH3ymcL2KTApyegMPvphe1snkjGbcPFX5F+Yrb6NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KWllwRnJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0df6f5758so85789466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753937945; x=1754542745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SDR+nXsB5Eofl7XYJqQlqomL2Y+bdQehNIv6f55HHF0=;
        b=KWllwRnJtR2AEKCnWtXn+jydcDQlkjw6iu1F0jedWlFf+j07LHqbfe36diepnewCce
         OQCHXumy7CFZgcA++VMuuOiLD//CypD11AfgP40Q1QGffLkijhhGFcVeF3JQusjCgALH
         cDRoN8DaOfwcDa5WdqApUKmCHR1RK8vTY69ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753937945; x=1754542745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDR+nXsB5Eofl7XYJqQlqomL2Y+bdQehNIv6f55HHF0=;
        b=T3W3l6e/ozhFZ1Yy6xGzH8CJLN6h6hTnIiaWpc1EzHiIzrZ9Ns4MShuiA1L9RwKg7+
         Mzwy1puc+q1ziRF0JsWthpucVxKVPV+nMN21f86IKwQhc4pLKgbfI9nD4wl5BFHl6Gdy
         3e6qTmlVjZ0+xZh60aXDrWU8Ib1unGcJSh2YJg8vWrMcXfDIgLDXNcSfU9IPx+eRe4gH
         wgovCACZgMj7FS+WgWFmYiUIwqb2SdOEsVzPrEYN/g0ZOHqopMvPulP+xVfv6dOdg3ob
         swluOrIpZI3uQg7XGHCKcnCvliipIx9JdTfg1AnK3c6hv2Ck1vKaav1rGOtuU0wnFv2j
         UGYA==
X-Forwarded-Encrypted: i=1; AJvYcCWzVkoXA/Ig4BIYXdIg2B/EiytX4lXE9RDP7gHM9Y/JPYqAuIp3nkHtWl1YFn5tD0ni9d7U93TPhIZBWQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbRZIJEaX5GyvGr3Jz95Xg6XEcbZ4f9q2liTRvdRyC5WGDHW6n
	3uJHTHazjN17YobGu+hKPYn6X9EMBatkPWG4yUCEmLkdZyGOmMs3Z/QrYtH//qKFgm2Y/kusadC
	vB8zLaXM=
X-Gm-Gg: ASbGncu01EX7YIa6TKlGeeMzUbd+trd46pYqiuy42pn7SZO02fYlMxULb0UCW8ZAUq0
	MDjdZd9Ukar4JqrnapbILie4wLdCKDERKWqRFl7J7L4pYTEXyXXtyg5tOXopMLCPgI/lIR/tX2Y
	C75PpmqLwK0m2m30ryngYmXmPUzozdxlcLw7beYH/yLjPEht40otPm5BIbUNhehQ14Foj94xc6D
	RNLhmHHA2dDj6QXbqANKLNbuu59bNRPiYlXVatPZljkz/7hrXDp+h40rQR6iD0OHhO72fzxUVdr
	+G93bRYm+5QMIn9mNuiwQ0CowYZ4LScA47eJMCLTZRfksXBkzEGtl/BKeyRjzJfUJMNeTv/WrKY
	FN0+z/qfoAGFZO917m8pcyEiBuf6QsUu6rAykJctJ7XMfvnQwg1uOGnCT2oz7BrKbbGt39ioI3u
	jYC8tGxe8=
X-Google-Smtp-Source: AGHT+IHymPIKnN0vfB0kxaGYJO1bWD/qsRK+HlQjGNwqU/RqW0h6GJ4JKjA+RQMjORQ7lP0jBKp9Xw==
X-Received: by 2002:a17:907:7ba1:b0:ade:36e4:ceba with SMTP id a640c23a62f3a-af8fda0c5aemr708373866b.52.1753937944858;
        Wed, 30 Jul 2025 21:59:04 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a91138easm542551a12.56.2025.07.30.21.59.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 21:59:03 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so568357a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:59:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtZV76alnrRR4RbbecIwl5/4fV/G8c890oq64nV9ZlLr6GfmM4B4FcALkEk4ccyPolLsmFOX0Pw4v/1pQ=@vger.kernel.org
X-Received: by 2002:a05:6402:27c6:b0:612:b67d:c2ae with SMTP id
 4fb4d7f45d1cf-615870b55cbmr6258831a12.16.1753937942860; Wed, 30 Jul 2025
 21:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
 <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
 <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
 <CAPM=9tygJqtbmYzB5gktxp-7fBfv_9gNq9p9+SdZ6wiYE2-6PQ@mail.gmail.com>
 <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com>
 <CAPM=9tyb1mELymOJv62KJom4mGF0UBifbVqLJUFdS1C7Eeu3jg@mail.gmail.com>
 <CAPM=9tzDWmYBKQGB0ybDzhYHkg0p98_6PJA8OuPahRep8+QPvQ@mail.gmail.com> <CAHk-=whOb_ebQQbnXeqb8uXf32WA32nrL3=HQ2y8hBm9hFgVOw@mail.gmail.com>
In-Reply-To: <CAHk-=whOb_ebQQbnXeqb8uXf32WA32nrL3=HQ2y8hBm9hFgVOw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 21:58:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+79KkMXsNqyPxeU+c5U2h-n13ko6J_QzwtjyYCKhrSw@mail.gmail.com>
X-Gm-Features: Ac12FXyKAfRuWqMYw2cQQob3MB0m_PufodiTRPWQuH_SVlJTpkXUQidf6jnttf4
Message-ID: <CAHk-=wh+79KkMXsNqyPxeU+c5U2h-n13ko6J_QzwtjyYCKhrSw@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Dave Airlie <airlied@gmail.com>, Dillon Varone <dillon.varone@amd.com>, 
	Ivan Lipski <ivan.lipski@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 21:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, it's one of these:
>
>   3f2b24a1ef35 drm/amd/display: Monitor patch to ignore EDID audio SAB check
>   aef3af22a456 drm/amd/display: Add definitions to support DID Type5 descriptors
>   d7b618bc41ee drm/amd/display: Refactor DSC cap calculations

d7b618bc41ee3d44c070212dff93949702ede997 is the first bad commit
commit d7b618bc41ee3d44c070212dff93949702ede997
Author: Dillon Varone <dillon.varone@amd.com>
Date:   Fri Jun 20 16:23:43 2025 -0400

    drm/amd/display: Refactor DSC cap calculations

That's the one that makes my machine no longer work.

This is a 5K monitor (ASUS ProArt) connected through a DP connection
to the Radeon RX 580.

With that commit, the screen goes black with no signal at boot.

Let me go see how painful it is to just revert it from top-of-tree.

             Linus

