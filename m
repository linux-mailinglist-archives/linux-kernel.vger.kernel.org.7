Return-Path: <linux-kernel+bounces-749384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70098B14DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FAE18A1236
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E432291C0A;
	Tue, 29 Jul 2025 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2kzj6q5+"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA152A1CF
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792038; cv=none; b=j88DiqHDGrvgamMgpMqEGdd2GZgxg+f37ndD+DypwspFYqW/3mdQK+s+1f3qa9qFfW7bJxQE7JuUH8Dh3vfL9AwoNCCxu9lnx3s7oSvJa59LptaYkBNPry2SwCQuhjPwsj+zLYj7zMMNWog+/PmUa8ZNj9M6sdNJmaipTo8s1Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792038; c=relaxed/simple;
	bh=TKnKjXQEBljQ3Moyn2NGtUB7EUlIC1Y7U1SPuVvyKxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g/LHRPRkxqErwVGziFbSfrqPikUWFEuieS8b0wpkvHdOgbAKJHsh+YfiyycXTJatPWYo0EdYozKuGGEk+3vmiYCv7iPzXR/EMOzNmd2WWbOZfDzvX1GhSzQf3lkjqrriQylkRAjVOE90QSO9QmKucxZV3Umz6/Hlz0BHxNlDavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2kzj6q5+; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3de2b02c69eso22631785ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753792035; x=1754396835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBoPwxvF5REE1oiYskNxYL91+a+mNha3bGxiDN/ilXw=;
        b=2kzj6q5+lrgCupoS/NHvwEO610qo2CAfinn7IwhF1MX1PicLlXOd7L5OK68dLRJnKa
         6g+nZNbRWRmIxl41DgHt7/kMJJT+i2Y3zKUK971dkLb5ikF4OBMeGvixBASD4MmuSO4/
         t3ssnT+XIxSzkmXl4oAiz5RLqpYC9bVnrJVMei9341RvdyA8YrpxFUGqht5q9U55/nEO
         Jidt9sQ7nHF4ciRY3HN+3U/44b8DtrCV80+ayB4BZujs3wA+cdE+t6TAYuoByN3DERSk
         3vLPrSv2QuQ/cBGhnDwU09+vFC2xO+31T8cE12RaIV7Fl8ZqFiJEAK3kUOfCPqZ2ct3J
         pu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753792035; x=1754396835;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBoPwxvF5REE1oiYskNxYL91+a+mNha3bGxiDN/ilXw=;
        b=t9R/OW5OGiShgImrFK6VvnFGLayDroDUQraQZeWZkgMXiVGG5ForntIAgIErOqVndT
         PDv+Gs/ig3wntO88GuSkyBSl+/bYKEgO4rpev/n+wmu3js0Tm9QNHheSIDPioCwxaHM5
         xjNXp/Fv9vMxwk1cRyfZD5dGwg2CZyTEtmc4pOvDkmy6vbbsvKThKp+g/SZp46frO6EG
         zMMOJQLtA1q+VtKhUTjXk3IGWAdq2P5+OJ/XKTobKRnbXvmuUH3VXxQ4RP32T9In1OoH
         JCA3qpMsajpTHhbZPLX9aNZ2H8md68P4Dai7t5TfGEch5J8yS1NSo1qyhW0wUaT/VWvr
         6tZw==
X-Forwarded-Encrypted: i=1; AJvYcCVpntMvtT+EyHvue3U49oUeZ3TfCtkovYyT0UsTTNHqPM51nsSCV8XaqAW8dhFS2H5aoBQxXVkfgjPPNgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84S9g/vM70kJGFnxZx9b904yA+vQGwFsNQqOiRXJdiwDbHtyG
	1u0ZWu7Nhikdbm9LQbuoquHM7FNNhp2vBFvklR5UkBhJpdLtH0pqfjXQVXdTjFRfNSs=
X-Gm-Gg: ASbGncvyz5CRwUu2UUnEK4TkRMycgp7+eKs6u1MTrWhWsaETNMM6vKtPjrxsrIVr9Mr
	nNJD2+BeuTyCfTKeL3QFXOmo7V7AnAGW3IZouQ1oSUNHywwbQiNmDJRuSaWEfgdQlCJ7BvGuKbQ
	Su4URfg+dPlQgPY7Ihud27JYCiYMWezjqYhukniK7k4erJhODabrJnsz4Hr1ztih36cmeomIMqb
	V9SiinoToFr2okaj86EdmM5CsuUnuqW6GzT/dtLGy/VAmX+/psTFYGpO4jncjS1HOww+y1FCujg
	bTgcg1XfmeBxNchYSgq14B5JMCW5XPWXH3OpZlWMRfMBcIhkdhcxpCOcQ8Ky27qvItsKzdM5Nyg
	ebtWOdB8vn+OeBQ==
X-Google-Smtp-Source: AGHT+IGHcaKjtZEYlhGDJrWLhQcx1+zeJk9eBT7KKy57mJTajg/qBo5smTbYEzo+iUzETQ0V7vpYPQ==
X-Received: by 2002:a05:6e02:12ec:b0:3df:3598:7688 with SMTP id e9e14a558f8ab-3e3c5314102mr256829775ab.21.1753792035564;
        Tue, 29 Jul 2025 05:27:15 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-509002ae794sm258067173.45.2025.07.29.05.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 05:27:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: jack@suse.cz, dlemoal@kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250729023229.2944898-1-yukuai1@huaweicloud.com>
References: <20250729023229.2944898-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v3] blk-ioc: don't hold queue_lock for ioc_lookup_icq()
Message-Id: <175379203368.176672.14343982267949571023.b4-ty@kernel.dk>
Date: Tue, 29 Jul 2025 06:27:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 29 Jul 2025 10:32:29 +0800, Yu Kuai wrote:
> Currently issue io can grab queue_lock three times from bfq_bio_merge(),
> bfq_limit_depth() and bfq_prepare_request(), the queue_lock is not
> necessary if icq is already created because both queue and ioc can't be
> freed before io issuing is done, hence remove the unnecessary queue_lock
> and use rcu to protect radix tree lookup.
> 
> Noted this is also a prep patch to support request batch dispatching[1].
> 
> [...]

Applied, thanks!

[1/1] blk-ioc: don't hold queue_lock for ioc_lookup_icq()
      (no commit info)

Best regards,
-- 
Jens Axboe




