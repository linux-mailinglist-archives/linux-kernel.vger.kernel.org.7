Return-Path: <linux-kernel+bounces-841594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCBFBB7C86
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCB319E6E6A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5862DC77F;
	Fri,  3 Oct 2025 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3MGhMWt"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798FE2DAFA9
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513187; cv=none; b=DLHFkblMLIUByGo1VyhDSYHOwXrJqRYHiDZZOh+Dp34TsWD6tFHPju88s9ktKDYjxilMNR8WJXws8IS2T35Zv3nB/VDb62d2L99v+Fatu9bK45ATpN96uae2r1frvpe8ZMBY0pl66gKNDnlo4ppuiYwTwCFBAcz7x2/p3QpJgBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513187; c=relaxed/simple;
	bh=ZaUhRL9uYRgp3STBiIrntA/xJ/L78oxvSHtu/809KNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMlRfDUVPoP4fYYqLDn0hJ1flWtQ+4ncqpOGRtYcuB23ARYndZMCoJM+bmxDh018NGhQ9KNgZQtaWhsNlLKSx5mXY9jsYGqVFe0PZ7ITGUJ9ZQUK+fgdfkV9RLkg2PqMWAHZqjS5PyKUkodI0Z1EFSGSo/3d2o18tpB6SHiyG8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3MGhMWt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso1123642a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759513186; x=1760117986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwVgppgL3hOntHtqfj1wQPCPEzCZhCKf11suJZJq538=;
        b=G3MGhMWtJVTTfbCi26kQLLnmedAmzoPsBHVqkIQQE+YvuIuMAU/V+Txv5BB07jNWCv
         P1uZbstAZOkxZY5+w4A2BTYtL1MZJCoPnMxMuPsudH8GxzX99EIeOMqb/SGvrshX+xh8
         ldawJdF7Bvt3eXsYs/InAIAoRDyKTBO4YBZtKl0SWy6GY79QriUW53c912jRilONOFaZ
         RUyVs789OCGFleIwTwhF6Mv5WEn0riPkZ4azEODtEABhdQxrYCQ/lkCIrqFbw5kXySxx
         Bg/9Da/Q8j9ylaO34Dbc1xdmJa+8HSV8iKHzxDzMq+FTz4r+tbu5dLuruesHMh9QFyVW
         ghUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759513186; x=1760117986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwVgppgL3hOntHtqfj1wQPCPEzCZhCKf11suJZJq538=;
        b=BmODO29VBEBM63oz641dqTo9XQG9zoB5X7Ps1dV7VM8O6MDTW5vvGcrBVqm9z7NbkH
         COmSTrq+y2BS9Z+ULG3JEPVQxG5EJps8vPNatedpdlJEqlmowFqwkq5vZ9hteFBP+C5G
         yUuuBMg/mzT9DSumn7DZ3i6yVGWrbJ1tsuWqC9u4fRltlpMIbQNV7zR+i0QU3QU1Eess
         J+hiVsJ0jc7hATUZ7/JB6GXT0hJakhEjxs835SRUA+LF6lRzw05CUalYcWSWH+nhvAOS
         KJk2EcHsGJeGi70nJJoxmCrHlrIIDo/2tlLvkMHqI/vDfFVJlB/cBk0dZUOjU5KMoJNM
         xrDw==
X-Forwarded-Encrypted: i=1; AJvYcCVHT9plqMvysN/kcDbX+QmsquKlde+DqY1tJ6t+t42eLMKv9yUsk9OPmwlEY+ndenbJqlvKCRb9An7ovi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHGrNflqx7xXAb3cld+ur9bu9OSo6qmg1Lrmz0nV5j4tB3D0P4
	/00YreV1VarYOV+mbCShSxI0hiowd7F3K7HI42tW5HCJ0/9m5pGiTZEZ
X-Gm-Gg: ASbGncuDCqqwIijcujhpVFTEeuF3LXFCQ1V8cIQ614z2ALwiA8jkFGoMB9RNmdiY7ze
	RmU3mQ1WL3J9+B82Awmxgt1REdynHaS6q5JP/yzYt+28RRj/6znNq4JN+vbWOXOAdzgVvl/amqQ
	MOGFapWq+mJvTIFe47coKvyUoSkrlJy1OVQZ0VKtc4OqSOovHcPiVrmqFgxJX/LweIgE0qqShj4
	j2eMawcIUc5zcYUHu2AJQSM/7BCye6rPdnZzV37LZJReb0rt0c/Qkm5s0bdD+M+rBHVaPF5z4Dp
	juqMz+lJYUW7SYctYDAi2p/yeVFfqNSYpHoBMlJiag0/QAIlbqH1DsNKvQTahlGZoM8zwlPd/sy
	IaLgpT8c2CcyR5GVkDkR4HUY736Ty3fn0CBkFD+LlkTuXV6ChNoK3v3bLNlO0CAZbIwgNa2QkD5
	fF
X-Google-Smtp-Source: AGHT+IG6pd8ft2Gfzz8OtvTYc1aPctUPueNw+N8ygaqoazUFNcD1dF0JrQ4yow/VID/T1AeeLSKoZQ==
X-Received: by 2002:a17:903:2f0b:b0:264:befb:829c with SMTP id d9443c01a7336-28e9a5463aemr42367135ad.9.1759513185641;
        Fri, 03 Oct 2025 10:39:45 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1261edsm56267635ad.34.2025.10.03.10.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:39:45 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: alexs@kernel.org,
	si.yanteng@linux.dev,
	dzm91@hust.edu.cn,
	corbet@lwn.net,
	zhanjie9@hisilicon.com,
	viresh.kumar@linaro.org,
	rafael.j.wysocki@intel.com,
	superm1@kernel.org,
	2023002089@link.tyut.edu.cn,
	qyousef@layalina.io
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: [PATCH v2 0/2] docs: fix malformed tables in Chinese translations
Date: Fri,  3 Oct 2025 23:05:58 +0530
Message-ID: <20251003173926.10048-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003162626.6737-3-krishnagopi487@gmail.com>
References: <20251003162626.6737-3-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes htmldocs build errors due to malformed tables
in the zh_CN and zh_TW translations of cpu-drivers.rst.

Changelog:
- Adding missing TOs to the relevant maintainers.

Gopi Krishna Menon (2):
  docs/zh_CN: Fix malformed table
  docs/zh_TW: Fix malformed table

 Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst | 2 +-
 Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0


