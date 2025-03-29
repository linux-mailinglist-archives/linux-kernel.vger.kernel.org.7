Return-Path: <linux-kernel+bounces-580778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4995EA7561A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 12:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364A61892F82
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 11:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5909A1C4609;
	Sat, 29 Mar 2025 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bTpdGO+6"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7212EBE7
	for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743249463; cv=none; b=Ul5MVNSG6dNOvHDkv5Hd76Wx5He3oYWuPhWMWx79x9e4I/yDf71XCNHkWzKWCzIpsd6Y+0MJJuiDMRZXxCc8eaqOPMFX/2WlA+lXcWYq9EVmQ+un3GZ2jzHzdEQS1ahYW1fh3Bso/GLlJUJGltkHrBYMEpF1DtIMaeSYSVtdk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743249463; c=relaxed/simple;
	bh=e2538gtUpQ42rrCf6f3RRClLcz0Ugt7JJeP9VY7Pvjk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iJpwjFhuPPIPokEW3fqsjRjhb05eVrTuPSNm6qzGVQ6cX0UuDNSbAXaAZnjbuVT9+KjsounzXldhQNR/EWq3ju6BjS8FBsMYgn3Q0eKsInr52wqAnFIgEnEroSa4+CzSKMeGqwV/cxJD1jV9xlOu/9SSSC4TdB+uZVlcYW0Acsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bTpdGO+6; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85ae4dc67e5so110609939f.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 04:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743249460; x=1743854260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxX3ANr6NSvvPmsJnkIgr64FYB3lilCLAO/JftDlNQg=;
        b=bTpdGO+6yu6mWaar7hVxou5cvrMtdtuDcfwcsGiv2MpCxa9rsk/7RwdTomPxqWDKue
         vz4l3U3y0/G1axtwPuS23wHXNcwwEqhOG0FC2KRyK3dTI7r8z+ESSr/Y5vTvtru64U0C
         w2axtgc3DW68p5EYKvYgzXCWCJrTqtggUyKonQcy5pY1zNazHz1sxfcRxz08ONSk6PLm
         pzmYOFX42w3ocjUDI33Tit+BBiEEmDRkkCUkFMPB1xAk7NWdpF0qKXyawXKSC9yONga6
         vwkHOTUPllUrakvXHJv0d3OnHRhJ7pVRF8O4qXa/Au4UarR4XIq5k4PFMvbiKbaYr4i/
         Uf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743249460; x=1743854260;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxX3ANr6NSvvPmsJnkIgr64FYB3lilCLAO/JftDlNQg=;
        b=QN6jTrnuErFUELlziVQif8RuSiQ2a4sphDRtty38AEtnxphNJbwHyAKwMD+QCly1Vk
         fS0W9kIX49XGOed6xLw+W5RR7Wh+tkxhdgOMSnMR+i4/Kt0MHPswLrwtAbITGPPTrloE
         nM1lEBIDxgvO365VE5A8y+GFeG6F2BSM8Z1WcdlRKzOGoVpAubZ2eGAqnLNzSJMMfQCQ
         gizJ/PIveBCkw0EJu3FRRRUJf0alIjWSQblrq5JK0M1+r6GH/07jwgXJk2jkH5TsGCOZ
         x2Kq7dAEn8N2s607Re10Tt/Fdo7+L9kUattwHedBsp+dDI5BwnNKbBxWP4zz2lkuPDUD
         +Wbg==
X-Forwarded-Encrypted: i=1; AJvYcCU1h3BP3KoijBaX64BdMdqX6OWTEjnwEbkiibkxLEmouttjEYZiKzXW72oYnvwTzbLcfS2Zh4NXXGNCI3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YweGkozMt8T2NicgKABw1fhcMWc+oi01YGiuUmw5gxXa/V9vYjT
	4W58Ri/3aQqRhGc+AiUka/SL295BQLY4SeMXqlVQuFKWtDcLUTbn+HPDnZHeYpA=
X-Gm-Gg: ASbGnctQHAo11wQ4fXgTv+t4L+pwZtRqDUjG4RyIbLZS31YtTT8Eu6B4Tcoj0Pk6DP+
	WkECbwUOo/BLJL14jl63RlB7vEPoVbCnDJHptGZQstEM1M4TVsk3eQS2qiJ3eKcrTAiEXxL0c6p
	96YG9KfTauTcLgIABv7o3miaSZpz6TSuacisNBmBYxko4/+BO+se43S2k64MGeB0XAepTWDg81n
	qpfrjs2y+QsLXKcXNmedjwu1jkmJdTDj8DrPgcRtzDbcQeydODp6IxwWoLvnM+zF9n+2/hQ0q7w
	2hNUeLou7wLjdmkFLSbOCQScz7f6Ihy1UCfp
X-Google-Smtp-Source: AGHT+IFTVZKYFNe6UA85TvVbckIVybnZWJ6eZNQXCHzFACulSzjpoYCh0/bq1dgaV0YT6sDI9LHHKw==
X-Received: by 2002:a05:6e02:2144:b0:3d4:6ff4:260a with SMTP id e9e14a558f8ab-3d5e08e9ecdmr27404885ab.2.1743249459868;
        Sat, 29 Mar 2025 04:57:39 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d5d5a6345esm9616765ab.1.2025.03.29.04.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 04:57:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250328180411.2696494-1-csander@purestorage.com>
References: <20250328180411.2696494-1-csander@purestorage.com>
Subject: Re: [PATCH 0/5] Minor ublk optimizations
Message-Id: <174324945878.1614213.14704274208444492991.b4-ty@kernel.dk>
Date: Sat, 29 Mar 2025 05:57:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 28 Mar 2025 12:04:06 -0600, Caleb Sander Mateos wrote:
> A few cleanups on top of Ming's recent patch set that implemented
> ->queue_rqs() for ublk:
> https://lore.kernel.org/linux-block/20250327095123.179113-1-ming.lei@redhat.com/T/#u
> 
> Caleb Sander Mateos (5):
>   ublk: remove unused cmd argument to ublk_dispatch_req()
>   ublk: skip 1 NULL check in ublk_cmd_list_tw_cb() loop
>   ublk: get ubq from pdu in ublk_cmd_list_tw_cb()
>   ublk: avoid redundant io->cmd in ublk_queue_cmd_list()
>   ublk: store req in ublk_uring_cmd_pdu for ublk_cmd_tw_cb()
> 
> [...]

Applied, thanks!

[1/5] ublk: remove unused cmd argument to ublk_dispatch_req()
      commit: dfbce8b798fb848a42706e2e544b78b3db22aaae
[2/5] ublk: skip 1 NULL check in ublk_cmd_list_tw_cb() loop
      commit: 9d7fa99189709b80eb16094aad18f7e492b835de
[3/5] ublk: get ubq from pdu in ublk_cmd_list_tw_cb()
      commit: 6a87fc437a034e4be2a63d8dfd4d2985c6c574bc
[4/5] ublk: avoid redundant io->cmd in ublk_queue_cmd_list()
      commit: 108d8aecaeeb52f5fbe98ac94da534954db1da44
[5/5] ublk: store req in ublk_uring_cmd_pdu for ublk_cmd_tw_cb()
      commit: 00cfc05cf81f58b1bc2650e18228350a094b1f6d

Best regards,
-- 
Jens Axboe




