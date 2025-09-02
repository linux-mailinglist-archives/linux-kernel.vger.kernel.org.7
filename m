Return-Path: <linux-kernel+bounces-795683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13251B3F66F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1257A5F1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81E32E6CD9;
	Tue,  2 Sep 2025 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PgTmlKiz"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D22E1EFD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797562; cv=none; b=hepZwGSzx56JstQ2ZAZBEqL1Pdf6qKphzWsK7uq5vv6CSJGM4Lbtow6jxKlkIutgMK8TE2N3ViNKC/ZxFh0mTIF8SXDQT2r63i0AVdh3qqiveAgUEOj2biyOkyMiykXI1E238zj/49fcAp0DJwrlftKbuCZuReerXyNUeyF4SQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797562; c=relaxed/simple;
	bh=rvkRs/hHcWN2Hv7kuZnjCZWnKxCN2Fp/ZNHwmOgmHao=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jN//gA19V2aWpEhP9mzU1qsdB2UoQX7sCFV0xs4w2tiZxZM5gtAo4shmhubaTBr6GuxZhwkdh6gJar5TbnJhVUryF4DhuCJTIR4Su1RlLmH572Z15M7aAc5pbp4Iumqs1hedRn7KC+KBx7E7Q3qHxGIveDPDZGtL5xrvwzIEYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PgTmlKiz; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b72ef3455so18764505e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756797558; x=1757402358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tDIao9XUepcqrCjhRvfzY5Z5X6vXPs4ReBppcxWOCqs=;
        b=PgTmlKizpsnYUrX3UXxfmBgKHrpPYSXvDJ7hAj9iG05yh2N6GkoKM0l8ZjKnJ+dv3I
         wPXznghq4i4MO4HO0FugHT0FnmL3zDQcbNtMCQDwXj8BLJf2bdUiF6AmJEy8JlbZ3kBg
         9aqfkWSY1ZdtxwjybPEy1HTo6lVP3Wchr5jLgPO/GiOIBqbfxBljHiLSZvQxANAFhhfv
         VSgRt/eqP9bSeYjmWHcjNN1cjDznLJIKFW6tUUsm8jQJn5nC1iZUi2kNMAq4z3Sg5N90
         dl1XsEiOVHdtK+5/8mtPNoebkIp5y3jWVSFuv9gtijNBWOFfwG/5wQs0+mfE1W0/4P5c
         jdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797558; x=1757402358;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDIao9XUepcqrCjhRvfzY5Z5X6vXPs4ReBppcxWOCqs=;
        b=I26S1j2K5dIWBXXGqm4wFER8fIsdza/Nd+xTleoi826okIwmBE1hIADrBD71qycmcs
         ik3nNOjaYUKYNKGAw8ITrEtJ+AThKM6IxhWb8ZaX+yod/fWl1v/65Hs0j//yV07Pe8EM
         kd5hBZyxgm+LQaA7t12/Zhs08AAoTxPRQcESWB9pJOkY/h0icn+bCLkWLj4VakArXkbi
         XUGVDn4nymbLOMMMFjwXlbWx9btjMgg0hRSpOUuYZH6W8qy7drtdINAwwOEMm5bEqE8E
         N+PmrpD3cik8K7ay/SnbazKSKmsw83LI+fZjPuYcjfMR/56xKlGFqzJPrtGRr07FHipU
         Wh2w==
X-Forwarded-Encrypted: i=1; AJvYcCU3EVud8Gd9ijTc+Mlk30hs8u09O+Wca8I2dxxiHQqwPU8BHd/OSfCkktKrnDaMZfNW8yKjuIWEAJwmZNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWyKUG80ZE+Wtpcoyx4h3l/8cYL0sLCqnzZM0SaSsWy4s1fctR
	S/+V0IlulDlHfA9qWjAsk9x0n+Js4g82o7U9gd6ZU8CxiIXM/SNAeqhdU7OoVGebZK/WrPsIfic
	EysK3E/dMdg==
X-Google-Smtp-Source: AGHT+IHSqK5iPFipnfJUNjs1NPHxkOC7yb3uaQ9NzgXE72/2G1oKfT4pYd9K2JEATUQ2mtLCAbIG7uuqymu0
X-Received: from wmtf7.prod.google.com ([2002:a05:600c:8b47:b0:45b:89e7:5038])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1994:b0:456:18f3:b951
 with SMTP id 5b1f17b1804b1-45b85575580mr85979125e9.15.1756797558265; Tue, 02
 Sep 2025 00:19:18 -0700 (PDT)
Date: Tue,  2 Sep 2025 07:18:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250902071847.2330409-1-abarnas@google.com>
Subject: [PATCH v2 0/3] staging: media: atomisp: Style fixes for vmem.c
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Style fixes for pci/hive/isp/css/common/host/vmem.c. First patch
triggers check issues in checkpatch.pl that are fixed in the second one.
---
In v2:
 * remove unnecessary line break changes from second patch
 * add patch to remove unnecessary trailing comments=20

Adrian Barna=C5=9B (3):
  staging: media: atomisp: Remove typedefs for basic types in vmem.c
  staging: media: atomisp: Whitespaces cleanup in vmem.c
  staging: media: atomisp: Remove trailing comments

 .../pci/hive_isp_css_common/host/vmem.c       | 111 ++++++------------
 1 file changed, 36 insertions(+), 75 deletions(-)

--=20
2.51.0.318.gd7df087d1a-goog


