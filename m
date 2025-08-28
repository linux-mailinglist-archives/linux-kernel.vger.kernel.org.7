Return-Path: <linux-kernel+bounces-789874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0F1B39BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C751891DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E41130EF9A;
	Thu, 28 Aug 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b4l2Drln"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0DB665
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381878; cv=none; b=tsUSfphcovt1d9J3ZBN+nbXkEQmQsCGplfGXG92uufN4y0dMrHQav8jW+449OR4LCf7Vh1Z44eOhrko+eUqIxV3dJgm3aweJsF9A9juZef0xvFbdnwAZlHZJQnLqssjgXOyYvbuNJY0vTP9J/4zx9QZ9XrDGoUY7LAdKWYuljZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381878; c=relaxed/simple;
	bh=0zL6h9C+j78C/0YXe+LfzX6pWym1EET3Dtu7HOKUHVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIrDzrzUQDFqjYcY4C+pKY149qn6aKtDaYEh7yf2IMySjbYtgT4xUi0WblKMEfzRQlh4prtoX95Y4JVzsdF+KEeQX6aOMnIX4JTxXqj3OGMtqgcxtifoSx5ktx/xmml9WpCBVzfwOn4mxL5bWt85HJG1oHi1fTqx7EgWtWRKT4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b4l2Drln; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afe7f50b605so13798166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756381875; x=1756986675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NGZUxEi+OLFKAm62a2iDP4erNW5NjQeOcI2jJrFiEI=;
        b=b4l2Drln6P+vhA5Czcsjv3hx/0+cGVIN1D7eY8MPAfqz6U/xziPFydmuub9wwilGUA
         sCgnLVCoGHGTBZvlZSwB1xMGkI6Tt3AkAKIYtwvwwTFL2H5dLndzgLahUacB3P9ZvgQx
         C3QnJvyB+43DQEHUGcw66G5gl7mRBI3qjtpewYaXXPjqNZDyuMPfwGfcGBzDwCK8u3+y
         r6KEHA4If/sFOQRa5MU93edsh0xLjkieA3HE3UkV1T6VqH3LejuRXBqV39vpaWqba2LS
         Zeie0bjqXMZnnJA+XvZ8ZZ2i+9wHck2L5TZo2U5Umgrqok/SUZY9kKL/wslfGKnd+Lvb
         vVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756381875; x=1756986675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NGZUxEi+OLFKAm62a2iDP4erNW5NjQeOcI2jJrFiEI=;
        b=ZtziegDyaUp82A2AOR/0+qEeHoB+QCaXSeGgLe2Ffhhgzurc1PUIh/AU7mCZdUESg/
         /rWqhbi35Gar5SfYRyBhribzvZkf4VzFjIuz4QUFlBSPn7o/fTnLzNAm2v4fW/DwU8Iw
         5FghbGmPD/kYZDSlS2PxN0BQZfU9CDUEiYo9xFxC3xTMp9oT7fYfYeniI+jXc32QRjkW
         MuxzdqpximpQ0bHUHmGZKrKWkam5VJyj+DjU9qWo3DxR/m/8L9lOPeDVF7HT20hv0IAQ
         tL+1wNycdaCi7MgXlWBV+klLZG53UbF2epNMjW5xlVxoFnTX2Hd+ta0ZL7KKsNSnK+/w
         Pnpg==
X-Forwarded-Encrypted: i=1; AJvYcCV6BqTk/nGZJi9ZgjAo/gcblrPS4x4ABgfZ27HiJO6S/kJjOa+KBZUzxNDnO+6Hl2MZRv+h/eA++s66sJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYSTIsG8H6e1Rxehwe/0+Rf5zERmbXDZQeg5Kl6lANFGSIDM48
	tqQBdT9m0z7yr3j/haejz+MvkaVxyHVPHA2qUVSFXaQ0LdTO5go7fpK96MBhSBlNnDs=
X-Gm-Gg: ASbGncsQqGkWIdsMPWgQ+j292MjrWh0QomVW69VU27d3mjaktfR9MOeUBs+fM4MZvCN
	/w/WcTOEbf6k7JR+GF+/uxW8ddcWzknTLBeWsQuxZgqG9N2EXIpWEf87TyCuIQxoJdcNjWMOYT1
	pvSK9RnIKs7JZyXkU4wIodMNvXuaagTmUu/HuZiYG86lU3xh8ikrMCHP998zbeeKZ2GQzVISIXa
	EKsSHavD2OO/WPtAe3Uyxr39p4XBE6cwYNQpGpKhVyxBQKNKF80giTyzMnpK5qAxKWJ/p4IE6J/
	EBNXMnuzP5XxUi7/2WcKM8vDYYuXt125SAMwLOikQfE/VzpoYcBdrZ/VSR26NOARiwqadBeM023
	AHxKc67N/4QlAHAi2hf+aziFgItbZ2j5/g7uISLsSmsY2sBpoEole0oLsOpUaGC7XxxGdSSOCJh
	i8JXf9g3Suyj+jJz27ra1JxBfYBnRfJZaasK8IHXo=
X-Google-Smtp-Source: AGHT+IEySQjkkNcK8MXf/aZyms/JGCuMbIVBiywTS1GsEO0Q2xYaGss8HxiJweWHCh9D3hdIPYFoEg==
X-Received: by 2002:a17:907:d88:b0:ae3:bd92:e6aa with SMTP id a640c23a62f3a-afe2943e844mr1191511466b.6.1756381874763;
        Thu, 28 Aug 2025 04:51:14 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afef7ae440dsm14588766b.15.2025.08.28.04.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:51:14 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:51:09 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <x86@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tsx: Get the tsx= command line parameter with
 core_param()
Message-ID: <20250828135109.1da8eac8@mordecai.tesarici.cz>
In-Reply-To: <20250731191636.7vepzhy44ajftqry@desk>
References: <20250731083433.3173437-1-ptesarik@suse.com>
	<20250731191636.7vepzhy44ajftqry@desk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 12:16:36 -0700
Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> On Thu, Jul 31, 2025 at 10:34:33AM +0200, Petr Tesarik wrote:
> > Use core_param() to get the value of the tsx= command line parameter.
> > Although cmdline_find_option() works fine, the option is reported as
> > unknown and passed to user space. The latter is not a real issue, but
> > the former is confusing and makes people wonder if the tsx= parameter
> > had any effect and double-check for typos unnecessarily.
> > 
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>  
> 
> Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Thank you, Pawan.

May I ask what is the status of this patch now?

Petr T

