Return-Path: <linux-kernel+bounces-808279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95A9B4FD83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2512E5E1436
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4313C346A0E;
	Tue,  9 Sep 2025 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="t/q64CUl"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2D533CEB3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424913; cv=none; b=oBb0MGMI4iI6ir57DZyPB87amH/wzuyK9xVcro3+SKHA7aCv+Jeub2WjPNeXlTmFYboDRLErd20cJHGkJ0nDVDpNah214r3Cg4/5hi3cm13KA7Evcu5nGZO1uv/L0tHJwGynq/TTmtA/ZJTWHFqWqr8KhVk0VW0WwGFMnFFGWB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424913; c=relaxed/simple;
	bh=0GySI8s0uwrV1hGtS7+LpGdYoB33k/6ufezuMNnALcc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qe98gtThlBL8dGt/s8IXwSPhJ4B2BJA/gfxygRohQNyhcwifHLUGQ9XfR99ovDvHB1RbFzIOt3+2PGKpMZU2eTpyUGB5+SPo09wt5lS127Cz9JqQEBBpHu6ompUmwcKF1w/KJbLT7wBOOKgQaA5z5l2CQmrUC/J66aha6L9gjI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=t/q64CUl; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8876462a34aso153031539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757424910; x=1758029710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91VEMk1sFfOijh/hYnCmgtoVp/4AL0xjKu6h1vpW3GI=;
        b=t/q64CUltJgiwgcP3jHR/mLdhQ3s2R0XmqtXjwhmw89RSJqBOCLTGUdDPR0iq3SIq9
         O9GygxbYw/bJRHAfjQokyKt+xC/ADyM6vNDTSJQCN63B/o4EN01Gvw6yJR7cN0G3+KVp
         y8Z/kryUFcJoqIUsbOI4+L9adDHT8/A/5GzXkBAAdpJ1l8uOIIFd83W379if/Yp3RQ0F
         R6psk88p5iMUNMNrE0xdE/LnTqylLWWCUGImQxx/2QmwwAlOxX192K3jcFV8XfTDZk3D
         VWqS2uZNeJULSeYPPBPrenUWQJgxD6Y43L/pBE5N38tVn4njGS9qtUkO+N50+vcFXkdP
         5m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424910; x=1758029710;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91VEMk1sFfOijh/hYnCmgtoVp/4AL0xjKu6h1vpW3GI=;
        b=GyifhiRZfsZlaWHrgMRikxdg6wa3jPRYyNug5Y4DI1Vmab/pv9ndm1jXVKaWdHe/uD
         LdhP7VKGWvfYeCgPu7myonLifYQo8JDaA6RLzj/CLGxMExL2HRbo07zYsFvWQtT0w2Rk
         /KSAlkdHzIIPvNvX4ZE1xi1ZdAenvr/vR1VjriLk5CILlUMJ00SbM+HM+FqT7JSl0yu0
         pvRPZ8ERQ0FP29TH3+Uzmmj6f4H89AYCPKrUh2Njrk7kvsPqVGocJ9hxFkx+yCYogJbF
         yyWLrE03eZFxS6eveL5qUimTgfkFvzFtW5flsvnc1G9HuRYd8B2p2xvYVKjopPRrrecl
         YGww==
X-Forwarded-Encrypted: i=1; AJvYcCUvAuGTH3YrC8uAoqDykNc4QguIuLHJTYRWnD/H4khW11kAhw6eusz5oknNHFVxDklNKASlDum6itHmRTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXJLG9c4JZQjv2GC9zzpmxw2ncG9fpGDNj00eXfYMnDLnXDjlD
	9hJV/OaejAYKxvPWPWJ2dOWNlExtzG/PQATdAqPyc9gl0WZA3I1A2FeTxzGSn2762/b1U5bpO+q
	C/LOP
X-Gm-Gg: ASbGnct6GEvdv3lmVmzS2b5cypClcQVAm6Ns3KB4tJxTazPiVe8U3KhOWF39yJDGsDN
	imAILuLcQscierxljIjq/YtKSsm0C6rYsV6pJbhE59utuLplkApwHWU8cCrNm1s5tWBbxxsglD+
	6cf4LfB7OvT7ZfK7n0Wed1iL4CYCJ3mAdQwBxS9st28eqA8dvegIemQjw7HSoSnAwOiKRYubtnA
	WZ5A9x2gzM1YbWOgxGS0mYwY185uJWB74vH8oL4dXOOR2dKR98QoVjNFFyRX/i6WrvO3MPzGcD9
	Bn0tCTDq03SIGj3BfFP9oT6nTj0cWtgCL+eKwiuY0a4qNDHMesBV36EwyWgChFaLvP/ONwvZZyl
	y9p0sMB4fRvxrFwthqcCpmE9P
X-Google-Smtp-Source: AGHT+IFBZSrPB2kXk+dHxClCODH7SV3vFFWuaBjUmLycLqklhqrG1sLBrZU038RkcnSLpfJJElR64A==
X-Received: by 2002:a05:6e02:218d:b0:40e:de9f:28ea with SMTP id e9e14a558f8ab-40ede9f2ad6mr42285195ab.19.1757424910342;
        Tue, 09 Sep 2025 06:35:10 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31cc59sm9880910173.48.2025.09.09.06.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:35:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250904170902.2624135-1-csander@purestorage.com>
References: <20250904170902.2624135-1-csander@purestorage.com>
Subject: Re: [PATCH v2 0/5] io_uring: avoid uring_lock for
 IORING_SETUP_SINGLE_ISSUER
Message-Id: <175742490970.76494.10067269818248850302.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 07:35:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 04 Sep 2025 11:08:57 -0600, Caleb Sander Mateos wrote:
> As far as I can tell, setting IORING_SETUP_SINGLE_ISSUER when creating
> an io_uring doesn't actually enable any additional optimizations (aside
> from being a requirement for IORING_SETUP_DEFER_TASKRUN). This series
> leverages IORING_SETUP_SINGLE_ISSUER's guarantee that only one task
> submits SQEs to skip taking the uring_lock mutex in the submission and
> task work paths.
> 
> [...]

Applied, thanks!

[1/5] io_uring: don't include filetable.h in io_uring.h
      commit: 5d4c52bfa8cdc1dc1ff701246e662be3f43a3fe1
[2/5] io_uring/rsrc: respect submitter_task in io_register_clone_buffers()
      commit: 2f076a453f75de691a081c89bce31b530153d53b
[3/5] io_uring: clear IORING_SETUP_SINGLE_ISSUER for IORING_SETUP_SQPOLL
      commit: 6f5a203998fcf43df1d43f60657d264d1918cdcd
[4/5] io_uring: factor out uring_lock helpers
      commit: 7940a4f3394a6af801af3f2bcd1d491a71a7631d
[5/5] io_uring: avoid uring_lock for IORING_SETUP_SINGLE_ISSUER
      commit: 4cc292a0faf1f0755935aebc9b288ce578d0ced2

Best regards,
-- 
Jens Axboe




