Return-Path: <linux-kernel+bounces-757811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62512B1C6F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE0218C15E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E8D28C2B7;
	Wed,  6 Aug 2025 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6T636V0"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77E618024
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754487849; cv=none; b=gLooroJB6uQMOS+6hCBnI/VoqJZfjc1mov1oXDGgzN6aX5qgYERmdYrPNW9T6dVJbgDzdOigRGqyI2HWBk2ksjjiCSYbI1tnmoFKz4NHQ2u+hPZaJ6HXoYkognX40/NrT8FW1gFL5LRJ0t/6ONFOnEmz7JrJdICWm/QUvlLf6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754487849; c=relaxed/simple;
	bh=XLv/Q50dhC2UQHHugrJSH55dAVdrays+hhdJJQ4Jrzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSSJxTsgwEEigkJGUhyHTMct756wGCMfcGRklNAoFbQxSZlDVE4Gw1BavO0gXc0NgVrSGnKS69u1NlvZqJ4PEmbHB8ptoPSjGojzk+5HUy18md2AXwpGj4CGIfUND0GeQN0jMJSbs0xodFsUSDGO9LP4oYDz2+XrJNeYSpNXm6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6T636V0; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e901c374e7aso1658258276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754487847; x=1755092647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+BoskqRxZrTyHjmVFL6MiKmeRCMGEe1NmNgCqxmHtM=;
        b=c6T636V0C1cjB1B5xo9F8mN+AyjAN3X42gVWBxw6lHEPBGAfS8cDSHk9+gl5EYO0Zz
         D3L9pPVzBnGRL708P/WD+Eah15Lf4ahPh9VueNT0AokSaW1VCdyK1zcvySKeP0N4ToXO
         pURB3ghc7C0lx/eWAi/gNfBHBjvk5d2XFpsa96iTJvFEqRQXh8MGA8ecE5T7BHj5WDwC
         mHk3vFgY4S/+jOJ87lLXGS2LrCKR7bV6wojbFdg6eZYujRPrt5vefpzO+BKhJPjp6YPQ
         eOrM2A1wrrlHCb051hktmcfhQnbqeP7aJEOeBxfnSMOmNNirVpN56bEXU9cPBXzu9NSR
         y6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754487847; x=1755092647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+BoskqRxZrTyHjmVFL6MiKmeRCMGEe1NmNgCqxmHtM=;
        b=XbHZLUao7uNxcmQ93F87xLzTNaY9NhWUptK7xDpLML5rksLjEePPm/ww7gVbVQ0R+8
         prUB/9osV7Plj+Js9KUYTZAl/aEhjAdpEZ/OTzo28IbSjxGFncDAnPH0+gEybSaawKfL
         bmmp6oOL35/vPedHVPqPFamLpWdnNkIE1rBxszOvXgpEL1tF5QRsEJVYyaKXtgfl8SSI
         1pb/pyoDEekFtGE12rMt1OkWZBztQRJu2pWkdDqlpSRSBM445jSpZHlIWbNGxXYXQM2X
         KGXRPu9Kk2/1k1ktG/cPA9jVI9KflNA/LUS/IcrsrONR6A/BwOSyMju+zU/ZVX45ZpKa
         RN7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEqV0TMTJmmX6n351RuGA39cUcXmx/rG5j2F2hzAnd9DNoQiyLoOxRp5760SmS2TIbRcXzTxHvi/0zDJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh5oNSONPNT3g7rrZjfGYCLZZYr6NhwTxzINkLEMvg1CBk2a25
	Krxt1SEEazMJuzGQhn4indC2pubNnDFhCoIaqQebRh9jboN6RykfcwYX
X-Gm-Gg: ASbGncviNr4PWnPwjvohf+tjubL758j5n9jbs8yRLrEWX6ILwqeSDrjgerRHk42a6Fw
	sOULdzSYKmfEhzoWpFfEcX8IvxHGE8fez/tEbONoFlWw37SW7B4advsOpUXKFE6RT17OvX/4Qv0
	PxJc34t/tRuRrFTW/pNDZzXonFu0FYwUv3n6uz8tdYorH5HZYB7yRH0mVSGcmFML3c8JRsCxF6Z
	IcovGgtc18EIdWUsF45if1cDfLKTnPBLwnWRiG7ZIYviEnIHLakSNEYo58ySMeup2vyGDgQoQp9
	lvdZSaF6vcUSgz0ygnCiqGKwpXCd1XaKENzMPVYIRfQB4Am6gfXl4sbNlh3vlT8gYfSQ9yYXdNz
	F01hd9YSfcUqtN5lCqOSJ3Q==
X-Google-Smtp-Source: AGHT+IEawk87xQDQOVWUd1SSZMxS6FyCzOtqHsqYpXoO4yyDYZeLvgJgpUUMmfH9mL8lTAc1P0UXJQ==
X-Received: by 2002:a05:6902:320e:b0:e87:b880:7dee with SMTP id 3f1490d57ef6-e90287695fbmr3351443276.12.1754487846599;
        Wed, 06 Aug 2025 06:44:06 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd375267fsm5550223276.15.2025.08.06.06.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 06:44:06 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Alistair Popple <apopple@nvidia.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3] mempolicy: Clarify what zone reclaim means
Date: Wed,  6 Aug 2025 06:43:52 -0700
Message-ID: <20250806134404.2000234-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <87zfcduv3l.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 06 Aug 2025 08:55:42 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> >
> >  /*
> > + * Enabling zone reclaim means the page allocator will attempt to fulfill
> > + * the allocation request on the current node by triggering reclaim and
> > + * trying to shrink the current node.
> > + * Fallback allocations on the next candidates in the zonelist are considered
> > + * when reclaim fails to free up enough memory in the current node/zone.
> > + *
> >   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> > - * ABI.  New bits are OK, but existing bits can never change.
> > + * ABI.  New bits are OK, but existing bits should not be changed.
> 
> Should we avoid to call sysctl ABI here?

Hi Ying,

Makes sense to me as well!

Andrew -- I saw that you added this to mm-unstable yesterday, would you mind
folding the small fixlet below in with it? Please let me know if you would
rather that I send in a new version, whatever works best for you!

As always, thank you for your help : -) Have a great day!


Remove the reference to the vm.zone_reclaim_mode sysctl as an ABI.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 683c130782f0..8fbbe613611a 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -72,8 +72,8 @@ enum {
  * Fallback allocations on the next candidates in the zonelist are considered
  * when reclaim fails to free up enough memory in the current node/zone.
  *
- * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
- * ABI.  New bits are OK, but existing bits should not be changed.
+ * These bit locations are exposed in the vm.zone_reclaim_mode sysctl.
+ * New bits are OK, but existing bits should not be changed.
  */
 #define RECLAIM_ZONE   (1<<0)  /* Enable zone reclaim */
 #define RECLAIM_WRITE  (1<<1)  /* Writeout pages during reclaim */

