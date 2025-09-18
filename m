Return-Path: <linux-kernel+bounces-810088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4179BB515B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA311C83DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10155319859;
	Wed, 10 Sep 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rB3nbBiG"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09352DCC1C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503804; cv=none; b=V/Z/76Oi4Nlnsya/Q5jIPoohldSFMad3JEu4N9p0mdfvb1M5uZr5Cwd870grMNgFNrstKtG4XmdJB/fUxe+SdMQIjDlDoIy92Y+342ViM6WQC2e+nCRauplbDmj/lYkPtCtFi/CBEK7Rkauz8lYOtVRLob2V7cTmpn2WEvZ6AoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503804; c=relaxed/simple;
	bh=iU3g6YqT3iBhtM4Qx6LE4jyqmLa5j7vhy7FFkAC+vbY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=irVWZhja/7SpVA5pOz8vPBETtZ8rAhdrRAwho8PEN00WS9/FE657zCkHTMSd6lfkMwe2BHShPFPKeRxmAzRT75a0MHP7qk9w/2Q/JVaivDCneTaXZ8yVCJD3asFG7uJz9DwbseGWqoRf9KT+cdpTpELFad7jQA0LFvY5bD9bjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rB3nbBiG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7722c8d2694so5641460b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757503802; x=1758108602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHog35fdZul65rJ2KSFV2eXJRn1rF30zkol6ZT3v8ug=;
        b=rB3nbBiGCCmUq5GzWvTdIf3pbOGPTQHXycuWNkfM6XjrU0bKY5pbZ8viPOo2jCHobj
         1lzHzpEgfB5r/gdwtboudIQXpL7M8N1yswrMTWnHhCwcXg6qjJv0Y+5tlfhjX/K9lFvG
         cSoepf/cgsc4hQogO+/wQAzge5GZicpLIQYFoCMHR6jJWgScpSZPSWVoYfG+oDY8Kd59
         RaDxUIyCNMVTo81on34pnnNrzFN6u/+ZB9rfKuvyC5m6hjb3lHJ0iSjNv/QV8mHuiuav
         7cOVevZE/SmRKsqhkz5+PssfDDXnr9Z6PnxkSEIYgX9xLHQyIod32Ekb/9dbGpxd2ELF
         uUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503802; x=1758108602;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHog35fdZul65rJ2KSFV2eXJRn1rF30zkol6ZT3v8ug=;
        b=Ds2v+oh4laZkOt2muvLXE5/BdxyQl1+icXWwYRez9bIWBDk+wLK0xMtp9tmK8Xs9Qn
         Z3eB7++1RKctJMEYgE2MPhmZY1Doibq2hHklliS5JsBpnL5GHLJccKtLg9C+/iOQRBo0
         psC71R/P8r3yWUe7W5Hdhb54YW/yQemzyHEoM78n8pOshoSWeX7rvQH8G0Snyp8dutHo
         pSTVcp6K6bvrBdW7Py5gkewKjiiggWGbTGTTMc81gjb4NAsrq3CzGc+vk42ReExr0oP1
         rQwrm87/dSNuMqaGJAdQwwSYtaNMGedTR+1CifdLN1pMDXcEUE4imDbv+Cw9Y9wqaoeh
         uJXw==
X-Forwarded-Encrypted: i=1; AJvYcCUBQfkEUlmx08r6cQXb1H/2T6w2lW3vT7A3agzITtNhRfOKo4tmN1lT7jqD004hVsiSj6QoYexh3vfdvRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKMv+W+TCKaaIqI8o0ux81LS1bT3ExlFQNBl3a8LZfaFZSNqA2
	NO2OUIctpmMrkUPT7/v78fTBUxrOKXQUyIY0++ZOeHOKsrCbxT+bHt81aFQMrGmczII=
X-Gm-Gg: ASbGncuyxPOXZDghYbtoUCO7kgXwZKkfUiwMYyQOJ7ibqu5YzHVQEFA+oBZR52MMO78
	IBfZ8LPwzX1f0ue6cT8WBCN5tA0r4O1b2kuzxrND0rhms5eD4VP5byc0HkyD21eooN2MDWMPwAA
	+HHRRmrMiSfOuey93cEACQbeOH1V0zEXUjyJD3g2pvnTl3/A/aBPrzkbjrLgorlFaDFEjjAftZa
	oC+g5Bf9h+y4kO1EP5dRzhUIYT2Mejd+57xTmIBE0Gyj5tlML1PB1zMnJAq9g97+FiYpIWisyEH
	6++98Ow8AJzAHluuBkTBXa/yUvq2o/xE9NN8UvyhojbpJlECeEPbh7u+v6mka2gU4O3EjyfkDt3
	gq3G79zbAfMNyy0Q=
X-Google-Smtp-Source: AGHT+IHkihz9yFR54R0EvSFdM+hx3ztjH6FzLB6hWLgclGcjkfYrDxszfqHbE5NQHR7E0043fCmspg==
X-Received: by 2002:a05:6a00:13a0:b0:771:f951:16c6 with SMTP id d2e1a72fcca58-7742de60a43mr17847732b3a.15.1757503802237;
        Wed, 10 Sep 2025 04:30:02 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662920b1sm4964965b3a.52.2025.09.10.04.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:30:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: nilay@linux.ibm.com, ming.lei@redhat.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250910080445.239096-1-yukuai1@huaweicloud.com>
References: <20250910080445.239096-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2 for-6.18/block 00/10] blk-mq: cleanup and fixes for
 updating nr_requests
Message-Id: <175750380136.204398.548203762682278830.b4-ty@kernel.dk>
Date: Wed, 10 Sep 2025 05:30:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 10 Sep 2025 16:04:35 +0800, Yu Kuai wrote:
> Changes from v1:
>  - add comments explaining accessing q->elevator without holding
>    elevator_lock in patch 4;
>  - add non-shared checking in patch 8;
>  - add review tag by Nilay, patch 1-5,7,9,10;
> 
> Yu Kuai (10):
>   blk-mq: remove useless checking in queue_requests_store()
>   blk-mq: remove useless checkings in blk_mq_update_nr_requests()
>   blk-mq: check invalid nr_requests in queue_requests_store()
>   blk-mq: convert to serialize updating nr_requests with
>     update_nr_hwq_lock
>   blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
>   blk-mq: split bitmap grow and resize case in
>     blk_mq_update_nr_requests()
>   blk-mq-sched: add new parameter nr_requests in
>     blk_mq_alloc_sched_tags()
>   blk-mq: fix potential deadlock while nr_requests grown
>   blk-mq: remove blk_mq_tag_update_depth()
>   blk-mq: fix stale nr_requests documentation
> 
> [...]

Applied, thanks!

[01/10] blk-mq: remove useless checking in queue_requests_store()
        commit: dc1dd13d44fa4e4d466476c0f3517c1230c237e4
[02/10] blk-mq: remove useless checkings in blk_mq_update_nr_requests()
        commit: 8bd7195fea6d9662aa3b32498a3828bfd9b63185
[03/10] blk-mq: check invalid nr_requests in queue_requests_store()
        commit: b46d4c447db76e36906ed59ebb9b3ef8f3383322
[04/10] blk-mq: convert to serialize updating nr_requests with update_nr_hwq_lock
        commit: 626ff4f8ebcb7207f01e7810acb85812ccf06bd8
[05/10] blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
        commit: 7f2799c546dba9e12f9ff4d07936601e416c640d
[06/10] blk-mq: split bitmap grow and resize case in blk_mq_update_nr_requests()
        commit: e63200404477456ec60c62dd8b3b1092aba2e211
[07/10] blk-mq-sched: add new parameter nr_requests in blk_mq_alloc_sched_tags()
        commit: 6293e336f6d7d3f3415346ce34993b3398846166
[08/10] blk-mq: fix potential deadlock while nr_requests grown
        commit: b86433721f46d934940528f28d49c1dedb690df1
[09/10] blk-mq: remove blk_mq_tag_update_depth()
        commit: 9784041145796994f2b21f4c7e628d7c9db762f4
[10/10] blk-mq: fix stale nr_requests documentation
        commit: a75fe12fa2e2f96b619f25b8cda1fdef6d616ab1

Best regards,
-- 
Jens Axboe




