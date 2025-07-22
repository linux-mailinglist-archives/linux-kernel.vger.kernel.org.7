Return-Path: <linux-kernel+bounces-740568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD523B0D5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EFC5189ACBE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3442DE213;
	Tue, 22 Jul 2025 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owBWUb6P"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCD2D7805
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176149; cv=none; b=iT/CZi32UX7PlcEkHz6PhH9amedf4ERCvnmFvsLvAfJYzTIe3kpwwkdM/oHWKU+5s/TVdFLb4oxfa+plrO8ej1If7f+jtVaSmRGHGjfduivVvbiAuZ4q/C1L+i+9oc9eo95jfg/Sbh/l6aqYm/8anMKy32wFUb2JFoQjnRNdR4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176149; c=relaxed/simple;
	bh=6yQpiSo0+rgmT/RnJIkn8LyzRl3XRGHtT6XWn0Ypfec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qaeT4b2Hgv3RESLY0qNyFGwOkYxMU66Z8I8krkZWY3iiOMWiHwCQ9R3DzoCz+RWydCjiJnL5B78l3fPXcEeLUsGNj2Y5LvNyEJlHxfqCvraKjfez8vqhtx20oXqQ+TSiHDHOmkUDAVvLYY/qpvLzOmVUv/zm1fkxNjfQB5b7YO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=owBWUb6P; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a575a988f9so3123249f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753176145; x=1753780945; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6yQpiSo0+rgmT/RnJIkn8LyzRl3XRGHtT6XWn0Ypfec=;
        b=owBWUb6P3jQkk0NqHo6BRopLuf4z7b+ZsxaHcie1JbGAQXOh1mjnowEfGxmDQEKC/H
         K+9U8xlMtqzLf0gDL+VIkfUcyz9tdAeze5jBpo/8mockt6xfZa/fY/f5t3o0vH11CD9J
         wo9ZLX5hia1sRXXmM12E6Cmyl4+4ALsH/lHKyuLtaxl7GpVT2HmnLAS6cABb6MC3ZXw9
         83sXbFItvn0dcvzHHpI7X9ImO1HYHhlscohthUdOiXZM0LTHG638JmQzIB66aLiSzwtz
         u2AEo2JxRR8Icmue9aeKWEE1HtkgwjPDlr0iQn8Us7bB87NikI1QT/KytOr4AId4Q4Ha
         xTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753176145; x=1753780945;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6yQpiSo0+rgmT/RnJIkn8LyzRl3XRGHtT6XWn0Ypfec=;
        b=a6F1VVUyuKKC6skJfFImIgjGvCw5dkAMFgd3/7pZwGZzGwZSdUTDF7NAHsF8Pq4e9n
         fpSnCs0FaduGEm+Sv6NUxE2ug76PIWT6xnPrrObbLx0J8cBPM6GPbhik2M3kCr2g5gjV
         D/KcGRKPYT0RytmNqYywII6kGqHHkixF1KN3VP7JiFzeoud+mwgCAjCrKr2QB/YqlW9w
         mPVeimWlLcrz/naXGFTGyIU/VuatIPsHMJU/U2DCzgRI1fBFAUYZUPbz131rwwO3S0X/
         GjxRSVvuebAvz8pP4dDtcWAapHBpkfFQZw7YPIY5m2KtQaf3S2rQ5YjSgfSfGurzz8Ao
         BYZg==
X-Forwarded-Encrypted: i=1; AJvYcCXSg+Puwu7HwM/Hdw4ty1oXCtRjPmaDg2DnO71JuEH1af63Jt+dUsuD+M4hwxHnad0RkSwngowb+P5TQXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdIMhO+GsjgUTeWxO4Leh5rCkTOtLViP1XRNCIM4M2lhXxcFB/
	0qUHQVXqJFCmkKeZad7LutSLkxDAmebw0H1B6RrriLPEwJ7MLBCKo/NXs1GbpBGSJlY=
X-Gm-Gg: ASbGncvnD0vGk1nQbRDRocXze9L6S/sLtZHSiKoGRXYKInxJkZGPGJqVWJ/AGxr2zpU
	aqY9fZO+icCVpxJC2Uk25CO96QXDc4M1hNTkkt8XBvwhPAQjf7NK/cNfxOBfcsOuLc5TynkeaBh
	T4JHOmRn7J2MOuslIWYl9nNAxBWJw1Czwj/si7eQV4wLi9fB5qSIdJaDMoN7oAi9TwqrSBmUOri
	IFYV4c9aYNMDY8Ous07t5f1waCWQnravc4Av49zWUfnmJrztKKV6PRfUCxM1SsldR1IFzELM0EN
	VvT2fPIEp/ptH7004bVOVm+gzFQewzv+fgBlVJtdyYgIXwX10QRXHKQaK5KtioAVQeB0+iWAhuM
	RWeGGsCYI0zHBqg9H8sPeEEdT8Q==
X-Google-Smtp-Source: AGHT+IFa0Cq8XCk1eei600ygP39rkbICfNwYJWpNDRsRQfPQ/EhYt57nAduutsvBoNK7GvU0uukHNQ==
X-Received: by 2002:a05:6000:2903:b0:3a5:2cb5:6429 with SMTP id ffacd0b85a97d-3b61b222600mr13228880f8f.43.1753176145551;
        Tue, 22 Jul 2025 02:22:25 -0700 (PDT)
Received: from [10.1.1.59] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8018a4sm186401235e9.9.2025.07.22.02.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:22:25 -0700 (PDT)
Message-ID: <f6573ba6fcb43f0c41239be728905fa2e936961e.camel@linaro.org>
Subject: Re: [PATCH RFT v3 3/3] ufs: core: delegate the interrupt service
 routine to a threaded irq handler
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Bart Van Assche <bvanassche@acm.org>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Avri
 Altman	 <avri.altman@wdc.com>, "James E.J. Bottomley"	
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"	
 <martin.petersen@oracle.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Griffin
	 <peter.griffin@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 22 Jul 2025 10:22:23 +0100
In-Reply-To: <68631d36-6bb2-4389-99c1-288a63c82779@acm.org>
References: 
	<20250407-topic-ufs-use-threaded-irq-v3-0-08bee980f71e@linaro.org>
	 <20250407-topic-ufs-use-threaded-irq-v3-3-08bee980f71e@linaro.org>
	 <1e06161bf49a3a88c4ea2e7a406815be56114c4f.camel@linaro.org>
	 <68631d36-6bb2-4389-99c1-288a63c82779@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 08:28 -0700, Bart Van Assche wrote:
> On 7/21/25 5:04 AM, Andr=C3=A9 Draszik wrote:
> > I don't know much about UFS at this stage, but could the code simply
> > check for the controller version and revert to original behaviour
> > if < v4? Any thoughts on such a change?
>=20
> I'm not sure that's the best possible solution. A more elegant solution
> could be to remove the "if (!hba->mcq_enabled || !hba->mcq_esi_enabled)"
> check, to restrict the number of commands completed by=20
> ufshcd_transfer_req_compl() and only to return IRQ_WAKE_THREAD if more
> commands are pending than a certain threshold.

Thanks Bart. I'll try that instead,

Cheers,
Andre'

