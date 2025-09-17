Return-Path: <linux-kernel+bounces-820806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A754B7F42A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34DB57B67A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD362FFF9A;
	Wed, 17 Sep 2025 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rW2uJWgm"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591B2FBDE6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115676; cv=none; b=ZFBR4VBY+Bfgv+3lX0JiGPFZMKe5Di2tQzroIfiLuYYJmFbSJcNj0ImvUYomIoBskdVQ17H3Dakz0D/ZeymPJ8YkFuiyBWPF80r+g0pAlwTeU2U+Xzfk8W59lF2/hBjf6N3ERiu+9cBRZ9oDfLaOLfl1OeKJ+vTzAIKSmGZLHtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115676; c=relaxed/simple;
	bh=M62rwCb3WpopXPBEr/TcsBpZz+0Rl4/4oOOAHyk9RDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=drOlU6HSNMdMRljYctm5/BMlkRqx2DfloXaTRgTbWuNgIRWNMd7MspuvjzA+mx1/ymlsZ0b1Ns7OLK9dL9uqZe+t38Ko0X/qN4XyrARKKGLTN2d6RyUXDvQRvGlS5fdzNONuhT0fkWCSsRLUyCHMHL5QYjEVs1seSEXUvk4K4NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rW2uJWgm; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-88c347db574so203075139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758115673; x=1758720473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7GZOzuObGtag5EoNFyxDUa3UQRVufAOUXVJL/ng3BY=;
        b=rW2uJWgm9RkT7sU7lJ6WTwko6WKw1X0irnKRN7chSnATbsi2S1SQQ2Lq/Y0pJ4EkP+
         MWwUaIe6JYCqrT4qZsrweJPfQbEzJqGBGFinwY23VhEUDFJNfWXn/gVmqVEcTyZ4dN6Q
         aLDvg7B2uZENuEt0oZ5S+OSQ7+hqcg6MmuOXh58sVWyNVIhfGrJJ0J+vICVp4dqw72kk
         urZWwoCWL58g+qidpl4CNb873QGKs1TsOTfjNiH0yI73QWDfqk0tBqsAgRag/jGocquH
         +rjEu/Gs8hrkoz19o6mgE5ajOYCLitLhXdmj6VxU22NgkEeC9m5mubtL6DAZz474okRY
         tKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115673; x=1758720473;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7GZOzuObGtag5EoNFyxDUa3UQRVufAOUXVJL/ng3BY=;
        b=vhLBtWHvact37NNluyvRCwLDnVsiRO9mR2wkrnDOA4uU03l0gLDjIdiZt/dFkIy0CW
         TleeCiXOgtmxI5mYT/pBFUJm9WitHHzFxUntYXgFPv2aF0lQH3yhqU6dRo3s/IF+MdRF
         KiBAwgefplAzcny5A1CGEy24SxKYeyut0q+iuLkoCxRqj/AU6W9DWzSjKeo6VV47bvhl
         K44E+sX85nyvbx3VP9EjnDGBcksB3y3VsAtYtlRvjVK8COJT2743l+r0czXBHUN02fFC
         bnWTT4OX40qVCsjlFWebNYZ3tZGfLSlNjkLJVcBC8/u9fi7wFnOnDXMbxqo9oYpo+/Uc
         ZPtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIYaIof21ON8yAudntDaU2UvlfqTf+ExBz2+DOWtTBRiN4gQQ8e3VqIkQW4N0weYyYkNKEjQmiHKG/6O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUoQ7oySqav2oeRFsPKd4M3oQjkCBxBJQQrIR1ErkkKLmvIMy
	RsWHaXWvMBYTJDzhfOeqotCtUGAGJgqxj/qzxYhW7xU1Pkgzqk8QinjmG9+lEIalFziXB0nwxu9
	flPp5
X-Gm-Gg: ASbGncsXU9p3o8Z2R7uN8ghULn0cvrzEuF95WnVqHB6gMTZVxO7jSXi99UAunU/x4bN
	1tW3PuNjLN6tNU+S3CRtuQi+iJHqP7ObKBhno6Ui8j1TFMu+ZUg+1w7YC/Jfz/InNhsFm6Db5/Z
	FRv0+hoYIOXS5WAe9OHMdR2zu0UzC8JRrCIEQ64xeiajKChPYHeTakt26uWSx1K0EFtLeqH+ODO
	VUZoo/i5oFTTemBJeAyaARo+y4OLhIlQyTii/88YhfVADeSpKNxB7O3QoEZFOrwYtbaMRcW0B4M
	2r0Sr7LoRR6S3M2Unr88L94CiDQxU5naocsY0azlSGlIclvRX1u/4AkqxacO5XUoybVE8sC73by
	tfAxfYyShd8qzpEWxPqDSTpxU
X-Google-Smtp-Source: AGHT+IFn/OaWveSG0AWC87YfzNDHOK3c2Lkvjfj2pXX0BCsm8FFh9R1/lMuhrdFs8NTkuH8A65JvwA==
X-Received: by 2002:a05:6e02:1a6f:b0:410:cae9:a083 with SMTP id e9e14a558f8ab-4241a4b998dmr29796965ab.3.1758115673240;
        Wed, 17 Sep 2025 06:27:53 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f3062bc3sm7216527173.47.2025.09.17.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:27:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: yi.zhang@redhat.com, tj@kernel.org, josef@toxicpanda.com, 
 hanguangjiang@lixiang.com, liangjie@lixiang.com, yukuai3@huawei.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250917075539.62003-1-yukuai1@huaweicloud.com>
References: <20250917075539.62003-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] blk-throttle: fix throtl_data leak during disk
 release
Message-Id: <175811567232.367585.6804225420415541020.b4-ty@kernel.dk>
Date: Wed, 17 Sep 2025 07:27:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 17 Sep 2025 15:55:39 +0800, Yu Kuai wrote:
> Tightening the throttle activation check in blk_throtl_activated() to
> require both q->td presence and policy bit set introduced a memory leak
> during disk release:
> 
> blkg_destroy_all() clears the policy bit first during queue deactivation,
> causing subsequent blk_throtl_exit() to skip throtl_data cleanup when
> blk_throtl_activated() fails policy check.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: fix throtl_data leak during disk release
      (no commit info)

Best regards,
-- 
Jens Axboe




