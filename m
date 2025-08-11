Return-Path: <linux-kernel+bounces-762820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1561EB20B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADA018C5EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A886221F37;
	Mon, 11 Aug 2025 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Umtee+5S"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF422F755
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920940; cv=none; b=AqGXX1G++vz2VBsSb/pvdimyyi+QrBphZRzHjd3eQCJWuXe5MZ7OtpfOvlMX0v06EYMuZNlNzw72BNgNLxCcuz/saHAUuNb25xvD5FPYgK9u1+REcEMxnYyFxqLhE2vW72MNN62l+pGZRFPoBeOtYOZQmuk191oZN8whnKZLkak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920940; c=relaxed/simple;
	bh=06gZDC92OAdkO5dOJ43DVg0d+8bMRn3RRcDU/RZvNxo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hisVMTNH+o0YFBznvWzutLARu1zHGlxm/dRnnEU9v2oMHHphNIQ+xuV4BQIzZQBY1TqvkGR5vMmf0QJo4T1y1d1smSbwQPww1OpNGfZDvnmMXlN4QvQq7yga0W60Xx6MlE02ODNJd5ljHCW5IfKTkYbxG8FTG8aTTvHZXDp8UnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Umtee+5S; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31efefd2655so3451724a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754920938; x=1755525738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HynK3yw74tCVZlnSB+FC55ZKGpBTHS1HxgPxvGEg9ro=;
        b=Umtee+5S01w19PhAMvQR7Ah47NgQTlYqcqS5wByBsYZg4PJ7Y4nx0Pz/g+C+roXosW
         7Wj7hIj6mwalOxgiu8hrHyiOy919PgEiiIiJhzLwAEA8+D6eBJvH0yHRHk6OSKZ96KO/
         3g7m0EKJRXqg1jX1bc+zWJxeINxSTjGmXx3eotJOK8oucPob37zLtu4Pn+RLGgA8aZ8F
         HOBZLWRYlJ9w4Cyt0mMXnG9/w2z4pZvxjWYxTB6iDvqlGtmJW4ObF/9eBkFbePCVqGqL
         EVLpZdtiwy7WGRFANRrkdrdi+6xWA5DHvBjvSRleA+bI8YnHXX605yR3RbqImYir+C8W
         2ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920938; x=1755525738;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HynK3yw74tCVZlnSB+FC55ZKGpBTHS1HxgPxvGEg9ro=;
        b=PY9jbhxzKPMF5GcGDv8J+v5tjiKtv22ZJPDDgFubhnGoBDnywrOwCB4w7v5NtQM9sV
         k7hY7ZgvIULsqE4DrI3nw84wEBcl+GALn3/a8mZ/fm8HyybgbANtX4c9tO8gcbjmBYP4
         PtbM154wDLOV0q3unuivicDBHLf1e2US296lq1E2SCF/jz01BxF/BOwXlD3UKsSY+BKI
         S2+qzbZY56v3shvaIvoJvozQiyQOYI5AagLl5SLOlOUFots9n2mhfi1A8QVcg0Rd5imT
         udAzk2ktjKiMOV3hHRbih1AjXueBefrBK44wmorFMPpyVmjKv9gWkre17w7IDG5xShiU
         9BQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0cOI5aCZoJ2e2QvpR5u2Xk+Crw/vasn6ys5t1WxL5uCxplzV2uJu800rLG35mSFPUmxauMLSoNmq9WUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoyQSIXSOALRPTONuy2WsGRGu5HVGBp+pJ3yc+JTKeo9nKCp3a
	fy1gV+gamHEWvM8c73R8DywPN0DQI26Qa4+oKE80xWLD58hJTITJVaGvXJwgi22UOPk=
X-Gm-Gg: ASbGnctMkgVm16pZ8rOHCRP3fbxRls3It7ZrW6EAAqO7btV/cmAbw8WbBGNbyJyUGZs
	kkdfJFme243lTWYL0/jPx3WcPTAy+/AynlYxuRyV1vQ7vb2f4BPwAe/JjaJMPg0DzsYaJI3dygE
	Fl2M4rzRIcjw6OXfMktDT+3DMeNdyBiD3J8kdlwEkKMuJYhIPrC7RgDgexrXbDBNyC9H1k0keta
	bZobI9/s/o9oZXN+YZ5g9qEFTexNvSfDvxPEdsrzvLSZKSHnodWgzOrD4bezHmsE12BVmfIQrGy
	1w2Ybo7XH5H0cHAliJGfqO1bQ4nUGFX3WJH9HeZ2DbcrTFsE8Drk/xfgDJ+VaQhU8PwUSLTUu9x
	asbRpyA+Cedx0g6Xc41bCg+d2ig==
X-Google-Smtp-Source: AGHT+IEfmpU0b6S0i3zhLG/7wjKd1mXcWSglcpDeYqSC0LLFira1cW5+wVyEDOnNDDCeYxgaoo2j7A==
X-Received: by 2002:a17:90b:1c12:b0:31e:b772:dfcb with SMTP id 98e67ed59e1d1-32175611801mr25545062a91.10.1754920912253;
        Mon, 11 Aug 2025 07:01:52 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259a48sm14821216a91.18.2025.08.11.07.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:01:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 houtao1@huawei.com, zhengqixing@huawei.com, lilingfeng3@huawei.com, 
 nilay@linux.ibm.com
In-Reply-To: <20250808053609.3237836-1-zhengqixing@huaweicloud.com>
References: <20250808053609.3237836-1-zhengqixing@huaweicloud.com>
Subject: Re: [PATCH v2] block: fix kobject double initialization in
 add_disk
Message-Id: <175492091078.697940.9736842876552825184.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 08:01:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 08 Aug 2025 13:36:09 +0800, Zheng Qixing wrote:
> Device-mapper can call add_disk() multiple times for the same gendisk
> due to its two-phase creation process (dm create + dm load). This leads
> to kobject double initialization errors when the underlying iSCSI devices
> become temporarily unavailable and then reappear.
> 
> However, if the first add_disk() call fails and is retried, the queue_kobj
> gets initialized twice, causing:
> 
> [...]

Applied, thanks!

[1/1] block: fix kobject double initialization in add_disk
      commit: 343dc5423bfe876c12bb80c56f5e44286e442a07

Best regards,
-- 
Jens Axboe




