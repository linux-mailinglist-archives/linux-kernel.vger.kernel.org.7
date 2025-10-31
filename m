Return-Path: <linux-kernel+bounces-880643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C1AC263BD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 008D94F5781
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C40A2FD673;
	Fri, 31 Oct 2025 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd+Vq+54"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABFD2E92D9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929338; cv=none; b=diYBTJMO6Z+wqssEWGemE+gJEQtFasCOrsAcnFbjdH6wdItUl8d9cVZZfgrarOD8Xi25mkiQxz/i2YilILeOYOzBCUrCCBf5svXbhvWylP1YElJUuab5Q9We13kPwerdVmjM7SPAPUeRyHuKTnhXMI6gtVkjMytgsMu/Ywo3WJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929338; c=relaxed/simple;
	bh=jkmdMqGEGLTAlWpJzbFnFqAwY8BBbmWukGoDZnvbHLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XK2f7rb+l4ShFJobzlGCQGM0XNRJw05m/3PWe/Iw11Jt3nXffONybJ8awzc+gzUMG8llqKl7l46EGBS/pZnKVwXfupAf4PnzScq+jJspocHheSd3jVLxJwwdi9AKKBUxRMREro7Ci0kjl+Ud5FaKASkHabJma6rwP68Co0LwfRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd+Vq+54; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f5d497692so3225715b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761929336; x=1762534136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lgb+9C3jvqIAil5vMaPqTfTmFra5MOD9hf+0ALcR1eE=;
        b=gd+Vq+54MXmvC5nvbN879S4ri6sxSBUwohX8qDc5jnZQl6lhgbNrMEykQP0cNSuhB/
         ClasQv1XTo/KBgJ54eSq2PtB9Wjm8ZBGmxuk1cPrIiPwCwHjpCwgaIvDM4gPvNv7ZjoP
         5WRVKHiaY2hPnXKYOGbLF17aGlaUL3bpPdM7RCKkk2zMmzXd1CmZQr4Fl19F3MWeEZxy
         Sbzo0VInSsmjQFyCDA5gCPwbJG39CYOdS/zhie658SAmNY6w6cVfkqfRV6FF6RvoS7/D
         OouEt+u3p0ARrhHu8gjlmrQJPGVHZm9vzf1gQmwADhLANAY/GyWzSasfl4nEBhBkwm2w
         wvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761929336; x=1762534136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lgb+9C3jvqIAil5vMaPqTfTmFra5MOD9hf+0ALcR1eE=;
        b=b2DawAYo6tGw7wWSUteEvN3QIy22s4969SUKGsB1Btb6lQAINEVNluMWwGm5fZOKJg
         F4fIvoyNgQHGjgpz+kuX3iE2lH6Xtv1drVaa8tC3JHD45deBVOAh36PTM+gwNMY0xjlO
         ylJWXFLDScmBapsUYSBvAHZy0fPFvqnTyDs9FwxpoGWxygbBEEV7ZpjWik4zUx9u1toZ
         R3vioSyC+mbGciS1LrZ1J0Qz85GKo0NRx4x/ccvtIM0//dWRtpe3jtZi3KdjdHgUCeiv
         RimlilFBcNG87mhLVaCTrltF79C9QodSlwU9wdaiT+mPp6Ki9AJ8zmQG17BPgDKU+Tjn
         1e3g==
X-Forwarded-Encrypted: i=1; AJvYcCV1sx3Bv3XP3W9Rn4MtiSYUL002Ee3HNGNox/ifpJ46W+gyuaOcxeprgY6eX/brBuVaZZonEyOPnCxA1+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNFkjLeCWpP5DD/gDIjuCSPAGte+UDa+QW4oQwZcSAODalghTn
	BFne/r0aXnPzv0rwEgQ1Vf/cNrlUND6gW9NfSJVT8feobf+q+1r4/JMd
X-Gm-Gg: ASbGncvzf+T+aLwXG/ZNVjY3jKHmyB44T7QopB9ZO3U1zghcR60mxO2LbGBqX9VGvIk
	dp0GJ0V2ADXEd38xqwyByRC40c4/cL3EK9xLjQRrTvZvghlsoy7g4ZBq4H6uGvVi9SHlYufT5tt
	Qn9d3w2bRBHNV230678FCMaHoN/7E04fg8UOg87PJzComn5xtqKuLfRD7H2tqCUADRex5LdSoW5
	XAblrdOJcg/dSzkOpx7hW8hjaGBNlMCq+qLDYbfEQbV0be16BuO9T25UFoqfV1fQez9HFxw8++I
	woOqJLshgWbI0EOVXIEJSljanHBxUOOt2xIKmWEqwP0TI6i2yxlON/56NdxKhsg1Lu/QYfKY7Qs
	MYtUshbSrQEoHesg+nJ+Sj1yQcyp5tbZO7gvJc3TAHrjf7NJ3xbsJtReFhOSW6MA2FWnf9PnomV
	iaZWJ4cjBfWBPUTUyVhViA
X-Google-Smtp-Source: AGHT+IHzisb8pOTUrWEeEIlE11gPDxItgXXojG7g9LRH0MLHpSQGT5VIV7jL+XPyT0+qo+/zJb0lZA==
X-Received: by 2002:a05:6a00:9291:b0:79a:905a:8956 with SMTP id d2e1a72fcca58-7a77718e95cmr5394654b3a.14.1761929336301;
        Fri, 31 Oct 2025 09:48:56 -0700 (PDT)
Received: from localhost.localdomain ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db0a26f2sm2755863b3a.41.2025.10.31.09.48.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Oct 2025 09:48:55 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: mhocko@suse.com
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	inwardvessel@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	song@kernel.org,
	surenb@google.com,
	tj@kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 00/23] mm: BPF OOM
Date: Sat,  1 Nov 2025 00:48:44 +0800
Message-ID: <20251031164844.27060-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aQSB-BgjKmSkrSO7@tiehlicka>
References: <aQSB-BgjKmSkrSO7@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>


On Fri, 31 Oct 2025 10:31:36 +0100, Michal Hocko wrote:
> On Mon 27-10-25 16:17:03, Roman Gushchin wrote:
> > The second part is related to the fundamental question on when to
> > declare the OOM event. It's a trade-off between the risk of
> > unnecessary OOM kills and associated work losses and the risk of
> > infinite trashing and effective soft lockups.  In the last few years
> > several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> > systemd-OOMd [4]). The common idea was to use userspace daemons to
> > implement custom OOM logic as well as rely on PSI monitoring to avoid
> > stalls. In this scenario the userspace daemon was supposed to handle
> > the majority of OOMs, while the in-kernel OOM killer worked as the
> > last resort measure to guarantee that the system would never deadlock
> > on the memory. But this approach creates additional infrastructure
> > churn: userspace OOM daemon is a separate entity which needs to be
> > deployed, updated, monitored. A completely different pipeline needs to
> > be built to monitor both types of OOM events and collect associated
> > logs. A userspace daemon is more restricted in terms on what data is
> > available to it. Implementing a daemon which can work reliably under a
> > heavy memory pressure in the system is also tricky.
> 
> I do not see this part addressed in the series. Am I just missing
> something or this will follow up once the initial (plugging to the
> existing OOM handling) is merged?

I noticed that this thread only shows up to patch 10/23. The subsequent
patches (11-23) appear to be missing ...

This might be why we're not seeing the userspace OOM daemon part
addressed. I suspect the relevant code is likely in those subsequent
patches.

Cheers,
Lance

