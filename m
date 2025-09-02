Return-Path: <linux-kernel+bounces-797327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEEDB40EE0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F4E700467
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D0C2E7BDF;
	Tue,  2 Sep 2025 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeEDUYwK"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDC263F2D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756846276; cv=none; b=AYeEav4hlRq6BiSule71tmC/AtszhGSHdGYV+V5H2QxQlSsVsjvMTJ7V6KAUCUNF83fx08SlEeBGRwYU87v/ZBvh74OS2xjraLhk7fVEOPXJSc5DJ7qggtE8wrB1P1bjA8KwmR9eeJwRo23Hhu5GUPn/a6HL8bJGoipWB8j61/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756846276; c=relaxed/simple;
	bh=65EvhtvipMhOdjygn6tHDJEsIHl353A0aFQlz0RsB+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7M94x8WsrsieIUQc0TK4lZOpBurGHkFbl1rOw21a2KcV++dKsB5OZOvAasmwgCJh0i0h87Hv7tlGCtP/YxMmK9c7RypLVV2D/jqXXmDN3QYRW7B6LMtmrZS8SJur8iVq7e3u0Z0D4DjmB24k78LfwT1bVE//33eT3nUrAPoNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeEDUYwK; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32b5d3e1762so192529a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756846275; x=1757451075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65EvhtvipMhOdjygn6tHDJEsIHl353A0aFQlz0RsB+8=;
        b=aeEDUYwK741OkfW+68ixPZhz4OQwmxNYEzqBHzd8k3WpL8Hmxia7wf1k1WbE35SuTQ
         8OdRI/B3ZfIdxg94IjppiRR1PtWSSef9lbPriqhIz6Sq7dSAaIOvkWyRC4gkZTX/rm2F
         /KvEMjmhg+z6pE2FhwCvCxaxH432tbvJLQoUovjaD5S3Or1VD44RiLtma8h405e2rYnu
         ILrswI76f8PZSme/VqGtUxThtiIYl2c+iC0InS2laQcqYAh84DrAHTQNSscoouZVE0Bo
         WRygqkyxRN1EDmfZp5EU0G8y98kTAr+EDBLfHZbGqmMouRYDTcGB3+scyOYlmJrusXB8
         goug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756846275; x=1757451075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65EvhtvipMhOdjygn6tHDJEsIHl353A0aFQlz0RsB+8=;
        b=jd6BcSh12UJmQscOFkEZt5l8mOZq/4teAbev5QmrAdka12uKN/URygTA2QxKDRmZD3
         GP0ebjybR6qyuQT1y61t61f5Dc9vQ5tftx2odd++MfvGMtFnxAGAoq6wGl4Mb8fUY6Mj
         mxINHam3wyGvP6VFT+/Ts0UqqeGWWGV2usWcRFHz1eNpDFQ7zXGgo4Izel9lWXI+2zGZ
         A2Vqt82WtrK/h9mmamx5nEpwyNvxf5SR+SWbfOa8fIXiW8fLOZxf0tpOuqK72vt+uQzv
         R0f2A4tVhWzYlYSIU9aE1ex2t0J/MfeCuUyhrvN9sHc/fqJkhrMQ3PGFWuD+f0E6TkaO
         jpVg==
X-Forwarded-Encrypted: i=1; AJvYcCXp5vZvs/86YRiRqYaVXAs+JSmQRgrZANnyvI4LT2/oYm/YMXR4CpxWk5fkL4M6eDJYHDJ8DSSO36rnqqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLB7CSJV/SmQVEuZlqE0/yDSScoMSPMOj6N7+55V/q6RQb/cn
	9P/LLPbCeqk3G+b08/dPBpO14QU8r8O2cgEnz8YGgHnSytoS2jKsdKDDbl9aoX+hxR4ZddnQCNs
	W7Q5nYGvQgAEAD53MmXE8V5oqTHWvoHM=
X-Gm-Gg: ASbGnctbVOaX/4rYA2olY8aaH4Gj78wwHSlHD+JoYoAqjqE4lc6j4ny/CAJ4QH6YqwR
	2dkt3/ulxqV/4NjlI5y3C1TJY6xtqSPX0Gf+ozEaaK7aVcBU18D8+jfQ7trtE3w6vEZcgSjAU/0
	ht1iB/yGLArMKXjdToYRWnc1BSMKhQ0yMxnSSRF6g3vCSe2nHK5OrhI7WPpHK5CsObeE33xW0q/
	YnGnpintg4p+lDTsPFy/cmO+KHV
X-Google-Smtp-Source: AGHT+IGoMSLY9lsTFPrOE6tSEpdCd5ie6iLYbodlIhPMnaNwXHeZCeGU+4uX0c9H+JAl0U/iHZdR/fO7RStqqoUApdE=
X-Received: by 2002:a17:90b:1dcc:b0:327:70b9:9d68 with SMTP id
 98e67ed59e1d1-328154551d2mr17853246a91.16.1756846274566; Tue, 02 Sep 2025
 13:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729174332.3acd1a86@gandalf.local.home> <CAFLxGvxZJv_A+YKCxVcd4yxPXLhHD5L9VzkvbFKPytxXc5vWaw@mail.gmail.com>
 <aKCLGvmPLPwjyw13@shell.armlinux.org.uk> <CAFLxGvwPwrG6KVsF=hKn1SmbC0yjLVjm6h8t1+qFE0GkO7rUbQ@mail.gmail.com>
 <CAFLxGvzcaGjNAWzCjdQdnOQjGPOqPg_VY2UBpp7Q6pGVBvAa_A@mail.gmail.com>
In-Reply-To: <CAFLxGvzcaGjNAWzCjdQdnOQjGPOqPg_VY2UBpp7Q6pGVBvAa_A@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 2 Sep 2025 22:51:02 +0200
X-Gm-Features: Ac12FXys35k1PMljuy9oRGh6uxKxmo60Bv_GaMm35fWBEQYYoeQIEqgC8yfWzDA
Message-ID: <CAFLxGvyBcaf76F=O2w7q7pJGEGLtS4GwgOjfN=vLV3=80CfWnw@mail.gmail.com>
Subject: Re: [GIT PULL] runtime verification: Updates for 6.17
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Gabriele Monaco <gmonaco@redhat.com>, 
	Nam Cao <namcao@linutronix.de>, John Kacur <jkacur@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:41=E2=80=AFAM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Sat, Aug 16, 2025 at 9:26=E2=80=AFPM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
> > > Also please check whether you're using frame pointers or the unwinder
> > > (CONFIG_UNWINDER_FRAME_POINTER or CONFIG_ARM_UNWIND).
> >
> > With CONFIG_UNWINDER_FRAME_POINTER the stack trace is sane,
> > so only CONFIG_ARM_UNWIND is broken.
> > I kind of expected it the other way around...
>
> I found time to gather more details, maybe it rings a bell...
>
> The problem is related to va_list. As soon as va_list is passed as
> function argument the
> unwinder is no longer able to unwind correctly.
> Unwinding vpanic() does not lead to a correct frame anymore.
> Maybe because of va_list the function arguments are passed via stack?

Time to post an update, there is a problem in the ARM unwinder.
When the last instruction of a function is BL, LR points outside of
the function,
this confuses the unwinder.

This branch contains two WIP patches from Russel and myself to address
the issue:
https://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git/log/?h=3Darm_un=
wind_fix

--=20
Thanks,
//richard

