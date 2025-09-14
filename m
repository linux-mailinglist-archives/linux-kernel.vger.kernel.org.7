Return-Path: <linux-kernel+bounces-815594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D7CB568B2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A703A5C94
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF36C264614;
	Sun, 14 Sep 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQuRA5o2"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDED19E98C
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757853610; cv=none; b=ANw1+XBpg3DxnqAP5FdF0VQb/EoX3gvXOxvaL2wtMZjuujVq5taJSRxcSzacuFjSEa2HTergJdSB/zyyq21YgL4cZJ3ZAGfI5Ah28i9oMEPNJip5ywPq2nMNTWCNOppQljc+43KcMSwQf2dy+Zl64kvapvPuIZIYbSqa4AYY5mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757853610; c=relaxed/simple;
	bh=Dh+wk2yoqrWCD8TB+uPwRbLtPIr4/5QsJ+QbZo4yO/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHGUkVsSBqfrHGDb7tKlTZmRHUUbLitJHOQZlq6djrvi5l26YRVxbNB3qr2M1nvzhx/XRb8XiG+rzRqFeyo1/JbR5mhHd20AAvWgugDhq/QnL/Gj9WfYlVSWfrKQtr91lKMSYDUUVBH4Q/tCCayrD+g6KEyZ0Jwgj2bOcWUByJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQuRA5o2; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso2309167a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757853608; x=1758458408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQf2AGsnl6vclYwp9c3+fOFIkP4apfGdDfRnsEWxb3w=;
        b=cQuRA5o2MTkN4YKbYLM3zCEfwS4QWMKylpaAOPTH1jHZXCQsyFSE7fIE/rGGaRdTX+
         BYGXZBQNRZo2qOY9g1Sz2RKD4QniFAuXUC0nJoU8OUfGwjhPdFLp0eM17IT5wJ6pnBJt
         56dY+s98IWWfFybwKywcKLcx5AqYBQzxRp2mRZnz0Y5iXgav8wuMeiMjY1qSz/M5kxyy
         0eMPi3lxWPPM0Kchfl7XEYUViR0fe34WTIZaqnYxQcgGuQufC2N0MPSCQJCViOW4UeVN
         u/P3YEHyr48v72K+ihyj9gTSJlEQeRvVnWwq9Tnq+nQIXZVB4nJk8WOqa3gKQx/NIV+D
         3cuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757853608; x=1758458408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQf2AGsnl6vclYwp9c3+fOFIkP4apfGdDfRnsEWxb3w=;
        b=o4YRQdi184Br8yAneW+TACZMkrP57Ry/COPuueTS8aYjR6mC1OnD/ZoxVqVqgkfDRm
         HIyMCc+WE22hZR2/awQ7itIup1Be5d0r8pEFp5oWya48qu5C6Bx7XPP2p8SXEiYXXxDY
         sh7KJSJHsCSS3IntEaAvZwlpxMB8hQwUPpCRqJVCEku93CHU3tz/63+iMYkWHniB3Z4O
         j/6ig7SU/lmBjnLB8QGyJ68QqJyV3qtQhnsFTe3Bm43Je+2ymqJ048WfO3YNDzo6EcGx
         5C5mhGTpoqZzMA+cvJWtlMHgU/E3dlFhrS6vYqoWzyMb9MXT9Db95opZOW29S8LwXiIW
         PUkg==
X-Forwarded-Encrypted: i=1; AJvYcCXuWs9k7Pfm5jzkEd08T/AVxyuAtObHCIDdt3B5H2y+YNGtaziw5oyxKc4Ge0K1Hj8VlpVMn727wTjQCX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ6g78IiQ6QXUk6YyuF/LFC849qRXbDjDh9wBEwV98qnVMfY73
	rxShGOV4IzzFeITkQq++ts3bh14DtSTCOqmTdfnpAMT2IajIqKU6E74Q
X-Gm-Gg: ASbGncu+i+eqHE802MGO9rk+l8qfD4ZPXxhw0/DBf/GGRrUVfepiU+goG8kEgIEmJ+E
	ZteddYvJI9g0yTLNcjBAgWIIS8dg3M2/GSLrK12rwPr+iQGb4L9boDw5dFhsQo0QQRL1uSEiRSG
	c71aMy/Tb2JDNjDciKJSrcLGvVUCMAcF5HeUbfzCNaf0UztUF7RXdvpQFFoUZt5IYW5dPnEPw1f
	6a3H4mf6b9uU8eimTgMsPqvfRlY9tpBlfDriV9EFrx33OwlotQR2nvxhuWPUIIg4DDZA5SDrfJu
	SBo0Gdeq4Q4PtJk0Zid4A4/OIQwDwYPkNNuIZQ12J0b5e+v/imF0cyKaM/puoNPOPWZ7sbjA7Jn
	IfW7IyIPjFrUucXuX/UZTzsQLkstHYqUDCSY8K+ZPhaTBa6cU2AS5hYs=
X-Google-Smtp-Source: AGHT+IEqALl6Dr8zeTny4Ila1tLRwXJarsJ+CPNRvQ0gp8DtgtwVdOv93ajULAIsNdfEu/GQETTTtg==
X-Received: by 2002:a17:902:ced2:b0:23f:fa79:15d0 with SMTP id d9443c01a7336-25d27142f24mr114645185ad.46.1757853607940;
        Sun, 14 Sep 2025 05:40:07 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25fc8285639sm49876965ad.134.2025.09.14.05.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 05:40:07 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: kernel@pankajraghav.com
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH 1/4] iomap: make sure iomap_adjust_read_range() are aligned with block_size
Date: Sun, 14 Sep 2025 20:40:06 +0800
Message-ID: <20250914124006.3597588-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <vath6pctmyay5ruk43zwj3jd274sx2kqbjkfgvhg3bnmn75oar@373wvrue5pal>
References: <vath6pctmyay5ruk43zwj3jd274sx2kqbjkfgvhg3bnmn75oar@373wvrue5pal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 13:45:16 +0200, kernel@pankajraghav.com wrote:
> On Sat, Sep 14, 2025 at 11:37:15AM +0800, alexjlzheng@gmail.com wrote:
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > 
> > iomap_folio_state marks the uptodate state in units of block_size, so
> > it is better to check that pos and length are aligned with block_size.
> > 
> > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > ---
> >  fs/iomap/buffered-io.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index fd827398afd2..0c38333933c6 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
> >  	unsigned first = poff >> block_bits;
> >  	unsigned last = (poff + plen - 1) >> block_bits;
> >  
> > +	WARN_ON(*pos & (block_size - 1));
> > +	WARN_ON(length & (block_size - 1));
> Any reason you chose WARN_ON instead of WARN_ON_ONCE?

I just think it's a fatal error that deserves attention every time
it's triggered.

> 
> I don't see WARN_ON being used in iomap/buffered-io.c.

I'm not sure if there are any community guidelines for using these
two macros. If there are, please let me know and I'll be happy to
follow them as a guide.

thanks,
Jinliang Zheng. :)

> --
> Pankaj

