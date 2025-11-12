Return-Path: <linux-kernel+bounces-897562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D017C53308
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406C5507B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FDE33DEE8;
	Wed, 12 Nov 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0pXpeRpE"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C029C1339A4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961168; cv=none; b=Lt0JnSUYd0qLyCqBbR4u8M0Wp8P67/qv58kjbwUOV17+h06y/V5ysfANkIJ4WpkDf1LsuQbGyELnJqWyOGvkS1xmQ7wZIp1dGMxto43uUSIdG75RaH+slj5NwPS7i6GqjYAAfy9jEyWbeFhA6iiJwoMCv0OH800AN319KnMDoA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961168; c=relaxed/simple;
	bh=S3HgcwMVfZzHMTxf+gvcGSq00lyXdOZbvgaMm4vD83o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OCf23KnemZO+FuNnRjrfUqCaiUp0yCAOrb2nJDWWVozsNEPzH9eNZsRO9oPfbPYRYe5we082mWhZST/F0eUoHNQ76tJYTCWgVECAJqtQIrBRT0RjpAijbaJIQzgACe+MIIQSKpiiJF/DPahR44l18w+1ndkrbubf6PJaxdUjzKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0pXpeRpE; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-948c962a0edso24127439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762961164; x=1763565964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhfi1JuTKDb5v2cN/vHFWbcXiiQnvSefPdXao0zAnOY=;
        b=0pXpeRpELAJ2GDaxwqZ+8ZRABbERL+ScFGuWSu8hL2QOcCWw2Tegey+8OzpdLsf5OH
         NJwrVtJ07l024X4JsoV5L122Ic1XV+pwxuLmkhWcs+C9K24mBfrjvKTw7jusV5JXwK1S
         r25zQ2K3C/I5H3078KIc3B/Cz9VaP3bPthlc9ZkTo97bs66EARkVjTcxGcPAckqzNL6F
         kboH7yGvP0VhwqgliKJ3oQAsXFGl1z7R+tfuUP4kD0MYsPB4VmNcePM9EDB+7WoL21G8
         S5MJLAFzglwj1BbYCzQmFitltc+b9+beb1o7y0QEJn4Uq3d1z8Oh2EaN8ysQw81AkTt9
         1f6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762961164; x=1763565964;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uhfi1JuTKDb5v2cN/vHFWbcXiiQnvSefPdXao0zAnOY=;
        b=DKLOQtKSR/jYbeyb7FJtNGSHITPmBT66MDmZ/oxWnyScRMGhL8FI4XenKg+0tC8Y4B
         0RqyTVgMqVrTlgdJ+2uceahbSVzcglB6zfxesoE2CLSFhMlVTvUSE2iblxdz9GqvOKpw
         VeFCb9M3MahebnpYY23hx2IfcAr0ZM/QxnWzgFKML1H4pVU/6PD0iIZfuGvFip1h+icc
         zATujVdiQp7ksn1IVH3UioVrDLdjzqzeCk7THpAJDaHoDaO7xh0UTmQlUNfrpg/2LvHi
         3l2TO8luNcbHRCRZS5d6DBEc7yh7nKXwn0B134vbFxUVi6jRHcv7MZtueq1hDcBxgURE
         qCUw==
X-Forwarded-Encrypted: i=1; AJvYcCU8L1fXdLGAmfg/L7OPkXHJh3dh/4LtX4ihHpMjcz01756w+cJiviZIA0vOpvkH6KbyJP7bOqCLiuACoSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+BEmnEa9KDUO+elStpOaJrW0Rh+snE1CJzzAaakIkmxe/IJ4v
	zUUdVK+CIx2AzoZeFEipEDGYz4zeyhcUWe6WRbYXIoAIkQRTNt8pec7p4/RCgvJ98T8MK771Pwy
	1YElE
X-Gm-Gg: ASbGnctIDTJP15cXW+kgxZkw/Q2nXaavV4U2DV1hk4jnonjDbX6dVPdk5Rtr7/DRrJL
	7sfTUd2ZGFvOrrKYcBGhAIaAqamW+255Z/EIO5y004dpIypuiRLVa/CJH57hyfsKZHCfVwqP0h/
	kMrfYpwM4cwY+8Bm2BylR+aqg6NKmnFqivEyUfV5jmdxoqE0PaNrEbGXE6/ZXEl0amGE9zbNo6M
	/6zZ6PXEZe6hIqSGjlIz7Kfv7wNL5ehIDv4QWqW32aC+Q+iMAXinz6e3jKpzMTpKCke3r8ZWaKN
	7yA109W6V7FCS3hICM+RD+oyNNnwTSNIT2clr+G9jZ+QdDSRTV5B2+4bswwag3SIEXgs2t/qfKU
	dGzwxicGKgoCY1GsyHKVuQeqJ+yUTqEIv0EM+RsNPg3lW6orRHZvl1dtJWC40ddBv5zyt
X-Google-Smtp-Source: AGHT+IGqo/ElyNGaDcWY1T7XkvUdBijvAO9psWKrSyA4l0qa2YEYORSe/5hiqsBqgoiwFhOiCOknzQ==
X-Received: by 2002:a05:6e02:3388:b0:433:7c86:74ec with SMTP id e9e14a558f8ab-43473dcf6a8mr41773375ab.23.1762961163853;
        Wed, 12 Nov 2025 07:26:03 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43473398d5dsm11421195ab.27.2025.11.12.07.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:26:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Chaitanya Kulkarni <kch@nvidia.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251111191530.1268875-1-csander@purestorage.com>
References: <20251111191530.1268875-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/rsrc: don't use blk_rq_nr_phys_segments() as
 number of bvecs
Message-Id: <176296116216.24001.10740596505863921319.b4-ty@kernel.dk>
Date: Wed, 12 Nov 2025 08:26:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 11 Nov 2025 12:15:29 -0700, Caleb Sander Mateos wrote:
> io_buffer_register_bvec() currently uses blk_rq_nr_phys_segments() as
> the number of bvecs in the request. However, bvecs may be split into
> multiple segments depending on the queue limits. Thus, the number of
> segments may overestimate the number of bvecs. For ublk devices, the
> only current users of io_buffer_register_bvec(), virt_boundary_mask,
> seg_boundary_mask, max_segments, and max_segment_size can all be set
> arbitrarily by the ublk server process.
> Set imu->nr_bvecs based on the number of bvecs the rq_for_each_bvec()
> loop actually yields. However, continue using blk_rq_nr_phys_segments()
> as an upper bound on the number of bvecs when allocating imu to avoid
> needing to iterate the bvecs a second time.
> 
> [...]

Applied, thanks!

[1/1] io_uring/rsrc: don't use blk_rq_nr_phys_segments() as number of bvecs
      commit: 2d0e88f3fd1dcb37072d499c36162baf5b009d41

Best regards,
-- 
Jens Axboe




