Return-Path: <linux-kernel+bounces-772496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6C7B29364
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 16:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12EB2A097F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5024342A9E;
	Sun, 17 Aug 2025 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GZduaCD3"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B6C192B96
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755439242; cv=none; b=bymJWCeXS7RmEpX/678Lv+fHwsiBtqbyTCUe4yT6ayF1VVgULxioOUgf9LUt2A5zvnFUKzC7q1maaKR+04w5QqxBmgTv/oQXLkg/3dhqyjrT/XEXNWPhTpVPGGulQxHR2oJNhmGaIqDDULaG+Hl94PsjvKzck7D8KVefFsHZp+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755439242; c=relaxed/simple;
	bh=XENsuQCumYua7MioNEYzZmc2Ath362rqsq1uzx8nt/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaicSsmCQxEPWqvHXoNIoCJp+vuwIyqebz2E00/RTyKeRwVPYvDQ45w/jVeSZnagrdrvj1t4TmiBLUQj+sn47QdsLUc7AJi2721urEVSVbAnq8IV5Yjf6tHcOm8WKWcUmaDTVHWJnHWdKPAqopUpaBAOEQhB1mwtA2edH8oJLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GZduaCD3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb732eee6so570659066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755439238; x=1756044038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0qIavE41IlhgiieuE7QXFih894kngFLTq8gzLMbLAlE=;
        b=GZduaCD3hLfAlRS18ZQD7A+V6lp8noNW66oGo7EfIJeFvUSXIaPp4/SU2LyOKLqHas
         t7QT4/4YC99ZAuN8zL8TiSf9bxjmIsazeY4SsNIfVOpMP3p2HisGiqacfWvz/73MiLDR
         o1HDz5sc/fjh9irwhqGcEi/i/g4dGR0emrXvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755439239; x=1756044039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qIavE41IlhgiieuE7QXFih894kngFLTq8gzLMbLAlE=;
        b=gL410Q5kZnHusP2gQ2AMGXv4jL3isU2vEf6rhPj7JthXa+/UTXNFXshc8hbBNsmtet
         +NdA/p6Hjo2i4sRAseht/xXqTjYVCROmRX/+/BVSEuVKBI+y6lIjtRB6E7Qsf2bdfqJg
         1VQrURrdaEDCQDGsajehUMDc6XoChrLZlkeSQuWMsUgqWqnLrb499AckaAXxgd7VVxWt
         aYc+yGiNrSyeLhiTcNinwFZk1GawiWccNI00fa4rP/3BmXEVbeWsPGLdIJGblTv6nzEa
         iuZvVuUORD5iHbGESo32M7/d68DcPv4sSt7Qhashh8Cq2sFkfKTJNxLD3WdU9vTSJ6MB
         IupQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqaQCp3OxzTscl8seNKNjz1rpY14AX/WW6FvxS0aueBKoNm41XMyAE9KF1ijA59FBt5XofAvztkoTL4mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ihKYY7CYuHYw8XgUd/mCT4wJtwYDWDzTb3hS/mEDgVqVOPr3
	2uo7axDvL+lol+DRP0mtcKv0BhQqFlbg2NgcX/B8WCYanlWG1Ta0erUblRH8jVQzW5rRBfX1zCD
	dNIhzDXI=
X-Gm-Gg: ASbGncuU1T0PQqRgf4Thhv3ghs7XnHXdtUpHiKKhjEen2jG8Jg22tEfr3W7iE+m9nl4
	uwTlsJzGuUBgf8tcmXvtn5l0cOCMzeTrl3/gMT84t3AMeekCK9mj4aMYZpClbzSAM9aVfoCalld
	yJ29TLH8vdWF8ENDCdlZIppXlHCvz6R0pIg4n3ZM2C3jOKysfTd7HZpKDF1t4Q+dMuSP/KNLidG
	bLMLE++62WWVReA4EA+HjYx8eJGtTONFK7x/x3wc4HhJTJgsaMuNZOUeRw7Tfx6vSZnf8eFTNj3
	cxYIIbl331ljdtu1C3aTgQJteXz23zD8Oqm6Z7JYZ7Cl2EAl1Y62ZPubKX4rVZs9dHcvR5rOAob
	vRZOaNAVAA1E22bDA06FAEW1hkX+2oL1KiCisKd4ie1u+Eav81SnoxsDLqaao1wwicBgyeQZmzF
	iQhc+/gD4=
X-Google-Smtp-Source: AGHT+IGwcazvbXXosbZOWn2sVKfV2cqYDKnOtS5ZmRmuaU3pFslchgbUZ9HOL5ddyeh0qIK3hLaiPg==
X-Received: by 2002:a17:907:9494:b0:ade:8634:7b24 with SMTP id a640c23a62f3a-afceacab932mr524562466b.1.1755439238528;
        Sun, 17 Aug 2025 07:00:38 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd010e8asm591073566b.92.2025.08.17.07.00.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 07:00:34 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so4640190a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 07:00:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgglRSU0FxYHABPqtqDrlDVFdB/U2k14pYwkK9qq/ecrqQJPkFXn9hRcv92PO5C7thAeBAk8DPG8ZVLLQ=@vger.kernel.org
X-Received: by 2002:a05:6402:518d:b0:618:36a6:69f7 with SMTP id
 4fb4d7f45d1cf-619b6f685dcmr4528758a12.4.1755439233322; Sun, 17 Aug 2025
 07:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813150610.521355442@linutronix.de> <20250817144943.76b9ee62@pumpkin>
In-Reply-To: <20250817144943.76b9ee62@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Aug 2025 07:00:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsACUbLM-dAikbHzHBy6RFqyB1TdpHOMAJiGyNYM+FHA@mail.gmail.com>
X-Gm-Features: Ac12FXzplb0gROZKOoqhHCUXLWMWF2cOyr2ccwN697kEaYKsDdwVzkAFtgsaAf4
Message-ID: <CAHk-=wjsACUbLM-dAikbHzHBy6RFqyB1TdpHOMAJiGyNYM+FHA@mail.gmail.com>
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked access
To: David Laight <david.laight.linux@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, x86@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Aug 2025 at 06:50, David Laight <david.laight.linux@gmail.com> wrote:
>
> Linus didn't like it, but I've forgotten why.

I think the reason I didn't love it is that it has a bit subtle
semantics, and I think you just proved my point:

> I'm also not convinced of the name.
> There isn't any 'masking' involved, so it shouldn't be propagated.

Sure there is. Look closer at that patch:

+       if (can_do_masked_user_access())                                \
+               src = masked_user_access_begin(src);                    \

IOW, that macro changes the argument and masks it.

So it's actually really easy to use, but it's also really easy to miss
that it does that.

We've done this before, and I have done it myself. The classic example
is the whole "do_div()" macro that everybody hated because it did
exactly the same thing (we also have "save_flags()" etc that have this
behavior).

So I don't love it - but I can't claim I've not done the same thing,
and honestly, it does make it very easy to use, so when Thomas sent
this series out I didn't speak out against it.

           Linus

