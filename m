Return-Path: <linux-kernel+bounces-834062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465C4BA3BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C617AC7D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD2E2E0B60;
	Fri, 26 Sep 2025 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gscfe2+X"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106801EEE6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891494; cv=none; b=kR+5aK/i49DJwXo4i24g/rvZdtyiFHevWdM+5lzZC6P9C0Hff5Jwq4wEcGggwuCUA0OXN6s5eeXGzJrv1/StABB07j0aECKiY0gU/WsSTy7HAzlBVkwPqAhVo2NyD5QG4A4Sj0IJZN9bvV7ooGJQDKSdmpkYjm5XuouZJ91URcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891494; c=relaxed/simple;
	bh=9aoozeymCtilt+qkHUzPEFhKKMah5TAuvXJod7umpVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpNy6NpQSjUB355tgboZVDCqO3+9Kodg5b0XY1PZvRWvJsqGM0p74i5oDH2wfUuMEQRd1to9UAcjmoA8/3h12ht/qCd0tE9vgm8TZHkhpOjTHRzbPueyoBaRurEAaekfbG4hmDUot/ePEiHLjlUrJk3ClfFYW+gZZ/3nPmX/FGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gscfe2+X; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d603a269cso20320447b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758891492; x=1759496292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+s3+W287EF3WpdqRLN76J6wag+8qKpJsyHBGGlUi1g=;
        b=gscfe2+XBCM7xT6mTvQGtus2atdlgYyTujEw3HJjNn3mR3wOKmbM1EmnJ8WsPl8Jtf
         4I8dVgCGEoXIWn2VKFpjWSxUfK8r0NHrWdlgf43Uz22OnlZ590zeg24dSQh4X+6A2kC+
         M8mfgqa6hJ9+WUltj696cnJ7rcJruBk+2FYvrQywL/b1JbH17xnCEsmZK7s7jvunQ9TL
         IchRVAOQMiGhlF4+PVeozBdpeIajMk5i27Gm1YJCUQt+3GKg0/2j6ZIG6z1TUY66dDkK
         wi95ee0R/tW1t/r1VhsNvvG1vndVCKfCFUepRaa8VY5mF266c1ouEJMbKl7+bG45u1dC
         zbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758891492; x=1759496292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+s3+W287EF3WpdqRLN76J6wag+8qKpJsyHBGGlUi1g=;
        b=sdPoJFmh4QGNWkvSq+fBI6UOboEmW7wRaMJlW5nSqBNk/+KBFRn5SY7Jna9RIR0lkz
         zYDf+fzo9qCJoPeh1aW5f24s+w0ls1k4K2HcKEKm/FO9a9AzcCX52xgUabebTFNqbY3E
         vDCBmI3f9BHeWpyU4jvAIiRn3orRHxNOVHS/n0kG6zVSoMTdt2OHsT9LmhVlGbOzmEgr
         UwvkhL3vLGJRG84TBZ3yCgRiF1/kNnRaQ1RTtXg2n3G8Mpns8gBlVOd+Y6pfvX1br/1v
         yKPUeDl3zS1EscwDVnHoja97dM3a1rMRgqnjrjPg5nXX0mVyLrdl3UtVlehiGjhm3bpk
         WuSA==
X-Forwarded-Encrypted: i=1; AJvYcCXKGDMnbqzTEY2j5wdhnNUwgEchg/voec6b0SDbZnxyFr0Dx1hXxr05pj0HhP+xfhoB81m4rKlIOL555SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlcYvbdBsin3twcQwmtW5zO+7b8zbpcsz3cZMWxlHJbMEaBdxg
	chJRu0KbBqb7/537UlNBZZCJcZy6LRk1cocwdqAsb2gJivv7aoGeJv27
X-Gm-Gg: ASbGncvLQTV2r7W5fMRhjF29ehRjcmzkg/jsIUnyEuMc/GFbB4VQ1TRFNqMcjMbMTki
	AxaFc/JNruqgoDcON5nXvwyHvpMyarYdnJbQgWKswS3Kmcrzpxc3OdOm2dE0qtsRHotFg/7m0IG
	xLPunXx/PRddAeml7pZRFE6IoBh17S3LURywXqzG8bJLkp+L8uaq7XcpNVyUydfiKi1Xmo8+99s
	TEpjdqY+VFImqIWQ2+dEhxNxcUDzvtYZqYwyDV3joOrxIU7p7fvhg59Yxq7+s5iHkXGpWqfGwhq
	Y+3rmrEDR45A8fE1pAPWgRSBYBQt9AmjczMiWMIIWlLeiUMSBR+wcFml6bnUSuVO/tgF4hjAooE
	vMlo4uFJtRbu2wIhoAXmt91t9h1GhFSFIjGWGzxnJ2A==
X-Google-Smtp-Source: AGHT+IGLIvAM19ntk8+Lddvjl2AdkR8Dpz1fEGG8f6oAy2PmwyG5FhSovK+XEHlRkEKZ9R+AN8qtiw==
X-Received: by 2002:a0d:d081:0:b0:74f:5366:86ba with SMTP id 00721157ae682-763fa430ad4mr57737817b3.12.1758891491815;
        Fri, 26 Sep 2025 05:58:11 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765bd407b84sm10951587b3.21.2025.09.26.05.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 05:58:11 -0700 (PDT)
Date: Fri, 26 Sep 2025 05:58:08 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
	syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] ptp: Add a upper bound on max_vclocks
Message-ID: <aNaN4DtuP0QJZVus@hoboy.vegasvil.org>
References: <20250925155908.5034-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925155908.5034-1-viswanathiyyappan@gmail.com>

On Thu, Sep 25, 2025 at 09:29:08PM +0530, I Viswanath wrote:
> syzbot reported WARNING in max_vclocks_store.
> 
> This occurs when the argument max is too large for kcalloc to handle.
> 
> Extend the guard to guard against values that are too large for
> kcalloc
> 
> Reported-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=94d20db923b9f51be0df
> Tested-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
> Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>

