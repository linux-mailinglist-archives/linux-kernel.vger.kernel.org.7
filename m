Return-Path: <linux-kernel+bounces-830434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05FBB99A55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D6B323B96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E3F2FF178;
	Wed, 24 Sep 2025 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="20M06Zfq"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103AE1684B4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714525; cv=none; b=B4dCj3z1QY1JqBtHQVW0kdTsx3bEV5HmuscFOnwpAYVRV8e3Le/0IqnTLQgGa3WYvbN6f5bYrBaARpPntlX1Su7+ijQ46cPW1Y2QzPq8lkwxnqNzPAvimDJERwyDqeGSJ38fo+YuJvPOShe6PhftJeF/dea7AVtOPAHxx3b94rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714525; c=relaxed/simple;
	bh=8wa1ZLHn+cg8S8nHQAlXq2ZdFV4bDju8o007GcFQZ8A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ONxn9QwRVMHwx2V1rPdfclaw1d3G4PUeYe+F9dxd8BWE31qW+fRoAP2kE8oZQ50giPiJ432rL96dvdj4tOaVKB7KL0jjXmRoMCZ8zdO8YWbMzytjut/LdBZDLg/BYlVR5G2lh8S0ir+ajt6n4KJYsR8/IONrisvm4KZljjnvYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=20M06Zfq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e1e318f58so17187955e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758714516; x=1759319316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XL3pj95EhDFRWDVYUB7ZgnLiAqsYtgD7zX9Xu/MZ1Ag=;
        b=20M06ZfqgyBotXhZ6peh6krIclXZM+lwqOSZMMIqse4Z+jGqxOmURdUf23+vuHYSF6
         FHIF6GMXOrktUf1oRDC+fC4B54o2NQnn/CJ6az1n7SuyurgM3N82xv4a1qnTQF1H6QrE
         D0YfRnC0AmAanJXSK/jHnlHaRRpTUynaWlSfGi89PTEENzdnBsZSYicQlrSW65jdra8u
         g13MF1Ol5yWHPAeHZuQp+tE5LBSW3A5Rf6EzNVg7CwOMKnaiaB11BVOSW26bniS3J4fv
         XeEqLc4y0iRGs/V1o3JlEcZ9x4py8PgcZoFQ/yJoM1ms1qgX47cja4a4JV2hk5J7U+5G
         +QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714516; x=1759319316;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL3pj95EhDFRWDVYUB7ZgnLiAqsYtgD7zX9Xu/MZ1Ag=;
        b=PuzM27uY7/UWKsauGMQkjT4TSzUcHQZb8ov9RGhPD/I4sT/xr4adv4EJXKi4q1NlSL
         K0hCb6FOQhb4dFjQ/sa9KpYdPWbG5jfGH92sRgvxgUHnxBoJU8cheDfFhV/ioU1f4NCh
         uCwHba6x1HKRu0nRT9lxUZBIlnrlX4vPZuHxeD0MWIgJbJNgQPCbfFr6HGz1f+OF07V7
         0wtt4FKw1HRq+6us+1mEZSqGVTQgRiFE3TL9Z2wyUuauPt5ar5FolQJqfYkLKbJY2lD3
         gz7AHbx90ijbH7BwX/ZNbldgeohQtLfW2xf/6cIxCmGa1AOu4DMTRvjSDA+dTIHQFsVn
         ZDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH+az46ZNGVQ85ezxMRptlSfUSEeeH36ocIQbR1u+WVAuEzGh5XSxzqDKGhUxkPa6v+GPda6X/jGwlpfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMOdBqzZsERWdVtKr078gKP1geNvp9u7+nsPdRyrqtCRNgivbL
	6EG7FqVNNJW7B1lUFvgUWUnG/4hx/mL1jczJs2VREfUuu2nS3KuxDSDP8W2LlMKPeTo=
X-Gm-Gg: ASbGncsCbSJGqUQHJ50/8AqjXecGTHWqX+LzfgIpUULKIpvDRh2dXIG1A9JGCd2Pp1n
	8KJEt0xWj6kW9BgqgoCqptZi3rOlT3RB9oN2rQLlzcFE9OZWH2h6QM7npQFeacYxzJ57msxlqrI
	jiEwPriRvuYESo7JyvTau9S5Wgtq8pbYHQXUUBkM8sjjc1T7iOZjiDeSuRY7MGolYFH1YCIqnjP
	QPq60P8KU5qeT9Lvizw4wd3Qu7U4wuZ3zlfNhdR2cwhFldyOvN0REchUhXag0w8cf/cdyDb1Yel
	MOH9GG07Bdu5HrS4P30LHYmPzinRFOyzyygO5AtAi2IeheJCW47h+eAiMCq4W96LDLhLge+W2DK
	D2A2a/QOOTrNTt/at0Q==
X-Google-Smtp-Source: AGHT+IEltzN+Phzm/vgIDV/CDKiL0LHpsqh9NTpeatvcZoFTuaa8yQ5OZWw1bFDTJZAr7bLrkq2aNA==
X-Received: by 2002:a05:600c:4454:b0:45b:9a46:69e9 with SMTP id 5b1f17b1804b1-46e1dabfdb7mr67404585e9.31.1758714516165;
        Wed, 24 Sep 2025 04:48:36 -0700 (PDT)
Received: from [127.0.0.1] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31bdesm28162185e9.11.2025.09.24.04.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:48:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com, johnny.chenyi@huawei.com
In-Reply-To: <20250923075520.3746244-1-yukuai1@huaweicloud.com>
References: <20250923075520.3746244-1-yukuai1@huaweicloud.com>
Subject: Re: (subset) [PATCH for-6.18/block 0/2] blk-cgroup: fix possible
 deadlock
Message-Id: <175871451525.316144.5136709409891330252.b4-ty@kernel.dk>
Date: Wed, 24 Sep 2025 05:48:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 23 Sep 2025 15:55:18 +0800, Yu Kuai wrote:
> Yu Kuai (2):
>   blk-cgroup: allocate policy data with GFP_NOIO in
>     blkcg_activate_policy()
>   blk-cgroup: fix possible deadlock while configuring policy
> 
> block/blk-cgroup.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> [...]

Applied, thanks!

[2/2] blk-cgroup: fix possible deadlock while configuring policy
      commit: 5d726c4dbeeddef612e6bed27edd29733f4d13af

Best regards,
-- 
Jens Axboe




