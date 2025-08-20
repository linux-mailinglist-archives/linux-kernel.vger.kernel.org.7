Return-Path: <linux-kernel+bounces-778299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37747B2E3F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E02A5C7843
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EA0345754;
	Wed, 20 Aug 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JVteHfZ5"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271E2DEA76
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710554; cv=none; b=lcqLTcTR7mS67XkEgKyGgYp8jZ7A42zQPDvC+qI1YmNvKn/xJNVa50IzKkybnDzWrwazDu+1wmMq0v7wkSP6K/D6e8cTXgMdxFCtTKIacucOOBR29uwyRC81fSjVYPS2wGgrfYMnLp+T/rQ+fqpcfr9KMb9h1zJ9kzOnbH3CSJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710554; c=relaxed/simple;
	bh=rTFKcpRH0gZUfa10nqE9jLLBvT/nhI1W5xxAmN62AcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xtv2sz9IddvF+cwenYEEuwLcd7YidwqXNRxxSUHka8QzUwobSLSCUpCfkMY9VR+++KFkEI02VDPkPRUhka+HbJUVOMwZnWb/tSxdwM6K3UhiOOdWSa3jOvPc7EO2beoZPyuEEbeDiM34QQRZAwo4fHm1mTX6AsuwMhWWFB2O5io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JVteHfZ5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-244581cc971so973835ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755710552; x=1756315352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rTFKcpRH0gZUfa10nqE9jLLBvT/nhI1W5xxAmN62AcA=;
        b=JVteHfZ5IohqfB+EPB9NnCgLfqlJyWYuGmBIWY9/YCeviVuXfg8O7KrhZe75pJy0C+
         bGgOmXlAj8GPb6dxKhJk1NUvkFH9lpmN2y+PbtNdD3FJw5K4S/D1xKCEEWbBjQLGuzBI
         WNHz3VlAYTWncjwxQce6zu8L3IlQcrK5ndMr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755710552; x=1756315352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTFKcpRH0gZUfa10nqE9jLLBvT/nhI1W5xxAmN62AcA=;
        b=iOysNmp7UbmauAJVMnAvj2pUOyOlVCd6sFfbVJ7KmlBudk59wOH5j+thJ2mKLQJS9x
         qZiI7yldCln2PG6QmH0Q0AzKmTowxYAHFk4+5CxJChK0FGuDupWqKBJA2Y7LZUDZO9FZ
         XcvjgANjZIuL/Bne1iO3Hc7j3LHmQu+fHoXcZmg6TSDrghr4LnKjV2l6MRqVcpgVpCma
         1vrc4yymMO+QQv9pshbZN6CoYlbrCKuVIcaTjp+gaa6FZ46Avdo2EmPrdv4FA0SslRbr
         KLT0NUf+Wn/3IrQeeihLKBuWYQqsWKxSPBRjuaXZz5UGTrXm/uBwaIJZdUEcjhVAUR7M
         mdNw==
X-Forwarded-Encrypted: i=1; AJvYcCXPz8z9/vCTr2/K4GXUJI3umt0qZvspkGAh5vOQYKqLOMD/frCbMcSl98pWywcmZqEO9FH2vtd3sdCF7F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNy4957iIzSSPY1qrmg5fiWAo9Sx3E75p2LjnDmTZ/Ovq/NwrB
	OVRzpL9QRzrr/E0sRoHV+/saZxEhxuEtfgV9b2taXAm8nYau4HfkYdAWKEPPO5njZQ==
X-Gm-Gg: ASbGnctkBHL8CI390PS/jxn37yuIf7u3wYJhGyGcoffBH9zhFLsKo8C6i9rO6g+uA8B
	GzOVJW4U2ZvIdugMSqzwrz+3LUGCSg8XAGrU7U9NZU9c7B59lHlKCV+renBGAUZNIJQKG1OIN83
	Llg9VqgKT71m6PfJF7LuZbKXf2O8U11nLNWWwq8z3UgN8YW64gEOO2bXQqzg98NwwVj5Cg1KC5a
	kX9rA4UCgkNx0WEfH3AyUnvjbsXHVTWBFJ1iTzY54K/RY9Pgg79eFZKfp2LjoPL7NsCzcnzF9zm
	SbXGS7F2s+muX8wC+YESYVytMVZoN+DFUUQlvALXXleEerd2QSWNMAHLue5v4R9N3AvxaLANo5W
	DLR02fGgDhHS/IYC5kL4+jxbxcGxlCESoPap3rLE+01XXsgLG+rZif73RkQaW
X-Google-Smtp-Source: AGHT+IGTbHW2iOs9TTyc8XHMPC3pv3d37FzqQ+7gLgxKHuuMS5qqsrhp2UQQIRbn+wfI6B9LbCKkTw==
X-Received: by 2002:a17:902:c402:b0:240:5c38:7544 with SMTP id d9443c01a7336-245ef270ffdmr42539505ad.50.1755710551803;
        Wed, 20 Aug 2025 10:22:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:635f:74c7:be17:bd29])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-245ed33d2a3sm32191975ad.12.2025.08.20.10.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 10:22:30 -0700 (PDT)
Date: Wed, 20 Aug 2025 10:22:29 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Gow <davidgow@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH 0/6] genirq/test: Platform/architecture fixes
Message-ID: <aKYEVTRhzbXvwlbD@google.com>
References: <20250818192800.621408-1-briannorris@chromium.org>
 <CABVgOSkUT_yYqBvk2-+OozKEBybj-07mcRAVECNYQiw+1P67eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkUT_yYqBvk2-+OozKEBybj-07mcRAVECNYQiw+1P67eA@mail.gmail.com>

On Wed, Aug 20, 2025 at 03:00:34PM +0800, David Gow wrote:
> Looks like __irq_alloc_descs() is returning -ENOMEM (as
> irq_find_free_area() is returning 200 w/ nr_irqs == 200, and
> CONFIG_SPARSE_IRQ=n).

Thanks for the insight. I bothered compiling my own qemu just so I can
run m68k this time, and I can reproduce.

I wonder if I should make everything (CONFIG_IRQ_KUNIT_TEST) depend on
CONFIG_SPARSE_IRQ, since it seems like arches like m68k can't enable
SPARSE_IRQ, and they can't allocate new (fake) IRQs without it. That'd
be a tweak to patch 4.

Or maybe just 'depends on !M68K', since architectures with higher
NR_IRQS headroom may still work even without SPARSE_IRQ.

> But all of the other architectures I found worked okay, so this is at
> least an improvement.

Thanks for the testing.

Brian

