Return-Path: <linux-kernel+bounces-893732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B289AC48359
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0177A4F1E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0A93148BB;
	Mon, 10 Nov 2025 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bhMsrdUp"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284B30E0F1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793561; cv=none; b=ZegdC8XjzQSyDTJs38dkQ5It4uGtdEOGPfpmnRWobw1hqtpp8COsUtFoanaO+IB+eFc7YqOHTyV61alLAfvzs6Ec/LD5l5OtE+Z6aYzCyY0BPfZOLuPjOaeiWgfvWFkLYm4B7UJPBGpY5gFSoeITUvnQH7jVvXJHJgS2ctJYj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793561; c=relaxed/simple;
	bh=Tr8jy5Uv1Hg6kF8O3bdp7h65v9dreX5VhIeIqr0/r7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az6LA1mUe9lP6n+HcyElIzHpSv+W26Wc+ebygKk/5bba0c54IUB5Pws62EAk+UkRph/2OaAXRoR/FcHTzxPlGJci0OTaY0EC8N5YE1qSuikJPSr/JqmXWigwQeNGoYWg4YdjPBre1ox5Rundj0MRhBTuvM64O3ATZgLijHOJ2FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bhMsrdUp; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b403bb7843eso589827366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762793557; x=1763398357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/4RqD90tySiRBMIs+YyAn5XCZ9L9SFkeI78NBN/f4w=;
        b=bhMsrdUp50pIM/GQla3eEzwJp7+6CDnjlRwbuWKSvavG6JyASsKzw29mJ1q2C9yOWo
         I8Ot0HPMBXz7pNHWEkZgRqLZWORAQJa9BGm1XUWNX8jexbGnb+5KBC6a82EKpiMPn3Sr
         Z5WvF8YPTqJg39xx8dLh60EjTTaF2AUbpjuEakj6d1KsUvWVk1HCNSv8Hqxw0w5u/w8/
         urmN6qqUk+Ql+PImMXtIA5fqjmfDod1jYbTRNOJvd5kzDKV+iuzy8/m3BLpSNqeoVCnU
         ZsfC0hY+BobdQfaNNmoFTCry49VjW7+BcA+OALQBC2g0rBRqxvwX5qHyikb/AxNux7QY
         KvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793557; x=1763398357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/4RqD90tySiRBMIs+YyAn5XCZ9L9SFkeI78NBN/f4w=;
        b=gtjom0FWEt8jMR0ZXfYgFPjuo0JxJaob+p6lQrLSz+LJpFUamhJ7Nd2AjBcFySfHtv
         OQhMSAVF/0dHOlwSwhfXw5mMkDY0OshjucDcE2Qb/s6z5raKPk6wGG93KqoJO24tUYLQ
         vBEaBHbyYVxZVe/LQqH8F72KKuOM8MOIR0YYO4bpSYJklQ00EYH18nkbOzmuD9dTS2VR
         Kbnp2KZA2T+GAzA4meqfMfGEIr42VOrZxPmiGEJybRZPle2re6gBIQRC0mYm7+R3Xxel
         me+sk0WYQhPaYUZGzPUIA/FGF88iTgacuP/92T8FQFPxfLJRAD8FFpCdvN1AmjfvnJxu
         U7TA==
X-Forwarded-Encrypted: i=1; AJvYcCWnGPhTG8ZVMGnJVGgwIuAnN5oCcOCFx4hXMv9+Rbnbh6R/SM6QX7I4HKB+tNupmOFEDYURt20Bm1wMQxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylXaIPJQfvz41lr0Gyb3w+RykhAQzxlv0zztrpe5w7rq4hWgD1
	Jg9wBqxSYT2MVjW1mn2xYCXdC3PEO1SIS7rUI5dEHmYdBzCq5qqejFqKaNvAUUkaL8KmPP1UIw8
	UeU3P
X-Gm-Gg: ASbGncuma7M6GGY+yiDx7Cug8v6OQL+lMA3rnyszne/SroiY3cGlxpqqmmsUPpfcqWx
	Cyuy9LTXmqFY1ODHGkDhERKVqjL53QahhXxq5J2xWwUVIQ1+At9YcwZSzI0YLFxC8oe+NDouDZJ
	NsPAY0SVmzRAt+0PxXohs2r+3I+XmQTxNJddju5rtbrnEuBY/kISMBImCdb1+Pvt9YaxrxFO19g
	yXtlF/AA6VSldQN65NzLh6hFYQAhghgVfKHmmJzR2p44Zq02wk4Jipvitk3C9eymTymAR8Zu0Eg
	I2E/tZ0EpyrYpUgJFWj8x+X7wHFxaR8x+7mo5juhGN0eumauRzUVAlRz9ShhA2pAwrdfI0QB1i5
	c9cDnmzig1awYl7W34nKerAbmJJMu+84Zf2J+R7dCOjRxiHjNruQ0Io2D1I7oY7M6q+05VV1lHb
	pF3auJMj4dqqdN6g==
X-Google-Smtp-Source: AGHT+IFR+ASHYCqb9BnD5OHuuIplJT9cyfwUPwyvKGHQp1tShZlDKLMVRhP8BcHW44EQ05Hok4HDPg==
X-Received: by 2002:a17:907:3fa4:b0:b72:ad95:c1c2 with SMTP id a640c23a62f3a-b72e0286ee9mr848674066b.11.1762793557422;
        Mon, 10 Nov 2025 08:52:37 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d3baf872sm995452466b.27.2025.11.10.08.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:52:37 -0800 (PST)
Date: Mon, 10 Nov 2025 17:52:35 +0100
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <ioworker0@gmail.com>, paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] docs: panic: correct some sys_ifo names in sysctl doc
Message-ID: <aRIYUzM65_ZigeIU@pathway.suse.cz>
References: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
 <20251106023032.25875-2-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106023032.25875-2-feng.tang@linux.alibaba.com>

On Thu 2025-11-06 10:30:30, Feng Tang wrote:
> Some sys_info names wered forgotten to change in patch iterations, while
> the right names are defined in kernel/sys_info.c.
> 
> Fixes: d747755917bf ("panic: add 'panic_sys_info' sysctl to take human readable string parameter")
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

LGTM, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

