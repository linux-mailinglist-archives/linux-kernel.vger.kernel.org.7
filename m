Return-Path: <linux-kernel+bounces-880059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32E5C24C64
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DEB3B58F6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AD13451C9;
	Fri, 31 Oct 2025 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVx0TeTu"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909202D4807
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910040; cv=none; b=JM5K5kFHZN86pkj0O0lMaESOssS4ZVNmfGYu3ioih9B/32jjKN+y5oXMsgtsJZ79crcrDkz2R6LNitEXKd39cp/fCdVQin2vu62PNaFM0TrTM8IUYb6JAL6u75uahOaPVcJ+Dy/RcF8dwS+YsKCB6jcAArwTvrTzGk37rM4oyAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910040; c=relaxed/simple;
	bh=plC+/6CrEBYyMLwLcmmekRAtRmr4crxYvfBWrqa4EsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/Lg1rLpGX1/ZMNNbK5pjSJgORADiThNOl0krg05rp7QGAR8A9y8qxslpX8sSw0VYudRtkeE1oqS7iKRUd+TjXhjMb4b5zuG1JZpzwVpxcZzqw9P74HHlu79f8pbeSXDRYnASwA/UneNoi5j8aknGMCbWJ50q7yZCdg8UU7IdKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mVx0TeTu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475d9de970eso14745085e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761910037; x=1762514837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwf871RDbtgle/X+gHRRa1kmehrfWm8Nitz2OZjIhxk=;
        b=mVx0TeTuTskgFvVTRNFRNe6XPJ94tkP1BMM3Y+K2B68F7NwdV8zrYxQtzarW4GnYHN
         2akQ1i0UOJPhSqXG78UBb3x/gjoD+M1vtBRBMoRzCz+nr5/hoE1RUzwdR6sK30PiSC0N
         UKgyltXMeNnjYB8zeitgS/3/LFrhIXkoDINbmEfZtBL4SvulrJ4jZmymUYq0y+khpK5q
         H0Xqr0TMWLZ/853vx/Z2BIy84xuxgKHy+s+RKgYKNiQnj1Yk8XOnpcZUREm2FZev0Vns
         Ex34fuxZ7RZBIM/sWha4ANvIYjrhV9aubPIfpZQQeEu1rcWjUVVCaY8Scvt9JYx6O+1p
         Ltyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761910037; x=1762514837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwf871RDbtgle/X+gHRRa1kmehrfWm8Nitz2OZjIhxk=;
        b=IeTGAjb5USA3bALM5SZ7OB8UBCKxff60DKTGI3jXVHb9dbOrqxnCCEWAUXUfBM/Dc8
         XEFFH3sfkLHkeuDzJ6YcuGzNJEjpL7iCRa77CLuZuR31EezJWM+PYzEEE8leI2AiL7Sd
         Eo1fT71/Fu/mwRMZ3DOuKlsriXBrJ5QP2vslLO1V3Gij/i9jfJqT2t1DBC5gZjmVgAYk
         IaUnF3D2ZUHFdBohd1UHu/+dzHVR0BQDBQmB8P1DCBjFG3WlJsMvkSprJ1qhIpyzWlXj
         51/LgOHckuESjF2GKpGKALbJ9s8bf0LXtvkIXeahUx1pu6FgwjZNzXQ8zmVwnDcj5q4t
         GNJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfqMYsQA/fsWe4ytQkYSrkUOxi5uqSr7PI3a/k05aVJTweIXVSJyaHpyRxdWrbq+X27fjtmGbszPEuR98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOjRmHF8KtBY9HBZyjNG+QjVkiKJL+OXzEW2PD2b74XfBNt79
	FJmAXJqSaRfTE4jGjMi+C3U3R31XkQOMTQQKXIVRafZ2iUYMedF3VDxDfnHeH/rQluo=
X-Gm-Gg: ASbGncvgSpCZ/N1X7pUYQKmG1zliVlucHaTgB3rGB1R74Pnb5MtXgmIXZZ98Kmeerrx
	4fB43Q/fGcHTDwO7f9f8ccHmUSigcMb8m0KJA6PfAv+vLpSsjY66mxrQahD12PP+vcmZk6fq6sN
	ViBJByR5bqqyZs5a94S43n0JtUnFe5fdhuZ+REzCdPpNAyleik4JU3iItr+7lfLQqV0cV+JGpqB
	KKMuKt2iwUyrWkXQfeBXeDXceg/aomSTrjRzyrWEHXw01H5nCoFvonhDI9nleTVM9sUe4rFbIwa
	CJ0EDqOj4Sz1SZ+eE5hisdzzm5szlqWAIfKT3q30b+kd67mKMvP0mMew5F+EoMqR8So9aaQfAmZ
	E6gV/yWfhG2ZZTeoCAjFOWaXJuwyx1yLan6XgCf+/qH1IN1ajmRzBY0U8wrmVvIzuYG9rlibiR4
	iObgtwVw==
X-Google-Smtp-Source: AGHT+IHOCxnrV9vNtIsoHM6missOnF5vwOTnrAGX8+16mZQ7e1sifCeCAgu5UUuGQnX7eDw9qPPn1A==
X-Received: by 2002:a05:600c:5387:b0:46e:1b89:77f1 with SMTP id 5b1f17b1804b1-477307c23d9mr27753125e9.9.1761910035750;
        Fri, 31 Oct 2025 04:27:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47728a96897sm90006865e9.11.2025.10.31.04.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:27:15 -0700 (PDT)
Date: Fri, 31 Oct 2025 14:27:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, sparclinux@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Christoph Lameter <cl@linux.com>,
	"David S. Miller" <davem@davemloft.net>,
	Finn Thain <fthain@linux-m68k.org>, Tejun Heo <tj@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] sparc: time: Use pointer from memcpy() call for
 assignment in setup_sparc64_timer()
Message-ID: <aQSdD5RFHvzJOlak@stanley.mountain>
References: <2fa899eb-60b6-4637-9035-aeff78e261fa@web.de>
 <CAMuHMdX-uKt3-Lb2NaxmONEqWdtFgTOqXEo1nOfGq-R8ysHfcQ@mail.gmail.com>
 <33199802-d83d-48e8-9032-f1c4c61cfee7@web.de>
 <CAMuHMdXL+YXxwAM+HkawzTMxL2ez5O4bQ-j-LCCXTjz=NoLOKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXL+YXxwAM+HkawzTMxL2ez5O4bQ-j-LCCXTjz=NoLOKQ@mail.gmail.com>

On Fri, Oct 31, 2025 at 11:08:39AM +0100, Geert Uytterhoeven wrote:
> 
> The above function could be shortened by writing
> 
>     (sevt = memcpy(this_cpu_ptr(&sparc64_events), &sparc64_clockevent,
> sizeof(*sevt)))->cpumask = cpumask_of(smp_processor_id());

Heh.

regards,
dan carpenter


