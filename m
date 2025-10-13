Return-Path: <linux-kernel+bounces-850470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEF8BD2E99
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A092A189DD32
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56F726D4EB;
	Mon, 13 Oct 2025 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="mY4sPzvi"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AFD4C79
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357348; cv=none; b=HxADUh6KrPh3zgQJ18hOmiQxqnGZX2J0Bggy6uD8mBtHwpR9sAeAOku1bHd2Rg43bptlfeHa0aqrjXyFZKEO4fsKm2EYDGcCgftE4KcJ6DXYkaawrNswOzw9wjfyQmOBYvR4UxXUuuqPF2aQi/PTQz8TNdwLLsHeluOnGmE6SA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357348; c=relaxed/simple;
	bh=WkrhCDKmnX21ln8ADvzuSSLLzMz+QhUPgKenp77b8Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dRixEWyrgh9sr842Pxvd90FWRnutjBAgs8fn5HyYGulrqlI1JMNaR6yUfDANJRCT9ZhFa2SFQCh84zLLPgpJ1Yg+/+HiR9FCtZ17uPJSh+DOBqUbCvEPG8ULXHjLPMhkgguzGBAQk11WGxMgLy/8DT6WOlojabgfjiZYLrxRNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=mY4sPzvi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-28a5b8b12a1so37607775ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1760357345; x=1760962145; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m3Gfu3e8nCRXSOVyjhQI71hHhbS6IxG+1qSKutGMsDI=;
        b=mY4sPzviKBnGFbreyu4vMquclL/VUWuyxaUyccwEC2Cx5IiAs6qTm6rUztWqTk2lqJ
         7gLH9CjY7AvoE1k1cfwMcKoL7ZpbXPovIDpKAc7xWaEqic4ARhyvVxC/u8DCq/6E37G/
         A+4jMdeB4XGPZL+7okVzj2CcNgn14JIiDz7cCDRmpeNwqoGMI3x7eznuF3e59qQkAVJM
         HlVKoNpRuDgAELBUrZATU5sB8xysAX63h1Sqtm55qETl6TLFQteg1P/VkaCLTp7hB7NL
         b3CKC8jSfvVgSV/SthL41IeTBu+BV6lNX7osZbk08K+S+FGMvyWOX8z0m9CyTgMrjmBT
         Q4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760357345; x=1760962145;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3Gfu3e8nCRXSOVyjhQI71hHhbS6IxG+1qSKutGMsDI=;
        b=knISs4dyoLY3u4zpK7Ekm+obHn57ZaP/sAASQGbd1ieghtonwlqedmc5GORaAsoWVz
         NbffaecxpFj0073dQQciaGjFTOxb3QJpvZnLlRyhq1w7mAQuSzltUag2ZpFyPZ/ffWMI
         EHE9DFBAC5MmTVXAS6HUPLtxOYOzhdTQS/32xXbgndU8RwkaZ0EuQ9xocrPXAsiDSNHg
         HdALJsg7uFeL9Vw+fy+IVOKSbdoqH9EikihHo7AjoP44d7EVulxOVAX/yjj9wDKjlwcW
         g5Gs6PNjK9Sh8L8FetntME0piIPNw1mtCu/llf4u2Gdeo8Yboq9LHAFqubhEu12RcYCI
         Qc/Q==
X-Gm-Message-State: AOJu0YwdtbneVHYIwusBB9JknRvdo9QMb+mrvxzXPsOelbhqm834+8Db
	PxJy80IcN455QteLwKXBHtep5ELz/MdqtOjWG9F9ynwXRfRL/uWK33Dqp7s1u9egAIHcwyq7Ilx
	BDbndSpQ=
X-Gm-Gg: ASbGnctlYwq8cTA1S88DWHXkf2jhGVo9lta6650/9mG7JsNynFriM7MrhMABiWtvSjO
	NixzJVUjhWhhzRVAhIeQHpY498nJ40Y1Izsgv9kUtsC0TSYmjhc1lr/j6CazhZGWdBXbxWfXRPl
	Xhcr9qtLWPXlUyvFmBFF826Ku11FepG177QzcyaJQxTb/gC1AH3G5FG9jdKl5HQUeVTM0Ic/jKC
	Mt90xRcy4Ht2fMbxeH9828a6ECA9tFBt9kQ5k73vJFTSyh9Hr0qKgQw9SS7L1l5n1RPjymMysZP
	PQYhQ8wpPwPFiYN0XeGoK4P9Jzc61DSA60Fteya3IileObwI3L1qLt/AkVqnLB2D4oi/Ua/WWjp
	ghR1di+OJSBT+28ELPLT4jK7rbUyNRWKipovOYQBbCCJB/JC15QBYuM4=
X-Google-Smtp-Source: AGHT+IHKpxaVS92Avf9ofvKsLY/RI0Q8LbKEn40W3SPaMYIdQootNz+ePlCODloQmspejcftZKx2Jg==
X-Received: by 2002:a17:902:e78f:b0:277:71e6:b04d with SMTP id d9443c01a7336-2902735691cmr270188135ad.3.1760357345428;
        Mon, 13 Oct 2025 05:09:05 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:866e:775a:d8e1:7566])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08d1bsm131411535ad.68.2025.10.13.05.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:09:04 -0700 (PDT)
Date: Mon, 13 Oct 2025 07:08:38 -0500
From: Corey Minyard <corey@minyard.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	openipmi-developer@lists.sourceforge.net,
	Guenter Roeck <linux@roeck-us.net>,
	Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [GIT PULL] more IPMI bug fixes for 6.18
Message-ID: <aOzrxmNP1kT0FOxB@mail.minyard.net>
Reply-To: corey@minyard.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e406d57be7bd2a4e73ea512c1ae36a40a44e499e:

  Merge tag 'mm-nonmm-stable-2025-10-02-15-29' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2025-10-02 18:44:54 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.18-2

for you to fetch changes up to e2c69490dda5d4c9f1bfbb2898989c8f3530e354:

  ipmi: Fix handling of messages with provided receive message pointer (2025-10-07 06:50:08 -0500)

----------------------------------------------------------------
IPMI: A few bug fixes for patches that went in this release

Things that need to be fixed before final release, a refcount error and
some missing or incorrect error checks.

----------------------------------------------------------------
Dan Carpenter (2):
      mfd: ls2kbmc: Fix an IS_ERR() vs NULL check in probe()
      mfd: ls2kbmc: check for devm_mfd_add_devices() failure

Guenter Roeck (1):
      ipmi: Fix handling of messages with provided receive message pointer

 drivers/char/ipmi/ipmi_msghandler.c |  5 ++++-
 drivers/mfd/ls2k-bmc-core.c         | 12 ++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)


