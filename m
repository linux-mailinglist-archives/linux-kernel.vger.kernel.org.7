Return-Path: <linux-kernel+bounces-807427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CBBB4A445
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429693A2436
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45678236435;
	Tue,  9 Sep 2025 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vqLahdfO"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4E31FF1C4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404500; cv=none; b=HWHG0uWe1r8D0RuSovbmh2ZWYu/AbeF7Eq8ui/2kCP1DfNdX2OqdOBUuzVLNFwwv9w/RLZ1qbwRjn+OyvdMEj+fHUGLEH8cDDJMnVwmORH9gw4UejqyfhxDy3gbHj30S6I9CrKDrBbDEtEvUfMYL0ZrOYPdCHr/pa8xVR/1nwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404500; c=relaxed/simple;
	bh=bPYYoqftfSKsz0hlk498WcRINtzXQZnNUseNh+Begto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8lVg5EZq5U5Q7WlH1jseaNZyNh4u20TezXvMOnrKjlWvqjLSL+Ma1UiWL/ytnfVs5G8qa9Pb4cxEQV2PtOCvatdf2zgUGSrc8YBfMNzzvUUb4VNldpbTB/gEMzNLKfwJ7Qe236KM/u0GrFXAIwXcO7jD0PJ2CEEETCjqKGjsWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vqLahdfO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3dcce361897so3484741f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757404497; x=1758009297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t5sZUHke1cOrNWY6qZMJoyROLt4T1nD+uxD+OwzRsAo=;
        b=vqLahdfOvDoy3e8ZlV9Fw79WizA6wTAmyOsJarmprpE3i7Ue3xfaKUt9+ed67Y5qRU
         K2zJLRygdjzAxwcYXNciBakdt8Z+XH2JJ+ahny2CJCIV0uRhrJrCd4QvI4AA5LEdEdPG
         cww+VJuZdTNPN0R2hRtzhKKljhBjLdY3lgFA0a001/1RK+P+/Q5eBaZvB/73h3cPWFVG
         U0RJcuBKcuQqI7HKPOlO6VPBDLOIF/Kgjnz0Ad1syHArO1aDxWE9elmgJUdmk8mvP0Cb
         qVHBK+u9mMtU3lU5jAu0zHHEDhvFhOVCx6r1pOycHA7fWpucNeOdQ/ZvbjvOnc+Ie0dl
         Cz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757404497; x=1758009297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5sZUHke1cOrNWY6qZMJoyROLt4T1nD+uxD+OwzRsAo=;
        b=K3ZFdT2hGkEnxziWMmNezXoEqU2kfoUpqXnpYwwqc94VeblrhQxtpyrIRdGITQ1KmV
         OFTxOW0E2ZzPocjCH1QZemBlWmS0R0Ekoq6V0GQFaQYn7rsFJ5hA6+pAf/nRMTl0BN6G
         aVKOYOF3pZZcRVYpx3BZ7WWRZenbcgXGzvupks8fuWvyGFStqAr/qBn6rasicCr8BRAI
         /z5+AfALOdE9E5hMPfJ/yA27JJ+KeKCOahL1jGyskZj+JILfbylJVLAD5oDpnptz+Kn8
         yQ0eTcSN8A9p9VfpYcA2yrm6qm4+KWJ/pi2qX63LTJIPDchPli8GfU7sWtvxPBDknDCU
         APWA==
X-Forwarded-Encrypted: i=1; AJvYcCXVlxBEwFT3/sxWQUNDNydLKtm5PHBMdZ5Qc0P7HZ3pv+HUAA694xy3X7dgwFH/OXaebvNGJag/DUq3evM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK6is2qoM+0IDo2Vkc0CaDaIAHVMhP0XIWynku72XMl6t2mb6S
	wLvSiIc7rdy4yhfHziS6y/5EUUzu1i50ZYO4iS0AV1XCMx4yF8v3220dbWYu7VEWnKI=
X-Gm-Gg: ASbGncsxQFpzUo5EQ4aHtTcFdHIOrc0Jht/25NXsYaHs1jnnRnUB5gpkihAMk0yI6Ll
	37JK5VRf0qGiCtW9OW4hAv0CMuK3IK9USSBoFus4slbYAwF6JhyjXsQ54IrXxHAascIuiA0zZ08
	2EvqXznPA2eJnXRB2gs9Q7WQN4sPDC9A9FqHKIjytOsi/lAVl7r16GyW0p4QqSRuvoC8locoFt/
	PkXYB9HDCSvw0axaO2BQKmCnxyqS6xfL1zmPIdklc0yFXZ1z+NUGqvwbWvbjytPPG2lQuh/7YNe
	GKy7b+pMhPfCJ2UbH5IdXgb7jSVfLGTEpwEWemZEc1mz7YdP9NoUPUf2bofQgaoJrfyQhWyPTKj
	8j8RmHVU6zHaCZ3Ezk7DqnVmMmlJU/k8BKWcGvQ==
X-Google-Smtp-Source: AGHT+IFMrL+qpqVZLHtIpk0NAIPagB6TkPEvQUOKqRDE9Ox6P//HG3+ZZPicp7UNZIR5zh9FPOH4xQ==
X-Received: by 2002:a05:6000:144a:b0:3d1:61f0:d253 with SMTP id ffacd0b85a97d-3e64cc61000mr8735700f8f.60.1757404497452;
        Tue, 09 Sep 2025 00:54:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45deff68b43sm5564215e9.2.2025.09.09.00.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:54:57 -0700 (PDT)
Date: Tue, 9 Sep 2025 10:54:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yiming Qian <qianym1996@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com
Subject: Re: [PATCH v2 0/2] fix coding style issues in sm750.h
Message-ID: <aL_dTVlN13Q2nYX0@stanley.mountain>
References: <aL5tjv_2YkvHPs5C@stanley.mountain>
 <20250909060130.12919-1-qianym1996@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909060130.12919-1-qianym1996@gmail.com>

On Tue, Sep 09, 2025 at 02:01:28PM +0800, Yiming Qian wrote:
> Fix volatile and camelCase issues in coding style:
> 
> changes in v2:
> - Split single patch into two separate patches as suggested
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

