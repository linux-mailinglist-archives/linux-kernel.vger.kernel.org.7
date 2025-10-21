Return-Path: <linux-kernel+bounces-862145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205EEBF4872
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEB5403BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E085226D02;
	Tue, 21 Oct 2025 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HXf6AR6S"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78C1DF269
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018198; cv=none; b=exUXvSMdE5n2ZTUL8ZnHUxfyk3nHUEWMbRly4L4AbV5qDhMBufOgu9Pq6PzvfYY+pFRIOTjjo1bGOGYlTgDp7pU7hApA0gM2itSMzwpx3qS1w9hORM+m4g+bh8socGaKuTvcBubkqCOv3ihpsSzRhf0lehH1UHXuPQMSFsPpM1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018198; c=relaxed/simple;
	bh=nbBzwttth1UnlFkWL+G5/MGyW0tHPQmic+LV4iQ4s90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtOnO16F7gi8Qo24WdPa/Sm9hln5nzIw1HTJuTzwLOhuFeEHGAVG+P0eB1Wany7p5sKMgNqRsW1G4L/JrXuSqTYPCL37t6QQavZy6piu0pWgusC9mUNBOcQF6voG4EAjOwYKn5uwSZrh2KPM2FNQOQ5c6//dMrYsdHq5RnAg0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HXf6AR6S; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so4428042b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761018197; x=1761622997; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xr7US09S8qqydwr4G/9BHixKcLW/nGB742179WdAweo=;
        b=HXf6AR6S+thw4MAjkMLm3My+5naBeeWdrHooFR786WFOdWzYwXdLu7YKLRGOWpzhtS
         zQNs46MB2gM8YobUSjTFHYDnr6MORGSC9UrRraNZ/Lakixeag28veIXGh36BeagIfzzl
         ehkOawJwLLY2SFaUH8k/NE1QcxqBfC/UZ85zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761018197; x=1761622997;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr7US09S8qqydwr4G/9BHixKcLW/nGB742179WdAweo=;
        b=l9ZF3mqwp6yatyGNBdtn4aI+cgy8RUuyFXssfKFV8b0LLcv/gthFVSE9vzjm+w/99x
         TeT2z/acLKiYOlS000difhDJDbCWXaqsQoQvD7PJhZgg3x9S1lUThNvZp4Wi6tB/86tf
         EFC7vmxsCnyP4oL6eAFGzXTzSTjqCR/At3F+P7tHdVPF74EG2p+78YaWIitz6Q2Howg7
         S2PBfJqyofito4Z41cSEjWD/gvfGcDMpetYyppq8Zs1ueBwKdWRJTT/wk60gy4RS914w
         vU91oPBZUJOUSzcvzqjUNQ+6w879c7RJajhlRoOfFkQOIOwwW79xG5fBwCjL2ixmYJ4t
         i6yg==
X-Forwarded-Encrypted: i=1; AJvYcCXjaxJWzUsPRhTARxY0AyQnDaBQbWy0v4Qrtf6gh3VPWRsmJ9dYpTHLFzHH1iCXh7PfT/kXiYFlGTqYcQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxri9t98udLM7qUE23ko6KlMXZZEclL/vhRQPG9jasJRzKjQYBF
	iPSL+13Eni95WXxteq+2J3s+jyFG9q85gqKAxqhIyNOnuQlzHWpLsrU+ucSLfhmo1w==
X-Gm-Gg: ASbGnctrUhvYtMLc1gyRrPZoa9+bDkDHxMgQMK3oZRz7RtU5pF/OYPhEevtv/EUgX4b
	MTm1tCiAUVbqCGnqjyK8Ocw7vrbPT5bWhUAOjWFYG6aLVPaFE9IlVHSlRY0OXliXwGUG11OlahM
	lPyM5czIbl8FmvBlejae7yn0PqAK4ON/PmpJjZ11b/QlqSZsvqSO7CR87gB5XNxEwDqQWCACc0n
	OuCN4RcYpsFXLDBBFDjRhFj2TbQP/u16hcs4OvvMc7jI5hfGG+qnNC8o5oBEdcsnqK8LlqU+6R6
	HAze8UndkHLaKbfdiil8YSkRYh55EnMv2RmJszCJEkdl9iaeG4TlU74OkER10FgL68QE7HYVoeK
	5ui1ZYGGBfC623jMiMR5IPagKDMbaNYQifBreEWzxmRKBWICFq932wQgfTWq4iXMe/H7K125jdL
	VRkeYJPhTYFwjd1Q==
X-Google-Smtp-Source: AGHT+IE/m6Pnmm6QG1kxaMZaj2yh9jqr1scnjiIgpm7t50PZ0mb2TcvYsQ39BhAG1mhtNI+3sHgXnA==
X-Received: by 2002:a05:6a20:6a0b:b0:32b:83bf:2cdb with SMTP id adf61e73a8af0-334a8524332mr21571201637.15.1761018196691;
        Mon, 20 Oct 2025 20:43:16 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3364:b517:9129:5413])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a813d4766sm7375833a12.5.2025.10.20.20.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 20:43:16 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:43:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 
	'Christian Loehle' <christian.loehle@arm.com>, 'Sergey Senozhatsky' <senozhatsky@chromium.org>, 
	'Linux PM' <linux-pm@vger.kernel.org>, 'LKML' <linux-kernel@vger.kernel.org>, 
	'Artem Bityutskiy' <artem.bityutskiy@linux.intel.com>, 'Tomasz Figa' <tfiga@chromium.org>
Subject: Re: [PATCH v1] cpuidle: governors: menu: Predict longer idle time
 when in doubt
Message-ID: <x4qvjfwxzatm6wnrtqgue7y673oqzo74i6ysmxalvnts5olkot@ekaee62fjg5l>
References: <4687373.LvFx2qVVIh@rafael.j.wysocki>
 <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com>
 <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com>
 <28ecb23b-ecee-409a-9771-24f801081d07@arm.com>
 <CAJZ5v0jMoEVUaYYPx6EtHFxsg6TF-QtDWJGrasGK7C2C+JxOFw@mail.gmail.com>
 <001801dc4041$607c19f0$21744dd0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <001801dc4041$607c19f0$21744dd0$@telus.net>

On (25/10/18 08:10), Doug Smythies wrote:
> On 2025.10.18 04:47 Rafael wrote:
> > On Fri, Oct 17, 2025 at 8:37 PM Christian Loehle wrote:
> >> On 10/17/25 10:39, Rafael J. Wysocki wrote:
> >>> On Fri, Oct 17, 2025 at 10:22 AM Christian Loehle wrote:
> >>>> On 10/16/25 17:25, Rafael J. Wysocki wrote:
> >>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>
> >>>>> It is reported that commit 85975daeaa4d ("cpuidle: menu: Avoid discarding
> >>>>> useful information") led to a performance regression on Intel Jasper Lake
> >>>>> systems because it reduced the time spent by CPUs in idle state C7 which
> >>>>> is correlated to the maximum frequency the CPUs can get to because of an
> >>>>> average running power limit [1].
> 
> I would like to understand Sergey's benchmark test better, and even try
> to repeat the results on my test system. I would also like to try to 
> separate the variables in an attempt to isolate potential contributors.
> 
> To eliminate the PL1 effect, limit the CPU frequency to 2300 MHz and repeat
> the test. To eliminate potential CPU frequency scaling contributions, use the
> performance CPU frequency scaling governor. Both changes at once would
> be an acceptable first step.
> 
> Sergey: Would you be willing to do that test?

Apologies for the delay.

Sure, I can give it a try sometime this week, am dealing with a bunch
of other stable regressions right now (will report separately).

Can you please help me with the configuration steps?  CPU freq limiting,
etc.

> Sergey: Could you provide more details about your test?

We track regressions in a number of tests.  The one I'm running more
often than others is a Google Docs test (our tests replicate real use
cases).  The test in question creates new google docs (in chrome, of
course) and inputs some text in them (with various words-per-minute
settings - 60, 90, 120 wpm) in English, Japanese, Korean and other
languages; different font faces, different styles (bold, italic),
text highlighting/selection, windows switching, and so on.  The test
measures input latency, the number of dropped frames during scrolling,
CPU usage, power consumption, etc.

