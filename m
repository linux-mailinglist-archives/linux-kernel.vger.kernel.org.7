Return-Path: <linux-kernel+bounces-722147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA501AFD5DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8E23B10C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BAF21CA03;
	Tue,  8 Jul 2025 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="X5b3c/0g"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615D221A421
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997617; cv=none; b=XnPcvVLM85hc1CxYD4YvDtElpdfWscX5cYtMQjGITEqX/1trzItuuUjHZYH3CMeOcxwT4dcaehr9sOaByAjXO4oJsWjazq+2CdsycagKpQVXBbRy9u5rSXI0fKPi1SaRZHm9hioIq3SusWXjbAoDistSowsaECMI0lJDV1uICLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997617; c=relaxed/simple;
	bh=K0FtaLvPDD58SdNpxuK7ai80vnTyKwzEJVT+QPt4lJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WJFN633+3VT0wg4U+7y0DxvwAurXpGdc4BIKsUJL6upGrMz8aQuRf2AtRuvGcFKALPLm/EgJLRwAuqkcicsqcmIoPbjAsF33/FT/oauinROG0jKpiUWDdDALnx0oaYpfDowQXBzMJ7HNyj0Ly8MaCRHrKBfxZHoIaLsvygSbDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=X5b3c/0g; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-86cfc1b6dcaso156337539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751997614; x=1752602414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpAeStKhuXFhmoLjTEJdf1ChqrXW0xgEt5fFi6Rv3U0=;
        b=X5b3c/0gI+ME3H87aw58cyaiWUUTANGDq/BbV9NkvevC4YQTJi4d+sNChbyOD6vsqT
         d64Ht28xoiXcY0n4I8T5S2LHgIU3LIEPdxPS/nZD7CWmIoDZ6IyNqf6TwJVO0Zd6BesO
         HgcdFJe/3aR+5y4+fMK2LQYfrfbdckGs98AFwsqg2yKQfez2HIXE0e2IMlAGMU//uqbj
         kqpqT0uLM2uBzqFQO6n0zTOuL5xMuKsCN5+6eJMueTImqn6aRMClHOLkGYcjFYoBa6+x
         c8ZZIipZMTsUsah+E8q3PPfERjJ/2DsIdbvwQ7Svf2bZzkpRUqELYJps5y6YX/Dt54UZ
         Zehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997614; x=1752602414;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpAeStKhuXFhmoLjTEJdf1ChqrXW0xgEt5fFi6Rv3U0=;
        b=nge05bdzmKYIg4Tam3HWMG4oiv8OLgdOxYkewTJxoKD0bYRSCgG2UKUJICsPtNuLx2
         s6ghzsEefmtI6beqCPfpmzo+TOVgC4MZ6axx3YSiZuBFjVrP/MalYO5GftB2GmRJwg1b
         bCnVgo2GBnTkg3hRRZJVFHWybfp3FQI1fhuX1VwMTYYJbZk/ux47uZWmmFOftdttTznI
         VCPVwYru1W4OxfCrD5mSnVjmSEmYz/5PDh4Q5gYLT6fRQj6/gb4HyxHqxjtkVfWXOpt0
         Vgz5dqnC3DbIyfjLDgLJSrm8zhumvLgtITTZHIrep9+GUEdOPaIvKY3LARLaAxyb6l9F
         Wucg==
X-Forwarded-Encrypted: i=1; AJvYcCWrKdfEMJDpBH7zNX4ZCgKDqmZPTEF/cFqLiMyf6DYDRoA/wPXwntdHZeWAjtfwjGz2TdDOVhR7dmvrcJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE8fTYOXyL+8mYArGCbOcrrRvUv2yVKHbVQT69mrv8s/9KkqTa
	vUcfO6AVa1Ey+Um/eHTpRn14mnLLZiIzRgkKDMKiLfSWgylXEB1ySZ4oSkaI9aAHgAA=
X-Gm-Gg: ASbGnctClqlBvO00Q165N8nYeF5ujkf1HQGua2juihqhUMuGBplIK+vNWzi//p7zgJU
	Dp/KDtMV4zQ0xj2Lst+7vEEM2h0GDoFYCmPBiu+iAK8r+Vals3cDUSxT+rmAMMb9nDlEek5zxX0
	Tig9mlsa91XTlOMyMTESNonCyAgxm9XOccq2BTk8T6bvwJOeJp7OA809TT/g5NQU8KtQz1HAC3+
	Za95bm5Cq5AYvdBzAqBs4m0fnmIMpTbdcpWBWyhhhpvPUlKcVMtijuy/HsYy0Z5+uRThpzD2sdI
	QTF9PBrAcMbGDZUW99kk0jBbxJxpP4iIstipybgw6cQzlohiurGrAYU+p4R679U=
X-Google-Smtp-Source: AGHT+IF7FEKSKTg37RdYgnx6ZNfepZlDJuC0fV06sUWu4KRmrj0zOy1YhAyMZYb/GQVD06m6nkGkVw==
X-Received: by 2002:a6b:d319:0:b0:879:26b0:1cca with SMTP id ca18e2360f4ac-879596436abmr83046639f.13.1751997614319;
        Tue, 08 Jul 2025 11:00:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b59c72bbsm2276958173.38.2025.07.08.11.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:00:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Philipp Stanner <phasta@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Li Zetao <lizetao1@huawei.com>, 
 Asai Thambi S P <asamymuthupa@micron.com>, 
 Sam Bradshaw <sbradshaw@micron.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250627121123.203731-2-fourier.thomas@gmail.com>
References: <20250627121123.203731-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH] block: mtip32xx: Fix usage of dma_map_sg()
Message-Id: <175199761337.1185853.10292369872403699020.b4-ty@kernel.dk>
Date: Tue, 08 Jul 2025 12:00:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Fri, 27 Jun 2025 14:11:19 +0200, Thomas Fourier wrote:
> The dma_map_sg() can fail and, in case of failure, returns 0.  If it
> fails, mtip_hw_submit_io() returns an error.
> 
> The dma_unmap_sg() requires the nents parameter to be the same as the
> one passed to dma_map_sg(). This patch saves the nents in
> command->scatter_ents.
> 
> [...]

Applied, thanks!

[1/1] block: mtip32xx: Fix usage of dma_map_sg()
      commit: 8e1fab9cccc7b806b0cffdceabb09b310b83b553

Best regards,
-- 
Jens Axboe




