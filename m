Return-Path: <linux-kernel+bounces-846595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC7ABC8762
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9CD188BA02
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FCB2DA76D;
	Thu,  9 Oct 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="U8II0m/C"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851B92D9496
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760005385; cv=none; b=q9wIfajr8Ub+oYrdYwgQTxpEyJXlAKFEdFistC1+1EDmQ71Kcdi7TuzR3dOTr8Vzoe13tGoh+Ac2+STtcNpUC9MKvQT+mq0lxZtSadwPYttH8eGsW9/bY3mGPeuttDyrXIjLnfVahToeIimz+70wk4vWQI+sVaaLhYR0jk+LvYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760005385; c=relaxed/simple;
	bh=l7QzGI7FmuzLiWBMITL6HLIWO89vnW9gY5iIdUxjrpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=bDuapq0uBCtt0aTE6+gRL5zPcVVzdLngkOP4b/SttBLEyNU0ytPmX7u8YjcCgrj7/iylQMMertHirSIZBfyGMad6dViMS5Jk/J1eIjnuajA9IoxWJNIrV+VDOUUlAZpgFSwVTxSn3hklPDcjAsWAO13MNXeMu4osJjgC53GEM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=U8II0m/C; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46b303f7469so4596745e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760005382; x=1760610182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7QtmyaStV9Cg/SiLzcIFBH2QrCmrrCZZBI5xKAFZzk=;
        b=U8II0m/Cj5yciEwOhl+9+q2n1zL0VJ8txNNESrxpElyWHbpGGnwHprG6I+gMXghbhz
         GWFD+Sn4Fwwd/EzexRWS3+hwlBhwKpwkB7dOqzm+PeouxhNCYAwjjeUUAXsXc0YDeRqZ
         57Xdkk/gqHHmztstOKP+Qx8ypu+0Rr0Gp5W8by86jueg43t9OWW8Xqw7E0ELFFffO/XW
         af4hguikER5MQXTVRKziRjCADGg/ZIFtQd3i3e06rKm7NhumQgmozG96D8lWpKbDmMQw
         v66AL9eg9xh59Ov0hsJExWjrdJ4a7yjES9RPZH0aKyvMu+hXdWsPrURGNh8vI53ayfn+
         kHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760005382; x=1760610182;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7QtmyaStV9Cg/SiLzcIFBH2QrCmrrCZZBI5xKAFZzk=;
        b=h6UfN9kJ/+TzEnVCJ9YvL1jgvF+/mS77RCtPumiua56qYuxpTfC2FAh6mHOWvJbFPE
         xRegtCmCQbyxaIuK9WarRVZB2KOiaUR0hOqtk/Sn18NE/+6o4QeI90WAePYLCUbBMZP1
         0MW7QddXr3QsMdWOBEFQwTj0g0eXysIAp9yIPbHSWSzVDVaJdU2CdXybVDclXiZ9Q2FV
         SWcG3mx1DkvYhB8CrsznpbOJuj3vjSgnyGN2EZzFFIXcumC747KNCdSUP6fbI58QLrUO
         hgKcyY+1bfFpus0rtajuAioxILPOxcM/om090eFsqJu0a4vg/YU79R3qYqlGgroqWrJL
         g0+w==
X-Forwarded-Encrypted: i=1; AJvYcCUu2hLN9g1vg77OPx8DEiR5W8l0bxklBC7k5CRoasGkHhj9YDG1FP7Rs3s2rn1cO2A6UZvSwO5P35pKNSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPuya7LY39Vh7gXKqI202dgNeKLNdYfwBw8zRzFL3A0FML6El
	j320ifUud+r7G/239FiMr/9YgTwDgPHt/T1XCB2Oiepf22K+E9m3w6DFHmquG8e7Izs=
X-Gm-Gg: ASbGncs+g+/NUIacRnNJYppoDGBUmKw6c6NcFuRgrWvJMxjuCjam2NFBOx8DFy4Jkut
	EmbpiVaCIZfUgtLVXFRqjuHPY0hnmA71R6od0VJMMcNno+Xu/ryOVwBHSGseCGaBTrRXHkfDKUp
	5PmFu2Z9RN540Cnz8zOTrX2N8cYp1DMxEWkP54kAAhwdbKorBs4t/XzKgM+oU08hML421rvf4V5
	1KRMa6Y7eUYzN1pWiShEhNJPpuvrDCZGUuJoYhjVTcM7+sy52VjDheH6DIjWETlAPeOgRbqTjiI
	BKQTijU9vf5sczJv+14SgXSVKw8n8D+z3rBTW5yyGUNHcUw4KvAfKPqFhgRaG0i6wbmRqnHsYGF
	mFJpcI5N4mex4127IK4K5Bpyi63lN02MME6CcGaxsWDyEH1ersk2GCgvMeA==
X-Google-Smtp-Source: AGHT+IEStIkragv6qCXCo8V3gHP7SZNoyJGu9SkTjAiRd/XZfLMJTPJ93VfbPipyaCKgSacW7ychVQ==
X-Received: by 2002:a05:600c:528b:b0:46e:6042:4667 with SMTP id 5b1f17b1804b1-46fa9b11b24mr49480295e9.33.1760005381887;
        Thu, 09 Oct 2025 03:23:01 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::2e0:b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab4e22d8sm33204695e9.5.2025.10.09.03.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:23:01 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca,
	jack@suse.cz,
	kernel-team@cloudflare.com,
	libaokun1@huawei.com,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Date: Thu,  9 Oct 2025 11:22:59 +0100
Message-Id: <20251009102259.529708-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008162655.GB502448@mit.edu>
References: <20251006115615.2289526-1-matt@readmodwrite.com> <20251008150705.4090434-1-matt@readmodwrite.com> <20251008162655.GB502448@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 08, 2025 at 12:26:55PM -0400, Theodore Ts'o wrote:
> On Wed, Oct 08, 2025 at 04:07:05PM +0100, Matt Fleming wrote:
> > > 
> > > These machines are striped and are using noatime:
> > > 
> > > $ grep ext4 /proc/mounts
> > > /dev/md127 /state ext4 rw,noatime,stripe=1280 0 0
> > > 
> > > Is there some tunable or configuration option that I'm missing that
> > > could help here to avoid wasting time in
> > > ext4_mb_find_good_group_avg_frag_lists() when it's most likely going to
> > > fail an order 9 allocation anyway?
> 
> Can you try disabling stripe parameter?  If you are willing to try the
> latest mainline kernel, there are some changes that *might* make a
> different, but RAID stripe alignment has been causing problems.

Thanks Ted. I'm going to try disabling the stripe parameter now. I'll report
back shortly.

