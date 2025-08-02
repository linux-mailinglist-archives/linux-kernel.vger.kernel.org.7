Return-Path: <linux-kernel+bounces-753974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F067B18B0E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 09:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B7B77AE977
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 07:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFEC1F12FB;
	Sat,  2 Aug 2025 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpHOlXZy"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E3516FF44
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754119928; cv=none; b=ZTpoolQBLsirDswztT5CZwbZH6dswRjjG/4hjCN9sp3uImReQHO1qTYBBwugWela2DRLzV2UDaEI6E04UL6vXAtrIJZCEPftXAm043dE/+RHSlL8Xk6EQhMLW2ORnaJgqLLaX9lMb08T0wEDt7B4s7OuM0cgwG5Ikw9yAUUCDcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754119928; c=relaxed/simple;
	bh=X8HRyQFPoOlzxmLgSDnwmZXBUKycsDjwrurq5e80avE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOAf6MY3tnWXYB9XcB1cNfC0N008aOhdTngGfoq8kAat5+xRKh2v6F0uYp/Px0sz/ReNFwUYQECQVP9Pq3wxCJ247QqShJoegGr7rLy0B+M6Aejvt7hKiC8U4gQT4z21TLVjqKQL95k3/9Oyy8SFYU8j1zIvAeAELnaj7zkEEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TpHOlXZy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b7823559a5so1647813f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 00:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754119925; x=1754724725; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6Pft35+3lXQVnWPsUsq5tpsncZSpCehFTU7fpA7XTkY=;
        b=TpHOlXZyl9li11KqxDewgxvlH9mchzRQW2GbTWz/j5xg/4kBizJ1C9JQp8u78bFwSi
         rWSxvFlO5FAlMeLN4V2oDcpaun2L7o6ARP/eUGucA9kDD70I1UofgEtvpnVpWScPQA7/
         xgR4pJagtxI2x/UloEh6VvdUHnjAeIlXmSUzNBySbWPkM3wEfBjHok/FhmegN8atKF99
         GIjLM+2rMibyZKF4kdzkP6yzJpxiNCMY5wZ/GveygM3SI+pwzRP53+tYAxxrH7Er7HKw
         XS3WCaytqx+Fb2gvZg2HkYGutNBjrvJ1cilwEFMs0m47vDZlmLsmTnYuFNH5Mt/BsNza
         X3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754119925; x=1754724725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Pft35+3lXQVnWPsUsq5tpsncZSpCehFTU7fpA7XTkY=;
        b=cs0omJHmHsLDua5OmFxru2B/U/J7RrXg0wp85miTMXUQCFHjf/Uj0+qyLL6c9XJhDn
         +B2bg0v3ETxgPYUtsb18KDTOHZ3ZlPY5JW+vDY0fpeRV0fghFvts/N+lCJesVH7YFsaV
         iohKfx6BJ2WRRCaGaOFGt2JPjUyIZw1RhJEwS4rn1JWfPc7S3mt0MDI3TYvw5eBMsuW6
         8A4yvkUG0kAIbg6NOOCS+IoGWQhTs+NlgV/0zA0y0fHsVrsMVb6VO7R5Md7Zf2n8Mfeq
         1TQne3YcFut1vx3EKVkHMz1s1J4RJndpoehkCx5KnCiU3R5mKEgQPAY2W9XQQ3LcjqSq
         rSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfwsA9B0JQQUHqNnn0uq1DdeUxgK9DfGyxtudnZugLylxpNOQSWX+8S+bym9uLjVapnvXYmxaHGC+pWZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxW6hm3xy+7aPEJV45rYPM5kVppt0oFQNNK8ZgJJwKQwdmFZYI
	BQHOBKdHS3/eNN3dy4dARNSwGlFsojBYrcYqiXY95Fs/4zLfxay7Vc3M3U4J4CaMsm4=
X-Gm-Gg: ASbGncuc0RZlG87yhmX6EQe/E8kB+beh+2s9iH4ZIx8hZK8iq3gIZkOhxb3vX7j5FYK
	daYbqhlP1iDf13n+FYDvp/fM8/LO24fL3Gy2emwYUIv5DIiPYVN0QM87Y6/7KjSH16MrwmjIQ/i
	2S4xz29jWeChsSlQfl3bpNCEyLdCEX/tVUh1cUs5sGrTZFlusL2BK45Xj0f4jvoter6tLLqVl/m
	j0vnMf+4lcyvllF1BlmQaC6sqc8CfKJUT4iHTDiVhcqsrdR6G5beNb/VBjv9HBbshgXUTgtQYMT
	KUtWvIJwkZZtVEI4wCbwPxEAzMPcBidWHk2oM9noXW7JBxDyP5ZCy+X0oLSAul2iLWbxWyCrbc7
	/6HPKfsHKvju733bgbwK9Ctbd6Wc=
X-Google-Smtp-Source: AGHT+IEncAhoLdtPekt1mG/QjBbcpjITQUAV/Ke+Zpd3fYn54X7RELoK7NrhYvkBeCEbn5j1iK8FgA==
X-Received: by 2002:a05:6000:2481:b0:3b5:f93a:bcc with SMTP id ffacd0b85a97d-3b8d94c1ceamr2065362f8f.35.1754119924640;
        Sat, 02 Aug 2025 00:32:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589536acc9sm133848185e9.6.2025.08.02.00.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 00:32:04 -0700 (PDT)
Date: Sat, 2 Aug 2025 10:32:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] media: atomisp: Fix incorrect snprintf format
 specifiers for signed integers
Message-ID: <10626b28-9619-47ea-abad-db823c01bb96@suswa.mountain>
References: <20250801160023.2434130-1-colin.i.king@gmail.com>
 <CAHp75VeDt=1=9epJPQjzfyyph09bov9UWWwpaAXgu01Egf1hag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeDt=1=9epJPQjzfyyph09bov9UWWwpaAXgu01Egf1hag@mail.gmail.com>

On Fri, Aug 01, 2025 at 11:57:43PM +0200, Andy Shevchenko wrote:
> On Fri, Aug 1, 2025 at 6:01 PM Colin Ian King <colin.i.king@gmail.com> wrote:
> >
> > There are incorrect %u format specifiers being used to for signed integers,
> > fix this by using %d instead.
> 
> Both of them sound to me like the fix of the symptom and not the
> cause. Can we simply make types of the iterators to be unsigned
> instead?

Making iterator unsigned by default only increases the rate of bugs.

(Although, my stats might be biased because I'm only looking at bugs I
can detect through static analysis).

regards,
dan carpenter


