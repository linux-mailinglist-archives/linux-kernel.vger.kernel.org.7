Return-Path: <linux-kernel+bounces-775555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DE0B2C08E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B574E725ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC522A4D5;
	Tue, 19 Aug 2025 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9T4dDTq"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE030F813
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603061; cv=none; b=KzwbHV+4ZaIp1Uoo4c0NUF9uR6chwvx749/KsonHWyOGf4ebFZR5yEoHAI4fj8qUmJ1vm2UC8HRhtubFQ9VrNHJCuw2mIKY9slb/9As0SND4UTplIYnNytCGquLnIdGPYz5HHOT82H2Tu6OwlqBg6iXhzJiHjIyPqMfNKic6EJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603061; c=relaxed/simple;
	bh=RS+DDBsenDMGRVRuo5OpJ0by6/pE8abc8eGvwv3Szfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAlUoC8gOMqOkQwwmg/u0mdMvFMNi5sAzyWYd/MK5vkxPWOBROwoWhsZI5CURKgp9ux/NlABav+HrNfj4r4qXSjzLfE43XjQNex0iAurUMLdiv0NL1k03cdxH5tIXh4N+V1TtFxGAtwJMSg0hHGKLIzLhGL1/hmdoqY2tm5TUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I9T4dDTq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so689854266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755603057; x=1756207857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MlZSqNXnF5cFT3EKTsD5C3uA+ixCm4MLZap6H11YwJU=;
        b=I9T4dDTqJjS4jq0QjdwoeWQRXmAWQvbPFYS0e2u8VTGBYdjWEzZ/5mLK0pq8JSOmzG
         lXFYAAjqgvVOUUFneeHZQHh59gCz6bx4698RZzv8hIilHrQdFIVDIq+LWklvPojeneh/
         TwXkl86vCC386iFAX5MRIBOWge8IF5SSdTWrtvVGmcbzn2u8jjG5OHetpuj6OR6y3MSW
         op9kDqoS3OsCu0iHBQQkaXfVQI9DKBVfvlbUFu8v5SAQuikPE/V+/VZ+orSALcdatqPe
         MpISU+2sKowBpbhlDX1wYbmrLMunlSudUJykGUdotRdFbm8q2IawSVyMEhTqags7Tyzg
         Ocrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603057; x=1756207857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlZSqNXnF5cFT3EKTsD5C3uA+ixCm4MLZap6H11YwJU=;
        b=w3OK03dkEszUoBWL3+8MiZ7NdX28bsLK8zBJ9Nur6RKK8mvlyuGC8LrIziwOuEFg7J
         vsnqAQ1b76SjnGI+t6iRaqpS5ge4L//ObZKkkS7zmLzuJU6ZayvfxpLk94m7uE4wLcsD
         B+oAjYMPtzMYUa+09SEb1QabfWFEnTCYe0g9c497exskiIZuO8YcxtzJGU4jSIV4gjDD
         MnDjb/iMF0jdQ4d2837PIbdxp9DpAqiuWKQkqZxUzqxTDPqDkRl2bfip8Ws9OnK7p0K+
         clsgAYPtd+v58N1/QDAbDu51rxDLwEToawwUziHsYWKssK4oLxoafKeWGomWCQnYCf9M
         hlfg==
X-Forwarded-Encrypted: i=1; AJvYcCUX2AXcyzE+jAhkqwUDlyC+smBHedz+tVB8WUvYAWnhWflqqnJ9eOqDuoUSXzXgmp9CGcoyJYzhsrACkCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqDmhR2MyDQiTJVOHcydG2C42ifj23T9p9E+KK0fGVQH4K80X
	drTGDunxK+0sA9YMbQeP9HNonqIn4GniX7qx1kkOIiLtbB980X9YL8onpddbyq4MPevHl7SPNsN
	6QZ5MCGBBUuw/iR9QosjYKI2rFZ14t/wzHRGAPHLV2Q==
X-Gm-Gg: ASbGncvOuLd4j8HZmx9X5sEXmVJAGfIneiFioZtKiMGaBWAcccs0lfmIt2w+nYXyP0a
	4sDtyR70IhHgg6wz1gKhA+1CMxZHoB/6AED+mR/3WxKWE2zQg5IJKrNbcT6wBdDf4FaxNFiDLi6
	uXOrnwSBd1Z71Py6iJ60hlqpJ506UeSZDFn6zOt7uDiSfgY45WD5D4OPr3DoR2kQrBHg4BSCSTY
	Y42
X-Google-Smtp-Source: AGHT+IFc1qeOeB8SEpfLr5OOLAFUUqEj6GU45bLARYtHghlfX/crq9PpWhn+VH6PLkjxDEuyGteYvZKpflusqa5M/Ig=
X-Received: by 2002:a17:906:c115:b0:af9:57ae:dbb3 with SMTP id
 a640c23a62f3a-afddcb81908mr192322866b.22.1755603057341; Tue, 19 Aug 2025
 04:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818124458.334548733@linuxfoundation.org> <CA+G9fYt5sknJ3jbebYZrqMRhbcLZKLCvTDHfg5feNnOpj-j9Wg@mail.gmail.com>
 <CA+G9fYt6SAsPo6TvfgtnDWHPHO2q7xfppGbCaW0JxpL50zqWew@mail.gmail.com>
In-Reply-To: <CA+G9fYt6SAsPo6TvfgtnDWHPHO2q7xfppGbCaW0JxpL50zqWew@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 19 Aug 2025 13:30:46 +0200
X-Gm-Features: Ac12FXyaJepFNIeos9w4tdtDWEq_utvLUQ4wMo0fo8sqlMNsdeJO5hMNv6oFTrY
Message-ID: <CACMJSeu_DTVK=XtvaSD3Fj3aTXBJ5d-MpQMuysJYEFBNwznDqQ@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/515] 6.15.11-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, srinivas.kandagatla@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 12:02, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 19 Aug 2025 at 00:18, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> >
> > Boot regression: stable-rc 6.15.11-rc1 arm64 Qualcomm Dragonboard 410c
> > Unable to handle kernel NULL pointer dereference
> > qcom_scm_shm_bridge_enable
>
> I have reverted the following patch and the regression got fixed.
>
> firmware: qcom: scm: initialize tzmem before marking SCM as available
>     [ Upstream commit 87be3e7a2d0030cda6314d2ec96b37991f636ccd ]
>

Hi! I'm on vacation, I will look into this next week. I expect there
to be a fix on top of this commit.

Bart

