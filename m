Return-Path: <linux-kernel+bounces-723842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE597AFEB57
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3069B401C2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FCD2E7F35;
	Wed,  9 Jul 2025 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="sNp28bkW"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461FE2E7F21
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070002; cv=none; b=NpDIDL/r7qJRjLOQVUz7W07VNQA+yxkFKeBAlpdT3/d5jPYyzyBCdY9+ArhoFzQLXNY7ix30M9BvMYdlSIRv2VoqF6/RrYKzPad9rA0cUDDCGS9adLi4GYfFhIy+7XIM1jfoFxv5PUo5PySNkRnXu32G70VWfKcLx2yBXmb7uEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070002; c=relaxed/simple;
	bh=656Vgjt0F/Iys54NK/hbJwcusVSIdUYU+XtWq40qi18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoTeXyqziFaxyEyXz+lrWBkpanUaPBW4imWJgAEGnz8JKs/jy0Yw0nN1YNjikaHbPINNMBSmAbhv6kISYtTy5S6RKZyseN5cQY9nEL+I1NYjXRdFK6yIjdciEcqPPVqWGR2vpFX0HZHIVPw3mXUZfaf/a0I/q4p5wMZpYDuu+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=sNp28bkW; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fada2dd785so78262636d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1752069998; x=1752674798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=656Vgjt0F/Iys54NK/hbJwcusVSIdUYU+XtWq40qi18=;
        b=sNp28bkWQ/FcVJcbScMzJKE8f+EP/jK/3Usj+HPwvme/PcSuc88PSxYQQNDKhWuG0U
         HcBRcb3wcM1PTeQ08RqiEAN+kRea8b6zsJv9+CDpLY6NuxkpE/hrwcSRra3LktpL0bv5
         sCsamtwUy1oj0ojxlK8hFTBfZnsVjFV9zEu6mRNQE/5mmcnGmXSQZ5RvsUmcV6PNcma2
         btvyF7C8rr8NoLleJNslYL7HXRqfmcIB7fgwA0b6E3SpCDHgbfOVoKm+mK9v2jYX6wCz
         pxbx01HXRrTLjMafPpco4jF/OUc8LJToqMEWKfcwTZOHgEMBtPjlngpf1LwJFGjAExzj
         Igng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069998; x=1752674798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=656Vgjt0F/Iys54NK/hbJwcusVSIdUYU+XtWq40qi18=;
        b=t5i3+5YjvwmU8TvXh1Q3Vua3pakNxY3CtJGOCynCuxLuGilC5tZ1i40qj7i6K9zFRR
         WKZwIhcgbBDiI2d6SU62jvFcZSiLuZmGYBOJlK5CE4vHSKzwxFF+fwt+g5N+rzta8o7Z
         m8gtnhVi6CIWpI73z9S+9BKTuIfsonDpjQxwhqPDa8RGijd0Z2fOlJ9bMbuPSPr9uzIo
         tqjvNNPoJxQzsWxguCL/6yF3M8Acg6TaKoz5SkckgI5osfk9o/HqVGkLIUCPAzwhiMOc
         P2W5WkZcGKirg4OUyjljhmx6KRx9/oS+Z7bKByLv+ALIiw+ru1KsZf7HwzlY5x9T3ADz
         qajw==
X-Forwarded-Encrypted: i=1; AJvYcCUtFfrBaYLS8I0UpQ007PMbvfChArftZ68i0oSH4Cs00slR/XlUG+ou2qioMt/Xst0ZmlKiaAWRk1XLBvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYXoUPvnptr9s0J95Sji0+uQJYTmfOXbet0Kbbsu1KJwwR/fOU
	H1/EXAacogLLxt0ed0f2PTjV4lCT6NQ9pFSu345QotkDcBHlGheQQZL8RWRnrx6G4OE=
X-Gm-Gg: ASbGncs/PMuxBaIBxw+ZMVbE4BbNKJKK1qJu1vOQYdL602q2qQ4CMA/M1TjA8jx9Rn0
	LSeJCuO7wD4+1pqmOZGohCZH7U43hEOLTeWh4kr/HbUnWQ8fLueQm+lHBiNQhQHeQh+mUQGIqxT
	OKohBWC09fFeXKGqkHCnZtajcJzuL03vfVC1f5TeISC4pe8ULNJ1ROSyiz/hB/fYvzzQHJlCozv
	0pAFMBgYvOp08qPn9oMbYP0SP+20/WODvWpgEHiBeUh1M7Ru8XJV0EJ0rfTl2M5z5Rjn2/wliB9
	BRcCXf5YiLNeh4VY+FUloukrRakHSyAlN9sjxhgweCw=
X-Google-Smtp-Source: AGHT+IGXZd6H4Kkpfx6dM+K4pFtqC4HUPrp+lQt3iGZRub8DP9kRV2d9wVb5zcj0U+N0mplxba6xWA==
X-Received: by 2002:a05:6214:3bc8:b0:6fb:5f1d:bf8c with SMTP id 6a1803df08f44-70494e89f20mr923456d6.11.1752069997580;
        Wed, 09 Jul 2025 07:06:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:600::1:587e])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-702c4ccd65dsm91355526d6.37.2025.07.09.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:06:36 -0700 (PDT)
Date: Wed, 9 Jul 2025 10:06:35 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: Re: [PATCH] mm: zswap: add myself back to MAINTAINERS
Message-ID: <20250709140635.GA56533@cmpxchg.org>
References: <20250709123438.794466-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709123438.794466-1-vitaly.wool@konsulko.se>

On Wed, Jul 09, 2025 at 02:34:38PM +0200, Vitaly Wool wrote:
> The patch removing me from MAINTAINERS was sent when I was on a
> winter vacation. Missed it then, my bad, but never acked it either.

The maintainer change was based on an influx of code contributions by
new shareholders, but also an extended period of unresponsiveness by
the previous maintainers on these new changes.

You flagging this change 1.5 years later is sort of a case in point.

Anyway, the other two maintainers acked it. I'm comfortable going with
majority vote, and keeping the maintainer list as-is.

Thanks

