Return-Path: <linux-kernel+bounces-805587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5375B48A88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965383AA7F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B19D21C9FD;
	Mon,  8 Sep 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZaET39O"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB21DB154
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757328501; cv=none; b=tcsXzkado1r92n22/P6OM5C0Kj2n2hws7hxrBeBtrRzh4lI+B1q1gnawwAxQvIFfYpoPuCNZHZ6Rpvg73u1sVMDiqG+w49bZOVtnngs96sN01Q0bc1nsMpKvaPPRqnB6i8NYdZ9ONbgNBXj5+vFjYyLyCFHjb/gCI1OjFhYLfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757328501; c=relaxed/simple;
	bh=aooWlxs61oe5XmAvG5mEG9jZb11jz6KzCxSNS1Hzn4k=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=OMDx0BlTPgXrY+f2CR0HPtJDnkApTYyrRg55Stfp7xXYgp3S7ysEP/k9yx6C3RE5ivsr3eQr9V2VOZDLbckk458aUqXivuA8EndqvKMnqFyCfVeBh0Kyv1I609HM7ksaPnLIx3rciIsP8iURpUOrfWijd1/fkPp8O2HtURN47Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DZaET39O; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45cb5492350so26967125e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757328498; x=1757933298; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHs01z7oM1ANWId4X0P4WXVaPJBWZpLLCmKiOd/Ff+A=;
        b=DZaET39ON3QQRCLbqo3HcytUB1zoTavH3MAq41xiZRj4PWLwqk06hD2ecjQQpOneo5
         h4zIR1IcQBMhssnq7xl6gyLf40YwIOE3aa4uCMiI9Ge7ze+FAiVKkteHB9vOULiH0VFC
         fVBTHZAofKFfe3tLfzwyedNLE4MLjpvJI6yR5RS5j/MncaBAc08iCYxKYLANFj4UAm1e
         idVewv0Pw4gVJBYtojNrR1vpBBYfuPlvspE0i5/MXQwLzuMZMZmHDQkvm+z2Th5EDix8
         PpplO5WuVSDBcSdXILz7FW4tJjQ/l9rY0i+qXlg3fYZB6aSrkf1NuVB3n8UFpvoiT4bj
         0gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757328498; x=1757933298;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vHs01z7oM1ANWId4X0P4WXVaPJBWZpLLCmKiOd/Ff+A=;
        b=d+IzqXPWcWfJ7wwCIqS1SPJjfshKThjTbVZSdFdUqnXSwlhYCI4EpWJJjA33j7R6CH
         IXJcR98Lq0fvY101OdTUWEtDYUVBp1Y8loElcrO6fziKdgLLvWdjAim6FAvlThpsgRx1
         eoWd7JPqk1sE5F733W1lH/dk380PMki7fUUIZ9aWACzM0AXRiRU6jrNpzjdRwccCdQHz
         W5ZQVYJVuw36ySpmwTDb6bNO/EBlviA04BHr5SzbgnMkEANMTOuRBJEibJSDW+e2pLPx
         INrFvpAKN+kMuInw+L4ZGWQkvVjfTzOEuGBzDFqwM62EHiwhdZBfsJfKZg6NjSk9VQtV
         2ENg==
X-Gm-Message-State: AOJu0YxJZeTfLVi4RgIBuB2svp3kN2mBMD5jWENT0J9AhvB+HRC3X0wu
	dX2nOnp6f1Dskh9opCQS8lOFIpbwq6kwiN1vujQfG0Fgp+NBpd50BvTNrHvFxawkO0PPZ4/BapB
	NfJzp
X-Gm-Gg: ASbGncvIjm7vSsqDqNahbMMi/MqOS7WZJsldzyrY4zArDwG7WMupR2PAaRAg+VfddID
	da7gGfgEojmWg8qFKAaCSmivUjYabK6pyXZcphaovLe8jgQGUKC9+LOFN5YiVM8yO4OwW5IPlng
	cwSj2a5Uvzyq7coAcn4/kTNo8vpNtOv1kPRvARr0AvzunBNYUuX+TiuGRMtHvEJ8oDfHsZE6Gvl
	1EoeH9M0xYFo4MuZtJ+Lwyn+KzH4WHR/0ehGBUqOYbLfFCx/zRy9M0Pef6OthF3qnrUCEml/+eq
	SO7euA6iwc4zu7eOJ36MMyibmGFPvz+Ro8rnaWVqTpISY1THzsuTh+17m8luVwvuciSzQg/8rvq
	6H46TbVF5T5JTddTYhZnmaHT/Jof4T9gsmshyPaV5Y7ewfgBCoqbj6hbKpUD2luovVyj3CGzoni
	YjrOPYDxuyMduk
X-Google-Smtp-Source: AGHT+IHPhOXQXGFj/kIOadcgTuaRxf22+4yFciHzJcYi4juLw9HJQxPZ/k92mxlesnF3xP6w9bAziw==
X-Received: by 2002:a05:600c:1d24:b0:456:fdd:6030 with SMTP id 5b1f17b1804b1-45dea83f76bmr8038565e9.19.1757328498296;
        Mon, 08 Sep 2025 03:48:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9b6a:7b16:fb30:a294? ([2a05:6e02:1041:c10:9b6a:7b16:fb30:a294])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45dd6891d23sm140785655e9.4.2025.09.08.03.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 03:48:17 -0700 (PDT)
Message-ID: <2af92349-2c84-4f1c-b035-946c3996cd9f@linaro.org>
Date: Mon, 8 Sep 2025 12:48:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Lukasz Luba <Lukasz.Luba@arm.com>, Saravana Kannan <saravanak@google.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Deepti Jaggi
 <quic_djaggi@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Srinivas Kandagatla <srini@kernel.org>, Amit Kucheria <amitk@kernel.org>,
 Abel Vesa <abel.vesa@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: [CfP] LPC 2025: Power Management and Thermal Control Micro-Conference
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi everyone,

A Power Management and Thermal Control session will be held during this
year’s LPC, as has been the case for the past few years, and it is now
open for topic submissions.

The Power Management and Thermal Control microconference covers all
things related to saving energy and managing heat. Among other topics,
we care about thermal control infrastructure, CPU and device
power-management mechanisms, energy models, and power capping. In
particular, we are interested in improving and extending thermal control
support in the Linux kernel and in utilizing the energy-saving features
of modern hardware.

The overall goal is to facilitate cross-framework and cross-platform
discussions that help improve energy awareness and thermal control in
Linux.

This year some big topics have been identified, for more details, please 
refer to:

  https://lpc.events/event/19/contributions/2003/

If you have a topic connected to the big ones identified above or a new 
one to propose for this session, please go to:

  https://lpc.events/login/?next=/event/19/abstracts/%23submit-abstract

and select "Power Management and Thermal Control MC" in the Track field.

Please note that topics should not be about work that has already been 
completed, as is the case for LPC in general.

The deadline for submissions is October 15.

Thank you!


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


