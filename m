Return-Path: <linux-kernel+bounces-806049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD83B49150
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3A43B0E01
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD1530C633;
	Mon,  8 Sep 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qhWQECUK"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A436F2F0C51
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341514; cv=none; b=uKDgCvk3AlDVc/eikYN7u0QUVBtp/CwY4qh6D3fToNndErLROVLEz4rRDL82qyVeYV5lxxaIC/inz73JggGYiv53qwxalCc3Fnx6V7AInaFYi4uQyCZSXFWlqbVrGgiSvHn3ebatB0UMyvB+nFq1yYelgBSiTHGdiIOdsCz4uEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341514; c=relaxed/simple;
	bh=49N6VXEcb6CRiDTym7YEaVcGgy2IFaVW/XCBE/FWkb8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KDiSyaB6qqODCKJe6YTsLU4+/Y6RbBUWroJYYGA4w0tpN4RWrua6i3dwGlu1BGTR/e0NuIR/XL/3VrZBXZ0DJ9dbg8EfwxYrv4PHqf1gn0VmewNwRfl8f8sRE4VTKnyB3COFS0LwihfCyrimasCIttggWMChEHpapJEtMHOkz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qhWQECUK; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-329b760080fso4247303a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757341511; x=1757946311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZzRU1g4sXXFvuEmKPSKN3MMa+/bBXJsTRHKt64W0Ro=;
        b=qhWQECUKJt5vaqeL8HkSLyl0BYwYSaP2U86J4QyTadwxnWT6rHG5WpipTiZs5VzZY1
         beWIZQyIByOKH5puHFkHnR8zG/Q0pqak1D4JqDqlAIJGBM9n7RfSagTFQiYmX8rvLWIm
         xj+kPKSnVwCdt61oIRf2GUuROFfuBL+FfT3g+p0hFCXyEWLhD9Ln6hUJwGZNeG1laTN9
         KM52W4ajhARdULivAWGIR7vcvfjFiYcEf6D2SIVN3HFiB8J6XxMBdRNlwMYD75YUbmSR
         UIKbHi7WivdX5DKssr/4RtAiYji4HkiEizd4AgSlfSJTYV+5VQ4V1Doelumf6qBYwkXg
         j6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757341511; x=1757946311;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZzRU1g4sXXFvuEmKPSKN3MMa+/bBXJsTRHKt64W0Ro=;
        b=ubs9dZCvZjQAceQX3B4+huU0+jp4PCYaHUqHZC6ylgGsnJRa40IMxNjxd2Yk561LtF
         gtxL1iUH+ZiYIaMC4lzrMXkS0uqyeO3OdCM1grdbHEs4udwPkPnN0iq9tQAOnBry2p38
         bu39QwsB7d04ycw6ExRWwDt5z1W+D2LFRMf33xBkAb+UVUzKC5s/kUSydTSg6XVyVNnj
         RuP7+LhxqeXmo30zaf2el85UZCOKyKoeD5QZcdW7J8lC4yawRPcpEMbnc/FlYFvqfXz2
         uVITtEp1iaheBVBKjvZXiYx3SNphlvVO2ZJG9dMG1beFx1HUvle3u5s+sInKkQGDfbds
         uIMg==
X-Forwarded-Encrypted: i=1; AJvYcCWmcZoV2la7aG934ZDpJDK8JmPxV211d/xdiTW5lQkMU0OZjOA0bcZUkqB1xQNXIcIaKfOcZ5O1OyvkB1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTpGJBmdFIHJzB0DBnXUNyEEkCRdLmTUc5EyT4QQ/twLcrWWdy
	uEs8+ucxKy0Ni242Xt3sT4ss/UuKrpc/TZ2wZIRVh3V66KBiMY+DcFrKYpLOOowGk4ywuPPVBFa
	JNi4p
X-Gm-Gg: ASbGnct0arK5+vT00MRnTMF5uC5R4pZzMvFdK5ffarALwMM6fl/RE9/9aJ1ujUK1Fie
	17JJLU2LT+7ldrLJMvjJ3zZCqZRPgFgLQkOgRPBvVGgPtCvp2CZ5zzd7v/RWZZgdEJimRw2g47A
	Tt3uUr5lT3PoWIBRTrj7IqEf4yCzpdgScMZ4GePhskXGcyB+VxrkZdeHub1zLo4FgK6LVyla7Jo
	A+KY8fsyCWxIi+J3FP2ImzHhBtjLj+Q/jVon5C7LiS225Fk0f0dZr7BLXXXxpXMDen9hzSFfWCQ
	kcicQUF6zfq7lGpUx6nBCXG99i+7PoB8Lp9PFjCU6Iv/Q61WBEJxaoCYSaicGDht+gjN0J5qixM
	KdtTSaPSsqEvuYI+6CVXk8ZHysw==
X-Google-Smtp-Source: AGHT+IFlvk59BmFds07mYxDRPlCj7VecIAUwHvCl2d557Lh/Uv9Qv9QzR0mU35OFLy1w/BAmdDh4Yw==
X-Received: by 2002:a17:90b:2683:b0:327:fd85:6cd2 with SMTP id 98e67ed59e1d1-32d43f6112cmr11950251a91.24.1757341511572;
        Mon, 08 Sep 2025 07:25:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b92a671afsm5157308a91.5.2025.09.08.07.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 07:25:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: yukuai1@huaweicloud.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Han Guangjiang <gj.han@foxmail.com>
Cc: hanguangjiang@lixiang.com, fanggeng@lixiang.com, yangchen11@lixiang.com, 
 liangjie@lixiang.com
In-Reply-To: <tencent_E009F9D3A4C7F814018C1DFA80304944BA0A@qq.com>
References: <tencent_E009F9D3A4C7F814018C1DFA80304944BA0A@qq.com>
Subject: Re: [PATCH v3] blk-throttle: fix access race during throttle
 policy activation
Message-Id: <175734151062.534076.10128778772498989432.b4-ty@kernel.dk>
Date: Mon, 08 Sep 2025 08:25:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 05 Sep 2025 18:24:11 +0800, Han Guangjiang wrote:
> On repeated cold boots we occasionally hit a NULL pointer crash in
> blk_should_throtl() when throttling is consulted before the throttle
> policy is fully enabled for the queue. Checking only q->td != NULL is
> insufficient during early initialization, so blkg_to_pd() for the
> throttle policy can still return NULL and blkg_to_tg() becomes NULL,
> which later gets dereferenced.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: fix access race during throttle policy activation
      commit: bd9fd5be6bc0836820500f68fff144609fbd85a9

Best regards,
-- 
Jens Axboe




