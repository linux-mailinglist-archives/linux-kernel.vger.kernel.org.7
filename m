Return-Path: <linux-kernel+bounces-790690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48446B3ABC9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506631BA86F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B13429BD90;
	Thu, 28 Aug 2025 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CR25SVWl"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101362957CD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413535; cv=none; b=G4765ySGkueD+2wMgrwh6BDu6x0Ylt/If5sTT5bSqekDvF5d/Tf/VhBh+kb8sf3GWg7B1Nd4zgsGgn7RbMHARLvzgug+bgFrQx83IThxxXCAtGSbb7itmZPMrgxu6W6f8LvbOuC7eEoeLu4Y1mBDdtZImafQ0j+6nDk66Z3O7OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413535; c=relaxed/simple;
	bh=hNgqbG4EGq28u1EQouYSBUbpkt0arWTr713X7x0bHTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QslKlvRSCqOX41XKRv4OYRAOL6/ugTi+boheqdup566fv1uJcbJKPtJ8VJgTdwdDMqZBNM6F6Xop4MFexDjUKCdJPm27NxCAUotZi0FBI1dSmwAilMCKZEFL5SL8rcz6sr4tBLPNVYTlr6XR3V/K+effecTNnTyj9HGdOHmDzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CR25SVWl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7a16441so202718466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756413531; x=1757018331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JWiKHYlJvcne9jpaEYcqWHC8AcX+j8YMHCgi+HL4MNQ=;
        b=CR25SVWllkSsQngPZ/qI1RjWfYWrvLm8VbzPm98VzjwaLjdRjNwDd13FTpR2RX7pGg
         mPFA3EpJxQBjP7Tx3twUGOkFyDt7c6lozMJnCWiFxP8VsWrGx1D0UKnZ4ZzchndZ0LWG
         wPQnNeB7izcMgfmzzXMqDh8Qganz7MjmOuOaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413531; x=1757018331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWiKHYlJvcne9jpaEYcqWHC8AcX+j8YMHCgi+HL4MNQ=;
        b=CPWOCSZx+Nnmv7Ns5rs/UvdnWYRNNiHhgenNhsi1613XSNAKErghrZXTgZ4H7yUhlY
         nKkkfR4KZ7MHZbiYCMpgr3KPEUTqcA3igXmBNLfWg9OcWRIFo2QADsp9wZCJjSvq/OAa
         Wn6yVStcIi/yQleL5qH+z9auRbxkfZcqtJwyuPCzoXVeNMHEF9G5Oe3h5bVtco4N+/iH
         Jg06Sig4FKSU9htL7xlGyg6cRXEckvi9bDZj55a8rxPVOmvFLVxnKEJiQXVAtys8qGEG
         wBYiprFt3id2OwQpG8WTyKHkzDuFXYNIdCRHYpD2UQyjtcFuATXuO7dx5g3hwaTK4BZx
         x6ug==
X-Forwarded-Encrypted: i=1; AJvYcCW+WnzbxDUSMIm/arXqehlc13Y7SBm6M4kc0PP3+Hu5EAZS1F1MAcTu1puuJEjA4PiDkq526MJ7FeIwTTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoezpN+SxPiLrc6u88Tk83v8B7t0SOlBVboPWpWqSL4khHgZqS
	ko4pzL6vSrxPJyqW9s1ktR9Kzt6e/kLBLlBHY9foLqjicTffMjFgTYl1W8eFURNFDInfhd2A3VW
	bEnvgiLY=
X-Gm-Gg: ASbGncvm6Uyyby88orOUUegWoURoqJ185smZ6jv8+Lq31A1IchJC4UH8W4zX4aoV2cV
	/O0j/OHg/xWYqtiIinqra3Tk+iXxYJAdJyC7BUq0zIGM9Bkz8QtOCGZphd8UThO/9R5z6ddvW4J
	67mePe8GNqxrjMHeEOY4zrosYk1TBd9MDLWURswCxAfKDYiwdZJ+ybVnvm+93WfLsxjSrNFvZV/
	CBQ+8H0fC5/Oc3cHziOudN8wwRhpLbCsMQ5ZlW5lT/ZMk5lNWs5j3QdndHrUzs1Nv5kIhUxWZmt
	rfocgJEl6FWpClF1ZIzApfGNj4wfDTFvlSarO5kGFH/0p5H0PfGxyg7f5qgeCJCfIIwrJ4efxaT
	bIoa+93QetM22mKRT/Dxn/E8G65/sNacRuwvNBXdawnw6DEONMF4UNmXf/N2HCHDsRL75tfls
X-Google-Smtp-Source: AGHT+IErmr5k05BbcvNMfd7Hb8z9t02V7I1Sctc/A87Wm4xjs2H7+vc0HNsC7FTQSCAvP/epIsfN8Q==
X-Received: by 2002:a17:907:ba02:b0:afe:ffb6:bfaf with SMTP id a640c23a62f3a-afeffb6c4b9mr22580266b.3.1756413531201;
        Thu, 28 Aug 2025 13:38:51 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca3fb3esm40628066b.49.2025.08.28.13.38.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:38:50 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb731caaaso205872366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:38:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4Jg3pvFD/7EufxjlrzovoGkCaTrl3n5I10Aqf2o87uU16a6oK5cRdegdNRDumbTiUjZx0D0D8Cp0Wte8=@vger.kernel.org
X-Received: by 2002:a17:906:fe45:b0:af9:5766:d1e2 with SMTP id
 a640c23a62f3a-afe295f1a73mr1975930266b.47.1756413529327; Thu, 28 Aug 2025
 13:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home>
In-Reply-To: <20250828161718.77cb6e61@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 13:38:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
X-Gm-Features: Ac12FXy_trL7Swvm3pmfwOKxyHb_uZ8GQJCJzY2njmQb_NBdcNYF0cJIcpF5WXg
Message-ID: <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 13:17, Steven Rostedt <rostedt@kernel.org> wrote:
>
> >
> > That should be simple and straightforward, and hashing two pointers
> > should be simple and straightforward.
>
> Would a hash of these pointers have any collisions? That would be bad.

What? Collisions in 64 bits when you have a handful of cases around?
Not an issue unless you picked your hash to be something ridiculous.

               Linus

