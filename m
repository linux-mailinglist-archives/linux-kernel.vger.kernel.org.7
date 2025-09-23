Return-Path: <linux-kernel+bounces-828601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC3B94FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BE5168241
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAA531A550;
	Tue, 23 Sep 2025 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4VNFD/i"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE9A25785B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615890; cv=none; b=DE0fuaMuhMmlTA2jD+0af14DlNHxOdlx3acStseA+y+MS95FZxmnZGxRznAxNHYE5LxZKvP3+hJUlzhT2HC8BdcEKvLBtDT4UqHZJrkFmI2tIsfbnSFGj+uWqhVB8TJM9pKvX9WMlT8xkGo0GDFTlV/kvupBR/XQZOQ0D0yIFy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615890; c=relaxed/simple;
	bh=dxCnlkJxXq2EGJPZ1tZ94V08MX2xLllvGQdXxEda/2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLL20GsQv0DrIxaxMseyrPwLAtM5dhTqmvOtVUvP12Nr2nQCeqM+WREW9EjVzLpdRHsfY5viiw6dkxU7uLNP65/eMwOgQWBP8HWh4MK81HLGVHFTHzorrZW5AzTm53rMCAzQ+UPY+5cgkymOkm7eCZ78W6NZlQCZxIGur2Ivp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z4VNFD/i; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ece1102998so3306656f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758615886; x=1759220686; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZxNhYZvdVjbbAA7O2nlWpIW8uXfLnzpFm+bfSFng/Xs=;
        b=z4VNFD/iCANumGus/QVtgCGUHwfTIapzG0+MDEMXczLkJbRXhGvfrV+Z5TJQiSosP2
         ohkFe1kqjlIxLfYPI68ZqaDBLO1AU3/U+xySWq33PF912I4w5+2yLPfmg5yxsGnz9/Oz
         +q7S0NTox7WOR7JeUbQxI5TG/iY33j2HfcfjbBShYwLzPOprnvYTO7HcXuvKHFN0oH5D
         7lQYYpzYCgl0fHZpS00MfCCJip9p0wI3ApAFAGZ3FshAMjVyPfeFhGV98xyfQzsinOQz
         pEU4kjmuiJGfIFJlF33pl6kOT22yTVvBpFXKa4pO4DL2RIkz9XKs2CSAcBHXMgS+Rtkn
         8XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758615886; x=1759220686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxNhYZvdVjbbAA7O2nlWpIW8uXfLnzpFm+bfSFng/Xs=;
        b=lnO3Hubo1MRnn8cLj6hcAVcYtupnh0EcfLNKPkl6bR+8oKt7jx5Hwb8Li1mo+swlcR
         ugE8Foh0eteb5LYF4iNnD75XHzGdcvrE0E2piw+NO62zD2dJpJ1Q2ZcN9fmaJVxRH9hC
         zp0b7kwFLktUMu0gffbjG71WzqsJPhYhfF5LuQGZGBCKaxCZWkKZltKqNOpGs5vMLXx8
         XBlmnd02YgJxrdwXyH5D+x7sWOStLXuBWeK8ER/D5tOI+NG3iM/smxhabOdCACfWf47E
         rOAZqHw9gjgqId9lLgOTjS+YPQnIKMPcGkGSFL6Q+enIx91VjDjJXYOamTl1K5veHdwC
         viKg==
X-Forwarded-Encrypted: i=1; AJvYcCVF18XKIo0bLQ2LKphQJTKJVCcQECB14XpQxOidPxI9/qdhkKdEJitJzll/L6LxoBqaL1ezwmq2YwK9te0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNPIERjeH0f+uJsRkPb6FzUMc3G9LuM5hhV6R7cTg05mH+A5/m
	dWa9L4gJmNiGkY3qR2VZEHClgSgSHZA1t9yG7pEKDoqIxkjVePDtOY/rTDlUmyfo8kw=
X-Gm-Gg: ASbGnctksaSRcoFhJii6fXMKnh5VjvS8P+1Wuk+2zPWwgIhhYoEmdalOfjV7tHdcs76
	QyQJihGBSTlF4wyh6NmIStq/py4iyGxnFGl6fzAv9ebh2xFo8O8CxVoLJchVoWqmKzBHCs8XILO
	zI3DDZON1/BwByk4VzaqyyFLcBxyLpLllBORSNPxz48hxD1h5mYGjs43R3yx9hqrwdpvYr+BVhq
	mZ7vcMMdbidnOXn5++hPO0hVmqVBih5oqerNbZE46B92c+9UHVp2IALHKqtmyzbyfdihUa8dkJV
	HxXtH8QGSlu+jKHBPabSDefgZsi/2hrHjswR7OLQcVQWcLQn+V0ACAlAQOwtbJRL3AMQxkRrarB
	sUFYJL+4g3/MVA+zgG7gjeBPlQDbCF+KIzs8A8Tg=
X-Google-Smtp-Source: AGHT+IFU+sjP7a8s/NZmPKRBLF84hn5GUX0iuTuvGDJtszkIku+WbxTqwewJG5TmfqMf4a997/HbmA==
X-Received: by 2002:a05:6000:200e:b0:3ee:b126:6bd with SMTP id ffacd0b85a97d-405cb7bbd33mr1319369f8f.50.1758615886417;
        Tue, 23 Sep 2025 01:24:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee073f3d68sm23104079f8f.10.2025.09.23.01.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:24:45 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:24:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] 6pack: drop redundant locking and refcounting
Message-ID: <aNJZSugLwx-ZkbAj@stanley.mountain>
References: <20250923060706.10232-1-dqfext@gmail.com>
 <aNJINihPJop9s7IR@stanley.mountain>
 <CALW65jbwmP+Lms7x2w5BDjFdg_d2ainorAMTWmR_6NJmjV3JmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALW65jbwmP+Lms7x2w5BDjFdg_d2ainorAMTWmR_6NJmjV3JmA@mail.gmail.com>

On Tue, Sep 23, 2025 at 04:10:07PM +0800, Qingfang Deng wrote:
> On Tue, Sep 23, 2025 at 3:11 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > checkpatch says:
> >
> > WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> >
> > Which is relevant here because Google has apparently deleted their
> > search button and is only displaying the AI button.  "The email address
> > syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com is an automated
> > sender used by ..."  Thanks, AI!  I can still press enter to do a Google
> > search but there are no results with syzbot ID.
> >
> > I can't find a search button on the syzbot website.
> >
> > Ah.  Let's check lore.  Hooray!  How did we ever survive before lore?
> > https://lore.kernel.org/all/000000000000e8231f0601095c8e@google.com/
> >
> > Please add the Closes tag and resend.  Otherwise it looks good.  Thanks!
> 
> checkpatch also says:
> WARNING: The commit message has 'syzkaller', perhaps it also needs a
> 'Fixes:' tag?
> 
> Should I add a Fixes tag, even though this is not a bug in the code?
> 

I don't have strong feelings about this since it doesn't affect real
life users.  Some people would say yes, other people would say no.
Probably you should since it technically is a bug.

regards,
dan carpenter


