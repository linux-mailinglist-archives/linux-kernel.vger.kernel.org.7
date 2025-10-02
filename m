Return-Path: <linux-kernel+bounces-840809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E4BB5781
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E3B3A5FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E12882BE;
	Thu,  2 Oct 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MbsRzaJc"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CD126F467
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440609; cv=none; b=c6KfKyBWJT7dzvTnnVAdYR4FsTAGsZxiFCGIVxQCxBuInA2ZaS1te8zgBSSsuE0VDWXpvQJOYbQlmUyu83ycCfRS+Iyu8Ufnn/Y0igTULf/Wy90FKqr7KoETiocxPz+8CRob1fd5I2yofyrPy+47sDKlNfkp8R9Dmfj2WRYC7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440609; c=relaxed/simple;
	bh=3cXiHd2YBbbDhzLcMAyDC46g4zuUrDFj69nkTlySJ7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=esl9YuGNtiaUebb4+UWn1WNTYeBCECqk6ywJIcJz4MJqL89LOMPLhzKZ1NWqjhEIkzkboK/+rYYWb067dql6H7+zbstfcO8lVJ+MZNuNAdDsK6xCRz7d2BGyvYct0RSnuB3hF7ZeMSnknxHA/Tkf8ENOnWS88hisMpgXptEUxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MbsRzaJc; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8ca2e53c37bso138088439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759440606; x=1760045406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dT84NsQ5L7cCw3pr4Gco4EgRoaU06NgeVgWoDKDnXE=;
        b=MbsRzaJcZiCcgdFx8OMvnwmTABmZV3lxyFI+R680rnerY66hGBry94F7dxEajbw+DX
         vkGuIgaG6z5W7Ux3rHpanx1HFqig/rOrS3GzJEU+rI6hIpt4y+rT6pCDYPamFNeffcac
         QKweq7vyVsoeDehvqccXv8xDGZalj1EYY08aUeSkIGjWO3hJfm/kz/KXxjuYL8wnHO8o
         ZxBzWnfjuG4afpzHeC4aIBDIKNonBJOt2gwgGJtFv/aj0nRtEVQ8SAC6Yk02DBmTHhH9
         IYSBuEGtZ+8gaEjMpCu5KmugDmCizAPCKdrVec3PVRMnZRz2JKHP3XOS9HO2XdyqbhUu
         AVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759440606; x=1760045406;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dT84NsQ5L7cCw3pr4Gco4EgRoaU06NgeVgWoDKDnXE=;
        b=TL4U09N3UzezA1ZzMJj8po/kOvtjP6loRA0YPq0BYx+I3YhCvZ90em4e5h8zDbEiv+
         yeapsFLtu+daXEmz3ZisFbkBoRUQXm0Tb27PNnW/kBTUo3SfD/Vsi2EyvsLEH0UpTp+5
         AL23ZAA3GgrU3GjW688r4PWxUgeI8YGAz+OVdJJQSXUL3HTwv0KsTg+kavmT4E0bjB3D
         2P6bpRITEH4Nz7UBmrQO0OAGLoZOwboDPYMdOB6YHyWTN0ivWbgu3tgWeKLXfw36fd4z
         s0msQgFH+0UK8h+DCYCtskNCKwI+Ie97hVH0AXgtlS5iHsPOAEf1DEMEN3r8DZEARXLH
         Bzcg==
X-Gm-Message-State: AOJu0YyQk//V+5Ns3QUjhOYK03Ql0otq6/M0Le/8qaBEzHbQZEWR7RIZ
	/ZmKoQ/1p3hWQDDYqwzmVmY2CuMjDx19cKXXSZgguIOSB3spKAeK8tIKhkn91d45bmI=
X-Gm-Gg: ASbGncsu0w4lTvfIDQAhSL8O4oBaYslVd6gNzEOmOQRNJG+P1dUYTy/+GChAZl5qLFj
	DfCRwolRkxM858hsAAIeybaaD2w58sGOxAJ9B4gVsVYkPO1cZO/rya8bO5hcsL74Ct/z/8e3S4F
	I9+K/ytOUw3Nj+Z21az2umplBjcZzDzPtGA2Lp/zpRpy29P6sjxb9V+LEaYGhh6eTODPkNyjp80
	WXW2Ai/BjhZMkIz1IKAEX1CAwdLBcfrP73vwzT3MUpzda+JYXz3VA3qvEW6U6R0k40jh2/iu6lE
	XZcYawgKDs+oDujzAuRAG/MlQj2bwIqFrBMHI9X37Q8h6XzHtPOy2oOF6n78uyiyrHGLqGDteuZ
	LjMtaG8avGQr0ZO5Io6hSlBIzWCr+irJ2YTfkWao=
X-Google-Smtp-Source: AGHT+IG+SpEIbL5sC/8GSI6uW3/+xZz3Xd5NWiqbSP19k8VI1Cx5/MkHbZloWeiPJ7UWNIbczxvmvA==
X-Received: by 2002:a05:6602:1582:b0:893:65c1:a018 with SMTP id ca18e2360f4ac-93b96930cf1mr108216839f.3.1759440605682;
        Thu, 02 Oct 2025 14:30:05 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a7d81bf16sm119168039f.4.2025.10.02.14.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:30:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, hch@lst.de, Tang Yizhou <yizhou.tang@shopee.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20250923112136.114359-1-yizhou.tang@shopee.com>
References: <20250923112136.114359-1-yizhou.tang@shopee.com>
Subject: Re: [PATCH] block: Update a comment of disk statistics
Message-Id: <175944060434.1563810.14517631402501395981.b4-ty@kernel.dk>
Date: Thu, 02 Oct 2025 15:30:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 23 Sep 2025 19:21:36 +0800, Tang Yizhou wrote:
> >From commit 074a7aca7afa ("block: move stats from disk to part0"),
> we know that:
> 
> * {disk|all}_stat_*() are gone.
> 
> * disk_stat_lock/unlock() are renamed to part_stat_lock/unlock().
> 
> [...]

Applied, thanks!

[1/1] block: Update a comment of disk statistics
      commit: 510d76646a6a7beaa49fc0da7282e285a3dfce97

Best regards,
-- 
Jens Axboe




