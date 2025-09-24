Return-Path: <linux-kernel+bounces-830799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47AEB9A913
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6EE1B279C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD8D30F813;
	Wed, 24 Sep 2025 15:17:58 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B810309DB5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727077; cv=none; b=erJh6K9DhfDM/+EwfoyeW2Yf3qNuTeDr+QLMRwdLtNn4oesnrpyySN92H0wlbgHxbOXw2pVY2PTSvMdavEtxua///Kn+Z8NQ4U8x+Kox5DAfgVL8I/OyuRuXyJlAd2OR/5KrPIWrpJcqis2QPy+XSLSYQQXsxZ+oyZ4M4jgevn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727077; c=relaxed/simple;
	bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=iGgHeNuAVJvS/2uZ8udXrtADbtNIjM9vOcb54aoLUQao6+M3oV0w5HjfpR/P/+/t61sfhufnmXmx6eWxQyxPICtmS/TkIaeoMMJhk0JHH1Wl4pFzgxzgpFef2TAsCoa3h/FXNJdt9Uu3dtn0NewYIUZg8fq+oE4tIYdZiHpkfEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4257ae42790so48152695ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727075; x=1759331875;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
        b=YbY6tKm0MUQ5kMvJKHoFz8tM9XnfvXPfIMD3eTc/3yvzbUAfWl9+dly9FbgSfCCcS/
         CygHYLpPO8pomcaCm5imCfyNgeH0mpR7G4KHCHkprWHAQnhF/4N0qtbGQGs2y5IRdBPu
         5PcUJV6PTIh7gFM7A/3AFaXAkdq22DAHF7isBtAYHU9z3ZCY2LLrb4K6zGW6E5wlPV3u
         wQAolvQpZj1yzObTG/cbyvAHyt5+zluZVEiT2CfO4lHcOHvCOnCgjn6+t9tUydcZB5RU
         VCRYtWtTbqSmvqYCbHTqko1iR68TCUfp1qq7J6qRRKPB8HXl8sGyTYmg+c1FMH0QINrd
         Ms0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkclfEQmreK0UQ+9gHnsAzPIdCiHlsjLM7wv9wFvn0YSOXz0Bf/C0Isf69tFEfjxju+xzn3b6BjJfuDnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZ8Qo09Rjnsb/QZt3ADofzU6fGyrGi5zSm2JpusSep6XU1xeQ
	7uWqzh+omrUJ/xVTEkKnhwKhhCUf0Ei7BRepBL3EJikH7dBSNEM0VI5aPnFX8QzyyW8mjhXVvWB
	dNQnV+eXTmyBdj/5/4YCmo7P73ql6wBayrgVSEwOPaNnH5V80QtC9KMwZU8c=
X-Google-Smtp-Source: AGHT+IGIspDJcfiwKe8EB0MODeKri2IildTQSkg4g8g+7VO8rr1EeQ8+cJgqbkGrkdn/cklfJy7I0UeB7QtMI4Szt8a6KYi9u7Wp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160f:b0:423:fcd6:5487 with SMTP id
 e9e14a558f8ab-42581e28b8emr110631205ab.14.1758727075330; Wed, 24 Sep 2025
 08:17:55 -0700 (PDT)
Date: Wed, 24 Sep 2025 08:17:55 -0700
In-Reply-To: <CAPrAcgMpT43t_MRC9qvsZCYUWdKCw-OwU5=PgRqcNkRu-oSiQg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d40ba3.a70a0220.1b52b.02cd.GAE@google.com>
Subject: Re: KMSAN: uninit-value in lan78xx_reset
From: syzbot <syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com>
To: viswanathiyyappan@gmail.com
Cc: syzkaller-bugs@googlegroups.com, viswanathiyyappan@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.


