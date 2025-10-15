Return-Path: <linux-kernel+bounces-854600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7A1BDED56
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3941887D50
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E96227B95;
	Wed, 15 Oct 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cAJz+po8"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6921DE3DF
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536145; cv=none; b=DwPMpXpP/tk0FwwEyyINfhzwL6H/CvC0tkXqG+4x3yjeWmo3I1h8rVs2zkIe9eZyepfrfg4M3ybQwTUvcLKKPyeyL1m+yh5unoSB4QjOfXJP4MAWPNevdwOuG7riSoUGWSDztmehQOwCOFTeYwMnlTSSDw04y3GfNCoMHbqo2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536145; c=relaxed/simple;
	bh=HT3gj1u7/nvYJA/61kS1+m+QfDqb7Q7pkezqn8FKGMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVd9Dy3FD5p3odwAmoLqSG+77b5O0VQXBI/rS9pFRhXEST709vCs4TG7cfxdsNL8LGJwHb/xZwGxJGRC0Ichi3TprgDJSc+6DGRNTmi6oDnVv2SJKiXxkcMtDibdf2v5uYPkYIDyt5qx+OTZkAeQeXuqzWwp09dnHfj99XV3qwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cAJz+po8; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-930cfdfabb3so47706139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760536142; x=1761140942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMbFwwV83Qg+1jJmG0XLxD4XrkMFEdpohch/EjieyXc=;
        b=cAJz+po8XfTlLeos8FYrvs7LZMUVhFZIzIxzeCKu4S9lI4/HNbvDix/xtXKXDVcHuI
         0ijA9DLqcwSrpYZS8102/PlYcbqu5J2wOL3vIBSSFNgLfAtJDhibe6QkuuyouACzUIj9
         vRu+UNH9iO98OZB/jneHmvZRxLP1ziWatQKru/nD3zxDebplI9StuJMb5YhliqRJYbar
         xk4JGtKL02P6IEf5yzxBM2xilxZdGonkAUsAMa4T1gMljdFhISPTqGohtfIn2Q2lW+q1
         TDHUkTjQCnvQpavqTqboV72mUSYeDCrYvurX6KICF2QvvJJaw/A1woP5KgqIW4lDxT21
         373Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760536142; x=1761140942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMbFwwV83Qg+1jJmG0XLxD4XrkMFEdpohch/EjieyXc=;
        b=fCyq1HZ5jqShrTwYRv0Kl0n3h8qEvrlJoz3My4qTJuyyUUOeVf8p2Rg2WIr8XLWi0e
         4eDLvJWQsvDBGLyqxsPbm27a5zGH6i4B8vgbnyep1T6t7UFouBd2W+7FkNnYW2lZPgjy
         N9KzRHWBmKwepaBDLTRCGKRBvvdk92TZ7bqmtes43xSWXPetZzxjN3uSABzodElKplBs
         Eg0cb7y6Wu9NNFpZPByuJxvM6iA46lLyKZH9/XbSdRObOq4ByFsbgO+Zu4zgj4pTeQ9d
         qmO4b6JpJCmf6WjdjJpGcQ6pMFSaUYREQnkh/YJyxkE2/DWB96vGg7mS9WNolMV3FBxy
         BSlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpxvaCTsPfwRB6AJH6tRiTCRxkZQLlq21VDG6v+Vgrjl+ZY5aIccVwQAo10/5yHD5NY+bONHSnTRNHs48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfbTC1qSbM2j4B0LxriVYio01ESi4tgbPSaZs2/6i8oGx8MMO8
	jk1/hQ5nA6IR/ilVDLoyTjbcRFuRj/YwhbNnrbaOCeuIxv/BBR2JIqbTHDT0EsRHhcA=
X-Gm-Gg: ASbGnctSpCo2i7v7P7c1FEjVthjgIhuM8gR174ApXqgleXjJbeFNz1AtJicbMgfqdvh
	ZCoMYUXu3FgG5kO1jmK36965BhIanBheq5XrnDxyrL7t7EqOD5ibjz5upUV2EhNG/zHNY1jFeXW
	nXayMUtJ0zuQfmwyNReFG1F3wrQLbHcohBgbnXQ0RMC0XAM1FMp9YK2Z5C3uZombsOet20UNVVC
	WqIPob//9Zqx3+GPPD1ZFEQH6q310IzzIAoUx5cPpIdwdvQnTG30YfPvhN4umViFFnpG1PdbuWz
	bcmuDBQsOH3oi+4Ee5+Rxz2txWvOP61aF/qOf1JKGsOs7Vwaqig6PvrfulMudB/fpmFKMoeWHeJ
	NSEyp82amxLymgpsv8sCHafxbbKZoPelVfyCD8OAsRfAfCVGL
X-Google-Smtp-Source: AGHT+IHa8fNGDE+sM3KP62soMcj2BPqKtw3xT2uQRog4kYeJMrSbUQu6nIccEpfSNol6haFAFkjRNQ==
X-Received: by 2002:a05:6e02:1fc3:b0:42f:9649:56b4 with SMTP id e9e14a558f8ab-430b437e677mr1896315ab.13.1760536141679;
        Wed, 15 Oct 2025 06:49:01 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f7200b261sm5666738173.34.2025.10.15.06.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 06:49:00 -0700 (PDT)
Message-ID: <9e775775-940f-477b-879f-dd7389f0be31@kernel.dk>
Date: Wed, 15 Oct 2025 07:48:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: fix stale tag depth for shared sched tags in
 blk_mq_update_nr_requests()
To: Yu Kuai <yukuai3@huawei.com>, clm@meta.com, nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20251015014827.2997591-1-yukuai3@huawei.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251015014827.2997591-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 7:48 PM, Yu Kuai wrote:
> Commit 7f2799c546db ("blk-mq: cleanup shared tags case in
> blk_mq_update_nr_requests()") moves blk_mq_tag_update_sched_shared_tags()
> before q->nr_requests is updated, however, it's still using the old
> q->nr_requests to resize tag depth.
> 
> Fix this problem by passing in expected new tag depth.

Fix looks fine, but you really should add a Link to the bug report, and
also a Reported-by tag. I'll add those.

-- 
Jens Axboe


