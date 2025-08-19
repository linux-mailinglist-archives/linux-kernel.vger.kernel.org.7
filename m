Return-Path: <linux-kernel+bounces-775650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 914FAB2C30F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3834582749
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B398A33CE80;
	Tue, 19 Aug 2025 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="g//SJZfa"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD032BF3C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605805; cv=none; b=d0nXrG6VCRmMfKmOGRL1xUnyaa/pouXRUHTHg1utvTf31nrf1v3kBhnI4JwYgDTryrqx9h2z99w7yLDD8vlwOuESnWmg+xnjpqtE0PhV6pCekhDFIJC+Tt9sk3zJX+yDoa4uXIeoMGY4wgb1twYxgaM8DKkLXr8MXhEPhJayIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605805; c=relaxed/simple;
	bh=+UdqJ2l0+r6uRordgh+zIkF9ttaFydJUFmIeQFhXjI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tyzqv002lOQkAM3o/3533/zI9L1+AQnYhf/aY8LDZ/u1sC/WC1v0u9IhT0Nu6gMwkiTTswct6T/BKarejDOD/ugFEkXd/ZzpFrbjbM4eQe3NhcFIo+VbLFlmtS4n0XQXWStvsrUkqK/8xAi6bojUb031zMbRQi7UK8t+YJhsfG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=g//SJZfa; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-618adbeff22so546191a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1755605801; x=1756210601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMlwZjg+BwGuKg1s6kTEEYqgJZl+nDMkdFkULY+5kpU=;
        b=g//SJZfarPbx0ievrhtGEGp6QqRctgkj5zeD0HY5UXzS5vYX42u0mYsKlsSNA+M6hk
         NFYAGgL3t316tteZI1fDo7bMVEsgNVhZL69NyJSDg7TD+wGBuXUvlDCiaNxvm+GSLgGp
         IGSbYX1pFRLCjnhboZbAAPVr4JxC8GxCMY2N1VLhMa9eLOBGgNGtlDArLlNf8wSYK8/E
         NkoozLr8yIoX5wiY17xxcVPOqefin7bVjf/t5BZKqmOAp8qVxXV3QKUFG05Wb2sPM74B
         unqDJUBQTgdtuJrUsa22vtUFyJ7fAjp/+mlJ4mmnvHapSfxZmOCnQvKDv2OW1pm96n/+
         aALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755605801; x=1756210601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMlwZjg+BwGuKg1s6kTEEYqgJZl+nDMkdFkULY+5kpU=;
        b=eb63extvC/AsY6CsC2DMQJKR/LZCZCgxi9A8KqnJBbUgJlJuTXcmLoP20C+HT089L9
         V0fJFgyxjuOf8v9tv505JuPJNm3PhWRUhzdX2NRKzLRpJTiQscXNtAP3dlUqjFt33/M/
         Vi4DUn77/gZ1RESjCXwXSVvHx0Kz7P8VDYrEXY1xvzcgRJt5wobgCbVgjaafS2X314YS
         0SbKgmICdBkG1hPXKJy4t03aweclH28mOQCy0Lo6cEx21jHopKoFLNBt7hFjB5ebFuQe
         49ry/AD3eMHEAcJ9IfBr8ZcBxTtUodPA+GrUlFoZK0kFiomgj4ImQXglykPkRCHVJ8Go
         clxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwu7Wknnti1sEGbFbPr4eiFe15iTIZdFCuHfhEFIr14simNePfM/DBmRZh7KoJ+6q3WDyqeKou3n0lvF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5shkOS+mQZNVZy7urlFB+6AJ7wZTqvUWgoXO/xuk77wOwJ1hE
	dwANmJkEvrvDx/RGbpeKoIDSLSLm9xEvzokserxyk9U+MPjgWivs+qn44wRVjP6KD+b+eyqZt/H
	BgZjpd24VneanJx2sOT0tDLV5OOJwdHzE2QHCaLowAw==
X-Gm-Gg: ASbGncvJBXpMwjaA6PomIhUquVvAmJUcw8AhbNkNon6lTDlI0JWtAzCkA5d40y9+Ee4
	L22/UJUaALRCKzTDCQ4nsnuj9wq4l0QNdfOuwg+jlt1yyyZM3aG6GLkBAFQkZl28XdSHowSbubm
	99MBqftQ2HY5doi2jAk+Ea4O9zxn3M1aMDvGo1yUjp+xqidLnjrbcg1XrqA3k3RuiL5iizgnqqs
	WdZgPYZoz/WXo8UjA==
X-Google-Smtp-Source: AGHT+IFVPOJnpawqYW7dgmQm05ygm+o8VCZKwSKrOr4m0ElqSL/2bgxkgUBv9mgR5/NbA+QU7vlP8i/6O4WJ8B7wxWE=
X-Received: by 2002:a05:6402:13c7:b0:618:1835:faa4 with SMTP id
 4fb4d7f45d1cf-61a7e7431a0mr952736a12.3.1755605800879; Tue, 19 Aug 2025
 05:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMGffEmFm8wvgiw+s0ZpOhRxBLOz3dQiS=sQCkgJLD6qC3VwJg@mail.gmail.com>
 <20250819105527.GCaKRYH9VnQaVdl7gQ@fat_crate.local>
In-Reply-To: <20250819105527.GCaKRYH9VnQaVdl7gQ@fat_crate.local>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 19 Aug 2025 14:16:29 +0200
X-Gm-Features: Ac12FXyi5L7sFVX4UCj_Ji2kWikgHR5CHKMJy4pq_iRmfKf7TcnG4_KynvPZ4bc
Message-ID: <CAMGffE=+hhf6EXCVYo+tvdUKN8B=uEtjkTpo1R9PXN3HycXG-Q@mail.gmail.com>
Subject: Re: [BUG] amd-ucode 20250808: "No sha256 digest for patch ID:
 0xa0011de" on Linux 6.12.37
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-firmware@kernel.org, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Boris,

Thank you for the quick help and for clarifying the situation. I
apologize for overlooking the information in the `amd-ucode/README`
file regarding the required minimum base microcode version.

Thanks,
Jinpu

On Tue, Aug 19, 2025 at 12:55=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Tue, Aug 19, 2025 at 08:14:50AM +0200, Jinpu Wang wrote:
> > Upon boot, the following error is reported in dmesg:
> > `microcode: No sha256 digest for patch ID: 0xa0011de found`
>
> [boris@zn: ~/kernel/firmware-linux> less amd-ucode/README
>
> ...
>
>   Family=3D0x19 Model=3D0x01 Stepping=3D0x01: Patch=3D0x0a0011de Length=
=3D5568 bytes
>     Minimum base ucode version for loading: 0x0a0011d9
>
> So you need to update your BIOS in order to be able to load 11de.
>
> HTH.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

