Return-Path: <linux-kernel+bounces-847283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 788CDBCA6FC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767BA3C84FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E115E24DFF3;
	Thu,  9 Oct 2025 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="UYxA8Kp2"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD29248F75
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032379; cv=none; b=qwjJg2N7wtyhOfPf0z2WjTePyAqBBDnhxO6TAlqCAMey4tMAYb8NLZnNv3M2Ahy/CBvSJwTZfrIUcvjYwZkCgma0mdLiNFRUxNUE9HBZZeEhD7MiyeRIMddOTA0Q5ypVbfl/DTUZJQ+kuU6Fj63CadtSg/PKW6E4gULqeuvY1Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032379; c=relaxed/simple;
	bh=ebOvcIfmi3GafyZIz6Mk3JkcM4lI40dZoDVr0qN254M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEpvalhvmfSI0dZzVBI9UushKawF81/+spdCXUZRWbVx8D7Jobgkh54R0OOWZbIiViV3x5oF23iQ04w3YXiMpPb5K922czHQ2du48zDNULAXRNjUUPEmjZ37pMOkP4TPthiTPa43LqGlmOQj66hUVxqoRmKLBvulek6B9rdC9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=UYxA8Kp2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42421b1514fso647023f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760032376; x=1760637176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJOsN41yoa3YyKSJ9TTkHzxgmGK8HIKNRuuL8EXcrYo=;
        b=UYxA8Kp2JwGCpnXHTTdtWeghWv3lgRedYwTpgLxsS7XazmpAyt5RSNjMyjp55zgEKg
         yI32RZX3nX3nmr7ulqNDwBq/sUJFlpPlk+yS2HTonJRLPrJkUofLQNPwIcTk0j9SAV/4
         GHLTthRjphk92TUJEB809GRHBPIj3DeMFR3wzTCYxAvmH44wBDqSflSc369T8Zj9a83R
         sT/1Hj20hMFb9sFfMyQX3iteNJ44fc8wk9xltn9D5kxt4H8Yu2gUn6KJjGUFeSqwWPd1
         p/wrvFw5lySNcXvp6OSfZzpkN0Tjuxr0tC1MKege3yJxtyZ/cAK2LULYQ0eHmaouD3BJ
         eQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032376; x=1760637176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJOsN41yoa3YyKSJ9TTkHzxgmGK8HIKNRuuL8EXcrYo=;
        b=pwQ/x3TfMvJGY/8VxGWv92f4pK4BzCMNBb1DfSK4oioQxE7+/PM8Kjs4sWckcwPFPd
         0C6SXfPq/sjETTdJjxBtKqYI140DcDCuh/aogifdYG6rC36Z7FGANtqJG1x2SrDTlNVc
         saHAET4RKoAoprxz3iPBSmW9aYJKROo9uwp8jrinISzVhdmt3Ot4vUsBrQcPo4LMERAW
         ba4RnWZVqD7JJ8a7hftFIZQ1g47hGBgbgZCH6mFh3T695KpXJUGGAkWAT+1LQSAPhS/u
         EwEknXK4tvXMZPZCo/hQ4rky+KodZt7Sonfp9Luc/s5/8UFWqy7S4dOIJh6IY8qAZH4/
         vzzw==
X-Forwarded-Encrypted: i=1; AJvYcCWpHkA8TZAwGDovRcPL2lqXeADMfYWVG2qiO7USlPiIrOs1Ow5dOka77f5WBBdWEuaPwJEIyQglWqGS3Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSeMr+ZcGdln0BMzUSZaNC5rTJli0ExgC+PdBfaYEfaF9YnPa
	nhnQlcSI/V1NfArUZn4PMkf8+O8Y1atBF9gbyFo7HPsPRycPbhp/BWq/0BWI9BqZTK8=
X-Gm-Gg: ASbGncvSpEXNYfVUs8IvmzivnQwhpHnNj2JJZa1Dx6nXJEx2Kep6+f6Lzwcl85ikDW7
	Tf9Yxcw0zaItFiGtZnnZXce1G7wRciO85OrJm7XiBhBJ018UW1cxjJWQsZ2W7f7B+Y5rBNC+kzH
	JdiL7oinYDAS9B82K0l2tgNkizs6pvQ5UFj1CHk7IQC4NvbCR1IuLK37VdvaC9Wk3yQZiKdsUhn
	HLdh74NnZpD7PL4FTWQld3qi7A7RUfumj2IVd5BsU3SEAgBr2HDrdehriDPxVffVSwdfcTOitAH
	TNNbYhh9QtyBioTlI7CljO4d0JKJz/Q2fx/9twYcjGKVIxEG2D5dEMQV+8M0oQFxukfJCcRJeej
	Tyrg+7ij6WZzNYQCgjdbdkykjeKbieU8=
X-Google-Smtp-Source: AGHT+IH4pkZ5LUcz1UVUD+dIXY7lwVVUALuhd5+O3JFYRmZLgI9Otm/vnGqmQzZUzY0VBhTbKmteqQ==
X-Received: by 2002:a05:6000:4313:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-42666ab29d5mr4804842f8f.2.1760032375892;
        Thu, 09 Oct 2025 10:52:55 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3d8:48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e81d2sm103917f8f.49.2025.10.09.10.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:52:55 -0700 (PDT)
Date: Thu, 9 Oct 2025 18:52:54 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, jack@suse.cz, kernel-team@cloudflare.com,
	libaokun1@huawei.com, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <20251009175254.d6djmzn3vk726pao@matt-Precision-5490>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
 <20251008162655.GB502448@mit.edu>
 <20251009102259.529708-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009102259.529708-1-matt@readmodwrite.com>

On Thu, Oct 09, 2025 at 11:22:59AM +0100, Matt Fleming wrote:
> 
> Thanks Ted. I'm going to try disabling the stripe parameter now. I'll report
> back shortly.

Initial results look very good. No blocked tasks so far and the mb
allocator latency is much improved.

mfleming@node:~$ sudo perf ftrace latency -b  -a -T ext4_mb_regular_allocator -- sleep 10
#   DURATION     |      COUNT | GRAPH                                          |
     0 - 1    us |          0 |                                                |
     1 - 2    us |          0 |                                                |
     2 - 4    us |         41 |                                                |
     4 - 8    us |        499 | ###########                                    |
     8 - 16   us |        246 | #####                                          |
    16 - 32   us |        126 | ##                                             |
    32 - 64   us |        103 | ##                                             |
    64 - 128  us |         74 | #                                              |
   128 - 256  us |        109 | ##                                             |
   256 - 512  us |        293 | ######                                         |
   512 - 1024 us |        448 | ##########                                     |
     1 - 2    ms |         36 |                                                |
     2 - 4    ms |         11 |                                                |
     4 - 8    ms |          1 |                                                |
     8 - 16   ms |          0 |                                                |
    16 - 32   ms |          0 |                                                |
    32 - 64   ms |          0 |                                                |
    64 - 128  ms |          0 |                                                |
   128 - 256  ms |          0 |                                                |
   256 - 512  ms |          0 |                                                |
   512 - 1024 ms |          0 |                                                |
     1 - ...   s |          0 |                                                |

Thanks,
Matt

