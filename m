Return-Path: <linux-kernel+bounces-741209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F30D9B0E179
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EB51C85AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4934027AC5C;
	Tue, 22 Jul 2025 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fnFV/I8y"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8E527A127
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201033; cv=none; b=m4oOD5MqNU9y6fjSfpLi6t3Ssn8iWDFyr6D8+AHl9QwnezzXBP/4fT7XHpXjpXhWqEoMkfqdQaVct+ieDmHMrB35YNml6VsSeBZDzpatPVMP2A6X+NmL2VhbAfC6/2vtonwRyuNZxhB0t+iCBu3umfS40TahMZa0iYJ+XinxVeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201033; c=relaxed/simple;
	bh=FDXlr7W+/66QOFftaHFQrLT51jF+Ev61+zYZLRFU49U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9VzVJXXNSLb2MK7TBYy0vJQG1FtOYrJBKKitN2xV5VmyoHJM2NH0lRH4S4BZhek+//d5LP4n28sd/O6k7U1+d5R5giOxSB31ibyykIK0V1v4C93+8OVJixwo2fGujrzD9di52lHa4RbZYImeGvWphAvS2wfb8dsRMHaVUMD5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fnFV/I8y; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0c571f137so1075099366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753201030; x=1753805830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MwUpVzSwK6dKQWrESREzqGXoWD+c7JZoygfweu86bO0=;
        b=fnFV/I8yWl/hAp3mKKIcByPv24P6IFqgenKGnUH1PPfTu14P1Bp/UUqCC9HxQoXMEp
         eKVkwP+N3cNurtgl7Q3xpESa8NfdkDuvC1LSE3hr4FtMLo8Nr/9FCdxx+C0AUyf8so8d
         /uQIcmz8V34rv8nj/g5rTlDZULt4dK5WaNb5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753201030; x=1753805830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwUpVzSwK6dKQWrESREzqGXoWD+c7JZoygfweu86bO0=;
        b=h4oKLQG4efR7XCThz88fj9HBAQs0GnTCCnGMqP8bAIhxHr65fOR3IOo9kT7EPkOQg6
         0A8WYwuwA1hEOO3D8NpYF5kjJ5RK1ucCcr0eoU6i2wzF7y9Zcgvb8l3nNBNkOJ+E5GVw
         Ey2t36yYetdp61XvURFRxB3h0o9BSH4eeMP+GPP+8Y/wsb+qJOWAli040MXWsBtrTx1A
         9igoKx+t5EuxrfgqFQ5ZQVWjum712I/5sg4BfG0XMIlWG315n+qm2BewELj4w7iYyvv6
         2AslsAOLKibP1lLc1bWqH+tmiy8l5yX702ym6t33BeYormdZFzf+BVCkuWIoq93q3Oqd
         f0tg==
X-Gm-Message-State: AOJu0YyKAhoxAyBG9/z7U5EQIABOU0gdnDPdIWr4BS++FuX5T5dfiyE4
	sYeEK9sSvmTkdDJoVV+E0RK9hH6+NKT95WGYuz4veFuI0hD5NWbAJN0D0bOLMfgRYPSOkDIYVPH
	04QFN
X-Gm-Gg: ASbGncsrvB9rRAt9ZZmIEOY6lZc0lwx/J5iqvB7i0N/xRtymvvu7MRNnsD4utvWoOs5
	ZXHsmUfrjWLqylx1c+RdXPtmwOjRlKZ1wbptxCrcOhKiBnWBik5FWKK2lY+Xi68fD0wX4J1PAjv
	3Nm61MyaPz9j5ph+d9WrUGl5o99ZGCSyYgqbhYuX/1BPEzl8nHdiC1IQS2oHEpC9Rmp8JK0tAnh
	yC+zOht7gZSBp7AKIR9UWMlafzzDBaJ3+MkgmvaWDAtdv3gr7puBNTFJWUKO8Tw/3v+ZhLV2Hth
	Ku/c5XSk1IcF0cHYjzm05TJBjBw/b4lOGj6LwpvC2YYNUBf+k/gplrvkVcCgANpZUdbpBuTNHQM
	kRvErz1Dkx00bCfly1G6rvuK4k/wX7bZqWiIikeyjbvVREbKpqqLBFGERl/tDpmnoSUFri0u4YG
	YjaerzGgk=
X-Google-Smtp-Source: AGHT+IFMcChjQLaYLsTzNdx66zzIogqriyTt6JPiVyMMLIkyq3L21ub7mm7y1GAO6V0guMprEmOx7Q==
X-Received: by 2002:a17:907:3daa:b0:af2:91c7:f2f8 with SMTP id a640c23a62f3a-af291c7fc0dmr108851566b.50.1753201029838;
        Tue, 22 Jul 2025 09:17:09 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79cd11sm884714466b.16.2025.07.22.09.17.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 09:17:08 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so11560478a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:17:08 -0700 (PDT)
X-Received: by 2002:a05:6402:2111:b0:612:ce8b:8e3a with SMTP id
 4fb4d7f45d1cf-612ce8b93famr14784723a12.18.1753201026121; Tue, 22 Jul 2025
 09:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722152053.343028095@kernel.org> <20250722152157.664260747@kernel.org>
In-Reply-To: <20250722152157.664260747@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 22 Jul 2025 09:16:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihb6KVgU__zfhdHR=-Mqhp6qaAABdu31CJ2ML6MDj0dw@mail.gmail.com>
X-Gm-Features: Ac12FXzcgZHEVpW_XghiBSi-6W6yHtnaI5_N4MXF70P1OCTvgMWBy0XPnjswCTs
Message-ID: <CAHk-=wihb6KVgU__zfhdHR=-Mqhp6qaAABdu31CJ2ML6MDj0dw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] tracepoints: Add verifier that makes sure all
 defined tracepoints are used
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Jul 2025 at 08:21, Steven Rostedt <rostedt@kernel.org> wrote:
>
> Add a verifier that injects a pointer to the tracepoint structure in the
> functions that are used and added to a section called __tracepoint_check.
> Then on boot up, iterate over this section and for every tracepoint
> descriptor that is pointed to, update its ".funcs" field to (void *)1, as
> the .funcs field is only set when a tracepoint is registered. At this
> time, no tracepoints should be registered.

Why?

Doing this at runtime seems completely bass-ackwards.

If you want to do this verification, why don't you do it at build-time?

            Linus

