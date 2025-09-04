Return-Path: <linux-kernel+bounces-801037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8456B43EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A4194E5CAF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9538133A001;
	Thu,  4 Sep 2025 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QGSnNXd8"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9EC3375DE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996309; cv=none; b=trasLtSiHVmaCjr2t8q5mEvXDnQh8/Pjf/e7cgNyIDkHCOAA4u2Oh5yFKlxGC4sgSNbqmcpVOipLr3Xv2WZlZyGLSgvHJ4ooCS0lJIkMQ8FuDX4WzoVcA/78KrSpTAbBv2PhGYsSY89g408HzL3t+a6V9nn0U7NZTf0q76tRIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996309; c=relaxed/simple;
	bh=z7pU301qN5RSzlZY8CDhBRBS3U4WTNApANa5rq8fplY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sc577Ns+TWzv3KJIzl0MlKJB0PqBGTmb/XK8yWwHCLJ2Hf+FT9L4v3z98IyChF6B5ZwewkaDMpupRi42nSjENf28icp/7BNKJePjaLxLaIbHnrjVaooQit+TB55kgcXNWjVZ8S2UseJM07O65Oc7GpuOunZ6jdxfW8WlvMEftzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QGSnNXd8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b7722ea37so5769845e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756996305; x=1757601105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NdywsOyjdkDiRe/+b+HSItb4HDB4ynduYkGNWZSwr8=;
        b=QGSnNXd829I69Zg+6GEnTdSXvn38Bh3gt1x860dTtkY/lXUfk25EVXGr1t4XRsuKki
         G5mnG7//BJ92zQAdS0XqVFKS91Y1FnezfmPVpvBtAdWRza5RAJsNvTltqIL2XggKkjvu
         WoS6MSgwESIYuTg0elNFZzVXaABlpfZR3+Ym0qy5liqYqmyfJxxzEhw/SxHm3Dvnywqk
         WxUqTeL9iZrTgFjqZX6Qckb2/QTrG6ZoAccfRiaadKB4rhBhNsA4/tbbT+/DPo6d8J3M
         c7RNKRRc1sXrjL6dDhC++SSRi+8IWP7q3ilwm/AwDNP9+ipwsXol24jFbrutFnDyWwif
         bTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996305; x=1757601105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NdywsOyjdkDiRe/+b+HSItb4HDB4ynduYkGNWZSwr8=;
        b=RTJudpflfix06i0hPsuxonyVFd+NOdLzNzU3BrjbnlH0+ndjMZHrOe0BPvKLtDxzqm
         1ZP4zAxFwkLSMLnGVfvOzh0k2+H0SAc3EBm2EvV8WgionwAvW+qte7tuolMpIx3sXZuf
         MwIpyBunJaunA8uXjdg5TA92aeUb3cEtwdYs1Y8wNfn+UHa6BDGOXT+1Bmr+5vCLLjFm
         a3N62YEAyUAqXVBqh4YpI5Bm7r3iD7Hzm1mNQjmsGeV34eUyolZPJYbFwX3c45i7ci1t
         U/egVUpf1wTK2iQOtb31qVv6H1VLj0MnujWDSICzkLDUtgPCwhI4DNZEDAUZ0f1+8h/W
         vYFw==
X-Forwarded-Encrypted: i=1; AJvYcCWk6wtVgEQlihxvdWyjnSOTrab6c3IC0QtWdnhxInRcfPhtpJlWGOGaf29tltGh+mxVarnTv9EQ1YHIVOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPMmtPdPZeiCy/bjQyNur9IwqrXmIs6b6+bJf7rYkQRDlXOVlV
	fwyuT2WU41Mv1h6ex3mdoNmsteqB2ABm+7CPeRyGri9INyvb9CIqIxPswG3/yzUHqZk=
X-Gm-Gg: ASbGncsArNalcbKRVCbPytRsNj6RneqnIeqd3tf585kwDJ5GkwRKQ+5Bay2gO/ndIYQ
	vCdfSiQUzW+LCrxC7+QY6mc/4ZMiO5PH0Bke4Mfpwbn9YtxXbsRqds3J+HiPQ0hjsONmTtfioR4
	aNYcOjNfOjjXh9Kjr27NfFaH7juEO1SmY/fmFIMcPLd8fPgkDfF6D71hY6WDBfbUKd+kWEoVN/X
	2rz8YhDHNpTcz3rQRqQbIaES8s3t0AkRF9dPcExJPj4HQgrVUeqlOOjfP8asmqmDP1Mwu9pIdRt
	VBBuJAKFSeZTsZjgqTYPVsESpe48S2f4QDLxiPhlV9paBwcuHbSKRJsPX7N7Fe8Pp2EuRzl0x56
	c0T5gVmHUlxNmEMMP8DumJWE=
X-Google-Smtp-Source: AGHT+IFXvXdGc6f5H5pPzlrvLjHoiygtB9yAgkixLIkLuOxDxYYjkerLppwkC8XIDL7Kyt9fmkZJyQ==
X-Received: by 2002:a05:600c:1d24:b0:45d:cfa4:ce10 with SMTP id 5b1f17b1804b1-45dcfa4cf3dmr27357855e9.10.1756996304971;
        Thu, 04 Sep 2025 07:31:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6e82:a4aa:49e0:a7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d1319sm319642535e9.5.2025.09.04.07.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 07:31:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: brgl@bgdev.pl,
	zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	warthog618@gmail.com,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: gpio: rm include dir when make clean
Date: Thu,  4 Sep 2025 16:31:30 +0200
Message-ID: <175699628268.79535.1530693991646063200.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903063621.2424-1-zhangjiao2@cmss.chinamobile.com>
References: <20250903063621.2424-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 03 Sep 2025 14:36:20 +0800, zhangjiao2 wrote:
> rm include dir when make clean
> 
> 

Applied, thanks!

[1/1] tools: gpio: rm include dir when make clean
      https://git.kernel.org/brgl/linux/c/ed42d80f3bae89592fbb2ffaf8b6b2e720d53f6a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

