Return-Path: <linux-kernel+bounces-853231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062CDBDAF90
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9AD18A7604
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B39621CC55;
	Tue, 14 Oct 2025 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNfwhgNe"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279E02153E7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760467795; cv=none; b=JxAaRwLYjN8GERJnFZQkbzM+iUrqBw2pEJa9chvgy41xJfbxY57R0O5W7wRE3FuTpZnRgKugnZFGAbqMjasjb1edb8bkWUdMFCIUCcZW6BtokvRYdMcx43fEfxf5z1TT8XwuiApwXpARZJ4fVXNQinNMD4v8pEEdOXJ6hcBlQNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760467795; c=relaxed/simple;
	bh=O8y1PCk7CyqsuON9JJ7jFfE0RrSjGfU19Q5yPhpqNjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AX3J/y4e9xXPApwJYTF0+4hKo3RFT7Mq9uA2diGccaumPdLQT+a7sNQyPhc5zWTUsvwWWDIRV5tPaiUBHAdbUDlX9+SK7yblAkTJ/0/OjZdPJhWX9Q/Vp9kpTuxRfU1rCMLv78PO6Dod3z52taArjbQYugTBqOMt+ShNb6aXAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNfwhgNe; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-279e2554b5fso1622065ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760467793; x=1761072593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8y1PCk7CyqsuON9JJ7jFfE0RrSjGfU19Q5yPhpqNjM=;
        b=fNfwhgNe3DbIEfn6BOmCsVlJitC+c3QxCEHdMmwfNvo2CXpu+3pP17H6Zf9COLt/3O
         w4aANowQIskdabSjDoKBSB+vREAFpTC7PpiH5JMpJsF/MpDm+xryH5qvNgUDTlANGt/S
         c7AnlPWursHQEMMZ2S/PQqy8MU7vHx6Q0dn05u6ASjUZD/E3CCdgJl2CuIQI7dz/X8Tz
         axMClWvXhQmkQYRQJzF42nHVL4Ww/NQwRmKO3btjLkiq7cOVquJ4biBQIH0xvnOuxuPo
         nCnL6s4Cs0M+iL8ObJ7ZwNmiBX6JZRrlvn2XP5rmYwgOOFQn/fHzwnhK7JFnwdiKCJh1
         TMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760467793; x=1761072593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8y1PCk7CyqsuON9JJ7jFfE0RrSjGfU19Q5yPhpqNjM=;
        b=m21Zzmfv+jlJlzkio2zaBr/GRtEXvdcH1K1lwg0N5oC0lBLN3Xw7oazDaPgeScGEVO
         mhdJOaFdv5lD4bsPtHR0A9nwSo44LG8jZvReGk35Sm6DV1pzhpyG2DGL/RYCZlqH8asz
         uN/glGq51BXZjddWwieRBWjre82zchypLgyLotJXOMdrHG6mNb/4tXniBmNYdP3kpXcz
         /6gSkdQcF/jDbdUfpb6QSPK/6aq688UXmftbQpNzbDo5G9uQ7fVKhDreCA9UrQe9nWPD
         vf0SPUEmwbaIoBWQs/mN4LNLRrRRtZWA5U3MJ6gGV+erUFVKaqipCfjlJC1vk24Z3Xqt
         gdxA==
X-Forwarded-Encrypted: i=1; AJvYcCUchdtoxivloQhqssUqgpE/J6hCF65lD5YG9E3cvFQysIZbA91+JqCQbOaAhWW3x3/VKQtO3sjScXBb0b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKi3PJ7F0Du5TonteHjQI29TIP1jEUcR/m7KxoMs9NLT1zJPrp
	QKT5LAhSX2NQl0scYdAwDTn/puf3Z9dRuLJ2pgszIvHfNmby8hFdnhpPBNXKcwDfjaw=
X-Gm-Gg: ASbGncthoIXXQGOMsEdqqDbva1cnwUk+OVoULhJSq5VZ9wu8MSRuy6F4HcQyv7L6e/N
	zLXoTXOefWEq4eFdLWPUib1QXk2YLcj648GWcpa3wXOOQAQizsOJIkwj8GDg1EKj2dswd/OxB6X
	FKWRp/m3wD5wR8XqHh6KiOhww+TJsaC0xP8rFirHooSQ78/sCdcefQNpL7n5zG7odhoYybXvS5F
	1jA92DA9KPT7ma9cJGQkPgURFlofPNoKK5dBioaXVoCvdHSzVpD3eE5UrNCC3ego0uYwQsVWQbm
	EdSB+f9o5o7BAAnnvJweV3GiJOJGxKvKMxzjxtsT38MTTU+kkAQih6QBCaT2TJeICguGRDKqYcC
	/BOr541dkgCXa8Efo8XJQFWZDofceBWLEtXJClvZua3oTE8QhStMWMyULPZDuPqqx/QWz/w==
X-Google-Smtp-Source: AGHT+IEH6d1IjfTea0ud2rPM+TRuMwjthPBgm8nzMRmg2/IrFgebaJBKQOOqZENx+bKdPBRqgq7kYw==
X-Received: by 2002:a17:903:38c7:b0:269:aba9:ffd7 with SMTP id d9443c01a7336-28ec9cafcc7mr327649645ad.25.1760467793106;
        Tue, 14 Oct 2025 11:49:53 -0700 (PDT)
Received: from rakuram-MSI.. ([2405:201:d027:f04e:f00a:2e90:a424:4c03])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c70sm171560565ad.13.2025.10.14.11.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 11:49:52 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: u.kleine-koenig@baylibre.com,
	khalid@kernel.org,
	dan.carpenter@linaro.org
Cc: chenhuacai@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	lkp@intel.com,
	rakuram.e96@gmail.com,
	skhan@linuxfoundation.org,
	ulf.hansson@linaro.org,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in pxamci_probe() 
Date: Wed, 15 Oct 2025 00:19:41 +0530
Message-ID: <20251014184946.111325-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: ed5bcdca-9a6d-4144-acd7-1c1feeaadb0f@kernel.org
References: <ed5bcdca-9a6d-4144-acd7-1c1feeaadb0f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Uwe, Khalid, Dan, and all,

Thank you all for the detailed review and clarifications.

I’ve just sent [PATCH v2] with the suggested changes — adopting devm-managed
resource handling, removing redundant NULL assignments, and improving the
error paths using dev_err_probe(), as discussed. I’ve also updated the patch
title to better reflect the nature of the change.

Appreciate everyone’s feedback and guidance!

Best Regards,
Rakuram

