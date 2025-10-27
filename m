Return-Path: <linux-kernel+bounces-872171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04512C0F740
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A7B84FA976
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9597C313526;
	Mon, 27 Oct 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WrRh2ASj"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E79311977
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583760; cv=none; b=nMG52aqtxoyGknpR/s4jD/pqE31AJWxJ9rTBBbAYewc9B7Haueeze2jsN89xC6vOKqDTrnRV1YDGCLlZEJLscYHyRMtRVGovb+tlz0AsKStmOspeCfHnOfeoArFZl1mnEeBrzf18szzeBuNZBa17h4lCdV7VyHKYIhBrCJYV778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583760; c=relaxed/simple;
	bh=pwFDnz2qvTBq7s3AgupkMDfXcsi90GT6AfOCXgh8tCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFfQhT13+OxYTnQTA01aC/WEH2oDm7sjHGeICdZ7ev9uyvDekCt6dU4r3+9dWQZ2197wtLnJa3TDVHH1SVUK2GE3wuGSNwqHTwkk6gZ61f7nJcDmP9MbDXNxsotnCxICAdVnu4x+pkOsN0Kr4tBh552zsx/c6MRvXneOFQiVZZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WrRh2ASj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b4f323cf89bso1168006866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761583757; x=1762188557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S6RVQIT9XTJ1IexdP/0qbvavFIRX5x9dwzaipWLoAeY=;
        b=WrRh2ASjnIXC0aQpq3HXxX3xAp8K+df5FwhFtqtGHwej1KA9tzwrz5UBLb4GPOfm7k
         AUmOmo2gRQleLtpSgL7+k6N/Rwe2jDHdpC04TErYdlC5Fr6vnWsZn/ZSxgeXYRNBiGq1
         6lbn5DYzU7TIrlgTqlM7xx5Ne5IaDbS79VJOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583757; x=1762188557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6RVQIT9XTJ1IexdP/0qbvavFIRX5x9dwzaipWLoAeY=;
        b=FkfK6RUgIO7rHloKcNDT6XQzKu9xa1ORqfGJs1d8Q2ufby3lDKs9AG4x7K6rPUCqQr
         vSlg7y91AcfigsjRsX2STprh/xfKi4THFf6x/gvV6Jw+hKCDAfF7SpuUHwabLFOW835G
         CH539633v/NCBpOZaiY9GzqFy8pRaT7AJ/u9sto5zFD23V6swdl5IKY+WA0Bmcj7S8Qn
         TPtUxUIDnbyQVi0hIYQ7FPhzJluAsL4e7LS/QnhQTpYB7FH2x8bTn+FWGY3cUAK+bbhW
         7KZJhMRiyITTpGFQ06FFEfYzZ4iRdAMpGKUnQfqOBSE9kcOFWx9vJ/B8zdhhDAf5mxLi
         mV5A==
X-Forwarded-Encrypted: i=1; AJvYcCUBgw/DyUGq3DDwsnc/MYmUX4PaVsP7/wny5DBDwsAaFpZqpwpYPm1NqmPVtCWJL0CG3qeCS1gmVo3Au2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7CC6iBwHGSaCjt5P+OqfugwnsmobGeK2ofZymtXz39PqwsHgB
	vBqK+Ek1QkcAx8B9VBL4x+0Q2LlCu54CzuIZ07sKPOVAHrTW3YR+QubK40KSxV4UmOaOBmjGFk/
	ryrIaxHw=
X-Gm-Gg: ASbGncvvYzmJ6qGTMpe+arT+Xhuu4+TqkFf7reiHJ/0VON4HBpDj/04doDLl2uH9IOv
	zS3tVmkpyguQc9sJW1nN1SVAGUgn6KaExLlL1Yi7i/ZQpicrBZsnw/8kB6CEr+Qhfr4RiAovFWT
	EO6EYtjKq3e0PC3vQAo62eu5s0wPNYEzwuJSS+gic3GATEk6ry/yk5ZVPITHZq+YNFsgPET1AOx
	FIVOjT9Ldq2mKmZhgM1t09Nni7LQtrAHf7vVoyfPIZqbUgveVxs2jb7Sa47cbdNB2NuN2W5OVbT
	dH/7be21V7mbStHDqDirb1W63HCF5DmUR3QBRznIVd0ZwemwRyyRQYTECWejciT1Xw6QJlmrGAX
	H/nxBKtMiFFq2bV9ExJ0EqooO5u31MK8utUqdkPAq1LTqiigSj1mHDkq6RT9U5zYA2ZjCn4wVSV
	Y2ipwzYe82tpiN1Au3jreoWohIjfIi6wREXxmUs/jY/eeOTPSUMw==
X-Google-Smtp-Source: AGHT+IHA4+f32pKTWS+RLroQ5lnZ8V9XqlXSeVWG19u6WYekXDPxOC7A+Ox7W0d7lh5TeZzVgOIBBQ==
X-Received: by 2002:a17:907:1c0f:b0:b32:2b60:eed with SMTP id a640c23a62f3a-b6dba597dedmr55273166b.44.1761583756899;
        Mon, 27 Oct 2025 09:49:16 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d854550f2sm800041766b.70.2025.10.27.09.49.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:49:15 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c4f1e7243so7717847a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:49:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZHd73eJkM5Zzc7Trn+89lnuKJM+wsPQVDsUoR4e6eVLggcTGSHNaoSn9505matb7zg2h1j+RRkIEK3E4=@vger.kernel.org
X-Received: by 2002:a05:6402:510b:b0:63c:8123:9d46 with SMTP id
 4fb4d7f45d1cf-63ed8494f82mr503142a12.11.1761583754710; Mon, 27 Oct 2025
 09:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
 <CAHbLzkpx7iv40Tt+CDpbSsOupkGXKcix0wfiF6cVGrLFe0dvRQ@mail.gmail.com>
 <b8e56515-3903-068c-e4bd-fc0ca5c30d94@google.com> <CAHk-=wiWmTpQwz5FZ_=At_Tw+Nm_5Fcy-9is_jXCMo9T0mshZQ@mail.gmail.com>
 <7bfd0822-5687-4ddc-9637-0cedd404c34e@redhat.com>
In-Reply-To: <7bfd0822-5687-4ddc-9637-0cedd404c34e@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 09:48:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgm=xTvbu4zEn3kFRC8bF8XXrOdK5fZj8iNbDn5bGB2g@mail.gmail.com>
X-Gm-Features: AWmQ_bmMCF2Bswabi5m1iDRLn-PFpqrzABrPKB_X0KjtKKqdcRXd8_cg4QARfsM
Message-ID: <CAHk-=wjgm=xTvbu4zEn3kFRC8bF8XXrOdK5fZj8iNbDn5bGB2g@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>, Kiryl Shutsemau <kirill@shutemov.name>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Yang Shi <shy828301@gmail.com>, Dave Chinner <david@fromorbit.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 09:06, David Hildenbrand <david@redhat.com> wrote:
>
> So I really wish that we can defer optimizing this to freeing folios
> under RCU instead.

So just to see, I dug around when we started to do the rcu-protected
folio lookup (well, it was obviously not a folio at the time).

Mainly because we actually had a lot more of those subtle
folio_try_get() users than I expected us to have,

It goes back to July 2008 (commit e286781d5f2e: "mm: speculative page
references" being the first in the series).

I do have to say that the original naming was better: we used to call
the "try_get" operation "page_cache_get_speculative()", which made it
very clear that it was doing something speculative and different from
some of our other rcu patterns, where if it's successful it's all
good.

Because even when successful, the folio in folio_try_get() is still
speculative and needs checking.

Not all of our current users seem to re-verify the source of the folio
afterwards (deferred_split_scan() makes me go "Uhh - you seem to rely
on folio_try_get() as some kind of validity check" for example).

Oh well. This is all entirely unrelated to the suggested patch, just
musings from me looking at that other code that I think is a lot more
subtle and people don't seem to have issues with.

                 Linus

