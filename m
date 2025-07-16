Return-Path: <linux-kernel+bounces-733760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE541B078F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0137FB40E48
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A2728A1C8;
	Wed, 16 Jul 2025 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uTVHnCXJ"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D202F4309
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677469; cv=none; b=dAuTyyfrvlY8mdNZQWrIZQoULtNUZg1oGwER4HLfB+LS+8SPdWjzi2EJBhCxXWXdFluwpCdBDc8qOwaS75E6X6UhYuR0kejluG613gjDWk3RGHC6GLxsKuiwRL6yBitJR5EoMp2Jw77Vcg8j++SeTFEf5hBXPw6+wLtYyBd5CnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677469; c=relaxed/simple;
	bh=fwbD9UqZsH241N3eR2h9klJuicSlxQUaLnMjsuw1OwY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e+HTT1lOpedty3CpLn8o07ltDM39mZGALsrmn5yso29sj3kg7h5W9KhnugMWUjByd7Ln9s6BupEqgrVoVQ3LMIe8jC9J9wxTkQoogw6GkgBDmMN2q/BP/NuFNe73bBcVIocV9gRhIWOavrgpNMpjrjE5cteP684j43zzGdIr8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uTVHnCXJ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-875b52a09d1so173708339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752677466; x=1753282266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwbU0q/ifd6FalZH5HEq7gHegG0B7AyE43XqSR/SlAs=;
        b=uTVHnCXJ5apqSXyWebs2aoGJqb82KYo9Wm80Rmlql7+xSlqwt3D+jkB4vZmzHkubEv
         TUbEKRpHtCiiQSwl04UjvaXosbXD5fJx7D5njMS7znsIEATmXvivhFlumKWoT8l1IbVe
         KbotzRNKhnM62IASqGTLLJ7UmwTjp6YN/ceaLyKVe8FkOQBgyEhQukKtabEruIK882eM
         UJ2HAONUvSSFzseAaReuAghB7+139VupBpMJgeMYMEZ7rqmAwWUuU/GO8I46Z8te+QV/
         yo0wQGDwH4bjDXNMR/X5ec0snRicAOWYeY5ALpWo+pp8+ikbWJh37kTXYDspxjnfsDBT
         wOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677466; x=1753282266;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwbU0q/ifd6FalZH5HEq7gHegG0B7AyE43XqSR/SlAs=;
        b=nr8VA4X4wfLwMSvKxSav5TuzElM368kQ7K9xUpwWAwTqrE2jiOAd+j5ChjqYRHxEzh
         g7YYfANCTh+8xVPSACD9SDrLLwHIf30K7fGM8dcLhbyBI2S1e63a/b2D9F8S792LwMA9
         KIXIpnd4BdUD5vyBAz68zitl4uCblKCy6eF2rKThU4AaQfhWKZUxF/GpPY5DnqDtmkvd
         8UxxacswP4nri1VdH+PaFQ85oCFkYQM7uxAM3an2HZXuAVA5rDrIWsvZ7r7AkhMjvpc3
         7ICnAeeZLQa0L0RQiYwdcFPBrYqnSzB1AOOr5EMLA47yJsqQalvq1If/A4s1/Ovi0PqT
         Pz2g==
X-Forwarded-Encrypted: i=1; AJvYcCUbzI5ecoyIMtbnpHNNUNd5c2O4sKYaLGBdnZ4ls9nU2NBD0rSriCTut+9UApyva7i/6jj+b5XUX06IKcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydaiz6JbTzGdodKlzUzmAn94aRoHJP3gVFwAa+zdKWg7Xu0ca8
	DaMDuq2WmjonjcPrMKHaYGciBEJJ3+cw7NgD7DtfUPm61UpzZiLYDb7/PNX6q1K0tbVKp39SJG3
	/8XKQ
X-Gm-Gg: ASbGncv6YyODTER22/dubOfIHFSzOO9Lkwi2eTWMmopixnVThYFqsMnxQA7sbIiC4VK
	1SdbxeytM9SMKEJup3xIsIRpndDR2OEz4m+yUC7AfaOY85WkQ2a6bZLmmVIVorQe/VxKyHeBIzf
	SEOD36vJhzCI3TxhXMaFd43ZVTO8VR4Y4+rZS/QyL3M/vHVSwLh5a/hFa7l/ekW16KbMNy5/R2H
	IMZ68E7Uz561imCIp1W1MdcBgCIZt2tKTndP1vOT3MDPLrn91wxMbNlrdFzHSWr+9++Xf30ECB/
	O9MMy9la6vz5Bx6rcZ84NP+0b5wmAo+w1DKq43GcWQYuPkRDQjTExgY02Z2TKc994WaSXZyD0by
	EOkcOP1l/YmHF3g==
X-Google-Smtp-Source: AGHT+IHP4Rj05mgTi/TM+2sWnURzVs9GTrIAvMAgF7z97LxxXL0q66/VCKY85ikZmNl1jEito3jg6A==
X-Received: by 2002:a05:6e02:1a09:b0:3e2:83d2:8b08 with SMTP id e9e14a558f8ab-3e283d28bb5mr23221745ab.6.1752677466082;
        Wed, 16 Jul 2025 07:51:06 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569d0e4dsm3011781173.109.2025.07.16.07.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:51:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, 
 GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 io-uring Mailing List <io-uring@vger.kernel.org>
In-Reply-To: <20250716144610.3938579-1-alviro.iskandar@gnuweeb.org>
References: <20250716144610.3938579-1-alviro.iskandar@gnuweeb.org>
Subject: Re: [PATCH liburing v3] Bring back `CONFIG_HAVE_MEMFD_CREATE` to
 fix Android build error
Message-Id: <175267746483.305834.15435352691107984360.b4-ty@kernel.dk>
Date: Wed, 16 Jul 2025 08:51:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 16 Jul 2025 21:46:10 +0700, Alviro Iskandar Setiawan wrote:
> Commit 732bf609b670 ("test/io_uring_register: kill old memfd test")
> removed the `CONFIG_HAVE_MEMFD_CREATE`, which was previously used to
> conditionally provide `memfd_create()` for an old test in
> `test/io_uring_register.c`.
> 
> Reintroduce `CONFIG_HAVE_MEMFD_CREATE` to resolve Android build error
> caused by commit:
> 
> [...]

Applied, thanks!

[1/1] Bring back `CONFIG_HAVE_MEMFD_CREATE` to fix Android build error
      commit: bc8776af071656b47114d777b56f0e598431cf5d

Best regards,
-- 
Jens Axboe




