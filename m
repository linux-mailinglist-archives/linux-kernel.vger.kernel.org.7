Return-Path: <linux-kernel+bounces-838158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3ECBAE92E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAA61C4953
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3B728725E;
	Tue, 30 Sep 2025 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NTXq/a6h"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BA1287516
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759265470; cv=none; b=Pz2xp5aVSg3BrvXT0DEuMbIy3mDFEzLt1HM+1ykEEdENFj33k3Rb6c9D94K3oV+UQ2xWhPkTFvQIO09hS09knl7GwhhACnVGuRyEPuQKwVKJh+QiBM5R9+bsXDFlCwv+bhh09EqWfHw/srr1B935xLS7oFPbAsDUtPCC3NGUK4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759265470; c=relaxed/simple;
	bh=Bq7aYulorZgMIBlo9sqBhK4C0U91968OxL5exOrO+Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bl75cesBEE12+LP4rxjWLASQWEDTA/pUEQ1YfM46WQAZoWUkmRVKXTCAX01kWWXBf3q5b0LYvXqSoDPSGIhQOzcUhAYhjuRD53Bfcxa8dyT10IvVuFeU7ldULB8Q0ssoAVmuJHCu2Fk+21fH98WRyuzIwcfEd1DKYn0h4jBCmpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NTXq/a6h; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-634a4829c81so10952552a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759265466; x=1759870266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QRUM4XMMsUYAz/h48H1x+lWc5jezcYUvc3NT096GRyg=;
        b=NTXq/a6h3O/ss1ekhiWkXRlGApPJwVL4a340zdj7zWwqH0E1Rik2W0lzWsirFf7uxD
         zKDmGZ3w5Hm5zS2h5RqVV5GaSvSQOCB0X1vKkhk76/cXrF1XEy140c2eBugsUtjR6b6P
         PLwgWF/fVKrwnav1cWHKyQPqWunqJ//XXjnC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759265466; x=1759870266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRUM4XMMsUYAz/h48H1x+lWc5jezcYUvc3NT096GRyg=;
        b=wCILLJhCQcyn5SgoVzy+fi6Aeajpm8oqgwHXBRZCByiRx27U8yifBhDiLQpSB5D/Ca
         lSw0PYjIVfeloSMkYxT8ufvtADIQ0scVLNATSdLzWY4P6liC/J8uxYXVOR95q1a8O7Ro
         SVqGPy7rXn8L/Qq62oz3uBbty7ew0Y/HwlgIbQbGzJhvaarZlyCYxL+JA8ZZPuIz6Jzm
         PM+B5QR5WQPb8GNJlzdr+yx6294Xy6AVHY+7IDfILencrsfxmgG9AJtdz3k28Lqj0puZ
         jgwtUauzm8HbEBdpKe3TgeMjca9eRb+CrufY3XelpKOdLI+s461JM7Y7rHsu0eg8EfWp
         A4Og==
X-Forwarded-Encrypted: i=1; AJvYcCURGPuB3FqW+uR/iWCgViJwYShrj3Dfk37567qIHY9FA2FTKcgSZGkBdW61w/4CoyoJ4iABUu03D63kmkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6SXzdbzdRsi1p3vpkARMZZOIHoP3Ae3d6Lo9s0iRR9zOwz1Il
	xXMu6XO8e5CZl6oGTRnvKKMiggww2JKnnd4Ax2S5GQx0gj/zs5Dwx5uzOWD4b/V5DopD3O9waAa
	jzUm31mM=
X-Gm-Gg: ASbGncvw45ueAi9hMBxnJmPwyo3W6UUMOoo86EVRbszsPv8yC700IzIEbhMtCjIFhW5
	mOjavBJHvQwddebCiPRk3kG3YilKbFppkpwnQ+yi/ilGKvdD20N9fAYnG8K3y0PFWyZQOIvcr97
	xG5etCD6I/tkXrZxFGF84qIPngJAxwb7+tY0HOiA0jgNOmUiOJDtfWPZMBFlKDQ47oqqYuVAScc
	okhpKEm+GUM5zCe425S29+NUK0ZDhT/onjT5B6jPDVZyAkRXbOOIprPutR22ZSO2tx/S8sUPc1u
	Ojs7IhtsSHJlOzDN2uo2nkn1rCCBGFFndZ0OXb4XD+NSXC0WarJndSgaXFyQgL1CGO6TgjH5+a9
	f8tVw78N4dsVISzj4GGNzX/hKvpl1DQCIpW/b7Exi5m8loXEyCf2Pc08JOnSg81VAgx+AIfsTli
	Si1gQcv+Rldxwose7tITs8cQl5XrLzQUI=
X-Google-Smtp-Source: AGHT+IG7NLDvS1nhcFEA3nd/0XO9tr/wN/I75IvaZd/yKvXBkF2hpd9+WHIKR149APXse5ODIUgQ6w==
X-Received: by 2002:aa7:c60c:0:b0:634:bc7b:440e with SMTP id 4fb4d7f45d1cf-63678c9f531mr1070236a12.36.1759265466323;
        Tue, 30 Sep 2025 13:51:06 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae321csm10726140a12.24.2025.09.30.13.51.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 13:51:05 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-634bc2d6137so9285017a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:51:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/B2yKg0M//ihT6tW9zwmm+2w8qHNOWS5Y6S73D1imXr/7SEUKgjBes0So0drNMs7pzm87d4KAchNiMQw=@vger.kernel.org
X-Received: by 2002:a17:907:3f16:b0:b3f:f822:2d9b with SMTP id
 a640c23a62f3a-b46e2624e0amr109870066b.9.1759265465001; Tue, 30 Sep 2025
 13:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926102823.GAaNZqxzXkasrXXFjn@fat_crate.local>
In-Reply-To: <20250926102823.GAaNZqxzXkasrXXFjn@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Sep 2025 13:50:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibOJBAp66CPz0qfSWe93iisGvN4xL_MzuwSZ8sAut09A@mail.gmail.com>
X-Gm-Features: AS18NWDjELbR_yfUcTf-Bwg5AjTE-jRMFQK1zwGNV3AgH9YqtlkhR8ordnaNWT4
Message-ID: <CAHk-=wibOJBAp66CPz0qfSWe93iisGvN4xL_MzuwSZ8sAut09A@mail.gmail.com>
Subject: Re: [GIT PULL] x86/apic for v6.18-rc1
To: Borislav Petkov <bp@alien8.de>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 03:28, Borislav Petkov <bp@alien8.de> wrote:
>
> this branch contains two big features because it was deemed a better idea
> to merge them into one.

Ugh. I really wish that hadn't been done. I would much rather have
seen separate SEV and apic branches.

And I don't see the _point_. Yes, I see a conflict resolution. An
absolutely trivial one. So mixing up the SEV branch and the APIC side
seems to have had no actual reason or much commonality.

Oh well. I've taken this, but it really just seems ugly and pointless.

If there was a real *reason* for merging those branches, it sure as
hell isn't explained in said merge. That just has the "fix conflict"
explanation, and as mentioned that seems a really really bad reason.

          Linus

