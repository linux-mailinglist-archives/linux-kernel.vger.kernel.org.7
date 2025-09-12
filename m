Return-Path: <linux-kernel+bounces-813226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D893AB54234
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F08483A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4792773D0;
	Fri, 12 Sep 2025 05:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hooFbfX9"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E37C270EC1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757656311; cv=none; b=MX7G7/ZnHrylr7rmmGAbS5RDst9xYsl2cCi2xdj96IqVS3HUzEaxGf/57HGB72MjuCIB+H2lfnyEcmzxSNSf4JbLlPLrHID8NdCay2NLRt6hhDSZoIJX9LsDdmuVN4JFcs4YdsxU143IQJfT+duIdBY/2YXq5c6PHUlZnRE+ETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757656311; c=relaxed/simple;
	bh=7i6b0HQZmpItcoHiRjDWPxsI+KEN2RjAWI+wYkI2Gzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ND9OpVrdjGrS+KK7mqtAb3q9hLkS9/7BBeWQRG5DuVkHAdCLRpzytqEbyjIx0z4kh8IXTlI/tm/UiFwS9rosLg2U5RXo+/brw6fjAQeClNcquRRsQiIExbrljF+B2Sr+fZ4+19s6bn8L+vO+I9BtR87NyYyiiKuf0Nv6zMDMizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hooFbfX9; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7728815e639so1205098b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 22:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757656309; x=1758261109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwxrf7orhL2KYO0iCZZdsGPUWyavjuMuxgjcqzj0tsA=;
        b=hooFbfX9qGIPRouDdpxKBh+VC5sYTXZliz4PmWvxPCKl127AIagsLLtwPvzPQBXWHP
         s4ekyjZzE1pcGPnQ0s5HDN/8EHEH4Vm4cCTG6oPTDCBSuu2ZdF16Zq2IqYg2/iKHJ7nI
         4IwiiHRCcKEiujfc8bI18/8dED7qymMVGHMAHCFHcO5V3hIyrrE+dU/BGvOHbNYJsGHa
         WfHh4XrwKEWttPfNv5Nw9NE7cfEfvp/vXkwGzC/TdDX7emiY5122jLuF9EdigCoNkO8Y
         4Su5s+5Rl6OMi23xBHWUrE9UiE4W5DSA4YCBfNaQR1X0D04uRrqtGVobhP4cr32bOK4Z
         lNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757656309; x=1758261109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wwxrf7orhL2KYO0iCZZdsGPUWyavjuMuxgjcqzj0tsA=;
        b=BxQEJkgFmMUoRUY/49mBdd4YupQU4xVAe1F2Db7kxF8JWEcZAD9zFbvEz6kdlhcNTd
         cR4RKb/TYHhV0gwSmxX61I/xZmYJxGttvrd73WKqyd8KzBNfQau8+hLv/r2xuA+Hx1aG
         +/+xU9lARAvVF1sovpMgpHxPdsd25SnOQ6s+rwJIiUyHFSsIAWbIdX0sLS2W4lx3GiPj
         9rOEi5Z2kXVJGKn7Py9RUJN9p1de0ySsEBCUcCvPdALOlnxW4HoJboB/yOYG+0T/axTY
         AaIN2BE+5dKrJ9R42nBsa/8kej3z+eUZFAXXbzAmdVNrFl9egjcCzS9iNzeC253NOuWu
         JPJA==
X-Gm-Message-State: AOJu0YyXlsHSLEoxYF5IoRMybMli5ddHVrf2t9jDxwhzGPpjJ+uyqNIQ
	w2VOZcM1Vn/aSQ1OOuwEM+OnlSHlbThCsMDjvd2vgiBrw5lDL11dMiov
X-Gm-Gg: ASbGnctOyZczDiqnsfO8FChojYR/zyGKkENn51jDT5e3hkp1s5o6JkkDIJRcEKDQdkF
	M/t3YSfKNRdaWsfiRk7ZSfvIIVU57pTu3QQvX4LWr2r2/tiTV9/OxCPVX3+lPtl7F17jr4HO9h6
	srdaHieF42ZMQGovO8iIEPJW05l3h2N4AW17PmLn66+lGT40YwyisAzdL8Xl2nMdqZfSxaMMp40
	FVwZD2N3LlCSA5YYsu1peMqC+2LO/ty85RMTd1FtFK3LZhrkeZPNSw2vM5Fi4zsz9Kln33ecMiT
	0a876FFLhDO9lvwC6CLpLPoaUxJTDIdHjGQBv3AvD2kc1yHDCXKqb1lupwYcptO5fd4F9ZwoY8I
	Duph9pkUxDQcugrlibMUEZYOPDJHX0Myxo8VQNCPjluu6KA==
X-Google-Smtp-Source: AGHT+IGzJaB63wIa8y1WxrhARLk2qyeDzg2l8cffF9pjyL26hVSSSTlaS01B7UHtSYXcq7zGWNVPeg==
X-Received: by 2002:a05:6a20:7f9c:b0:249:467e:ba68 with SMTP id adf61e73a8af0-2602c90cda4mr2342631637.50.1757656309414;
        Thu, 11 Sep 2025 22:51:49 -0700 (PDT)
Received: from localhost ([45.90.208.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761853866bsm450111b3a.95.2025.09.11.22.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 22:51:48 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:51:43 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com, "David S. Miller" <davem@davemloft.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/19] mm/ksw: Introduce real-time Kernel Stack Watch
 debugging tool
Message-ID: <aMO07xMDpDdDc1zm@mdev>
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910052335.1151048-1-wangjinchao600@gmail.com>

FYI: The current patchset contains lockdep issues due to the kprobe handler
running in NMI context. Please do not spend time reviewing this version.
Thanks.
-- 
Jinchao

