Return-Path: <linux-kernel+bounces-821886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE36B828D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A151BC7A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B222425E;
	Thu, 18 Sep 2025 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YxFTJFKm"
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC55323741
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160234; cv=none; b=W7JGjF8KYJ0D4kWIoc0WMDzDR6a3CVLUUpAsVNEBpRUsG4soNNIvDiAVTQVgfInrWgAczzSSHZ8TML+uScEf8LWiAfqoo+O3ZmHPSEpZaCNb8f3IfCRgRz6lV5LolINjlrzfcrfQAPaPvO0P8/EUPrh/Gu5JRGWhKlCbim+8m+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160234; c=relaxed/simple;
	bh=YmbL8tWBk7PcWIy4d7codzBe7sqj3ogMoQ4DpsIfxTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yq2MfGlAihaShmbyFD3cwtc0JBJlMzvLE5L3sHVW14VHh7yEYT98b3+oFHLe+4ApNG2pvsa6l2NgAWAYLtnbhjvs792gmi8+ib9AN9+QYzcbC0ztOC9uZNhtFFM8eKhkIs2MAgI+2IFnawXAKtYld/EDSI5fgr7nPhCI4xMgj7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YxFTJFKm; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-329531bccccso124612fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160232; x=1758765032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGIvktuNokMfEeQBYkw+feVubqH5mU5MNNf0kIjurc0=;
        b=YxFTJFKm+GOwjfBoH9z85PSg9AUcAUd+cAdZAyQjPMkMXMWxLgNHkir8fXi1gWyh9P
         +FSQPaCehaHpibVwkwYAIu8ZVgbt1xYOSE3poYZLc4zam18wM/rmZVJni2ZbLqNAl4hC
         a+r6GkQVp3s3wYGpESdOxSbDDnNTFoI55PiMd9LsUzijzexfdVygJP4aLjsMFmWHgDpX
         eCybjVCWctM1XtYCyeXoATmLPvSb/62SLe+pEEfhjgos8/+8bRtTgNFlTTK/XK/HHyfp
         Mlk1r+U5owKENgfknsbChNNPvZ0EwDe4jtWV6vseMgg/lpvUSntpAAGfFl3Fykm92UQd
         j0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160232; x=1758765032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGIvktuNokMfEeQBYkw+feVubqH5mU5MNNf0kIjurc0=;
        b=UJUruk3xOnf4ZuW4anxcbdQkPMbLVrv6LVV8WBiWGS/Xp43rpi2anZs9xIFiy7J+rj
         1vtE9BQLfpgYPVIjE2YM8xBJEqWhob6dmMOsRwGd9dXnblQlugV9aAIBp7YjUgqpJ1cc
         +1jxZf9xYCPG3klY2UONdB2ZRR/ZHHYfkOldLe0aA4cmAP3Uf1NwbDNYzgIpOGaaW17E
         Ua9OxxAMJBepckuA0JStg8hzbG0qejn4cEYmWjUfYNwu6KKN2hnk44NxzdqYp6E4ujM/
         Qi21yuPObAw6THyNfYEJEXuXUty4sZTYgfRctFPicPSWez6785R582IomuWkYJgwGS1f
         NVqA==
X-Forwarded-Encrypted: i=1; AJvYcCWXz2NfoZ7rg7MDXZ3VvO5P2B1I37+uRLAH77U9Tr1PnMAHCXpZ21szMFBOQGWKNmu9PB4Llpd0NAcZzTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaPSYQ19tXHWtPPAj6jBJHDUktGrvHrrLkcWgdCXDJ3A6qHC/1
	QWLwP3fC4gB60edHtCVc+Zc5lGS5ODANJkcd6mEJXiukBIJBLydMBCR3oxVBNthS/j/ZQEdyxQY
	VTRjPgjrMXgjxTzuBXFBl7XW00oTvCIQ8l4UaKxVf6xo/aZn9jM3F
X-Gm-Gg: ASbGnct47XyOETaiUw1pnHaIlLN16QAMmMBK14ETG4mlJm7dckirU1Sq60+exaPiTcD
	BYKnvHaQEAdmlb1Pk7cAsJOzVCj8pah7BSVdCXv1rlXHDrdwrvrCCET5Qbz3Vv0fRnD5E7AuLur
	gebSe6D62QCkw3rsTbn6tEs23R8PsjBPbj5e570kPVZB6XmIJpZ6lNi0HU7S70Q+vSOf5dk+S2f
	8hBJlw50GfbtDrvi0SDCeLgIffGSwBwokLdUapqquFAAjanjymK41/N2bIG+YGXiQbHVoz3TcLw
	RCe+ZJRnDmFKPsek6GxU9X1yXQiWDCNrSpNFPC5xk+vZYbA/B7YNXxgXSg==
X-Google-Smtp-Source: AGHT+IFjlktqk/3nYPmb+CRYzX3NN7hHld95pMMXVz0WtXy5Y67cG3TeyxcLYDmSvHwYCTNNBsADk3KeahBe
X-Received: by 2002:a05:6870:9a97:b0:31d:6420:8791 with SMTP id 586e51a60fabf-335bf6206demr1202085fac.7.1758160232119;
        Wed, 17 Sep 2025 18:50:32 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-336e6487e4asm123459fac.18.2025.09.17.18.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:32 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A36D6340325;
	Wed, 17 Sep 2025 19:50:31 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9BC38E41B42; Wed, 17 Sep 2025 19:50:31 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 00/17] ublk: avoid accessing ublk_queue to handle ublksrv_io_cmd
Date: Wed, 17 Sep 2025 19:49:36 -0600
Message-ID: <20250918014953.297897-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ublk servers with many ublk queues, accessing the ublk_queue in
ublk_ch_uring_cmd_local() and the functions it calls is a frequent cache miss.
The ublk_queue is only accessed for its q_depth and flags, which are also
available on ublk_device. And ublk_device is already accessed for nr_hw_queues,
so it will already be cached. Unfortunately, the UBLK_IO_NEED_GET_DATA path
still needs to access the ublk_queue for io_cmd_buf, so it's not possible to
avoid accessing the ublk_queue there. (Allocating a single io_cmd_buf for all of
a ublk_device's I/Os could be done in the future.) At least we can optimize
UBLK_IO_FETCH_REQ, UBLK_IO_COMMIT_AND_FETCH_REQ, UBLK_IO_REGISTER_IO_BUF, and
UBLK_IO_UNREGISTER_IO_BUF.
Using only the ublk_device and not the ublk_queue in ublk_dispatch_req() is also
possible, but left for a future change.

Caleb Sander Mateos (17):
  ublk: remove ubq check in ublk_check_and_get_req()
  ublk: don't pass q_id to ublk_queue_cmd_buf_size()
  ublk: don't pass ublk_queue to __ublk_fail_req()
  ublk: add helpers to check ublk_device flags
  ublk: don't dereference ublk_queue in ublk_ch_uring_cmd_local()
  ublk: don't dereference ublk_queue in ublk_check_and_get_req()
  ublk: pass ublk_device to ublk_register_io_buf()
  ublk: don't access ublk_queue in ublk_register_io_buf()
  ublk: don't access ublk_queue in ublk_daemon_register_io_buf()
  ublk: pass q_id and tag to __ublk_check_and_get_req()
  ublk: don't access ublk_queue in ublk_check_fetch_buf()
  ublk: don't access ublk_queue in ublk_config_io_buf()
  ublk: don't pass ublk_queue to ublk_fetch()
  ublk: don't access ublk_queue in ublk_check_commit_and_fetch()
  ublk: don't access ublk_queue in ublk_need_complete_req()
  ublk: pass ublk_io to __ublk_complete_rq()
  ublk: don't access ublk_queue in ublk_unmap_io()

 drivers/block/ublk_drv.c | 155 +++++++++++++++++++++++----------------
 1 file changed, 93 insertions(+), 62 deletions(-)

-- 
2.45.2


