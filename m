Return-Path: <linux-kernel+bounces-847091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F01BBC9D71
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1AA36353979
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A36D218580;
	Thu,  9 Oct 2025 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lANZmlrP"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92B211A14
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024689; cv=none; b=iNVgO39QUO8NgXE0TsIrK9QVNjf/jVhIhutZiN/KeeLy9mWDdNvZ8o3343t0RSDYK13dMrhtuLtsjcPzuJrlu5q7XJmVK/Wv8Y+pqmrZZpPD+qtgV462oQmocJmhVm60KTmgh1hU55jQuTd7sPs/d8gmsxZ3lNgCfJ1W80n01Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024689; c=relaxed/simple;
	bh=ISyXxX1CgQPxYK0n5WBhvNUsiBcHP1WQpSdLc5FTdtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6nlBGGnR+LxduIkKGybaIwTsiwVCBHEFkLWGU1IPPeMqeYV3cfut8aSzMnGjExpvsQSjMKyrxOzTLR3i41s4ARDr5jCfZmVv65BSHGR5PBWOGg3Hoyii51CnYVZNRZpHNvYBle4Oc+19YPqwohGbt4zR+5SYIRPtPLZFkSBRTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lANZmlrP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-269640c2d4bso1688735ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760024687; x=1760629487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISyXxX1CgQPxYK0n5WBhvNUsiBcHP1WQpSdLc5FTdtI=;
        b=lANZmlrP22CV1nc12xluFSHiQtQHbxQuv5+d/u4hEj7qpY/6BAD2+D9f4g9cUEHiWl
         XYBrhv+yQ8fkHSPS8KOiYmgO3MLRbXHzgFZyjhdePb1OrJld24pmFnGwCBNcpsWNbkhj
         B/UGqMdTBVAhX9ASyXt4ekNWOFqMGlt6pMqWqERK4TF2pAmTFgByjBCDY5w0Dhl7jzbT
         oKlghFvIjCaJOAqphdTH8HT1eZsaTj+QcTi9P5+i6CDLG8rWVQwFO4P6OzUs5JVRBXLM
         8a66CAltQGzVE/GkwQUSLxAxEUsnwPa7XjiF1Z1b7kUQEge0j54lRvyhlX+18dThS0Sf
         uCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760024687; x=1760629487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISyXxX1CgQPxYK0n5WBhvNUsiBcHP1WQpSdLc5FTdtI=;
        b=sJebxPf/Cw502E0XITO3YNAPFvihWxuDK9ghTVFv0TnbHO7m7H0lQPBxEZvzgc9V/A
         4+q9xdq/pORkRAnf9f2FTAX5Spfxcq1Vc0WNrVURqoLbfUlwHqbfD9TMl5u3FSisRQmo
         UeLkaR8st1pEjrhfwSBlkdkgdUUkYR/y0sJeUsnU3V/Jd2hRXHgVAD4rihnWEP9OdpMw
         OFlhcdt1PqLdJqlX1D6W6mOQvjfflZ+q5LgcwNQ9pA+OjfGEVSlk67aPHIL4ma5EMEmZ
         so9k1kwbM33HXWyXscYSvCnyqRHQjPtYUQG9W0dXEmLQ/5lt2JpcqxvYbihGocLCgkCe
         iBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX266D6wjo9mR4IGPxSpKumH/K6Yvv8FI2VeIuliLfrXhq2NX9BxKTRqt9O60GrAVxn41qMqZPGiD4vGjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyih7Fk1sCr4fOkS7Tdp6zWgNuOmcZ5T1ATPVizQCW4h1hZQM9F
	JCyacWv5pQNKR9pLPSf32IXvCv2whBy8n+O9E2V1AiSRXXcNPq+++aWuGLj3X7wHrN3qdaj35Rr
	nk9srDUWfoFmEiYnnjsvrdw6vposNv2I=
X-Gm-Gg: ASbGncuUjBc6+oiVtMDeS7MtxwxGlBujbzGgqEMGHKwBIIktTDWvFaIqtcyUbYuZVdq
	+7SM+qvCkOp5CTviqGBcYByv1kYrBgEbM1Reti2Uiidc4yhAYVcGv18UGdcvzYiNh80qpkjUKpe
	LpRR+auDNldE/EQpP8AaoiF/AwZMh4YSw034+AS9ejDEpL/T+gNMNqHULC5TWem1q/NipbP715e
	LVQqqStxXuzPsFcZD937Asu4kfN+fJwGGxwRHP0SoxP2/MY9CeSxEBhAOADp0Nn8Xb2UiKJYmnT
	sUQV+/wMUsAWRVs8r34u3p24sMMp/nB3UKLGma9/DdcSG7tuHQ==
X-Google-Smtp-Source: AGHT+IHVY42dVY/s3HGPNLm0YmAHrBSIuu8RB49AOjXxJqjSxRVehbPuC5RwOIEYcZqeiz2UmeZxv5xyJOuu3t5xZwo=
X-Received: by 2002:a17:902:ea08:b0:28d:1904:6e77 with SMTP id
 d9443c01a7336-2902726698dmr56840335ad.3.1760024687272; Thu, 09 Oct 2025
 08:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008000816.GA1856596@ax162>
In-Reply-To: <20251008000816.GA1856596@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 9 Oct 2025 17:44:34 +0200
X-Gm-Features: AS18NWDb2NjPVihD4F9J0jmsEojiUL0B8kovxxb4Y5UBQmW33TKAOCsYHpV-Q-0
Message-ID: <CANiq72kgceVgcZnBzCTpJytb7GhjNWGVJR=4mexo1vtu3cAyXQ@mail.gmail.com>
Subject: Re: Prebuilt LLVM 21.1.3 uploaded
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 2:08=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> I have built and uploaded LLVM 21.1.3 to
> https://mirrors.edge.kernel.org/pub/tools/llvm/.
>
> If there are any issues found, please let us know via email or
> https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
> opportunity to get them fixed in main and backported before the 21.x
> series is no longer supported.

Thanks as usual!

For a build with Rust enabled:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

(I have tested previous ones as usual, e.g. 21.1.2, but I didn't get
to send the tag)

Cheers,
Miguel

