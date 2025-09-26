Return-Path: <linux-kernel+bounces-834545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA6BA4E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AC474E18EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A4630CDB2;
	Fri, 26 Sep 2025 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnXmrsn6"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756D30CB2A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758911857; cv=none; b=foJvWoYexJ5Hm95D+YdB7/aMlpsOsDO4j8HvbFkdBerPMK7eCCophZlvtLQ6fqNvL85VIl4adSLrxZT9cwpX0mfhOVRZp3TzIoHYYr6OcnOObh2skPKhA52JyT9Jc3hjjcan0RRZQqvfgUYANc0heJdRCa2XwIME3dItYzq5caQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758911857; c=relaxed/simple;
	bh=JF64E9LziDMomCBPJZwiXLhLGMAjQD1sjgEoH+6r38E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mmh9V6ZEEJ3i6ifcpBlEsX3eAAobILHcrIGGM7VxS4XP3OeMW4kphbHGrnpXTIELWWdBHm4IcpN+VU7e4QqHVHzpk9GHhtf/t6qfIGtbflV8GqdSD7NSHXdgoOKrKRPLzlsBUbTzLOeU1WyCSvq+06Q5D/H9V9QURIrv/1/HnDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnXmrsn6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ece1102998so1786109f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758911854; x=1759516654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4tLH4zZsU/KCMVQpK5rDpwcnO5VG4igW8/S8Fp/Tqk=;
        b=mnXmrsn6NIrGzTc9Fq5YQVZ98jBpmr+MKZvjQiHsFAxdLMnqVP+WQ49yJc2rVDidBD
         EgHkHqGz5+TGORNvHu6QxNrLfWiNCU9xlzVZZMfEazGc10BOCZPLfIFwfLUdBPrT/GOu
         T41Il4Q4Xv2N8uxTYRkv/aT3EnBp8A8I9jgW4mBUMVHu7PKoG7zUmmC6OuIFyd666F+I
         sCym6Eu1k+Hvg5CE4MPFnQVjGrZX3pmN8Icn267UIizwXzCVmgjTkMuEj/S9PGh7t+6j
         EsWwAQgF9ThupbiecQRync3JhoQvHNzHlTZiE18yV5jj1efe3j/TfcAzVVwCk9lNT8E0
         u+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758911854; x=1759516654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4tLH4zZsU/KCMVQpK5rDpwcnO5VG4igW8/S8Fp/Tqk=;
        b=X96N3/TyD8W9CrhmjylaerjHVFKIP8KMuySUABsJRtACcHG2MKHndfajVrzRreOGTy
         oJev7qNn7XTA+ZY6iqMCI6TXI1vs1qBPGEKvVmKou//S4tFumFtWtRyfYNSqvlLF1U6g
         HL1MG5Wu1FhvYux5Gi090FGMO7/kLjhBkLJxwhPTqY/J8AH10uhQiI1uf3zwsOgAPoea
         dYvebhTEe1253jzRCsWsgBjzlIclJfq7EMXIVqt0nPINiCVCc9hhC967ifzha6/e81N4
         s+rvrYvJYo/lyk2Nh1TAkgp1xjmRjOq+yzJcuCm8QaqF5KUbU1jOJQkWl/Ynihl1gnRf
         bT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVglYUGq7shbaqUlr7i8CioFoFLxoN2/hoE7fmbZkstLZHECWCq1ZVZuDp3PzFJobN4T+Kmm8EdLRFt23I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+EnxInbnpB4n/j3OBavx3qh6h3Lkxii3mRxLQLjrzGrlIJ1jj
	VG6pCVgjeU/oFUiZMN9NMsKnzFTZVqCRcOhpCVCbYhDxwk+3WnAyF2IG
X-Gm-Gg: ASbGncvhWMkundogALMu9trEqpN6dEGhbDxQOA3Bk8AL5aHxUsGlfsuQfJ+pMsVZtHJ
	W6MiAWd+YVmVChC6IX8xLL+oeITllarO5Uf35fonkb3z/g7Z+bZ0WNR1yIC6Os1w6TB+Wgddm3Q
	/i1Wky49kqCXamHRLs7ArNRzh2RRMJZR+h3m0MjhakSddDGvRvER7rGLaBcaVhixz1iM+ifheEg
	3E7sOIUclw5oAwUQUaeoebE0GFntNG/hdcrID+XKfrBTQYKzfEW42wE8wx+jx3ZObt/fi0n6+w/
	VJFk8WN1iyLfUss2Mixh0OYFZQq3raPgvNxht4DdM9Y9jq9snqNAK+RlwnJrsNvvGO8yCeA2mwh
	37x8nBf29quZCk+jJNIibU40X63wo94a0T0GAos3aRjdauhmvOs64EQzuOLUuspPvak4YNjy3Ij
	ImD54t5u0=
X-Google-Smtp-Source: AGHT+IGL3QvqfsVcdYoP6UEPTEo7LkSql6GFvlUpYyPH7Az5c/OcA09RHs++MokV2IPq/7GahQRVUA==
X-Received: by 2002:a5d:5d07:0:b0:3d0:3eae:576d with SMTP id ffacd0b85a97d-40e437370afmr7995364f8f.22.1758911853783;
        Fri, 26 Sep 2025 11:37:33 -0700 (PDT)
Received: from radijator.localnet (93-140-141-58.adsl.net.t-com.hr. [93.140.141.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc8aa0078sm7876881f8f.59.2025.09.26.11.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 11:37:32 -0700 (PDT)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <dujemihanovic32@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject:
 Re: [PATCH next] clk: mmp: pxa1908: Fix IS_ERR() vs NULL check in probe()
Date: Fri, 26 Sep 2025 20:37:30 +0200
Message-ID: <12766491.O9o76ZdvQC@radijator>
In-Reply-To: <aNYQiRJDmOO0mEWs@stanley.mountain>
References: <aNYQiRJDmOO0mEWs@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 26 September 2025 06:03:21 Central European Summer Time Dan Carp=
enter wrote:
> The devm_auxiliary_device_create() function returns NULL on error, it
> never returns error pointers.  Change the IS_ERR() check to a NULL check.
>=20
> Fixes: a787ab591c38 ("clk: mmp: pxa1908: Instantiate power driver through=
 auxiliary bus")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Acked-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>

Regards,
=2D-
Duje



