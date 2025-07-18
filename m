Return-Path: <linux-kernel+bounces-737087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 048C4B0A78A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7791886EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CBD2DE713;
	Fri, 18 Jul 2025 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJqqp9Rj"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3AA2DE213
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852449; cv=none; b=WJzsQErrkvuHAnFr3+saCPAFpmXeKva4v+QDpvSaAg6IaoTRsLZ1qaM500FQjUP/mt7dQv6aWcjqtz+Eqh6EFsEfeiySoxdqBlSHtiZuf5ZhgkkAb5/slaxvD1QSBjiTd1zpT9c2cbL0dlFZ9fDTu9q4u9+k1pLlXRcJxc7i+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852449; c=relaxed/simple;
	bh=ok3ivDYRuNQPcJYkzQ/LOj7nL7uE52sAZj+wDl34c+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXJqaAk1kvj4SqGKvrR9NwAsaKGHVHo0NzLqYz6DoJDLnvY4FFUJMtdhDuPxsj5eaRYUxKt9Lcf2hkpLE/RMuRqnTwNpOm6DJ/Vs961r7wbZJ4oUZBmvWvXlw9gFT2CwKeR36uRQJtCgnMEo0VScwUByy0d4PJWkBSozZ+ehex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJqqp9Rj; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-714067ecea3so17322477b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752852446; x=1753457246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F66N0wil7J+HbPwMNjuizTeNTbRlp/Sh4yJnp4lMFrY=;
        b=aJqqp9Rj7xGinlrj9gtL5LBL70DNEP1pWn8NHIff+eNXvB0U1N5VtRs9cVhfRVEb7N
         mvnLqmlXENecI9aKNJjrcpcow0OOU5vgwU9S/M7a3+mddGqpKKUF/t2huyKa8tFntIu4
         9k1AzsEAR4BwMOiH2GE/puENN9o3PgDitCs31LRI78q96DSkYd1A1OVEhUkJd4jmkZew
         jhTP68f4c/1pBYNcRVGqbIW43UPaBlXFs5mroPGpTArzCgDbv/O8VVMV2NyygHwJY91/
         JGYY63j/R6RS6cSjYOGR9M8iFZKwV88wV1cYGm4MNdTcJ6/gJcG3EN9Xa/k7fQA8V9XP
         tvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752852446; x=1753457246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F66N0wil7J+HbPwMNjuizTeNTbRlp/Sh4yJnp4lMFrY=;
        b=gJ36GjTguJLiiIPNaRK9kzpl65lEt2ZUSqcBCnvuwWc0HegnesbZyEBqyqQiMRZPgc
         dgMVTSQuy0372EwlEDVUn1Pufpeau7v0Tfk2+NVMERDRIE6qcq+HKHB5TId7jZ3YFoX/
         3aOPDvfMTHkJSGS7qltZ6GD1sxB8yv/hsdrwcTFdLMmIChpAKw7eOZpU941hlKo3fh9Q
         9cvl9DkYOwLGWUgO4y3afCXO+zo1Wuu3iRt4VHiFbielDr4dGr6Eg+gKqSae3PYvJrYK
         JxZL3Eyn3tU4XU3em+lsS5DmRuUipT9/c6NeKdFggoumu0ttpBimaQvVE7oRQ50syrk3
         T99w==
X-Forwarded-Encrypted: i=1; AJvYcCUVVDbvdVR9z1LI1+hRiEGHEh2UJQGSpyw1VRESOJ6tNAWboG0TuIODTHP2mExr3RsjOJID88yk1BBE0fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypVG6cb9pR8oWlgpzhtJarfcbfCCzm3fZLQVP4ZMG1e0+SXGrU
	Ym1/6YPlqrzsToCUrzq4qa904nep6mTfmdvBkUew47+aR/nonzCowOs2
X-Gm-Gg: ASbGncsXOO83UssPv0prVXFidWPrIMoShlCNg1dADoskoYJ5Jx4tOZcp+ZY53KgDzhW
	J491w+zEUQb2Mkpl9UpXK9Ri44H9FQiFBKiCwT5NlaWOHFUN87+svDipj6K7GJ6G1oHsZCeeqAB
	xgYL2sJ64TcKz1ZO9UK+bsccUyQLZozaRAkKjACki11MDqPh7osfgXuit/AU4iZmeKy0lXA5id3
	kRRHsf7g6AhIhAZVa4JqPfL2t7OdIVkKoMmtmVaLU+yqqSgxYeHw/UCzV9bbyOO3tFVCHCWGGh4
	UDv14a+vISFl5mx1OJRdH2J4DI/EAvE7Hx+N5fQhCRZrcu/Yrh8sHLwEcfOxRHoeX7Z8Juw2LeX
	zAoJBydTSW+W4mW1TuBuf0g==
X-Google-Smtp-Source: AGHT+IEHt3k5CxyEPCwLRVQs6pZJ7u5eFljYq50VtW2JoGNL1uq6TN77Q4wUo1jx7bSmHFInqIZlnQ==
X-Received: by 2002:a05:690c:9a0c:b0:712:e2b5:e61b with SMTP id 00721157ae682-71836ca03bbmr155585107b3.13.1752852446394;
        Fri, 18 Jul 2025 08:27:26 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e9bsm3683787b3.61.2025.07.18.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 08:27:25 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>,
	oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/hugetlb_cgroup.c:829:44: warning: '%s' directive output may be truncated writing up to 1623 bytes into a region of size between 32 and 63
Date: Fri, 18 Jul 2025 08:27:23 -0700
Message-ID: <20250718152724.1206447-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <202507181808.mpbc1F0r-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 18 Jul 2025 16:39:59 +0800 kernel test robot <lkp@intel.com> wrote:

>    mm/hugetlb_cgroup.c: In function 'hugetlb_cgroup_file_init':
> >> mm/hugetlb_cgroup.c:829:44: warning: '%s' directive output may be truncated writing up to 1623 bytes into a region of size between 32 and 63 [-Wformat-truncation=]
>      829 |   snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
>          |                                            ^~
>    mm/hugetlb_cgroup.c:829:3: note: 'snprintf' output between 2 and 1656 bytes into a destination of size 64
>      829 |   snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
>          |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    mm/hugetlb_cgroup.c:829:44: warning: '%s' directive output may be truncated writing up to 2087 bytes into a region of size between 32 and 63 [-Wformat-truncation=]
>      829 |   snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
>          |                                            ^~
>    mm/hugetlb_cgroup.c:829:3: note: 'snprintf' output between 2 and 2120 bytes into a destination of size 64
>      829 |   snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
>          |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In theory,

#define MAX_CFTYPE_NAME = 64
sizeof(cft->name) = MAX_CFTYPE_NAME
sizeof(buf) = 32
sizeof(tmpl->name) = MAX_CFTYPE_NAME

But in practice there should never really be an overflow, since the longest
name so far "rsvd.max_usage_in_bytes" is 23 characters long and the longest
hugepage size string is "64KB" or "32MB"...

Unless someone makes a horrendously long name, I think we should be good.
With that said, char *mem_fmt only returns strings of up to 4 characters long.
Maybe we can shrink sizeof(buf) to be 4 and explicitly truncate the last
5 bytes (account for '.') of tmpl->name? I can spin something up.

Curious what others think though. Is this fix necessary? We really should
never overflow anyways.

Thank you Kernel Test Robot!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

