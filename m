Return-Path: <linux-kernel+bounces-818438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF209B591BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6264A188E4B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716D9288C81;
	Tue, 16 Sep 2025 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="FT/W+ex6"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E4A28850D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013676; cv=none; b=QRCTIy1g1S11Bor0E+IbaZyjYlcpqGcsJeo1JmZkBZPovBCFNXNLCUb/g78OK/vJg73P8g0LW/ykUjrFFR9e4qOBFPZ9z46a0jkxC7hZlH76ctdUq+6goWnEiouRY2lq9VOos+4F4Eqv9MGCxXg9JJNGZEPQMU4tqIevayPTUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013676; c=relaxed/simple;
	bh=fM1QW+UFz5zHOwXNyLvYeTnh6QmXecM50gjhKcitTM4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a680wZhikH3Dx8xRLAMmYYqpZDMYiLqUDd8RAUDYu+7jLgFezia9W5Qjbcfrfv9wtEmappFMzahzgudS6jqUbD1i4VPN36yi3UrwLrb3tlnB0McQwzZEKYINH8wWUAVJq+tFAxqkaAK8eT7ReED+JI+QlSn8ZOJb/oa8tR5G9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=FT/W+ex6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b07c2908f3eso610877166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758013673; x=1758618473; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGPJfwEdnpfBh17k0uP4IdtgceOjAvM9dH/m5dD76YA=;
        b=FT/W+ex663OkQapBdsdZfiqLbYPbkbzVnog3Xs3mpz4Xgconp9x/dpGRHaPDtPNLW9
         ixh2cYtm4JWK60nHEFL7C90FMizD4O9NDpm0XgjKKbAKa6MQGVYIZKXtIyVNXEvXdPll
         xO78MacI3EikAFs5oCbgOJss/QVWcWRQP37/48n+Z1+GtSUaCGDnsrnrlVrWG8si7O1r
         94TOul6Ohbll7vJbAvAdeUmX/1lwebJ6Um7OcSVt28412nyHT+Czd6S3q0zXW3S+rlON
         zm0+nbxhnU6V+vNzOee64mcGan0mFlRda++wgZ4vaBj70pcHlZQrlVQPf/U9b0edpf2T
         khMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758013673; x=1758618473;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wGPJfwEdnpfBh17k0uP4IdtgceOjAvM9dH/m5dD76YA=;
        b=AQO997NcOpIuRxEc37yfsZon5WUanF9jpjJ6nsJGmYs5TmBe3dEm0mmd7g0dwgvoc/
         65KXGXh9T+Z+GcwRpL0CVlxZbD4zgHBLtUjibJsrYWsLKim72YdcUa7bOMVk0JHZVy7s
         ODWUQqJR9nk1ZC2hYMPctj0lQ0QT1wMHd1941ZOHSYACQKPPmpZYI/6wqb5IrfsNBG/o
         iZOsVlirm9XxFNNLbpy+oeUTn5SWeme2CGjUp3cTolCT5e7o97QOn6BcRTsKjWtQemeV
         BEpZvMuS5KW7VQkgyBbqEHY3DxqXqoNZDmStFNTdqe44KzG2LRpXprMQpuWAohlLhapc
         lwew==
X-Forwarded-Encrypted: i=1; AJvYcCXTuO1ng8azz29EGQ2pTbzA1PzXac6E1FrbT8R8WWQoEBKej3+2/ILzaMeeKZKPGaKdsNydMc7bbdYcHIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsR031ECBAv+ViRnDdXXueRmcmyouSHFgV9jg1Rrw9W+y/Nl0c
	x/KhNGYcAx06ntR99VJDf3DBvUZ88UuG9mcRmye34IdmVhZrhWQIcNK2i1j4fdKXqP4T4Wyxz6T
	BUxGCavlpGA==
X-Gm-Gg: ASbGncvoiPSiH6TwicYLDZANadpWW3Bczb5F4jeJ/+TJjLshZQHRZdlVX7gMcllF4oa
	9BPtWn35bb1IMvMFrSgtHDLzZGRQHRHxtMufDbXihUg3x7/P8+Ycu1H5676M+WxngSP+6ol1TSc
	bcZKT2fuLmE8vZgSOjfLBSe5xBGhIbzyxlUeywCVuyYBvzpFOohzw+bYXraWA0EwPAmk5jVjUCh
	5KFkyg+MTpN9liTcQc4/5DjVYIrUfc1+Ej6LkOkYjd4lUSKE7q7eOXElmA4DxZ2w6jSiNY5dqOB
	c+mZuqiM7kCNpEqz7M/isBIbXJZZ2n1iRxxIYU9dLRfONkXM73nbnzrIYe2aRNn5RRSWCqNUQTV
	e2hA0ruqbSZjvQa4cuOjE5nSQiHGi5Uf8dVxrLlgFlgNu4lAX6SeDm8oCD8sU3TZPGLp1
X-Google-Smtp-Source: AGHT+IEnV71DLjZiRWk5j6jXx0pnqls19vN1Qen2T1tQxSI6t57/t1s9FzfJ1We13UaEvDdr4m6msw==
X-Received: by 2002:a17:906:6d13:b0:b09:c230:12dc with SMTP id a640c23a62f3a-b09c23013dbmr778396666b.8.1758013673277;
        Tue, 16 Sep 2025 02:07:53 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c7159e6csm899506666b.33.2025.09.16.02.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 02:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Sep 2025 11:07:52 +0200
Message-Id: <DCU3U3SF3ZRT.ATK17JG93309@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 0/3] Fixes/improvements for SM6350 UFS
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
 <DBDAMGN9UQA0.J6KJJ48PLJ2L@fairphone.com>
In-Reply-To: <DBDAMGN9UQA0.J6KJJ48PLJ2L@fairphone.com>

Hi Bjorn,

On Wed Jul 16, 2025 at 9:15 AM CEST, Luca Weiss wrote:
> Hi Bjorn,
>
> On Fri Mar 14, 2025 at 10:17 AM CET, Luca Weiss wrote:
>> Fix the order of the freq-table-hz property, then convert to OPP tables
>> and add interconnect support for UFS for the SM6350 SoC.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>> Luca Weiss (3):
>>       arm64: dts: qcom: sm6350: Fix wrong order of freq-table-hz for UFS
>>       arm64: dts: qcom: sm6350: Add OPP table support to UFSHC
>>       arm64: dts: qcom: sm6350: Add interconnect support to UFS
>
> Could you please pick up this series? Konrad already gave his R-b a
> while ago.

Another ping on this series, haven't heard anything in the last 2 months
on this.

Regards
Luca

>
> Regards
> Luca
>
>>
>>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 49 ++++++++++++++++++++++++++++-=
-------
>>  1 file changed, 39 insertions(+), 10 deletions(-)
>> ---
>> base-commit: eea255893718268e1ab852fb52f70c613d109b99
>> change-id: 20250314-sm6350-ufs-things-53c5de9fec5e
>>
>> Best regards,


