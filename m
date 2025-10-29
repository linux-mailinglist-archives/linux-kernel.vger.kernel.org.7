Return-Path: <linux-kernel+bounces-875846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BA0C19F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E551A67B19
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C3D32C93B;
	Wed, 29 Oct 2025 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMkOPDNj"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F232C320
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736445; cv=none; b=S8nnuNYo2Pvu37/lWiMIzjB98asoIX6Rox8adjLlT5WlpnG3i0nwN4L3rDLHA1tiqkhWotzr6I4SCTr5k+SQS53ujAb63WQTpdgKsAE5Phco/sAHsME4vrDnezII5lx4bhIeMJ38k93XI69WC4xWhKTS0qgbjbmYrRnwQ8wG0g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736445; c=relaxed/simple;
	bh=D/lapmvTOwB4w+eO4w4TOz+x/hybYzymaElHesTMXeg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QBePonAf9Bzydu8+VJ23AysEHPgVtK+ZEi0SZiCA9OzQDG79RFAa+8v3fONwgYQL0orEPYChZv0rlBVBktKJt9DiRvWBH0bWFiJ+CV+C43yyJndMDGS1Ru6pZjtj+7f3dzXylgS0JNDOCH3O+icFTYKxSaFu8NtrKBhJLRdsXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMkOPDNj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475dab5a5acso27083335e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761736442; x=1762341242; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D/lapmvTOwB4w+eO4w4TOz+x/hybYzymaElHesTMXeg=;
        b=HMkOPDNjTBtwNSGyUdsh90hVcMTgwt29vCrohawwxgBIRvGVcsrdQl4T7uJck6O+R3
         8GCqfr4X3NJWetrtdmX6vbozpxVLnOhbeQ+yNTjDOImQe2+vW6vGUt8hKmPhCySmYhX3
         X+eHLlbaPkZomu0wIyN3RN8EpkqrIqtWdaC3l0eOLj8rgeqW3VIosa5A603xlWzlLH4U
         mfkyajlp/tzIApDVErxeRPyn6FNSeDAUffVockuf4LJMnYIKpMaPXZo0vHb6ogroup+Y
         Oza6KTz2GE7d+a85ZfUV/jihKxsr0J5/5sogAo9vNBIEAtZh+tHcJWAK6D0rUm0Xuc2k
         WfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736442; x=1762341242;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D/lapmvTOwB4w+eO4w4TOz+x/hybYzymaElHesTMXeg=;
        b=QfrtOlTU/U2EOFIDmyvyAZy1WYTlHDX8n/fGXeCvaLRc4Fh3Krc91dwgZJQ9mhbUIV
         UpX7O0gMPQ/mtScVH26rq7g+jvW43iLbYZv7GGWb8VqjHT8yq4U++34mzrdSKxFfdtW7
         jtWz0zn1KsVUlweiABVtW+W8ubjqhgoqKgigmwENgdhe5WPDIrumt5oVMab3H9/OpX8+
         Un/J++5GaJtgmkB4+47xuLtTxYgvlI4bS+q9b46DJuJ3mDRexzrmaZm7imYjLyKrchT/
         jlDtD2HB6ipZ+UB1Gu1TwNOUsaA6zdK3rvVhzqySLaqESdFXhkljpY11Rh+5WWgkG/WC
         pnbg==
X-Forwarded-Encrypted: i=1; AJvYcCUK6jdoeohmLKiinFLfIUTND3pVeDBoaLGR+Es+ZAbqOimKRGjLEE64DFH/enTjZNZXbtNzUccfKsH4/v8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVPv7ufW61jQW9MRphBQDaAAUEt1lVo27oz8znF2LXmFs0H/fZ
	ngvSLK7NE4/yTPJTESLp01p+Zztvw7jceZ+neOmU8pCSY13mWhu7SOyI
X-Gm-Gg: ASbGncukev5NNHL1ErVBy3Rpgp8Tb6nO24XW7Co0xtnueS5H2/JdXakFLrFhV3TbGWZ
	iLhfFQaxYGMb+OOU4bUQ2qHrbfsKt2Y21isuKmRztSfKVnrp6bhAJWozNlxiTYUrgR0vImBn7ac
	nWSU+RymzPDxMIl7G+aC0SJTSPJQxks26iBy7CzksrkDdzyz++aCfIy0Wu/Bb1/ZPiC58uVIQf5
	2wQudxRxtDnI574lGW0Dy6rTllZ7YZLAfHypy7g8IX5D47muEZ5TEn2Ct3tw8L5FMjBRHGyg3qk
	EUAgX+oE/E8Gy9xniEIUUJZtA7dtKB25piPLcvuK1+w0hGOtFLM2cIuauTMc+s524+fBKrsiWqB
	82b5Cfe/B5GwlB7sX/ISzNvGeNNt9TlIJXZgXlQKsY2jlZnRCk3viEMNyMvwO158vtev0Ab/k1A
	SEu1v/EqV/W/Oo/seZfQ==
X-Google-Smtp-Source: AGHT+IG7oVJwZfUJXNbRBLD+lo+88EHLuFLdA49goSZs2zZITHJszlARkVGhqDOeg4E/63DSjHyGIw==
X-Received: by 2002:a05:600c:34c4:b0:471:d2d:ac42 with SMTP id 5b1f17b1804b1-4771e333a08mr22980435e9.14.1761736441418;
        Wed, 29 Oct 2025 04:14:01 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e18caebsm44190725e9.4.2025.10.29.04.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:14:01 -0700 (PDT)
Message-ID: <ab9c1f88026058fde8cc37057864f25889ce47d1.camel@gmail.com>
Subject: Re: [PATCH v2 2/4] ASoC: cs4271: Disable regulators in
 component_probe() error path
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni	
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, David Rhodes	
 <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela	 <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Nikita Shubin	 <nikita.shubin@maquefel.me>,
 Axel Lin <axel.lin@ingics.com>, Brian Austin	 <brian.austin@cirrus.com>
Date: Wed, 29 Oct 2025 12:14:00 +0100
In-Reply-To: <20251029093921.624088-3-herve.codina@bootlin.com>
References: <20251029093921.624088-1-herve.codina@bootlin.com>
	 <20251029093921.624088-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

On Wed, 2025-10-29 at 10:39 +0100, Herve Codina wrote:
> The commit 9a397f473657 ("ASoC: cs4271: add regulator consumer support")
> has introduced regulators in the driver.
>=20
> Regulators are enabled at the beginning of component_probe() but they
> are not disabled on errors. This can lead to unbalanced enable/disable.
>=20
> Fix the error path to disable regulators on errors.
>=20
> Fixes: 9a397f473657 ("ASoC: cs4271: add regulator consumer support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

--=20
Alexander Sverdlin.

