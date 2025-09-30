Return-Path: <linux-kernel+bounces-838229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E773BAEBCD
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 01:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F543BAFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843492D0C99;
	Tue, 30 Sep 2025 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMSepwig"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F32D1913
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759273880; cv=none; b=tGneJZS08mr4G9OYORX6Cu7aw5L05HdypYK+oUrFjK1Dx5VdEhV+SYo3n2Tnnk/YsEknRTAL4GFEeNp1d/VvQjARV9z5RRloK/p+x/p60XanK0gK3XGwq18liXj+hCMJvKv2JQel9oiLIOsXqDJY4SOZYhZ1fRB45HaZv/D7+hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759273880; c=relaxed/simple;
	bh=I2oehnwu1ZtZ2nSZQReIFluTy9eO0ldlfcJOha47UgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGIa/oFhHPKAGwpvYbwboyNfIDWjrHeb2pnCbBOY/a1K5ace+HbF07gJIifgMXtIxLhRPsy3lCTuaRFyS8TIygpOD4lKzaSS1R9CU/1jZV9kNB3a1+ES0GH4PcEXEMCo9ZLCYPSMV3sIFZZWOYQs/2iApALQjhyIyJmAkWDpCLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMSepwig; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so416617b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759273878; x=1759878678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoQEcly9HBRRvRyEJZ3tin9hqwMJQKfC7mBPShQ6syA=;
        b=KMSepwigWU3Ka6NJzv5k9sNnllmbwfzq721FH1PhCMMkszmqa+bbP3zpTabBkKUsCf
         CG174baV40c5TSLWwcLmB/zCpM14W8rPqsgElEu7otmcP5GO6lPVnA691amXVo5u01HD
         taytt3Luf9siDUbl5u6XiEn0U4PLH1MVIrJVnChtEFnYZLdClzl5fosqe13Al3mApHam
         gmjo4Zz4ViYPzCAiT6SQYlyjXa8P/s/hMEOwOpXfZNWR/r5SoWhiyUtdKLsdEbXFiAER
         uw3FfVQFLbLfXQLU0e9PWoxWmuDFpO8leLYwfKzOfAvkhgJ6mlcmPfkx0/Og4iiZQwLN
         yf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759273878; x=1759878678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoQEcly9HBRRvRyEJZ3tin9hqwMJQKfC7mBPShQ6syA=;
        b=TVXAVE6G3X0TiZDeWTmvrM/zLOx+G6B6ro2LF/D+WFTHanf20S3sqoXraNb9WeJz7S
         bkLUOWqODPOf5MIepwo8X6jL333+RHN6HWKZSE+kfpbwhmHukyLjfYYQc8gjtO4ERxAf
         I3szyVins7y2aHm2pl18oNd/xWM8bj6K3CGODkXMPomBN9En5PXNEqCI+IjOe+ALquoi
         F7rHwsmEGwvRyFVnzaCSt9XKPSBk5maHJmCMsl9tTTWO2gHr2I4RWzEe8Oq0NwOhe/Y3
         I2X413lGOew7vFXJJjCkXvaMLLD5mXO9XaDTSG6eayS8I1roq4cl0UZfpt+8AEt5bRv7
         Wy+g==
X-Forwarded-Encrypted: i=1; AJvYcCX/asm/nlorOjIbQBPGbnnSsP9qF+u2K5/LbHuq3Yxi+KoEildi2UOGPxSHPd8ytKFEawSZw/e52r/2K4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+US3NPSx1jq39OVxr7KHOSwBYONlLKNh65RDM2mGoQL0/9+0
	rrACBtJCCpgs5yKz4cAE1tvy78AIwfXgZt1eaX6VV4pGlR0/y46WIEMA
X-Gm-Gg: ASbGncsVjXv9YDuRxxS4u73+OIJIuYjrr7YuI0zPvr3/R7NdKs1A4BJYdoJTdLUFZle
	XfduD3LO1iL6h56Lzt57/tqKGe/CRfqMIPZollbiwi+SmO62GCc1qh+fdggEwAknC/Z9eb3EHmU
	eo4ZLJ4fkpIIhUc2x+vERuq+91eOPE5DMD2f8T3d1QBWRN4l965jNadvkBwj9Mb9Rui3PrFv0xl
	bVYTOFv+wr22hq3wdNGvBWWORdIKqMOCscXZ8gttUjfxFNtH8938t8uaKYQq2QWOMSaTG44a1Qg
	e2IsJXNRNyHbNjPx2411avGqOB9jCCgOMSjB6Hsqk88j78/IQs+7+ck7LEXUHvOfSsshIxMaceb
	/wQrjf3ObdgqRdHntmnhyRoM8ZXZx
X-Google-Smtp-Source: AGHT+IF+nweCrMiUJcE3jpyOpnOZrJlJow1aPBjVGke+YDbBefAorJadxVH1HjNckfU28LnGL5Fy+g==
X-Received: by 2002:a05:6a20:4326:b0:278:bc13:d83e with SMTP id adf61e73a8af0-3218dae950bmr1904270637.11.1759273877643;
        Tue, 30 Sep 2025 16:11:17 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::55b7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b274dasm15009804b3a.63.2025.09.30.16.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 16:11:17 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: irogers@google.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	collin.funk1@gmail.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	ravi.bangoria@amd.com
Subject: Re: [PATCH v1 1/2] perf test: Add an 'import perf' test shell script
Date: Tue, 30 Sep 2025 16:10:57 -0700
Message-ID: <20250930231100.197258-1-collin.funk1@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903184248.695267-1-irogers@google.com>
References: <20250903184248.695267-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ian Rogers <irogers@google.com> wrote:

> The 'import perf' test needs to set up a path to the python module as
> well as to know the python command to invoke. These are hard coded at
> build time to be build a directory and the python used in the build,
> which is less than desirable. Avoid the hard coded values by reusing
> the existing shell script python setup and determine a potential built
> python module via the path of the perf executable.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/python-use.sh | 36 ++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100755 tools/perf/tests/shell/python-use.sh

Aside from avoiding hard coded build directories, this also looks much cleaner to me.

Reviewed-by Collin Funk <collin.funk1@gmail.com>

Collin

