Return-Path: <linux-kernel+bounces-729246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE57B033C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAA13B864D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2628815B0EC;
	Mon, 14 Jul 2025 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmejdwgo"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F2A31;
	Mon, 14 Jul 2025 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454090; cv=none; b=QNdQMFymVK8+pQN9CPb9CkyTl+MZyjpg9zI+iJedkMbPE/SjLrhNgN9LmZrMKqawSWJz7fIVYIMiP6fqPGCFg4x2hUHsfWc526j5TlbKUQt99N7NvHAp1jfdmwGZyLwTuoj5o4do6f52jb7H1KwuRd5wFI554qxdpZMlm98wIco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454090; c=relaxed/simple;
	bh=C1sFYjheOWlsTkZ2WNKpGWul8UIIVwmJu5J4YpJdNgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OELxFXIpLQz8LVjR/mWI69BeKxNBgHhO1LnTjtdhWB7swHN0L1jZNkvzOySq7A+bv9YVfkAbWBpdzyxv7jvHDF9REwSjAJK7RVHdHx2jqqwHp9LDTdytVeQWPJDdfOpldDsUtGUAQ+MDZdPtB1BzRgg+XNYxFCXN0eKRQkwjAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmejdwgo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23636167b30so32992875ad.1;
        Sun, 13 Jul 2025 17:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752454088; x=1753058888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE8gcfRQh+HMf4a6A0pf2sS0KbyGC33gzglhO7WkKO8=;
        b=gmejdwgoBWjY7/RODRve30FaMMbpORpI8X8S+Uhmynx/dn/e9aaN6jjIRV4LexGySP
         3dUbxwGKlkvqazW8Ew66UvoTbio8WUkyhXfCFo1raUXzTa8CG/a3SVQ9ePamnVrqN1w2
         McAilhgUthwP0OYUi5CCYuYmoSGuLxXef8ccRfl7Fw2B6N2ZdUrscDuHWLsM4vmHxm/+
         60lodsUFjVDhk9RnL9dQKaNdhIzJluiBVcWj07YCg8+R893uOYVoR1o3FHwmf3xmo60n
         l4Sr6RZHmfZE4rOnCkhF6TXZqdsyDN8Tc4YJ7IIFa9SySctpFP0H66TpDcsTFHmqeU78
         3RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454088; x=1753058888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE8gcfRQh+HMf4a6A0pf2sS0KbyGC33gzglhO7WkKO8=;
        b=SdnIlpLel79NtwGa71dPWpmiRzwhKsIZc4geWyaTJFTrThOHqfQyiv2tCAU3D5DZXg
         lT3jIjsakKAhuvNTU6/fFH48Ni9LZ1fbiRYOIQloQQdujZTcDlu1ZmVXS7jH+pC5Nkla
         uylFWBS0AIAg1vKenQwNuDZBJcNOTOlp/tGgFR0EC45+efoWtDMdltjlyDE3YP3nMlPZ
         YShnC519AlBKt+OyZF6LU0FQN/ClLTraRmoaLl1eSAYfknFbj0euqdel0AGSMSOL2f0g
         80mJle63S2uHNw8IG7js3GrVg/PH3v9NxRTZZ9zjzCLS7IAwFYKTV26n4E+eV6LRJoH9
         O+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1/06Mn8CtWQT1s9LcuTePE37RiBkwK1sXpGtExj6yzcuoZoNS6rbEcFQJ+HGev3hfhmIq/VnZV/5lFmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWou4IEwE2hwWA7Un9Oge2tHmnasoVRHEuVImK4YIfnKfBtHEl
	aTdxK4reyz1CLRBmxBmaTS5VVNzN7ybys6hBrk7K839dmhwFL8rR1krF
X-Gm-Gg: ASbGncvzfsJqu+ZxAtsvAu6Zg0JvrqoqIDFw6ArqLH8oYJdQiCs/m7qOJvk/H23Rq9a
	RJ2bRtJbC7tt7/8CSZp/pmbxUB2MwxYl9Uq5rmjaOQZwtYUL55OHnCFTIQUfC50CUb6NI+VeweL
	Nt9hS6aik4Jn3KK8OVoJgnJpUE0/2T63Vr1AKcQbAmXKEbQpZsYfUkJi8zJ73LJJWsr2nQI+TRQ
	7K8GUGtzKBELHLkiAI5SrwGHYR1St36AbjKoKlZP3ZZ/kw87H81dKdJJh60N5iP1ENiyQh4ps3i
	svQ11DdLrYWoPtdMW7W9+aYBeMqeNMSMi91ce2K9LLn9d1OC0neDvlseAQ9wsHjZ2pf7SNDxk/b
	Al5RVXDbWY7BDOQ8IYv74wQ==
X-Google-Smtp-Source: AGHT+IGfTuXiEaw1ivPyHcSOEg1RjHIi71oU6RD2M1GmI7E+NQWCV8xxX3I9b/f/wLUPbWMfwnb8OA==
X-Received: by 2002:a17:903:13ce:b0:235:81c7:3c45 with SMTP id d9443c01a7336-23dee0de80cmr163437605ad.46.1752454088461;
        Sun, 13 Jul 2025 17:48:08 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de4283a81sm81070505ad.27.2025.07.13.17.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:48:07 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Longbin Li <looong.bin@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH] riscv: dts: sophgo: sophgo-srd3-10: reserve uart0 device
Date: Mon, 14 Jul 2025 08:47:49 +0800
Message-ID: <175245405815.143339.9845329520923216196.b4-ty@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250703004024.85221-1-inochiama@gmail.com>
References: <20250703004024.85221-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 03 Jul 2025 08:40:23 +0800, Inochi Amaoto wrote:
> As the uart0 is already occupied by the firmware, reserve it
> to avoid this port is used by mistake.
> 
> 

Applied to for-next, thanks!

[1/1] riscv: dts: sophgo: sophgo-srd3-10: reserve uart0 device
      https://github.com/sophgo/linux/commit/a3ec6cda33ea16e3b7cfee80a6278085948cb793

Thanks,
Inochi


