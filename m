Return-Path: <linux-kernel+bounces-774365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ACAB2B161
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FA32A7AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556AA274649;
	Mon, 18 Aug 2025 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ECWbyR/8"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C42A3451C5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544256; cv=none; b=AP220CkfRRkTRzdjtc9m5MTnckQDkboXrQbMLpglIJVUasXrKKA7SPJ6lXQN3NefNQGrgfuesxzxf5q3XrP0GR403ZGGxtpAsBKz+euMc5uas2iMkoJW4HHg0IaN+ei9DdD03WamHzgPAr8W/2dV4L8YdUU7Q3BYkCY5QFoqj1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544256; c=relaxed/simple;
	bh=hH9A4ga/R+X23C4gJ+oGriVYHNeRobhPQRPx1lX/z8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TxwkLkW7w2S1fgt2hvRoVZCVqWJzYOQt+vaxoS9uc6DuBcOkUbW30kk75XpbyjDj2AqNee5JrpRwGyRS57oRJFWuxvbtJZRxfKHe+Um0VmdlUH9eBcqpoFpE6SNdk3XJVd9YCLM9V+hMvUTIbwsi0YTprOpuz77qBNBTUtjK5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ECWbyR/8; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e66937e452so7278765ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755544253; x=1756149053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98s4oxjoCh9JFMdNor4pD8PSiVTI+34Wp/PkZUG9epY=;
        b=ECWbyR/8GEFEjhhelsoRYVb9Qh6gM3j+rROQFNH0RcT9Wg4WB7s/zzguZGi6NVWG4R
         XrGxNFesBBdigVyNHgzmVm6+KunnElc7mCgUwWqbKHXm4YVmD5rCIxswgPzvaGXku55o
         tKIAnHrHBF3ppTWBMMuXtijXFRpQk/tlH0AtHP1XgtoAJ95e8xS4ceYnOTuPBNvmxa3g
         dYpRVCFN8irnPh550e5zRzDcj5WFYqZOfMA8O2+4rMv12SuTthmpAvGBwyOVfx7gZk1+
         VCPneoUZlgNgyPF5x6rS4VZzUjtK9UMRJm0C+dGpeu4IGh8fXA7GTRjSSf+L4g5KMINe
         K5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755544253; x=1756149053;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98s4oxjoCh9JFMdNor4pD8PSiVTI+34Wp/PkZUG9epY=;
        b=astf6OBG2yz6ENYoQ7wcaUDuvRHlZbT5L+83aEZiRHsgcn1nCwvAB13QEAcsmfd+fd
         kgucgr45o94obQutgyodRPSd37K6WVuMThDg5JjLDRQ0ZKAkbgWegh7ZuRC/3KW6/Yat
         7U05/I86kjongEAii7E0e4XkcwxGlQ+7PXpj0ZIQffvGe3wuQQfh+DOSovC3P57Z8ZTq
         2oYIz4WDY8d/M6vCNv+m85PN8KE864G6AZaTSWCfa656P40uEgRpIdwPqB17vbHh6GHp
         56YJxc05JsvQW5O1UflSvbyFYn3V0rs6bXt3S3HGCpb246J6zO4vbR+rM+ZMI37eYKK4
         lCyA==
X-Forwarded-Encrypted: i=1; AJvYcCVFkhXsPKicBn2nTe8jdn+QKJ9in5aTN1H6dXSfSEvDx8zkgPKav6ifXgYG0U+L/+heF5myj45Qhh/tPDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOhLVKUdmDWqx8N6K9OTc+uIvuurEX6JS2GYzYoXNUO04Odh+Y
	biSjpfh3K8Cn9XzXjl5gBzWsNW+K1NJOCCnTeNelSrGAl1/VBgW1LvjLDqp9F2QGoJg=
X-Gm-Gg: ASbGncvQLc212cSNGbmiIZqNgQbRvy7RGlTFoQ0WKTAXNcB7faD4XcMftqoeg+PycUZ
	iqfvTrgfPMbwAuMpj3UtU/Acq9SZvZMdf8+WCl/TPYrwJKvxrhgmtcohK0dtRAqeWK3V2490eLZ
	LD4W6dvRKx4WxDzxWgaGWQJN4cCbYRCMkR+amrKS3xpvAlmg9BbQFK7S9KRgum3Mgyu73oqfOOc
	mUUFCuUi/IwGgy27+Q5SN7afNxVotPrtIjgmW61wmys1nqOAni8mjxGeOLeQvqZE4UX0czs8gjy
	90c7nunQF8HWPdvMLQU5tEXh9khWYeJklUsjDWN2cTTmtAKutck2HdOj6G4dbFRtLn/KxgA1kDM
	D1u2EmrrKBo08kMYP67g0jrrc
X-Google-Smtp-Source: AGHT+IExPQWHNXEp87a6gdTrRalijU8TTfNUlXZ8z/6M63ZuM5HFn5QSpjqem+d6JzrncNeyYbRK+Q==
X-Received: by 2002:a05:6e02:2705:b0:3e5:5937:e54d with SMTP id e9e14a558f8ab-3e57e9c8e73mr229307185ab.15.1755544253574;
        Mon, 18 Aug 2025 12:10:53 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e667540aa6sm19589805ab.32.2025.08.18.12.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 12:10:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: yukuai1@huaweicloud.com, Rajeev Mishra <rajeevm@hpe.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250818184821.115033-1-rajeevm@hpe.com>
References: <20250818184821.115033-1-rajeevm@hpe.com>
Subject: Re: fixed commit message
Message-Id: <175554425273.106072.9130682116879021274.b4-ty@kernel.dk>
Date: Mon, 18 Aug 2025 13:10:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 18 Aug 2025 18:48:19 +0000, Rajeev Mishra wrote:
> fixed the commit message
> Rajeev Mishra (2):
>   loop: Consolidate size calculation logic into lo_calculate_size()
>   loop: use vfs_getattr_nosec for accurate file size
> 
> drivers/block/loop.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] loop: Consolidate size calculation logic into lo_calculate_size()
      commit: 8aa5a3b68ad144da49a3d17f165e6561255e3529
[2/2] loop: use vfs_getattr_nosec for accurate file size
      commit: 47b71abd58461a67cae71d2f2a9d44379e4e2fcf

Best regards,
-- 
Jens Axboe




