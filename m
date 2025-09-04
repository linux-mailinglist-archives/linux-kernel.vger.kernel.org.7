Return-Path: <linux-kernel+bounces-799749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBEFB42FC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F0E54E10A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E331EBA07;
	Thu,  4 Sep 2025 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="csRdQhWH"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E2F1A3179
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953275; cv=none; b=ZGPd1EaLxc+/sXKyWD4SDufEf8Pi4RX0G5DLZyUIMMgxxlpZt5G/ut3+tiL6GHh+siH+u/2sCZ4kj5gykf7ZvtHovHOkBgmKMyTEXFfuu3ZqjH1kQR08uEY0Q7/Jjv11yVwZDqk9uvUHk7rMwiseSFmFPz/VbbejNoFLO2mweao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953275; c=relaxed/simple;
	bh=l82Hzd47vfACCCghMD7OPoWbZyTcPfjnx3myCJnU5eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYFjJQS574DWdem/maA/Y9TFgO9SohfeGi4GMavUC/nERgMmt5tbiLGwaFTJSm6C3Er7xpUv/a6BS2U0IYzffaHoye1KHIEc7xu+QeDpJQUiZejy/PD6lZA4ZIWfdT2EPTfYT1U+a/++d8/UIVgmnCCAfersFX87pzSm+gGOvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=csRdQhWH; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3297a168470so453076a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756953273; x=1757558073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+q1TKaoT6DcMQ2MnG7jJNQbZpbE3FhF8fLZoXHU8eJg=;
        b=csRdQhWH39Uy3ZEoYrq8pBnAyO9/x8ygTy3lADLHHNipsFLHQAuuHfYLWR+Zx74v6e
         rqUFFZqerIRFWj7J3MDMcmY24hAccBD0f3aU8q9oxx6jh3CXVlMObzZNTU3iWzesRGQg
         ubszKcUh3Efx7YG7OHLx0HgnIofHTuAzfTZ9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756953273; x=1757558073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+q1TKaoT6DcMQ2MnG7jJNQbZpbE3FhF8fLZoXHU8eJg=;
        b=FLEOz+UkYTiYqvsBPHfC64V+aRSfMvano0UU/3fQcKFTZnl9OMU7Ojvkm704NmdBuP
         fHV4+ZkZnTGD54dTU0aIE1hPqTF2TKCKIpWdl3uRVTJlNsXjPnpvswou2/OXe5ygzerL
         Ih2XNNIjzcO+rbqbwDXMRSpUDfHXRdeGaV7TRLIWFMV7Dc4Zi/568u+uKNllEw6kBiXs
         bSZrwtzVCbLhnY2/buif+ARWZf2dhysJE5m5+0Q0I4OGLM2AqODKOWt9ZCDxct7qVhxv
         hNUx9oa0fkUdS5Cl+5hPtFvITwvwh2mfgmCegLqwUGqrgVRQmc9S1OGS6ys4Re+lWJeA
         cJUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX/30MckJgjxUBw2isjN95VoU3JNQXR/7tLtFCR1PLZGYaig6fKQPcvyGZax+f7YSoyqHYgjtdA0d/Z5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHCwWjiRM6OI/c9bUOMeV9gwgLi59vELnVxbg2C6NJ7u8qGRG
	944d0aMFaOUfcxGFpEZRnkceQZyFDk27vWMpFLFEFDweijaS0xM85AOy4mHgYu8M7tn1lLTwSA6
	kClU=
X-Gm-Gg: ASbGncvZUtVaU4zFK9/HgDNqWwJJZy+r8MaQKcINOD5XQPDCeChDFRYVVLbqYcB31RA
	Xq37pj8xVdV55Zjbz8sTpR+FFOg2p8FfMvR1jfwh3z5nIXgNtV7H2J7sqnj2sWv7lgXv7BnR03h
	7mOrnZMx36eMxuLr4CvqU2uGPjYITp1iKLzMPyQ8H+RHL1lpGS5h3UMDG3k5f8rSmVB1mll4hHc
	a2mGjZKQbqsIm7b4ktH2Y5FhKVhCRlq4q3E+VpXm8J14JT1DFqI0duAnXdkrv+DVSGQwAjLKM7x
	ZAQSJFUoupJ0CBmVlcNcuyvSRsBLymHWUyFw6jOgEP6eAQNKJ4/GgFZ8FTw11APQQ57NE9fFlqZ
	kRVAHn0dkY0RpTMsGfWK6Yd8rzQ==
X-Google-Smtp-Source: AGHT+IE7X/xvXD1mAm1tZ3L1vPkAetrL173ikT7EeDfPQ9om6xD8orjoOq256zUTlc/bDRkzQltCDA==
X-Received: by 2002:a17:90b:1dc9:b0:311:ea13:2e63 with SMTP id 98e67ed59e1d1-3281543604cmr19675744a91.13.1756953272676;
        Wed, 03 Sep 2025 19:34:32 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fc16:2361:9d73:40e4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2a0485sm17434021b3a.25.2025.09.03.19.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:34:32 -0700 (PDT)
Date: Thu, 4 Sep 2025 11:34:27 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	John Ogness <john.ogness@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] panic: Remove redundant panic-cpu backtrace
Message-ID: <i4hhb2kxilkrzdnddffqrmyauekwmj5cztpxplutcldaktgiq7@ksorrmedmnk7>
References: <20250903100418.410026-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903100418.410026-1-pmladek@suse.com>

On (25/09/03 12:04), Petr Mladek wrote:
> Backtraces from all CPUs are printed during panic() when
> SYS_INFO_ALL_CPU_BT is set. It shows the backtrace for
> the panic-CPU even when it has already been explicitly
> printed before.
> 
> Do not change the legacy code which prints the backtrace
> in various context, for example, as part of Oops report,
> right after panic message. It will always be visible in
> the crash dump.
> 
> Instead, remember when the backtrace was printed, and skip
> it when dumping the optional backtraces on all CPUs.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

That's very kind of you, Petr.  Thanks for working on this.


// As a side note, my involvement was more of a
// Reported-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
// Petr is the sole author of this patch.

