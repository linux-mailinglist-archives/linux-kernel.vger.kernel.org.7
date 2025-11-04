Return-Path: <linux-kernel+bounces-884510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36625C30553
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0133BED7F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ACF3126AB;
	Tue,  4 Nov 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W/of/Q6a"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC627587C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249087; cv=none; b=pSZDPL1d+uC9/I7NQI+o0VWfL9CGEwAHXJqCCQ/kQ4BeoP+iYlA9j1Km1LTAe7UCZECsKTqeWumUWc/S0DayW2k4aCIxExP/06oaIq0k+gGv99ubtHlr6bTbOhXJ2nAdcU7LHk1y78YgtVjuBhGoMjigCcucJDQnksIVERoBoEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249087; c=relaxed/simple;
	bh=72R88Rn3rGukSOJyhGw/2xZ+YQukQNHhATYbzzxBpN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4qNjoNeOlMDVpUHHlLXt1sCQRrP5+bpxzC3liBEN1KWNUrd0RdzFioLIpvrgxJGRunpF5nsXBsa561Z/ciHk8weDHKtgh/PaI7nUNNWGHGzZBeFQwIFCbzkrBVPLgj+SG3jc7B9o58fdHPcO2DYUvXcz931AUMGuCB0fp1F4oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W/of/Q6a; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so3032141a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762249083; x=1762853883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4fFCVmjL0Fz2iZG689nRiXgSeTQjOQSeq4YnYrnmIn4=;
        b=W/of/Q6aoHFv4Zc89i7Nc5PSi3jvUe6utaZyOIee7XD0mcHsGpEAyAOJLASzThU7Zm
         u85/lmI+BdL3IlhY9Tsoc7Cx7WSjL9vwfANGpfSC6wWUBw6Vc4ZcZSB1SzWD2JBnap0l
         PdsXBDs4NQmbAZYfLVr+dvJoFKBYgvS1JtqoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762249083; x=1762853883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fFCVmjL0Fz2iZG689nRiXgSeTQjOQSeq4YnYrnmIn4=;
        b=Swbll1pBs6fRLUpW6pg77tBAlKJup9ThLJsWgY+uGOUrRjZ6tSgigyJlHMeYxkcbWm
         2YHCqP6smX/u6i2aWpuQlf4qmbpVK42PTDJUiWj8gMstU1kDHUD5vOQL6/MauGgt9kdq
         +gmSt1X/ZxT5Sgo3tCcgGOVTPjqPJjtIeVw8KBxxRcjOOeIVua8ql4Nd/5Q+5Ii+PK8d
         AoJ8hG+rPdKvQo5vRbKp/ImrzMdHj4I1p6YhrD54lQUxvOALwUvaphfelzqFnVHCQbew
         0nDr7YvKhY0SzL40wJCK3HqjWnWCH42A+aMIfKA9nQg9MTVmpHDFk6PHje/kWLq0+ec0
         RH4w==
X-Forwarded-Encrypted: i=1; AJvYcCUuTdFfvMm8o9v96tuYA/NpDCn/U6J0WBulnjVI6rc7PYYgTLCR01ANEKuUAU0crL7MljhcaeSFvOpiY0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfiq1N7dtYfidYF6CoCd0Aj8HA9UJzHz2qsogiTx96iirR33Wh
	50L+RN5I5q8Xc0YYCCQxD1etZr/a05cVTz5b0BRZRrkn4ta3vJaVue2SSFVxfuG16SiFOCcmFOA
	/L97OOLxRNA==
X-Gm-Gg: ASbGncs9xcIPrm24s1fdpp/SmVTqs4dIBh2zmOnD6VG2uKyrlNYyzugxokbaZ8LP1wU
	Ou9Algy4dEMbrUD0J9PFEBLFH2GurhDqkdmQJdyQ9mJ9fsRpL2DYewc2BF6L6hmUMdXtFa9PDG4
	p0yh+iW0koWVcDnwzc6b+AEwm+HGbo6NvNzWxMq8yGvqleYguHwUp7BqMIOgxtXWS+QQhkQzTpj
	gQcwPkHXjfawapj38esYL7lacPQ3TExm2bRcpH/PqUX/7uAXtsuU0a3rewQ+k2ZRJBJLMCjB7dG
	iBBhhD8+A+XedqyYutyw4KgwmOwoaL6KmwmUtr2BADzrc8/8mrgmPgbVA7jfoAsD7JH0FyCbwmu
	D+yKM511wGc2L0Obkl1sH/LHDr0Ad/prsXl7LXYrYToc0xtp/8lavEFiuchCvAUNZ+EreEUlP/3
	J1VltJVtZwbwHikY3Q7y5aYQmvXl165ug/4EoZhKnrGLY5GEmzJw==
X-Google-Smtp-Source: AGHT+IHWDWiFsDfKAVv+m4JAVsdZSF1kYygJe3WUngX5O2OE5AmvrFNQrSxxiy/ugzaF18/lqvL5Sg==
X-Received: by 2002:a17:907:98b:b0:b3e:5f40:9894 with SMTP id a640c23a62f3a-b7070874d79mr1411137466b.62.1762249082735;
        Tue, 04 Nov 2025 01:38:02 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe37cb9sm160496166b.61.2025.11.04.01.38.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 01:38:01 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7042e50899so925778466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:38:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVY1u9+pJeRbHMMWLenEIqOtVcowt/UjZOXiQrMHbnpuPwRHIrdXyFT5jV5GQIfuOsvWgD6RRu/ZA8TDMs=@vger.kernel.org
X-Received: by 2002:a17:906:c156:b0:b5c:74fb:b618 with SMTP id
 a640c23a62f3a-b70700baa61mr1757486366b.12.1762249081268; Tue, 04 Nov 2025
 01:38:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com> <CAGudoHESYkHNdZZ5j1KfZ3j23cEvPZUNWVuc7_TTKds=qNWt6w@mail.gmail.com>
In-Reply-To: <CAGudoHESYkHNdZZ5j1KfZ3j23cEvPZUNWVuc7_TTKds=qNWt6w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Nov 2025 18:37:43 +0900
X-Gmail-Original-Message-ID: <CAHk-=wjUWNCbq+GEvCRjBBKkRiJboGMjXMiRd5Z7tqKCyJkdtg@mail.gmail.com>
X-Gm-Features: AWmQ_bmYy6dvq-kHQF3LAm-hFoZjgaQ0Uxt5kmfzN_e8mdhKTNMNYStG4JPRvTQ
Message-ID: <CAHk-=wjUWNCbq+GEvCRjBBKkRiJboGMjXMiRd5Z7tqKCyJkdtg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: "the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 17:57, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I would appreciate some feedback on the header split idea though. :)

I don't think it's wrong, but I don't think it buys us much either.

And it does make it harder to see what the bigger pattern is - the
code that initializes the constants is deeply intertwined with the
code that uses it, and you split it up into different files, so now
you can't see what the interdependence is...

             Linus

