Return-Path: <linux-kernel+bounces-888347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D447C3A95E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2DA46245E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ED230E834;
	Thu,  6 Nov 2025 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SqBftk1V"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A42130DD20
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428322; cv=none; b=r6wJmp3ynbKJbuQwkwbhFd6Opl32QZEbhBhnHrpB0e+KOFCtWqdlLOWRgQzfNM/vBE1ULkAx+JyEHzZFQJ6EoER4eti7UQ0xEFlz8GIzRbA/EHHZBnRDYAWOvtsnJCLdKC7kS5jfoM7wD+GtKebtTdWJ4tVyXGT/8K1ZxD4JmQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428322; c=relaxed/simple;
	bh=yflAE0IohrHMPff4q5CRSpNWbs6XScZWnLpg5OWbzEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cd67naR5N6aFIVbSWtCIc+ed8ke7hpi/AqrQK2BF6mBeMl+Qs7xonkAxnho0Me3xWhXKeUCKS6BOul8WYIi8gWVvNWImo3CzwfdRoOueAEasaRUSmaGBv08weJ86nwrEeTdF/Vk9fCyt7S13L5tZJ9W184KyybKl1i9DLODuKIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SqBftk1V; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3418ad69672so651952a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762428320; x=1763033120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yflAE0IohrHMPff4q5CRSpNWbs6XScZWnLpg5OWbzEc=;
        b=SqBftk1VFHHZHfp/VnIy3X46R3abbKUY6BWwAXtYNy754D7vxpId/ibTOivBhJT67W
         pUdc/vhslqtajIs+sS7TL6ilwpOW4uBsnGn17nihY5gVYwgOhATbdYiA/uaTh8qKWpsj
         xp44K0oUEjw3pN7InI8c9lv/sq0/K9qZRCCP5idp3rJ2z9owL5ix0j6/juod/ozLCYEp
         4UYilRe11c9n3hg6z4WX3AEuXSJb7MWglqeDtQDlg0AEBFfnZ+TwsC31pr4rQD2+Tv1D
         He/JRg5Qwx6Kbcw2W0zV357vsNsGkYGyjAG/A8WKiyKmPTl6nph4/Mj17hfckOyVtJlc
         /U3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428320; x=1763033120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yflAE0IohrHMPff4q5CRSpNWbs6XScZWnLpg5OWbzEc=;
        b=gNn4KCzJF62PMIuefATPUw+rKSRT3ApWq3wzr7AG+TPr7sIZMBe4ieHBGljt2Dq26x
         GcOoCjeh8F9cXhtz5GA/7lGbzFzpTljdG1Fq1LyadQLj6USAz8CowVdfY0W5CkZiMFoj
         KsiLua/g8OhQ5QP1R3ym7Gya23IPzcfWoTjLVK/eRzh7ADQlTd8RmbrpW9srs0LbHtdS
         L2GsRErh8r1q06/Zf7XJicbE06Esx07d+WyVLA/rVSSs/LIZj0uatG909QNWZy+eNtnW
         0eQq/ytkOcW+Tyf0afd5fD4XGDFyhKXBp+YkLbFJD4YlFIVXaMRnFTJ6ljqbcCrpdXAL
         ANXg==
X-Forwarded-Encrypted: i=1; AJvYcCUFbSEjGhNh/pmRyXLWASqJy7/HQPZwmG6jBUFlUToXDj40iTHg6391VXBbJmJX/w61XW+nglUfX2dd0h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqt3d+Z7S6qwVGSdpFEWPYtWBroOoTj2+dd46crjAlk9151i0
	dSWnoEP7HW6BZG8mqiiu0gPPsvL75ldX/qy18KSZIaL62A9B/eHVoMqhmvHyBoLvpQ==
X-Gm-Gg: ASbGncvi3KS1zMv04qHAr2UKr2mNJAFRWcQ0yMGMrJjx5nYsyhWpOChYcDCMKV6egYr
	gJwDAA/zCRnsMerABCpSBHgoYN72/T/qAXpsbBd8H7OzyUyWzutSJE9A8psWOXMEIGQUstvCuZS
	Wt1NQZXhzVJi9Xk8azI14s1n6mnphnQor9d6FN1w940SWhOyjBWMZMlAbI0q4+qGnjuvzVDowmG
	LoCb3LIwz4PAdA2fQ52t9VrQBsFQxjXrtHNqBCT5ryzGLUsq0646NpX7d/6KVfWYjGF98pcx1CS
	80BeIElWbnlPbR9BD8pqvLMvcy0Z0CSBolTWxv2/PtHzgGDLngAyYYSp6RRN+qISm4wQs0K3+QN
	jBTYmb30iwErkPKL3rrh/olengM9odphYPMhLBV2byTcLAjOI2U2HRtacvH1vF9XS8x9zp3HjP7
	fkFMbuAtqqv5CCg7kZep65sSr3U1KoywQ=
X-Google-Smtp-Source: AGHT+IGu1haJpE0XfBd6Kafz5MUEUUFB8STfx5OylqtQQ3p8U6kY8U+a9xayUjJC6pn8gVDj4E2G7Q==
X-Received: by 2002:a17:903:41cf:b0:295:3d5d:fe57 with SMTP id d9443c01a7336-2962ad2add3mr96789755ad.21.1762428319699;
        Thu, 06 Nov 2025 03:25:19 -0800 (PST)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5c71dsm25377235ad.31.2025.11.06.03.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:25:19 -0800 (PST)
Date: Thu, 6 Nov 2025 19:25:00 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Benjamin Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Hao Jia <jiahao.kernel@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3] sched/fair: Prevent cfs_rq from being unthrottled
 with zero runtime_remaining
Message-ID: <20251106112500.GA471@bytedance>
References: <20251030032755.560-1-ziqianlu@bytedance.com>
 <xm26346sjh47.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26346sjh47.fsf@google.com>

On Wed, Nov 05, 2025 at 01:37:28PM -0800, Benjamin Segall wrote:
... ...
> Reviewed-By: Benjamin Segall <bsegall@google.com>

Thank you Ben.

Hi Peter,

Do you have any other comments about this patch? Or do I need to send an
updated version with all the tags collected? Thanks.

