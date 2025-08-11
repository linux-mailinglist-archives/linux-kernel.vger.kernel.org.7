Return-Path: <linux-kernel+bounces-762818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E26DFB20B25
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4103D18C5674
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC95A235346;
	Mon, 11 Aug 2025 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="C5MRKQUH"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F584221F37
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920913; cv=none; b=HyI/qBInbU965lix6tSB9nhw0MwAtqea97ks056rYx+DMY94Cya2Rilg2HJ6KrRgDAIB0LmXmRukjP5vGDi3RvS861+AIOR1SsBVTO/F7e0o1VLmJY5rBC9gyjVFWacohdrvc2M/NpRVoacBvzOg5A9Kl8PZnzUGTLL6zJLjFHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920913; c=relaxed/simple;
	bh=y0zIX+KBoOVyLl1lGcBqZ+e5rFzymnFo9tPUEW6YMeQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MaQvQNhvzIaCai4CbFIwPepRKULzg7lSMS7oDOUQuz7Rxjhk15A0Kf295uoHW/tkY3HqLk/CYEoFPgQQFKLKoyAHf4GVSeGbWqYo4t9hiqiKXSQSF2NtJz77+sJ9aILU9gWhD3V1VI6v0j3enn2wEX1ZTl9nJvXeDyAhPh3vBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=C5MRKQUH; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso4820623a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754920911; x=1755525711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Co7Mq6oJyrCqVWs37l+pII7jWFOL/0/u/Dfz+X4plSU=;
        b=C5MRKQUH5CUxmw5MLOVMpeiTBJPEPIhFcIpaem7uEwXa7Wrwog/fvCrnVSXCAoAGVN
         e88shQkNVUWpZQ6Nr/EVi/NKIS1XlFS95nSSAbSFxdxI6Ep5NeV2h3RTqFJc9eq13VTE
         +AHnNb+9MMQD27zoLCtDMzZz/+GWt19Zv7W8oMaukVV4Hu0Hgme5IXwWFHt/ObBQUC1d
         TSGp6rRF9MN9GiLuHVIjFTwtdo91jmGGVLNhVuNCrVTDDqyXj3oJHfDjGpnw2WFdz2Z5
         kHmiD8MGor82oDnZhEue9Zu7hZeoPfwWt4rlms52qOERpl7eab+Q53NUGxs1Qu6rXxdr
         pVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920911; x=1755525711;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Co7Mq6oJyrCqVWs37l+pII7jWFOL/0/u/Dfz+X4plSU=;
        b=oyh/DzS0T2As17Fq7JySV7Fevr7jZ4XLVzrt02CQynAKrdhetazQxig1MHaxkGsrQP
         Xt9riFd16YDmZVbI5Gd6f3lfg8sJzhJEn0wPureRQ+RsEabBt7l9XjmhzyCaZfr0RfnG
         a3JK+mqHq42ORNKPMFWUptygO6sKegj4kN4ZFQV7GKxoO5otAXliMVBByVmLoF4cck9t
         UKSMGrjlLIvDaYUPLIj2oWp4CVJayq4mgbJ0CS1XI+VZRnn7tPgWNQ3UuibChZ8pHckb
         +gRLLhpaEl05/rxlnlqB4JeiSH3FmRcjWeyUDwfOFCqopoa5KkVYoDhINgyNxwyizgJO
         X3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5u8p4yesMXFyit7ta5tAXzK7PrlBu80DtmBE7Q5zGJZ7m6xBEpJezdCZarr1lrQu+0Wo92Dh5amVEWpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrVgZmtNkgWQ7OGGRfi6nQgejjbQBTMMlE7ym65+YOuxrkMMVh
	P4+PyKCMh/27JyxrxT/wsPDleCuvyjs8ot8L7l41oJaxfQ4uxPi9FFUVOgytafpE84YotcSp6ZK
	lkmF8
X-Gm-Gg: ASbGncsH/lczpTtK2BW9KIQw7sRBfH3Q4zf5886TUDhdt1xm88/Pl56oMXmsOXT+B3d
	n0GMMUtuzOLC1swyT9BnvpKuytO0rVfD1UKDYXTBnowYK6etlHXJQE3wAAQvS+PR2OBoGTnGHXV
	RQjnbuwC28fb6KDYbcXi5mkNEvJA0UMf8tRRp/v+C4twzYWdwh30/1o/7E0wkIngadDXLVA530Y
	UcjfpoQprUe5P/vTCSixjYtBcVQ/A3JLq6GZ6rvAAQgbA6x+Sy87aYKr6BjWdSpxWemQzx9fE4b
	WFML2i045+92eHKQu3ucnnofg95H3+MwQMhacCfBROJXh2pdnSS/0bmNgaPoGgIyx5ZjvcBDds4
	MvlkqLW8O44eC/8SWeQ9YIM7YpA==
X-Google-Smtp-Source: AGHT+IHdapQQqIEBFEuAI4fgLuc7zanwo1g6eAIPxfo3wR6CEjTbZw+JPfriC+9e8kRAaZJLbRghjA==
X-Received: by 2002:a17:90b:48d1:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-321839fde25mr20913876a91.15.1754920910599;
        Mon, 11 Aug 2025 07:01:50 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259a48sm14821216a91.18.2025.08.11.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:01:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250809141358.168781-1-rongqianfeng@vivo.com>
References: <20250809141358.168781-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] blk-cgroup: remove redundant __GFP_NOWARN
Message-Id: <175492090902.697940.7586040071360422708.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 08:01:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sat, 09 Aug 2025 22:13:58 +0800, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: remove redundant __GFP_NOWARN
      commit: 196447c712dd486f4315356c572a1d13dd743f08

Best regards,
-- 
Jens Axboe




