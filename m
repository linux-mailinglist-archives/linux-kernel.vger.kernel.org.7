Return-Path: <linux-kernel+bounces-747734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904ECB13770
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2481770E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475B6233133;
	Mon, 28 Jul 2025 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="hnRqEenl"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34E230BCC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694693; cv=none; b=H8ZcKoitnenhaGrR25Xv5YVkyNx6iIKzjACEt0aDU79TM5gRc+LRKjnfSXsIHYMvF0BJNmXVBqwWbzsTeB/45Azco7Pr8W2SjGceai7UNMIcNgbvPzE/lZu+H/BtYM10jTCy8Z0h+yXd/1ifvp1wstOG8UpgLRggCeH13gOHSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694693; c=relaxed/simple;
	bh=p7SaI3KRq9+LTs81Ai4ENBC/+OQ8Fyl2MN4HlWaQG8E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=JFbFeEim6bcmPLDtumrvTUMnSaiSVL5U8JgcTqwa17LtMBjCaUDLiLfh6BtDKuKqLrLWIu2fO+Zjrg/DU4hYbIxhMFKat3XVnuvhEhULVrJfRabvKJiFt4UO5M5am8r83aeivBWVTviZDknRPx2EkRVfqJvaTtgUtqUiVxHcWMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=hnRqEenl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0c571f137so799816066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753694690; x=1754299490; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7SaI3KRq9+LTs81Ai4ENBC/+OQ8Fyl2MN4HlWaQG8E=;
        b=hnRqEenl351V0jKU5o0FexJPeykocfKZRvqd3XPdnk3WxuWZwK00bVDgumZlsDIuYA
         qZBZjSv6nK4+/lxPc5uQC+3mJo0azz2pQMt8MS2MFmThRbPXSOiBQPBSJRH0R+rcay62
         2hLXp2wTfLHQxL+CJMqWzNRo/90jUrmwlLVfMC0kIEOtDk5qQT3p13mJEG6WW6ZT6NhT
         sbjSd7OUW5whJBGK3H09wQLtbxRJ+cMOhjckpcwt9x5oogSr9YA1k51d7HI1EHDDDz+S
         GuZtAeqhdxjNnC0H6GqZbWsheZ00/JaiyAubXrB6KWTN72i7o6MQ14blYwMBf1V650sC
         mBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753694690; x=1754299490;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p7SaI3KRq9+LTs81Ai4ENBC/+OQ8Fyl2MN4HlWaQG8E=;
        b=h2E+7Hk8g6vmEP8fcvAyKvg/HFZfLjLJH5TcOUJSJ3AfsTmV8EtlQwJD+rsGQ1+Bm1
         ER68euJlsUyOvo7ISqXnOTCxHVKyEgv9kVRGPwvMATlAFQvOBaGlbhEDHZWITjoTikRl
         K7FvH0c11VfTaWvG2JvZlIAkEdSrQMH2+oYtQAn/fboX0TL8hvBGmC/ou70Yeh90Jr1P
         Qc3z49MhAyMA3wXRvKzEatbekOliG4eZnwQQG3pfkgkUCOU8uoKFHXjmpjKCbf6bcxf9
         LMvfJztthSHK92WWqi1S1NmVBg55Sdqv/lGzwXw/BxD2rHlgJgwR5b7YHhWpE0qqOQmx
         lQ2w==
X-Forwarded-Encrypted: i=1; AJvYcCVnBs91j58MJ15n6IKjg4dNU4KoskCxzv33fiZABTOu88bbMOQbnslFxcKADNFYgmMrdJUU6TQM2wCqo2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0pnO+IItQdC0YxM4tq9hxoFrnE1tK73iSDqBE9zlSNWIGo37r
	mzEA+Kek2e3wVHEwrQ9+LXh0leGGFH/hm6YH035/AYMkvt5vAAXGQUol2aG3TkSxhQVcWtKbgTT
	XQTjb/FQ=
X-Gm-Gg: ASbGnctdmiOUBTU+PwjfFXHnVVylum6zDuG1v0CvCYPfgbAFI1sCgUtMDcrikurMCOg
	tyVbZW4P9+sFUu+cnagOIfyJAkSOkllF72aeWqGeaO6zn5NdPVtTu6mkL655e9Uv6YpSj3bx3+g
	JUpooM8beEJrCY4lUMkuG/nLz5Q8+PJT8J73JnkW1k3wEiw3+vGIOfTx2APQyRwrb+OoUXHquTB
	51jXqupaLBCPa7p4n9D457OqvDbBaL+Q67WRIwO9y/S+ewDg9DsscI/Fo6SrPM+IuZe1Kiwi+2n
	qPttnwvN0sfB3pswVKthXpPJa1IJd1hHUbDD8F9dvvU0RY3V8C+qwKRNKd8rYQfLUX1UQv6VLAs
	K1086tNiEWegRhUagT8qDRtVhzdcDmfFwHiW7MzFjlfmbw+fgrDJvy9qMnhHj3sHKb1Y=
X-Google-Smtp-Source: AGHT+IGk6lrYnsZId9mCE/cRiQIVZNKCJUyZ+AEWNPRvXM5N0BY5nsGMSTWyTaZBxtJaa8J1biPu9w==
X-Received: by 2002:a17:907:e2c5:b0:af2:4429:206b with SMTP id a640c23a62f3a-af6190f8b0amr1131320966b.33.1753694690008;
        Mon, 28 Jul 2025 02:24:50 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635afd811sm384349466b.136.2025.07.28.02.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 02:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jul 2025 11:24:49 +0200
Message-Id: <DBNKVU7OQHNL.12Z6O3PI6SHGU@fairphone.com>
Subject: Re: [PATCH] slimbus: qcom: remove unused qcom controller driver
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>
Cc: <srinivas.kandagatla@oss.qualcomm.com>, <srini@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-sound@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250724132808.101351-1-srinivas.kandagatla@oss.qualcomm.com>
 <276b7977-45d9-4b37-a4f5-1c65802ac267@oss.qualcomm.com>
 <mwhxikivaxtz5px5e7jkqtuuk2iz457fy5drsnaj32j4o5qqk6@hwkcjso4jpsp>
In-Reply-To: <mwhxikivaxtz5px5e7jkqtuuk2iz457fy5drsnaj32j4o5qqk6@hwkcjso4jpsp>

Hi all,

On Thu Jul 24, 2025 at 4:24 PM CEST, Dmitry Baryshkov wrote:
> On Thu, Jul 24, 2025 at 03:31:50PM +0200, Konrad Dybcio wrote:
>> On 7/24/25 3:28 PM, srinivas.kandagatla@oss.qualcomm.com wrote:
>> > From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> >=20
>> > Qcom Slimbus controller driver is totally unused and dead code, there =
is
>> > no point in keeping this driver in the kernel without users.
>> >=20
>> > This patch removes the driver along with device tree bindings.
>> >=20
>> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.c=
om>
>> > ---
>>=20
>> I *thiiink* this is apq806x code, with 8974 adopting the new hw.
>>=20
>> +Dmitry, does you computer history museum require this driver?
>
> I never had time to try enabling audio on IFC6410 nor Nexus 7. But if
> the driver would be actually useable there, I'd prefer to keep it.

FWIW on the WIP msm8974 audio branch (from years ago, unfortunately), I
don't see "qcom,slim" compatible being used, also with no change to
drivers/slimbus/qcom-ctrl.c.

That branch is using the compatible "qcom,slim-ngd-v1.5.0" for MSM8974.

So at least for my museum collection, it's not needed.

Regards
Luca

