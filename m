Return-Path: <linux-kernel+bounces-745754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F36FB11DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C174188CF84
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148DB2E4266;
	Fri, 25 Jul 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAc1RrR3"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F882E2F04
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444352; cv=none; b=I98dHZj7FlcKZtC5bYO1EJYPr3RV8PyKRhOusTh8knRlcMnstQp865BC46Qi6J2sXa1cNsY4ZM+HkHzFGLmU5fmiz+cFXA+5Pw3aE9fp9VxAEn5O29DEgpfGSTqvUWHqJIKPevlpALlMnH+kvQbquMc+iSZPIN7zJ4kXSTwJacg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444352; c=relaxed/simple;
	bh=QHfUzApUEKGymgCU0ibV0RvNyL8ndz/ADx0x3sfKtKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7YbBvMnjLb3uGMCCp4kxwZm1YNxAQ+QLWMIG/YPi5uZ2UL8uRDgEskxrEFJQ54BwPmhAz5oL4seIdeSzwpqdf03Ttml/eYPfAXYnzaUrarU4YK84t74OZD5ZppJ7JIbPjhdjoCmTOVl+gFAzU5+Pw3k9aBYp+fv+Z0iOOixAeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wAc1RrR3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23c8a5053c2so16961575ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753444350; x=1754049150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QHfUzApUEKGymgCU0ibV0RvNyL8ndz/ADx0x3sfKtKE=;
        b=wAc1RrR3V65K7EmNOT7Cidhoa1sYsOdSfR9dXTBTrzD/6iQfKFfi9rTj0gKDJh7UzF
         ZAguFrSZXIl7j39OZxnVML77w3uCBLbA7v/CCrMtQCr1ijN1Ammvd/Y0FTJvTEVxAGuL
         qXH4mfDbKBIlTEwTg0FNrOyX2tR1jTmXHQya4wX19fZ+SQCAoiZJR3Lzx0dspemgdh4D
         gyhq/OzY2Mdonlb/aX7NRziRF6SyfmrOv902hpSA9BGhYNLboQm4Qd7WNde4wWZ7Vqxx
         BZ2v5fKZFh4FmKceD5T4ZmGwyzNADi5unOUXXDBPQKfpGwLJdCCVC16XuursvRSJf7mU
         CrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753444350; x=1754049150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHfUzApUEKGymgCU0ibV0RvNyL8ndz/ADx0x3sfKtKE=;
        b=ikbsOyC82ZwdBhaWStypaC74Z4ts0+JxvzV/gxgOseWoWrELJuNRVWNxe8beE914Ct
         ISzCDDSoCO9aG2XUhgLk1vTvQPWJUmI/5G+mmqnbjH7VaZCLCqp9F7nMdgxRgQCrrs8P
         sR9SJoLA7tISpdCAmuv8WZOWbjIOfo/z3TXuxfpamfh9DVPvJWT4ou6zQk/yrFJgHWAw
         a1EWOQ5RQKuOOMbkbKrOl+c7ph0jnWmiYAUYaJDLiEA2NMhUaHvoMskNER5enKSE9BcV
         jVy6BNxtURNyd/9Ev4vfb93o/kKqr3EfdHIkCzWAc3vGNb0PXunratUA+fYMT1eAWxQ7
         RgIw==
X-Forwarded-Encrypted: i=1; AJvYcCU1OKba+dCtngcytycpXFL4g4CcgSYa3yqaYIhFbyppcKHbrIxesteJ4PDY3GKxAxtF+E0kD2Jy3CvyBvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXrNk6JFyTpM4INFEdZUiZoDcTPBqN2EoCxzS18B7vW3fT4UL
	cHDFMJEYbEqbUJA0AxoVRBDPKh8lej837OfmRv5c6JH9f1Bkj5E38OI1oikP1AZjtIVPfU60erl
	SyYLh70oMELudwwrNKH34dSE6WSCP6rrGAmCCXVjf
X-Gm-Gg: ASbGnctrIXaerFtFfdowejZ9Li6hieUvbzi/A0KqigtBHzhGmTD1QPBWEFrSHJZcdLO
	XNVjfwztkX0gMdSBb1kjn09XGAK+7Q6WVMbq3wHZeJue7Z5UiFfk2x0k2EJKkV301Ucj5nRw08j
	rRVcWMCkGyfG/D0nDFwpuwhfhtdoFuPnVm0rYX2Hg99DB5Zm+rZA7aFm8PYijRFXHue3JluAmFu
	x9n4ZNw+fogkW6dKr9w7aPF9QIRL9vd0ZfeRoLGBJ/Fl43Xgv8=
X-Google-Smtp-Source: AGHT+IG5GfmK3MrOBGZHbuRXhEHK6RPABvTMzdf8n43yLckQ5vo4Q8NkC5md2ykU1zeemIwnNM0VGxJVKLMifYpsCx8=
X-Received: by 2002:a17:902:ea0e:b0:234:c8f6:1b11 with SMTP id
 d9443c01a7336-23fb3167767mr23036425ad.44.1753444349904; Fri, 25 Jul 2025
 04:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711082441.4193295-1-verhaegen@google.com>
 <aHEEu1eSSGRhITmW@vaman> <CAAntYmKea1p=ao3OOWb=1Q+BXdyo1SCm9qGb_JMC5ry5DQVt-Q@mail.gmail.com>
 <aHZLvVnNiBcqXdXG@vaman>
In-Reply-To: <aHZLvVnNiBcqXdXG@vaman>
From: George Verhaegen <verhaegen@google.com>
Date: Fri, 25 Jul 2025 12:52:01 +0100
X-Gm-Features: Ac12FXyZSuRHRd-IFK6__wpasUMXKZCQVkzaxu6X84fGcQfro1hcT6PjZAqbpBc
Message-ID: <CAAntYmLn28XD=Zc2ZeCnhEiUuoa9iq-W9EiK2QXY5YfYcsi0cw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] ALSA: compress_offload: Add 64-bit safe timestamp API
To: Vinod Koul <vkoul@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Cezary Rojewski <cezary.rojewski@intel.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Srinivas Kandagatla <srini@kernel.org>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-arm-msm@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Jul 2025 at 13:38, Vinod Koul <vkoul@kernel.org> wrote:
> You need to add support for new ioctl in tinycompress too

Thanks, created pull request at
https://github.com/alsa-project/tinycompress/pull/29

