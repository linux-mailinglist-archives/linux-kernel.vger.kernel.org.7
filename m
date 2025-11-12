Return-Path: <linux-kernel+bounces-897381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AEFC52EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AFA5011F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F0128B4E2;
	Wed, 12 Nov 2025 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOF6yc45"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17997334C35
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957291; cv=none; b=txCj34ZC8IUs1w2uSJ/wdjZsQqrK9v1ft3XTomy/kb5D/N5EIjFHQAor6u7oA1+x5PSRIy0itIZffDiGyY0qSPYsLcSMUgLsl4egT5hX0JMdFlQarzpbMv4ZOEeaZjfIxXWYtWTrlMswvEV/zbnrBGqdOC0dJWNIWHyxKxJnfOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957291; c=relaxed/simple;
	bh=4Kk0Pp+oyCwvBc7QFBhUC7pOI+Xlm4LfKjXcpcFHM+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iBopxesQCNpO3BwJlPOshDtelLA2Y5C3OCwuYwzrrGG9EpAfylQa9RdQ3OivgWFzVHQ3B2wFs6ByXD3e8soofO8wOFv/ouyufVNZnm/uaTIlIVK6TRtshPoRrKBeMHQs2C1bd56BX1v0sGoX2hS8WoracgeHR33lrpnM6bsWLo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOF6yc45; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-295548467c7so10067765ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762957289; x=1763562089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6aIKYL3h7TEPkfgMqOOs4CW+bxa3dLyjG+Cts4zApM=;
        b=IOF6yc45CGHVll6i13RxaUkiZo0W5AjmXD5VM2AChzD81T2kZ8xsyM9VbIokEL9oUH
         ydbgKAE9WFu7DrP2nwSIn7fYYaCHtmqK10t0DnrSSx1HUCCzBBn/unj6+cVn6GJRtbyE
         ckpHsllqo4jh/hz6yT/lXNyzrtWrUwUetfeRY89Ir1dLIgBDLMOMv7e5+dYjlLx/CXG9
         QLCAINCnbSFaNORUjjpsHSK2uJMLYXr6wIL73c2wzVbdGgmNPy/dlhQZeqP5DvwmfB5G
         NklacGdrVA66x096jQdXbYS69iuRPsMIHV7uYoNaSMaJQAoigTKII+fJmJ17pVeozcnZ
         HqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762957289; x=1763562089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c6aIKYL3h7TEPkfgMqOOs4CW+bxa3dLyjG+Cts4zApM=;
        b=Ufg7kH4GcDZukcX/Vqls/XMmbntZhnHClJ5+YXGyr2QTEZ0VFzt2s2asq8vWKlBe34
         OtH86Ty/rjIzv6A+23necuKmLulru6P9jKrWuOL2aRqtyZXIteVc9BA3bWDmO1CEjem+
         lO5dsl3+F8Sz5joKVNYdh4C6qIA1hjsm383jKIu2iLdklReyXc9QUTXdu1XDscN9CWks
         CaeFMEAbo6CSu423PnQidHncmIAdF7ZKegBBExH6D9TPDpWl47GegVpZlOGj7E1QZPmY
         lcEjA+yGVam0b3vGabhKb09YwYDmzrfGJjTjLGIdCS5/4AUmthHr0UheC6kEQX5L7Vvk
         bCmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZLL5TUc+5XRn6rGhx1Yg0yI5z5BcrOxThzjl4R551Oo4+1nW7JFFccqErI6CdzLqmPS7qfhJFxNdRv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YystKtJtx5zk70bho0rbF7jPFBx9e3AfQ88D9gGzW2cKr7L/549
	zn6XYs4KYb3v4B9/OGelwYaOx5U5j/3HB0JfSBVxM/Whilg8VVb/bo0=
X-Gm-Gg: ASbGnct8x1sKUj1yyF2vwJCGgXYT2LCoOkdCLR0dTBc49bSKqP6T7gx8cLzaZKI2KCh
	tdyyv7IAtq37AbUt8YPbLwFO1WrkonmMTEpAV9xdjvXKKBh9IJb870B2sJTs7UioknMhWApVoXn
	fTkpYeWyGB2uxP14R5T80U1CTV2DYnpqnaUFRkhEv71jnxI66nxVPma49O8cCF/8OQ/ZolMSS3g
	Jqx5+gQZzxxJib1YJpJY5AsDqQzxMkBjl6IejBb4flhoz8jyCcOWJme1D0lISK5cthn0xSg7YL4
	oRmhtnb5tJ54OqfgLs9vg/6+3nEnXg7i+txpmafWS0xbtTZYQ2ZDOKuP6HwFykIVWZ9NaNup0Tj
	LaNUeFqUkw6xOPJbnKLB1tRSKe55TqsolLiPqF77f7c6qZ7ccLXIXXZ5Mot777SDmclL+Vukt1d
	kdWNTPfxsJhMuUqGmBQHsqKvPC8BUuMecsIbkdUmY=
X-Google-Smtp-Source: AGHT+IFb5IKVYywJ2wTpqfYM36tnRXN86Br+2/MojU2W4hRCNkjZz/A639w8i7TDIc2oPdeJ+TJbWw==
X-Received: by 2002:a17:903:3c27:b0:297:f527:a38f with SMTP id d9443c01a7336-2984ed35723mr42105695ad.18.1762957289302;
        Wed, 12 Nov 2025 06:21:29 -0800 (PST)
Received: from localhost.localdomain (173.242.118.39.16clouds.com. [173.242.118.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dca17ffsm33035385ad.71.2025.11.12.06.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:21:28 -0800 (PST)
From: Linwei Wang <wanix1988@gmail.com>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Linwei Wang <wanix1988@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: remove redundant se initialization in unthrottle_cfs_rq
Date: Wed, 12 Nov 2025 22:21:19 +0800
Message-Id: <20251112142119.375184-1-wanix1988@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CANCG0GdjAaXG5U=9etbC3qo5uY7fbpFTG_RqoKcgChVSrLOKWA@mail.gmail.com>
References: <CANCG0GdjAaXG5U=9etbC3qo5uY7fbpFTG_RqoKcgChVSrLOKWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Aaron,

Your commit 956dfda6a708 removes the duplicate assignment after the early
return, but still initializes 'se' at declaration:

  struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];

This initialization happens before the early return check at line 6036-6037,
so when runtime_remaining <= 0 causes an early return, the array access
is wasted.

My patch defers initialization until after the early return:

  - struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
  + struct sched_entity *se;
  ...
  + se = cfs_rq->tg->se[cpu_of(rq)];

Your commit fixes the duplicate assignment; mine optimizes the early return
path. They're independent optimizations.

Should I rebase on top of 956dfda6a708?

Thanks.


