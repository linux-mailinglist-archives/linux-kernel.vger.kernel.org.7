Return-Path: <linux-kernel+bounces-812412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E5BB537D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328CF189E255
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B2F19D88F;
	Thu, 11 Sep 2025 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iySdujC1"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB373FFD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604770; cv=none; b=pPaNUQ5ejsgiJKX3LvhExb0BOrQ55O203+67+pI7xE2RJISBdh/q3itvuDE1mUx9ZwmyS652XtnU74ObDkuSbcWmvDCzJzrCThi1ACQ9LLzYgVZ47LSTF1L7v65RvnUqHvlIs3hqGti+1tlxxx0ZnleDWWYcqvWOEl+UULgipX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604770; c=relaxed/simple;
	bh=YkMv6YjsyCNBVi5yIMwaJK92TSsQZwK3ovRalXzSm4E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSstd3NbdZ8hEQzjTO8l1QWkKe8f4WdJNWj9pctjSBV2w4omSPoz9nd7pHQXSnk6y+vpG/KrWzhWDB4BMO5dMypVQ2+f2RUZUTqQROtL4XTWIQLedk8FUvrsQX5fRbSp+9DOd1nfUg1V3AIREHbjKbdust2tF8aNkFONtNQyzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iySdujC1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so10828845e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757604767; x=1758209567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Y/244DiSphAJbtkVDW8SEmzh2Ums4Tc++EtjExWiik=;
        b=iySdujC1QrQC4czP+CEbV8VuLXtpy7ttLEReliaXH+L1WUDFIll2p2Nq2C4MOgFt7B
         ITpv/BKt9xlrsw2BGVNtb3HpzYTTk1Ocv14dn84Ang34rCKRSVBzfeC4Wqaa56AQDV2v
         sfk7eHUaJojWt1nZogl2kE31d4fsHxWURkdgsOyOpggTf6KE7C+2jGvGd70/GWCtqAsH
         Aw7vLyevFtKOvTHAqAVNw11cg4SEZ2xusdwrb1jjk0QxEr2mtlZ1cKSmoIh6JQLfvaHT
         rOOQWKma3SgRVzw3U6zqFblQGjJb2eJHkoYlpzoUMTKG3IGyQQIVljpGM/myjg66oYAo
         xFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604767; x=1758209567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Y/244DiSphAJbtkVDW8SEmzh2Ums4Tc++EtjExWiik=;
        b=k0tqmcz4ayLSgW02e+BEWx51pQIvSVwhMxLmAwX5HlfWdvq4odtLvTVJL3kqAYXWSB
         ca68d6bi1iz0WZlrmLllCXgvDyt47B8ZiGMjpPP/TqJ/E3iBE60Vy10FXEAiSQyrQSDq
         OTti/ts5Iroi92hndqmu5xKajboWpVvUb9jOak5ax7zO8yct5q1tPPTj+reAPCitSy3i
         wg9ImvWY+0t7GNbVEWXl/+kDRZ46Du/E2PavvCdCoDibYGKzOoUm2emwlNi7h35LEt2G
         asi/ZxBIU3BMBuKn3ekv6L/kIkrbYMHvJ3dZaaXnPkSb7A00o9VKntgpAo0k2XMAn9la
         p8og==
X-Forwarded-Encrypted: i=1; AJvYcCUHZpyGpGAi7gxEApLIW9zFli23AD5WZV90WYLJ8c/JZqqQFL2xsW9vQe76sQXspePOpmlPlzeoJt8KeEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlS4AEYVFt6m1d0IkTb5oDrhp72lsir3osDxVnWnZGbtz83FPL
	sdKeuLNOfSOAK8eAxr6Nvs6vDrEKYNYLH3/KGpBIsdtUPYT1/Eb1mvCW
X-Gm-Gg: ASbGncuZbOnz0XuM3ZGV6RI3OY5Ox8+HrGHmHjlEUNKHh7pP3TM4uOYihfNV9y82Yq2
	TP1v5eHlq5zlxafXxx7hmY5Fwp6No4O5kuy65lSPaYRFTOQe+TO7Mo/p9Vj+ohMK5PrunLyUZW4
	tc5v607maFCiBMIgKes+5I7Fk+DeaCKQJHayPjG4fXTxEnfkaTNlfpcUY09kvp66CbyAKphzh1c
	1x8Jpl7bsKrHALQsEt6vDQ6ZViz9Wu/sxa5yirWhh3aCTR1naKCPmTxINQ8sS1VcxxYjPpL/NHV
	eaocJged9NI3f6PhGi3aTcoH/Y22fXMpPBDRx2hPxkZ//NIt9V8adLkHnUb2G+GUMfgfOi0z/8i
	ScaX8CytWLX07qczfi0cHUt9qImp6vCggQx9Ft/Llr7A0UJSDPxcOcY7Wd5QVW/wlnrTZTdyY+M
	mvYB9Xw/G9Y20DVkje8CwWpqLxfsGAfqR8+Us=
X-Google-Smtp-Source: AGHT+IGDFl50WTcAW8FK5GtCVqo1WVM9JouN+PbJLJQUqledX8LqT6eikYMKGBvqjaGPWeZ+ftRl4g==
X-Received: by 2002:a05:600c:17d8:b0:45e:598:90b0 with SMTP id 5b1f17b1804b1-45e05989245mr18195835e9.9.1757604766795;
        Thu, 11 Sep 2025 08:32:46 -0700 (PDT)
Received: from localhost (p200300e41f1c4d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:4d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e01baa70dsm30941195e9.15.2025.09.11.08.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 08:32:45 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kartik Rajput <kkartik@nvidia.com>
Subject: Re: [PATCH] arm64: tegra: Add I2C nodes for Tegra264
Date: Thu, 11 Sep 2025 17:32:38 +0200
Message-ID: <175760472294.2784204.12720978219175288045.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250828102803.497871-1-kkartik@nvidia.com>
References: <20250828102803.497871-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Thu, 28 Aug 2025 15:58:03 +0530, Kartik Rajput wrote:
> Add I2C nodes for Tegra264.
> 
> 

Applied, thanks!

[1/1] arm64: tegra: Add I2C nodes for Tegra264
      commit: 7afa0f58751a85bae003fd1f0a283b9fbe7611dd

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

