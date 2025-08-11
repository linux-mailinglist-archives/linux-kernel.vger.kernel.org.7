Return-Path: <linux-kernel+bounces-761902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D96B8B1FFC5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66D8189C5C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097412D9485;
	Mon, 11 Aug 2025 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CkgPCvPP"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60240202F83
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895658; cv=none; b=UXFsecM/9WLe2qFpDd5E/3z/YRmaHsRsexJTDkLZd9W1duSwFW/ZYh9tg8XL/k4dv3F1I9I46O9yAcjD2erCHfihRr3pbMx9GCyZx4q68DeHuJcqzlFE+VfrX180A68jlef2FvxvOE+RZBjjCV+LH136VTNxgLgiu8yxAlakfUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895658; c=relaxed/simple;
	bh=4TXBlBGQNvA7bt3BXu4K6a+JVORCJDofx4zHmkOthDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y9Mg6ha2FHeaHfG4zoOjj0Zcqs3Bb79YTotYEJcGHg3C4OMbN139AkZLP7Jza0oPBiU/4n+5wolXafdM9xHuBTy/evWYv792e2QIN+tDfdlvpu+tQ5BWVKZwyC7uqvjP82aHCCynyR80uC6gWadHvPojnQ28tGGs0xn7ilTTNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CkgPCvPP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b783ea5014so2077004f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895655; x=1755500455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hwWzDFSbMSy9EZ6eh9Z+w3E0hJBaTZziN3cHZhQKeU=;
        b=CkgPCvPPYinEiDCKNHlRoUuoVm+ePNxSkJm4e+BCILCgFOZkWdE1oqwQtZyuZHbNCa
         OfmAnB4TcLIAX0B8By5RHBr1OJPQS8Fx1VE3DihPhVKuO+9L+VNSYGYZqMdC9oTfmKgU
         vAwWJk4UfGzQDiSqr55Orq9gGLT4wdNAdm043YUM1g5YunCH3UIoUDz6cahGD9SP3IpT
         opBWDbViCdlgEwgrTov+k4HMWf4Gozt0EZjJAnd8UK+QimFjoCH6YB8O71uC7qk4aAuH
         WYmpytwsod7FEC/rJnQ+JegjxK08CweI/1wLg4eJrXjPf6AHGB2tP54LhYpeKyy3IEN4
         QUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895655; x=1755500455;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hwWzDFSbMSy9EZ6eh9Z+w3E0hJBaTZziN3cHZhQKeU=;
        b=HJZ9ikrpMZUQMb+KIwtgcAujSX1wrASUrFGtKv2f7mdspP/tIAlyvwn7LksuLKferN
         sn6dr9XrEgtzQjdx81VCeKk8LIc5uY7hpgH4+mktABVEj2gIKoEKw3uFkZW1yhNynaFQ
         Mt6VGFha/ctWMDv6jAf8+vsFHIUTzS12UBemQmD3L5OW8leKcb/Y9TyS6p6t/oaK5Bw5
         drSyPh1TRxmJVAb4pFGAKYNMVB/QOvZm7W2z3YVThxCTTJQl3mU3uurhFV44TU0+DMkV
         4przhQYdY85N4KBxvEnd1KQSaNCRznfDDyG2At6AeuxRV6QegxCbJqEHxE78s2CtOmVf
         XG/g==
X-Forwarded-Encrypted: i=1; AJvYcCVlwGabvijpaslXTr8N/r7dfwTa6h85mzMjVUb6SiBfDF6TQ0c6frWC6+DZFdY9v16kTu0nfXNvbtKil3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYifv0+urxvU0K0Hr8pKxiyH3hIqMeVOUaZEOMl7EOeBQ61sNZ
	8V8IaWfRn+2KTz6NJWDysKfszHhIOlA51KFM7QvQdE/xX1qn9pwtLAhJff1j1YEHMW0=
X-Gm-Gg: ASbGnctu8KnwMQBD4PKDM7iLslgICVXg5OJa6bMuTRphq5ZFJNXZfmn6uETA59u2jKQ
	k4J/F0BCJk8F2lzQoFaE+zVjbu8glyDbPRg0qQcAU5UA+HerJM351tqG1eSMB5+ZuTrUaiJ4E+6
	Kcym2ItHcQqsAFP3zslK8dHA3ENvubQ1/6zpISolR6nNT5zV80ybwy02BShpz2TBQP6jLliiUkg
	ofRqwXMLyjfe1fSDNvyym4t9AVA+YmwVYJOp5q7NG47mKWM6yD1mLsv+0WZzFdCZ8wW4uXMibS6
	jbyHyw6Vxm6Yr/4r+vb6pHast/quQyEOpDJllJocDGEP3fGX9TZws1vKK4q9RP4NfnbFP9VlfhQ
	xx2joRwULsct+BnGhbnbeKWxBdwZV6JLTc0n/9A==
X-Google-Smtp-Source: AGHT+IHRURi+b8G7dagGCHr+89qFgRkhvYaQGSCmp70FV+PfG/xE/6yTSPpoTAWNO1orRt9InmbSaA==
X-Received: by 2002:a05:6000:40ce:b0:3b7:c703:ce4 with SMTP id ffacd0b85a97d-3b900b6aad8mr8041910f8f.59.1754895654564;
        Mon, 11 Aug 2025 00:00:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459dc900606sm305322985e9.15.2025.08.11.00.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:00:53 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:00:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>, corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH 2/5] mm/damon/sysfs: Implement a command to only commit
 scheme dests
Message-ID: <202508101330.XRQqvfiN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805162022.4920-3-bijan311@gmail.com>

Hi Bijan,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Bijan-Tabatabai/mm-damon-core-Add-damos_destroy_dests/20250806-120845
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250805162022.4920-3-bijan311%40gmail.com
patch subject: [PATCH 2/5] mm/damon/sysfs: Implement a command to only commit scheme dests
config: microblaze-randconfig-r072-20250810 (https://download.01.org/0day-ci/archive/20250810/202508101330.XRQqvfiN-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508101330.XRQqvfiN-lkp@intel.com/

smatch warnings:
mm/damon/sysfs-schemes.c:2605 damos_sysfs_set_schemes_dests() warn: iterator 'i' not incremented

vim +/i +2605 mm/damon/sysfs-schemes.c

8014d822c9939b Bijan Tabatabai 2025-08-05  2601  int damos_sysfs_set_schemes_dests(struct damon_sysfs_schemes *sysfs_schemes,
8014d822c9939b Bijan Tabatabai 2025-08-05  2602  		struct damon_ctx *ctx)
8014d822c9939b Bijan Tabatabai 2025-08-05  2603  {
8014d822c9939b Bijan Tabatabai 2025-08-05  2604  	struct damos *scheme;
8014d822c9939b Bijan Tabatabai 2025-08-05 @2605  	int i = 0;
8014d822c9939b Bijan Tabatabai 2025-08-05  2606  
8014d822c9939b Bijan Tabatabai 2025-08-05  2607  	damon_for_each_scheme(scheme, ctx) {
8014d822c9939b Bijan Tabatabai 2025-08-05  2608  		struct damos_sysfs_dests *sysfs_dests;
8014d822c9939b Bijan Tabatabai 2025-08-05  2609  		struct damos_migrate_dests dests = {};
8014d822c9939b Bijan Tabatabai 2025-08-05  2610  		int err;
8014d822c9939b Bijan Tabatabai 2025-08-05  2611  
8014d822c9939b Bijan Tabatabai 2025-08-05  2612  		/* user could have removed the scheme sysfs dir */
8014d822c9939b Bijan Tabatabai 2025-08-05  2613  		if (i >= sysfs_schemes->nr)

i is always zero.

8014d822c9939b Bijan Tabatabai 2025-08-05  2614  			break;
8014d822c9939b Bijan Tabatabai 2025-08-05  2615  
8014d822c9939b Bijan Tabatabai 2025-08-05  2616  		sysfs_dests = sysfs_schemes->schemes_arr[i]->dests;
8014d822c9939b Bijan Tabatabai 2025-08-05  2617  		err = damos_sysfs_add_migrate_dest(&dests, sysfs_dests);
8014d822c9939b Bijan Tabatabai 2025-08-05  2618  		if (err) {
8014d822c9939b Bijan Tabatabai 2025-08-05  2619  			damos_destroy_dests(&dests);
8014d822c9939b Bijan Tabatabai 2025-08-05  2620  			return err;
8014d822c9939b Bijan Tabatabai 2025-08-05  2621  		}
8014d822c9939b Bijan Tabatabai 2025-08-05  2622  
8014d822c9939b Bijan Tabatabai 2025-08-05  2623  		damos_destroy_dests(&scheme->migrate_dests);
8014d822c9939b Bijan Tabatabai 2025-08-05  2624  		scheme->migrate_dests = dests;
8014d822c9939b Bijan Tabatabai 2025-08-05  2625  	}
8014d822c9939b Bijan Tabatabai 2025-08-05  2626  
8014d822c9939b Bijan Tabatabai 2025-08-05  2627  	return 0;
8014d822c9939b Bijan Tabatabai 2025-08-05  2628  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


