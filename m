Return-Path: <linux-kernel+bounces-784833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD4DB3423D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893E7188A7BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89862EFD89;
	Mon, 25 Aug 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hfgmdoRS"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047E293C4E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129677; cv=none; b=SBkv8VBNFoV73UXLOdBnHzPHljjtORqbqwmhNFle2gaEZr5RMlqkqal9c45u/UWfM7mk3G+joAs5wAUTnTFOpMm+bEBh6oUhirk6UDG19v+pgbZ5z7JVUVVvcpzRnalaCzQJGw1OwA1AY5lmDt0CsoteiG0Tpqq1fEZ0mz+gH28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129677; c=relaxed/simple;
	bh=0g4nfZL06xXfcqQP2ZXeFhZtwkwQeXk3VS6zc+kDK/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sw3fexjYKZ4RXJejabtaAYTvU243jOBZ0nAS1hXrmYEd1Jv4CZo+nnek+GePivtAM2/DuRu0oQjJfK2jRRiSPiVcTKbc9wbqlZb7nP56GTMvyPvN5UJjAcm6hT6XUiDIPWvwFqySv8dARw5j5ZRwNprrwBeh79Zsb6nS7Asq6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hfgmdoRS; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3eb71ce0510so20776205ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756129674; x=1756734474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaJhzYO4iaGPetQog50EhntUWyYduBz9Frmzzr2P5Qo=;
        b=hfgmdoRSzKpjCpiNql9Lwq6XbXmLMRNwntE8BJy0O0SAFu1eDcv1fjKMmAN/zDohPH
         JG2mu8IaEnJtxXD908Qr6Htuv3a5M0yGo+LJTMJUREKu3VVu/jfj+5glnFhOKf9ml9MT
         ZKQb/ZCvZH5SWMC849Kjqb3bu0WlParJWMz3NZU0hq2qzjlpT6rzSKPSjoll+u51mK9P
         Xh75TZC0vIKPWvyvB74lhX8PVCbOXkNILwMBzygXrLOM14kxwbYOeIusIqZhuXcVNVLH
         EpkXE+emkjI9G1xKi0QOhsePy8AqN/IH9y5LU0CmcoePPCBzPV85nB0kpLVi//JwcvR9
         1mxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756129674; x=1756734474;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaJhzYO4iaGPetQog50EhntUWyYduBz9Frmzzr2P5Qo=;
        b=aBGX47+aGdI7+CxuP8r26ahytDHDPJT/cFeCMJrZLLvQi9cAjYsEFsliJ6TuIy0eZu
         8vUcdHUSaK7oZWcjyrsChjf97vHi5jcFsAv5OPWWrpms0SkReTOdON6YfWbbuvhqVqUK
         hqqkIBzJQZJ3VIYqwT5tbpfPXLjNx6hmh9hCscyFUTZNWziJrgRE+evoD5um1HphO+ZD
         T3JgMQ30QA+tE6Bov1pa5WdZLYuAPgICQYeh3AINuR4evXNb5sTEtBIW80kL6xHXg7Xp
         eSWPJ5SzzsjhuKWMNPa0lh0lqy9Bib0UxfYoJUqwO9Dx2DY+LsOZ3hOv+xh8h7UWxiuE
         GUAg==
X-Forwarded-Encrypted: i=1; AJvYcCVxEa1ivTHr0JYAjl3JKqE3a+h1RYq29bp3eYFln7C831zROmlBAKdgM9g+lk5vUqp5iFZsAY1+pAUC3eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrp1N2Y8HBgIE8kFHbTYLBU1oGsCCbHS72z43WjNhUJWiOOEiS
	BLVijJCXdUT1Y6HXqlX7m0Tx3wzk/n0ovVhz81XVjRQik8Gyn24vAEFRhHopaU9sifU=
X-Gm-Gg: ASbGncuUkQlv0ir89KvEOy4S8lp/qNZUzBRf3502GH5L5D50IC+hipr6SG7VhoTeo1j
	+t0jjj2gsWqZBg4ZICf0C5j1GHQB9qgzRLpcSPpl7UIzxKTkzixsgPpNFXOPnwiF3jetY5jGGJc
	dQnuzXyZnYwPF1Jpk4/tQ6ebFKdNDvT/Z526RK5MBAWyA64i6+x6Zi7ZC0nZSoZku4BLphHKxZQ
	aQkZbcFVRq1Ox+WxGDHjz2mtyKwAfnHcTnMEJvfepaobkbIPjwQgs/eZLjsS8+viU7mwK6IHcZB
	EyjqCZjrqH5iVyPtTAdY6c1hv+Vl95vdhhc6nQvIDmYJwJL8f6rw+Yt+8hgJPppmw4nPbW2a2WM
	G/unDDy3PwP8Lsw==
X-Google-Smtp-Source: AGHT+IG9EQPhdHbz8mEGF2jLK140waZfJrbHSx+bzTm1sOM18L8qwaMMO1zcVhW/7At0bhqvqh7H7g==
X-Received: by 2002:a05:6e02:184c:b0:3ec:40cf:2d37 with SMTP id e9e14a558f8ab-3ec40cf2ed7mr54279585ab.31.1756129666261;
        Mon, 25 Aug 2025 06:47:46 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3eb18693d2esm38348625ab.42.2025.08.25.06.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:47:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, hch@infradead.org, yukuai3@huawei.com, 
 rajeevm@hpe.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
In-Reply-To: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
References: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] loop: fix zero sized loop for block special file
Message-Id: <175612966482.55174.12405819858243003502.b4-ty@kernel.dk>
Date: Mon, 25 Aug 2025 07:47:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 25 Aug 2025 17:32:05 +0800, Yu Kuai wrote:
> By default, /dev/sda is block specail file from devtmpfs, getattr will
> return file size as zero, causing loop failed for raw block device.
> 
> We can add bdev_statx() to return device size, however this may introduce
> changes that are not acknowledged by user. Fix this problem by reverting
> changes for block special file, file mapping host is set to bdev inode
> while opening, and use i_size_read() directly to get device size.
> 
> [...]

Applied, thanks!

[1/1] loop: fix zero sized loop for block special file
      commit: d14469ed7c00314fe8957b2841bda329e4eaf4ab

Best regards,
-- 
Jens Axboe




