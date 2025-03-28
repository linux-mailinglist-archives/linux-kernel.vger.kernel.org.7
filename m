Return-Path: <linux-kernel+bounces-580324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BB6A75060
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 19:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4737A6131
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B65D1E0DCC;
	Fri, 28 Mar 2025 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXfkpJpI"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6DF1DF97A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743186479; cv=none; b=VyQhAQBQccM5xwxZJMfgrtRz8IwDEHU0bG2wwTvFVcJVdvgUMwdn465smhIZ6kciDpu/RcLoWsOTfstDo2Ng1TA4GHVSYXipT1Y/jcaKguznYvC3O9Dko3q/4y6elgy22VrbIsHoap2W5FOTGkH5cOoUHXcrRN5X/tWYr49f6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743186479; c=relaxed/simple;
	bh=XRJ2FZolH/J8Y0TJOfbHKH9CMImV97LQTgnKGL2Hwsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PZuGlvXXDADWA/uHt9d2my+mUAP0WglNA7uzyDVsxXNGAAUgujhk9iCN5XLU3lksCsGcacSohDv/faeuwOtEyFu3jT+Ykw1+Rc9aQD4UHMfMFskFDK1TtO6od4bZbR2PPzjdqbVsENiagpfHACl4rqB2D9GOda7tdqUpwi/8TKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AXfkpJpI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-223f3357064so40408765ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743186478; x=1743791278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XRJ2FZolH/J8Y0TJOfbHKH9CMImV97LQTgnKGL2Hwsw=;
        b=AXfkpJpIao4h60Uk1V+v/keV4ey5Qh+GNg12MdJ5OCelMOZiJNoIOvC+xpsqo/gb1U
         ERLgSnXdEYxT/ClygQa58LRhbEKW2YMgs+ibpL53AeHcPUwevPlgyKs5KumyksYL34kY
         ewd161x30vDQehAEt8x0lVdJTNrJ+Pw4SZZi7+AZROI5zfb6CPIk7uR1ziMmtA45cMDA
         V6locCK2SBsGREayCy6UK/TpoIZt7yAZ0+af3tPjwEJwt1z5jtXK9mJg2dcRNcPQ1hfd
         KGYH+8lgi0xZrikrtoR0rP38mHK9bIaqyH68ATcP/yssps1rgv15wPB4rN32P0Zg5dEs
         6bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743186478; x=1743791278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRJ2FZolH/J8Y0TJOfbHKH9CMImV97LQTgnKGL2Hwsw=;
        b=DUsd3HYn+HxGPdvkzqxpYlcLzyyhuQNjXmism5+HA0ytU8Bow4SZ0fSnYDs3F3fzaZ
         EI42AzM4wFv3xAZX+NLNpV20R5WwA8dR/96V2MDjGOvZJT1xx5pcstWpQIzlkGdMx+V1
         T/PgMlM9aCw6NG+ViciM4TdEP5Ryskv+yIs/HKhyXb9en+Q0SX3UJIINgF+DLUxXQ8mI
         1ZWx+/hM7DLKwNj8H04ZNNtX6IwB47u03C1CrWye6AIThhM+r82meMH+ptR4TVX3s1Q9
         x9nwYAC77Rip6K74BI5qRjhDBNzrH21nz9zOOmz7XVg7aY91DJhIda2g8IXlg332M1JL
         8vNA==
X-Forwarded-Encrypted: i=1; AJvYcCWq6JESHoP4PyH5k8QaC5cRhj4eN6aE7DoxEOV67tEwOCxCR9qKz5f1uAl4RDYkoz3ec7m0XMTtRy+nH6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtRtSir0w95yj4QqtSKo8zppIqgxKrGjmZ2N2cX9pnyNr2fkud
	OyeNPBcKjSrcTAykqp+8gijOTnm9QPqjFNe/WN3cgZYkL81TLMka3kQdUf4xG/yQb0r/SLtOXJ7
	J4Q==
X-Google-Smtp-Source: AGHT+IFBBQtgOfvWzPAF5i2yJMdV/dsAvgseHW7W6uZZ4TV1TuGHUdK+sVb0HFuE+coaNQr6/L++8gG9I3c=
X-Received: from plgi13.prod.google.com ([2002:a17:902:cf0d:b0:220:ecac:27e5])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:189:b0:223:f9a4:3f99
 with SMTP id d9443c01a7336-2292f975798mr2954795ad.29.1743186477887; Fri, 28
 Mar 2025 11:27:57 -0700 (PDT)
Date: Fri, 28 Mar 2025 11:27:52 -0700
In-Reply-To: <815e95e9-5a2d-4ef7-96bf-321fb57f42e7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <815e95e9-5a2d-4ef7-96bf-321fb57f42e7@linux.ibm.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328182752.769662-1-ctshao@google.com>
Subject: Re: [PATCH] perf/test: Skip leader sampling for s390
From: Chun-Tse Shao <ctshao@google.com>
To: tmricht@linux.ibm.com
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, irogers@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	namhyung@kernel.org, sumanthk@linux.ibm.com, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

We believe we know the problem, appreciate Stephan Eranian's investigation.
It comes from throttling. While the sampling is too high, the generic code
does not modify event scheduling. `perf_event_overflow()` simply returns 1,
and subsequently, `pmu_stop()` only stops the leader event, not the slave
events because the arch layer does not consider groups. Also, the
`event_stop()` callback only operates on a single event, not the siblings.

This would impact all architectures. Perhaps we can extend the
`evnet_stop()` callback to include a new argument to also stop the siblings.
We also welcome all suggestions and open to discuss any potential solutions.

Thanks,
CT

Cc: Stephane Eranian <eranian@google.com>

