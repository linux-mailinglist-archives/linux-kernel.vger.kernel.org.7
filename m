Return-Path: <linux-kernel+bounces-824955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBBBB8A8BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4B87C65FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69612321271;
	Fri, 19 Sep 2025 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1aS3p2K7"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FED81BDCF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298938; cv=none; b=hy48VBFTmJzOHcXJTPGloSw6kXni4B/53Y1fW+be9DU57hmVJIsMAai0e5fQY53PIuuLkFOOibu6hY/2b0iqoh+kx+QRstyB/VOmF9jdPbef31XjFU1WVLwZLNjNoebOzl1T4mUCZauhAMNrygEIr98qR8xBGXoV82BriXHQBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298938; c=relaxed/simple;
	bh=SR5J7VhzCc3FdwtjoGH5nZbj/8qB/RWMHAcPVUSZcAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hx/eF5itBHRNxfajE7skvJVq9hCx5nB/6tqLMdLaqYngyCbcaa9v1YaoXFFp0AxJYkuvpOkl5NQ2+oE7EgXMUG2jUsNhMrJEaJkRM0cb1Z/lkrkxn77dbv0AVPmPrYiiDpiCqfHR81lG2M2PYjRst396MZKk56NrnFdx/PUYf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1aS3p2K7; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62f9089b957so12470a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758298935; x=1758903735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9l6sqe5LvkU2B8zsnh6dYkNJqPSUF1OCEWK4jmvgrA=;
        b=1aS3p2K7BLy4KvWLbudhmLZlSPoiSBYh9oPrvfEX35hrnXzAB8HDkkCVvuSIy4Z9KH
         dJ723jgcZen00OZo7NRgWK2paYsp3iHobvvyw+MnpE0NnyBu608JFpUT/KV7nnFKL4b9
         fXNqvm0G2/lo5WR6OSuzMTU0RYwoF0w3YpVmsHRxCBIiEaccJpLcfLeisqKKfncWSfH3
         yD4x2ZW5dSDP65pxQ2iO5htYpFXgoQpGk4i0IAO/Ttco2+lH7VcWoRo1QJmR7/nN4ocJ
         TDDEKhqyXHeKxx7lzI7bk5IowZGKXwxvceei4HPY1P5RUwsi3sVk+8A5tPW4UZxsPDYD
         MA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758298935; x=1758903735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9l6sqe5LvkU2B8zsnh6dYkNJqPSUF1OCEWK4jmvgrA=;
        b=G/sBN22YIQzLdoQPyPZ67Gs7PsU6RsSSS7yl9WNgc8uKnQlF5ulquQZTSrcVjEv25J
         8D8u7LHX72of+91albgv+oe7N9tMM/MAvkk/7cIFqllocUSVnm+CTeusrB1HaANge+ct
         TBtIuAh3jFvYw/2dn5FT+S5eYfrN70JrnwuwjC+810Qp9HTR5AlYpCVR2B3NeAew+lE/
         tAQi59fovBdfy1H4Mg+LPg+O/NoYxj9EdUQ0sVSIO26TRUVUbLEVFKmT6SfbFh/njCsw
         +K40iz1s90nIlAXEYrx3wsKAvuUQ9bvkMcOA5e8Qs8uRmphiOseGHljhmDDvrYb+Xlxq
         kX0A==
X-Forwarded-Encrypted: i=1; AJvYcCURJkApH2G3veeLk58XdN0uAK6JHy1bf94LATUDxpHMCnhCB9tnxIT6Ck8/EDeBnxEMglRC7oxCAqB8sco=@vger.kernel.org
X-Gm-Message-State: AOJu0YytHl+BLDDLGSYI5j+3CMDM8ouEJ8wxZJz/IG+mQxNe0CI3+a9e
	LjoS/QLxdGWPozWpKEi5Hivmgwx5N//ZXEDV7v9Jqv038dVZuwBfBruB2JF7RSwiXZpPUs1ZW2L
	h7uUf0VaugXBQxufuLDOjpnP2HbdnpRN5Bi1lZ+5AqWPiFBISedhBES6U
X-Gm-Gg: ASbGncv5Lbf4PkkclVW1wnhAqjDXhxoz6gljX6RzxjorTW0xevy7ufCIK0vJObA2xzc
	+TSADWXtAy5fqoQrXrUD8O3vZAN6sfUJ3kUDalvL6FChELxSNGNgmdclPyhQ9UjD4nJT2ptFiiG
	JpTC1n1PunGKv7lQnU5M6dT8lIxlVeKnFyfGxQEP8TwxL0jUWZkRZEFIWU0btXFvvzn/frkeYmj
	H0EhAE=
X-Google-Smtp-Source: AGHT+IEki6kFaYkdwz4WSdg/isMNBNiUn6MQVMt6kgGcAwbfnheSmWubbtiKX1h1K4NJX5zmFQcb2TfvOT+CGTZoQsA=
X-Received: by 2002:a05:6402:28a9:b0:62f:c78f:d0d4 with SMTP id
 4fb4d7f45d1cf-62fc78fd2b5mr51497a12.6.1758298935262; Fri, 19 Sep 2025
 09:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919004639.1360453-1-seanjc@google.com>
In-Reply-To: <20250919004639.1360453-1-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 19 Sep 2025 09:22:03 -0700
X-Gm-Features: AS18NWD3n-txkVWiqPHOd01wYLhU4hOVNE5_TggBK0XwCNJa9yyEjXsAoqyqlIw
Message-ID: <CALMp9eRAqb0HSt_kpWefUuYmcdvqohBzdx9EsurRcA9o3SfqpA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Don't treat ENTER and LEAVE as branches,
 because they aren't
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 5:46=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Remove the IsBranch flag from ENTER and LEAVE in KVM's emulator, as ENTER
> and LEAVE are stack operations, not branches.  Add forced emulation of
> said instructions to the PMU counters test to prove that KVM diverges fro=
m
> hardware, and to guard against regressions.
>
> Fixes: 018d70ffcfec ("KVM: x86: Update vPMCs when retiring branch instruc=
tions")
> Cc: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Jim Mattson <jmattson@google.com>

