Return-Path: <linux-kernel+bounces-866300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D19A6BFF6A3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABA73A5A83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2F0285CB8;
	Thu, 23 Oct 2025 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhcVmyac"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610C1EB193
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761202510; cv=none; b=Hbx5T+B5u5b+S37/JndV1FoW5IoiUNP3u+VGyDGsO4NQQ4ncBYSYm6MnQS+3PC6SBHcyKUu0UAlMxG6zT3w4NIdT0X+qgDkgPikrFL5ZDdUGaYAW11aWoaxWZsTVaN7Tq9mF9qfnHZf+iRFzFc3RdAhbNLa6vnojg3n5LwNEkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761202510; c=relaxed/simple;
	bh=DAUepJfRVJxKkvnA4eaWnnSRchdj9qn0LAHm8hNmKnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gwr0/Eb6y0is6qrkHSzHJF1bYe6AfUw4ZDXr06i65W5w/XmRUDMSonfHMgeQieefq/JMhz3hj5oj94+fSeaZY0gO2m3tI3hViH7zJtSdtPF6cTMuITootjBWw6Te7POa3o/WF++c/wywtTlMKyDV5wO0YphgR8dK4ageoouTkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhcVmyac; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290ac2ef203so4159035ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761202508; x=1761807308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP5Z/HgAHKQmrP0IPt7675MCu9ilZEdEUaUFoUDjH54=;
        b=jhcVmyacXEor+7je2afErkqqeTsunQbQT8zWsjdkNs1TfjZjXLg5g+kGTq8gxMcxEL
         kv0e+xjdVrw9fr+xnkhoqDuroPvzCi+XhDFwiKxy7eJBCvUu/5YAqNI5oRzTNGIAv3uP
         q0PA/B/xLGevjSQr5sjc+IzSvX0a2pXTHLJpNBXPJycxtWlCoutdGl8b2MLoghgmIAOc
         QiXDY0Eq4c52lw5KrU+OwKWqS7FMjT9ihmD4c4HyjY7DYyU1yXrz44zg9KzbRcsBMdNZ
         umUAmXU1uNGL42tdE1EoEI8xmb1Sf3BekUYNOtPIdJuA/AEddKTrWD9gQTKs00hCn83w
         rRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761202508; x=1761807308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tP5Z/HgAHKQmrP0IPt7675MCu9ilZEdEUaUFoUDjH54=;
        b=lm2FM6oT+NioTJg4XDJ17OVnGQH4zp371yL9AxHMVMCAm21JAqleu9/0NTpAXD0gPK
         ZAmgU3wTiHczul6l+lZqxKPBLYERWo37IgdABhuVD76H9hBYEJE0qzx64mITx+zLOIDv
         3QTjZWUKDoHHOT8HvcP/LATFWSVoaX98NEe4NbgSYcqgUFpKvSQPo83CvT5rrTJgB0OP
         pVk5sl+AwYogqBH9DA+I7BO2U/NFsPnbLfigUfvq8xarA6yHUIaQFMtS6B2sCuKoEkqN
         ZGW+5CJQ+qZUDD1NAAwxosWWvtokB47dCvC6IwSt0KqcIdPHkKqbi4fO8pWjF2uqZHv6
         oFMw==
X-Forwarded-Encrypted: i=1; AJvYcCVqen5eH8oGRH+MWbWWdkw0ltKjkXMQns2ylYI3VJqt9jEXXNkCZJeabvlFNcXlFLxaeZv339q9njMLpD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpeya9B1KF43aph17sUrsk7ZB3CPE/WNYgoeaCIZ0czzc56k/4
	oILme1AoItFz8p+cEcwlday6PATWgJ20judVI762oBja0bNsEQ7m/kUQ
X-Gm-Gg: ASbGncv4NACiC1Fm/LWce+MPNcp7Sk0iHFRqmZWZ7nML/WkLctfB0JPQsTNBOYDTj4P
	x48q2Sv/ExBYQbaUqMW02aGAKOxCQokl0wNkhxYYX9Ii1LeUovv7dEYxspeAvM/kv/+sNT7HQaq
	LHl0h2qIA92rJpOJOf5hQdJAe13YATdU7WoHJdzY3G/DimgPRr5fic46xRTjC/U/V5R/EctjTFk
	ImaQZnCRe1MrKvV9tOLyuhYJXVtON0+eYgD1NQEr/WWt9rFaZLEZ1cAtbGYTydwnmt62IXsFjSP
	S979G3mh/AVAcmQYFXNGQa1+7QX2lokFUbX4MARoaWAJV0bhULTkXzeivM411rLzx/uPSeETPcm
	41Nk9XAWoqC69+rK0+e7STY5Z9clDeLP3RffXr5XQxUJfPCaEAft8iGmCNX611CEqqJ5FMIyGEc
	zArk09ZVZNnbuipOyyGJ6xhWWZmRB1oi/72CSo
X-Google-Smtp-Source: AGHT+IHr2gzxSyQALV9E+8m/brmHPQl4niYyUyZD3GGPKvCuyRW9JF9upqsoc9+MUaUg4LYABaSFQg==
X-Received: by 2002:a17:902:f642:b0:28a:5b8b:1f6b with SMTP id d9443c01a7336-290c9cbbd49mr304163725ad.21.1761202508058;
        Wed, 22 Oct 2025 23:55:08 -0700 (PDT)
Received: from localhost.localdomain ([180.172.132.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb016f865sm1335179a91.11.2025.10.22.23.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 23:55:07 -0700 (PDT)
From: stephen.eta.zhou@gmail.com
To: stephen.eta.zhou@gmail.com
Cc: daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org,
	tglx@linutronix.de
Subject: RE: [PATCH v4] clocksource: timer-sp804: Fix read_current_timer() issue when clock source is not registered
Date: Thu, 23 Oct 2025 14:55:03 +0800
Message-Id: <20250525-sp804-fix-read_current_timer-v4-1-87a9201fa4ec@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250525-sp804-fix-read_current_timer-v4-1-87a9201fa4ec@gmail.com>
References: <20250525-sp804-fix-read_current_timer-v4-1-87a9201fa4ec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

I wanted to follow up on my `[PATCH v4] clocksource: timer-sp804: Fix read_current_timer() issue when clock source is not registered` patch,
which I submitted on Sun, 25 May 2025.

I haven't received any feedback yet.

so just ping....

If any updates or modifications are required, please let me know. 

Thanks.

Best regards,  
Stephen

