Return-Path: <linux-kernel+bounces-846812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67104BC91A7
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9B81A6276A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5DB2E6114;
	Thu,  9 Oct 2025 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVjMyp9y"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4D2E11AB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013927; cv=none; b=d4MO4tf/MiyBuVFykLEPZiKK5mrbweYNA2nKqQWXSjnkRtSS8u/xFXPeNFJ+T6CxGzPdYT/Fac+6E4W+9Nyx229guBhkuW1hpOQDWEY0oRHuaiLOEfl0dZSXKM57j0kFcC0zwsm3LPpUUL9iBKR0GxePKLI2hz3ADzHteuc+8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013927; c=relaxed/simple;
	bh=+qIn+RPmmwPv3OjgMXBX77cROFYyBV3LwSb/xEzaOA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I5jBYMe3ouel2mfIH2GlOUsXu78XrcZKg4uqCzenKdcYDzwCJ/DyznCJVXPBKMvnaVKKpV7LWd70I9zPHsniBpU0PcvTitgcYxQPjYtN5l/SiMaIJduYcYeVJNQdLAP2trZKsnULAYL9pYXGgJjUMcU9OQO8eQG4C03QMH4dfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XVjMyp9y; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso1604984a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760013923; x=1760618723; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+qIn+RPmmwPv3OjgMXBX77cROFYyBV3LwSb/xEzaOA0=;
        b=XVjMyp9ybbgsoaIoC6phHf0gwxtiqkvDTBltEZRWMXSk6fiOglqgNCBGLdih1aeLXi
         wXwSmbwg+ykKhcO7s2ekQZiqcb6+L6GbxwAyGMJrF4w9/Du7pbucRWUN8zDwRam5Ui+z
         I5fKc7qcG3dSzvD2cG4TzOCc61dyPqqBIKKtSMYmAPOgGYSrimg8vOIhlUZY3ClIbQWd
         0kIbhYFBP9RCKAg3ZKqthtPQPcMOSL6vSG0TvkRh0XsXDjrjKTKGTqcSfb52Xp4A+qX6
         4XHPyTEZ4uokAguOhB8yFBvn0wb8AIVgtofX57M5I1jVzH5WJWAqr1fR5A9XD/XihoSl
         4RZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760013923; x=1760618723;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qIn+RPmmwPv3OjgMXBX77cROFYyBV3LwSb/xEzaOA0=;
        b=gj1SF5CzaxEVNjx+W+Jm2P6pGJCoxao7UPYjDvSJDPR43O5Q0cuOHNFifGKWj2x+w9
         HJ6xr0wUToUIVJhSoQZH2wVvS8v5TIEfvkwb44uthDvATmMDcF4UlbFooZyz5s7WY9D3
         rM+pWM1v06Z6LuDTIvQ2edxoWrmLI3Fq/r0WyLRbf+XxUb56kp+ZUz/eD5TRb6yt0wp6
         iWoG4zFxQJfF44TmwD3pTPFqQvNham4/dLuqysK2wLoH5kwhUB0Iuk/2UTgh4lL8B31E
         HfXYdSyTRtctAOCf7qacYURTx9dd0WFuoP+yx0fL42K4BVoE089WNqM5uhnvfxVUDX3p
         3Mkw==
X-Forwarded-Encrypted: i=1; AJvYcCWLjdvGSalOddxqw8lkFKCaQWnVvnH2Nt2aH9OPksAmw5cWT7ns9f4BP6GIY8ujqlW6+/67CnUyH0mK62Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXisMbaeIlq9+3jOFA66jEzdp/S+xl+MmPW9tz47viwm8+ePmt
	HeUb4RlblGAYzBUHHykvO/jY1G1VfUJuhnIKxamKILGQgS/DBb6DQUFtg5cISQTir5Y=
X-Gm-Gg: ASbGncsrVnvQ74D9Xg7vajH4LoVv8xigplFNytyfmW1LhM5a/24GUZBdDkYUSfjhr7H
	RLnrr21tzOqlWutoybl9hUyt6c6wofP6o7jV5XKA9EYOJEfEi7Y0gAkqhxDZvmpasyz0TEqWp89
	IWKYdMWGnmOLXzs9DEN9+BLOzBomyhUzTbx3hydZOFGQl0qYdEBUWLsOVMm+LvgMGVXRkcHyM/2
	0VWBb2SHd/QhZwpYBjNtOECqoah0P+1hXYy26tDnIQFCKFuor1jpORblGunZZP+crL8QssBMDaB
	c8Nj/BpD0FhdEGOvahDZObK8Ut0T0DeB51Fq7SWMSpk/6/r2hPi9UVZqjd2+p7xVSvBqiVVckJi
	mQaVgQggdhyPLxPiiMIglYicJwLzD2ccx5aR61BVFwryFaNNd1vxwbA==
X-Google-Smtp-Source: AGHT+IF1kryN6ovbJfIQc/Fy4MJIAskuq3zQgUsbduVZ1K8QdtBLyuZQWhuT43c/0DSCHjf+2b58hA==
X-Received: by 2002:a17:907:3daa:b0:b45:60ad:daf9 with SMTP id a640c23a62f3a-b50a9a6cb4fmr894498966b.3.1760013923400;
        Thu, 09 Oct 2025 05:45:23 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865f7420asm1880196166b.43.2025.10.09.05.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:45:23 -0700 (PDT)
Message-ID: <8e95e30e0ca9a85ee40f93e01c23edbfb4e1b3ff.camel@linaro.org>
Subject: Re: [PATCH] dt-bindings: soc: samsung: exynos-sysreg: add
 power-domains
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar
	 <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 09 Oct 2025 13:45:21 +0100
In-Reply-To: <13426fe2-d4cc-4d87-bc4a-4a6dca955456@kernel.org>
References: 
	<20251008-power-domains-dt-bindings-soc-samsung-exynos-sysreg-v1-1-ab41c517dec6@linaro.org>
	 <13426fe2-d4cc-4d87-bc4a-4a6dca955456@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-09 at 08:42 +0900, Krzysztof Kozlowski wrote:
> On 08/10/2025 23:17, Andr=C3=A9 Draszik wrote:
> > Sysreg can be part of a power domain, so we need to allow the relevant
> > property 'power-domains'.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > =C2=A0.../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
>=20
> It is not part of power domain for any existing SoCs, at least nothing
> indicates that so this should be restricted as in example-schema to GS
> sysregs only.

Thanks Krzysztof, will do.

Cheers,
Andre'

