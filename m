Return-Path: <linux-kernel+bounces-880015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3217C24A90
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B6D189D7FA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A8A343D69;
	Fri, 31 Oct 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dh5svi1g"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE553195E9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908397; cv=none; b=M8Abv2NE3EDdMW2UNGxjhdgduSlrvxliGjZu0i9zkonWeUN7ngrVTMzUTlZN0v1CN2+HIHz7vgIkcNcYesI16on2d8/nzgU5rUDcAzO/C0J8So9U/AVWCKOU5TfpOBRinCNYAWlbOj2uCXLXvpNW+ME3KW5G5fi8XYDq6uN8Fig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908397; c=relaxed/simple;
	bh=qiIhi6wVU1hz2HJYvxU3S3tnFXVAiM5qPta0gYT5p1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tpvoGRfJ82aNt9DDxdB/+X8vFSntmtbcB3cOqw+z7MUPe3YExE5y47yE6zVy8CrPaQ/hpAkW0KZan+rBKGNoK7TdaZNb/dAo33o8TuK3SmIpjV+m7LVXxK5WNyZprtf+HHUbP9YxhEr1hpLGVVRpQcz7UfeWb9p+QG+4Bcd7qmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dh5svi1g; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429c48e05aeso154266f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761908393; x=1762513193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b6vAaaeToiu5B9u+qUVaFIcSktlAlQtEv6NbG1yx7d0=;
        b=Dh5svi1gMcXsXzpGWpPRwwblpINeVYzUiVMMCtJCkz57xZz0Gm5bJx3DUcwFNb07cU
         plXKpHCwWtprc2cLynonSI0ssJQ2Q8K3yAmun+VXHOyYK16vdEoKKX3OxLjGmaRUl3md
         VGjqbQfo49gb0EPs1XZlkegVnbifJDXCPxKLtDjk3b5kCRvWMrHCDVOHf5uc7OZygYbO
         oFm8Zvfjw/fzXvb4IraqW8Ro0YcPJXYLnCboGOAsG6vDbRkpBvj1iDJTF5t+Boei1J8z
         4ql4HH0fZVrIrNUx5+bpvstsnmx1icp+CwKtVdVqfP0RaEwJKDVto18aECOLKSvsZWRh
         42Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761908393; x=1762513193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6vAaaeToiu5B9u+qUVaFIcSktlAlQtEv6NbG1yx7d0=;
        b=Nz5piuyOWawlwX5LD90pugRkHC4yhuTkvzfuawQ2X7lWBbMYhbR30sOkzloH5dfo2/
         sK//9m9VLWgvI9qx71Jck4UI5HJdMvkB0z/S+CrFuerJlhzJrl2ZqT3UJfUnYuuw6YQM
         Qvge//TFd5PEYiztUhWbsh91MtbiGG9xOoJuYAF7AbIJuESEs0VQUI0fwoJJLeG5Q5rR
         E4KspLipYmyc672e8eH/BY3ITOzSuytyoDMVzvjrhMiUptYdr7CHY0Dd2J3oAi8xdA6l
         dt02OijqzyYb6VqqO6f64WeDSurifw2bOLUSWJoY0YSViabS7AMpTaSciINGvihFIIRw
         AIbg==
X-Gm-Message-State: AOJu0Yzh3QiHl5LZH+8t/tauGMXlkuNp9qLlocWupItrSct3Skv59p0B
	mhTMt2ox1jfbeDnHQVDMJphrDhdoQ+EL9fXz7dBhKr3PiYuIbmPCpFSOj24laF7F94Kv2Bo/dLz
	JhuMs
X-Gm-Gg: ASbGncv61hctMQ/MatqnTUvOasys2qmfwFtz98xvMzxx+zuVL3hMK1HgnX7kg1cU56X
	nvsrmJmN6i6LD8IxkCkBklN0dD2QvoKn4uMuLa5UfsY8BWusRGwJJn/6Gyry406rPv5sdSywxGB
	bExB2zXZ9kO9SOPdepqdRnNLR5k5k9bvJwChLT68pcBu/UGLwKbUaamoBfOBCPRjG9Froy/imUt
	2aaMVHGFxKsexLxJ2FVfpUwdjZtCY5k+p8CM4Elf8WWxcKneMNU4mug68hWe4XRZe49MpruINE4
	EruAKoRF6FFoSWusZ4tcYHJJOmMGyBJaUvhfiVSLwHZhlRE7T/xTRuGDXJwrGZe43KC3gddJFh7
	wP6SyZlJa/5Te9XRWZ+5EWvCdXE735OuzFykGYfMTGqVWiQF2kOSlUlA5wX/TdFWWPT7wGE6GEP
	eotsrLeJuS1+tiKqo4Y+vTjah9jaK7HyptxzA=
X-Google-Smtp-Source: AGHT+IGyVj6dXJdOX2Hhg+vEPmOzJtfUWoV+ITI3sQ78WwjXbOn3KG8ZVtyP7HvSgwbXFsTDPGRjmA==
X-Received: by 2002:a05:6000:25c2:b0:429:b8c7:1848 with SMTP id ffacd0b85a97d-429bcd5c6ccmr2789802f8f.19.1761908393047;
        Fri, 31 Oct 2025 03:59:53 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c110035esm2965528f8f.6.2025.10.31.03.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:59:52 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/2] replace system_unbound_wq, added WQ_PERCPU to alloc_workqueue
Date: Fri, 31 Oct 2025 11:59:37 +0100
Message-ID: <20251031105939.129200-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

1) [P 1]  Replace uses of system_unbound_wq

    system_unbound_wq is to be used when locality is not required.

    Because of that, system_unbound_wq has been replaced with
	system_dfl_wq, to make sure this would be the default choice
	when locality is not important.

	system_dfl_wq behave like system_unbound_wq.

2) [P 2] WQ_PERCPU added to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

	The behavior is the same.

Thanks!


Marco Crivellari (2):
  drm/xe: replace use of system_unbound_wq with system_dfl_wq
  drm/xe: WQ_PERCPU added to alloc_workqueue users

 drivers/gpu/drm/xe/xe_devcoredump.c     | 2 +-
 drivers/gpu/drm/xe/xe_device.c          | 4 ++--
 drivers/gpu/drm/xe/xe_execlist.c        | 2 +-
 drivers/gpu/drm/xe/xe_ggtt.c            | 2 +-
 drivers/gpu/drm/xe/xe_guc_ct.c          | 4 ++--
 drivers/gpu/drm/xe/xe_hw_engine_group.c | 3 ++-
 drivers/gpu/drm/xe/xe_oa.c              | 2 +-
 drivers/gpu/drm/xe/xe_sriov.c           | 2 +-
 drivers/gpu/drm/xe/xe_vm.c              | 4 ++--
 9 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.51.0


