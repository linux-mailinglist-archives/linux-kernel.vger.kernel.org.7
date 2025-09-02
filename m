Return-Path: <linux-kernel+bounces-797389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5B2B40FD9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F021562221
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5AC26F445;
	Tue,  2 Sep 2025 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VEHF8dUF"
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A926CE3A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756850891; cv=none; b=c49V/PQ88c6mDo1wCyfz9ELI5YFOtnGSSNUpduueuBUNRR+ykjDThJ53FUzPJjgABNfVzkzlqDkeD37BUA866/Qjk5QHcs1fdOdCuJVFVMBnvy8UWuL6FMiGDaDVJgqiZgcQfbmyXxoLIsSjGQoXiGz1u3NPZFgzDcV07AwpfuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756850891; c=relaxed/simple;
	bh=r/lzy9yr6DodEDv6FzqGeWpQUvOquGmOFlV+gYPQqqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XuvShsdH10qECVjviHXggz9DbLRWxZ140K9lj7g0Na7vGTIIwaBeprLQEk7GAYNdue7Oksj0esC1wr/bpC3VKNat+kBmGSM4slbFUZdrcnGhJ8tBJOd2kAjHhpj6e0z0WkbO0xHf1n/RztexUwd2AzmNB9To0/uBLw/DDU5AWp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VEHF8dUF; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-7725d367d44so165263b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756850889; x=1757455689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JS8Y1zJmFurXBmjvwW5K+3pblWnk3elwcS+1Ua//b2g=;
        b=VEHF8dUFWY8cPIkKrEfCskFKX/tGk+QM23edonHw0sorzjX/3rsgZbGiECwW+YzXUT
         CwTrjA7yIS7w/tn5THlrv0bu5ZwPerncxZUtAoZC+UBZMRHy8ew7sTh4o6fofeb4iSVc
         Ts1OaK5pcJkb1irYo8G7XAw6ZYeHbmpWq4TZRPkR7KHcxP9iuGE4D8cCHjOyq19NNf+G
         0hb/DE0k8ftulDwxT0Js95uFRv5kM39b+jQSTeCyq75ToMFM6MKRGSWadD6KrXhqmRxa
         GUwn5tWfRGdR3QMHkR2y6G4+gWBx5blRRzdHFrPDkxdCX06HPCCh1j7MW6G2dkfOmWZ8
         GOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756850889; x=1757455689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JS8Y1zJmFurXBmjvwW5K+3pblWnk3elwcS+1Ua//b2g=;
        b=CIy9gpTAxDWNGCEvGvoXhtkEs0UzMBSuda/xnwhyZUah+v3h0CzEkH1DieLagk3fWQ
         le//4N7rG5rYJC79pcCC+sWgyJHrMRTmeht0hNiaeeqCfROChAR2+RQaQ7uP0wr8Ul22
         LgIYvCIJT1NrHP3CdLVZTqOlK/tqfiyTQiU5RQJrYYZ4ofCDVj1SpqOiSJIFxgoyRmgz
         4TvLRX73qLdw6jJZY9govqswIzCRqY5hClCltRdXJHjv6EOSNrYb2ih+WTipez1DM+9c
         teEjeRdeAJDSClrvSVbcwfmuHqTgRRcwexXEMgEXQswOL5q+hVu+QxEd3euehBUUsk6E
         AZnA==
X-Gm-Message-State: AOJu0YwJZUc+jx0W6togNszK/jRtKl6czrInkyupIo9ej+yFZboVLhNB
	A7pTMPZ7pGZoQ+QLaUi4/8Vggvpo582Ikyl9WtjSqS9XTGv+w4EPHVhFjld93IbFDk3ubCm+cTB
	mmPEm/DYjB+Qhqk6wdwK4cRGP15UVoBZ0I/kFIZqlXBsiBJAOzuII
X-Gm-Gg: ASbGnctcFsI7G3ESnO6ysZmHvLqAaBqsYQJDt0c6+TyGZ1W+5GJbkzqPEPE2Jpj3HoN
	FX7sfiVKim6ZaZ93uUGjgBDJqfipgkX9qkPlTRCopd4THmZlkKlxUOVCn9wRo//GNja/ydUwzyX
	aMRVMMiH/Tb04luLHpp9eDDGByPORlVxKvwamQeVePUjij54e01ZovPRvalS2J2ZYUvmwAeLe9u
	MXNlH4yaknaKPrWx2FRpaE7rHcF0RpAcJqqfU60c/4Wulfv/jlfuGkFqyAoQqa+zd1wsYueJhRt
	g8fnBnWM5p4sI5q36D73v0T6a5gwuRwdSEw6PdubTjTE+P7upcs6HLSmsg==
X-Google-Smtp-Source: AGHT+IGlfAHyxEUyj0SGVziuTT7p8mI22wEOeCMI/3ILrwiV8uceIaoMD9dUe59rQEJrC8RW6mRv9Y62rN8p
X-Received: by 2002:a05:6a00:2e27:b0:771:f8c3:1d1b with SMTP id d2e1a72fcca58-77232874f4cmr11293159b3a.3.1756850888996;
        Tue, 02 Sep 2025 15:08:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7722a0e3218sm774116b3a.0.2025.09.02.15.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:08:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4FCBA340214;
	Tue,  2 Sep 2025 16:08:08 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4A4A5E41920; Tue,  2 Sep 2025 16:08:08 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/4] io_uring: avoid uring_lock for IORING_SETUP_SINGLE_ISSUER
Date: Tue,  2 Sep 2025 16:07:59 -0600
Message-ID: <20250902220803.1932692-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As far as I can tell, setting IORING_SETUP_SINGLE_ISSUER when creating
an io_uring doesn't actually enable any additional optimizations (aside
from being a requirement for IORING_SETUP_DEFER_TASKRUN). This series
leverages IORING_SETUP_SINGLE_ISSUER's guarantee that only one task
submits SQEs to skip taking the uring_lock mutex in the submission and
task work paths.

First, we need to close a hole in the IORING_SETUP_SINGLE_ISSUER checks
where IORING_REGISTER_CLONE_BUFFERS only checks whether the thread is
allowed to access one of the two io_urings. It assumes the uring_lock
will prevent concurrent access to the other io_uring, but this will no
longer be the case after the optimization to skip taking uring_lock.

We also need to remove the unused filetable.h #include from io_uring.h
to avoid an #include cycle.

Caleb Sander Mateos (4):
  io_uring: don't include filetable.h in io_uring.h
  io_uring/rsrc: respect submitter_task in io_register_clone_buffers()
  io_uring: factor out uring_lock helpers
  io_uring: avoid uring_lock for IORING_SETUP_SINGLE_ISSUER

 io_uring/cancel.c    |  1 +
 io_uring/fdinfo.c    |  2 +-
 io_uring/filetable.c |  3 ++-
 io_uring/io_uring.c  | 58 +++++++++++++++++++++++++++-----------------
 io_uring/io_uring.h  | 43 ++++++++++++++++++++++++++------
 io_uring/kbuf.c      |  6 ++---
 io_uring/net.c       |  1 +
 io_uring/notif.c     |  5 ++--
 io_uring/notif.h     |  3 ++-
 io_uring/openclose.c |  1 +
 io_uring/poll.c      |  2 +-
 io_uring/register.c  |  1 +
 io_uring/rsrc.c      | 10 +++++++-
 io_uring/rsrc.h      |  3 ++-
 io_uring/rw.c        |  3 ++-
 io_uring/splice.c    |  1 +
 io_uring/waitid.c    |  2 +-
 17 files changed, 102 insertions(+), 43 deletions(-)

-- 
2.45.2


