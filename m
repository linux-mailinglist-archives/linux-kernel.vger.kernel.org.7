Return-Path: <linux-kernel+bounces-778420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CAEB2E575
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614C51C85487
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D2928642E;
	Wed, 20 Aug 2025 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U2pcuD8E"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B625628642D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716812; cv=none; b=sa11UOD2W13hleiJiaVhm8LQSXxw7cnRlpym1lJAhWRmV8+X1qmh6jQiHkkQOrvHWIPtBIBr7lkVvT7phdXyTbjUcezxpJ0cU/AZhzvN8QGxcN6Pkm4zzdI4P254mWS+icZsAGxivDlU6p+q1kJIwQ9riAs+mdbfTIQD/X9CWHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716812; c=relaxed/simple;
	bh=FMpA4RSm8ne9pEdJlb8jlNv3zSaTEZX72+fA8B7cDZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okVZXTXYh+4HNNNS22DpRMzJOPXKL76srNENEyKisQ1jXRAv2BOh6Q/9XWUMQ8o/dPnWV/5cOJYN1lvfS5/cs1LCTzQaByzarsVTTZZGJnirJh5Bz2fdVToVAf3FoPBg2P1gpeUY28dRVy1+CPsyLPwBWC7+kfr52ERn4EucGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U2pcuD8E; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e570042988so1312625ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755716810; x=1756321610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63YhklUO+WBFbPxAfzObLOK/MHzwz+yybl5BUcMH4q8=;
        b=U2pcuD8Ec+SgkSLr5SZdCxMqhzAQIezncINp8Q+KVBBbCj5C9Bgg7tqvufLatE6uhP
         Zl2s4ZXSC4kYu3JAnl1dm1NFYALyldwECl587JcnBNw24XaigVoIAGA3lWZEiwpXiqN8
         EZa6LjtVhDwLrsW4AFGelvyYmg0APUN7mcx0sVtnm0tOYiQJrOfWznEqu1MqfZO27mKU
         cj1bDBnn0/xaaQPooiLy0FYLKfSFA50pa5ZQqa7qywyLsyf5cUYVOVUFPvUV9tYv74Xy
         8XNXICu3KrDWH1LH5kH+Kf409OFBX6a/6p2JMMpVQLctGNNyOpjnmx4x7hGtS6VoePYE
         yRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755716810; x=1756321610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63YhklUO+WBFbPxAfzObLOK/MHzwz+yybl5BUcMH4q8=;
        b=bfE5berLrMj1NPw6DtrO5BJrqPkI7zSB3Bgg3vhVW3vC/tlj4yln2sbUyaZDIV22M1
         sFHOTUj/X8ACt/eSNo9MoArwBOty1/0PMWI/VN6YS3ubKSxfxHsWmDQZZQ6tvmG2hhx8
         G4y5rCFvSo7Q+b2IBh7Xu+8gUErn/crXV3Nptledcp/9qofrwMMaK4aN0AVu7JjWB3XY
         xwMO/D4pTAohNDxT/t8MJCq9tt3srf14eF5ycn7z2krCahxODwmNiAK+6/TncHX1gSrN
         ielzYWuqERqJZsv/NPlJ0t6vNrKzjxFp+O1q5/KQCHaNF2yMfMnC/g0tJld6F5FH5K3+
         NmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH6tNHsaw3RMQUQ9LgalLCmgeUI7wJ6nM70WnvQdx3HEjQY/zN5PxF8nG7onhP3P+GTkDkMbStC/auN5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU2c8YYlEXzYQT7jsvFL/GemUpP7BDot8MdHat+CYtlU0h0Huu
	zkmDiM5eryzUx7QGoPz7SzFxOVimwP/xX9Q9udXvCWbmWJkOMbtq4wfREyvpZk3yO1Az0DpqaRv
	3/bUe
X-Gm-Gg: ASbGnct09f/6XgpTUjAD2kPqo89+pMrsSWvdhCd9YFSrmlrfV+ZunDXyENJt9C9Zpoj
	OibbFNuyyxIS/55gpFxXVwEwErVDk01VwkvcuzDoNVHDXDALh0ivBBt404Wh5QUoWI4TUD5XYbf
	CY/IpFBEcgtJgFEBp+VZHr8uZqgjeeNNuTB70dHZM1KLTSXpVHTws1UXRyIqFwwdjgksrzL/Nyo
	kyvhU8j009nkbwS8PRut1CM5NEzodQGxx08nOWTDX0SGI9d5X1wmBSA96lnJvLcexhXW6MNNY2M
	hWPGzEZJQuRhV35ClapOdqshk1FqXyq1h5oP0QZePpz/hUX5e3D80OH5UWdJeZ1cssp0iFYQzEo
	aoRtDDXJ66QWy1IT2BKc=
X-Google-Smtp-Source: AGHT+IG16BboURgH4OQAeM700nXr+sqks1yvd2HCItALLn4nCvwET/cZqXVm7nNt/gYksZV58tglCw==
X-Received: by 2002:a05:6e02:219c:b0:3e5:4da2:93ad with SMTP id e9e14a558f8ab-3e67ca09140mr60072095ab.11.1755716809749;
        Wed, 20 Aug 2025 12:06:49 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e6cd0desm57826545ab.46.2025.08.20.12.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 12:06:49 -0700 (PDT)
Message-ID: <1c482f1d-2696-4f99-9563-c5d88a520e91@kernel.dk>
Date: Wed, 20 Aug 2025 13:06:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fork: kill the pointless lower_32_bits() in
 create_io_thread(), kernel_thread(), and user_mode_thread()
To: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org
References: <20250820163946.GA18549@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250820163946.GA18549@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

