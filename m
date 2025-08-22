Return-Path: <linux-kernel+bounces-781967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4313EB3196A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5747CA01928
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C302FFDDB;
	Fri, 22 Aug 2025 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhsZ5zAm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3BA2FC021
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868861; cv=none; b=C/MacaIjpAQEt5phOGwtIA3y7r0zmBQXrQdSnyLta9zfmxeAO8xY3qHp1zcw8VD7ZYX60052k3kgiqOOASQkB3XENjJF1jynUXfzGaRmt174KgUE5zqiD/H130q1ZQ/DMqQGIjK8vR7ZnqRpYwPQdygWVE/Uyix6x1A7yYSru/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868861; c=relaxed/simple;
	bh=RLk4D4vD/TDD8BadjDyMjnwONRBMR+yTQwbOQuHgP3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhhNrT3+13Kp3TMWAkWHgmbKZgdPnROP38qvaV9lO0c8JUy+fTDG6an2dtC2ARrel9dyJLbStZBefb0GwlgWKFxQPALXT55avoM3b4L4Wp/R/uwLhdfm+aBE4ql95BUsMdBTa/MVdoHKRI0N1MHr9grwmwv0LEDZ6aHm0ETPZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhsZ5zAm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755868858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3leSXfueIJ7OjI6bMt9yYc6dreSLbCTLjK5B3khIUcw=;
	b=bhsZ5zAmphH9jEZxu8LDouEg0FD4M8zdTt1JfhtbwuUES7adCAm/wwgq/vB96MMQkXqkdm
	i9UVcq3ciUf5MhkhAVaW3IofTPlpsgEDc4SxQwSAoHzxVS/OWQC+sdzi5HIWsgmoV/uI2U
	Dl2d+kj/YcJUX4CfTTc9cZ5VzUhv9yo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-iBoK4V0wOQCaZZasORBlhg-1; Fri, 22 Aug 2025 09:20:57 -0400
X-MC-Unique: iBoK4V0wOQCaZZasORBlhg-1
X-Mimecast-MFC-AGG-ID: iBoK4V0wOQCaZZasORBlhg_1755868857
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8706c668cso545437785a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755868856; x=1756473656;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3leSXfueIJ7OjI6bMt9yYc6dreSLbCTLjK5B3khIUcw=;
        b=DJ+9qh85CVPDw8qaKaTB3urgYxydeOOU94EVEog47Rn0i4tTuM4sftblPYx13dONXi
         auycQLTGquwoJz9imx/r/FxSqq8omKC8GlbPJbb4t7t9wQxU1VLPF8c5/8PDQ++8rCUX
         YYHnSkCcIa+kAjwRK0jX/urkVZYGvP0qoKcLsibopRwivafRZt78tVbbRn6WqZHQK/jV
         AifmnZjvz9OKseNqzoO6UOy7Wg8vqnfjsT7D9ai6SxQRES5Kb+/AjFj3w//A7Ox2p9fV
         DTXAu2TD8ve6siLBTT/1aTe6FQicZ1hgNqCUO49S8UvGwGB4Q5/LrkQtf2FBWdDWzCTx
         GZEg==
X-Forwarded-Encrypted: i=1; AJvYcCWW1LPvynJTWTs3EQIPNuQJtzV0lPuOxjUZv+QvnlSxTtdPw7YH7mweb2Wm1wZKmGIMor01Lykb3MYZ13w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyD69bFePesT9CpG4iX1zkF7QdQ4kblgujaYj9sGKhaKSjmknN
	FsV5QRAQRmNROomYEjmg6KKmBbnlzFzGqF5Eyo/Zl6i8y0vBm1w4PNPExR4/wOfMw9DVZy41Nyt
	4uadPhO6gFkeN4cWxhq2WZzmfkI01s8F402wBnFUr/jiGVtg6ZoasOI4MKOJiSQSPYg==
X-Gm-Gg: ASbGncvO6vXk+qwa6Bt0N7p8+wWQULIUdeFho1OXjFFotCWpXow3OGfXmUfaan5Gl/8
	JEjkF+1HnbWz91vuRqxUKBDSz0rrg4si2lp19bU0q9BRhni21F/WwP6k7l2xNpbY0fVOay40Xdg
	nl6xCvIALYrMwC7o1MRkg5G1gEv6iz/0CgouDpwFADnLl8UeP9kUvbgQtixqeEF/nLZuc6P6ENi
	1Xft/KGhPHeJbf3r520MCdXIEIW8lb3xkp/xd6cw1lm3IyFV8Nx9o3Kev8V4zpg2+Zm0Oc3kBM+
	Utj5SURb6c1RxQQAKMxiBU46lB4O5SvBUxtkL4bUpAt8T2kOQC3xsmihJ4HI82xKQsj1peRMBET
	45J0lyPdGVnFXi2I5hg0=
X-Received: by 2002:a05:620a:4723:b0:7d4:3bcc:85bf with SMTP id af79cd13be357-7ea10f96d7bmr350319585a.12.1755868856646;
        Fri, 22 Aug 2025 06:20:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJT6pAPKYEy5K11CQ9yMu+8+XejnwBM/iicip7wZSgoCGQVpWGHpC8P6vRS4lRcd6AamSOvw==
X-Received: by 2002:a05:620a:4723:b0:7d4:3bcc:85bf with SMTP id af79cd13be357-7ea10f96d7bmr350315285a.12.1755868856078;
        Fri, 22 Aug 2025 06:20:56 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e19211asm1338828085a.51.2025.08.22.06.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:20:55 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:20:53 -0400
From: Brian Masney <bmasney@redhat.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] clk: Use hashtable for global clk lookups
Message-ID: <aKhutc0IVWun83qF@x1>
References: <20250814035317.4112336-1-wenst@chromium.org>
 <20250814035317.4112336-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814035317.4112336-2-wenst@chromium.org>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Thu, Aug 14, 2025 at 11:53:16AM +0800, Chen-Yu Tsai wrote:
> A clk lookup using clk_core_lookup() is currently somewhat expensive
> since it has to walk the whole clk tree to find a match. This is
> extremely bad in the clk_core_init() function where it is used to look
> for clk name conflicts, which is always the worst case of walking the
> whole tree. Moreover, the number of clks checked increases as more
> clks are registered, causing each subsequent clk registration becoming
> slower.
> 
> Add a hashtable for doing clk lookups to replace the tree walk method.
> On arm64 this increases kernel memory usage by 4 KB for the hashtable,
> and 16 bytes (2 pointers) for |struct hlist_node| in each clk. On a
> platform with around 800 clks, this reduces the time spent in
> clk_core_lookup() significantly:
> 
>           |      PID 0      |     kworker     |
>           | before |  after | before |  after |
>     -------------------------------------------
>     avg   | 203 us | 2.7 us | 123 us | 1.5 us |
>     -------------------------------------------
>     min   | 4.7 us | 2.3 us | 102 us | 0.9 us |
>     -------------------------------------------
>     max   | 867 us | 4.8 us | 237 us | 3.5 us |
>     -------------------------------------------
>     culm  | 109 ms | 1.5 ms |  21 ms | 0.3 ms |
> 
> This in turn reduces the time spent in clk_hw_register(), and
> ultimately, boot time. On a different system with close to 700 clks,
> This reduces boot time by around 110 ms. While this doesn't seem like
> a lot, this helps in cases where minimizing boot time is important.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>
Tested-by: Brian Masney <bmasney@redhat.com>

I tested this on my Thinkpad x13s laptop, and clk_core_lookup() is
called 684 times on normal boot up of my system. Only 4 of those are
duplicate lookups.

Brian


