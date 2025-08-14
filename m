Return-Path: <linux-kernel+bounces-769291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C415EB26C85
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D5FA07EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2B2D6417;
	Thu, 14 Aug 2025 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="0zJTZCIP"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0EF1E4A4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188639; cv=none; b=YoCrK48+KPCODjH7Z/QW+Kq51TSaefLJgiItDdjUoh8nSW/nNu8m5ki/KpKGWnX6YXLPPRWkFj/Ssb24Ut3bPQULEzt4KxshwM7wxk7aFKyRtVZ3znqVeyEdEeUpeMyExRfNvAQzhCNlHo3QRPKtPjyu73gU4bU6QMzIwYerq9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188639; c=relaxed/simple;
	bh=BquuVZ/pScBpjN9GSES87Hc5a3tiCrzPNxqElX9tydY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew7qOpPrEhrbXdrNJLFaH5enSnzGy/0KVcxGQSOT7qJt6PUHI4qoRrtFR0H7HWMl45eYQazxsRS5L4mxydEbOgAdhrGKUfmReu5aa0ugfYuOvCDidkTCjz5ENu7U4HkxyUB2uSlhB0egDiKdY3OhhWGwzw8eZDd4qVeeNGofJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=0zJTZCIP; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70a9282f475so10267186d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755188635; x=1755793435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1XdoI1EB+TYi+GTcXprk2z/DCeCB6Qa7ba6UyBEXK4=;
        b=0zJTZCIPCnu8afrVXw0YiQhB11fTz3ulcrM3i2EregQmtRvqAxyGf0Wv8Abq3gmaHL
         HgXlqdzXrWTHN8VbDkwtiNpdH5gUmk1kyEBSdgSUZXtpZ6pk12Ds2faiKYiRT6//w4dU
         aGVlGnhdS4aPq2O2LcrH9jA8skAE2pFp0aEnHysMIOsfDp+1cciSyXQjq5FHJ7iTpHb2
         rjArKiuWk0DdmjM4RGlOWBalK0ydw850QC7bkzHzh9jdcGWzcC0KyIV4wAhBTpLBifry
         zR3k2nAMyNrvI07zQYUunV8vF8FEhj8uYa/Z6jyUj15N7NAP7s6rlZslC8E1hC4bnMrd
         lnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188635; x=1755793435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1XdoI1EB+TYi+GTcXprk2z/DCeCB6Qa7ba6UyBEXK4=;
        b=UALRY3p9YsCUnwb/+AihyX6ywppCVr6FXz6pIll/oMnSaJjtKncFIkbltPOaoulsiv
         yDkBNXRWJydAbZHxjMKfINlHLY0HwPFC7WUfY81ZE8afgafDeGtSkfcaI3r/eOvn1QmH
         Dl03NE4cSbK9+YjPhVewBX3HB1Ke3R46E6+6Z2uVAWRkocH1RjegGd+F07epZbwOxpTP
         KYS1U90Q8rrB3iZHV2rmY1xYduKVyKvjhV+D4p94NwF2cnOTiUl47DwTTmPJ72xXWIkD
         BeNFAYwMs0kpao+8pRce8QEVO7uGVkwWnURQVWio8lAxeYHpMv7uzKy+CH7Ss1RCCa1E
         E0qw==
X-Forwarded-Encrypted: i=1; AJvYcCUVio6fb2CS+pJ8uJO79Jfccd/1VptA90yVdMpeDoPgG3wVntkc1tqo7eV7SzpF7nr8b+no1Nv7+Ng8OpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/458aok+Z4iEjVdkPX5DAExx6OjrVMEtr0S7CjohGg8XhQZEq
	Gntme1UI7rz7Whp4XiREzNheFCeP657XAYNcZZfqWIfN6+TLRpmCQiQTJwpkaYgNQ1U=
X-Gm-Gg: ASbGncv4KNBuRo4neGTjTvfOeUdrXf2ahmEDlS7MqIh6K1ukWUmsNevR5I65JDszJSO
	o4OKlQLY3+NIrRX7nPmByLI3rkFtqvpAd9DE0e18W169DvDEHx6gQ88lr7LVWzIYJYj50glz79V
	pHAwL/+gp7EcDglpisjwIRYRQNufVcpCip04bE5py3O3Vbo/o/53n3KKuhJkyB2ob71bYV9681n
	/We/eqfX32nyNzHZJf4/TOQJqL3wQYnwIrxqLtY6jAp9HjhZmPXNd1+BEptK78x5LYswdaE+sCV
	3v9QXfMSMTWHa6MuPWtZ11UEXYBsEPjbGlqvH1J4YdSaKGhx7NTQcj/5XPGzrWzpLO/E7G3z60e
	7YbLzBDkIo9FMFr88VZm0+Q==
X-Google-Smtp-Source: AGHT+IHjkmsqLPMIQBReIDsRlz8WV96jv+aEprdBTrsqjSADWIAiJ+wMvcoDhoVHcgHpljyWm6pdaQ==
X-Received: by 2002:a05:6214:2422:b0:704:f7d8:edfe with SMTP id 6a1803df08f44-70b98561840mr41169446d6.51.1755188634693;
        Thu, 14 Aug 2025 09:23:54 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70adc1cd94csm14860096d6.14.2025.08.14.09.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:23:54 -0700 (PDT)
Date: Thu, 14 Aug 2025 12:23:50 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page
 as-is
Message-ID: <20250814162350.GH115258@cmpxchg.org>
References: <20250812170046.56468-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812170046.56468-1-sj@kernel.org>

On Tue, Aug 12, 2025 at 10:00:46AM -0700, SeongJae Park wrote:
> When zswap writeback is enabled and it fails compressing a given page,
> the page is swapped out to the backing swap device.  This behavior
> breaks the zswap's writeback LRU order, and hence users can experience
> unexpected latency spikes.  If the page is compressed without failure,
> but results in a size of PAGE_SIZE, the LRU order is kept, but the
> decompression overhead for loading the page back on the later access is
> unnecessary.
> 
> Keep the LRU order and optimize unnecessary decompression overheads in
> those cases, by storing the original content as-is in zpool.  The length
> field of zswap_entry will be set appropriately, as PAGE_SIZE,  Hence
> whether it is saved as-is or not (whether decompression is unnecessary)
> is identified by 'zswap_entry->length == PAGE_SIZE'.
> 
> Because the uncompressed data is saved in zpool, same to the compressed
> ones, this introduces no change in terms of memory management including
> movability and migratability of involved pages.
> 
> This change is also not increasing per zswap entry metadata overhead.
> But as the number of incompressible pages increases, total zswap
> metadata overhead is proportionally increased.  The overhead should not
> be problematic in usual cases, since the zswap metadata for single zswap
> entry is much smaller than PAGE_SIZE, and in common zswap use cases
> there should be a sufficient amount of compressible pages.  Also it can
> be mitigated by the zswap writeback.
> 
> When the writeback is disabled, the additional overhead could be
> problematic.  For the case, keep the current behavior that just returns
> the failure and let swap_writeout() put the page back to the active LRU
> list in the case.
> 
> Knowing how many compression failures happened will be useful for future
> investigations.  investigations.  Add a new debugfs file, compress_fail,
> for the purpose.
> 
> Tests
> -----
> 
> I tested this patch using a simple self-written microbenchmark that is
> available at GitHub[1].  You can reproduce the test I did by executing
> run_tests.sh of the repo on your system.  Note that the repo's
> documentation is not good as of this writing, so you may need to read
> and use the code.
> 
> The basic test scenario is simple.  Run a test program making artificial
> accesses to memory having artificial content under memory.high-set
> memory limit and measure how many accesses were made in given time.
> 
> The test program repeatedly and randomly access three anonymous memory
> regions.  The regions are all 500 MiB size, and accessed in the same
> probability.  Two of those are filled up with a simple content that can
> easily be compressed, while the remaining one is filled up with a
> content that read from /dev/urandom, which is easy to fail at
> compressing to <PAGE_SIZE size.  The program runs for two minutes and
> prints out the number of accesses made every five seconds.
> 
> The test script runs the program under below seven configurations.

                                               four?

> - 0: memory.high is set to 2 GiB, zswap is disabled.
> - 1-1: memory.high is set to 1350 MiB, zswap is disabled.
> - 1-2: On 1-1, zswap is enabled without this patch.
> - 1-3: On 1-2, this patch is applied.

I'm not sure 0 and 1-1 are super interesting, since we care about
zswap performance under pressure before and after the patch.

> For all zswap enabled cases, zswap shrinker is enabled.

It would, however, be good to test without the shrinker as well, since
it's currently optional and not enabled by default.

The performance with the shrinker looks great, but if it regresses for
setups without the shrinker we need additional gating.

