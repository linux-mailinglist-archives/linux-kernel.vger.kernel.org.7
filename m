Return-Path: <linux-kernel+bounces-851043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F63BD5371
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8E018A5A62
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274D7296BD3;
	Mon, 13 Oct 2025 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDYbt3AY"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B5291C07
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374192; cv=none; b=hHPAsIoWSi6VE11m+8tEeY37HOo5MEhIoUUeE6VxxkceCvn16K2YvZuFCMzc3s5ppXFoDOJX+W5OcNZ7dsv9dDndso80s5nTdOSw0uishNEeLlmr9ghp6aF/ilPd4yaUZLetM1nFTAUa8jZGkt2SJRN34wzPLug222lh0uTAcJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374192; c=relaxed/simple;
	bh=kx5RY7oeloUuI7eYO+d6SROp0dR5EAAxdn5zrmZ7DwI=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:Date:References; b=JYxH6rJ1FwFGet6fVzc2AVP8pCclQIVnY4PXFHglHka1nu/fTv5qweAPBzsCR45ulOujxuj0HMbuN0wNpG7r/AKtXjqxEa4RXxerQYbRnm3TlMGeD3GAf87j1carTbpor5MyI28ICM3t8DfD/7tsRGvZD5EmQ0hr+tZwWJxPOaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDYbt3AY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso3798702a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760374190; x=1760978990; darn=vger.kernel.org;
        h=references:date:in-reply-to:subject:cc:to:from:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kx5RY7oeloUuI7eYO+d6SROp0dR5EAAxdn5zrmZ7DwI=;
        b=dDYbt3AYrsBt7gAEajsrCYu1CKtkOmgXVQqeA/WK6W2AQW/kjmZChSp1xHEOdBIBOP
         tjfpqPRdj0i9nErlbhZQoLKlJ7xCE4oL590RfQGK0FFa8JMdw1+5Yfr9k2lrMj4+z1Pl
         eVf5CA2UWp8qlUJv2TxjPFuUYhTsLftDjdMboCvrYUeDhguZdI4RdlnlvE6RQXBDtANg
         yDPd7JWeS6u13cT/3XKOesDWWzIl+59YHXmbOek6kUoDRjDd3lxBVvgSbZ9dN+Cahr/d
         0SBWZJDd6Hb/pUoOaswPq6DkEtnUtwbQF8PliZn4HUt1XEIm3Z1fzPqcIaZ6bFR7QhJd
         R79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760374190; x=1760978990;
        h=references:date:in-reply-to:subject:cc:to:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kx5RY7oeloUuI7eYO+d6SROp0dR5EAAxdn5zrmZ7DwI=;
        b=Ioi0g6E4aIUAbOQE5hOpe1F1hWv9nphqBhNVgk1K5ka7/O9380M0WBwLjKKsGmnHcZ
         awFZ0vHvpgQcf2v0pRmxy/iML9y3kRTE/DaGmCNeLgsBN2ToTWkTeckTgbPa2Qo4ptYE
         RmHzsLXa91eK4sXC5uvwfBu8RXvyidYkFHJDXpkOxB2UBUpOX1jl9dijj+TJV1AiHIUY
         4XwZVRIHTZo8x9NEHO9e+I8wBwCy5HzTY8Lvu/4Sr7u8TcSws7hleEcngOHvplQhTAFH
         T0Y5lQG9YBRWemrGPrzGtmai2TPhoLWPyhAiq7uxL0/mwpzI1Mvm5wNT/Ay2AjXL3y9x
         1Y8g==
X-Forwarded-Encrypted: i=1; AJvYcCX0s4Od8c0WP7B4lEVJAvCZbLgpzJ6ZlYlaVg5D2wLPqxSlanuCi/Qy2vYIl2ZLGYfiu8GFZt1W9Sg3cXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+AwiysefX6ll6s0LRcI+yfoFle/RbKFRTra5m6C2OUnmDlBjk
	tQ/6cKbZeYZ4ClNCH4iw2GbAWyi9v+d1ja9YR7lHJoLp1TQEKAW6BkWKv/Dr31PR
X-Gm-Gg: ASbGncskh6L6Fxy9LC86E7RWctZU9zwsYfzLhz3mNHQsm7K5UDBHvxHi5Wra3CPXH+P
	LVeeT9nnIwDu7H8ZPQ3/chVOLoqw5y4tRA9n262Mc3LA1v6UfLDD9Dbh0HCaHn6R8TUm4Lubl6m
	1IaEgafYcht09FGH4scNRIIIqkG6OKllpkNuqOe0AStrilr1PU5wRti3hcWA7qDAjOzi5CX2hh3
	mVqSP7xZTY/csxuCLwZ9PHWwAsWIsaHZUpnuyU7Ohgo6BgVoYRJ/+XkH21/zT7mZEdYcXooySiD
	anesOoIUvmdym11fhcHRsb4k4ytGh/cH8CK1L8pQ3zeUiGI4PT8rEGE+EqtdexUeIkF1FLG0DRF
	suHqhv2unF7I0sleqy5Gb9xVWOcCHE8WY
X-Google-Smtp-Source: AGHT+IHevJcBjt8mHUt/pyY93x641rdKkka0MNqxiQeyFCWUh9FBFG0xSjkzcIivii+OZab9HkGH1Q==
X-Received: by 2002:a17:90b:3909:b0:336:bfcf:c50b with SMTP id 98e67ed59e1d1-33b513865a2mr29845894a91.20.1760374189866;
        Mon, 13 Oct 2025 09:49:49 -0700 (PDT)
Received: from dw-tp ([171.76.87.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b7411fcf0sm6811568a91.4.2025.10.13.09.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 09:49:49 -0700 (PDT)
Message-ID: <68ed2dad.170a0220.37a345.0a48@mx.google.com>
X-Google-Original-Message-ID: <87wm4ylpge.fsf@ritesh.list@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Nam Cao <namcao@linutronix.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc, ocxl: Fix extraction of struct xive_irq_data
In-Reply-To: <20251008081359.1382699-1-namcao@linutronix.de>
Date: Mon, 13 Oct 2025 22:16:25 +0530
References: <20251008081359.1382699-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Nam Cao <namcao@linutronix.de> writes:

> Commit cc0cc23babc9 ("powerpc/xive: Untangle xive from child interrupt
> controller drivers") changed xive_irq_data to be stashed to chip_data
> instead of handler_data. However, multiple places are still attempting to
> read xive_irq_data from handler_data and get a NULL pointer deference bug.
>
> Update them to read xive_irq_data from chip_data.
>
> Non-XIVE files which touch xive_irq_data seem quite strange to me,
> especially the ocxl driver. I think there ought to be an alternative
> platform-independent solution, instead of touching XIVE's data directly.
> Therefore, I think this whole thing should be cleaned up. But perhaps I
> just misunderstand something. In any case, this cleanup would not be
> trivial; for now, just get things working again.
>
> Fixes: cc0cc23babc9 ("powerpc/xive: Untangle xive from child interrupt controller drivers")
> Reported-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Closes: https://lore.kernel.org/linuxppc-dev/68e48df8.170a0220.4b4b0.217d@mx.google.com/
> Signed-off-by: Nam Cao <namcao@linutronix.de>


Thanks Nam for the fix. I validated this with KVM on my POWER9 hardware and
this patch fixes the previosly reported problem at my end.

Feel free to add:
Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> # KVM

-ritesh

