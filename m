Return-Path: <linux-kernel+bounces-756808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58938B1B990
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DFD18A004D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3B0294A1B;
	Tue,  5 Aug 2025 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg/bMock"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFB23C50F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754415937; cv=none; b=FHtsdf4scXqLU9OW12UcD3nETdZUSNLFifbVsSDwBScdF+c1/WcY35BpAJH2SZiRNBQ2xNW4OGOzLBcf1LDjNDYMbeD47b5C8X8991jOwRAbBTUulsIymHOmPwvqse6W0QYjcoRIz6WZB1tHAMhLuqI+6/LM2kSjjB4i3fFcAoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754415937; c=relaxed/simple;
	bh=sfsLziwv7xFL5A7kyaLd18E6JkM/2IlJfkpkSd83p3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uv7oRE0TfPtkHwAnbEHg+1gVFxbWNklmnrtOjYRohnHWBkaHQalA9LegOj6RDfkaGQTXBKLsavdbGIz4aJKNUS3Vmo6nN8rTwLz17PRrGg1Kwj9QDz2rCRtVQ6j5YxCC35GdDF/OnSAMIxdzhfsGEk0eojeEcrWv2cCCU09CoPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vg/bMock; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-769a21bd4d5so4810800b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754415935; x=1755020735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtnM1Y54ikgwJKEpH7vHYLg7tHBe/Gh00x+EzZ6A1Mg=;
        b=Vg/bMocklJib6CphSbl98I892NHhYBanH26aVHrZXo4jECa1ZwjHe9jERqDVEFj+ya
         uYJ5EM2nB3s1bJna8jcmgHzwe9RsNJfVK33aox0GWExjQzflH0FYHj/pRBzAaFspryDK
         eg9MTHdLNYyFZnbtjQtPg/k56Cr+df0wcY1zRwxgT6bsAhK8TLoOvvb7Fv6cyvhpz8jz
         ES6LNA8kRtnXZvpwmgzhw1boxo3zbfBhPyBOsmW++1vHELwMGZ4tnY6a/qg6fR3VY5XN
         bt7Mi9cLmNULbmfqgpXfiFdYC4aw0guuQN/wJzuJmlFEiqrveACcbr42BNPSUvTjSjBl
         wQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754415935; x=1755020735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtnM1Y54ikgwJKEpH7vHYLg7tHBe/Gh00x+EzZ6A1Mg=;
        b=wwQFAg13vcMfphEzHt+OOOaIMWeK20yDcKDgB9uDhmMuBZne6vYRPJm4LSnI8vYbOv
         jUDSGHgLSnRfODR1+Rln5hd7uUoOT/Sg3xK6JmOkBrmJkbPsZV6qzXEnFP+X28NNOLN7
         bLxFvP6D96BVKyTtJmdbg4l3srIN7L8qhfp68te7tVwFHv7rPuH9HvhqpUnbsFKLUq8t
         fSeif/OJFSbV3tNoK7Xl4zU9TJM8kITEQtM6ekbRI43FVwsFyN5HmpKPOKZniTpAw2Hp
         Wh8aHxsZBzL55DpUlTSw2R0alVUHGi1IY8BPtizaba2nHZ6mnL9V64wChIo2GI7Jr9YU
         bxdA==
X-Forwarded-Encrypted: i=1; AJvYcCU9r2tLGs96LHsCa8iENonKt/gQkAf0gPBbOeKLN8LnF4Wcf8yj3QAX/gHel8zBlZH2dlJ0DDQ1BkQl1Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwALu09GvMKRvJVs+lwN+XqNGPRWF/Rms/uO1H2MY2SIDKBNL61
	Ia3tZx1W1arqfF1cgg9eRaax/DnIsqvXagY/HlGmhvCNWiCJo5qtINOJ
X-Gm-Gg: ASbGncuTqHFnS2566Uo8dAotV9jy+FQJUWNMqWTBVUrmzYDLAzrrYMTvflV99Rb2pji
	Nz2ZaiOuiiEv7vsSXG7EnawOnGdlkS7ONncQYwS5OH5SXx83xiIbwh9iI5pdPL9oiVSBrRqRydg
	gIyYtqObpo18GH90o3Gu7dlb2Yc/Aahuz2bFuVh/y+ZThcWC9jFwrNo7RXSKRkZEiHJSyoj9mFM
	ug7QmfY7nUrfpwb99Kp9H7K71gZZ+j6uc7FFap3XIxYyICjEfGYR/adzpXJ0aAXZOodX+iNhdK/
	HVbSC2UqG1AsSoMDVVjFaETlPQCrtatLGzcMW0ez3dyvikEg7hpyR0Aqvhd2BV6rVlLUfbuiFsm
	YNB5Lken6KvDSBG6zy4S4kB5bKsxI8FTN5KU=
X-Google-Smtp-Source: AGHT+IHhOSt9DUmqNp/LbL5bLzv3vIIF2xouX8QOR8jF5RRQrsxp1RhZFvHpbajr2MI6T0vfme8UWQ==
X-Received: by 2002:a05:6a20:7f97:b0:23d:3513:935c with SMTP id adf61e73a8af0-23df8f664f4mr19319686637.6.1754415934814;
        Tue, 05 Aug 2025 10:45:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8fa10sm13370520b3a.52.2025.08.05.10.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 10:45:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 Aug 2025 10:45:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Tsai Sung-Fu <danielsftsai@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] genirq: Add kunit tests for depth counts
Message-ID: <31a761e4-8f81-40cf-aaf5-d220ba11911c@roeck-us.net>
References: <20250522210837.4135244-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522210837.4135244-1-briannorris@chromium.org>

Hi Brian,

On Thu, May 22, 2025 at 02:08:01PM -0700, Brian Norris wrote:
> There have been a few bugs and/or misunderstandings about the reference
> counting, and startup/shutdown behaviors in the IRQ core and related CPU
> hotplug code. These 4 test cases try to capture a few interesting cases.
> 
> * irq_disable_depth_test: basic request/disable/enable sequence
> 
> * irq_free_disabled_test: request/disable/free/re-request sequence -
>   this catches errors on previous revisions of my work
> 
> * irq_cpuhotplug_test: exercises managed-affinity IRQ + CPU hotplug.
>   This captures a problematic test case that I've fixed.
>   This test requires CONFIG_SMP and a hotpluggable CPU#1.
> 
> * irq_shutdown_depth_test: exercises similar behavior from
>   irq_cpuhotplug_test, but directly using irq_*() APIs instead of going
>   through CPU hotplug. This still requires CONFIG_SMP, because
>   managed-affinity is stubbed out (and not all APIs are even present)
>   without it.
> 
This test triggers warning tracebacks for me.

[    5.766715]     ok 2 irq_free_disabled_test
[    5.769030]
[    5.769106] ========================================================
[    5.769159] WARNING: possible irq lock inversion dependency detected
[    5.769355] 6.16.0-11743-g6bcdbd62bd56 #1 Tainted: G                 N
[    5.769413] --------------------------------------------------------
[    5.769465] kunit_try_catch/122 just changed the state of lock:
[    5.769532] ffffffffb81ace18 (irq_resend_lock){+...}-{2:2}, at: clear_irq_resend+0x14/0x70
[    5.769899] but this lock was taken by another, HARDIRQ-safe lock in the past:
[    5.769967]  (&irq_desc_lock_class){-.-.}-{2:2}
[    5.769989]
[    5.769989]
[    5.769989] and interrupts could create inverse lock ordering between them.
...
[    5.776956]  ret_from_fork_asm+0x1a/0x30
[    5.776983]  </TASK>
[    5.778916]     # irq_shutdown_depth_test: pass:1 fail:0 skip:0 total:1
[    5.778953]     ok 3 irq_shutdown_depth_test

Is this on purpose ?

Thanks,
Guenter

