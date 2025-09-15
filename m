Return-Path: <linux-kernel+bounces-817661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6A4B5851B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC181AA8140
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BF023814D;
	Mon, 15 Sep 2025 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NYNN3Ts/"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FB427E7EC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963174; cv=none; b=XSDR3O6IuUHjURngq65mnc24nPszmm0VJL5HoM9SAarm9G2PBLYq/YjYzbi8WtwU3yPlBgUGLOMtNI+fC0/jOmpH+pw3WMngImSGRsvYBlzisb4tSYJG/GFBcqK++PtNw+MmUSZGkQcTOhjlRb4YU81J19C9f73hxK8SPy/rZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963174; c=relaxed/simple;
	bh=uG8nC9oDH61dYzrtPeYvBQoL9gSQjgCoib4sR0f3whs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YFBgKYLiSKWnYFVXAaJhZWGO00pAQRd3mGBPUYYe52oHLM/rx46k2BUG/Ed55Ov98BJDfxVJ6G60gLVQs/wx00EvzTWstHTJzzY/Ed+R04vtSl1ff8EglyWesXMCSS2KLxGwxkyJnTBwwNj91agIO+msnDIJPBlVtRVc26FoRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NYNN3Ts/; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-424073edddaso6378765ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757963171; x=1758567971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVh6sd5jyxq/syVYCa2EI7xp2H1Pq0+2Ah4mfKjgzlg=;
        b=NYNN3Ts/Vzg+H1ZsgdHr2dvbyL7CgJpkHNaLVB2rR70gLED2MApyLiZkQ1Ltbw6jHS
         EoqUOdyTST7bRRN75NOm4jxdcMzCAo3ZcQj0kbRLt75YPEB1EBOalaiBOrVtXYUQHMRJ
         DgFIj5uFqQtzHhY0id1xkJTsfkSATYbDFm3la/KdFrZAjJ7HpmtmSJHXbwZAjfgAxE/z
         RvepyobH9dgnxNPjFvUkfR8OijaV7esVqfUHS1HvmJsg+vLh0KuI1f6/+Ypg5T1+lZGc
         NFoJct8gdCUXkNkfjduALHsqIxQMbQrf5IRWlRgz0pw94x3xQWJD31lPZcVMeJooIAsi
         oXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757963171; x=1758567971;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVh6sd5jyxq/syVYCa2EI7xp2H1Pq0+2Ah4mfKjgzlg=;
        b=nxe9fzjNn9hJLW0Zc8hELS5mIiUUUWm2m/TCgvf6t5EldRVpqpCIamwzob/ep9fsSY
         xBHj8PKTsf61sgC/R5Qo1Yq12/4TcNhAZu2GDyfMb7K2G3ZWRt5ft8CjZhXXKiy+pVjL
         QJampYLYwWG/Ql2KEiMgR1V1ydqPgaw8/hYt4Jxl8YojAHt0U1TAPOr7yyvG1FRrd02R
         rzODJqMktdquo2N9Ko9ovVfWHAFP9wo6NQEZetM92NCTDTzPIEO06Sq3XWgN74fUJFl3
         hiJLPFZbB7peL65n8r7dbdVmxfE5LGqyxKBkpq2PxRC2Mny01vWHVOLxH62k29///0Y2
         I79Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5BIRGsgn2OIToMm0Bh7UIbrkRRC2/yxHS+4otNrKcesV2tGnY3jpEBBwA7saM3r2KwpoaMItKtWuk50w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/sMrgdFq4WtHoSXt7shrC4r2A/UeZqnWLe2/aY2nOI9W4Cqv
	eBuU/Brt84RMzmWb32p/8tV58OGYRvTj2iGMOTVDmdz8XC1IKZdv185L5HOjSeZ3OCU=
X-Gm-Gg: ASbGncv+R8JCqgoacGMmIi0Tuzbq89mP9KtFo2uVIIGMHqWkxAE4IezwpDXcmS/HGQX
	HCkdByqb2H7GNWzJqkvIeBZ1py6NbODJig3O9ulUBVOORDod5usUMoFYElBJVkfz/LIcEIGNBtw
	YNSM94n/XFdRhzkOeXfbQH/5FhWXJewgZfK6FAJu2lQ9dOQdkpef3D0k3CWkzSDtMH0LkEKnH4L
	6vgvIl2y/udMbEzSUXOOKy/dWAw0YaVmNal3f/V8SOWrfHPnm50y+KqJfX8l+ZP3rfKFRZDIXUU
	+pQ20eylv0Wlvy0CFMWCmhYTPKTmhOrK4I8qG1/jHpVu8CTFHGGvOBG68FzqvtDMlEm8ZylAAep
	lVEVgUh3GpYeYFg==
X-Google-Smtp-Source: AGHT+IGcYD4IuB/wNW8MI8+e27nl+qICtx3uV3uHHdDP6AqZ/REWrrxVvvAsFfR/EjZbUXKsqyNkjA==
X-Received: by 2002:a05:6e02:4815:b0:424:657:7782 with SMTP id e9e14a558f8ab-42406577ad6mr46791835ab.7.1757963170660;
        Mon, 15 Sep 2025 12:06:10 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-41dfb240f4fsm60222675ab.43.2025.09.15.12.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 12:06:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Fengnan Chang <changfengnan@bytedance.com>, 
 Sasha Levin <sashal@kernel.org>, Diangang Li <lidiangang@bytedance.com>, 
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Max Kellermann <max.kellermann@ionos.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20250912000609.1429966-1-max.kellermann@ionos.com>
References: <20250912000609.1429966-1-max.kellermann@ionos.com>
Subject: Re: [PATCH] io_uring/io-wq: fix `max_workers` breakage and
 `nr_workers` underflow
Message-Id: <175796316976.265356.16431775523856266594.b4-ty@kernel.dk>
Date: Mon, 15 Sep 2025 13:06:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 12 Sep 2025 02:06:09 +0200, Max Kellermann wrote:
> Commit 88e6c42e40de ("io_uring/io-wq: add check free worker before
> create new worker") reused the variable `do_create` for something
> else, abusing it for the free worker check.
> 
> This caused the value to effectively always be `true` at the time
> `nr_workers < max_workers` was checked, but it should really be
> `false`.  This means the `max_workers` setting was ignored, and worse:
> if the limit had already been reached, incrementing `nr_workers` was
> skipped even though another worker would be created.
> 
> [...]

Applied, thanks!

[1/1] io_uring/io-wq: fix `max_workers` breakage and `nr_workers` underflow
      (no commit info)

Best regards,
-- 
Jens Axboe




