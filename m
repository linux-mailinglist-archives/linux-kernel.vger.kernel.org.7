Return-Path: <linux-kernel+bounces-739816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C67B0CB65
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8B91AA4D95
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EBA239E96;
	Mon, 21 Jul 2025 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAhgpGlG"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110EC2236FD;
	Mon, 21 Jul 2025 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128801; cv=none; b=f19PjLFUMtk+dNTKiuOCQ3SG1wJN1eb+A9fK4GUanqxChmSyn1dZK1y3JNWiJ0gy1/MoIfxsQZ+q8ic6+rRAPF9KdSYoWDTJthAx8nIVZAk0Rv9KDCKQOWCGv2YwvxyKrYmtiPE6oqpekCkKCNNhuH6M/PhJKuzIYBMnkGwOS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128801; c=relaxed/simple;
	bh=la5LQMHSf9dwPtEfGuezlYjOUEGcVnsf/mlUepU+B1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ei2Nz24wMJJOiPr5BtPMkw6uQNLi/t4fz8xe/8ib/DKhL71yR9Jwv6i1YOserPts3ACXDhEmYIXpF7Zt61SYpGsxyTQdXvy/VcaYitVnDoavX9fwzbTLgDh/XrF/QVPP/ZlkKw979wxlYJsFU7o1+QeKc1HBDh8ukpgy84pQJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAhgpGlG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2355360ea88so4766165ad.2;
        Mon, 21 Jul 2025 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753128798; x=1753733598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la5LQMHSf9dwPtEfGuezlYjOUEGcVnsf/mlUepU+B1A=;
        b=PAhgpGlG16P3ERuKfGfLdLLaaoU3SZSkBGaKeZVmI3Gew5bfW/useObY4ew4BOcqzg
         BqhQk63HMDSnwTX5DjphPQnUN+DYgp91cMzwWmh21fNQCcZZboDD18ZE9k+zpfXay563
         QBEIP4CBYCDSftX+vR+m49zJcK7MPRIViVcNHalHAHDyzP+mqDCNZEeLUtTGRRg3ogyY
         H6Y/ysXSfk7FqyaaJvfzD+GHg09Nmh/Ut7LE0ny0MVFh4USZKVN2GusCLioJRkCiAGVK
         KB3NsfU02GvudHO3w66Yh49XVfh7Pzzb3g9ZayZhfxWySJfIbpggGsEFDQ9aAq7oTuIj
         c5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128798; x=1753733598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=la5LQMHSf9dwPtEfGuezlYjOUEGcVnsf/mlUepU+B1A=;
        b=UurMP/vsnqghrdcK0rQCQy82RqGldyjSuldmq9Lly3/Ab11R63OPLWKx3aghfB79Eg
         N76TMgv9XKYLu9X/3Z/Uvn1mbbpKq8oJmL9BE2+DkAMKZdd+xx+qBj80szNLlin6vs4Y
         9LE7OQRCa/OEx+0peWR22aA12/TS2inGfSWXfzUQwkCJ3/TvpkJlJmoL7TOU/kCfdKYv
         DGKHu/Azkx8CmvV8MiANH89QdyftWOUp2Asbm/JUjMX8ERXFjLBnlIDIg8nindsKgktb
         qY16qAjNEuTeTtbloXMDDUSq0kOExTlp8DHk9zYnTn1OGxv4jLUYbJ5gEKISE2ND3uEU
         d7xg==
X-Forwarded-Encrypted: i=1; AJvYcCV7hnxIDr4lMr+CiNAMjR9jNCxSyHUahi0PA+6JEAqgQBCYqJsiuZp5jkxYZJSpTSWkUBpVRFM26JVgKZPy7JI=@vger.kernel.org, AJvYcCWY2m2/qG70+YTmbf7q/M2IrboMAGfN6FigyJcEF5qgbmrOVyr1iyAb/nUfd8RZ/K2YTjHGhJ5xtcQElvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/cxsL6ynpOht55uLOIKFKLrfYlCF4Ibo3VWg0wJbSAsWgEUe
	pLHwL9ahtgLLy0VqnEgTUXdLtb8U5SJJJ6FfZ524oo/PMs8uQBi2pHc9kcjXbmWoXYUpwxSbrUy
	VW2cFrdrvOszeCDjatwY7IpnJbejo4gk=
X-Gm-Gg: ASbGncuTBEPeME+RrfGcU1r9AHjJB0X1sXdYjly+dFgjINjuScXupxXnVRB+BxQMafE
	J/lOTAfUvdQLu1zC3hjWTfqaqO+YGMbIGnGSLZzVss6AmV/8pg+NAkpAgS8nm/IRMnUHe1P6kiP
	1gXNyw3JK2d890yErqcNaN8AWNpkp6MsG8mYOLVI61XXYSqQRypz1/QTMVPiFSQabvIgRGWUn3B
	0ZB0Vdn
X-Google-Smtp-Source: AGHT+IESxN/8maSvQ3FE8zGtNbDZxmYPvYZ6CIbNbI+MwSZ8O3Car33dPWCPqyjmlw72QFrdTgwYpToCDUNBtFhpo5A=
X-Received: by 2002:a17:903:166e:b0:234:f4a3:f73e with SMTP id
 d9443c01a7336-23e24f4f229mr124108655ad.9.1753128798207; Mon, 21 Jul 2025
 13:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720094838.29530-1-work@onurozkan.dev> <DBGYNQJJ0JI6.P280ZLVZUSO6@kernel.org>
 <20250720181721.54ab9faf@nimda.home> <CANiq72mv2yiJW_AD-_F1JUP2QdJKGGg8SqZ5SgDWT2xc_tpbZg@mail.gmail.com>
 <20250721091358.7dda6b31@nimda.home>
In-Reply-To: <20250721091358.7dda6b31@nimda.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Jul 2025 22:13:05 +0200
X-Gm-Features: Ac12FXx_d0P_BEjq17kEixmAKwgkn2-E13jX9861wBHQ2v3lFk5Ue23_wjO7FFM
Message-ID: <CANiq72mi5H1NCGHCRtkpriH=a_G_a_Vuf6edQ8=U0=hVJc=o8Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] rust: make various `alloc` functions `const fn`
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, dakr@kernel.org
Cc: Benno Lossin <lossin@kernel.org>, rust-for-linux@vger.kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 8:14=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.dev=
> wrote:
>
> I thought it had effects similar to inlining, but after digging into the
> assembly output of a simple program (with and without `const`
> expressions) and reading some related discussions [1], it seems I was
> wrong about it, sorry.

No worries at all, and thanks for taking a look into it!

I think Danilo will take this eventually through `alloc`, but it
sounds good to me.

Cheers,
Miguel

