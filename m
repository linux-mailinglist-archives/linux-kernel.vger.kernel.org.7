Return-Path: <linux-kernel+bounces-725133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F415AFFB28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0401A7BBFC6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F0528A70C;
	Thu, 10 Jul 2025 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWh1GAoz"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461DF289E00
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133273; cv=none; b=Z0wmFMYP5o5WRbnVH4RdmH/ox9srmWo3EmpQag3KvVuYbM8RnkZtwaJ+DX3InC4SMQ088KMx/99GL/c9POHzxw/4bW9UXiHIP2aDsWVvzvLDXQqssGAF6oIIzQCJI7DMKldVvBK9Gnw2d/DKg8Q4Y7NAgB5Xk7c+2KSocYyrpKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133273; c=relaxed/simple;
	bh=GYNoVdAKRWVmE1F4lpwjJnXn6AMF9TT383wPE3kxNxc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VvY1r0IgxtA+35/6lqr/iPPoaptHfFLeXPToe20nUTzUFQgK3rcbmZ5MiPZYx9GTWxWTdVmp+JZlKDCGZfpGRue7gs26jedXusIgowv7SW+zLZ0JEVAG3IOtNHX8dmrFgevs+c9e0S+hQwrYRMFnfcABftMug3/CK3RiuIgCNXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tWh1GAoz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-453647147c6so5708995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752133269; x=1752738069; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYNoVdAKRWVmE1F4lpwjJnXn6AMF9TT383wPE3kxNxc=;
        b=tWh1GAozGBaBEaktfzI0TSxeCkQCh2GdRNftwCT5NiVsgJXNE4ujW677GNFn5h47HC
         IZOeaS/DqSzF1oe6Ba9xQ8B/rrJ2Vzfo3MkCaEOD2755ttnpdcX1SjtQTlrf1oaychwl
         CpfGKLq4nEqEJO4vX40C0wCda0fK9m6pO+vMf9b47tlSUta+n0b1Glu7zdkm17i8azn0
         pLF+Y+o0Bw3ZiLIvDoNjrZQEjv4pmZM2BQgt7tKVfHpxTjQ2W4vWa7Ai1ZhpDM4MWBbj
         nznqIlC2So11ApZYfV8iHvu22eJjESCxXDiRSOTUhGOGkaKrc5AmGh2pFXeryqHwYz1k
         zbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752133269; x=1752738069;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GYNoVdAKRWVmE1F4lpwjJnXn6AMF9TT383wPE3kxNxc=;
        b=mdHarmDutjJoe1ZG9NgqoGxnd9BOuwDiAGGbl4SjlDFYgqQPfG39WYN2bESVpmGv8c
         +QSC9qXxMfcZhiQVnKgWygXi4Dz0rdK/cNsFD+KMNN6vx+PQxRx1XdSdzEIjUT8MB8SM
         x0dUEFOSNSfwAYmyjY9asQ707mCpClliD+WJwzpkGLxWF6D3EQrCNxUh9Z+/fEdG5qXs
         ouM6uuDgdvcYmJ2NflaVSjGzNHDRwRWuN2hlgT1ti80RTYLwYnr+egK1HKCPw+6Ir//5
         N8XN+zNf09eFG6xm3iFToA8LXykZf/VGjw2PVWeUljxB7A1eJltI/xiD306l2B81tJgB
         02oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnhKdYD98MkkFS+fT3XwQeB610BdzbgEgV7aY3jxySP1wv5JwBvnqBv6tWEDH5T7myl4yNO64u4iNdeTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqUSxa6w91UfRL31x5RCHiu2AWjVUrziEiINYtTrzG8d3Bjow
	kMBhjhj7dRU1jCpXUZGEgsuZIgupaNYSS50eFdcnnM+R601UOaatqKNZxJ9hsit6hIk=
X-Gm-Gg: ASbGncurnC838YZkHZbnHx6U5xHow1W4k4c/aqESNR6Bj/zJuI1eXiaR56kyjNdw89m
	odXfABbQkfU0itTTsZjDCRMeyP7Il0IU4/PH+l3VVsDyaX5hTCr3fns6gIQrHgUtpoIGjuorOd9
	RbC1bbX9LXMNsuV6BHctQPn1iF2erBqX4xELVX5MfrhS57GAWGKErFAT83uejNhTE3aXgllX3Ls
	LbHLLa5Sx9h+Y+vcIOdf77OpzhoewvNWXNoBelBhcqwzDY+hfpDFMA8PWPKCRYGZawBVLW6Z7ea
	WsaKMEJp2xS3WSrDgvm2/tkdo3DoqLm7oTxUZztQu2+ny/RKAUQo+pJ9IiKLbegx50/bJBlj8/W
	8
X-Google-Smtp-Source: AGHT+IHAKWHAz0ARt1BvQlaWFcq4y9BAt+xbNRCyzxhCMv47nKYFLDZpuaCU2IxFuVRakMsMLi6B1w==
X-Received: by 2002:a05:600c:1546:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-454d53a0186mr65715925e9.17.1752133269645;
        Thu, 10 Jul 2025 00:41:09 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd474a9csm11086495e9.16.2025.07.10.00.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 00:41:08 -0700 (PDT)
Message-ID: <fe445967514bbbb5bbbcc806f98dd6bbac9e032a.camel@linaro.org>
Subject: Re: [PATCH 2/2] arm64: samsung: MAINTAINERS: Add Tesla FSD DTS to
 Exynos entry
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Peter Griffin
	 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 10 Jul 2025 08:41:07 +0100
In-Reply-To: <20250710073443.13788-4-krzysztof.kozlowski@linaro.org>
References: <20250710073443.13788-3-krzysztof.kozlowski@linaro.org>
	 <20250710073443.13788-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-10 at 09:34 +0200, Krzysztof Kozlowski wrote:
> Effectively all Tesla FSD DTS patches go via Samsung Exynos SoC
> maintainer, so add the pattern to make it obvious and reduce the chances
> patches won't reach these maintainers.
>=20
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> =C2=A0MAINTAINERS | 1 +
> =C2=A01 file changed, 1 insertion(+)

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

