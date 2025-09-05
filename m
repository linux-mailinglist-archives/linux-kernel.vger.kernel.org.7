Return-Path: <linux-kernel+bounces-802722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73357B45604
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5815B5C5E9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23133343D94;
	Fri,  5 Sep 2025 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gqzNFz1m"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D0B343217
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070844; cv=none; b=FmE5/77XKSQqA2ty6FjUN8uvBj29xBEnJqJNYRdwPJSR76CxHZNBenEIHRnp7Tzs6Is/iDPmSY1e+RLZ1ye1rPyUXBNOjWfkEltg3lLJb6wpG6MjH6UlCjCMVmrOYGcGKTALDI/7QNXq1w6RjWG6enEl9zaQNTbnEXp9rFSCodY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070844; c=relaxed/simple;
	bh=LvPr8ZjWkY5j+R/qUcEAtG1qh+P4cINY04MmTiG6eqg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EvmwPqw69HW9cN2OkeiKpwRHpLkgcY3W3TKNmrvc3G5dlqof0v0mTyNNNPixAwZOa720Yt3H6/7mi4c4yT/7nIdaOZfwPAuXijqyaCBiKVIp+cGx+jaFn5q/thLCAUHNghc4njCa0yBaL5XAFkVtNxOQsn3fQptQAD3PRi9Euj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gqzNFz1m; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e98a18faa35so2242108276.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757070841; x=1757675641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XohVMPelRMi1Z40i3tKGQQ26fQqgID8bfPjyJfPTGog=;
        b=gqzNFz1mw/RyfOr8p+8dsnHybe2Xgi5MFxK7bkUScLF4P+GwroQv5LmqvHyDaOmA04
         x45cU9xuqHeia30AWAyNX0AvgiT3EavB8GlcWcFiL8K+Gww/QqYG5RPQMUkdIgXz+BiN
         LQE3hpB+eWz3H3xqHSB6/mQ5ago+9/8HNN/M5cpoKTJDlRFauEvUIp4aGO9cnHB9ajAu
         6mzURfUCiwoLxOgA774AUPO61mPyQ+dXHIOzXDpr/LdgOHEkjKEOKXzXFYVAUEhfeJmB
         z67XJGwS5UFf4KIT7otVBvEGejKkdMgknQOLlqUbwXDt+l9B5lOmiT2hlIBd5SC/ePKh
         RxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757070841; x=1757675641;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XohVMPelRMi1Z40i3tKGQQ26fQqgID8bfPjyJfPTGog=;
        b=vSAZQM02jmol1btSSUesY3+T2/eMSPYkSXTq9xZ+4vhgFF4aAMe0+k5bEMuJd6PaS7
         EkmdLineKVueWkqkYeQdy4av6j+4gwdybEuOSGvl7OFbVh1LoDR7Kl/7Ub8HQ2DoGVgw
         NZQ5So+nLwAPzo51VAV3YX/Us4Vz1ueMU/Si54DKMxS9dA2zDzA63CleYWj4nOWqTQ/g
         8wv8pfbtn7sONKpb9GRVrW9cduq5CT7rJ+2NZYwjgnUdAgJNsVHYoaVFbRcseOSXIBhy
         fpEb+iqZZG/jUfGwL7cMfNZ/IZUQCwD3EJsWh+kJT0CgtEUzYDUiK9rmZKaqGX17PAzc
         UYHg==
X-Forwarded-Encrypted: i=1; AJvYcCXo94wF0iSsc0lnirmXwWDGgcZAdrQ9rfw2GfTVNC2qA4jOMcNRQJnRYkFPCNeWJJW+FP5vXwXWtUX/SPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEHjrCecbl4KC+XHuKzY2j7vgUOAazZ5GIMBccjlXsC34FPi+X
	dqtgLKprqXd2v/KK86bDwy7OJWW8vRo+GTdcW14TLc6N6a0Rl3R9c4CZnkQZ++ANlOw=
X-Gm-Gg: ASbGncsiLEGFBjij5xJAjfGKWXwcihsLy4cLgiSOycRiQmnItEqdPB5zNWkRc1PYMMS
	mc+pgLotdqYLNVOF0s79o1uDJlXifSafXojhurYC47usKwrcwGXOvGSAJZYg6osZHWGBo4G7ST5
	OQPHV5RGHnQrvvOF4LRIYcOFq+5e0Xn3rX1xvQn8ybo7+lW9v5FDf61aLwC7vo6vyM+fSvnMt0o
	s++gX5UKwv6Qr/AakvmDKhYBSjy0jR1ZIBDyfjhVPAld+KfVchUq+lcGo9vPYria6NMQiEGcu7S
	SkZlBgLOK+nHdR2TJ9+5gc4lHVE/VZPDqeQrhT4lHRCOPVSkJIuLSP9vUlCbWdgWAUW/Klerhgw
	OgfgNE+K1mf6eE19bgV0FX81LT96j
X-Google-Smtp-Source: AGHT+IFQGiEhr5yUMqGKD0P94jeQvBpJEYwhpNf7H1jqUT7KYojcKEb7y1jTd42pBM7o87Xc40g0jg==
X-Received: by 2002:a05:6902:120a:b0:e96:c6da:5bcc with SMTP id 3f1490d57ef6-e98a5759523mr20552127276.1.1757070841316;
        Fri, 05 Sep 2025 04:14:01 -0700 (PDT)
Received: from [127.0.0.1] ([50.227.229.138])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbdf57266sm2999999276.14.2025.09.05.04.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:14:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250904161223.2600435-1-csander@purestorage.com>
References: <20250904161223.2600435-1-csander@purestorage.com>
Subject: Re: [PATCH v2] io_uring: remove WRITE_ONCE() in io_uring_create()
Message-Id: <175707084052.356946.85147804002646222.b4-ty@kernel.dk>
Date: Fri, 05 Sep 2025 05:14:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 04 Sep 2025 10:12:22 -0600, Caleb Sander Mateos wrote:
> There's no need to use WRITE_ONCE() to set ctx->submitter_task in
> io_uring_create() since no other task can access the io_ring_ctx until a
> file descriptor is associated with it. So use a normal assignment
> instead of WRITE_ONCE().
> 
> 

Applied, thanks!

[1/1] io_uring: remove WRITE_ONCE() in io_uring_create()
      (no commit info)

Best regards,
-- 
Jens Axboe




