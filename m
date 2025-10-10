Return-Path: <linux-kernel+bounces-848224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED88BCCF30
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5602E404AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B896A2EF65C;
	Fri, 10 Oct 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="M0N0E6SH"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8E82EDD62
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760100166; cv=none; b=XOTaTLNsw3RAOeDQ/e7F+xb42AyikkaQWf9dDH/PTIceUw6dzEtdVU2t0y2f1z93Gyz0w7ThxW5VXYOYdhVv8pnbXXIXuy+qI4p/iUmVyyu4FAgn/I63YixvHSYq36rvrVQo6FCmliVj0KIt5hUrTVoRklkvc2Nm5c4qng3lHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760100166; c=relaxed/simple;
	bh=au8PLeyI2+Pe4ULs+APkVrpzfMg+hC+ART9veqXOIk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUB7pPJios6kGluoUyrRcZSHmWoLfy43GHM/R/Si9hkfqZY5sCl3HqQDQoTfG8Un/PfBG1R8wthzXtDFMN5XELgpQJZgmVE+bFd99fQ3yjGsaZx0pAG5nt7ZI6LW2nTtMI4eAmy5TuVfhb3oMcjjJKbLPrjkRkDxqX2Glb/7Bqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=M0N0E6SH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1622366f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760100163; x=1760704963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ed6VgS5iZMO8gnpHzEOAATrMdAcan5FzzzLKhhlpKCc=;
        b=M0N0E6SHVT7jEPhWbMedq6miTm4XYWvWPGIQVDSCc35fp3kimxN17v7JZO8yW9mtgS
         fWyddsnJeqD7IkHnC6E9bRGLpYCaFXuDLeBUKCfNlLsyJZOkalrm+yrWWr8W3KnoSzlh
         OxdPOELQAJVmGQsVqEc3ytB6J7k5DmZMtmSlf+dgRmXujkY2E+kH6Dqzof8o+zzbuaI1
         XuZJkY4/T6qXHzxeB14dSnrUzRGVbvYt81Mgfa3dkjRIrTmEEpWmrRtIycPan6PRZKYh
         tKUXBTxKEST78QQFd+y+uFYEBMGGu8ArGi71fGkQ5RJlA5YtqbVJxeAOcHf9dy2i+z0r
         25YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760100163; x=1760704963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ed6VgS5iZMO8gnpHzEOAATrMdAcan5FzzzLKhhlpKCc=;
        b=AMlxW2X9YwYARbSym1YMiN2pC+gtAaWIktwGwNGh/REQUNs8H/spbpLYv98t5UurWP
         eJFhMyo1UAt44ynR/IUdEZJ133QS7R4zf3EIkfLWVyqXYCAsbFUo43zZrMMs7ikMEx46
         GbPY/Aokc7z0f/0dj8UZskIhXPRUzFHjVbVvEw/xm4XAOPRE7dMrnhW0rxhER7pmLkkF
         5Gfnry0eQYkGAS1saanIrszL5s+GnzqfOZEhaIEkfUk5xXxEy7i7V7V20dPZKJhoxo7j
         qaGrNeUV+DK+zNk23SjbCdqhyXsZA8z/5xrOikR0HzeBGxkWHg5tITA8x536UGUFf7AE
         qZTg==
X-Forwarded-Encrypted: i=1; AJvYcCV1tR9Bxvm340aorRSYB1QJ/Bh+68p+abNkvWR4R5eHvruElq8NrQdOrgZVpHuUSDW0IPJEeyL85R00ueo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYoSlz+DgCymJZexcfHf2goztX1hDqACUFZsR1HUmgQTwtpPG0
	CLZa+/47tXxe7fbApktYBe8PU77RRuI/N2E0fEf6+fX3u3FhoY7B8JSn8ppZY1MsfKU=
X-Gm-Gg: ASbGncsGauvqF1XMty2nO9Aq0jAJvGlllYdsuKskKld4nLGTzRB/xX30LG8BvUyyegR
	A26ZrIku4vHzEyU8NABgssuxKJarTph/Qk0RSf5BPB36/JOk1Mz+txy0+EteY/mwp/KYQDS3hje
	q3+doj17NQUk8MlCJlOmKbtg2fL2PJAp15SlFFZ9hlLzFkXcyuwbVYRl1+BUSV2Ec/dRY/AZd37
	0XalOWsFarggSEQXpmIT90oSc1mvCsEo+QeQO0wB+BKpZYYXKMZ4NgojaptIjt21UsjkI92r15Y
	ddu1Xd2FnWzZxAWE3h8pu7I3snZdEtQvCyj53WNra5DzcNDxlP2c0BVA9M/0g4bpI8JW9o7JJLE
	jA4aSZyMBSnS2Qa/fkYWsH21zMuSnHaQUkqAs
X-Google-Smtp-Source: AGHT+IE9WPcyJENyMKBqBjIXMdFg1BwYt6/7Sf3fpBe2yXxsdwOSvmD7T9GXrgparUtDBtokYQjs6g==
X-Received: by 2002:a05:6000:4009:b0:425:86d1:bcc7 with SMTP id ffacd0b85a97d-42586d1c0cdmr8127958f8f.23.1760100162565;
        Fri, 10 Oct 2025 05:42:42 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3df:2c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb4983053sm43513775e9.8.2025.10.10.05.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 05:42:41 -0700 (PDT)
Date: Fri, 10 Oct 2025 13:42:41 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, jack@suse.cz, kernel-team@cloudflare.com,
	libaokun1@huawei.com, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <20251010124241.k4wsjwdcy5svwd36@matt-Precision-5490>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
 <20251008162655.GB502448@mit.edu>
 <20251009102259.529708-1-matt@readmodwrite.com>
 <20251009175254.d6djmzn3vk726pao@matt-Precision-5490>
 <20251010020410.GE354523@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010020410.GE354523@mit.edu>

On Thu, Oct 09, 2025 at 10:04:10PM -0400, Theodore Ts'o wrote:
> 
> OK, so that definitely confirms the theory of what's going on.  There
> have been some changes in the latest kernel that *might* address what
> you're seeing.  The challenge is that we don't have a easy reproducer
> that doesn't involve using a large file system running a production
> workload.  If you can only run this on a production server, it's
> probably not fair to ask you to try running 6.17.1 and see if it shows
> up there.
 
FWIW we will likely pick up the next LTS so I can get you an answer but
it might take a few months :)

> I do think in the long term, we need to augment thy buddy bitmap in
> fs/ext4/mballoc.c with some data structure which tracks free space in
> units of stripe blocks, so we can do block allocation in a much more
> efficient way for RAID systems.  The simplest way would be to add a
> counter of the number of aligned free stripes in the group info
> structure, plus a bit array which indicates which aligned stripes are
> free.  This is not just to improve stripe allocation, but also when
> doing sub-stripe allocation, we preferentially try allocating out of
> stripes which are already partially in use.
> 
> Out of curiosity, are you using the stride parameter because you're
> using a SSD-based RAID array, or a HDD-based RAID array?

We're using SSD-based RAID 0 with 10 disks.

$ sudo dumpe2fs -h /dev/md127| grep -E "stride|stripe"
dumpe2fs 1.47.0 (5-Feb-2023)
RAID stride:              128
RAID stripe width:        1280

