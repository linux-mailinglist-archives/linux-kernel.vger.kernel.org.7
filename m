Return-Path: <linux-kernel+bounces-737269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3157DB0AA21
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C143AD279
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF952E7BDF;
	Fri, 18 Jul 2025 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSyrkYHc"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C215D2E762A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863399; cv=none; b=DkIeZRugQRAJQzaIuIJM3tYcmm61T+GyBd1cWNYvElwPFJr4JQzZz5YBWiM7BUqIrLWRZIVsa4ZwLSbrn7Qvm91Gcsap+LoXu9hBOjTRgmcBSHBRrQaLSuyF5hq7+46egb5ouHKQRMk8FqJZzUezdY3mOScByMspk6BHqh192N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863399; c=relaxed/simple;
	bh=YKJ1uovM2EggmxTJohVAvKuVCz6yqNmxfdLf7g8+kts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lj/8rfqNalNw5ehdFC2Sk9mRyOAO6BDDR2uFZR9imb1feSH9nQ/RLMkfWVqBBj7jxC7tbXpKxK9p34am+0cdWY0RSATqey2lIrqahCXqKFn18BA8urq5dXqmvs0p9Qqfofv3to9wLuKViXHLYY4LfAlrpLHtre33U9EeVEePo0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSyrkYHc; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab61ecc1e8so17851291cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752863397; x=1753468197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKJ1uovM2EggmxTJohVAvKuVCz6yqNmxfdLf7g8+kts=;
        b=BSyrkYHcKDbYgtEadYsWI6UfKnL8OPZ57cqNuLrvx2EECor1ATaFjCOJYOCwyN1d5J
         u4JWaYf/lKheR9yyTC8XuYBc+Kh0728wSM02XLitVU1e07Z8qwR1QQ7ShqXqxg5UBo49
         3nwHT6qk+mNVxVac/ZS+p8GGjdvaNADfvnKRYzwGYeFGZ25dNJbi6kBvYttIrPwHPrKL
         YWc4ZPdmyWr1W8z8CzmNE5mYZwfhFillQ4hgLO649no/lQ2P1A1DhpyBlh4xN5zzXEvZ
         MQhInCGCWcfVNicqBh1QEfS98cJbkTA2ICWyVB0rP4iqys/0hLb/+EJ91pTHYdjnMmMB
         Tgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752863397; x=1753468197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKJ1uovM2EggmxTJohVAvKuVCz6yqNmxfdLf7g8+kts=;
        b=lrB58KxB601HWcNYJLaww8g0joNtfH3KJa8y35N4zM1Mziar+GSlGphCQnc5L+5tgd
         /u3FnsICW+7E0AkU5QchM9XE+razw9P0O9uiq7sUJz8s9xShz7v8tBi3gBhHDtpZ3bDw
         FYMOPG3eCXJdsHtEYYhO5A7lqOZWf+SXN4Bew2VZcH5FFpFylHbC9c2O1p0zQY16f1VG
         KQhYVvA2MrNGwXoXXIVqiqE4wxWo20lQzhKs3hPgKvr28aThaUVPr+cwphJM6tteZ3Oz
         InGaD+qEJUaYVdBOeFcOZ/7fpNhsDFOIRT43TcQUpAqYJCZz/Kr54LNep+R4SBL94HPs
         8n6g==
X-Gm-Message-State: AOJu0Yx2yO2B/FBLWamk9E/U1Q51nYT9ai6RIfWyd/OGaQGOpbYdCgXk
	XZbwjYaxROONHgNKfQm6HvlUjkL1zFNeHjo3QmV/vGtAZ4dmB2pXLgWY
X-Gm-Gg: ASbGncujdeudRNuZEqd0odw6hv/Cu5UhSRApCpEPc+WibDQ2x+FG7/C2gbzjNw2M5pU
	9tyJCALL5YI6ntMB866DGz/qv/EV3sfpNQwWmO8j40MZDz65eODttLh/hMAyXD4JjQe6JavetWS
	KSJIbKkypkNkON+cRU1yu0Fj5Oc0XfxaLK60vLz2uDLarVO//c3t9yM0XzDEeN2EjaMHoFB+nPA
	1CJ3TcecTgp6kgD4TerUIjdir4LmX5u15vGfdP7S1u6a5mH7V+rOg3BHDR+rs9znlURVg/lf/3u
	4Lz5k/GtqO2EDuiO8/DEY+LGLRibwnSmjQR/m322LdjvTNEHiq20PU+XeO7iBD/TBuPpvjZrEZ9
	qCbFNv4gXcPYXAc7EYO35nnOa1k05OHRWcYztdhhuLLO8s3sGotg=
X-Google-Smtp-Source: AGHT+IGS41v+6MhJMyaP5uh0rlE//WnNcesBuHP1dQ3r5I+puFmRIHytXffnkbGwgpihGdMRtnpkGw==
X-Received: by 2002:ac8:7d42:0:b0:4ab:37bd:5aa5 with SMTP id d75a77b69052e-4ab93d8ca54mr130410341cf.44.1752863396346;
        Fri, 18 Jul 2025 11:29:56 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b42618sm9815701cf.62.2025.07.18.11.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 11:29:55 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	vivek.balachandhar@gmail.com
Subject: Re: [PATCH v5 1/1] staging: rtl8192u: Rename ChannelPlan to channel_plan and fix index name 
Date: Fri, 18 Jul 2025 18:29:38 +0000
Message-Id: <20250718182938.188395-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025071809-sulfur-unvaried-8e9a@gregkh>
References: <2025071809-sulfur-unvaried-8e9a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

The `rtl8192u` driver was removed from the kernel in commit 697455ce4110 on October 14, 2023, due to it being broken since 2016. As such, the patch I submitted for renaming `ChannelPlan` is no longer applicable.

I will pick another driver from `drivers/staging/` to work on for further contributions.

Thanks!
Vivek Balachandhar


