Return-Path: <linux-kernel+bounces-795550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44B4B3F447
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFD716AF5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E70231827;
	Tue,  2 Sep 2025 05:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZPMMJVl"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDA654652
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756790178; cv=none; b=ZvdVSbXpflQBxLCIOIw5ywpBtm0XqXUjJQaYBXtCHv3kgdb7nck0v02zRHTOCri29UnGsTkei3AD7CtBEkUMq7YZ4Ddvb06StQewBobSmOWMv0Kb9zevVzAd5QSW5xJsx9E3kFGGbZhSU8Z0Et9okm2oEMGigI6BR6vTqDSRMus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756790178; c=relaxed/simple;
	bh=f1xIhlsv101mj5R5vs1LsSQsMLbJyoaIR8PLyDi5Cvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2tqQ6uYujdXcg6AEPqfF3WPrpWuO79biVJUo+s1VFQ+ZqK1fU0lzGzS+Utzoro8uuHPR6wrF4NkjbJ7S/9zDzvuYKtQRzqg54+zP/ehr+cJhBPqo3+sPoiuIRGbg+bKf9H8f8DcD0aAqcg7BB/8bs21cZhC51vv2j/sW8foM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZPMMJVl; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e09f58so5272487a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 22:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756790176; x=1757394976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1xIhlsv101mj5R5vs1LsSQsMLbJyoaIR8PLyDi5Cvo=;
        b=iZPMMJVl4GzAD5tG+xrQLPeXwnA4clGriAgz1QdttMdHDou7A4TSgcj/jWtZC3DCV6
         1OrP2t3Hy9v0btRfmYj/+YIXlI1EZBY3lCNdFYsLrZtYhdAg0sW6U5Ou5af+S8Xo1zls
         Sshveb3ogJSm8Yd00G7gU7SlzhFpEdvHYQKOq+vOtpTRaMsDjMfXSbDdY7CuYySY1BEM
         PRPRaU1210HRdBLInT12vSV9M/BAbJb2B3OPEaOUkx+HzrHcYLBFkMhBmEi+ILwfXDRS
         IIPaDf9O71juMrNYaUFMG1y5epiML49sZCoML6K6ymJpIvuu+pJuav3WHSI3sQqCI0ge
         SRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756790176; x=1757394976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1xIhlsv101mj5R5vs1LsSQsMLbJyoaIR8PLyDi5Cvo=;
        b=Rl/5K6y2ZoVGpMitWFxBgzwNUZfHPP/yo+piXoRoyUz3ostdwrRpwwfPxOLMlwZKJB
         nmSoax5yvZw1Zbdfw5g9uYzzr3orK70gAn0znfjBbVfxiROC6BZuvAw6CTjYwcUUK8J3
         xhnSuF5eCgkKzYI2AQLo6h+aS56yuJhBL1FM4vmYdscZObv2A5fBN06/pdp63f7wMJCK
         kQZDuzxFGpMYo9r7CZQHwL40bhcqbh7rp1Db86MjROZYxdCdwyevP2e/ky8OCEHuRHan
         VmO0fFtSeJIKpLF3cezgjUxalleLmS/GxLiixGiTYA1HtXCTwkl1eKooLCbXoRbFMJpW
         P53Q==
X-Forwarded-Encrypted: i=1; AJvYcCWalPrhN1ZiCd6lJrL/L8l+e9QL5c5kitRN5KlqUsjzDz2ttm9Fp1ZvUzT+JwW2Dpf6AYWqd/OCmJzUzQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYciz1kHrUoX6svZV92c/oop/93Z7+F1IwQQAK/LLn4V8x639x
	Pw82jK+6EcPjzlngsJk5P4y0aQwD8Uk2KEFR7Geee5gKDabKbpSWmoK9
X-Gm-Gg: ASbGncu3h8gOhik7VNjmB/4zqfT4pqNeu8s2zkif09KgxhF6HY22sUxFMzrFv5fItHr
	DtGigWVGwU0DEgmDQKk+yX6XMNRul6bUJAClBT2d2BoU/hUle4r5eeAc6WGBE3k2Dpi3+Cb+cmf
	D5MMcrn/lvzzsbb21zOIuBWUbTGCwfG7PFrcGJNjtvKqumwxQ2xWzxDOZotBUoUzjoeZ9ZtKnok
	JlxbMbTZGgEAP/e4I4LEyMnfFN8cZzJxkmwTjed/vlRNPxOQ6qi9LRABdikGahMeNG+C/7SPGHR
	C1VJP6LTf8Bf3oRw2oHwp113jggv7fAHrZIiQM7xVzaDqpni0NZx0R/jbB7Lbj/vpwC+/9HAMl7
	EKCtZ7SsQRiie69dIIo+22aK1x5OxyAg=
X-Google-Smtp-Source: AGHT+IFTBKGhDyH10mh3iI5WYjDTDthO9DtEGaeWpsAN+Waoz7OaW3kmYy4/VROij1U4dxWNXBOBgA==
X-Received: by 2002:a17:90b:1e12:b0:31e:cc6b:320f with SMTP id 98e67ed59e1d1-32815412adcmr10896015a91.5.1756790176380;
        Mon, 01 Sep 2025 22:16:16 -0700 (PDT)
Received: from hygon.. ([106.120.127.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f80181dacsm4336458a12.40.2025.09.01.22.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 22:16:16 -0700 (PDT)
From: Tingyin Duan <tingyin.duan@gmail.com>
To: yu.c.chen@intel.com
Cc: aubrey.li@intel.com,
	bsegall@google.com,
	cyy@cyyself.name,
	dietmar.eggemann@arm.com,
	gautham.shenoy@amd.com,
	hdanton@sina.com,
	jianyong.wu@outlook.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	len.brown@intel.com,
	libo.chen@oracle.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sshegde@linux.ibm.com,
	tim.c.chen@linux.intel.com,
	tingyin.duan@gmail.com,
	vernhao@tencent.com,
	vincent.guittot@linaro.org,
	vineethr@linux.ibm.com,
	vschneid@redhat.com,
	yu.chen.surf@gmail.com,
	zhao1.liu@intel.com
Subject: Re: [RFC PATCH v4 25/28] sched: Skip cache aware scheduling if the process has many active threads
Date: Tue,  2 Sep 2025 13:16:08 +0800
Message-ID: <20250902051608.4733-1-tingyin.duan@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <463bc54a283c1b908ea286ce67f301e2d1d39ea1.1754712565.git.tim.c.chen@linux.intel.com>
References: <463bc54a283c1b908ea286ce67f301e2d1d39ea1.1754712565.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several different test cases with mysql and sysbench shows that this patch causes about 10% performance regressions on my computer with 256 cores. Perf-top shows exceed_llc_nr is high. Could you help to address this problems ?

