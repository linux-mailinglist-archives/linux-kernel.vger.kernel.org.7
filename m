Return-Path: <linux-kernel+bounces-864032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60F0BF9C45
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B904F19C1A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2846421ABD7;
	Wed, 22 Oct 2025 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnVo6JyN"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1181C15CD7E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101357; cv=none; b=b0w/10h0wx8LCTULE5/MRBXaBMz1j+NaaNJa06ceudmR9WfWQTQ2TiMgjFO/QBXsZcKPuU2HmihsjEsOad/5ckSXilNHHJWBbtXbpFLJcYlN7RPv98gQ8b2Gz8GWBWAQWiHdaY0V4J9lXuQa/COXePZJaKTZ1+6UhSarrVqbHN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101357; c=relaxed/simple;
	bh=hg8htel78kb1z0kG4s/8pGMbqRLpRj3h1qbTxut7SLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgTFBmReqY1vUiRBnRvW39zzazW66iagtBFpPzXg1U5pOjk6LZnAd+5efwYuqVgtufQP9sMhNX5arIHm66KeHqL/scl8jf8PXl6nYA4a3xBprvOTey9qmz36+s/KlLXzulH7FU0AerxlWG2tHPodnuj7oq55Rb8ELN6T5XRFeXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnVo6JyN; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-290dc630a07so34007615ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761101355; x=1761706155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCP3+njcCxAGRdxjG7v79kpTJ5io9Ph9CBSeZe4EXQE=;
        b=jnVo6JyNr9DqE3ulcPzJfikax0BKGv8RQAuSRtw0ygzmx5wjyVQRQXp4nhHLivOfVp
         tiUobR28hlnDCprT09Tatfikee8dxl6+urnTh24FORjGNBsxk+dBgg1MGWN0UyanaICr
         PtTMKWt0Q9TZAff3Xtq+XgbYY/9pUmUM+Hy6pu9WxsXLxh030tusMvZyqcM5uu7X2M6A
         MiUdJLF9n1ba5ctpMd3qRKPXJkmBAHwUvTPif9hd8AbpOICly2pZncSccB9BdJQihiFf
         EncIowYBf50xIpS2nmq/dSJt48hJ0s5Zjn6smq4wWJFYLNfIYnmxXpRJC2sBj8FD0ESw
         6IQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761101355; x=1761706155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCP3+njcCxAGRdxjG7v79kpTJ5io9Ph9CBSeZe4EXQE=;
        b=bccZCYmnNkGmsK2NgqCDo1xu7kPzLKAEyeiwaSInRgwECY0LDwfM6gsmPX/zNF4oMT
         JYIhWd8mspE+bTxvdCyLfUw0bBr/IPOP46+8DpQZkdk+wbYX1c3ZOMUO+LnUC5jLZJVi
         5MIO1HKiHUGZ8NGdX3UQ7QnO/QHjG17lfWm9XLYhslBnVw12xwrylx2nEZYEbNF93B9R
         rSfvNrt6MEjf6uM1ftWffSdEzJOzPVaJQHnxx9DH8gTOuvcmoDwrPrj4O2zumhb5NecI
         +qQlgoy8YtiTj7WkvHmk7jUzcsWLcBJugB+dO3Kb8aBUFBLN05Ao+yvIKzowKiwjaHoB
         X1+g==
X-Gm-Message-State: AOJu0YxRRvlPoBJwvMs8yhtWe+Zwbh3g7pfS/cK1fEKGxUfn18dWNIqH
	h/9U/5BTMQlNUzPR3lPmL3u9qTIN9J79v07QKMTzmbxmCklpCd/fgSlw
X-Gm-Gg: ASbGncuE/9dmPnr1iosVJUkKSiuKHD2hQLYL1ALEBhJFacX9XZNHFj/Jd8xDbxGOXMt
	MjD3+O2Is1Rc/cDSEe/3oT+loZxBhktGNyQ51iAcKZhpQTmhQbzWROEvlD0t5mNnJBsXjvvPLAX
	oj7PQ2s67xUnWwk28B/8n0YrPJA3ohotbw3cEF5CtjhUlLE+wioVTRaRxCcZEVsR9mdhQA7H1hI
	K1mBPdUj6Lt2a76Gc1JCGHbR/p/8CO171ZZV/ESzioa3O8/8vAyARcLaFr/gShD293f/h/IT22x
	bzwlT5UhfyPGHAN4iYlFRrtIRH4nL961Ux6/iD8SypG05/clANgBCriRhLpJWv+aTzwPzAlDSyV
	NfORQJ+S4k0NHYsKKUB9UDJN/O3vp+uB6LSWPQdco1rvMXw7otMWqrBhPMch3SH4ltaoxpcxu1G
	UeO6dFfOM2XUELPzlZG9U9d5wE5UPe/kXv42LSuvU=
X-Google-Smtp-Source: AGHT+IGPjfFw1MU49mZpNz6VxSCw+rw8IqPrOY86qqu1rvh7XI6a+FbsC1wlESQ+K5NmC8PEdzU7PQ==
X-Received: by 2002:a17:902:c946:b0:235:ed02:288b with SMTP id d9443c01a7336-290cba4efa6mr275302665ad.30.1761101355307;
        Tue, 21 Oct 2025 19:49:15 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcde4sm124950945ad.5.2025.10.21.19.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:49:14 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com
Cc: linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	zhanghongru06@gmail.com,
	zhanghongru@xiaomi.com
Subject: Re: [PATCH v3 1/2] selinux: Make avc cache slot size configurable during boot
Date: Wed, 22 Oct 2025 10:49:06 +0800
Message-ID: <20251022024906.87974-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHC9VhQeW7fFtB5uGRJhU7882MsSLazHmOZ0UKj=pX6PKiwz8A@mail.gmail.com>
References: <CAHC9VhQeW7fFtB5uGRJhU7882MsSLazHmOZ0UKj=pX6PKiwz8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> That seems reasonable.  I'm sure you've seen it already, but you'll
> likely need to modify AVC_DEF_CACHE_THRESHOLD as well ... or honestly
> just remove it in favor of AVC_CACHE_SLOTS, it's only used to set an
> initial value for the cache threshold.

How about this?

#define AVC_DEF_CACHE_THRESHOLD AVC_CACHE_SLOTS

We can preserve the original semantics this way.

> 
> > I will try to submit the final version in Q1 2026 based on the discussion
> > (Because I have some planned Q4 work that hasn't been completed yet).
> 
> No worries, thank you!


