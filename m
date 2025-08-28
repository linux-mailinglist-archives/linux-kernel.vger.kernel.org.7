Return-Path: <linux-kernel+bounces-790161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4D7B3A16D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CD9A057F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92333164DD;
	Thu, 28 Aug 2025 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="TkrjTtyB"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BA8313E17
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756390339; cv=none; b=XqJECgjI6RZvWRSRaa1nc7IOp1JNxVNus2Tvo7skGVjaf27WjVpdnMXWYwaLkclJkN9eOeszgwaFqapd7qS9PovrRyuv+ERAYLLdiJB3L5xax3p+bNIPcZ61azlX/L6c0t5CVH8puju4jmXXcdRqXlotits3FDMY6RMBsXWkplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756390339; c=relaxed/simple;
	bh=xGasVQTUSyANud2IQBdV3fHYF4iddxokxxxLGRFQefM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imKo1sUowyHxrc+JSM8DfZhCU4U2AAiaDSPVI80SMY23sv7gQkx4L8THJp2rxtfgkac5Y/dqCmieGQggXYfE1Lg8eizSVYvAydO3THWJxerEdpXvNciGo1kpN5w4qZ73fd+3H3CfiDhjzU9Ppzfo13UwERZVl7ze2tchuabGNmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=TkrjTtyB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so140214566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756390335; x=1756995135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGasVQTUSyANud2IQBdV3fHYF4iddxokxxxLGRFQefM=;
        b=TkrjTtyBdVihbwjLYeheTazM9a7mfdI0Ep7DEfUamYTw8M81U1S02fYli6OUQ2NHIi
         IKvB2r0/eHg6ZPupXOeFDoF2MKbBOE/7EAuovMXMgJvLyc7zWJetC45SBWkn76r8vNHf
         YteXV0k9J8R4MrbEqTdVTUMuFMjjeKVEq3Gn6BK/ip6zBaq4wGPp+JmGFKigll5saAoh
         LDGIQyxdHc0Pe0bk4WisRukzVf6jQJ4Rx5T0deYF6sxq1uKwqJCfAPFH99a3hdzTEK24
         767Pibij5vEJjyeHpYJierWaLPZFaQ7nLMO1sgRvVPkBUDYhsEUqZP7o2SMkOGgyrmni
         8hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756390335; x=1756995135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGasVQTUSyANud2IQBdV3fHYF4iddxokxxxLGRFQefM=;
        b=BXKJVO3CLRVT0d/cN50o/ZO0p77Ka+J6Lbyw+cR1r7qKzvjO0VqeKw+3RDqsznok6J
         rZmgPZtpV4oJZC2fKl9mbiYpKPvG++XNebvwba4KbGO8de9225mRdDgoZlD9E6L3uZjP
         3j6m0ULzpo5EljZZSsoiqP0G0PlHcJTBBdzHM21/Tuqa7GLen9oR7cx4dTyJlh6YXNsX
         3hCS3tpDDNyWNt8RSPGwpN0kFbr6cS1VVzDL6wci8io2S6uj81ROsWovylT/85cOSBzg
         aYRTg6pJx8kWztmn3uRSjtkg7KFeiJdltbCoTLRiJsGKlr1uU/zwstT6qlVj1Mof/YgT
         CYqg==
X-Forwarded-Encrypted: i=1; AJvYcCXW3aPUWjhXWtfAthqKd0H2YNbMT6TgYCf6HHNA79qIPIJzRphO/ogQHYcUCJ9HYi/VtFvFrzYBsD5kpeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtCT2uEpQiCuHQ55KQap4MO4SBGTexmcWwgZ6o5+7003OXKhj
	tCvyTLxQlYGN3L8yKQx4u2Etfh+GwTZaShgrJ4kMxhvJPR1ZN6KVgkWBdsT/D7YGfOdLfzJizRg
	7qw1JWJahcwWAEFFeC5WXjQQpIdCB7FhLBdDhCV4Bxw==
X-Gm-Gg: ASbGncvTJEwSZRB35YtJtoQFAtgF7meVyLVUesben9YXrOt0Y7CEpBXZnMOSRiic33G
	XvUQcuUEOuljb+F+ZMYYMVbR5QiPjcPug4fYY6AetaveUED8o5+b588dFgFHjhG4ZjSrl5Sapwe
	IsybbPwa2vAOGP7z95wXEx7i0eu+wtuAgs2cPE7GDD/m2hh4FKPLkeykZ/CvMBTKrmXWgAzmYMM
	ZdnoSuVx5ylioQZG6TpxJpsk1P0a0z3H30=
X-Google-Smtp-Source: AGHT+IFYQ+Zn1M6659H3JoC6ZjECHDpntiTMJRo82QHF+jENTwKdgEQHRcp187NWnMZQRXCgEoui+0Tl9MtmvbJvLxE=
X-Received: by 2002:a17:907:9408:b0:ae0:c976:cc84 with SMTP id
 a640c23a62f3a-afe28f5264bmr2173253666b.24.1756390334998; Thu, 28 Aug 2025
 07:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828130311.772993-1-max.kellermann@ionos.com> <c1f290b7-b4e0-4ec5-b60c-b1e6d3e0f21d@suse.cz>
In-Reply-To: <c1f290b7-b4e0-4ec5-b60c-b1e6d3e0f21d@suse.cz>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 28 Aug 2025 16:12:04 +0200
X-Gm-Features: Ac12FXxs56-Bnps1O6YH234WEdaH20xElL8cgETIZv7UvDBlU6oHboOZvAU_sQc
Message-ID: <CAKPOu+_TA3t=wbDS2mWp=WDy171YQqS6kR7AmSnpNpGn8cwnyQ@mail.gmail.com>
Subject: Re: [PATCH v2] pagevec.h: add `const` to pointer parameters of getter functions
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 3:23=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> Note that your Cc list is still not according to MAINTAINERS:

I did, but I did this on 6.15... but master has significant additions
to the MAINTAINERS file.

> Assuming you don't intend to stop here, a series with multiple patches lo=
gically
> gradually expanding the const scope would be better than sending a single=
 patch?

Yes, but that would mean more work, which I'm certainly willing to do,
but only if I'm confident the patches are going to be accepted. So
this tiny patch is a trial.
In v1, Lorenzo had expressed general objections to merging
const-correctness patches.
I don't want to waste time with something that's going to be rejected
anyway. I've been there so often, so often has there been one guy who
just rejects my work, after similar patches (by others) had been
merged.

