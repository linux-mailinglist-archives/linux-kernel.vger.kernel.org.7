Return-Path: <linux-kernel+bounces-876782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0764DC1C515
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8DA34F68AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDF73002B3;
	Wed, 29 Oct 2025 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LjpUCU2t"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2621170A11
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757018; cv=none; b=pJycDgZtk5suwUea7lJhymCt2I53klZ/JAkabCtZZ1O5e3XPCtcT0dpor1GacdKfNOXDeBSpnh/FTDZusDPLpk51ODbaYarrzwUP3Dx6RCLAaiPM5HRG7e3nBCjME/srQ7RHsf8eDz60qVOFeXx/S4Hx6pesjtPSOP36w/HUJZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757018; c=relaxed/simple;
	bh=GjjKbj2eMKib9fii55/oGGua/QWseNP2e4IOs8NJO+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXVHECwNjT64o1Zykxz4V739WdMTJ/U8tcVgQUKb/YOc1SI7giwRFyVnqyc5kHTmkgbJ9UqPFi1qWNPn+pu+ckp54AokOn8slFRGT9lJXqjVtpMLEn859B+/Q0WChCKFmoPJhjWez9HcBbLuLAkwzDlIM9UylGW0QbqkOaYiqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LjpUCU2t; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47114a40161so399935e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761757015; x=1762361815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yIJ3dMVPQRqYkVtVVJ+BHYPuM04KT3nCIS1A9DH47jI=;
        b=LjpUCU2tMubizYO6pPOruT+rbPMlSBFPzpUdxk6Zytz0A/6Rku7mtklch/1YR2gQl3
         2VfyF7b3eb8ulJwkpy7IvCG2NCe+HbwONEwD3H2BvlhfFALJngOKapgTraLTGuUGhXAV
         ox+I9IYhDcgS90wjJOlUx1f4Axt+gKbmlfDcdnmw+glSJvsZD5wr2eMdM5qOdOoAk+iD
         I6scIMZ1/r67n+/bHPKaY6CGPN1CG7T/FceMpUZzprSNJNVK/jUcQcHLOXZrm6jQCvgy
         xQ572eB96gQCX1+kn+2vK/FKR7itHD/cjDynxlJx89Zr4udXWurF9ueC6YylHeKyZghl
         +DZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761757015; x=1762361815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIJ3dMVPQRqYkVtVVJ+BHYPuM04KT3nCIS1A9DH47jI=;
        b=JZLr7AHxKOh0ZUSuLiFIEjiKEwIBxoGDl8dXMCNwXjVgrClOby2sqK5j7qsw4lJ4/U
         pcsF80PGJN41pUfL77ZRh3YY6OMS78hMjk48pX1BU9qsX03urX7RNeZA9P5ra/NOL6qI
         LDUiyhT+biq3szF7PPb4ype+KpVjpPFX4SPgz5qd5UdlTzbOqjBsAH1hWKhNonYvWFjH
         9zSg4zSc3Wk8M+F7sUYDedyPbglFDooVXnfED36mEJm6Y6ScgHj3N+iRVenwUPCUVOTI
         rP5byUXGQW57o27w0j7/I1d+C5OrGgnw1OVESgTv2TEifoIQtRxuMS+8ynAqMsmSfCHw
         vDYA==
X-Gm-Message-State: AOJu0Ywwga+zKqr7/ucHG615EdtXsMxrzypNcj72BBWF88bxFpofYGGY
	QflVLc9ykg5boYX3Xtba2Zi33yJg5GFsiaHVeqPS971iGviHMU+/ujDLgSWkfGxsbb7HHabDdX2
	slMMF
X-Gm-Gg: ASbGnctBzaphcOBGM2Zy/4Zv3SVlGHGF0wC7hbmGcYUy0k4Kuw+pxGtp0h3TNjYcwlU
	gI8fZaiEA30OeLcKmt2qt5twJfF+EMA/BvvEJFT1w9uTe+nfYsDb9aRxAghE8tb4yzLcGLv0j7c
	cSluC0JPU91kZIfm1AKCHkvw3d0yVkRvbvzRxa1AHetmm7v1C7ptlw22SUhe1f+wx7kSy5j3QT1
	vcS9rUBbwXOFVPfM390h53kE+dVWWmqVN0ZHrN4Xfj4i41PnKwkroZAjNoieQJQGADZwO4rsyLS
	boirwpBvu14FuWh17Iz4JnQGpqas7HBBGMIJIvhEMDcusdOtAGTHMNB8XbciAAw+n5Ts398ELMZ
	XwSDY669bF87jumhceQ1L198zm2NVLSVQKbVL4NrzdYY7EJSLGO8sm7OsixE+UXPqtqdbula1Xu
	+dxRLmsYeesK/7HqmuBRWFlXY53A==
X-Google-Smtp-Source: AGHT+IFYqJFZsAhoFPyNU3nEUwUIKl624El6R6Na+elRr4qSnpCFvVFBM9qNlTlmde2qxGHGbegNmg==
X-Received: by 2002:a05:600c:34cd:b0:46e:5b74:4858 with SMTP id 5b1f17b1804b1-4771e34a909mr37714225e9.13.1761757014626;
        Wed, 29 Oct 2025 09:56:54 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47718fc0335sm48393845e9.2.2025.10.29.09.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:56:54 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>
Subject: [PATCH v2 0/2] replace system_unbound_wq and system_wq with the new wqs
Date: Wed, 29 Oct 2025 17:56:40 +0100
Message-ID: <20251029165642.364488-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1-2] Replace uses of system_wq and system_unbound_wq

    system_wq is a per-CPU workqueue, but his name is not clear.
    system_unbound_wq is to be used when locality is not required.

    Because of that, system_wq has been replaced with system_percpu_wq, and
    system_unbound_wq has been replaced with system_dfl_wq.


Thanks!

---
Changes in v2:
- Fixed warning about length of lines

- Fixed typo in the cover letter

Marco Crivellari (2):
  accel/ivpu: replace use of system_unbound_wq with system_dfl_wq
  accel/ivpu: replace use of system_wq with system_percpu_wq

 drivers/accel/ivpu/ivpu_hw_btrs.c | 2 +-
 drivers/accel/ivpu/ivpu_ipc.c     | 2 +-
 drivers/accel/ivpu/ivpu_job.c     | 2 +-
 drivers/accel/ivpu/ivpu_mmu.c     | 2 +-
 drivers/accel/ivpu/ivpu_pm.c      | 5 +++--
 5 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.51.0


