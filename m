Return-Path: <linux-kernel+bounces-725167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE37AFFB8B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8BB643572
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9EF28B7EF;
	Thu, 10 Jul 2025 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uzxu+4NA"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6AF28853C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134455; cv=none; b=cRU/akXXvM3rRWMLAzlLtQxTdxViFWStWzHSwqupfNwDNNaVxmWMOucZCNwzhrWd99xrWb/9QipNcfaq/AZFBCei1gx7m35KpCfb4uRwQ17gvYATJgsMAmDwy4aajBeVckRVf513wbpj7FEfKbl9VaexEcVxZ55P8fFYZBRA4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134455; c=relaxed/simple;
	bh=iK8IOTCXE2lrPjdoQaDJjyXlv03DESYVyObGJ/m44kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVBkMOYnMCYAc49dwUdNKfhyueKeQgR2nt2rd3YA5fD7Brjn87JSBMzqYLQxZVkcC5uDKjZ9ZLjl9molRVoolBUoUT6IfCY8kP8huftD5/7lrPh6mYwAA16PBkqM57dPoLlsIPkE4H4b7nTIHzkFrTWAE1UbqhTop6dZCKg16k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uzxu+4NA; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2ef8df09ce9so485084fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752134452; x=1752739252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToFgcIrPsT47qophkUF6t9hEDKpaWGkYpzWGaT7NuQQ=;
        b=Uzxu+4NAdve9XcUnFWFBHCBNjqpalyRMQQ+dFqV1zfDYJhEFqifdAH4w2/3/PznNHN
         XhOp4QrvgzAdwA4nTwqwRv3bDciGdY2BmjM2WEMHx2K7mUyz2CObhpeBoWzP8DW5yiwT
         8OcayffK6GHXAwRFRyLmVKqYZe+5Kee6r4gDAFSgvJ+s+zJF6B0NkPpWp96SSXfD5vp5
         mqIGf9CDXFUMaXx6K+mBxx3TUpYuCFaIqaBsxC+Ega/uMAWv8OAo19E4wk8soxxEwFfz
         OsOTWQ0kmKPljXHsr1sOZai40cJ9lwZvQqffsLv40q5wkipMXGNg+5fPIrjIVh+i9pvR
         iCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752134452; x=1752739252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToFgcIrPsT47qophkUF6t9hEDKpaWGkYpzWGaT7NuQQ=;
        b=IAUDS4U2sop3d1Bbgd8/VtLP1ZMRtNW65xj+RtRwoKh6pMZRPWscpufV3+Na8W5loT
         bBGa8Ux8Kx7MqWDykT+YVK1Gvk6S/pjyA2K6QRmv0QuM7CKD5oZxifUh2lYg/J3ErD8Z
         t2Yflvco79eMZmhwowY1BHio4/agFXVvS5X2qItXP0k9r6RcbW5Rwh9ojKPxWQ7mwAzz
         3YagbBfYhKrmSXkZyCWMsfWL2Pb9JZjuQ/SN/fzNTRDzn+eBZAOcSPAI6XQ2iEVi1VJk
         SEzl9BphbKCzylK84W/Us5f1AfL79qvdSt1JqZY8WPZtFooi7Do3gc8TgMGeMGLQjCHp
         jp2g==
X-Forwarded-Encrypted: i=1; AJvYcCXyaJ44048lYk8XzjgTYJEGm7kSMdiHkYAYbSGwoOIuNuhiEQwYiuRE5Zpfrvr00nERqEU+iP4hFhvKeV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0V5w77Kdljpl0ut9jZaF6ehEF9Pikv72eDvOXQp+1krCrAQuP
	Xdh/JfX55qEClpA9nOnOic3GpFbx5C4+TEPE9KWG3JPR+3dMRIRX/YuW6GZcqoysCkiMPJwt0kj
	gJhRkB/Jk1UZjkBEWuEInh31RdKxsXZJ0E3d9U1FP/g==
X-Gm-Gg: ASbGncvg3SDGeI3uYp7svQ079HECeunNVrdlvcCEZnY6uwVEgaHGGF9yBEvaEJdT/A6
	eicnxPna4nW+9PUvLNRnmQTJSfX2RQ/6T0qOTmm8B3cTjQORHECRTYFwOqnF7UYtKrxXkXRdrRx
	LA4dpJ2xI7vvWd6x/I3Xn9dP0jmunOlFpMbvnEXJAqCeY=
X-Google-Smtp-Source: AGHT+IG42etH9AipEwoVy40wJMSye+NWVNGQGCdLQSYPBIHb3YYmVeD+/TNpEhAraHgVOha7QcC5U1cAMQ15bwl7bNY=
X-Received: by 2002:a05:6870:a351:b0:2d4:ce45:6990 with SMTP id
 586e51a60fabf-2ff10820374mr954468fac.7.1752134451671; Thu, 10 Jul 2025
 01:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710073443.13788-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250710073443.13788-3-krzysztof.kozlowski@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 10 Jul 2025 09:00:40 +0100
X-Gm-Features: Ac12FXyPZ25VVFt9KdiEcMMJ5hhaX1smahS3sKtKfS3Bife6pmJ1SYWsA7BHfaM
Message-ID: <CADrjBPpkZf2Hc_97e+-ZX5hpCw+DubEOUNiJ6fHLx0Kq2PZ7Uw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: tesla/google: MAINTAINERS: Reference "SoC
 clean" maintainer profile
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Jul 2025 at 08:35, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Effectively all Tesla FSD and Google GS101 DTS patches go via Samsung
> SoC maintainer, who applies the same rules as for Samsung SoC: DTS must
> be fully DT bindings compliant (`dtbs_check W=3D1`).  Existing sources
> already are compliant, so just document that implicit rule by mentioning
> respective maintainer profile in their entries.
>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

