Return-Path: <linux-kernel+bounces-780829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B66B309DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C243B7F90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE7E2D97AA;
	Thu, 21 Aug 2025 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqYXcXHp"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907126AA83
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817932; cv=none; b=O9rEBH4kHEDRl8MYCksJruMoEfB3R3t1zfXNBOvpNwPCWaeUaPhsHFBvXplM9va++U5XG/S9lATpdSuQ6utSMfmww/28EjvbCnpClYYWzjuSLGG0Tr4h0RaXxNkZCLbFt+l51Afm90wRPPipW3V3xvtGbnPpeTEuA3E9SXVBuaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817932; c=relaxed/simple;
	bh=JIel/FR57SwJcaLONH4epvfKs5IZENednDBecALaL5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8ORNKXHKMScrwrUGkyIvkoshwNgBur5QUanPjqC6VqQ9+wYGXnmjLpjlOIBrtOj6wkETP5C5I1bV6PB/4m39R85x5pqMj5yM9A6x9UW9Z6/ILhBvgP6JRSxy3RL3CxCdyvPdD8P6KuHpWJQyPATWS8DhomY+Q9yi1s2dDw6lyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqYXcXHp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-246257e49c8so83245ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755817930; x=1756422730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIel/FR57SwJcaLONH4epvfKs5IZENednDBecALaL5o=;
        b=vqYXcXHp5JhOaiVUadP5NSpBdFBBB5wBmhejZKZqrHVeZ04B1HOlNYGrrnnM63shg6
         zRhNPcYpU14pHCrkb6r3KX1C0IqDrhv1k/h3lZ+nlvgqxS9kiMDkK9RASTPC2r32p4+f
         KBb0mdbNiTOhmfCxnWL6UmBZafrT3IAUx9A06p7JrpcEozj+nHwA4L4ZcgHCgm+jxRd3
         NfwaT98HGycA0yOA+5POUKdrfinWfZUb+p6L5VN1qNOh1SbjN5v8f63R161FAJS9Q2st
         gLbqvlMdsFnkqqkKZTRCuMP79Jz+N5xLgfYVXpwVUIfHgTpQBEYTGr6t2wZXi2nAcu/z
         SmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755817930; x=1756422730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIel/FR57SwJcaLONH4epvfKs5IZENednDBecALaL5o=;
        b=KL3HxmtsQFN2p9mF62dfxQhWQn3dvcACP0XrNg9dIb8lSo/0tBbY2qo6u7v102HMJd
         Yg+9NDwtwsKQgqMfGMQajAnK8q4cg0M086D7q6XRGXRHfnQ62MmZ8gDXOmmv0VsLk9oY
         /9aKL7ecuQ+pI/pNs7hO8tdsV8MgKf9rPWsTsFT3O3SpUerwAyAdZ26uMGO6ggvdK7O7
         AjfVpn7/U5l6uY4RKL7uQJvGACrSaMUc30zJt0Dc26tW4TJKrGGWLM12UwzAqCkKaAOW
         Z2LkhqOeg3ICQQP5w0YsRJxcC9piSCi7v1iZ+58XS0lE3VQWrrcxTK8EEpeSZ94XuwOj
         mAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDcANYVDeqFHFl9BputGTNwTd5e/fyaYoWQbkUcGvV8epdD4c5SJoYwGjV2ROyX0mfXgnRkwHw2AZa/0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhfDy+dtsVDLxB3ZvC6pezC41Qv1fcfaRRyQLAfGjfvq1KATtz
	E7hwBRJeuLGg6HOqqlyBN/uzVU2qMDxcRhb6h+/xRmDR1DiaVUg3/MGOq9JubD9PC63SB37Hebg
	TEdlTXG4VbKzGPfoqjUJGqQUmypN8Xu4OdiXsXE8d
X-Gm-Gg: ASbGnctNrwEoiXc6EQL4DF0ZiwkNsK2kcAq1P3FDBO0XrCOelIRs6qECaC5Bb/X+xMl
	BPAmzTgex1sCfheE8nXF6YmoB2xrDOSHgCmgLkxAXuVZ1xEojU6PG145DPLGFBr/OAfJmLznPLT
	DPRcJF8pjFHROXWw0Ov3HU2op6P2COis+0zvRRQXk6K0jtsPG+Hmy6SjibubGKh0Rg6QDgHMl3h
	o+xjdGzlEedbYzqz5iyow==
X-Google-Smtp-Source: AGHT+IF8QmYd0K/VI5mJAgjeH3O4OfadWqimUtglUq+qrkzfyXjMxzaiIIau5t02eTFPYvM/Nzmw/35u9YfJlun7tWM=
X-Received: by 2002:a17:903:32c3:b0:240:640a:c564 with SMTP id
 d9443c01a7336-24639f23c10mr767135ad.3.1755817929833; Thu, 21 Aug 2025
 16:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819121423.460156-1-petr.pavlu@suse.com>
In-Reply-To: <20250819121423.460156-1-petr.pavlu@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 21 Aug 2025 16:11:33 -0700
X-Gm-Features: Ac12FXzZLbDJuAQzCBqrbxADBxinz6u05a7iaZuaDPd8ioxW8irI--KZO5WfYzg
Message-ID: <CABCJKufX=ayzyb-0pGpLvT5ULdQcp6BeM06AVfLdEEN5-r4-tw@mail.gmail.com>
Subject: Re: [PATCH] module: Remove unused __INIT*_OR_MODULE macros
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 5:14=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> Remove the __INIT_OR_MODULE, __INITDATA_OR_MODULE and
> __INITRODATA_OR_MODULE macros. These were introduced in commit 8b5a10fc6f=
d0
> ("x86: properly annotate alternatives.c"). Only __INITRODATA_OR_MODULE wa=
s
> ever used, in arch/x86/kernel/alternative.c. In 2011, commit dc326fca2b64
> ("x86, cpu: Clean up and unify the NOP selection infrastructure") removed
> this usage.
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

