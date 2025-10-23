Return-Path: <linux-kernel+bounces-867716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E9DC0359C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B35374E771A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91312D23B9;
	Thu, 23 Oct 2025 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="c6LhWJ8Q"
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D42235046
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250719; cv=none; b=oQeW4gdHN1p5eAA548KdupnvH10YGxOE865WXIHhQUIANOgrRpo+nlsAUPn8ZfOSFsJwFCnSXdCmgbbDcGfs+tFdTSSuD4/4/WiNyCuXMI3OqmEUqtlPwE5632vTw7s1ccMjcnhre/C70n2STdXwR/gIZUAHKOW/EaKFABk5jUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250719; c=relaxed/simple;
	bh=MNaW/Qmo6FwgmkLQqa0PKYjlcqHuOYgu3MksfCpQ4MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=agqtS4nxQuot7ElMJ5EFk/2bH8m9y/nhE6EPvtyHszYFD8nwvse7YUzTkRvfuQjj5ev8HUMhmWy8YJNQpKabInso8bTlhEPoT6HI4lEazgdmAWYavzyY2K+wd56gXAGGtJWam+3MX8DmdLqpNc42+HJbaTXpjb+kth+W2nJxVxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=c6LhWJ8Q; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-b6d6027158eso14458066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761250715; x=1761855515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cz0mQMPnFRMldaxGN9MCesCYr4t4w4JLIICl6X3LGRg=;
        b=c6LhWJ8Qe9UcznFArqbRWsOQ9aHKKotymYnnEk+I6HYUpGXcm+p2Q2vFNGTC1ha5UQ
         fupBDOD2xiTRww3vIabFbLCqqbt4v5O1tIiXzBjoHxwH78uwRoe922w5TxFsmPy7hvhw
         dKZay05aUFU5O2LOS6SGthy/B8PVTPXCuNAmQFHrtEFPFHYA60KQ1x+jwTvg4erbQdmC
         hA6MNEQj7V2yDyDxNMCIZtUn7mSKYaJxRLtWVeHEP2b+aneeOx3KSRXu02fIQrsGe3py
         sNoCzGq2AQxv6+xL6Z9qNoS/fNiHmu8VP2agrf3Ty5hvJah7d+C0zZas1Yjd1cNdjCSN
         qgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250715; x=1761855515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cz0mQMPnFRMldaxGN9MCesCYr4t4w4JLIICl6X3LGRg=;
        b=xEyWVKFxaPkAqPhnz2bY8IEH+Y8fJ9u4NZR4xBiic4Y0hYJtiRE2OJhJs0qj4soZgb
         Gag6A4jDgTLhLc/7PpOV+lflZXW6tcfhx7s+Qmin9LFfBrJppNrDwRQzKu+hOdPXrutG
         76/BJ3V9xLF2jfHKmSYKYuOOnwJ0isNPUyAcciDnaRHErFL1VayXvwN1qv69xqc+3e+7
         2+d6pQVvxnn2+nQXd1P5ZcoFlZm4BHNQDaJBBY6Z9aOghhdLy39eGGsoseBBiOpVKLmo
         8dPFSRWXZdVvjb1v1f9ZJKkl6+83kNOt7pIJkR4NJQBNWL+N5WUA9Rc+YR2IQodebuh+
         p9GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVjT58xKlTj23dlZcpdy9h5GJsuztKe/QjV60a6tjPrJ6GDrvW7HOPfRMt8afK5tEu5VQmfzm4FMQ0ZAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7tTVUctuwrRvpskiZDFq74vhT+U+iHaAcDlT+CjyFGro7k9VZ
	vCbEFk2Js/9/oSwxWNVXDbtgUimFRaC+K0ytBIApHYrW9wEMDoTMoZXQivROawVTy5aQeBdqTMS
	+C6SwcmQkEX/t1v70B1ffkFk9RALLmcScTuXbYbBL9n4MPtBtZCos
X-Gm-Gg: ASbGncsdzakS3o4D7BCbSV+RTZGf1lxy9IK/pCOhsVSJoabeaaCbXp6DCrVALlPoDhi
	sa8H04QVUOL2hZ72N/IbMweLjrU9k436g0I2pLjoxkYoejWm1zdQCUOIfGNKFQaHwbID7YUjGmK
	AJepISomk2KP1joe/Ic9SA+jidf4ekb5LenPC/B8G3yWPTHA/yh8N8GeAWXJ4x58wUV6ud6JhGr
	XXr2n5mzpdbFB6exRgM2co+EfK2AzsKRJhJnqm631GmsJLTN6wZUAFzrZBHinV9wc1ziBY4BgEv
	592MPr8gcTcOWF2NluIN1MPIYpeKUoh79fBTdJkDBcXufrvNyQxa9e13tWDaVo5CZMCQDT+x/am
	QSogDEABZjzpSpwxb
X-Google-Smtp-Source: AGHT+IHXhL/uv6eUeaN2ZVLtqNjngQKnmQcL5o8MgXl81NLPuCh85qOP68iyVWTyOMVTjHd4V9x4RLM8fwMs
X-Received: by 2002:a17:907:9803:b0:b2d:a873:37d with SMTP id a640c23a62f3a-b6c722312e2mr832720966b.0.1761250715011;
        Thu, 23 Oct 2025 13:18:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b6d5141d9dcsm15476066b.54.2025.10.23.13.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:18:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9317F340384;
	Thu, 23 Oct 2025 14:18:33 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8CBBFE41B1D; Thu, 23 Oct 2025 14:18:33 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Thu, 23 Oct 2025 14:18:27 -0600
Message-ID: <20251023201830.3109805-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define uring_cmd implementation callback functions to have the
io_req_tw_func_t signature to avoid the additional indirect call and
save 8 bytes in struct io_uring_cmd. Additionally avoid the 
io_should_terminate_tw() computation in callbacks that don't need it.

v2:
- Define the uring_cmd callbacks with the io_req_tw_func_t signature
  to avoid the macro defining a hidden wrapper function (Christoph)

Caleb Sander Mateos (3):
  io_uring: expose io_should_terminate_tw()
  io_uring/uring_cmd: call io_should_terminate_tw() when needed
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  4 +++-
 drivers/block/ublk_drv.c       | 15 +++++++++------
 drivers/nvme/host/ioctl.c      |  5 +++--
 fs/btrfs/ioctl.c               |  4 +++-
 fs/fuse/dev_uring.c            |  7 ++++---
 include/linux/io_uring.h       | 14 ++++++++++++++
 include/linux/io_uring/cmd.h   | 23 +++++++++++++----------
 include/linux/io_uring_types.h |  1 -
 io_uring/io_uring.h            | 13 -------------
 io_uring/uring_cmd.c           | 17 ++---------------
 10 files changed, 51 insertions(+), 52 deletions(-)

-- 
2.45.2


