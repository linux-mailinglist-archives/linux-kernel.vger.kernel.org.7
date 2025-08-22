Return-Path: <linux-kernel+bounces-782044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA7EB31A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28575E3484
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F5303CB3;
	Fri, 22 Aug 2025 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cfqqVNDA"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA722DA02
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870419; cv=none; b=fAp28C1G3vDbWTbPJBWapy7jPuAm7Y4vP2RuPHpWTj50r/9qAZWr34tkLpdLdZ5vRoshPzXEnGSQu0Wks9cEPyyCf+JU2O9L9GbQI5fvXSG7TYBOrV9PEmiBCEiB+m9Sc9RrU9DvsDlXokTx6jMImzpeh4QyhPE7UFCPZ2SShcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870419; c=relaxed/simple;
	bh=APQoGb7oJHGZ6Mj01fq5MbAELxwQW2xj4Pe4Rxnr6cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5BkpPmqzH2KGtnUDxTRqQIW7MP8YDgXeTm8MZPNjp5WVjDndW4WPh148tjgt4I/c7ALD8QBFDBGiEuvxoPNoYxj+Y+yXrY7OaIpxDBgYEqybcThkUUiXHftFvvlYTa/+4+PKGE8qZuCQ47j/oPv2Fa/5DL4cZiECSgKoEG/Qn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cfqqVNDA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb73621fcso289641366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755870415; x=1756475215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NRu/0FoVw+bU0VwjyXzuUF8CXZhxspV/ZyS4JSE6Hqs=;
        b=cfqqVNDApQweNVxsxTjcec1rnyC2gDXuHW1AhM+piZbNswOinrpjYBqWWmU0mvna3f
         91vNBZWHQHi2Bj5r74DvRUFae28DY9O5qfTKrdwohX6QerdjMJtbeIYS9qMMt54m7H81
         LLhFzh/pugcCU8toxdu+jGQw7fNRuRcNY18xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870415; x=1756475215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRu/0FoVw+bU0VwjyXzuUF8CXZhxspV/ZyS4JSE6Hqs=;
        b=Y75GgU4cPWKOvkqhlOBzUFvhhIhTA/NBs+bGHfD/hnj/KSuq0c8OJocxtnZYgQnUPT
         uvIw7kTsLPBwr0Oyju2pqXp0tPwU8iFB779VjJwMX4uCvRmOWWQH5rVjYn2O0y4n9WwL
         P2zeb+ku/II3cbkwAiK3fcHFZ0KfHhFzfOjMkv66n/r/9smUEd8qajI8R1agsUmpYzB8
         tSm8lXQPfO9/xcrghasWWdLvZ9WGVharXlJV/14A9Z2dH3BIXWimPTlI1BjeQOUvQnsQ
         RNFS1PFlafgyHAQ4EP84ca/sqGVT9pX6IuK64+B+WT0NkL1IH6iNhLestp2zgDF0ieD3
         +NJg==
X-Forwarded-Encrypted: i=1; AJvYcCW5r41LtclbKQ9GrtOySUlBypwi/LTP0mjTp33DFfII2OP91sb8AzlRU4nePZkJkk+qd6W7NRwA9h9Soxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOSZqWFyT+Towi+8bsDoYgdueELQf/OuVHc/Bgpe347FSjIOqd
	OT0mqF1a77TgeTm9Vix4b6TcNEfW1NkQYjSRR5nYW/KrF+7ZoX+X5iCtRO/WAcnBP+TcUL25DTZ
	hWPq/sjM=
X-Gm-Gg: ASbGncvXgFrQFEcdq1LXWs2EJl842y9xev1N/cPghGwILXHZGh3ZdzwbXcVafyn6O17
	lFWOr22n0ueeFccw8db0c7IwsOGBOOnQCZAZYNLXaJbzpoeIIkO2mGiSGRQ5FnPpzf0GRcz0VkT
	G3woD2cqX/X8pgKvDQp4ytURTeK0kx9f9bXHPmrstwei1z0hBE4HuAHmsc+5r8eLMSYo8Xs3tPl
	255/LXO6Vdn/XUcVu27+4dPzU9m/2poPjYbBMgvpUEJkax7L2jcQlNH6T8yeyLiNf8Nv4xVFniS
	xGfI302WCGo+4M//RHWbhtQ65C0RkUeFRk77b3N8BIRXzuP56upjxhqtgSn5/+cKKicgT1HuN6V
	F0naiiecXNTpizHl7xTHokkTTI6St2H7M8L5G4gFjbyJNrRpoY2+cZJswVhYOjwqmTRPo1I1c1C
	zCOvaqPAM=
X-Google-Smtp-Source: AGHT+IEMPl+fOMrBUE8ahxmtwoCkYc7nOvyat6hgoljrYVfoCNDHZomy1CjpRbYqGG6C71uGSfvuyg==
X-Received: by 2002:a17:907:7f29:b0:af9:7823:620b with SMTP id a640c23a62f3a-afe2963a81emr238925866b.44.1755870415188;
        Fri, 22 Aug 2025 06:46:55 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded478d74sm610451166b.69.2025.08.22.06.46.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 06:46:55 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61c21e50168so908917a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:46:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNGo6gCLoW5XntJsajtJ2jH0TMDEk8DjoocLr/aDojtqKFAO5EyfYInpwkge+XIrT7rN4lZylRwNhxInI=@vger.kernel.org
X-Received: by 2002:a05:6402:5110:b0:615:6481:d1c with SMTP id
 4fb4d7f45d1cf-61c1b450840mr2274281a12.1.1755870414406; Fri, 22 Aug 2025
 06:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755854833.git.christophe.leroy@csgroup.eu> <82b9c88e63a6f1f5926e39471364168b345d84cc.1755854833.git.christophe.leroy@csgroup.eu>
In-Reply-To: <82b9c88e63a6f1f5926e39471364168b345d84cc.1755854833.git.christophe.leroy@csgroup.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Aug 2025 09:46:37 -0400
X-Gmail-Original-Message-ID: <CAHk-=whKeVCEtR2mQJQjT2ndSOXGDdb+L0=WoVUQUGumm88VpA@mail.gmail.com>
X-Gm-Features: Ac12FXyg7aT4BFeJsiyaeWdfrE2FPhwu5xUJIJ1D8_vj4L1z_hVeZFuzgKfsNNk
Message-ID: <CAHk-=whKeVCEtR2mQJQjT2ndSOXGDdb+L0=WoVUQUGumm88VpA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] uaccess: Add speculation barrier to copy_from_user_iter()
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	Andre Almeida <andrealmeid@igalia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Aug 2025 at 05:58, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> The results of "access_ok()" can be mis-speculated.  The result is that
> you can end speculatively:
>
>         if (access_ok(from, size))
>                 // Right here

I actually think that we should probably just make access_ok() itself do this.

We don't have *that* many users since we have been de-emphasizing the
"check ahead of time" model, and any that are performance-critical can
these days be turned into masked addresses.

As it is, now we're in the situation that careful places - like
_inline_copy_from_user(), and with your patch  copy_from_user_iter() -
do maybe wethis by hand and are ugly as a result, and lazy and
probably incorrect places don't do it at all.

That said, I don't object to this patch and maybe we should do that
access_ok() change later and independently of any powerpc work.

                 Linus

