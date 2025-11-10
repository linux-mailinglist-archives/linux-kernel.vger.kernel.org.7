Return-Path: <linux-kernel+bounces-893411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92379C474DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4D924ED151
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE6D31329C;
	Mon, 10 Nov 2025 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UnIfQ7S/"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590B43128BA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785865; cv=none; b=pq66HPSXazgFc1PorLQjttz6SYqqNH4DBSRpCFWPRcv6fgz5Ni8aPGK/83N7SXrDKkJ3J9YEPf3Tm5SrNKrkKuhY9j3feWxkzcXc5oCujc3wLYCpp5QV9LuCVuOM0sr9l5b9BruZwquB4VuZR1t+J5jRFfl0EOmJ3Wz0xCW9APE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785865; c=relaxed/simple;
	bh=SmwGbUXi5DQW1GACvE/iZjpHBvXn1kXiV5oloO8GZ90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0MfURAjPr/caSkPiexbnfqURqRfuopih/F38v4Zce+NeQQNocOgCECJ3Sk11HnwKrbUp1OI/xTWjWN+eHxyAnbV9Emqu2+Fod7rzUY3S9adkL4nrwf4CE3Wqct38YjaiPzlsVcp0fpINNNfUt+HK0jHUNglpTp0JjoHxkVRotY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UnIfQ7S/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b6d402422c2so622401466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762785861; x=1763390661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cWkbWo0C2FaV9YbiYoLsjm6xrzwxAQArLPqLCYr9XSE=;
        b=UnIfQ7S/clT1vHF55yNSPyIB9CgIHrCRa+uf2ZiK6iWZXLKoRlctQPXxNN5sYn+WKC
         eTrliOYJWvBcJAgj//6PolbItiH6ZJSgrIwW0ZOfZhHsEGTS7pP2wHf1a4VnDLn90MY0
         7p87J+fZRdSD5+UYA3tdY/2Gc+bbnF/xiHyw799QlDKBabQ9BXFAWQyh8k9y2b25bo8e
         37qoB7YSv5CFHYTBwbeqmJJHpacbgn2eWm26L7++W2v+opbb/N4iY/5nWGf0NE76Z9Ff
         fn/9y/IkytkHIx4F6cDcJJ1FnFu1hPehEAdZ6q9yruBrB+IqMXn/s5rsiNh0uzALo1du
         +I0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762785861; x=1763390661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWkbWo0C2FaV9YbiYoLsjm6xrzwxAQArLPqLCYr9XSE=;
        b=OEZuy7A2eHzjyObvfgt/5Qo46gZumY+e6wZ8q9RTNnxMwUGhai3NIK4XXWWJ/kXB8e
         MxfDUxQ2ZMGB5v76lPgzm82V0ACnwYzunOMTRD9wmfm/2/DnkbYaCX4U6TgKpDc8JS8c
         3Hxsxn8scQS3nqXbMe7lunbsnZTuVW9lVBAADkcUCFexc7SRVSDbV+ysILaUi+PXUmWd
         alvIzStcXw5GVQXi1r5Mb57FwQoAcAGtAfuqAdUeGqksivMLoTofRTXWnInFXf5tC/mA
         O3mX/eTVu+2tXXzTszwcgy/WYOm8ofBDqFHUz69h2UhAX2rHM7+v31Gd65MQAQfRfOZK
         uqLg==
X-Gm-Message-State: AOJu0YwjVxT9ttl+dbH3uHItgWQb7J9Gnm+/lBADDjlW6h/gDpjweVzf
	BaK1eHfVkQQwPuo/LaAlqAZtNQq0sLkKI8YX2LJHzbg6uevGK50qHWzGb2LKYct1wT8=
X-Gm-Gg: ASbGncv2ticfJ+Yoz0PrFo5u3GbqIYlaQVgI+0vvlXZ7NziRuVYsxN6Z2dlMjxP4eKA
	jWmmp2rfioUk5ztZ/BK4qh/rKRUS/7Nxm0LHOAXqYZWh0cCfPLbpjpycm7XDtbWADKt23VpUzQT
	HzwzBjMxDTNxPt8SDL523Qczjb2PoGdSMSrwNQUFMvy8b920htGzLA4Hjv2A7S5VLViLoXGK0Tj
	Dv7dLkjNmuWXH9oygpnZ+6x5p3OOeUVFPiDaSr9+OXh9pRAausz4P9ZWVxq2cNl51AhWtxqDonw
	5HcTTLRx4aFtGtllOh6yNxm7F7bvdPHlIOvZFi3A353/esTkE5S8XE17ruomUP14ap3BsR6K/av
	FDtUCqdka835YSWrG9UIxsrtAc9ZX9l9Li1SeYy8hpQ6WO4dghosfw99kCqkSCtn9uUHj1qRPd8
	j0yq5my168Ti2b6g==
X-Google-Smtp-Source: AGHT+IG8GbrJLNCngeSUddvtLroajOs9HoKXq20Qw/co3vDwQoCKgoCUMZrnEIKWIn7J093BEvHeDA==
X-Received: by 2002:a17:907:847:b0:b72:60d9:32b0 with SMTP id a640c23a62f3a-b72e0285e02mr897471766b.3.1762785860621;
        Mon, 10 Nov 2025 06:44:20 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bd72bsm1107316966b.49.2025.11.10.06.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:44:20 -0800 (PST)
Date: Mon, 10 Nov 2025 15:44:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] lib/vsprintf: Check pointer before dereferencing
 in time_and_date()
Message-ID: <aRH6QqRPf7XrYTDg@pathway.suse.cz>
References: <20251110132118.4113976-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110132118.4113976-1-andriy.shevchenko@linux.intel.com>

On Mon 2025-11-10 14:21:18, Andy Shevchenko wrote:
> The pointer may be invalid when gets to the printf(). In particular
> the time_and_date() dereferencing it in some cases without checking.
> 
> Move the check from rtc_str() to time_and_date() to cover all cases.
> 
> Fixes: 7daac5b2fdf8 ("lib/vsprintf: Print time64_t in human readable format")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

