Return-Path: <linux-kernel+bounces-756491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B86D7B1B50F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AFB623040
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B7827510D;
	Tue,  5 Aug 2025 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KGSkARlc"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F01189906
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401003; cv=none; b=Dp+provaNODMOF0pH1wV2nTR6D9TK2SyurXyRbZC1AFPQvpezDtLKZHymfZj3tYZHFLxIHba4XAzP9pzQzsRj+ClGfca/VCX4e99KZ+kSsveAuyI410tpQB75oZrji/nK7OgMOvgfUeXnCGrow2K3biVAjtzh+V/ZHR+V/9PWQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401003; c=relaxed/simple;
	bh=J6DjSwoZRUXD6cC0Swrx2Kq6FOSNEG7qx/VOWa/IiUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ou8rA0PzC3MmQbsUQoDVEOCAgHLZxbp1v/Pv8bxkgPkXqxwaXswO5hXA8EUlsSRA6DcqaVxMjve2q7367ZzAOAtczmSWNp3gjBbaxOeuZWiAfKWzaG0Gee9as7skzO2nfH5XPveOEKW2LDjle1W2svzbyuqks6L6auaHzgY4GYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KGSkARlc; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-615a115f0c0so9503257a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754400999; x=1755005799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DMoGQJPU4f1NGWiqNzClF6T4JpK0+MQSV0Gqu0kgblw=;
        b=KGSkARlc3X78cyUEDaYqfFmRHi6xaDaBPQiIQgKMG3jP9KjNY4vsly3FjAzmI99KL/
         7GfwyyMzGCLL7zhUlOVAfuQ7zn6lkM+eRCq2uTkkej47twMIE0pBM/DAS8GZr8JWyYBA
         Jvk8efZ6nJoTX0X1G+sZbRcwzfhPJQzT4UenQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754400999; x=1755005799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMoGQJPU4f1NGWiqNzClF6T4JpK0+MQSV0Gqu0kgblw=;
        b=tJyl+ZxRVLT2ldaaaPOLcyx3ARwtIukqhwNlG6MUxA/oIRXrNcAXgvs3IdjGtflzfd
         3/7L0dwV9aXyaG68q3GRTU7yARNZdlE/gH0IcuXyntnu/Wm0w0LIIxxVFHaOK77br5su
         SUIKoDpE9eWOF0RCsQX9cPVCo8hwOtO/6ipw0J8PH/B2pBrzLOZGoOHhcBZfytEKyuRb
         kt2pSYenCWAwVSdp3kmkr9HLyjcGGECDXnmGZi4oHZ8JnfcZgNsEMp3cHucc8huMnWJ9
         cxQ2EUe2AnQtejhwazzHjq43GHSjGB76hQNrHTCkCtYHW7JhA1BkJAt7YBXez3Za00XK
         E5EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDkvdriyQjJtAX1UM8lm+sOSQphajtYQ/BTBNuOYmGPqCAncVig4q+F93qICkGLdAkfbvrSvjYFQKpTmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywya69hcM9/g8GQe3/m77LbslaWhp22zr8iJfnWOW3xNVuU4Fv2
	ZqP440Q/TK1fmVBuv/xSIbqKIDqJbXC+9YzCvp5nRs4QLc7Dx7UB3RDuSnMKxKcgocB4JBF3kun
	e9wVvX+LCgQ==
X-Gm-Gg: ASbGncsncqTK/xrVkepn+6qA9SFAKDSOe12hr/Ng9gPjUI8thbqiuMtoPRLT8fvbrOj
	qQ+wxV0WQeOrwUy6T3Sz030C5a6N6LowNY1uPNEZLS3CNbwZr6jwSapFSWEpp6HQvhEg18P6ucr
	qMxsnpWemAG6/U1W3bD/s0sE36rntT37t+YhTu1pSbwXf5Fvsm77mSGZfk892jm1JtoTrBgu0Eu
	bmZhUrL/vdv683vyqaadl0yNGiOPvAdmFD1qihxDSYilDuNP6ZrynvPiAjMGy0H86lhmyMgzwO6
	JTchybtYpT63qIyhh54z6OEJSCGdkFYI0gLbHVcM/zDFEG1hcnQFjG4gjoR0PdGkh1g7Kts2bmG
	CGHH8AqzH547sZc7ygOXGYXi6cgsBvTe+KYCNWliZfUEzTj6KkQ+1mDAUSf+fFln9ARJul6wx
X-Google-Smtp-Source: AGHT+IFyx+xDbNCAROAJEfINAOfOzP4DDInbNl1otwr8HKh+Y8C0HKWqfl5xRsN1l9T7l9e5kOUkxw==
X-Received: by 2002:a17:907:3d86:b0:ae7:cb7:9005 with SMTP id a640c23a62f3a-af940175970mr1415731966b.35.1754400998611;
        Tue, 05 Aug 2025 06:36:38 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af937c86989sm687678266b.74.2025.08.05.06.36.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:36:37 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61530559887so7464757a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:36:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFNxksPPkGGxZqS5jVxGN1phnJCFghBFDeWxpN0g/qZV8WSW1iGM1g1sFjYpwD0/YjaSTiOHJZUGIONLM=@vger.kernel.org
X-Received: by 2002:a05:6402:254e:b0:615:aec5:b5bc with SMTP id
 4fb4d7f45d1cf-615e6cd3968mr11395134a12.0.1754400996985; Tue, 05 Aug 2025
 06:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804162201.66d196ad.alex.williamson@redhat.com>
 <CAHk-=whhYRMS7Xc9k_JBdrGvp++JLmU0T2xXEgn046hWrj7q8Q@mail.gmail.com>
 <20250804185306.6b048e7c.alex.williamson@redhat.com> <0a2e8593-47c6-4a17-b7b0-d4cb718b8f88@redhat.com>
 <CAHk-=wiCYfNp4AJLBORU-c7ZyRBUp66W2-Et6cdQ4REx-GyQ_A@mail.gmail.com> <20250805132558.GA365447@nvidia.com>
In-Reply-To: <20250805132558.GA365447@nvidia.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Aug 2025 16:36:20 +0300
X-Gmail-Original-Message-ID: <CAHk-=wg75QKYCCCAtbro5F7rnrwq4xYuKmKeg4hUwuedcPXuGw@mail.gmail.com>
X-Gm-Features: Ac12FXyPQ_UPydLfRJMzum57G0PVuq0AJqMF82gLhObs0pxwHXHWtx7lBNKByIg
Message-ID: <CAHk-=wg75QKYCCCAtbro5F7rnrwq4xYuKmKeg4hUwuedcPXuGw@mail.gmail.com>
Subject: Re: [GIT PULL] VFIO updates for v6.17-rc1
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lizhe.67@bytedance.com" <lizhe.67@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 16:26, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> David, there is another alternative to prevent this, simple though a
> bit wasteful, just allocate a bit bigger to ensure the allocation
> doesn't end on an exact PAGE_SIZE boundary?

So I don't mind adding a check for "page_section()", because at least
that makes sense.

But yes, it would also probably be a good idea to try to minimize
SPARSEMEM without VMEMMAP. I'd love to get rid of it entirely, of
course, but even if that isn't possible, I'd *really* just like people
to try to make sure that it's neve ra valid thing to try to combine
memory across different sections.

David mentioned the 1GB hugepage folios, and I really thought that
even *those* were all in one section. They *should* be.

Do we have any relevant architectures that still do SPARSEMEM without
VMEMMAP? Because if it's purely some "legacy architecture" thing (ie
x86-32), how about just saying "no 1GB hugepages for you".

Because that whole SPARSEMEM without VMEMMAP is certainly painful even
outside of nth_page, and minimizing the pain sounds sane.

                Linus

