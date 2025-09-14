Return-Path: <linux-kernel+bounces-815481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3270B5670F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 08:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5381A20913
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 06:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF77C275106;
	Sun, 14 Sep 2025 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYQf7AAb"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499CB1F419B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757831203; cv=none; b=E3tb9mMY5/dchiPN3NP5AT+6u2d0H4A9wVLgYIjx7vch7v7h5QWUA7N5N2GPfl+2bFaUmVLEh40C/nw/7mWfb28an+IDBCoiLNMQlqm5nouYkOwzyHyjVPx85IWYUbNSbr3ZkG7onXF0uXTm7HK0aqXJrO5WEGJHkabclPEVdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757831203; c=relaxed/simple;
	bh=YpuAcY5BhVGhX+vCzPkKqiO0eWSE/MtMicMqARPCFKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKAcbEWEr/IJfBAfcYu82HiSLXH2DMJFrBUBlfrC1M3t/eKBz5bWhAXJ7naxLQzBCTAQOUWXkxOMnaq3apjBkcalUyXn0HbYPBvREoOarj+UtxCuCf6ELnY6BKoPEvV9ajbwXegaiitBxBN5xDKB80ZKL0TC3ww3C+6RHJ/x3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYQf7AAb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b07dac96d1eso220343966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 23:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757831198; x=1758435998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpuAcY5BhVGhX+vCzPkKqiO0eWSE/MtMicMqARPCFKg=;
        b=HYQf7AAb2VdLSAhRPfFCkuW+fJDww4LE9zGBUOVdhsQ+H2ZXNPygNMgKhwFEt0ImVC
         9eJ9eqQ/rfCY7D8arV3l2b+bVbGxl8mpiA8ranw9ZLY57gXJgCtuszfRgv+DbhwyJS/2
         yib3Iozuvd0a5QoovnYo0CgS4v9fW928pAZmReDZEVWPXw1WzcCeUhvBnIP9JkfsgTLm
         rrgP73e+oBTs+7WWujv+ATL6eAIfzBTCMHdIk6vGKXydV1jzj5tanw3NR1Up3nrd7C0Q
         Via2Q5H8xxsUuWkoArjNQb0uyL/ifxJIiCFcfjV/DYGgE4vxLtauhnsrh52gdiYMRoQi
         5XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757831198; x=1758435998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpuAcY5BhVGhX+vCzPkKqiO0eWSE/MtMicMqARPCFKg=;
        b=d/pcXQ/qR6fIg2nwVZPIu0Qf6dfdE0V3bzMQtxsl24yGgtUAQRqf240CCC4Sp6ZO6E
         JOd3GSlPDoJ0/Hpc9/nJnbAXMk1FVAOx2oUHrb2lmxgeDe1QgFuBSgEe6vBQ15s2ZK3f
         AGySxtl+id1Xfhf/8XqAWJRCvqHgsUKT0xD72U2iXnRQsdv3F1JJlq4QrSbbsE2t/Hzu
         ULQflBtJOQxVmZ386tnYHCHobmIrEGQtN1MjjR8dU2isagZrDaSE/obWe1KljO8ti2eA
         EhOt6JCg0Bw0C5xcxn4mSE2tmlDjwaLnlO4Pl60kARf8mx0ldoGv/6RBtKtmi74p+jaN
         Q9cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnrdLPvjfNI7+A8feI028Y70qBfJ5i47n2hnvUCgKfc5PZtW3Ag6h8K+nlmpGQz/4l71aD58alv2KaerE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKktJHRugX82t1/yqsTI3gSjVKZNW9T6ArGfHebg2Km86yp3Yk
	fb1HCwJFu20cdvc53y3YtCQcimOvDYuxQhS5BtoEeTg26f0l+yZ3s9Jh
X-Gm-Gg: ASbGnctmcWK4H2itXS3SCHyBHEucse/HHzlk54ulE91MsKBqFUrbrFBUyY6feuYHXBe
	WAF96GSeuCgECqWYwdvcQ7LblqcopaE75/mh+/cCb1w9ymo85hTTzm257XEY95DGMUlpnsEen/o
	5dGBTssV86ih0uATvQt014TX3LbH3AND5VmyPM7e6LD1/KvknOkJNBzXIgzsC6Hd2AqFR3Xl4Al
	ubmHfvf1UZIFRQDivnQAcYNBD/DPJzbl8g15wwBJ/2txEeRrXLp7urvNq77w5sEMxFF7j/5dcO8
	LwaYyPIKXqXuAkNhzb2mghKMtH1Sy5N6nVpCktqnucGXWOqQbxD8n9IYjrpPqsp3tM5WF0QQ0oR
	msw3QbexehjMZ0vKlBwve0VbHUWiP7ALDKVdQCa0FBrdhXENDaHdXf18=
X-Google-Smtp-Source: AGHT+IFgeECwBC/iiy6U4djD4RbKGuu6VUzMWKgjTe6SxUwypL1QszvVkCmMnx5qTasPZMrBF3ONRQ==
X-Received: by 2002:a17:907:7f94:b0:ae1:a69c:ea76 with SMTP id a640c23a62f3a-b07a68b646amr1170055866b.23.1757831198374;
        Sat, 13 Sep 2025 23:26:38 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da427sm699505566b.7.2025.09.13.23.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 23:26:37 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: allwinner: sun55i: Complete AXP717A sub-functions
Date: Sun, 14 Sep 2025 08:26:36 +0200
Message-ID: <2235173.irdbgypaU6@jernej-laptop>
In-Reply-To: <20250913173511.4064176-1-wens@kernel.org>
References: <20250913173511.4064176-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sobota, 13. september 2025 ob 19:35:11 Srednjeevropski poletni =C4=8Das=
 je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> When the AXP717A PMIC is missing nodes for the sub-functions, the kernel
> complains about not found nodes.
>=20
> Add all the remaining nodes corresponding to the defined functions for
> the dev boards, which have publicly available schematics to base this
> change on. The battery charger on all of them are disabled. Also add
> an "iio-hwmon" node to express some of the ADC channels as hwmon
> sensors.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



