Return-Path: <linux-kernel+bounces-842733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5835CBBD6AB
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AAB189332D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118CB405F7;
	Mon,  6 Oct 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue+RDgIg"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189BA1A58D
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742147; cv=none; b=u8GX4rejwaxYTl/E6kX9NsGquaj0vWO5Rz1KexnbPuy/gTXOkFMkzQ5tvVuSnIdCNbKxvgLaXu/OjhzZSFtCwsKGWOHWEhcnLHQsYeaZMtoNfPZy0rIbsi42Fyb2hT7l7ORDK7pFpy3ArHua5RHfMbWaheUs4j27ncdQOtlUIug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742147; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6IAaXthr2F8AXm8s5UZ/Rma1mlneqlcz9UrPzpc57v3ACzvGa5j7Ls4m14ixq69tJfEKvJzeO0wJglMf7RZp2IXxpTbvDR3NuMBokMvp8OrA+9aBiHx0yeJJl0uUKK8a0i0493cxOliOf2TN7pRVB0oGIQzqUg51nQHCn7qXPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue+RDgIg; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3a5437f2e68so503711fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 02:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759742145; x=1760346945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Ue+RDgIgsE4yQT0Ng0r3AcP+Yffu6otobCd2y+DWE6V1V8Dk7TPSPmaZ6rfJg4od0C
         h61QBFJ67gtDODun/LL9D6Lx6u1kZbT0qmb39jlhQNfxJzKbJZnERIINLCU1kZbK7GKc
         yvOvAAGbiJyAIJvbd61o5rAdBpx+AokLZDSwNdpcJVqUmqQS3Rhb1XnDoJpSGyN/fhcw
         jSnbzAzWbgM3I5pgzX1xQBg2A+Jh3MqtkM4xDTha7mPGy9PwU1/FYP2Gos5ypXchY3ec
         pazagO+We58DuVSaPo2WgAqLK78Xni6v6NN00UjD8y0haYU93KXS90CXgDAt+5E+B4KT
         bqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759742145; x=1760346945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=SX+ZsxWDKTRr/2lUUwlkyWN2Wau3GjkTf9HnGlyOYe6gHssapjsgjCGVA4f8rXdi0W
         P3nS9mtrzyd1ohFRIhLb+JMD+5jBH6sCzeAa/Nbb5rnaviUftKoGxijAcBeIVE2wj/4+
         p6/VLO9bdYxn/gcWjVLdthaFW52Nrw8tbQmJxoN1IRpVizl4zS3R8BTury9cXI8Brzmc
         Ggz5842jgL7Tua+2kPBAYcArcBtSURGKR7CNAvbmkqmufvBmeCzGxsjUF0pz70eZLW5Z
         9v8i29XRas8FUmbYkQXUrWY5eK6C2RLgqDKlmg7RtZ+jIam2e9TFYD0KzkXVUvIH3SfJ
         yg8w==
X-Gm-Message-State: AOJu0YzWS5Cjfpgufkj+Rp0XsRgMKXcIXn0Iovx5QISJCsemVXpFdUJD
	T2TqJzxfQ+OU882+d9TISQczE7ch/Mim/88cBzcHWr9jsiN1bUpu8KUM
X-Gm-Gg: ASbGncumMNhG+tHMf3JNgD9O0DJtwIANBCgFxV+UClGe6Mq3VBEFCGk9aPhFMVkFiPx
	ZGkbTGe7NJLGzD5UOM4lW/OPsf+cXSQ+jgPjkxhkGvsFoMxl5IEgCDxaW819TRfkVHcvlU3b3wT
	ffSo7dILHnYKrZwfL9V9tFi5mVMiVzAA4TwLWJ2mPsJ6mBYZV8Ur0XupMbY5c422IgRv+DtvD/m
	BgsGK38YUHzRnOWbrDgDff1eaFO7SaBEvZLxd2WA512P+ZItZKZs4SooNbto7TArq3XLGlCQlkT
	Qyq7C+AoA2HUWPCJIqurm7Rh5ZIYgoM92aZSr+BJh4JZ1vUqteAlAsI5Wu5gyk5JpmeKVJYvyqw
	Bcq8QuLa8WO2GWfwk2xSLOJzuMydEGmNrdFy4ln90gkVDXuPYiZMNur8pR5FIkyVWmyeKapARal
	AhLRM5qYU9Hnd6qduBvw==
X-Google-Smtp-Source: AGHT+IEEmK6VSSPgZ0Bpy8zQeZLVTMyn3e1f2h8O1vtHHF+mmm9DcQ+TklYOMe+OOB72ZJsFEOrdMg==
X-Received: by 2002:a05:6870:e0d0:b0:315:b97d:c9c with SMTP id 586e51a60fabf-3b105cbd673mr3041577fac.8.1759742144989;
        Mon, 06 Oct 2025 02:15:44 -0700 (PDT)
Received: from Michael-ArchMiniPC.shack.lan ([75.167.107.197])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3b0f141ea6bsm3138712fac.18.2025.10.06.02.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 02:15:44 -0700 (PDT)
From: Michael Garofalo <officialtechflashyt@gmail.com>
X-Google-Original-From: Michael Garofalo <officialTechflashYT@gmail.com>
To: adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	officialtechflashyt@gmail.com,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
Date: Mon,  6 Oct 2025 02:15:34 -0700
Message-ID: <20251006091534.2551249-1-officialTechflashYT@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <21d7f0c8-9a61-4759-b655-b12a6fad9885@intel.com>
References: <21d7f0c8-9a61-4759-b655-b12a6fad9885@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


