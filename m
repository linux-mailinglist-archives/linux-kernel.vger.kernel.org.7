Return-Path: <linux-kernel+bounces-720523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F0DAFBCCF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E4C16CBED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4585721CC63;
	Mon,  7 Jul 2025 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OznHFgvz"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA238488
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921382; cv=none; b=T2f9OiTMcbY8k7Ow6Soq5Y3witcJz8IviNVBwxE/08yvyFia0n0vX+Gcgkpp8VDNTnxUrQm1Aefmu6/2nMRGTZjPgV9FtqAHVLziAUM529LpOfn9THMy7cwwrCtDhQOZ+bobBfoeNBQ8KWWeLOaBvflyrmXfHdTFp+NRqSsgr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921382; c=relaxed/simple;
	bh=UlDKEZ5sWoRHG7cBcIetwmT6gX+Tex47BHzvQ0TG7UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPwf8ZSoH0o40xC+/u3E2sDog30mZ5zBpMst4bkhg6dDXzXi2roceHZVzKeVz1HZ/PsCQ9dehsZCrvTTdf6GgktuBHgQ2WmsLeJAan5gyIq+m4PsfH8vrXO7Mj+jBFI1mb7IaoHmMA5JmFfRAYyhkSctDMMDX99+qDS9guUVWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OznHFgvz; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so7543920a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751921379; x=1752526179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=02PgiN7PJFVFaSl1V+OWG4TgqqQ82M8yAYvu32Fbss8=;
        b=OznHFgvzIGNoin3XJUee1aRQWChgFR90oiWthvm4p3rNoLLd5hHta2PjrN0l3bC2/I
         lalfnpvsjqQvcwZNnEq1BfkpXln1CF762bWR3y4iue/rheNsJT0OZ1XgdTcX0l3l7VbR
         veXrKDHaD0lnsEfUDslZ8+qgXZiJCqzCstln8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921379; x=1752526179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02PgiN7PJFVFaSl1V+OWG4TgqqQ82M8yAYvu32Fbss8=;
        b=GNcHfpjiSpYh1aFu9+Yco3thsqTmfNb0wueESkMzKh8/MvSPgWMkCuZ+SfXlExbfHo
         K9jlBIZb/igx1dgSMVoaWlk28OHAnoWfpF/g+/lk1fHsw2pW0Q0DS69AkIQlHIe4b8qp
         KHo5nVg7SL1K+b5Jg5G2pW/4KO35Kbxi0izWCP0ilGa7OSGL+LfVRJE4HKjggDFPEgVM
         U2C2/owquaYg55+cUImJMMGsK8ISL31waiDbdZwEMX/vvFv+QYHkmzulkVtpMKIiL5T5
         qDqj8ujVQDLTsv+4prQnoaW3pDdKyiFib1YNxZ26vQKTMo3sW+xmDo1aQwrwYzEMxLG5
         Zgxg==
X-Forwarded-Encrypted: i=1; AJvYcCXjuEqvaw8ogRFulp3wwfRSKwrQvBDAXjkkd5q6SlUiE/i7MFI8snmg80p17dwz0RQSSHt7kHsOU4W4bKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2C9SeKHWT2HZmgmkuxm1ZlEg70RtEREOoVbT43OP/FqWmCIR
	WiuwyDviuF5K9uTAl9IWq3Gl3TgHAYqkofROChDuuCFCAFgPoYHFAxK6cAGf47FRE9ISbLpxdKT
	4eZnSWFg=
X-Gm-Gg: ASbGncs9wnbDMQGrV4PXl7pkYAEh8A9ex5N8BPd07S/sTeg7Yt3HBXk93K0W77vfCOl
	tG2hxaUN5LthmWspdfDwo2SD75hVUzrp3fY4It5l4whDrT0kwLEDZ+m1bsIcBKUAu90PU11+cYw
	jmlVAIx6LRn4LZV5yVJTpNq9Z5q+zoYY+LCSd6JWlHQJ7e0t4Y1V9XuXbcREBC2gkoshx31vym0
	k+udv2/n143102wbDSB8D9Bp1D8BLzdTQK9i5rsLJvgXFkRsfh9kVxtvvVsjAxeATl3H+90UEQa
	X5yGM7x7gjOqMLYPUeMPBcdRr+A52OKMkCH8hlI8YKkY8bdTPCb4Xnt5b2Sy3aNJ42Kxg7Ym9gV
	X6r02SLoKMxh7Tdoo7l52yQ0mHaEEGcNoUHsgCie40ZITM1E=
X-Google-Smtp-Source: AGHT+IHneAJizq3wHA5ufQ0eft93CfDSrXhH7Hd6HbO6iMRcsI+BWOw3GtlwwoVdOpp1A/zIof4HYA==
X-Received: by 2002:a17:906:3451:b0:ae0:daca:f06f with SMTP id a640c23a62f3a-ae6b0259fb7mr36008966b.60.1751921378630;
        Mon, 07 Jul 2025 13:49:38 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f692aa07sm778356366b.51.2025.07.07.13.49.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 13:49:37 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso6398289a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:49:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQjl5UD8CnNBtPqJmovvz4iQYdLJehiGeh21jYHUfJ1TpR0HWujdxAgJcdfy77Ot4GirOKPzAdzrc/yq8=@vger.kernel.org
X-Received: by 2002:a05:6402:35cc:b0:60c:3cca:6503 with SMTP id
 4fb4d7f45d1cf-610472e9b9dmr1045719a12.32.1751921377273; Mon, 07 Jul 2025
 13:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751862634.git.alx@kernel.org> <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com> <ugf4pu7qrojegz7arkcpa4cyde6hoyh73h66oc4f6ncc7jg23t@bklkbbotyzvp>
In-Reply-To: <ugf4pu7qrojegz7arkcpa4cyde6hoyh73h66oc4f6ncc7jg23t@bklkbbotyzvp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Jul 2025 13:49:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQ_0qFvg3cugt84+iKXi_eebNGY4so+PSnyyVNGVde1A@mail.gmail.com>
X-Gm-Features: Ac12FXyBZiGga4SfFrcaUHuYJV_R_nCmMtiL9Yd7402tdLFKvKKk4keGfQkJ8kk
Message-ID: <CAHk-=whQ_0qFvg3cugt84+iKXi_eebNGY4so+PSnyyVNGVde1A@mail.gmail.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Chao Yu <chao.yu@oppo.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 13:29, Alejandro Colomar <alx@kernel.org> wrote:
>
> I am in the C Committee, and have proposed this API for standardization.
> I have a feeling that the committee might be open to it.

Honestly, how about fixing the serious problems with the language instead?

Get rid of the broken "strict aliasing" garbage.

Get rid of the random "undefined behavior" stuff that is literally
designed to let compilers intentionally mis-compile code.

Because as things are, "I am on the C committee" isn't a
recommendation. It's a "we have decades of bad decisions to show our
credentials".

In the kernel, I have made it very very clear that we do not use
standard C, because standard C is broken.

I stand by my "let's not add random letters to existing functions that
are already too confusing".

              Linus

