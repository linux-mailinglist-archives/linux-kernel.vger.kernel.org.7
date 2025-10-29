Return-Path: <linux-kernel+bounces-875270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D888C18906
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAAF3A448C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8840E30ACFD;
	Wed, 29 Oct 2025 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXKtHUfG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA21F4606
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721032; cv=none; b=PPnFFTEuR0Qzrfq4ExjQkIyii4my/5KE3fN2fegkXRuQ24ZdAcANqEatASMHuCNvkI3/JXwnVpcVia+39rOFSN35RVbeWqqd/8W2gN/5TFTdkx1qbrkhQqH65Az0V/rX2TkbJ1/HtUeAFnMtCuyg7eK6r0BHYz5ahVs91YDIUR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721032; c=relaxed/simple;
	bh=ok9dT4MfExQ5WiZNPWfHGVmnga3L7bykmmPx2qnik9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ/sqqYRlsZQaSNW2wywkEpJNyHupU2Jozn4TQnnq3gvJn0ri9stCrT+Wbdt6JLS9md6//Vfdvaq7Z4Dhf4l15lWBwqFFT5dNKNpXAOri3SEPYfI9rIyZefT5G9Te4NyVFsZuFVT4qXr4ZEW2mYUOTNRhIy6eXlTeHdC2TqBDio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXKtHUfG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29470bc80ceso9414055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761721030; x=1762325830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kAzHjA1DGMw75h1oXuHrNcgI7jwtDfH+p5O7whoKqeg=;
        b=iXKtHUfGYI93jMssXQ4yZG7kK3WlaY57zDUP0fw2MwGzYp6j8T3REKmF/NYfOCT7FV
         TcJXxveSlgIctPC1rJMsYUfrwerby7GhVgxkG21WDAxSBuM+jOp+8SUoWTGJs++fqjyZ
         HfGmXoxBpaqlFBDIjbLxyY0qb7st5ioqYRe5qGhwti/TM9EzJzvGZkjsXmH4yQeKfVKe
         3XiVD8JgahGexJQ7Sz/T8WUeRyz7Kcv275BBBoUJLJ9Ngv2Uim4bxM53c/frL7ITVNT+
         l746QSIB7GvNnmf+4TN76FoGMu6ShuAaiB2SY/S5i8Ms8+lfasYc6JdDEOKBy8BBZUM/
         0irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761721030; x=1762325830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAzHjA1DGMw75h1oXuHrNcgI7jwtDfH+p5O7whoKqeg=;
        b=j8UEn9Wo7fSeEBFV5vJDH4V/FVd34zoZqaYKxsYrdqop1aZMSaRnAru8oHGevC/Qq9
         obvN4tY/TAKAbSo5pd55Yn2VKADgPry6lJLSeAj9JXhnikpPdr69tpIm5+fBDr1PLfHS
         zKmFP9EfwEf9ptRdX7E+nKbETrwQNQg/VXxhucswo1uWJfLhVUqCtGlnkT3/PHPOtvhJ
         gcxWgDT1rMdlZ2+aRu5N9e/GxhfhiMWDERx+l254ctSuR01p2Aaytg6xjxXp2BOkrNLu
         1XpYKBafQSSHMabs9X8w0C7vvEF3oxowg55sWGOq9EUrb19ojZtDUPMMLShuJzURPl5W
         3Dcg==
X-Forwarded-Encrypted: i=1; AJvYcCWyTYGGP4dLhsfO1XsYUhEE5t41v6IetdPrybAPxrSCU3WNPlfI+PTUaUB+QfkDE+frnKES2VzF2UO38i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeXxr/r31vXkXuiCtZkS+zf1lD+1tYFp8Zi/bbyaqHH8cgGoa/
	dJLitecMGJbuukD/UedVLCB/h1Wab+U4J8UJxGeyk4YPScIo3eQu+7qR
X-Gm-Gg: ASbGnctTE5ajeCLRN3ClyYhE02ezsR+af9Q7bUgu5HgD4s6sY7nhMwE1I3mWy2VXCwx
	JGSBWRj8DxSxQvWrUzr+x22Bz9iEiqYuxDOGQDxP/oUoOGcXyBD3TwQ0mKs5Hk4yMUEZPEOrGph
	3o6Qe0xA6WbLmSCraCMBj0z//N391C6wkx72Vv99cfDxoB5UlENjR/R0WcTE1Nx19wtq9PZehxV
	b3BXZ67V2BYV7GI9n4oqr7zo4bzF62k0/1UbiqMLd7SFETi901u1+8H4NegMEmdpRH/5N6JciGc
	tfQlhDArIJVWkS/ReAlQXMhMVX0wOG0RYxae8W05IsftmbvlxF7wWKaF9wRek5phsS42oVZxz5e
	QWjoUSJ4vsTnTxT11eyBsJ8eu9mWocq0g7028i5ezrX2fZniRqH+0SFmUQ0O4Nn8ljBM1X6TWdk
	okIhgpxuI=
X-Google-Smtp-Source: AGHT+IHAyxSSOH40p4t7F9MwgeCG/5rdk7C1zelhSNkfw2jl6rNnp0o+7NhxcY4tilgw3gjqSJR7Lw==
X-Received: by 2002:a17:903:1a28:b0:293:639:6546 with SMTP id d9443c01a7336-294cc7538c3mr72609105ad.20.1761721029610;
        Tue, 28 Oct 2025 23:57:09 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:32e:3ee0:36e4:46c6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed807dbasm14531229a91.12.2025.10.28.23.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 23:57:09 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:57:05 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: rafael@kernel.org, daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, jacob.jun.pan@linux.intel.com,
	jserv@ccns.ncku.edu.tw, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmon: Fix undefined behavior in left shift
Message-ID: <aQG6wTDy7Bnf4XDI@google.com>
References: <20250901144756.1179834-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901144756.1179834-1-visitorckw@gmail.com>

On Mon, Sep 01, 2025 at 10:47:56PM +0800, Kuan-Wei Chiu wrote:
> Using 1 << j when j reaches 31 triggers undefined behavior because
> the constant 1 is of type int, and shifting it left by 31 exceeds
> the range of signed int. UBSAN reports:
> 
> tmon.c:174:54: runtime error: left shift of 1 by 31 places cannot be represented in type 'int'
> 
> According to the C11 standard:
> 
> "If E1 has a signed type and E1 x 2^E2 is not representable in the
> result type, the behavior is undefined."
> 
> Fix this by using 1U << j, ensuring the shift is performed on an
> unsigned type where all 32 bits are representable.
> 
> Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsystem")
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

I know maintainers are busy people, so I usually try to avoid sending
ping messages. However, this patch was submitted about two months ago
and hasn't received any feedback yet. It looks like it might have
somehow got lost?

Regards,
Kuan-Wei

