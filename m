Return-Path: <linux-kernel+bounces-872284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DACAC0FD12
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E367E428307
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A354B31A04F;
	Mon, 27 Oct 2025 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5dMn04R"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F85318131
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587927; cv=none; b=iy5F/G4MJusLGAnaJoF/Ee8PSF9RHrN8CvvTbsAI0xMp/nFZDyyMH6Oq6Ekde56Qzcb7gwvpTCUM+7VFm/luJkehRh8dep/lIdxTjrZdp6bsJ2HSauKReo2HyeSmjx/PDsX+chtf3Yf7vXyhnq8aSZxMsBKgP1DvQkytsnUzb04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587927; c=relaxed/simple;
	bh=lrLZa5alrgHzC1J99K289oAUToN5br+ZIZn9l5DB14I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5GEtHxvp1p1kb9JiT0bOblMP6uhrAgnTRgTuXPAUx2SYXRH7FYfAnnjmeHASpgSQeWP87muaFSg8L91d4LY2rtPN97Fd0qa+exjNkT1ffHH6MppaY8N+v76JKIja6k6FrtgvWfOvfNVuAkzeoJ0s3zGc/sPYvf5SK0isBoA188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5dMn04R; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso2879335f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761587923; x=1762192723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrLZa5alrgHzC1J99K289oAUToN5br+ZIZn9l5DB14I=;
        b=b5dMn04RsBnItqzMCrb5hnhZy7S5RbR+b34HZ83ocRWHgAEC+41JFR/XB9gGdXfhOX
         AEy5dHe3CpmqPWYAgEgp0XIQeIxawt1YD8j9ObNaAUgkN3kj46zrjZFzuGKGz3Y/LxYd
         QiL6xQ/8/epQfyOZPzu/5eFO4BhrmoRE+nOqooYLV3lLQrJBMpedGZHDyGCF49BuTo+p
         xQhOmLbKmtWl9p/JnsxUHeO+NRKpI2GZvDsho5pqpVjW6X9OvTKtgA6dpYMO9OjnSiSL
         EW/edlUyJLao0lgmcVIoziB0HYEPyN75dIvuePvJPwahmVPokHxRYM3kj1dgB00w8wCS
         iwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761587923; x=1762192723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrLZa5alrgHzC1J99K289oAUToN5br+ZIZn9l5DB14I=;
        b=gpxQ0N2diqEMh2OD510hfbyyL9nCWGbvKaD9fz3rTPSghabzdqv31a1M7ida6jq/ev
         LdV8l2IdxkKoeWWnxN9zfQZ2mcE8ce6iYGv0q9T1iQ9qDCrrpntZ8M3jF8JtUQHFqLNf
         AlF7wplYxxhYP0D7y3ABTJP52Di7FnPrRXKosVI1nTA/AL/jPONSZRTNk6i4zcAFBGaj
         l09nMf/O9kPwkkmHxoTFdJri3tEt7ZTEU7Z5W5OYvnSmZoqiSYrNw8FzqitGRQOv2SK2
         /OPCtueKD/MWcJi9rJAVrSDtYYnC46aZq/NL8CI7DTvJ4dT4UE4v6CyTaBlqMS2ayI0c
         cxRg==
X-Forwarded-Encrypted: i=1; AJvYcCXDn/WhtnNCwkD7PbzTWXmL4t1RLU4PypXdco3Lgjw48/iJicIQ49nmPGg98fubBSgT8FnRip8TZtu2pIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1oTQoOuht1vum/z9EpunQ9UbkQsbbR/EaGbt0WRuN9SiDNTi7
	30GY6cbPB3SF9aCWeTcSJ4cSMcB5nQApN1KAhxpn+jYuIseJVttdcoVN
X-Gm-Gg: ASbGncuROVp31mW7SmH89wRogQH+EF/E5RVuhjnqHk8PsUJFd0wOZwxUD1Tpclo3T55
	EDVyVnrdW7M34ASyfUFxU3eiGJpUUTUkPpzlbtrVLjPjCgLPnpHcwlBNYSI/4NF5htJ+abyYOoN
	CxkM+IQGiTQQSrtkFI9g3n059pfN/sO4rK7gaz8Lg5mVkV3CTZZwOOfnHtRfDZr75EjP+UYNR5j
	OpCL+jsyHVlevwRLRzCWpRa4wA2R+4x3QY6Pox+IHyImX9RTTDY8gbHF2N2Smd/R7MI7DtBVLlX
	J5I9jAr1yZOB6WbpA5wSbusQDJ/Al/oENvPuKEBw1QikUjKUNOPkWQmZZM3rAyIfSq83EcZC5/u
	X/zI/Gh8qmAAzmPIkjEyTOu0rtLpIPiYDrVu8Bv33/ghnMylAj+ABVJLfjSGX3isJI9EsOHKGo2
	bV2ISAUJwzwZ0lvK49aKje7NkwLlHsxrJYj5/oeuC+x46jzhM4JXm+nw2Z7za767C7PfA4
X-Google-Smtp-Source: AGHT+IEEbY/WNAlAvL+pz8s7XDkjY8oak1WE3FbbRf2JSc/Ve9J9gkYo1nnN4xz8/yWauuSoOfnmDA==
X-Received: by 2002:a05:6000:2287:b0:401:5ad1:682 with SMTP id ffacd0b85a97d-429a7e59dbemr594649f8f.14.1761587922569;
        Mon, 27 Oct 2025 10:58:42 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df3c7sm15264123f8f.40.2025.10.27.10.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:58:42 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 09/10] arm64: dts: allwinner: a523: Add SPDIF TX pin on PB and
 PI pins
Date: Mon, 27 Oct 2025 18:58:41 +0100
Message-ID: <4686611.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20251027125655.793277-10-wens@kernel.org>
References:
 <20251027125655.793277-1-wens@kernel.org>
 <20251027125655.793277-10-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 27. oktober 2025 ob 13:56:50 Srednjeevropski standardni =C4=
=8Das je Chen-Yu Tsai napisal(a):
> The SPDIF TX (called OWA OUT in the datasheet) is available on three
> pins. Of those, the PH pin is unlikely to be used since it conflicts
> with the first Ethernet controller.
>=20
> The Radxa Cubie A5E exposes SPDIF TX through the PI pin group on the
> 40-pin GPIO header.
>=20
> The Orange Pi 4A exposes SPDIF TX through both the PB and PI pin
> groups on the 40-pin GPIO header. The PB pin alternatively would be
> used for I2S0 though.
>=20
> Add pinmux settings for both options so potential users can directly
> reference either one.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



