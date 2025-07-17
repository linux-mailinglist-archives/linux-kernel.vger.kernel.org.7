Return-Path: <linux-kernel+bounces-734747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88096B085C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5CDA46322
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4202D21B9DA;
	Thu, 17 Jul 2025 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFF79MiQ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F7421B9E0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735513; cv=none; b=QZ81Ht2qye7KS06Nyoqq6jlUyg1ss8nUn20dUQvzWyytk6CrbWt178HJAu53X7Go1ijPvbonJ7zoyQE+EbfS3Hq7dRBpK49MP+p2acXofuFaIpKv5JF33XM4ueEPTl0pNLmV5+nLRjgsrhbu+QIKTeSWTTkPPbIA0VNVByoqDTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735513; c=relaxed/simple;
	bh=z3nRmP03paZuTUzH3iYR6M8dSi+f4ZtXMFt7dicR0HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVyV3owgNdHB4Y691B2AMaAsJPsPT98Pys1jBURmwGXcanWYpoOPf+5w2toAA9njSl82GQ1E69B8+QWmaH4MF0FWuZtuM467lCSTzPXcH1nuzmXXW5jqHyMFLolKVPyHQX+/UbX6BUp61V7jJBGJUSjgNs0AWtmqRB/mw9nxDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFF79MiQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so118729666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752735510; x=1753340310; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9STJgt6LNRXF8Cd0XAEgDs1R//egyDOpIAZsOSygi9Q=;
        b=IFF79MiQbfSPL8FNH7TqLYKSFRyS3biotGYNN6kSNCF244WOv0wmO0eq+iJXRwjo5z
         YIDb4ekVXn2dMv810C7zEPu3hQBnMeqSlG0L/QI6TgUNDxKWulpH0NPnOy30AJTnxuGQ
         mGwqb3pABIztx8u7NQ1fg9z3cQOeELeRJH6C42F14Yp71kk8OXNAEwsYW8LBX+Nr6wb7
         mNlaz3E/l5Spdc6/4yDuukeYU6rU19em8vwkE+0zxgzv1vaItlTs0P5O6Yj1EBnL7Pck
         FPRjT8ohrCuTmJ2j0Zy9W8OFo3rC69utLHwsAPkpz9ZViGEpA685j+eSXTtshYOYIyx+
         ILCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752735510; x=1753340310;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9STJgt6LNRXF8Cd0XAEgDs1R//egyDOpIAZsOSygi9Q=;
        b=uwrSluHn3BEyTw3uzsHRcEf1HfxUrfAmv/cCKdnlZkr4tciryDhIuiF54XIhxew7V3
         PoAi1J9X9JyR9akN9821wZ5qrD2gaN1jQehpmuZJ/R2bbvSRRfL4rPNC0NZWhF2C60xQ
         zUI3ppmTo/fNVlngVerHSbRMa41ynqgVv1GeeW1i5xH5hK0ieFJRNqK+CMzhSOZLshuT
         z8NQcafC7aVQT6PhSaSvCyQ8gyCdNUpPbaJnYCByIr66osIH4yckOSfJl3y0ElzXeJSC
         ktpRbcfCKLHD++qXHTlr9pFypc7eqHl+DJ2oD8iGYRlyau//8++nboCzYILHYyY+9tNh
         N/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMK4sMQRGnbdNX9jtc/qwXmMMkTxpQLYqwOmj/Y6Xa43LGYFWNLHowskeBgVeIcgefVQr1uu5igoLVe5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZOx2Ltlsob0qwzc+hxXV0w7WQ6lUKmZhjTB66xVRC8HhnrJDf
	LB6YmJD1R17Qe2PDzEwDuzcILkJDyO3/9pe9yBXNHXfxHIawCwtz8oW1
X-Gm-Gg: ASbGnctW6lhqKogDAJJi7/FW5xoxObZveis6kIRf36e8szUEiGUMsX/di6gLwjIak7g
	1A7+QuUtmxc9WmZyqhPcAMvk/zmbNOHRzRegyWCRhrKX77Z8pyaQkpea+cYqcDmB1HNkKeoFF3F
	oAtW5AdpnRfiKlQSfk/p7gFQaMNDn2bOcdkeKeamJOilt6yOTKHqkmXfJPWWQl4e36Zp81d4AdE
	ITj/QMrIMZDVv66m7xTV5msJyFaKPQw7C39kFS9Gi25+xvA/C4cEWFlE9RTYub9XbblnP4peXIc
	fVe+n3lehZfcBKGQIVwaxeSj1x3tyFyzuIMJL4quwixo7uG7qMJXyKbukLYHnhwHHSmmYOen9DG
	5GkZOyu//ezw7wGLd6gC7eA==
X-Google-Smtp-Source: AGHT+IGSuH9rjFfBTBD2n4nfGvgPIPAZkajjUrkNKRCRWx0KFpdpdNstIYlk22ZqsSFJbLNieAfhbw==
X-Received: by 2002:a17:906:7315:b0:ae3:53b3:b67d with SMTP id a640c23a62f3a-ae9cddb6bb5mr521005066b.1.1752735509829;
        Wed, 16 Jul 2025 23:58:29 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7eeae5fsm1314148266b.64.2025.07.16.23.58.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jul 2025 23:58:29 -0700 (PDT)
Date: Thu, 17 Jul 2025 06:58:28 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: wang lian <lianux.mm@gmail.com>, broonie@kernel.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, sj@kernel.org, ziy@nvidia.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jannh@google.com, Liam.Howlett@oracle.com,
	shuah@kernel.org, vbabka@suse.cz, ludovico.zy.wu@gmail.com,
	gkwang@linx-info.com, p1ucky0923@gmail.com, ryncsn@gmail.com,
	zijing.zhang@proton.me
Subject: Re: [PATCH] selftests/mm: reuse FORCE_READ to replace "asm
 volatile("" : "+r" (XXX));"
Message-ID: <20250717065828.cxnjfrl3iir5eb6y@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250716123126.3851-1-lianux.mm@gmail.com>
 <20250716151543.998b121a58064011e9ce68cb@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716151543.998b121a58064011e9ce68cb@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Jul 16, 2025 at 03:15:43PM -0700, Andrew Morton wrote:
>On Wed, 16 Jul 2025 20:31:26 +0800 wang lian <lianux.mm@gmail.com> wrote:
>
>> Several mm selftests use the `asm volatile("" : "+r" (variable));`
>> construct to force a read of a variable, preventing the compiler from
>> optimizing away the memory access. This idiom is cryptic and duplicated
>> across multiple test files.
>> 
>> Following a suggestion from David[1], this patch refactors this
>> common pattern into a FORCE_READ() macro
>> 
>>  tools/testing/selftests/mm/cow.c              | 30 +++++++++----------
>>  tools/testing/selftests/mm/hugetlb-madvise.c  |  5 +---
>>  tools/testing/selftests/mm/migration.c        | 13 ++++----
>>  tools/testing/selftests/mm/pagemap_ioctl.c    |  4 +--
>>  .../selftests/mm/split_huge_page_test.c       |  4 +--
>>  5 files changed, 24 insertions(+), 32 deletions(-)
>
>The patch forgot to move the FORCE_READ definition into a header?
>

I get this after applying the patch.

cow.c:1559:9: warning: implicit declaration of function ‘FORCE_READ’; did you mean ‘LOCK_READ’? [-Wimplicit-function-declaration]
 1559 |         FORCE_READ(mem);

-- 
Wei Yang
Help you, Help me

