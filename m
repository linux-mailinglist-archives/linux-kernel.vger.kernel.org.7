Return-Path: <linux-kernel+bounces-886762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 807A0C367FE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A68EA50657E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B7B3128D7;
	Wed,  5 Nov 2025 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IPOMLgzq"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD391C5F10
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357043; cv=none; b=WGyrZSw37FYjrRd4uMx8QsDTZMmisgirK9+34tn05Y/7oyZfDSj2/Lbf1sUFpY4UFAWiT5lRZh1V6bwOoaWeiDFcJ7XZlg/BiiMxvpeVHPYx705dwpNdKudBrAa6HtX3hmnRrLCQ6J+1+yQI6ZIDYVW4TbGYJswLGFvF3xIGLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357043; c=relaxed/simple;
	bh=m61O97S6NfmxGhxTal6dIYh1VqdktvSQyC6eowRi2jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HekKd8zcov0i2Afr6v9Uu5O4zJH70351JX2jGDZg4u3Srh1k0JoFA5zhLe7CFjfALwuTyLRHo7x4TJ8svasGhxQT3q6AJsHq/9I74g4gG8eyGrtRzYfQaNqCqlJvDxZVV5TQadLhevNQ0BDHK3Q2nGHfIsYxm1Oah3K9vAYzIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IPOMLgzq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso2960380a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762357040; x=1762961840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5uqExUgKxmFd3ttKHvhc6HJuV8mvKHp8nd/APxExqdA=;
        b=IPOMLgzqk0eNxGfwcGGgpv5p/QPQsf0NE8s45PzRux4MarUAXHiu1fpevoYPcPaXsj
         EcHsdE0fepdrKYEd1m/pYaJva8eQJhvRfFv/oDlpBzkRudL7s6wNMFyPUXY5uYlvrSTt
         Z5kiWYrnvR6JQKGS7RetPKAHo97dd1NFffMJd7mjxKPVXoA+OGAYs/XwFBl63Hlgaao3
         6+3K6rKkWHehIy1tHA9+uxwlUssrxyUwagd4m3UyiLrjhH7ASfSuzb20g00+I/3Ozr2M
         RFvpQKG3mOOPvEvJFtH8TQeiWZp/LkTJkwn9efiUXhFvpRId/YiKLNyqljjQdq1ky3KF
         y1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357040; x=1762961840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uqExUgKxmFd3ttKHvhc6HJuV8mvKHp8nd/APxExqdA=;
        b=lVPhA3IKhWOqg9ZfOtKuj6WadcCwgVjX4uz2HpAykQfJP0QvOMJ/PlQEC4TKtA9dBH
         fhqVijgLbJIX2yJNtqm5r/0heho2rMv4hDbZBB0EpM8DXvEzkgSKVfgOlnCGe33cFWR0
         fr6jUVcQnIzlrLQ/i6aj+LkYzDkG76b1AI+PpQDogzbQh1Vl7NmcExR06DoTE0HicEqn
         OVp1edXbSkF0c32GeJTR7AKQpENfAN3QyqaOkX6DRjAEuKUV+/yS3jEdbum7BiU+Wiqb
         3XIkZh7Um4s9r1bIhpXIqJolkHnvU3fM4No/nJu5F9mWYL5s6jcyh1y10+W4a+eAM0yu
         YuLw==
X-Forwarded-Encrypted: i=1; AJvYcCWtr9pUcpN5b4S41MQDz1iYco/O9xiNR5jHCHXSoVqS8aLjwjiRqlCe+k/vxov+xhciHfUl3ZxyoPXIuLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQAvZfg4N4piqeQ6pI/obO7IBmhbRRzMnLlT/CgiCVvE7zLnR
	Uf9NyTd5C+oJhqHmKGeJA6ovgseAeN71cuGXkhd186QA8V/yiqz+/iATJN339366y6E=
X-Gm-Gg: ASbGnctM6+6gpGcirok2o6MtbzUDoIDJ9Ssp6PELXUAsTe8a5Ul/IjIOBupFubliDKK
	UKqqzQ1fgLeMgx6zJchlayoQwcfpiVjC1v3ZGcOM86SJhkv7bBUnyKt63EuqT0E54D7tZxEMlrR
	ZcOVOYfcUUwAJDeODJwgENQNLPWqEYVTGtnamNEM9T4o/911LR/1yGyWPJ88DsquhCrh7fM4+qn
	lHDQVIeulpY+0HUpkOtN16cgxMZHLDzDhPAFlnlZLyApXaXVC10CiPnlS+8vcBkoAyNh9C2opKV
	WGM6gULlrJT3sFB/nQUPHI+7UVrYUQv98+yj0s4Aru/nLgMzb3bQ7XciXrF6wDZViggdTdLzNlJ
	FxvRFzZk9fwPJ+eRJcPgV6H38+gZQ20KSmbz2Gu2o7WuRbDyggbj9s7UkdRSva4VQI81BDfcvUV
	Pn8PE=
X-Google-Smtp-Source: AGHT+IE+8ZNQFkhcdImMvcXqqcsY1PZctR5NHXTk+Gv9/xtr4yKr1SrmgJkABmO00giNnP9d+YmbRg==
X-Received: by 2002:a17:907:3fa9:b0:b70:30c8:c35 with SMTP id a640c23a62f3a-b72656cf1a1mr345765566b.62.1762357039656;
        Wed, 05 Nov 2025 07:37:19 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe37b7asm510757266b.60.2025.11.05.07.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:37:19 -0800 (PST)
Date: Wed, 5 Nov 2025 16:37:17 +0100
From: Petr Mladek <pmladek@suse.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: add printk core-api doc file to PRINTK
Message-ID: <aQtvLS7bB6pnhgxF@pathway.suse.cz>
References: <20251105102832.155823-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105102832.155823-1-lukas.bulwahn@redhat.com>

On Wed 2025-11-05 11:28:32, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> The files in Documentation/core-api/ are by virtue of their top-level
> directory part of the Documentation section in MAINTAINERS. Each file in
> Documentation/core-api/ should however also have a further section in
> MAINTAINERS it belongs to, which fits to the technical area of the
> documented API in that file.
> 
> The printk.rst provides some explanation to the printk API defined in
> include/linux/printk.h, which itself is part of the PRINTK section.
> 
> Add this core-api document to PRINTK.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Makes sense:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

