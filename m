Return-Path: <linux-kernel+bounces-766057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A75FB241AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEFB582809
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812D52D3A72;
	Wed, 13 Aug 2025 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MG6P32Q3"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3482D372E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066993; cv=none; b=q1v5N/Em8jEymFl7ZwIilFB9dBk70xaaa6WGBZYGB/4AwYzaztCPiNwEq2b2YQtIT8Q9as7Gt2xXWJQtSyPKLZUsdFhH/lMszY2pSk0Lsw8SiBAeWHXv8G4sPKAgPrNBxnfv9Kni+9gafogGiuV+YIKXN0gr/PyQfs/Bm/RY5A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066993; c=relaxed/simple;
	bh=HvKfaXMrh27S6x5OkfUMGM02Rx2ASphXYRfcdEu9PT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRJ6pt8zY4orspfbx/C4XVBVoG5v8UomQSoVRH3ZtEUsiCvQk9XIyroazMw5jTeL/vSIlOK4zeQBa6STDDjzDw9hRYN/YzzUm1IxSY/9XKa6tWbjDFw4JMhLTouRVJo92+0zq+f+JPGJSItp4ij38pGqYgNIRwSdzZVjewTrck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MG6P32Q3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23fe2be6061so4281125ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755066991; x=1755671791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nwgmJNfQshlnB9BiXnFvu/Ld5pA59OhVCDNPksx0F8s=;
        b=MG6P32Q3G750uHwRQh/VAIFNAJnU0rNcV+chC6fWDZniWnSGgPn9qo6OzhxWovsZ7X
         G8fiCkl30voVRzZl6dqUjkP5ilRDjjhZHdKezVMl85UmsE6zceXXnZD5qdUAR+07zAyA
         syoR1ktL9t40SWi5TRIPcvMo+NEyaEU/gW1os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755066991; x=1755671791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwgmJNfQshlnB9BiXnFvu/Ld5pA59OhVCDNPksx0F8s=;
        b=fSJofhFXDXHCuJOyIwpdv60MmmR0LBzNvKpvWofsUEB6pIfZieNRTYfWKy5UCwmzJQ
         nevlygFNhE4jz76506IcqvCR34tiQ+7ORuCdprteFw40wrdOJ18VsDdencuLthsuKqFW
         nMtbGy8kH8yE/OU4f3COE6o03WAKFdB7eDHTzgcIQdEimE4cRKXfBXWP7iJ9RFG2Tij6
         nlwNFj89Z2gYz5zcokx5PvWeQHWPBPQ2ENtEpgKzWoOolYykd2j09QgwtMogsb7ulvg/
         I2bNlRY0Z4KVlsioRTKIdxB3yyO7Io6iI8WIzRV70zGZX7Fe/7mq9CIYzh1VWJrz9vkC
         7jsA==
X-Forwarded-Encrypted: i=1; AJvYcCWkuYPAzfOB28hCTwJXvOYzX/WumTzCYcwZGkarhkRzXDNU7mz7M+sY64rnQZ6KF1Yr9Ie+3RLgdD4GI5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqfGGg2iacwOIlsWcGuUbBKjLXWqCRHs1+bOZsfLlMhGnSxXn
	iYs+F5t8MkyYt69EGHj/w9xr/K18HrgfkWDPyY3n+lhOndTzxQsA6yLjwjstDVtJsC5fSDDv+ND
	j5SY=
X-Gm-Gg: ASbGncteqk231LbCKM7Lt9t4gUWuA4f0qqwwbZabz24Gf9zpAYJSjhxUB5E1yU5cpau
	pKlfzp9q7vMpvV/mJkeW93l+iCMsllPqOvMJbMszxUrKzsHjezOjrmUm9qIQ5p1Ki+7zpL4E34g
	+8o7zVhIsXwe9fgO2u1RkVZJBCYprrJav0nCZw65u6TklAgK/7ZkD+Kv3wsstG3sInfF54x9kO4
	m5i0616i0o/saJx9KGQ3fUhascjxGUW65zS72gJA0M9DWRamJULMw2hAF/bgH6FmoZFmTkH5z9N
	1i5l7FtjGoWYP5pVA6Ol45+gIF4WKmVqi7cDte/pf8DmYZSWUq4v6ATdjEjYJWEftKCDerSNnN6
	5yUME05tLQaGOZhAJHga44XLw
X-Google-Smtp-Source: AGHT+IFwZmjY5Pd9SKfxm7NUCQfkSIVAvrkOyL0Texx5TPrWcyFAQuuakkZ6eFROa6KYL5bvq5dtVQ==
X-Received: by 2002:a17:902:db0f:b0:235:f091:11e5 with SMTP id d9443c01a7336-2430e925c73mr22378195ad.10.1755066991011;
        Tue, 12 Aug 2025 23:36:31 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:b097:1835:239:6aa4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b4adsm317448065ad.132.2025.08.12.23.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:36:30 -0700 (PDT)
Date: Wed, 13 Aug 2025 15:36:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panic: remove redundant panic-cpu backtrace
Message-ID: <5i2vu3y2hy473glvoaecfmpan6utr5ftv2cwf5j4rhypqqu2qg@ah7n235dnw6o>
References: <20250731030314.3818040-1-senozhatsky@chromium.org>
 <84seichm5t.fsf@jogness.linutronix.de>
 <2kwymhiz4fcozfmbmj6ju2qatsbmnrtiidfa4nxrqutgwa6xfy@dbf3caohbbay>
 <84pldghkho.fsf@jogness.linutronix.de>
 <aJs7p_UjPIfb_XYd@pathway>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJs7p_UjPIfb_XYd@pathway>

On (25/08/12 15:03), Petr Mladek wrote:
> So, I think that the following patch should not make it worse:

From what I can tell it does the trick.  Ran some tests, everything
seems to be fine.

