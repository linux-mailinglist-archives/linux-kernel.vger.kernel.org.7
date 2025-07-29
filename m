Return-Path: <linux-kernel+bounces-749742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81297B1525B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64613A2B34
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4385B291C26;
	Tue, 29 Jul 2025 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="WaeYMZnS"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604EF1A2390
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753811388; cv=none; b=sPWitd5PEKsGCNO/P7O0cJmZyDknsoWSK+pGiaLwRaH9K30Yx4eirmJAIzXreLvYXmOqhBKSBfrUlv5f3KHGUt00rqW+7a7w0HaLXJbqcYMmnIbUCasJ1Hr68l4s6GrAr0ZyA/wuDyiyBCe0hxMZpyLqkwe7qAs6doAEhvz8unM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753811388; c=relaxed/simple;
	bh=mBhvRQ0nG5MZFbi8opUSecvTUvSr+F+OxUXM3WaSTw0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rxUvJ3cpY/aTsiWz9JOe+kY/HGXGROp25taYyqVbm/zFMvPgItoGn48Q6ceJW3Nxm5NP7aDNdzVzqpnUMJmO21+SwIWw+S6V68vg8wSBvp41yg1QEmCDbrU2wqDHFWtsE7SSRaM2e51zsNYUOMVxgI6SoCG+IyMwkJZyiwi7N70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=WaeYMZnS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747e41d5469so6417649b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753811386; x=1754416186; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgacyD7+JSAylz4eDUPZatAHSCWLxzjQWqg339FTf5g=;
        b=WaeYMZnS6EHNp2/pSSzD6ELR8QYo1NJmk2aGOGfrHeT2Xdg5DPKMq8mA9UHwWpP4lD
         DxHzLIc80EEE+yUiVbVHDccpMeAUPSnfyAVdlct4Ds+egeJZk2L/3kT9IoRAxtyASb1S
         O/mWTBGrwzbEfchgMWGUdlElk/sJWN/GI+fCi+T2xlyC130cPdQGD7L/pgKKAvdsigf8
         WS70oCCCkxt0q+eC4EUYBLgyZxddIoauqJjkdNA5RV30dmAg6Nw9ErIVQwG2T2ctm2YN
         TQ+3qYxwQAuGLQ05Yuqe7U3LcTWvIFfQ1neIQS9afqJ6cyuXQ5D3bnYMv+ujyXMFze5w
         4A0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753811386; x=1754416186;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wgacyD7+JSAylz4eDUPZatAHSCWLxzjQWqg339FTf5g=;
        b=ZdgZUPJVpjjIwouEIVhO5FOqF7yJ8guqioWiv0iFxDAJOOYs7dK3h6f+D11exwexMd
         8Dp7yD54hoPUZgoKOsUkk5OHyxm02+KdcX11QJsjHzwUoMbGY2KD5UVVZ8FEwzlVuO4b
         lWIctMvL0Z0PJJqPRGSbo2FkbcVU/Hh2oUvIsB6Ohzp3V1Gb0eTsplmc5d3d8Ud/4KKd
         qs+A7FWQHBXprIOPTwtrQikxG3NXsCSpYOSrRewOBCHN593WGQnGf9BGIwBckzO27803
         u920dSAhweInyKmq9iREK1ozUFLtDv3fyyoKIwPz2Ywo3uBjTSSDv61zh1Vs48UjK7hr
         COsA==
X-Forwarded-Encrypted: i=1; AJvYcCXi1BtYkDS6XaRNfXxbItdK4VXMYnLnfsfdRm92SH4Jzw1BR/RPf3MtodC6CL1X5uo1j7E/dunMs8qfb+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7iq8KQXcwiwgZuAK2uFhV0h2x0h5hmNeC5oRC1iiOp51UO9Y1
	NKpP63IKRi5En2ArnSBJXDlLAxjMZe1N5FpL8R9fdQ81VqiKWP8lwQRr4e4CQKcqq0g=
X-Gm-Gg: ASbGncsLP7OLJ0sXUFFM1IkccNGOQYNfs3glfA68XP0dWfJiGGcZe5wifsN7qgpNHBb
	qo/VAQRskZVJ8Gl7S60PrCQu7aqPzfVCSnVEMN7c+jpeao6OIz8wOmZ1Av0W6f6ywr+6XnfbmRc
	bFb2kL6ymT947Wzc4GFTHih/w7m5nfy+5BKCm8Cn5YIsyNl40fwpvjZaqyHsB34ZECCeIcdNwsQ
	VTFat+LkhDgzGyMhShgvSto9B+pplssBAaWz567D1UJXLDdss/40kDnLE1PFa3saxxXsOIluf3Y
	Nm8vb4/gHPkGLKCSNUg3r50XY19TuF6smk0liEXBS7wGgggMiBV0V7TFp3GhhaWf95lFtxXWyvb
	/UQekb9J6/7xbB11pigE=
X-Google-Smtp-Source: AGHT+IE9oBm8nKprL5hGjNglF7y2WycqTKbCfeajSJ5D3OE2VH/J46MKc301lqcU83YSu4cRzCgpQA==
X-Received: by 2002:a05:6a00:1991:b0:769:999c:eec0 with SMTP id d2e1a72fcca58-76ab1020b1dmr787520b3a.7.1753811386500;
        Tue, 29 Jul 2025 10:49:46 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f6af886sm7347239a12.52.2025.07.29.10.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 10:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 11:49:44 -0600
Message-Id: <DBOQ8Z69EQ52.36Q5O3T140OL2@brighamcampbell.com>
Cc: <dianders@chromium.org>, <skhan@linuxfoundation.org>,
 <linux-kernel-mentees@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] drm/panel: novatek-nt35560: Fix bug and clean up
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Brigham Campbell" <me@brighamcampbell.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <linus.walleij@linaro.org>, <neil.armstrong@linaro.org>,
 <jessica.zhang@oss.qualcomm.com>, <sam@ravnborg.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250729054435.1209156-1-me@brighamcampbell.com>
In-Reply-To: <20250729054435.1209156-1-me@brighamcampbell.com>

Oops! My apologies for forgetting to add the following changelog to the
cover letter.

Changes to v2:
 - Separate bug fix into its own commit for backporting
 - Add var_seq_multi() variants of MIPI write macros for sending
   non-static MIPI messages.
 - Minor formatting improvements.


