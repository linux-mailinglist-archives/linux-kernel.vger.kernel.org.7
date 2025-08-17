Return-Path: <linux-kernel+bounces-772429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FEBB2928B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 11:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3393189C197
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 09:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91632309AA;
	Sun, 17 Aug 2025 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeZoIt7a"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50D1D61BB;
	Sun, 17 Aug 2025 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755424518; cv=none; b=GpcKALQaftVs6E9GDXTF1pkqXrFNjZXxIHRSCsAtxzNX8uoXp3y0wK80pfCJRbnV8lbTXOUXTNRlux3f6YJ7/6FsAr1Fl8zAx2PO4xDy667XVrgB3r5wIPaxTDpZ4nsymwu7HuyMe0AEDsyqKr+8rIneY73jilLWTM+1Rpe21RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755424518; c=relaxed/simple;
	bh=5mGqUIDf+LX8bqGv7TzokLroBn0Pqi6DYGaWVlXHAPI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qe+KxX5LbDQoCKeR7zE9GO80Tz6vmxVy4yMIebepRWhj3TC82CcQF5nPp1IoQ88YcaChgfk9lNCyn0fo0KmAFbpQ+2jkiUTDHuixcaAm8MjoRx1r2oxhKC1QFtgE9bWEvlzRtkMxco7ZxcTtDoGQVk98eaxEHaCdK/cqM/v6tFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeZoIt7a; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4717390ad7so2191682a12.1;
        Sun, 17 Aug 2025 02:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755424515; x=1756029315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1cmvwdDq9fEzI7gI5zVxq5BwjnNnPgACKd9WbNXnBmE=;
        b=TeZoIt7aLfhiMwp7d7HKm2DE+2rZ7hHF4FM3YFQxBIJ7aTNhnUF3ujsQFGOyMKct0X
         wMR05QtNrnq6BLYzWWKewwoqnzx1GDM2Uc4+LREdwfcCAHwp5Jny38c6fDW5m7Z205v9
         vIO6rCDYMytHc2K3Qs3FUGNGQ+gvQTcYQnwKm4AI7OZGGDxMFV87e6yKh89K8e012BMc
         6hX5ILznr47E5FYVtI2ZYo0nrjAIrdPOalQBtDfUHKWjgeryBE8KDPj4b5G5V4nqCXvy
         Ei7cKtdXmFpqj6iWaEIGqPkXyRjYnOVbOERE2tzc6w7kJtPALHWr1kmIVPoPV5kHlQ5i
         5tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755424515; x=1756029315;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cmvwdDq9fEzI7gI5zVxq5BwjnNnPgACKd9WbNXnBmE=;
        b=c7wKMlxHn3FIxpil84ts3Z+BP0hj2Qkc3B5jTprYulDwp8IBiCxRZKogYi9n8lrJIC
         6W/BSsttXKz/T09yMdW8l6WEnKob1yeHInNq8s2f/V70aZdkXoBtGNK9gR8lRojHQnEK
         7j4mW0dIh/9LUcyGMn0LyaOPDjGHe0J5Wxubqyk79hAp1j9fNJnbRcgj8HfXLlU5aK7F
         N2zW9u56r1rw08FldycJ4DwpEh3YWpLpPqnRdF6gxiUKajVt8RpPqoLtXFGHPncIuuje
         0zj3zgQv/8+CXnu6yg9k9RDRU7PJFDnGjc/tC1RZdAMorXGSp1DJHB3j1yAffzI5lZ7f
         orkw==
X-Forwarded-Encrypted: i=1; AJvYcCW2YjuXgd8KP4epFLSgLxwqYswkNxwex4SuAV2xNT8/6PL9M7IFG5imC04qQwZyAeRiKRaXK84NXYU=@vger.kernel.org, AJvYcCWGyS47LP4uEPsRS6SWnAGbZiuYfICHRNu8GTS6mUXqedGkax6gclHvBetT4z5zA3HjbQ2ELWs6I7XAtCsY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9eakJ2zlt3aE9jtLl0t3H6XxdEsr2nSDoo3rCh8x1x0JD/Zmu
	b5mBKOgAE77URqDk2qQLxtSPJjAKzY6+WG3HJo59qAk1Sh63Ng4oEuXbhVNc7g==
X-Gm-Gg: ASbGncsEtiATc7w/LRZAZh+sDYwsJDcfrRmB4nmLp4fcoY7nJdXUQs6qTL1iza1LWPK
	dY3QhU9sAKs3B3SC/btHIo2M0ZfesQ0gyDc3xbLjWFXkXnpWiyJL1c3f0guncs6f7+qih0VahkY
	eGZBoRIirafYoS5POndX0H35ToTWNZ9J0tPTOASBBC73zFvtp1jhtzoQYp5QpoUgFt0ieL6EJi9
	6Ia9I1CiKXJIL5pVmmHT91npJ6WOecMgNlYvdENSOZPOqYB+1BSohltqWNr3/4IgWvD0QFfQyj6
	/UTBnaWz9pfYTwalbV7zd691kVL4PCgoVwfwkn28rgIODA3fNbckqo4nI5wq5W8moG2GpRaShYW
	cC0AQmZvhHmgxEK3Qe497SBrzPRoWybcGyasyVAFWQb2anK4NqJ0RybuCjPd2qE7RBAhC
X-Google-Smtp-Source: AGHT+IH1Axs+2f8ZFd8sImHvAUvBgL0gAUZ3lcY6HEZqk8DFv+ake24/oVXSE8Kf/UsSHzPjEihHYg==
X-Received: by 2002:a17:903:3c6f:b0:23f:df56:c74c with SMTP id d9443c01a7336-2446d715b0bmr99414185ad.14.1755424514982;
        Sun, 17 Aug 2025 02:55:14 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d554619sm52022805ad.141.2025.08.17.02.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 02:55:14 -0700 (PDT)
Message-ID: <acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
Date: Sun, 17 Aug 2025 18:46:35 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
 <773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
 <20250816135538.733b80d3@foz.lan>
Content-Language: en-US
In-Reply-To: <20250816135538.733b80d3@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[-CC: bpf@vger]

On Sat, 16 Aug 2025 13:55:38 +0200, Mauro Carvalho Chehab wrote:
> Em Sat, 16 Aug 2025 14:06:43 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 

[...]

> Works for me, but let's do it on a separate series. I still have more
> than 100 patches on my pile to be merged. This series is focused on
> making at least some PDFs to build where possible, addressing major
> problems at conf.py that are causing LaTeX to not work on several
> distros and to fix wrong package dependencies(*).
> 
> I'll add a TODO item on my queue to replace fom ImageMagick to
> Inkscape on a separate series.
> 
> (*) One of such problem you blamed sphinx-build-wrapper, but 
>     the issue is actually addressed on this series with fixes to conf.py: 
>     there are currently several troubles at latex_documents list and at
>     latex_elements.
> 
>     Those are causing wrong font detection on LaTeX.

I couldn't see what you are talking about at first, because there
have not been any such issues reported.

Also, after applying 1/11 ... 4/11 on top of current docs-next
(commit 0bbc2548ea85 ("Merge branch 'pre-install' into docs-mw"),
despite the changelog of 5/11 which claims to fix an issue under
debian, I couldn't reproduce the "! Corrupted NFSS tables" error
under Ubuntu 24.04 (noble).

I'm confused ...  How can I reproduce this?

It's getting really hard for me to keep up with your pace of changes
in doc build scripts, really.

Akira

