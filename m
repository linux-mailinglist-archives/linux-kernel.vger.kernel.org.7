Return-Path: <linux-kernel+bounces-652919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71827ABB218
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 00:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF72B169F65
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 22:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28182063E7;
	Sun, 18 May 2025 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fT3uo6N0"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24C1CEADB
	for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606197; cv=none; b=M348PFwbp+xCKTnk6WHZZFSaS2c4EIA4i/gvsboVIE2MldIUOtWYWo+m1AJ/McFwVR/jfTVIcmhi0mL7Pt3IgIABPfgGI6/fCqtbEYtyVSkq6MxU3VsBjNm3he2xs2qU8pGa+KFF9oXqVeXfxJ082bDK6cfwMBwo1rq6BdunagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606197; c=relaxed/simple;
	bh=WUUkI/runPD4UYFAWLA4UTyBwT40Tgtc9DAcQ9wpeAs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m0AW2EjxjvpVoYl69AEc9d6mnuWKr/mCD8s5t4ZCZCUtYKN1SKAaYfiYciaTCDcM47lO2M//Sif2kloMhYqn17hoxbPE7vQGpQWSvnZwScUYLdeLOlGaRNU1iKmChXC5h3/WfbxNrLG3JDVl0y5pGPHPquGupaEFg/yk2ixQtDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fT3uo6N0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-232054aa634so9072325ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 15:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747606195; x=1748210995; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gfhLPxw+UZ1Sf6wlYpIDTg9JpsqEdC+eRzqAuOTaGg4=;
        b=fT3uo6N0ZQPyMUX5Oq+U2o5G/9C0QmdW8XvdejeAHu/7JF5df3it0uQJ1Glyo767bh
         9sxuPR+dsGFvcIUKROSEE16EejLsFQnVcgwwoQq0EN5aVOLwgn5HyH2/3l9j7oZmcwqi
         pb82bEdhwPUy8OYBpbhFqSsKcOWA5DjVahOM5c9aZwaF2GUR5jOH8zw/ygmZVHwSx0fy
         EMJcbdPt/YMymz1xRMzzQ/9uURStrDWe+HNpfdc9iLdErQbIL433KpsB1r4RP8dCv4EU
         I3S7rqZ0FiP5mpj3zSUnewcgrTULs+cigVm7dpV8IVgM+n3GYwKZ+jOL7ePQ1UxXBhsk
         kM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747606195; x=1748210995;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfhLPxw+UZ1Sf6wlYpIDTg9JpsqEdC+eRzqAuOTaGg4=;
        b=M4nwjB30Mi/ju+HjLScxQ9TrebuBTKKeddtDRwDDrUDpPjgA98ZHuUrNYvPi8eD/Zo
         1Iuki2C29+g0Aw1AAB5B8N+VtPbLikUkTCiWN53iFAwnRWCJc3YaNv0lVhd6le2ys4Lm
         CiViOBtppFVyyILGKqwjiV9Ur07EqGK9WFv84wd4RDvqqrzGSwtXPrQDmWV1hrpbaaul
         APSTC1+b4A4rAQjikLXVVhhB24kwF4Q9Zg4iUXhzuahZMfEWAprhs7N8f9bi/aJKzF7E
         99qEaesb3X3p+R9m/CUagBQSR8GAvFV2FvStifFpyBWYRcczmSPS+g6+Mvh2XsNQV+1B
         be5A==
X-Forwarded-Encrypted: i=1; AJvYcCV5zuF7pYsr5lJrPlW3w4BJV/KDNR1QVhBqvtX+vzr3xV+1Yu7prWFWf0uZeG8zLM7S6LuYfuoQ+2XWE6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgJhAjUTuF+bwFm/nixIiDmhoS8wVJ5tEEzQFJmvKkEwQSO3pq
	njl53eMZkI0Cex13NYA2KfihFZo4aPRan1ekiMNT3t0kUKUn0vcMbLLpqxj/5u7I7eT12j0r4bu
	9nArOH2mWVXkE3CvLRYV0+g==
X-Google-Smtp-Source: AGHT+IE/fmUAhEdNDzUegq5lLa6Q8dX9Z5TuEMtadBh3S+h8FbzaC55CAiy3l07PTwJodpEclNws7FtKjuJY56b/
X-Received: from plrj4.prod.google.com ([2002:a17:903:284:b0:22e:327e:32c8])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f44:b0:223:88af:2c30 with SMTP id d9443c01a7336-231de30281bmr131476915ad.16.1747606195043;
 Sun, 18 May 2025 15:09:55 -0700 (PDT)
Date: Sun, 18 May 2025 15:09:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <cover.1747605658.git.ericflorin@google.com>
Subject: [PATCH 0/2] staging: sm750fb: style cleanup in `lynx_accel`
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

This set of patches covers two style cleanups in `struct lynx_accel`
defined in `drivers/staging/sm750fb/sm750.h`.

PATCH #1: rename `dprBase` to `dpr_base`
PATCH #2: rename `dpPortBase` to `dp_port_base`

Eric Florin (2):
  staging: sm750fb: rename dprBase to dpr_base
  staging: sm750fb: rename dpPortBase in lynx_accel

 drivers/staging/sm750fb/sm750.h       | 4 ++--
 drivers/staging/sm750fb/sm750_accel.c | 6 +++---
 drivers/staging/sm750fb/sm750_hw.c    | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.49.0.1112.g889b7c5bd8-goog


