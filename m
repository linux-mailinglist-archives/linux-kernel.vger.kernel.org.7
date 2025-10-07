Return-Path: <linux-kernel+bounces-844621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37099BC25B9
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE9FC34EC2B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516562206B8;
	Tue,  7 Oct 2025 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHxdyEQE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F52192E4
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861147; cv=none; b=DSGC0wWwSo+mdarKAnbDQoAhJXoBC/ewMkwK5G/C/eyhXnblVbVv/xg7Kst1w8u8YFT+EgTWcZenGQwMc+CubzcucQ40oD2aAYvspJYgjjRrHH8jwOICusT7Y2MBoViA4svHisXKNspx0p6bcdj1H1tXEjX8VCVuZnvPkWMvtmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861147; c=relaxed/simple;
	bh=1NYA5NXCfUNHGAMPIDINqsi5FPnYmleHEw4ndZr/cwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ba5d/2xyHLPpFu3Bgn3aWfpsa7uHVGiOzotpE43rwa5/MZroKNHMnS5GLLyWMSTC8u/EQ/xSWrskDW+TzGmzoFUXVRJgX8iayrvMOKRmDQ4/S5DrGFk8zWl75F7F7jE+NZxbn0DcELFChAT7gCUptQ+u3QlViCtVFPVJ83xb8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mHxdyEQE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-28e7cd34047so55250985ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759861146; x=1760465946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1NYA5NXCfUNHGAMPIDINqsi5FPnYmleHEw4ndZr/cwc=;
        b=mHxdyEQEgPnwtacRM8k+mQIM8hVHqzxEohkD/x0yzUibemQtNRuqIwKpsXoPvvYJ6H
         O2YlkM/HZ8HHC9dgd1Z6RlN/uKZ5fvERHT+VpTtP1+PAuwOLq2CJM4maZDZ3rycdKnV0
         GN+9ZBZ1uw9RYM6V+73MZs23mPaujFhxC8VDHEAHyi1GFZX+umxMUNHEGpainfOjZ1S5
         E85btdjQ6UB7zCXKymOH8FdFOl7Rkf0qAmcDMhuCtkh9ZcFVp5WyRkrM0qgo6qqsfDD8
         SA/jNVy01j1Zge5ESU6WacilWTC/dUyN2yjXkroCe57N0iJ1oT898V41Eyr1d3jWmJKX
         VePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759861146; x=1760465946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NYA5NXCfUNHGAMPIDINqsi5FPnYmleHEw4ndZr/cwc=;
        b=ixlc4+ZU4nKAOmtPzWe2L0fYO//WjwQ+/FZsvG6PAbzdNHgt8Ty3HBtSo766ZEtAFl
         3liSbJuS7cWrLfo20z0olBpXhk5NuOAjuTzQtymBRMLsFt1TeDyw2wTLEEwoA/xQzjix
         5Fyjz1yMdlWMoowcW+6iOe4TE3Gq9h3J05oSF+w3uN5sqwrgwiCaG1V+TpdH/J6QY7iL
         gZbhEgPZ4iVdjTo99yCfRXIDFDMQoePhShs8TSSBBM7t8HDpMXB7M5FptEPJ0s2pTHPL
         OOHCmQkLeyr0ZeDLvzww1xcN9sq5VbwW79X9s8gesu80WFqfsLDtdOJqevdzBhBFnCir
         tFlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhpt7UVf7aZ1rL/A1EUaKGvGLuDBH6gu6pFW0XKiH19YR7RJmcYFGTfofVehCNrrnhljqAjERUx7xmDoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT1hgQAI8tOGmbC6N9qk1CSXsfcCXGHOFl92oYz/CXPaGTrEVM
	M3rOKYOhgrQpft9t/7fCiADawTGYNp0cuJh9LxkWmroX+eUoISa1mk9htlsOeQHT8FyWMWOpJC/
	X9dX8mq5PsewCLFmbKL/tOGYWwf+FIsYgPjDOGgP+
X-Gm-Gg: ASbGncvZWZSBUD8hlrpuPk45apbY7Yw1uk/J2d78ZoMC6kttSHk5yoMjC0K1Xe+Mm+i
	iORJjzI/9tNS7PJJI03UgK3kfMWOteWXc7ejiRdkwV4JGsbTf3vecAIEpxLhT5VmHCFrYohvDet
	myXKV3iJ1+7oNMkGoVB6lIgRyVIv2WTE6ZaxmccAZX6fTXxet8ZxTaFTTaTLe0YWIFiA6TG2fqW
	0aCqHItPhZsu4DwUu2VzqJS9Eo3mzsZX7u760I5LGk7xuYCeqqJPB4vtSQ968NIIXpjA8e97SnN
	SV0=
X-Google-Smtp-Source: AGHT+IHw6dFIKAHzPTv9mVtUGHjBlx7WlkdXf8MR1ZgGcxSTfN3zEfUpxsIIe3xlxd6CYLBEcLBlT5+Vp1Gkw1TXYKQ=
X-Received: by 2002:a17:903:2343:b0:28e:7f50:5d80 with SMTP id
 d9443c01a7336-2902721336cmr7056975ad.7.1759861145158; Tue, 07 Oct 2025
 11:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315025852.it.568-kees@kernel.org> <20250315031550.473587-2-kees@kernel.org>
 <aOR15Xb6DfolYM0z@casper.infradead.org> <202510071001.11497F6708@keescook> <e019c59a-ba8b-ec04-dc5b-923cf9dd9d9c@gentwo.org>
In-Reply-To: <e019c59a-ba8b-ec04-dc5b-923cf9dd9d9c@gentwo.org>
From: Marco Elver <elver@google.com>
Date: Tue, 7 Oct 2025 20:18:28 +0200
X-Gm-Features: AS18NWCHLWcuBl7emRjgyAd7xCJevIo8qneqm5GOzEKlmO2F3nZsj3gxx6OmYQU
Message-ID: <CANpmjNMsSGY+QEn=GV8S2sXuuQsioikPR+OhGa3+6EoTqYPkHQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] slab: Introduce kmalloc_obj() and family
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev, Matteo Rizzo <matteorizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 19:47, Christoph Lameter (Ampere) <cl@gentwo.org> wrote:
>
> On Tue, 7 Oct 2025, Kees Cook wrote:
>
> > But all of that is orthogonal to just _having_ the type info available.
>
> iOS did go the path of creating basically one slab cache for each
> "type" of kmalloc for security reasons.
>
> See https://security.apple.com/blog/towards-the-next-generation-of-xnu-memory-safety/

We can get something similar to that with:
https://lore.kernel.org/all/20250825154505.1558444-1-elver@google.com/
Pending compiler support which is going to become available in a few
months (probably).
That version used the existing RANDOM_KMALLOC_CACHES choice of 16 slab
caches, but there's no fundamental limitation to go higher.
Note, this mitigation is likely not as strong as we'd like to without
SLAB_VIRTUAL (or so I'm told): https://lwn.net/Articles/944647/

