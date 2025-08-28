Return-Path: <linux-kernel+bounces-790744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3221B3AC7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C099820522B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57512BF000;
	Thu, 28 Aug 2025 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fqMyjMyG"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D02BE7AC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415223; cv=none; b=DwTy45zhaBN0MqsTrjYNUGsuQV/yYqvbGrR1K3t9F14rqXSwo6ejgGdiylK0jbkV1io6ef1YVj9r97OyCQhhBDBmY6LAxuoqFROH9rlYjekhAh0IOpYHFfOyxUyZA6MXFQsw7975wQhem9D/el0rkUHwndNS0j/YL9nKLEkfo+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415223; c=relaxed/simple;
	bh=cWHgJuZ/T8lTpVPF9prtZYdk90QnV1fPX724zcPnR98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXWmk6cwij4pu0eWKCvxgtU/QFioeo8mRF9ZPGoD8R+dAchrQdhl0h326x9dKfvXQNV1gdge4DFY5D6pfGNAaU1aAfs2/dWepHQry4Y5BHGbJSFRmNx+ZTplc/mGrXEhvau6XIvfkwYJzV32J8rVNLjxEgbgO8IxZ3LtCED6h+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fqMyjMyG; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf0dso2322232a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756415219; x=1757020019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5t8lKSzWiJZ7o8aEHR2Vpuj8q+DwYY+2z0chiLgF/uA=;
        b=fqMyjMyGqcic60XlgCuGcjwYx8pY7N42enPH4yDLttCHy6VwEN/UlYK5zVt03LQ6BR
         jimMCcYHbyJjEp/ZDP0xpVlMWcfgLjjbKGrM1+qglZIU5fCN17dNDaeD6bZZEjKDAc6D
         kS8RVN3S5WxQCbftF8q4EpDqv7wAW/XJrzz9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756415219; x=1757020019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5t8lKSzWiJZ7o8aEHR2Vpuj8q+DwYY+2z0chiLgF/uA=;
        b=bzGgayqyJuViYVkyJEClvu+8Zu/DnYneRxPkZ+NjRVJcmLPbnitdGUT1qEDfyXDEBn
         SxbmgOHzt8e1g8KpL/AUYQRjQ/Cbz+isGNd+SClPPmB1ElDwTOr9PQKj4cmZFU286pRK
         +WI3SR41WY8TLB2w1/x5GRse4RHv+hLRHxYINYwWg0qpZX9rd9rhLTrBBYvKsZT/lRx2
         GticP6WVJoDEiOtM7RsFQdD6aWBXUmWmm4ueZxjd/OTebUhEG/MIl7ihIVpagMMC71ap
         pA0xP6v+0WlzgmDf4e5Cawz+dtk3yJiho227QrqrS7s+WZQwMU1X+x4rhErqz4TK6SBZ
         nyQw==
X-Forwarded-Encrypted: i=1; AJvYcCWACAZSF73UtFNsQTllPmQrqmQXyiTeVlM/4DrF8Gyo1H36QaNcNrRLJCHQxW0K/ERi0dAFqRXFAaGYKyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx30xeZ4LB/EL+7o9ZXxgpQwjlsKUggXRk6C3iK6MFWV5o6JFCk
	JXRqqcb3bdrufSwYWmb8Y+KKtmJb9pigxTe8zvsoFWZhKA2uj+vxqHN7vKtXgCRmxXzNY8UJ979
	k/sHLJkgT+Q==
X-Gm-Gg: ASbGnctcAXOgl/h6ocnUiM7f9bk8o1ut253ZvNmxtQnsEAt6kEYyFiDTvSUVWgYoRhY
	0Jnv1lX+RUra81lxfVbA1BtE/NWUqPk0QDGhMTCfCyyVyE3FSaEZI8lmoHGf2XEFhLJzM7lvOOt
	qQ9HKED/jIYoLnNLBaH19J4yuq9mxZHYhJ9tvxBM35FAcH8ldE73hxyBjqR0E6M+X/o98Kewvom
	/3mTNM2TQ4+G4flWonIdSeLhaxVSYMOns3W7at/ozKQN77cXjd59yX7vfz+4tZpVv1pvFdkBSQo
	9j0Kzh+4SoThOnu9AjopCTOnnSjz29W7untO5L5ZlJEcz5PtwN800bXZaDFfByzt6GcannQepmZ
	pWSV3DHUfSVjJBaH/kfRBWxIDoRlel/Ft2tLy/VhcjTtPsg9Zllh72afwFntmVxT+BLg7p64iuW
	lTjQR7Cm0=
X-Google-Smtp-Source: AGHT+IGEKA9OfljMUdOcA2kB9txYHx0tidm1HaxDFwy+3nuVVAxh3h909sbehDps6ryJAPXshvOZvg==
X-Received: by 2002:a05:6402:2708:b0:61c:58de:85f5 with SMTP id 4fb4d7f45d1cf-61c58de8a22mr13016778a12.31.1756415218833;
        Thu, 28 Aug 2025 14:06:58 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ae40sm365913a12.44.2025.08.28.14.06.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 14:06:57 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afea7e61575so161278266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:06:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4++AP5BWj2llETiiUEOuZAu8F9sLXJBiKhGcvjiPYhlLYDHoezZn3go/wh0BRolZ8EQSUIPscXqRDfAo=@vger.kernel.org
X-Received: by 2002:a17:907:9813:b0:af9:6bfb:58b7 with SMTP id
 a640c23a62f3a-afe28fd4320mr2202132466b.5.1756415216712; Thu, 28 Aug 2025
 14:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home>
In-Reply-To: <20250828164819.51e300ec@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 14:06:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
X-Gm-Features: Ac12FXyJjA2H7p5DkIaJHtdRMPBRP_-Unlm26ZIlq61PFiwHqxH_2EVP3LfoiLk
Message-ID: <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
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

On Thu, 28 Aug 2025 at 13:48, Steven Rostedt <rostedt@kernel.org> wrote:
>
> I could run it through the same hash algorithm that "%p" goes through so
> that it's not a real memory address.

For '%p', people can't easily trigger lots of different cases, and you
can't force kernel printouts from user space.

For something like tracing, user space *does* control the output, and
you shouldn't give people visibility into the hashing that '%p' does.

So you can certainly use siphash for hashing, but make sure to not use
the same secret key that the printing does.

As to the ID to hash, I actually think a 'struct file *' might be the
best thing to use - that's directly in the vma, no need to follow any
other pointers for it.

               Linus

