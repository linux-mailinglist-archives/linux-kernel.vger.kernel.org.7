Return-Path: <linux-kernel+bounces-724894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC26BAFF83B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474E14E885D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228402857E6;
	Thu, 10 Jul 2025 04:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM6IFt/V"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238328504C;
	Thu, 10 Jul 2025 04:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752123033; cv=none; b=tGkt2RAnJv3owJTFjVSGv7OCek/L/HZ9u21XIdZJI3g2I3LimLGLrJI0E2swx59ik0FK74smybCofkMeYwAvC+GqDYjjX90al/ITw/5lqcxFTNq+730gYXiSGyka/Gh8lj4L1ev7VD9ttlM2JbghHT5uZxvODdGAAm4fE0l7rbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752123033; c=relaxed/simple;
	bh=r/vFoFPcxhaEHAosF1butA9ZXZJWUZ0og7tQJmHe1Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blVhpzpRP1n6YeqZlXdA+poD8ySGy61RgaoEyhfqg3rf6RZ8S7wAQWjkUACc8JolusUX3tDHXAyID1GY/3WqfzDzSHCtS0hGFGsZocv8ESFxdhGUpt3kfZKt+gYPBs8Kd1OR2yEfcoy9IMeR8S69Dd0HhjIfB9SqYhwogugiXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM6IFt/V; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235ea292956so6339885ad.1;
        Wed, 09 Jul 2025 21:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752123031; x=1752727831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGHzgNL4+vgpSA0H+m9gA8FMtg3Ii9xrQRTg+31D7LY=;
        b=WM6IFt/VKpIcjcaWH1BbqcXZZpxCwDHSWlUwTRvP5qFG1f4twfp7GWOkHzQcjO8r2U
         vrwoWNN3UCo9fNvnkkp4WZ7UZlO7otXu+KtfGmv0BqvR66rcts+ZmvkwB3faqca75WUM
         yN4yaXe8zEIBudYwkI61nXu+G8ZWJAE32CZU192npzMWsGOITjgxBHNTghdAMov75v22
         9B+nSHJ4lBLxayrtQb8DMEkGr0DSONGyte9fITycARwPYBKEBTLxVu/l+9j+6WpFVXos
         qUc6UEDt+j/ROAk/wAdVz+FgJBpJM/c2+DkviDVpuHTbij5Rkwy3etGn93tR7MM3Hiny
         gV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752123031; x=1752727831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGHzgNL4+vgpSA0H+m9gA8FMtg3Ii9xrQRTg+31D7LY=;
        b=vhQW8gX3OEIp89Gby1kso1C9/A8OsbvExakDnwvKhElw90MA6jZSQe6UrRzzhTfJ6I
         VkqWKORFqTtFCTabOwD3ra3dc1f5LXMkj6crFKHAMvp6eytpCNetinUBpITxLeUDx1Y6
         vvbWVTGmWg0LECFhabz9WfVaSsF7jInxOrEYpS67wVZ3oELXQx8PwzwiYTiJvBPN9Ins
         USNoKz+Dw/tkHvmdP539JXr8g7PsgUcTuGCqk1r+cBmgMS3GEhvDBJD4JlQts74h1CoC
         m2SVqZgJzGTIZrQJ/JQzDAY4+t0LxPB3DMySEWwJjBr+1n1DVidugyjYqD23pKkkQ4vz
         iq1g==
X-Forwarded-Encrypted: i=1; AJvYcCVL6muZkTiBjKQKUSbOaB55NzqzKCdAtTmTuGDsmaXV9qg4zTbXbmFYuZGebiFqa3cxL1znejybjMbfdQNP@vger.kernel.org, AJvYcCVvTPpJhV1IkLm81zTXmjTt1q40ZLq0ZP+0/MyhjBVEdQEAoKtozb6dTyWV3w4AuHaCN95LL+6oLT+R@vger.kernel.org
X-Gm-Message-State: AOJu0YyfpjrA9wIdAmKfRdjJ05nKGJxdV+Ug7Y4PD7LJpIxzklQSlvLf
	iQ10t5zRkpL13+qLnuJ+Oa+AfbSoqOnhdtVOoT4FstrrrYyDcO42nddO
X-Gm-Gg: ASbGnctHwLqhfZd6A0bbX9+Zojryw1w7Xli0K/Ebho1JT7m3mTIrL0tFIt27B4gQZKp
	ObHUi80iAzRtdHoltZPvWAMk3iqVCvrhPPpI9UM9iwnJyr+fOB/FbDAMVNB8HIztXoheREy4Qes
	A3dlpgFC37Zmyw3HQ7cIEcBw7QbBJ8XcgxXKt7FlPf2ThyFkK2D5AUlEStjGx+6ykJUdqjuNUVh
	DC7ESLVe7yh3ctIMPj23iF3lzvsuC/fn17jTAQyXEMXUGqEVo2rf/HgpZ+U0zkSkosmeUSF7DdZ
	V13zXJACCC0kv5aCEpqriAn3Zv00cI8MSZTBYsIxttlvuJ6lbf5M1aWw1biWFw==
X-Google-Smtp-Source: AGHT+IHXOFRlJemTmjivVF6ysNCWCNLeYhGM/RjPG780mLaRyKh9lGj2s2LpZf9AP77JDjrcO+IkNw==
X-Received: by 2002:a17:903:3b85:b0:235:f70:fd44 with SMTP id d9443c01a7336-23de481bdefmr17144405ad.21.1752123031495;
        Wed, 09 Jul 2025 21:50:31 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de435c238sm8530655ad.234.2025.07.09.21.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 21:50:31 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Han Gao <rabenda.cn@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: sg2044: add ziccrse extension
Date: Thu, 10 Jul 2025 12:49:46 +0800
Message-ID: <175212292372.416883.15637532130862457065.b4-ty@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <0889174f2e013e095b94940614f4a0a6e614b09c.1751858054.git.rabenda.cn@gmail.com>
References: <0889174f2e013e095b94940614f4a0a6e614b09c.1751858054.git.rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 07 Jul 2025 11:15:18 +0800, Han Gao wrote:
> sg2044 support ziccrse extension.
> 
> 

Applied to for-next, thanks!

[1/1] riscv: dts: sophgo: sg2044: add ziccrse extension
      https://github.com/sophgo/linux/commit/b1d1810649b9d912c7990ff479a1c0f4c75610d9

Thanks,
Inochi


