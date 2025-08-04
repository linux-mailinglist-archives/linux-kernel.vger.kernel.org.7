Return-Path: <linux-kernel+bounces-755577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC331B1A8A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BFA18A1840
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5171D21D3CA;
	Mon,  4 Aug 2025 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLTw7Gfy"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF986359
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328754; cv=none; b=LoXY8CeTPplurdsvj4TIXbzL7PWuD4A5dBvzNolHvi4iX/b3BlIzKo4VYWXcLy++Br3PbLe+BAULs58Ij549XimVbw3iFFu89z9wshD4+GBD7Nb8sx4ZEApDkkHWrKBeedf7agTaPLGaESutOZKMyG1cx9uuKvjiBMZ8xfC6kis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328754; c=relaxed/simple;
	bh=6omrky32C6lrFTbeVuU07023mfEqWFh51fbWb7R4jZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gKfLaunlj9aiQeALx6wV3OXQNJKznFHzZCXFIqVwa66muFktplRL1xgbaQcfgPoODyDU3Wlcwa+bZQSyp3eREFiF/tz1r3u7r6tsYLLPaTYvJzs5pf/cKWiTkfRNXAUNF2vV4y/J0vc14V+Sw+bXVZq6ne7IEjF57NItBQqSxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--paullawrence.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLTw7Gfy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--paullawrence.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3f38d3cabeso3145344a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754328753; x=1754933553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1hbEV+wQKYZ91CYnEdmqqYZVyEmSUGWyP+ffm9T6J8=;
        b=vLTw7GfyD04va9AtoMAVTpxnn37hBwzX+zVKGRNAJleioTa5pYfgN8DsvYJ6M7HbvY
         e08ST6di7CvjTGt6ZOu8CkOVDQgxyc9lIQOxWQli0YCMMlInkdfTsgjs3eJ45w9tGIMN
         YOjCXl4OfOeem5detjjxPz0g2t+lMg3ja+JR4N7lEnDg4IdtJh8Ai5CqOG/yJJ3fj9Sr
         H43jvBoNZFwWtV19b2m+FoX4EJIOGXv2glEnzHyTTDlsDts60A9Vn7DPMs5I1fpr4/AG
         QGvKpxoyXsThIeQG/fq9IAyReEQZrHZH1TXyHepXX4rB2Fx9PbfUrhvwN5g/3jC9oHZ5
         BM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754328753; x=1754933553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1hbEV+wQKYZ91CYnEdmqqYZVyEmSUGWyP+ffm9T6J8=;
        b=XB9nw+Zpgf03yE5bki5q1IcAWkOjV+es3NFJeSgGbdb4k8HWvY4d/fSzQ311Uon0Lb
         vCuh/wgqbC0q7GPtvaS4hF6atQF0UdBWYSLrLRytnldw4KqZQiHB9daTWn6p1bkg35Si
         WTFduPhp+rpuHoQhWrPcri14HadkabntGVRYH3WYIriZ2y3RDgwCcWQjzigm+FTgYKRb
         DriYaaVpTkmVS9+bJ3+u0VAGCL+D+xAhyzmDJzLlTJ16vF1ao1wi6g7KqqHnRcfYemVi
         Rz02BMYyuWOux68iTlwA0PzcWEwUtCvQ1z7OQJVcmf9vMC3dy+C/a8rghJDr2QYETHig
         VW1g==
X-Forwarded-Encrypted: i=1; AJvYcCUnIPlTGWapQHlt2b0PrecmnQHEm2RnhTicA3SzCZtzTmGk3DUr+/57QEL7eC6FEcD95WXnmLTtw5ob5h8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKuriPEUWHb7UHWCBCC2KqiBZpkyufbW4weZ+fvZjp7Ypm3olr
	aBKqLphj7RIm21YCeD/E4qMPUcJF3zDo+z8CHHxLetz1DSpKtM532v13lv1Am7VANMJmMkUQmGl
	8iPNHqiVDADF5uf/hKznxAyP+ecBTXw==
X-Google-Smtp-Source: AGHT+IG1Pt6ujaMG+SQxGxkhlNtNdzUak3p7dhUL29RUZrlLA0K8t6YWgUS3XDJz7oEgP1LT/PGOceeopw4/IKy7z2c=
X-Received: from pfblm18.prod.google.com ([2002:a05:6a00:3c92:b0:746:1931:952a])
 (user=paullawrence job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3297:b0:23d:dad9:50d1 with SMTP id adf61e73a8af0-23df8f94a3cmr15663166637.7.1754328752641;
 Mon, 04 Aug 2025 10:32:32 -0700 (PDT)
Date: Mon,  4 Aug 2025 10:32:26 -0700
In-Reply-To: <CAOQ4uxhmA862ZPAXd=g3vKJAvwAdobAnB--7MqHV87Vmh0USFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAOQ4uxhmA862ZPAXd=g3vKJAvwAdobAnB--7MqHV87Vmh0USFw@mail.gmail.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804173228.1990317-1-paullawrence@google.com>
Subject: [PATCH 0/2] RFC: Set backing file at lookup
From: Paul Lawrence <paullawrence@google.com>
To: amir73il@gmail.com
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, paullawrence@google.com
Content-Type: text/plain; charset="UTF-8"

Based on our discussion, I put together two simple patches.

The first adds an optional extra parameter to FUSE_LOOKUP outargs. This allows
the daemon to set a backing file at lookup time on a successful lookup.

I then looked at which opcodes do not require a file handle. The simplest seem
to be FUSE_MKDIR and FUSE_RMDIR. So I implemented passthrough handling for these
opcodes in the second patch.

Both patches sit on top of Amir's tree at:

https://github.com/amir73il/linux/commit/ceaf7f16452f6aaf7993279b1c10e727d6bf6a32

Thoughts?

Paul

Paul Lawrence (2):
  fuse: Allow backing file to be set at lookup (WIP)
  fuse: Add passthrough for mkdir and rmdir (WIP)

 fs/fuse/dir.c             | 31 +++++++++++++---
 fs/fuse/fuse_i.h          | 14 ++++++-
 fs/fuse/iomode.c          | 41 ++++++++++++++++++--
 fs/fuse/passthrough.c     | 78 ++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/fuse.h |  6 +++
 5 files changed, 150 insertions(+), 20 deletions(-)

-- 
2.50.1.565.gc32cd1483b-goog


