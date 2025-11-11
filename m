Return-Path: <linux-kernel+bounces-895755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2A6C4ED0F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C792D18930FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6F136657B;
	Tue, 11 Nov 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QazHqZyj"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD5306B33
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875582; cv=none; b=ZtALOcshz/SFMdBygOUZygxzWC/SRNYM8w83F+jU3WxWk0FRW/aQ7qoOR0InZZPHUKqMODQU8cWbyKTyQMQpXXumSUfn5PTpy+wsIA0Tl7zmQ1UAQlWPxeaSKfj9t3MRSwDbFuhwfTQO3TFec88010ge/K7rr4MYi3cjXqeRwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875582; c=relaxed/simple;
	bh=cEH5jKud37Ut4uAau2wbec6Mi8UBb61QRGB2ASEBwck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WHI67C7PQ6Fh/jIxbTChnbR2g+2AzPU0p2sL4qObbCkeOrhkx18beL1cUkOP8qMOPPdG+sx2r0e+aP2yEAlblGvFxOOv88yp4u++2s/vEO1PUfeZ7CxefIddKF4Z6Ren7Yj48+3ALJhX1YBsl1TP2TN0KKErtroUHRVQAwZygbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QazHqZyj; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-94880628ffaso24396039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762875579; x=1763480379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLrTWxuYaH3EU6gA0gU55ZOBwqFiNvTbPI5shGJZ/Vs=;
        b=QazHqZyjAF/FRldg2XwA9cPDDRd7U4GG0KLoW42e7GqigksMrQW7S+sl18mOyncTks
         fx2/Zasa9h6aeQATfyY2LksKa4R/H9r9BLyQPM9y1ImT/M8gYMmW9lmen9cR+Bg9e0/H
         YFhOnXA48bDqLRdNznnwOuWLn/UMe+Z2pCjgyXJBchUCJQWEQ4pKKlKISGLkUPofhgSQ
         EyzIlI+0hNoZzXZ8m3RveKGrMpl5Jlj3hO+GLvt2xJiDLOVxg2JtdrksH4tKTqbqlCXs
         X3xmYSSf3fGDG1Ic9qUwkTkCMRmFgcFdrFo4Ua38JNBvxBqOdxDLXwBE4jnFFy24hU8g
         5h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762875579; x=1763480379;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CLrTWxuYaH3EU6gA0gU55ZOBwqFiNvTbPI5shGJZ/Vs=;
        b=CSs/Rd+w7A9MevKahG8rzoUFOg6TaUvyTsY4thzup8Er1zoGOXyRd0L30M00MPVpA/
         4TL+bD0JtNC/lrVQPTqKXsYOnPHyD9GRrKRe6winU/MdzndzguDgB8tsBwr9vIfnwOh8
         oxHizZLTAovDqNF5OJ9+pjz9qipZEUdCnqLNXyaGdp7hx4lRTGl/CQJaMiGxOTOmNlre
         gbZ7HVlGHtC2tVjHw2RZ1Nn4foDYZKKkQGhuR4uC2x7DcDj8abvip28JTRklEQEsVLcI
         SIm36uhuUoog+wwt58oErQTyyJT5EzSh7CAIU37jwXt3df5umRUWnXDiLOHd2mI0umZg
         jibg==
X-Forwarded-Encrypted: i=1; AJvYcCX1dRaKyvNrezomCKJK2mAkg90Yan7a3Rk0v2I5QlyYN8y48DBGmkDn+4XjUxJxzlxuG0VVeznL/2mvCYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe+LBSgSS8fymj6t4gzECC9/BH8KHYrMUONRt+PoswYDXEK8Ht
	knSFdWY9LJ4IwbkmQe6dTrMB1al2tZ7+D42LDfbJbK4k7K0+5mA/tFLE7ZBEARlYJNN1p6E2jJx
	ZFhnJ
X-Gm-Gg: ASbGncsyDgb7UGWltCjHq89UlxI8m2/xRH9GzQLFQ69o3X6SyDFwDWw/scHAlQ+r2I1
	EndxwjChwW2et5urFkuCytSFAaAsL92GUiqRh03x7uZBjy93nbcOmbCyfm0wy2uzhZfdrby/nfI
	nldVmEFVa3qjwuDNHvDOnIWN4N3CJjg8FnUXZ4wv8nq1TmJfP1IRo9cSRllMedCUh0RVOUDrpAe
	1ULb6p325LSU6TFbUAx136nUNmsY6I2/v/wQLCwZ5YbRK1pqp7HX58G6kDGPfbt2jduP98sJY5t
	6Hyb3I6IHeAKqbkNWC6k3K2JkczYCpSi5IV4tNjOHM52hNob6A1qXH42C7+ygWcW1XJ/hZKpOaI
	u7Iq6fAboK8ZNsv9s6yWYlN41a3muVTLYsx6jS3GQEHeQN1T+cxIQY7j3Cxpx8KTiAxBmPofQCE
	WieEg=
X-Google-Smtp-Source: AGHT+IHFsM5Zl0GGE51bbx2dgFFwizRiJUsR67FF2A6HSsCKq/X0xIJ2XJp1FbG+RSFGG3MnBlWa5Q==
X-Received: by 2002:a05:6e02:ecd:b0:433:3060:f5b with SMTP id e9e14a558f8ab-4338beed058mr38487015ab.12.1762875579296;
        Tue, 11 Nov 2025 07:39:39 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43473301539sm113695ab.2.2025.11.11.07.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:39:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251111115810.2320857-1-kriish.sharma2006@gmail.com>
References: <20251111115810.2320857-1-kriish.sharma2006@gmail.com>
Subject: Re: [PATCH] blk-mq-dma: fix kernel-doc function name for integrity
 DMA iterator
Message-Id: <176287557764.181573.7380138449406423011.b4-ty@kernel.dk>
Date: Tue, 11 Nov 2025 08:39:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 11 Nov 2025 11:58:10 +0000, Kriish Sharma wrote:
> Documentation build reported:
> 
>   Warning: block/blk-mq-dma.c:373 expecting prototype for blk_rq_integrity_dma_map_iter_start(). Prototype was for blk_rq_integrity_dma_map_iter_next() instead
> 
> The kernel-doc comment above `blk_rq_integrity_dma_map_iter_next()` used
> the wrong function name (`blk_rq_integrity_dma_map_iter_start`) in its
> header. This patch corrects the function name in the kernel-doc block to
> match the actual implementation, ensuring clean documentation builds.
> 
> [...]

Applied, thanks!

[1/1] blk-mq-dma: fix kernel-doc function name for integrity DMA iterator
      commit: 6d7e3870af11c2b5966b2769f9e8a0d4764f52cc

Best regards,
-- 
Jens Axboe




