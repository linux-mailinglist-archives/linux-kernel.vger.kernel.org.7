Return-Path: <linux-kernel+bounces-840779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F0BB55F1
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A53A4861E6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6992E0904;
	Thu,  2 Oct 2025 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zum4Xn2E"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF302E03FB
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438509; cv=none; b=NKj0/7uuaaaXktRKMd60aYB/oBGVwOMtsZ9A+Fku/c9HaN1OSjpmRQpAZ81RkMrnD7CUmPE/QYD2x6VOFRNRCgcLpcsUdnvfvGRp9JxX+ZZFiHSxmK5aPc/jTfp4X8UdodhwDymPFsxzFndogvT1tQyOwZNaSDquCbLh6XRUQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438509; c=relaxed/simple;
	bh=ve7VSnEXz8SXLkr0Ns3Xtbmzdzf6/gpZI94v8i0XhNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2wx+q14SfDZ7sp4j8lyKx8UcXQGxV/dJi944dQ0fXPSHOhoNRKyp3Lz25TI9pYYOAQTFWelyz1iswoOcDiNQx1D/Y8nqW4peMq1aS4Hw8gkd9wJKJhHLV1q4VV4YFEXPHIpHLc7yIG/vvHjdlNNylhFeo39nT0032nzfl5tn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zum4Xn2E; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27c369f8986so14401115ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759438507; x=1760043307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIklhV74VxzGNTOE6vXMU3sJY9HtAA/7pD7aRkESOR0=;
        b=Zum4Xn2E2Tflw56ex9a12QHG7jkwi8KYoQ8qGaYvZ2Dkt6SMK6fh/JwxIZVn3hwnz/
         656/S9F+MYXBSpsMEVjj3BgNvOZr3Nw80EiJCts7JIe1vn1FoGcxi6q/aTGfXFNeoA6g
         izHmK5aAckLIzHbTx8Ua65mh8J1m8CbDkm+R1czbAbGgQwYzy4KUIN14u+HWSKarBmX6
         BiwcHZmTy6BNiaeiIEJwB7Pchw9C13bHaJ4DLPN+4OKhnIB1f5XOKVSjq1vQgkCbbjUA
         pJELwq2e+S8+JzlPj1jIbcgOWprvh+tO/Mc7DJHgZDMGlzjJdR/e2yQNLEyoXbbmnO66
         x85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759438507; x=1760043307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIklhV74VxzGNTOE6vXMU3sJY9HtAA/7pD7aRkESOR0=;
        b=MtgEU9hnhnK/bxdyXcQ+AMoq1psIXOn+OET9zV83CN3jWbjIHynHGw3YJxfa6DsvuA
         K5sX5JE93/pg7oZCZmt88085TYH8lBfs+FFH047xLk74dYRG0sZ3NNXAgrfvvO8QBs56
         fRIC5dNe2+zAAQQJkbgTIWlyz+yaDazoQpewuMkGWuRX6XhUHbBVft3Dlf188BYdC2nB
         70AyyH95xQLmGeMUznZZtI5rWW9SwLhhXKOwcF+5y7sKfaDgFO+mhEKXtwtt0jdLbdWU
         fuutwfFqJYtRAfMoKhaTfglgpPdkm11GSX9ObBItKrI8rz/Yj7AnxUlFMYy16eijQxAn
         4kxw==
X-Forwarded-Encrypted: i=1; AJvYcCVzyx/cAmGJ/yDrq5hsU4w0NXGuI3EIRfNQTk8aHyfXHhA6h7LkGbWqu11RRbzr4U+HHzk9/5OdClLJQFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8QmsxqjEwEdXj0uxfyfAYVTtE9F17evjuYFSaIdy0ZVd/6JH
	wXM5P6hirG3iXCFhtoKTkuzVUXdgv1BRITvWW6dyLaxxenSANQyR/AnO
X-Gm-Gg: ASbGncuWlh4oEgRQiRoCOPcFOHL72S16v7+KLjZrgeTAS9kx8D0WshI7bD+i3Tmq1op
	OIXW//4ZhfyjCjVAxlZw/IEnv+nUsDrlm/x3tB8TT6ZTo3tWsps5ieheohkvT5k+amFAjMfuk1x
	XqgTpZ0aWeQQfhgUaHE4CBdSZzA7sNoVpjlmLDKfq6BVLGZxjgL6Fu1osLq1bwLJyNCN0yqPIoh
	I53R95JWRLPm+QuWxsb+hOUIpQevm6cm6P5r01em24M0eo2qejmG8UG/S02ERLU2/kCGoebAuc4
	8oRyJrOBSIL14ETY4TGK+hXcCzPDgrAWRBgph0QzG6Iycr1Rr2dlWa0u5p3OhC+nNL3+g9Nv7oj
	UgnC6GVhfcGjQ9VsYeQkadTqRIkbmOe+6pVOD+bC5zPA5yw60i7uk7H9K+X8=
X-Google-Smtp-Source: AGHT+IFTD102IbQjDd7ezi5HEPtVTH6TbbeKx+COFeUkw9uJEnFAQC6usbIyZfpGul6EpzbGLgme9w==
X-Received: by 2002:a17:902:d591:b0:26d:f589:9cd7 with SMTP id d9443c01a7336-28e9a593d26mr7143505ad.15.1759438507464;
        Thu, 02 Oct 2025 13:55:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1eef42sm29474935ad.133.2025.10.02.13.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:55:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 13:55:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: pmbus: add max17616
Message-ID: <07272da0-6b8c-4283-8094-ff6446ff5762@roeck-us.net>
References: <20250930-upstream-max17616-v1-0-1525a85f126c@analog.com>
 <20250930-upstream-max17616-v1-1-1525a85f126c@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-upstream-max17616-v1-1-1525a85f126c@analog.com>

On Tue, Sep 30, 2025 at 01:02:20PM +0800, Kim Seer Paller wrote:
> Add device tree documentation for MAX17616/MAX17616A current-limiter
> with overvoltage/surge, undervoltage, reverse polarity, loss of ground
> protection with PMBus interface.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied to hwmon-next.

Thanks,
Guenter

