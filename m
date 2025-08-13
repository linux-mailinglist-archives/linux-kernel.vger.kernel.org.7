Return-Path: <linux-kernel+bounces-766986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8F1B24D71
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8682A54E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD28C23BD00;
	Wed, 13 Aug 2025 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NUeHLzf1"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE04241CB6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098890; cv=none; b=fRRUBK4RXhc5p5IgQqFwj0u4NsccaiulBKL/SIAtr8URrKetbilC6wW+Szk2AEGcrSHXQuJmHG9cOE5I5sEfM8pLH7jrMgTNAyNIOdw11AnpflWSrr05lF8gfsgJaHRBV72U2a2dP7QouDfWJ6VFe3VQm9mZClNmPM8gVcJlSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098890; c=relaxed/simple;
	bh=kNbQ8bJ7GL2E1FfUR8hcocEODI6mIH2QsKu9td0CiWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTdtuRDr978Y+HqSnCKN5ucbPUHCmCqZcR9rt8YBhtvfXyljnGokQE94k0X62OqT+sAASHFOmLW6zFYYwRK8B5lRiOJYw3MEz6isi7UUIv72HcPbbWo+nPDS73NpgSqkPmZAnI82vhcupGo5gHMOT0Ej8ZD1nHxLv+V+1kJwIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NUeHLzf1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af949891d3aso876004266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755098886; x=1755703686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=utUYEctpaDfJIrNlEZgIBn4zx0vgLha1VJXf5Z2o5bk=;
        b=NUeHLzf1Ufk8RPw8LDWBI4jnsDKaSY6SG6FjJl9HRT/5YaCrycNO57X8fgOOZ0C5sr
         7AnCkSrHYcHL4CUBJp5I/DbmuiZR9Sgxzbqsstr7rpqMq8kLGPTC59lOeGERvFCGKRez
         JnRIPUlZOJvmdqLQjBZi3ghdS21HLk9DJO6ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098886; x=1755703686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utUYEctpaDfJIrNlEZgIBn4zx0vgLha1VJXf5Z2o5bk=;
        b=bEsilDV6Ble2Vv6Y2PSwU2JxTp5s+pFTQdBGJY3aoR4fj+pmHOhmfsYujrY2uBDM+u
         aTma7zW95XWQRXWNr23RTirpg637ctIIskhCJ6aerbgd/pZlA1OX3MDEZRHKY4fyClFY
         fH5c5y7z07nLul57JQTceYrH7VDBHYJuxkaazUfWIzWLNyAYh5SqKUqgjwMLUbdBDYqd
         hNZUk8A3a0WmRqxjfyNJQ7HZdfeUDIqJXsCLSCGsg1uYlCH2pp7psRuE/4biDocFFMWR
         7lv7C4a2308htbtAEqjYAL1bL5jPjZjDVZ/nYoA6MrEhYCQq49zcOqcriR/VP/dktr4R
         Mj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeA3vs25MCuqZEAf4ALiPS2UQCV4AALK6mbEmIpVCh0H55VHuNmXiI8cnYp9FmumyZ8Opp1pJWR625GUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTQ0OqJvMQ1DZO75bRyxFrD2A1VnEWWSVCGeINHPM4mMMUwET4
	UfFL8guX3kERk5ZHnGWqTYLTT+VYBg0/+LW/jtdN/yYWmK3kUyy4NLdPKtZON7T4LQEdZ96d+qn
	fY/M1bK4=
X-Gm-Gg: ASbGncu+z8WBmfq9QRMgdpfA6IquRZ2D6ysWvrOUQbtfwSH4udNbHhsXBvxB4J1+Nxp
	1DNqNr67eF+LvsXaS76cpv1knXy1lxA17eGZ+AHZ1GvlJQDSevRV8MTnmSSYd6E72YjnyKfE0rq
	36UE/XfDDAn8CqjKailAT2eimAXnYdK4XXvdqIYp0u1nPHMbmkcTHzZQjrT+NWmFj1hZZYDDWly
	3gfFnDTcFmATj/yPINSJDowicwQrEP4TObayFGpiEVAduH3XqkSMFOrk2FZNXpceQMPYEImHspy
	kOz7Uah2Ds2Gzww8P7TDRyR8nDav1aMZP5WTuTWTt7PLsqkmeQ1NSzjz2jDpOQ6rcYKoEMLj7Ud
	pov6SphrKSY2wy9Bp29EmQ34AZMf5ogJxo5FYn4+b3S/de3+TTNot5FmBHUz606tMQ6LBbtHlN3
	Ou2voBQUw=
X-Google-Smtp-Source: AGHT+IGsrb7KStkcyEB0m2ddzbTW2TL6/QHyxPWUKaQBl5Gnmj2BCKwZyfURAIqxULRJkH+gNwDVTw==
X-Received: by 2002:a17:907:3f94:b0:af9:5da0:adde with SMTP id a640c23a62f3a-afca4e44392mr339474666b.45.1755098886117;
        Wed, 13 Aug 2025 08:28:06 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0afsm2407041066b.117.2025.08.13.08.28.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:28:05 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so8281652a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:28:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVarAuJNwG+hjcWK8FxESmew0cEos7B/uF+a3X8w5jFbdili8nWsyK+FeIBNiVqLQbD4eEJgrTRfSqqTqE=@vger.kernel.org
X-Received: by 2002:a05:6402:2546:b0:618:4ab5:e85c with SMTP id
 4fb4d7f45d1cf-6186bfed0f0mr2863094a12.34.1755098884496; Wed, 13 Aug 2025
 08:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804220955.1453135-1-dan.j.williams@intel.com>
 <20250813141346.GM4067720@noisy.programming.kicks-ass.net>
 <CAHk-=whiz9EY5CCHPtRkAuX0wMHwqwa4=GhKUee83mMsU9R0rA@mail.gmail.com> <20250813152142.GP4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250813152142.GP4067720@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Aug 2025 08:27:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh63uw1YO3brwJpZqL2gtBFsM3vycZuAG1vGB60eLZaOQ@mail.gmail.com>
X-Gm-Features: Ac12FXzAQIRCxCMKXtU5LNQDn-555L6LNyKadTH4naeqp0E9Nvd70GKseVpXELk
Message-ID: <CAHk-=wh63uw1YO3brwJpZqL2gtBFsM3vycZuAG1vGB60eLZaOQ@mail.gmail.com>
Subject: Re: [PATCH] cleanup: Fix unused guard error function with DEFINE_CLASS_IS_COND_GUARD
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 08:21, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Right, so I've had patches that added extra #ifdef gunk because of this,
> and we've sprinked __maybe_unused in a few places just to shut this up.
>
> I think something like the below will do... totally untested and all
> that.

Yeah. I'm not convinced we want it even at W=2, but as mentioned, at
that point hopefully nobody really cares.

             Linus

