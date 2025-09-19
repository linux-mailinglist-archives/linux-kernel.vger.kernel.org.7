Return-Path: <linux-kernel+bounces-823925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3171B87BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2DE7E023D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E86258CD8;
	Fri, 19 Sep 2025 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HHh3obMb"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1352475C8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758249970; cv=none; b=uMiWQ5igTSPaZOw+uWdf7rRXiNvctG2mmnpCE+aEt9Bf3ypbIpMvs30SEilLfM/k2cOmstT3avwUm/AGVie5URe2cKzpPmJ39qBXkmAw2RZy55xbj5y5/IuJAeF/iklhyCU3+ZGuhZlVZCpUf2CibBCUXSyzO8yPwxUtty+7Ug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758249970; c=relaxed/simple;
	bh=C3rJlPeakNHxNeSRxvndvY3Bl2Okug10Y6PTrK8S7+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJp0t9v6DUIKKQXePiaRQEc4H/N2/JMzwsnaTfSbq1OeSO1wrnSREejWmCJFlZhXIHjLVe+PxnlIbzdzw1rXi59m7jIpYGk14dePUnZ+5HErqSkFGEB0VMqOvNM4LYHyJzdWR7SO5ij6haAmFI2g8/H2NuJAG7J6FWGUWwS6R+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HHh3obMb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so11422485e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758249966; x=1758854766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RV82iQeoL7J45auwt67Jr/9GlmlJe4+A69CPPiwNB4U=;
        b=HHh3obMboGgP3ioZnfCL9K42Rq3mM6Vil9JIfum3/ck2VcfJr5CeDwpe8Z8LF1kdn9
         utQbKaIBuh1ZmBzLTv1MMHSt4sAh5qOxHp4w/jTKB1QoEOoBNNj1pBDH1L7E1mgxGrme
         8vLmZmRxeIHHE2MB/tqovf5zbU/WzjH1spWTi7Juz6qwbunyjJVFrvaQoUderiDDQNe2
         HoNAU2jcyJU4c5vFYNP7k1cMM8gqp/xa81XjqlKFmbxIrSvR14/HLzbkjKV+rqd4uv8X
         Nz+uf8OBINEUF7Y2ZRPGOIxsJnz8aFoXmE/+I8Jr5ZzzsRLGqf+CvWP55cvqgE5MODsH
         MxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758249966; x=1758854766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RV82iQeoL7J45auwt67Jr/9GlmlJe4+A69CPPiwNB4U=;
        b=ZJk0uhwPHDzTcfoVUiuPG+lOMSgkh7RBteJmhGJvYDCtURxXiadytf8azZnjcPhQpI
         ylFdlcYny56qUQqWleVx5WH37n1YETXb3BHNDN8HQ5ZSjePYF0naqEfJiWiCJXRQPf+y
         sMe+tmduMLP30NrJSvAtOgUdW9Ur5x+p8i7v5R08eUi15FJaMrq+unWLRouE81C+x8qZ
         +EzLIDSYLJaxVEY8buC50BqfCk+y7g+MRbkPRFtimKLVcruu+pYr4y1UgaeV4Oqsm4S3
         8UwD7AoygeaBEVwekX8eSiCzEC0NlWy265XiHGKemMSk/ylnAduM5gUJ/U/oFN/GRQuh
         aqBA==
X-Forwarded-Encrypted: i=1; AJvYcCVuVyKw45RFsrQGbcwJ3w3Vtb5ffeN190rPGfhZTho2Xwf3TyxpW7y43Lp/1TmxHYEr72V7nQOB/BYxcw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywao35rSANAggKUqo6G/Q7eLj6TG65fjTtIql/1B01FcZgwuylm
	CQ69ygm+8z84L4/7NirwHNabDVxgRE2o0zUWbzS05RhTEUqhSfIIoLM=
X-Gm-Gg: ASbGncv4H0z9NtaAaVNZlh6sqsG8VNNMKI5as/vx07fGj9MFT3sfEanK2ae+7i8uiL9
	bAg33gr56cNGSPYcbOVKElgs3xiqBdCr2symjnEYTyvFd5uhw5wiZZsFbnNhkiWt2l4YViR7JEE
	eM7HnHhaStQhDPEN4zvap2k0UhRdJP0/Mo2n6LRKr83xNKCxU/skI2YnYXaE7DkEDx7zf9fDnMG
	VBq6pzkNpFdQBqPCJjfnNy2Z+O/WDMoT5Rt/6uRJFqiyT1g1H70E1pa4IdS6yYwKzDsVblLBR9j
	f/hKTkPl+joul6qdUyDjnzHlrAsQhoHgyhErhBlFwerQkiKsMSH6LcZGnR6aUuq+XB+r8GIJpFo
	9O6QX57mAVIhQaCPDNofKw57FJj2galNQ8TGI90cmnbNzn4qrh4ap4mCOAKbchEYzC6VsLhRqoL
	Y=
X-Google-Smtp-Source: AGHT+IGgQuGA3pdRA6O9frETa1wvqCMUipxJgFmb0Z1HCL/sLjXWcSHn9dqNe7Zf38rm77aViWLBYg==
X-Received: by 2002:a05:600c:1910:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-467eb0454f8mr10603065e9.24.1758249966425;
        Thu, 18 Sep 2025 19:46:06 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac915.dip0.t-ipconnect.de. [91.42.201.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461391232e7sm103225465e9.6.2025.09.18.19.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 19:46:06 -0700 (PDT)
Message-ID: <f7a654dc-aac0-4898-b07d-c6b46bd4dc1c@googlemail.com>
Date: Fri, 19 Sep 2025 04:46:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/140] 6.12.48-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250917123344.315037637@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.09.2025 um 14:32 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.48 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

