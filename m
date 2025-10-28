Return-Path: <linux-kernel+bounces-874407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3530C1641F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02A53BEB05
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A431D34BA3B;
	Tue, 28 Oct 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="HYu6JTSP"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C808E335086
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673249; cv=none; b=Mfp3a1/UkyGCgI4esprQxTEOc4gGq9uXbC4BWaGWBMVYTcaK35R2mjGTRUw/nQOtvyf+gHri9B9K2dciFZAE4EwSq7WpDf6HmNh8IHXUh9KY5MFYZXx67gg/dEI9apYWB3pB4IquHKHFNzv98dBx64TN7DvWwE8GjLYL573W764=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673249; c=relaxed/simple;
	bh=k2oFcW+F5IbZatog7pgx/F1s8i3ixYSpqpoKtIdHFps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdghND6R2rSvZ+tCSnh5EgTOn9/0kxuBz/9zwfNLUnvSmv7dOedJ5t/GeTkUWn4tiuR5+y5pVvwTBJNjJdiTp2dVO0L8hFW3SM3FzMsvk6sZsNLJdHWpKv0fpDXUFHwETb3qI2E+sxSmLjEXFwEm9cmuN3bhIq+XBXMyqWVb0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=HYu6JTSP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34029c5beabso1342199a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1761673245; x=1762278045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luiyWuiRrVRfhN7JAiac9EdJ6Gfejadf8kzjmyI1PuM=;
        b=HYu6JTSPEmM3aFi358p+nHQ7iz5PIhYGu3CEjyHhDufkmGZJfOfYlH6SKOoue/R8k7
         qk1WHOraf6nH9510V+ZMqEykIEQopNF6hEu6vR16WZsIv5tZjczSl0J5F057Ku3BafTl
         MlPFUd2+Oo7+OGA68hUNycvRECle4yyA8HiNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673245; x=1762278045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luiyWuiRrVRfhN7JAiac9EdJ6Gfejadf8kzjmyI1PuM=;
        b=wO8Y4Q7MXuSQFA1TOP2ILV5fO2G2I/CewjJoCbQWPjAZHWil2EkUWEeBmLoLkppcv3
         byMahQTDFg01/CjLnE2FfAp6EAu9klOvg2FdIuAWW+gyLNI0DeBXIwWOhiByhKkNlgnN
         4PzwitmYPrSHEKtOHr8apKayHWpC4QaNfBOKa5ktthQMMF1yP8XGo/v+3q5/yrJhQb8I
         rwGOIaK5i2E74T/f84eSGc2aauky42Vcfpo6kfO/Lkcb6Sxdn596i0LoyEk9XtRv1VgZ
         6wc2uXnU0vOAoFP05fpHyCs9AOrAdeLgR8JF7Jgk2D4PJMtCHYuxH+T3SGoW31oX3EK0
         LteA==
X-Forwarded-Encrypted: i=1; AJvYcCWdBIcmkkCwxv1xE/ueybgFrJRHncn5ExGSECP6doz8+NooMvEDhWmeTFZpohhSGxRaI5jPhwvzIbQyjFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysKBVtHCumoe6GPGdodJuOxiGKlgTnCdBXFMA91Jn9rZ4Q8jV+
	btY5dr49NWJ/z44VxRN0ttqx9TXwnKa+x81+3QnSwHawjvilNPBU5JH17YAhIeJNFQ==
X-Gm-Gg: ASbGncvX2OXn1s7vIGusy1dzpCCfkYFeXR1J8DAQZbr5WBVD62T/KM2Du9TnP0dmS8H
	xDjMd+PvEh97VDvza5+DK1xZLThBaNq0irXbLEytwhC7pmBIY2UySensBwdVwJDx63LcJ6gnh4R
	wc98EL8b6Tg3wNfhnZmGUdxXXa5+de8NcnGzqu96Hzs848P/pjvAIOsHqgbxleF2yozH8aMpDPm
	23AtD9ktPlHCBlc+XDzIYBViM7vYJNKi+sIvjVIlOh6ZZjflGkDzLA0/iki97Ot24E5nS42QINe
	fRJOtFJu+jKbMYBcD31LUNQVxA8e7V/PONPaaA2z2LUNqS1Kr8XBlR2l5MlsyK3dShwcM/HDoL9
	nLNwfPHgtMPd6BmBoDpuhi3TPRZyBa9RGWZzotwOSu2ZLH+d8pef/KD0oMK1bO85p9CieKL4iYI
	rEIjcOx4ouwia3rYlSUbzj
X-Google-Smtp-Source: AGHT+IG5V4vsb7CrJYMRIp5V3RyRMADScln5MWpRKhmnO7Ie2PDaI8M38ch/Qo6ITFZL8KyPH7+JlA==
X-Received: by 2002:a17:90b:37d0:b0:335:228c:6f1f with SMTP id 98e67ed59e1d1-34027a06cedmr6107636a91.12.1761673244857;
        Tue, 28 Oct 2025 10:40:44 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.125.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a86fsm12863100a91.1.2025.10.28.10.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:40:44 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 28 Oct 2025 11:40:41 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.17 000/184] 6.17.6-rc1 review
Message-ID: <aQEAGdx7n9tjCu1v@fedora64.linuxtx.org>
References: <20251027183514.934710872@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>

On Mon, Oct 27, 2025 at 07:34:42PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.6 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

