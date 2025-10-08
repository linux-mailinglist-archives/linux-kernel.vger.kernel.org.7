Return-Path: <linux-kernel+bounces-845939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 731C9BC6886
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E3219E0950
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE5E2777FC;
	Wed,  8 Oct 2025 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="c3rWTybu"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F9442AA3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953904; cv=none; b=diW4pZfLsFBINIpjEmXUA9GM/xTtObn8rg2zzVtvneMkQWZF3DCG8QXbCB4NkhaWfQbq6QxIubNT8KO6WwRNed1Mr8H6+b4HzHxqEr2AMXEhZhaj+BXbt0gWzwsdWUGgg8nBoA3i+zBdyuiaujwQ3V34P1iQh7Mpx0V0ZmD7FFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953904; c=relaxed/simple;
	bh=gJ+kQ8Th5n7sm7JliFtNiVYTbO+kOF6/EavJhQDsQHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y2h064WkbXMGIBW/OUng3TH6w6dFoHeusL4Ux2TuFcR8YhCUVLbiiljrcjdrzqCVzsmqdUqFaB6Ed0ZTeIrB79W/FSw6GD9+WEhcD5ngiza0wSrPF7GtXAs4zy16+3ochmO/T+BagypyNgjtlscMm1CEEj+cpbURfl8C4qkidh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=c3rWTybu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3c2db014easo45620366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 13:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1759953900; x=1760558700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kxgqcyx0jP4OzWdmCcz5dhr6b/zaz3Exv0oc29FIvs=;
        b=c3rWTybuA8JzZQRVVgPh08xP+Y6vhu38n3jMNnMXSW0quajeRcWQFEN6EK8kBNQ500
         LgiCtlYIvZ6cXrnJKNBkStFlXfTHxC3yjriHuNsvaUWBTjYph7ODhPLND85TsFBbM0Bn
         dnjVEqBn1b0qMVz89ykOW6aHXmQ3ij07lbleum01z/sZgAIHaWz2TKYyWE+53hDVKzNv
         v23uBlBW9tp6AdCY65Mf6/X7XywSQdmI4MnN8SYkf+c6GOxrFQFniK0oihSY/8Mn2uiq
         78oAGoKmTE3uRzvOJhGDjw0xHBV4stjsyWUddnceDrein9EP7/QSRLWrTsZwgg0F0vFk
         qZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953900; x=1760558700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kxgqcyx0jP4OzWdmCcz5dhr6b/zaz3Exv0oc29FIvs=;
        b=GYqXxVsCgwh2GbtLiUi0LO0AVkcBRY43xO5DLMi1zQPL5MKFPFEAx0G+wNwxQ2cv9q
         Mo8CoLVwrDltzUkMDDFUhnhy0fYPuk/wtfucoRBvZUmZmngrkkeLkuyst0II/VrC8Wfz
         bWO0k5PBO4BqLBn8NyPGfloGof/aw/RlqE8aKPNdSHQxuCv1rlTXG4N6NHhNsNf2oz/p
         0G3LqkmeymcpzjykKNIk2ZIksaQEOsr8DRBqqB/KY/IxricBmpdSdRiKfdaYk076Sr4C
         uu9Vt/BSgstZsHvx0F6VmLKMCr+/z8ZN7kzDQch4Co6CCnhX1RW4h3udPQsYYjYB9dxT
         W+RA==
X-Forwarded-Encrypted: i=1; AJvYcCVRvVj33ImYH3mgUtFoIugW3SvR3/VfHpiDPlJNO0ynz1xtoVsAhVoczfjb2OWS+8dVErSipGWtwwHylhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjl2X5HVM3bnEI2qgzqDFoB7k1R5aPfe7cH3huj3jNnmKm3YFg
	zdN3cV6xnSaKlDXjmevpizTaTrEVSXaHeMTfELctlb1bh4hbWvZa4+7x1/dVKz1bMhw=
X-Gm-Gg: ASbGncvGr29oUvxA/tpjv2HDhrOQYOHsGJP7HLcm8htTsND0NeoWuAJhrX0BbBtIwcF
	55oLluGHXK2NXmJXbb/NmBTKuS3Z4gQfW/nFHMql1PJyyrvE0hPsPWRhmwJiPhLd5GzkFYaSNqS
	uSD8Oq6y7/jiGVhuqQm+qjpkCI3MD4ffmitbD5f2/0Bhmhbl4R9JVv3okpMtvu/kn5AbrsETaem
	e73Gp/L6+V1DzS0X/av00X77MsxZUY3H9nW9d7bKrimEdyOrcKJKrYRL5su8JnfdLrlcA4hfuFP
	H33V+VTr1OBOos0iKFbXrMf2WHA2Q+l/d/MnQS83rwDZZ0xggFUnqJA6WeVvJhvw3EYge+ukvD6
	LbI1X8zrPAMogtDKVohZTfpX1MX/Cwokvt4wgz9NrPbwKKV0etZQ2yc+g1SYB8AJw38YM+Qetx0
	pAeKsXx5TcBOo=
X-Google-Smtp-Source: AGHT+IEXXGVckslNWliP/tNzD5inE9P8uAQLj9Hu0Y4ERfwHRS/k5BADAG308Wsx5e+ABMKUAZeSfw==
X-Received: by 2002:a17:907:3daa:b0:b46:31be:e8f0 with SMTP id a640c23a62f3a-b50a9c5b3c8mr584397866b.3.1759953899643;
        Wed, 08 Oct 2025 13:04:59 -0700 (PDT)
Received: from somecomputer (85-127-105-34.dsl.dynamic.surfer.at. [85.127.105.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4d9f5sm1758754566b.66.2025.10.08.13.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 13:04:59 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: linux-remoteproc@vger.kernel.org
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, p.zabel@pengutronix.de,
 s-anna@ti.com, t-kristo@ti.com, afd@ti.com, linux-kernel@vger.kernel.org,
 upstream+rproc@sigma-star.at
Subject: omap_remoteproc: Deadlock due to runtime PM
Date: Wed, 08 Oct 2025 22:04:57 +0200
Message-ID: <6460478.iFIW2sfyFC@nailgun>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi!

I'm seeing a reproducible deadlock in omap_remoteproc during system
reboot or shutdown while the remote processor is running.

The deadlock occurs as follows:
rproc_cdev_release() -> rproc_shutdown() -> mutex_lock_interruptible(&rproc->lock)
-> rproc_stop() -> omap_rproc_stop() -> pm_runtime_get_sync()

pm_runtime_get_sync() triggers omap_rproc_runtime_resume(),
which attempts to take rproc->lock again, leading to a deadlock.

In other words, rproc->lock is being used within the omap_remoteproc
runtime PM ops, which can conflict with other call paths that already
hold the same lock.

It was introduced with the following change:

commit 5f31b232c67434199558fd236e7644b432636b76
Author: Suman Anna <s-anna@ti.com>
Date:   Tue Mar 24 13:00:32 2020 +0200

    remoteproc/omap: Add support for runtime auto-suspend/resume

It seems the lock is taken in the PM ops likely because rproc->state 
is accessed, but perhaps this can be relaxed or refactored to avoid
the circular dependency.

Has anyone else encountered this issue,
or is there a known fix or approach to address it?

Thanks,
//richard



