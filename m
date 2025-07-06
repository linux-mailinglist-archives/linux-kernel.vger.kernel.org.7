Return-Path: <linux-kernel+bounces-717641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF39AF96D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 17:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E05E165C86
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E461E7C1B;
	Fri,  4 Jul 2025 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TvFn2PDE"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FC91494C3
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751643068; cv=none; b=leFDNRC+CkLNyr5NB/QJBGT6Rzmp4HH5B+HSRFKvJ4nm7GWpKhnWC6eWCbbcMmh3Juye/IFZWAPvZOR7c3p+uULYAKdILGgmQZVdC4yn9oNDWhkl8MG9XV2sCSqS8ojfsVpXq9JtQP/jg5xb+tWeK/yVndhJFMyipQevGrwjHyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751643068; c=relaxed/simple;
	bh=nHadSmOQ4fj+9ocF6rtES/ek/GuvZAir7sGoHBqWim0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aWXdjlTkUcXCgpmPDhg1KP70onskNaoGJepdnLbxirZXaf2kdRWHCdT0e8dbUzAKLbwSc9+THMDyEDiCb5GQhAKAN5UyY5FAVY+2vp4vEeLx83QPnba8m/0H2FVHZ0BsFen5cH4dS05MWBopVb0nk5nMkFgo9qyVuKEJI1N2/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TvFn2PDE; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-86d00726631so29367139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jul 2025 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751643065; x=1752247865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9U2YxSqLeeEvmDWj03WV/W/8jXHi/A1A5Rn3s5NR3A=;
        b=TvFn2PDEE08DvdNjlBnqzAndh4c0St6Y/7jdZgEcbLFuiljZ5rGnOSJbOLZcUKFHtp
         O9+hawkMyI6UOVuh429NsvuxJlTP/MGVW/Z1oC5gGvQpBMCzHt91NU3YcQ5iQ1V7c+Gv
         oM+vxkMGY6wgnxsfXaCj8Dwxq6soSHgiZmphNChGJFmEWltkb0TZIzmaNFLTB143ENZW
         2snHLK3nD4fajayCubJ0wUYEcn+F09JQBvJpEYjdCe4DL+4TlsZoIbFWYZyHFYEjImkU
         WD1PeQWJ71H1QykiGYi972nH2VGKTut/Q6wBkX1bPn3qOMOgVViqfQfDvtzqKAjAy/Bt
         bF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751643065; x=1752247865;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9U2YxSqLeeEvmDWj03WV/W/8jXHi/A1A5Rn3s5NR3A=;
        b=a+etPBcA1A+9SeEFqccTlmdBQtsEindqrwNmrOldlMoOVK2ljBNeZQpOYkYLYlcNeh
         JJ9LnZVnU90ZAl04Q9wd2hUW4OAhZMtOc0JUelTIwnM/nR5HReF5xQyXm5vqIBtJp84r
         p5zvsluQBf91sfUaQD3EC5WTcLWD4gFhM7JLuJ5hs0JedGPO9KUy5C0s1UerkNVSndTe
         g8geasFg6OeV3vZjUTNWio9LAo09egE16yyx+kZ3BUb2YrYW8ZukZgFw4hVkEm0K9ohP
         Hnja2p64R9DWhcD5LS882ic2+oDhhv1NsBUrxqOVCfdkkzRl90UXKvProMffAGwziJ5o
         3t0g==
X-Forwarded-Encrypted: i=1; AJvYcCU0ww42t0/hO8Tpd9HPrjS/cfeXzqtnV1WCAtHHedOtZwEsFw8hBI8arCVTvSgg4ucKXM5l1+LU8PDnJ9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyadHVjYOLbrqe71EVGSm7pIdfbIEQYK4eCsKhtR/81mgnAleVu
	2LjJlxtAkwwjuI89G+gXmR4QpQCXVNkrf4BbnGL1A6vpTknWhfl5hDO90M1iNv3kZWE=
X-Gm-Gg: ASbGncsFUvXJzvxNpEJzMWnZhNBTMev3Hzd3Xk3coMBjRHkxIOeBCmBlYOxTTzPhTPj
	EyFQ3DOrAuNcum2TWvB+w6Zihmn00VWal1KAYJXyYBdGOGI2sz2p/vXG/EqcUMgTqZs6X41wTl6
	Fb4pDgLQdI+UWC60VTyVUsMgNS+8a1yrDJM3BHAQJ5unABC1su93zeHQvz5/NRlKDo+jdwozwcV
	/lN7oFWqiSsJ8H8DIQCCsix2fLAdyLBaE2KoIrCHRMDVZ88M+RUP09p5eWiStycqBpIckmRExH5
	JecTBmTPGzAkM5dIfOK3hrDSI+AMTIUsv+689veFVBqdlZELcNkUcw==
X-Google-Smtp-Source: AGHT+IHEmIEl2VIpJwn0U2kmzedfnLAA7Xc0aynsYELESl9e1a7hV/8vJyBS3dHfv/hzMTr/lr+CkQ==
X-Received: by 2002:a05:6602:3a07:b0:873:35c8:16f9 with SMTP id ca18e2360f4ac-876e47b0dadmr215484139f.8.1751643064818;
        Fri, 04 Jul 2025 08:31:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-876e06c9440sm53826139f.0.2025.07.04.08.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 08:31:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250703-ublk_too_many_quiesce-v2-0-3527b5339eeb@purestorage.com>
References: <20250703-ublk_too_many_quiesce-v2-0-3527b5339eeb@purestorage.com>
Subject: Re: [PATCH v2 0/2] ublk: speed up ublk server exit handling
Message-Id: <175164306375.597273.4784854727001872046.b4-ty@kernel.dk>
Date: Fri, 04 Jul 2025 09:31:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Thu, 03 Jul 2025 23:41:06 -0600, Uday Shankar wrote:
> Recently, we've observed a few cases where a ublk server is able to
> complete restart more quickly than the driver can process the exit of
> the previous ublk server. The new ublk server comes up, attempts
> recovery of the preexisting ublk devices, and observes them still in
> state UBLK_S_DEV_LIVE. While this is possible due to the asynchronous
> nature of io_uring cleanup and should therefore be handled properly in
> the ublk server, it is still preferable to make ublk server exit
> handling faster if possible, as we should strive for it to not be a
> limiting factor in how fast a ublk server can restart and provide
> service again.
> 
> [...]

Applied, thanks!

[1/2] ublk: speed up ublk server exit handling
      commit: 2fa9c93035e17380cafa897ee1a4d503881a3770
[2/2] ublk: introduce and use ublk_set_canceling helper
      commit: 10d77a8c60b2b117868a64875a55c4c8db6f1f2e

Best regards,
-- 
Jens Axboe




