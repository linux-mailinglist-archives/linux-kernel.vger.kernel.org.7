Return-Path: <linux-kernel+bounces-755063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE62B1A0C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C8D16A66A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DE9254846;
	Mon,  4 Aug 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TjfzDCea"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3198253F11
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754308585; cv=none; b=L+qfnbNCiy1aGZd/KXdzZOQ5nmTk79vaqNXmxN9+TmGuX6oLkDOqkmAyx2wqi2M60O9BHCDPhFALWFsbs6YF/BcWCx69kRBqrDhKhxASTGDQOJo2OynjeByB8t3+bcPIiImiJ9efimOfPd2Y7wCQy8rMC0VqK2vFrHkPEGAZE8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754308585; c=relaxed/simple;
	bh=31qLRZAsxoIOElO8fpwP485d6bFlWnYkKF95ctBA+II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROu53e2PFtZSqgw2q6Cd9mJVomtCdAhGdwk2WWg31mfbi5SmJb+zc0n/PCwbs55F4zxTMwkTnJtQNZu66ktLynss1xMJAyttMWBM6+rhl5wy2QNkOWCXaKq1EHdNDWolvC+D0uAyoBRUXeh2exMKhPIcG8yULxLKyxaoYnpRe3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TjfzDCea; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bddb92dc1so3530589b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754308583; x=1754913383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cI7BbEVkVKXLURYH2L0Y1Di/XtiOa8E32DiWY0NNU6c=;
        b=TjfzDCea2yi1/oJ+vbS+h+msCRorJ83+/hcWq8HSF6OejOTS36RwATa3FTvp6/UaMj
         6LXd5PiEeubpDhng2ghKi6y6qCVtwf6UbZ5f0EM1wGMICgVSAKy1WvqgHUODw/IfCMIG
         B6zAHcs7wlVDmRHmrLRHOMwedcNTY9tY03JPq3TyGw6+3xn/MC7EzprnTQd8sAjA8DDG
         m8pqgySamUiHQbZ2gpouiQsWn3c4GrNGsnHy6X9272IPDZJi4qjbxWHw2+8qLGzmG1DW
         8BeHcdphTpycoDGO2X78Uy4VjeUeSotZsQP+CMsa3YpjjQPzGguFUsf6ci3ke+QQgVeb
         P/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754308583; x=1754913383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cI7BbEVkVKXLURYH2L0Y1Di/XtiOa8E32DiWY0NNU6c=;
        b=q9651PVajX2GqTXp/uSVoTJU4a4t0pN1XrrfPcjAAXPcKaXJ5TDrRYlDebt/Hu9av1
         4mk/BVjBy3fAp88R+3ekM3GtUSEnKeYWXyyydbFb9KOpEBZsxVr/56QvS0nsNf2k4Dic
         ID/hB+R6s0jej0bbc7aZUNix6AZQoBb2VvvhWY4yi85PS7+e84BqZTSAlm6rFbSVNJuH
         R/K6R5RxVG3C8zRKBLcwXolBkCtTVei43LXIRerTZbZNwACMS1xrqEluGhKM3wbWZeI2
         rhwy8k2EUgpDHR1bJ5+WpatC5cUfWwh89htbwJWORPaSYbeh4p+48tcGXWI8dN+r/0sM
         h7sA==
X-Forwarded-Encrypted: i=1; AJvYcCVL4ejZHkXqHRYFSTtt1vlevcc01YZbKrJ5kZ/AW0jUfOAgPgJZKZVWuP8XzYL1DW0mf3ry02MPxbpP3UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVr/02wSg5iTMJURgUOc9W/i1gGFtkeKqBdThn5n1rTOXuKH+
	6U2yBikeIofGk3m1MqbKpMUWh26OyNX8eFZyXWszDHf6N1WPsirNmRfMT/ZOszzeWg==
X-Gm-Gg: ASbGnct2P6C1iCx8LjlWv0h7uXTJQXjTF0+5XsYm0BCA3bvYbiqfxfnuv+gmGLBLgO2
	1edjJIvHtP9x17/ODba9XmH18KrrcUYBYh/b+jfIhLJDnTNfOKQ0fC3scoREtPHmXSfH+nfLoe1
	ZG7CJeSr/LjRNhtvcydTfG0KMdeuSJHCtO2rZT6Hmivho4JrGOOsXCa2bMmMuu+nNV/oJX5KyBi
	ageqtsqQvxSle4oDE/0EnsegF4bWYtF/bAmnZSe118hy6DdAZHcA4rxmus6F6KJXomKjqc9USzn
	j0mM5tDxr8W0nNijh/HtQskY4ZPO/gFUxqvZ4ikeNabtUsqChuR4Qv+hlG/Vlg27RXB/a4hbWfv
	tnOpLslzKXGRqm/p2kuNCGRIWcddONXSo5U0+ENCPVvA=
X-Google-Smtp-Source: AGHT+IHEURpnuv1qI3CIQWkvkauYvujp9hF9xWR8G9gZJeBsBh8ZeO0/ft/Fb9Z/Z4ers/L73lOMKg==
X-Received: by 2002:a05:6a00:1495:b0:749:ad1:ac8a with SMTP id d2e1a72fcca58-76bec48f3e7mr11765133b3a.11.1754308583133;
        Mon, 04 Aug 2025 04:56:23 -0700 (PDT)
Received: from bytedance ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe8f90sm10355304b3a.127.2025.08.04.04.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 04:56:22 -0700 (PDT)
Date: Mon, 4 Aug 2025 19:56:13 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 0/5] Defer throttle when task exits to user
Message-ID: <20250804115613.GC496@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <a3b3eefb208f06b0c55f889495376248@codethink.co.uk>
 <20250804075204.GA496@bytedance>
 <xhsmhy0rzz66q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhy0rzz66q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Mon, Aug 04, 2025 at 01:18:05PM +0200, Valentin Schneider wrote:
> On 04/08/25 15:52, Aaron Lu wrote:
> > I'll rebase this series after merge window for v6.17 is closed and
> > hopefully it's in good shape and maintainer will pick it up :)
> >
> 
> FWIW I've had this buried in my todolist for too long, I'm bumping it up
> and will do a proper review starting this week.
>

Thanks Valentin.
It's great you can look at this, look forward to your comments.

