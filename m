Return-Path: <linux-kernel+bounces-720319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7395DAFBA3B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62EA14235B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F843262FFE;
	Mon,  7 Jul 2025 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x4/KvH1W"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9507261586
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911102; cv=none; b=ExTnT2XiTdIUeGPII9PQ1k+WErA2wqo4HCQt+h2uGWbDPwSFIr572fuBkb/ZEHQanzt0H11g5HsPT4noLSU3KjLhSespNZmG+XXFslfVXbunn4qfruwLP6c64TYzTQ1ZZRMBwB3nUXHyV2o38DY4sNW7XBjAQfedMX/cAqmS5q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911102; c=relaxed/simple;
	bh=qEZzwgNx114aChLwfBaiCeTmO0r+Yco9pwzWbMScF10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rf5LEzNl0pj9DUKs+pLCdSjY0Ui6OdREBMn68yK89Lu6pq0XsPIvYj34x7rX0sdniI9L8f1MZi0PvD9MlYxvuhHsA/Xzgxm6T28D69JHPLVo6XMh5Afp5AwAiL5CCJUyvlQbi44avv39oOJGMgxPaw00M5xUJ2giUloYtjSvtCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x4/KvH1W; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8733548c627so122650739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751911099; x=1752515899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlhHGSQ/to5JfREBHMuV189z1QcskZtPpPgZr7K+mgw=;
        b=x4/KvH1W5PgzQgq7Se63/yXav+Lw9KuJEBOvnqr+7Fnrhr1J+3whkW2VJthstqgQLm
         a8DNn3Aas6D76iik47u+OOgsMrKIOwPPzAy5jmuN8jmaQW8dnGQsLP/2g8jwL4ZHxgCj
         7v6nYY51RbW+MzxQgG8av0StSIhrOJUNsGCVbspU1w9dKV10Ip9bKgtSDWfTAjNm+kA4
         UYYL847mbTpcC5ifcp6NnxTJ1VoWy0UlyVBAzgcJyB8Pyg3EDojDPN8DXARd+87nRjOv
         Me5gV8uvgIuP4w7Yv1ft8ZH4beNxFJT8VRKafVLd73Jsfby/5svs1MeK/bLF00zfnC47
         VCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751911099; x=1752515899;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlhHGSQ/to5JfREBHMuV189z1QcskZtPpPgZr7K+mgw=;
        b=SkgDbWxJRHMZ7Q05qzz4ntfC+1Rzy7+/a3XTea8wjz8I0Sruc5+oemp96wv2qsWZjs
         6YeYiY4FGFNizEG84U6yq4VEipP6q0IQXi2x1qT3p4W2E0CTDbBnFNw3NP5jZwxdTv2s
         9i0CfWOuZKXaYCDxhNOzoILS2KrQhJK70p6AQoKLWnL9xiqQCJ48IYV7t3QfwdFLMMhr
         PU8/+Bugj8S7lNOomjrS5QjZ6Jem8BYQEfnQT0SgePRxI5OgmeYOtYiT32LJatb8OT3W
         sQAMxZZ1MvwHOMAv3VuCpWSKDVbh+HgOqxPQcwGff9KURwCi+xLzXpF5QRNfl4KuOejN
         sOwA==
X-Forwarded-Encrypted: i=1; AJvYcCWn8WQDxfnXpXbShbUYFb3v7/Y8k2i/fZaroBYpkH3/i1nho6HmuGy64u3IExXVIGchj+0OaoB/emwUG+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1CjZE4MrUf9KfwAh0XT273SozTbciMN8bGZJfocqrjbv1i5iV
	fEASl1nf5S3SAZ1ZHpZAgM/ihPQWLq7d6Na8ti7bexsW5OK+4YETVykKk2FZm09iZ5g=
X-Gm-Gg: ASbGnctYIWTLt90WgcmrZRUSffjRoWLsITbcR2WIWTpxw9bujxs/15QIzGdIku1NM5/
	ntKUGTCLgUbTvflMPqKM9kBaHRU6jruqjaqz2TY4+ouhP6+CGfu+A/pfo884Nnd3h2/4H+IbSMX
	wuRe8hZt6vacEZRAAa1Yy7rBIEfShDXnoGnhZF2zVaSsCWSUbsD9YSFGTD6pGmgqJECJiJDhVFe
	Ciwj1Hwi93+V6+LVZgWQYmJEVobp7ZR2Um7XsvYSuCrGg0NsOqD4aKxyZuWe3K9krwQqJ12SgcM
	yfVlhn3f/gVUUKQVF51KKXVgbv3kzQD06ZPgUDOGdoBAP6pZqlOA
X-Google-Smtp-Source: AGHT+IHa1FHDNudpmCs6pJOo3hbLurChWIWuq7ec1KKGFj63vxcmH/wNCoMl/kC22BeFZU0wtqnm9g==
X-Received: by 2002:a05:6602:3413:b0:876:d18f:fb06 with SMTP id ca18e2360f4ac-8794b0275e0mr6348339f.0.1751911098772;
        Mon, 07 Jul 2025 10:58:18 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b5c0e72asm1773155173.100.2025.07.07.10.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 10:58:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: josef@toxicpanda.com, xiubli@redhat.com, prasanna.kalever@redhat.com, 
 ming.lei@redhat.com, Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com, zhengqixing@huawei.com
In-Reply-To: <20250612132405.364904-1-zhengqixing@huaweicloud.com>
References: <20250612132405.364904-1-zhengqixing@huaweicloud.com>
Subject: Re: [PATCH] nbd: fix uaf in nbd_genl_connect() error path
Message-Id: <175191109743.897627.1231024341560474795.b4-ty@kernel.dk>
Date: Mon, 07 Jul 2025 11:58:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Thu, 12 Jun 2025 21:24:05 +0800, Zheng Qixing wrote:
> There is a use-after-free issue in nbd:
> 
> block nbd6: Receive control failed (result -104)
> block nbd6: shutting down sockets
> ==================================================================
> BUG: KASAN: slab-use-after-free in recv_work+0x694/0xa80 drivers/block/nbd.c:1022
> Write of size 4 at addr ffff8880295de478 by task kworker/u33:0/67
> 
> [...]

Applied, thanks!

[1/1] nbd: fix uaf in nbd_genl_connect() error path
      commit: aa9552438ebf015fc5f9f890dbfe39f0c53cf37e

Best regards,
-- 
Jens Axboe




