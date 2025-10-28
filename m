Return-Path: <linux-kernel+bounces-874200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE2C15C17
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0401C26C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C26346A13;
	Tue, 28 Oct 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZbzKfvjz"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C79F33033A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668038; cv=none; b=eu9T6EPc0xMlRdKSNCnJVxVM+ivAFmgG7WpQy2+tXadY8jWc9ULhGGpJVwFjO+B+8pys6sWKZUk8rfAVxCduBY90yrk3OcwqNVHmoT89rhrxAx3Fyf0lq9nehxiib3JyIfjZcbZy3Id8KcUU8eHSWhcqi2QDf+/LAXXkP6WzFlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668038; c=relaxed/simple;
	bh=OTM6b8wUF9rw6fOXlIOEcqaTwYbvDfucC0gkj/2fKZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUQ2SasYWcu7cY+zw71iYVFnWE6KEjJj4oIQ+FyrnppJlbolcndEgZrPyq6SY1yOcZWSU6Sc3KRkBvX/0XdXqgy0prwZ0WcI/+YjFZtQALOF/Lg/raWevJboxXUHjPTTiAge+3I+Xg+S7JuOV5fZ8MQgM7sAufoCkXzrTSlrqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZbzKfvjz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b64cdbb949cso1407463366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761668034; x=1762272834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/7vxW2qYHkfek8BcuNGNfNSQ19bugBoHjwa49fBWcYE=;
        b=ZbzKfvjz90RJUVxDMbX0M1ivVwUqHfO2r3iweE3qUZ+CXb54Rja3n2cbcdsm3ueqq9
         vNC4G70+iG6yaSWu8BvUQ+XOZCGr/Vxdrx9n33JT5TUS6e3gG3j+/nC1QwmvJ9+gvNeo
         M6iIIsHF1yDqD1GmfyMAiyOmi8zd5zMQS986Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761668034; x=1762272834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7vxW2qYHkfek8BcuNGNfNSQ19bugBoHjwa49fBWcYE=;
        b=Vx69itBqYrWbsJm66tXTz3VvWCZ0Zs4/RudRBgR6Dtw0/LEbxL097ywZruGeWNNZU+
         CzeEL1BWCbkaqYO5nprDu5ouorVj9jWNXMbowuZiDt+aQdKCoDeoqw4g/ikt9SfaemZe
         FxcFB9scRT4X3rmyCH/dwD4DroEkQs5Ua7HUoBCHheH5MVOVobN44vtAg7KnI/421g8s
         cp0RD617PHPncPYntXcB5Rn75/jwgwpVEK2XWjDFegjTbweNVYqN0MZlr4UBRqQXExYF
         oW9vuGFoNjB+t9LRjBv5h6MY6hJ6hbtbaDoZfhUlP7czyN8MhfUrlhOIXx8549y7mnoL
         +9Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWncFtbCieIvRc34DlguFISTeX+AjTX1OJY6qxKJIvxAmp9oULyxxqim4MpdYdelfDz5sZlURnVh2JkLuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL+DR++r8p91sZ2IfkK+dkc44WF/+N67FOu8ebuPaZV2bScHBZ
	M47WWOV8wzphmhZahtNzYHog1M9DjG+BPZgeKYXpLgicVeoAHVRMlOGJEmM0EPJacc1PnLPVsFV
	EUy+v60s=
X-Gm-Gg: ASbGncsxnyXqsksM1cBOhKWyInRrfK/PQLidjaoFJuXVP8vUEwft8vONyLwTS7PuRLX
	Ge0jkljvRekWBAGQSgox4RNynW5HgmBaiSqd4Nl51DcC1r1YbS9exipeRsZ4MVlhXJ/zueQvGJO
	GFh11D+n8iiq0Jz6nJQNAW37vgoaF2VF38SlLL1DoUwQ2CuU0paVxXt68RPgofFdzErIwdWQMD1
	xtrOwUYk8ZQtxBu7HX6gEu6KP39P4dFzbcbKHodgh9Hl+3e0AI7+Im+WPjkFZ3j+LNRl6SESHrY
	lhM2whIaAOCSoj7On2XcnfSvWzp0J0Vlt0/wcjV5dbzcp7HTV0FlUIWuRZSXTJE59D7KyPOP1dk
	f84JZKfMZ4aDjTINR23attzKsadQwFfprS3GBd6nl2J4nXzl+yJTiTZtw33N9mP6S6AatAYznql
	s7XQDY461SzbM3KTBdvsDpodKZRAC7lUC0wFcVD9cOhci0jFjt0VOCUmahtzMm
X-Google-Smtp-Source: AGHT+IHZriKDiWnYQtAM1fk4XT2z8vHtKidtVPy8KOXP0PMIs9JopQ9cfiWHZc3duzjWT+Zb2S41Qw==
X-Received: by 2002:a17:907:940d:b0:b47:de64:df26 with SMTP id a640c23a62f3a-b6dba586eb6mr412912066b.35.1761668034247;
        Tue, 28 Oct 2025 09:13:54 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853f98adsm1113587166b.49.2025.10.28.09.13.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 09:13:53 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c1413dbeeso9912688a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:13:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhogQAmRuDJQvz+boczwhn2Y90olJ7ZyVfP9GEnqscNijs07bgash5rW7Wn8fEUgyBJn32CY/FoZSXzEw=@vger.kernel.org
X-Received: by 2002:a05:6402:358a:b0:63c:4d42:993f with SMTP id
 4fb4d7f45d1cf-63ed826ace7mr3748960a12.3.1761668033009; Tue, 28 Oct 2025
 09:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027083700.573016505@linutronix.de> <20251027083745.736737934@linutronix.de>
 <0c979fe0-ee55-48be-bd0f-9bff71b88a1d@efficios.com> <87frb3uijw.ffs@tglx>
In-Reply-To: <87frb3uijw.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Oct 2025 09:13:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZ39CSZwN3W6n5kSAqL-OhJghygh3-dRsrJKpOa9nTwg@mail.gmail.com>
X-Gm-Features: AWmQ_bkZ4DVtg-fqS9oPLAcmx2bmXbpg5s6Qki9Q4422mgDG3jAT_1tXHLLXals
Message-ID: <CAHk-=wjZ39CSZwN3W6n5kSAqL-OhJghygh3-dRsrJKpOa9nTwg@mail.gmail.com>
Subject: Re: [patch V5 10/12] futex: Convert to get/put_user_inline()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>, David Laight <david.laight.linux@gmail.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 08:56, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> There was not justification for the open coded inline either and
> converting it to get/put must be a completely seperate change.

Actually, there's some justification in the original: see commit
43a43faf5376 ("futex: improve user space accesses") which talks about
the original impetus for it all: avoiding the very expensive barrier
in __get_user(), and how __get_user() itself couldn't be fixed.

So then it was converted to the modern user access helpers - including
address masking - and the inlining was mostly incidental to that, but
the commit message does point out that it actually makes the address
generation a bit cleaner in addition to avoiding the function call.

But I doubt that the extra instructions are all that noticeable.

That said - this code *is* in a very hot path on some loads, so it is
entirely possible that the inlining here is noticeable. I$ patterns in
particular can be a real thing.

(There was an additional issue of just making those user accesses -
get, put and cmpxchg - look a bit more similar)

           Linus

