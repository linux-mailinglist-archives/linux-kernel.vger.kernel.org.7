Return-Path: <linux-kernel+bounces-867642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF8EC032D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E566E3B12FF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1675634D4D4;
	Thu, 23 Oct 2025 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RPeOJ2E6"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97734B433
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247595; cv=none; b=ErJ7lWAqTDwtaMhHeRHo3UDLq09V7II6mAETVhX5r7wW65vZRtg6hmTCdOR+ozIkjn1b9hIXSsvm3dymy5Cs6Xn4z0IeuQc74kdeo2aAfTOQprE69GUEBAMaCUS2yLNnQZXgGWRIiOjCbVlyhWa4ECmAaNApeW6IXJT4ZMlJOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247595; c=relaxed/simple;
	bh=0g5PWwg2p6TKfCHzkJ+Dwpx0TfIIseEhNZqQ162TaLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWPVCa+ERwCc7QzfQFJwBUBe85gMm1F92IwY5dcHWk63HeR7fYSTfTjIKhZGWTlckG40JSi15FLEYxd8RdCL5DlitXW1Wi/3dDXFRVExlYoNNyh1OvXH6Q9PmZmT378a9tbspBJukA4NkCNZQTocDkXrFxpIchZs1b9AR3I1n3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RPeOJ2E6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63e11cfb4a9so2199326a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761247591; x=1761852391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B+nka1o0UKTB6+YPro/AThdj4Pv3gE7VXwEkULP704E=;
        b=RPeOJ2E6kJ4XPGNOVECOHmrGC85CzhLN68Kgg1arqc9mUu+snqpmqUPjj82H4w8iFe
         xPIUh3JEE7XCrGVAbxl21ie/iQqBQs7+BANZd3ByHVSyO6dI4NGXMCCediR9ADYu4fYI
         ijN8pUX1keVNJwAZ5hI8+fwxstAVqFd3L+Fh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761247591; x=1761852391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+nka1o0UKTB6+YPro/AThdj4Pv3gE7VXwEkULP704E=;
        b=ZP3B1nlc+zc5SUNXmV/Vlb3raX6M/nxYXxY2eQY/SWdrA+p3W++X0LsDJFDW9N72nA
         60SxC+K1xjMIMdBVUsCCnfyJvXbzoE5D9XyxeoAjuF2hODUfKp3yTXK/umuNT0N71WB8
         2RpPim9IQsjd6AbUZpxriZzToy9av/M0PuA3H8mr85evF5fm8F9h5XS2RW8TrOYCHfek
         ly9jrHIKkNmEWFrqt/nIHhPmbgaeDnqYmI2qtt2uU9BqDLgZjymJFYO8NP/5Ld1Xslwa
         18RwatlxjZLJodZeSWeVqFHMVkTlJw/1sFokcan7yYEtkW9vXmvkrnOvi8EzV2l9tIZ4
         FC1Q==
X-Gm-Message-State: AOJu0YzJ/bzNS1dARUbeLD0qAWypWe8MYG4OGvvnd1GblHr0n+M99U4F
	+Cp1Ovg+1jZC7ZQZLw8owuYtAQnPswhTElnLuSDa8SD+VVurX8HhxHTVDqnVBChH8qQswO/61lh
	yR4UfMd696A==
X-Gm-Gg: ASbGncu1u2VVGJTgprelMUv9NfQvcNagpzFd/71N6D3Lcg/VT3IPwolX+MEvdaKm5qB
	iDxhO9V8QbYRJBWpeSEnNLyWHQWFC0+mzTT2R5ukDRfljiK8DZiJ76x7SCsPbqhLB0egDf2yOLr
	dBSphGFdU3xtNe42P9/3nwi/8xRBChG4AXjRSyHZ6B2nvVlCfrVJg7DPkkIeoaFsB/AdAk1Zekc
	BcTzz44XLQ2Gn6HCbSoOTfqPLCm8hl4dDnokNUOJqwh0i1/h34hVZRzPrVOalf4nQJ5n+LCevBC
	tGE9bofp2jiweaAqjOE3prgyeiT9v0TKmD94uBXXWciMiCTK1bYnnc6Bz0b1RUpEK1CoccsYWTy
	A/4vNb9NiYVlssMIW5F0pYMczmQ7IVHK9b+jwXeuP9IzOiSyPnU1OCp6wD8NUGTsVWICp1o1RFF
	9AThXt8ZYFD/SOCeUZ4e76Ncx6eXZP87bzfG4x7f7gdEVyxWvFGg==
X-Google-Smtp-Source: AGHT+IEbY03jqNpfx9EHxiDpJDcIYQ8zuRoQzTd+rCIlqrC6ADoB43YKEjyR3xZ7nnd5ZP0KWkt8tw==
X-Received: by 2002:a05:6402:3514:b0:63e:19ec:c8e4 with SMTP id 4fb4d7f45d1cf-63e19ece4d3mr8313213a12.28.1761247591581;
        Thu, 23 Oct 2025 12:26:31 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f316b64sm2374512a12.22.2025.10.23.12.26.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 12:26:30 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63e11cfb4a9so2199258a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:26:29 -0700 (PDT)
X-Received: by 2002:a05:6402:2681:b0:634:ba7e:f6c8 with SMTP id
 4fb4d7f45d1cf-63c1f6d5e1bmr24956720a12.34.1761247589536; Thu, 23 Oct 2025
 12:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022102427.400699796@linutronix.de> <20251022103112.478876605@linutronix.de>
 <CAHk-=wgLAJuJ8SP8NiSGbXJQMdxiPkBN32EvAy9R8kCnva4dfg@mail.gmail.com> <873479xxtu.ffs@tglx>
In-Reply-To: <873479xxtu.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Oct 2025 09:26:12 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjoQvKpfB4X0ftqM0P0kzaZxor7C1JBC5PrLPY-ca=fnA@mail.gmail.com>
X-Gm-Features: AWmQ_bmaCluDq9_Xyq5CJoakX9a-PwfYiYDMZ1KnC-jDJR9ceAw_ALWfx9Y5hW4
Message-ID: <CAHk-=wjoQvKpfB4X0ftqM0P0kzaZxor7C1JBC5PrLPY-ca=fnA@mail.gmail.com>
Subject: Re: [patch V4 10/12] futex: Convert to scoped user access
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	David Laight <david.laight.linux@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 08:44, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> But as you said out-of-line function call it occured to me that these
> helpers might be just named get/put_user_inline(). Hmm?

Yeah, with a comment that clearly says "you need to have actual
performance numbers for why this needs to be inlined" for people to
use it.

           Linus

