Return-Path: <linux-kernel+bounces-873649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2194C1456C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259D51A66215
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057E73081C6;
	Tue, 28 Oct 2025 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="BgGXWr1L"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8342306B0C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650684; cv=none; b=dflrIBLDmPgGeXpargZxTOPQQ0P0JcDYW5zlkg4Z+c3UbGBIlyZmuuprtvOh7Y9CjUhzOqqhBzc1+i3C7WeKz2onYN4knJYor7NpRFY5W/jxpMVT50X3yjFJneyUNqUB257JKQ0zmnDuvO8LYQQ50UQLUAjUUyFda/khXXCg7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650684; c=relaxed/simple;
	bh=ZS8D7YevM68kueG73PP38JtCM4/TbPTO+FFQtYA36Xk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YPaatva8rcghyfuIVqjZwI174FSs25z7iD0gwv9lQDdf4RUCipjHAALoOgKTAEVg1gUD1lOQbKTNEzQi4sDe1fUGuHuGEOfA0AhBNs341M1sDmgskH2005gjyJLCME7YV23EOfFZoNL3V+OgnHQHvdBBtJVGcSk90iyW51JI0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=BgGXWr1L; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b5e19810703so896129766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761650681; x=1762255481; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1X0JyiHF22wejOgofms7G80j8gK+WhQgjSa7+ha7gyo=;
        b=BgGXWr1LwuQwdmscGN2R6zsTMYKLiPURTF+5Y4Q8H7w3aRU4OEgoqnpYEGXfYh5gZq
         G3lC6sY0p/BcxJYZZug2Ddmu9t+WdYb+iU1/ib/oesOx9hgET9sEfUN4byOL9oglw8GU
         KKcvmTr/JisJLD56M0RcYg7vq9zp5E2YzqhxCq2rqueuVk2O5UqYY+f4ZdWE3KPBW3QK
         MJQm/SK3L97THbOmhMhNFO7icuodMEIM4bNt2cOH2Y81kBQZAznbmpKzlvPIABvtqb15
         OeQptLrD5PuyllwRoHMzO1qwUO0qyFg8FCDSfnzcmhnYPq5XxCnBsFKJ/OdTGM7UvjAA
         XR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761650681; x=1762255481;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1X0JyiHF22wejOgofms7G80j8gK+WhQgjSa7+ha7gyo=;
        b=Z81p5Uj+UEKc1714nQ5lonkvak2oax6ETGIw3+/A2teNTuaIZ64r5VxVwHo9SBGNSr
         JQzW/f3a1QfqknWg2LUIVv04Cy34s8e14F3G5AxgL+BbDTfWOS4xK5kFNHzyiARE+C1L
         jGJTATVkAxmrgsL0erCnDUxre3wn90i5jM8K/uv//uRv7Kl7Zu9ik5Cwcmm3k5X83/xC
         A0cwuvA5CSOW1PAd9R4ExJKhp9PXiuAr06sCkCIodUrYCSc7WupRN1c/senOe91AjEHn
         Q8EhGN7MuIgNxVrHXmPCexIrAqNF3nzhMbewk2dNf9BHt8DCnJhagxbMXQuBpo35EE3K
         ogzg==
X-Forwarded-Encrypted: i=1; AJvYcCW/zicQ1FVokyFx4v73k/cxQTrkLkZ5QsyJPQQKwjQiHItwMhSDix4HXRuq+EpYuOgOCta51MtxYR+lyUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziLaHt4exJBrCrRP2uScgM15acwMeQACshN3zgQwrh+RjJFT8X
	2/n+6UdCA3faXfm+vzILZJPMQcNTOsaOC9PU+rcaz44U5uLI/AXhnssSfIZdwN5FcFc=
X-Gm-Gg: ASbGncsXPQXVuYqPm+x0PSvckGrKuwojr75kqGHtXKqW75lMXhurnYwAIu4RmtTFBxJ
	o1E9M8yLGv3joNoFNRka15pFdysMYgK5gyGislufxReSFlgj+Er+zNzKaz31GSoJghJSgpyi4UR
	P6oRRsjXXJyLX8pNp+LTe5Qq4pZctoxsrzzDjkeOACNVrBE0C/42QGFTNVutR61cXFlFkPrPLnH
	/8WJ6/OV/os/j8Lz8/6UqAyrsAgkRLzj+B9Mk4ZJbeVE6LAiSKjawKDJ75sK2BR/8KB+eBN4aie
	5pFel3ZRcT5U+xfWrAzR7uC6Zry9g7UFFiK9U64mm5UwJl500QdEmejmoYxlWWTVEgUythYO0TD
	OOkzfOAKTs7J3/rV8FqXDjEXbNGxVagog2Aebbq5QCUNUBzBcWeLUdQXI+OhjE5z69c3EaqJulN
	fYaSwPRIofUg61lvDqpj+p99EyjJK6UUqwreKF5w1a8Odv2R6lWox9oqwDmMng0rRXx1PpqgF4B
	wYUi1inczlk5BcW
X-Google-Smtp-Source: AGHT+IFncZEIG2aB8fskoYH1N8Pf/o+3C4t3kr4xMiHMDpXB3GXPV+hTSqwVR4PFYW4I2LOJqiq/XA==
X-Received: by 2002:a17:907:7205:b0:b45:b1f2:fac0 with SMTP id a640c23a62f3a-b6dba4a8d87mr344374766b.29.1761650680970;
        Tue, 28 Oct 2025 04:24:40 -0700 (PDT)
Received: from localhost (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853077d2sm1068327966b.3.2025.10.28.04.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Oct 2025 12:24:39 +0100
Message-Id: <DDTX1PP2BBSX.WS61ZEATB649@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] media: qcom: camss: Add SM6350 support
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Bryan O'Donoghue" <bod@kernel.org>, "Robert
 Foss" <rfoss@kernel.org>, "Todor Tomov" <todor.too@gmail.com>, "Vladimir
 Zapolskiy" <vladimir.zapolskiy@linaro.org>, "Mauro Carvalho Chehab"
 <mchehab@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251024-sm6350-camss-v1-0-63d626638add@fairphone.com>
 <20251024-sm6350-camss-v1-2-63d626638add@fairphone.com>
 <7e7e35f3-82b6-4757-bbcd-38e0e867b184@linaro.org>
In-Reply-To: <7e7e35f3-82b6-4757-bbcd-38e0e867b184@linaro.org>

On Tue Oct 28, 2025 at 10:26 AM CET, Bryan O'Donoghue wrote:
> On 24/10/2025 13:24, Luca Weiss wrote:
>> +		.regulators =3D { "vdda-0.9", "vdda-1.25" },
>
> I'd like a little bit more consistency with the regulator names.
>
> 0p9 1p2 instead of 0.9 and 1.25

Based on the dt-bindings discussion, this will be updated in v2:

-          .regulators =3D { "vdda-0.9", "vdda-1.25" },
+          .regulators =3D { "vdd-csiphy-0p9", "vdd-csiphy-1p25" },

Regards
Luca

>
> ---
> bod


