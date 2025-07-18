Return-Path: <linux-kernel+bounces-737421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1435B0AC48
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D0617734C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6772224896;
	Fri, 18 Jul 2025 22:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IQqOd8jb"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18C2AD2F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878942; cv=none; b=BS9UXXQWtBsvbDhM/ECGUtsdA1ismoKnS1GiAHCgXF0kA0oBOBkIGFz5kA3HwoGnojnajjAT2WSf1qA5eIr9F26IO887iXVO11htSaSj4NY3vPHfe1gEdPTVAcLQI89r3pNnqBj5voj6Gf6kS7oExI8HOKTpMXA5+uHfn8YjM4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878942; c=relaxed/simple;
	bh=j5a0DZ468QzMrvyF4TXu1R8DhWG08C4AbgOqB1No9Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pS1mnELUj9GB/5fBrnGZRZCpvjn7f8vyO3VgYGuj/7ZKykO3qcFH/BExLSNrEIuS1hz6mH32S8HYe1IWQvU3oJhMgUSy1jIQtyC11cETZ12qVAyP3k7e53O1HidGeUpBt/i/aVZpYhWfmeh3Dts4V0Et8iSfC7zNJ7NvbF/840M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IQqOd8jb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so2191449a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752878938; x=1753483738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCekbMSEmyxIAVzfncRaEHsXG0dam6IEJBqPkNUa8Bk=;
        b=IQqOd8jbGkWpS5jXLTybWKrxG+S/FfLWQdKskC4kilDEoAPanQFX1ysI9doii4Nnki
         p5rk/hYUQEGegotwFpoAeXU9RlYW22EfGQZRAzMN1Vx8PPW4rNZ0oaFaQgTU9J+AYgWB
         XKl76gunpWV9ABpsmeOOHZZecWpGsd9RrnlJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752878938; x=1753483738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCekbMSEmyxIAVzfncRaEHsXG0dam6IEJBqPkNUa8Bk=;
        b=l3Qssc38cJP779p1cKBtuQQkhmeeWGWbx3Ty1dZzHKwTlhhYRP8pEKKcD9jel/a8Ti
         H1SbMCE6njanPwb3y27+rWHkHWH9VnKYTN5cwOmEjVPPUHt/qHm66kXIQ7g3Ynn4vzKG
         wsiU9g0dYLqvThqQ2OOP1+daI5Q5PfWRZuzyBfuXzdfev+e6+Ms5uAsvbVq6Kn4DzXeM
         j7MOAWKcNMJ6IFk+KBgyAgYojgmksnEZBiFpPB/UmUY7t66sgT6UWQUr8rYk3tsuinAN
         groGk9TkU0azMHCxjX0W92Zn+uzYXZDLaTg/7Aw7EIG+4o1pOSSCQDOE6MCGbhyK6Fvk
         ZLsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1d6nkYkDbjwkGcMCBftWGl/UNcA6rFY3AArfE7ERUueMEFaloAFB8YHM6lLdWomrtvSpUYaIh669KFoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCgmGFbNpt79MKCDdZ2tQaP5a3EPMSBHirZjK0DmbiwIcZ+2G+
	jWonlLufiBuSJLzR5ujdugzYhkV8GtVKALWKVdN37cGheyIveDeYddQZ9PeX47lB61OkV8JCPCm
	lwpQ=
X-Gm-Gg: ASbGncuF40czkQr4ljiTZdzTGpH++mGJwgWrf4GnZ3pmhTxoCdo8q5+GGXvj+Mp6nOk
	h75oBrLc1OARu/IdkFriZwPUYX22h8jCXJv7nxyFkmQCKzF7s+Vf12uh0L3/Rt1BDlNH2yGTCNv
	1bOUi7MpDp0ousI4eqf3qzoo/hj3LxmpIRgw8eSzEWutUA7R3g2Py6I73GyFfN0iCNHSUM2TUEy
	9UoM/3HYNjWqyW1I+8CHG7FZGSAEi5DMPZyLsdFJxKGWhBbf2MLhFAkRUvhi+ajuZkPNsA/exlC
	drFp/p04uyffRGHTwqo8JYPWi8OD2UEV6x4IPqa2AnbHe9/0/nQyUbofzR7/z1LSpsHMqdHydY3
	wF7xMiaGbPPtwa0MQFvaAcJnqxkAJqOPaBDYMn634ZnuSIcQIXgKqjNTA9n7QyTeHJg==
X-Google-Smtp-Source: AGHT+IH84S2AWLxh8+lVBZne8dbd03JALqRe+OyD/yfPJiE5KS5HEsuRDfYrd9S+HjZCEYgObVHweg==
X-Received: by 2002:a17:90b:35c1:b0:31c:bfb9:fca0 with SMTP id 98e67ed59e1d1-31cbfb9fd11mr7649698a91.4.1752878937954;
        Fri, 18 Jul 2025 15:48:57 -0700 (PDT)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cb0da4559sm2421175a91.2.2025.07.18.15.48.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 15:48:56 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so2038403a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:48:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNK1yNsd0qNSCLhcbR5c77DgQfBtu5PTGyHjeD2yT5H3pckqaspae5lIjOjceZ0CgX8VC+EyS504ENy2M=@vger.kernel.org
X-Received: by 2002:a17:90b:5307:b0:311:baa0:89ca with SMTP id
 98e67ed59e1d1-31c9e79bc53mr17025524a91.34.1752878935739; Fri, 18 Jul 2025
 15:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213725.348363-2-thorsten.blum@linux.dev>
In-Reply-To: <20250718213725.348363-2-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Jul 2025 15:48:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W1tgwvajXD6mcggHKy=Q7EN8wLx4nSJgy0NJBzHLBnSg@mail.gmail.com>
X-Gm-Features: Ac12FXxufG3DdfXgWkFesZeMyd_2GFfXRNaPb_AZ2xn1G3aBVcusp6YGrWqqY7c
Message-ID: <CAD=FV=W1tgwvajXD6mcggHKy=Q7EN8wLx4nSJgy0NJBzHLBnSg@mail.gmail.com>
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhang Heng <zhangheng@kylinos.cn>, 
	linux-hardening@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 18, 2025 at 2:40=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/debug/kdb/kdb_support.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

nit: Since this only covers things in the file `kdb_support.c` and not
everything in kernel/debug/kdb, perhaps that should be in the subject
line? Maybe "kdb: Replace deprecated strcpy() with strscpy() in
kdb_strdup()"?

Other than that, this looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

