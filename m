Return-Path: <linux-kernel+bounces-799553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFCBB42D79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254C41C22C04
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E5A2F1FFB;
	Wed,  3 Sep 2025 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NWncxyKv"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA4C32F744
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942580; cv=none; b=bru8AC6sKlg26EE4NSSd9KVRBW7BehPUVLo0zkfxF5WdjaV7qkUweyDUIQ3ZuYvKjeGIUUBSUx3tZZ6Aqz7RfoZJA28XKFmI90owlZLrVlhv2ol3Wwbwv59UlLxMtqORl0nSV2oXEC4JqatGh0fWhBGnlNdf3MIgKPQivg4x8Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942580; c=relaxed/simple;
	bh=gAF0GiYG38lA1kzBT/F4AXVuSYamIxae9UhNShfBNRw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HLcGVHJ9TQyHa8TWxIZqT0TA5+S8jTUD8iwHInFjfpz6OP5zb8Xapm7HLK+yfsVsFLohdpOhyvmUjoWenmKcDaD6eza8tMyHWkLtmxmwx9sCd1cxKdkuL+2Yfpto51y6YvWDL65FTxOTlZ0Jv2rfCRvFHz1RhFW0MgRaprz6gQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NWncxyKv; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3f664c47a1cso4739755ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756942577; x=1757547377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3JW0RPEGedvDyMhg18Ej09/52eO1GVo+v4uJsO42ag=;
        b=NWncxyKveoabsn3z+9DLuwrMusOrfI76y8WSYFEYpYI3WMqh4ZvgO5Hz8Ud4ACZBiD
         LSkT6PUccFmLu3Hso3u4DSImRAfllLsRcbV7RbCmYN77j5GWq8cPvfCkH5u6ifjwxvd4
         NJ9vpRJWcF4irps3uj1D8Yiid4f5Zds51i/zAcE4yf+c6AyCJaxVymSi9Y3x0YmCGg5x
         eTZ2V1vki/796HYiwQ/47x+0Ae7LzNcFKIybO/e9g3MW8xJifi0R4vmjDkZnTtaKiM2y
         vTNtwDaAIIhF27mQk8REIrUdPp2wZburjhcqHaKvpD+90iwAKn3Ma5tIjIDjx5p+bsUX
         3AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756942577; x=1757547377;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3JW0RPEGedvDyMhg18Ej09/52eO1GVo+v4uJsO42ag=;
        b=a5oqrvhwzE94ZR4WsZDqUBYXHle4547hIjr5tfIR1xSOVV8VaO8Q0Yb2hifOMgThZK
         dlkRTLoVfeV+FOBQutfS40c0tLxr7G3Nq5FeE9bkibyLTTKepzRT1Z0QiCNTrkxe4BnG
         +olU0u597hiOMbYHZVWNmCYi1BNrE7fbGQPXZWRMFEjmgTt5sZhrz+pS3dMhE3Ib30+e
         yAy1nTLSus3zYxlUDDZp5CulM55PTIJwvDEmyDPTqguJxK/i2ayrDPaOjBoQxHSrufPI
         +MGAVwBBHwVPgz3LhKWUUcu/3BOzQQVhsQz2J0iJbwoH2DcVOsXSTtUrh14k7WJ0nNRE
         KC0w==
X-Forwarded-Encrypted: i=1; AJvYcCVHGzX2dhl/eZlaHq6RtFIPsb7MKrcggws+/GMslcxmV0wewPJZ6/NcyDk08870PlTXuCgKnkVP35NI3H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsRQrIj3lOdAXRnh3UGEs//R/bcvDIj3rJFGl+YYHSlAKDoUL5
	FxAeHNifKY212O+LI6zKhQR0nkRIEqovxTK89dUntUHHJ2pcxmNdiQGIligYka8zOONzYKMvgmz
	uUCtL
X-Gm-Gg: ASbGncsaN8o2Dao+G/Yo8XgdTqpk2OsfxYdJ/EqUS5GKNaQ4cp9E2ZPXPOH+VEe87FK
	ZV6pdk4FwzI3ElNt/5OMnG1KaXyl4vr+7yYXSz3wllSInoiOB60Bt2x15DqowxOBOEy8GSbremO
	wG6LER+fjPuhNpZYHFCVo6xeN6TqBxnH22/CApW8Av0n11EWH0SvS+0Ta3TJixLnlfMrVmRvlvN
	xqmfVGSCsr+DqelQmgHKdpSWQ6tY34NcvP7l90K0BfqXWlagC1ESQHAhLbfOccMyVSSqkNEfrxc
	N6uQ6gKaMQJaTWB2gXRcE5+pN6Hq/93fyTlP4R8f61LPpATZUrrLjVc0+rkSV7e8ULRWS4pwIgw
	HxcoI3/CCEMSEp8XRdaAp+DvvNyHMTij47Ia2
X-Google-Smtp-Source: AGHT+IFLC+slb7ygMZMPUf1vPhWF5HAfFWl/vv7bO8M+ywB4h5W/s7tkIfjyPaDbgoWO4qBqUg8Zyw==
X-Received: by 2002:a05:6e02:16ca:b0:3f3:2812:417e with SMTP id e9e14a558f8ab-3f400674082mr291578545ab.14.1756942577647;
        Wed, 03 Sep 2025 16:36:17 -0700 (PDT)
Received: from [127.0.0.1] ([70.88.81.106])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f65d1ef2c7sm18736855ab.5.2025.09.03.16.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 16:36:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250902013328.1517686-1-csander@purestorage.com>
References: <20250902013328.1517686-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/cmd: remove unused io_uring_cmd_iopoll_done()
Message-Id: <175694257558.217330.1674546709065281273.b4-ty@kernel.dk>
Date: Wed, 03 Sep 2025 17:36:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 01 Sep 2025 19:33:27 -0600, Caleb Sander Mateos wrote:
> io_uring_cmd_iopoll_done()'s only caller was removed in commit
> 9ce6c9875f3e ("nvme: always punt polled uring_cmd end_io work to
> task_work"). So remove the unused function too.
> 
> 

Applied, thanks!

[1/1] io_uring/cmd: remove unused io_uring_cmd_iopoll_done()
      commit: 9f8608fce90fbcd2a98ceefad0bc762423927629

Best regards,
-- 
Jens Axboe




