Return-Path: <linux-kernel+bounces-824973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F92EB8A99E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CC71CC3728
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0859A26D4E3;
	Fri, 19 Sep 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnDQe8xi"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CABF2686A0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300032; cv=none; b=D17qxePmcNV9uTotzyw5NtPzITK9rIcdCRsPhXitoNOWsp2IBp2ZAy93gjH4J7xFcX55xprBtuERvDmLFR38kO5tE8hMpKqwzMLRDRBH/IvtCeZfuFkrVf+9h2+YOhpFQFAZOf0V06NUpDzjqWCllwPLgrsB97ubIxeiEGPl7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300032; c=relaxed/simple;
	bh=kfuM6yjN2W1uFxjBaIpJ1Fe1vU4tSmc9A7tnN6PX2N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9aWK64lIKCk1QIKXMXWI1L+D2nV3rItlkvNQ9o2kkfkmX/u5C2Q9D98hbOHmGmL9UqkIPusaM+TWL1qH8pmX44lGkcsblaZKeFC86NlEMinxN07zdOO75oQobB0IL1osV3/uorE0LQf9ttMcYjm43Dw3PuVyxAdDfvkvi26VWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnDQe8xi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24458272c00so25716855ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758300030; x=1758904830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfuM6yjN2W1uFxjBaIpJ1Fe1vU4tSmc9A7tnN6PX2N0=;
        b=PnDQe8xiBSjfIMtirsMvI4f0XOzc1hPu46vZ1NvmS92+GjztOOtwgGIrGxsARfl090
         Pkhu963UDuiK8QjipiMyWaT+1cPwfxB3CrH05UDo5y4MR7GinCtYsPwewNFoweyTHkoB
         TrK7KDh65H/d+Kwe3uVgmexIkjs1JEaT7C9UKbTgc9/+vRIKzyi8w06vMKmdyoYHYQDv
         H3O8rwCFQuuPNn5s2Z3KtFgoOHIPqNd7l1EQcD4YH/1v5/3fenVWvJ1Q3tHRNw3ToM7U
         F1+frO7p2LqpF+VS9eOfpTAVDnskKzFVJrzpInoYB2DLIoHQMR77HEO1SW6PS48ofFsL
         a41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758300030; x=1758904830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfuM6yjN2W1uFxjBaIpJ1Fe1vU4tSmc9A7tnN6PX2N0=;
        b=vrUiQww6EXS5c2TgrDRIio1QxJ3T/RWF8PCoB7F1l9VXVExPxSo7bc/mBissEShh6Q
         LT6Omnd2dkuWlllY7EM1CVJ37tQBhjN68A2s5dxzrItbh0yb6VWoWPnpa4ituAE8os9i
         GT/EcZoGAhGvvJr0SUXewJ4S7oeP0SIfgLVJJHu3zmd7V8PESxApH2lvYxI4RMuCBYRL
         8SRWsB5qmSVRYIoq1rilspSK7eeA8ve6Y6831T02KsljBXDsBGtiEe7qQRrlZbj1giKd
         Wa88dwEbdbj4ZENfgM/Y+IUx2+fhYYfYGHvurCfJ/uFXMKzKT+6vzrUAuU1kpNa07M+r
         cmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrvs6SbJe23C7SM0ztTmOWt8kBociaL2oyGmEIO4rQcVpwLIYXJVY1l6Mc6s+Cj6U6NikRHW92BlJg1Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhNdEl/HCa1CEA1pBabY7U8gbsNT2ll4UZLIUjVRXNdJVTggMM
	DG1TjIXbhxsa6oeoN3Nwvnxo3D0pzwnUPvC+9mqDKNl0rA9O41rZwCs5zJy3qUaRI0c=
X-Gm-Gg: ASbGncuYY8NRrnGTTZkO4QBdickD0cvgvj39mLRKtrElWV97JF23NGf6bQh5DJFkwix
	OhuaY9Mx3ezKNrBwTxDrwfOTzaxHxbTCD7Pd78ZFIYEHDwgw3BARf4YVBbwayzXfCW8FjlJr5Xa
	QCGRMjyRnejpQmGNU2QPz6alXT4XalsbPDfigo68qKOj1UkB9sGWZYJhDWfDeTisc8eci/h4g40
	Y4H5fu8zcBZI1A+ZQca2DHewrjFW/aZi9Ex9XwLjTs/cqP+WNdheqRXk8kKBgZdZDXyXHXkamDx
	ahXXvD/qWZY69lWO1REoWHvJUOvQ84sTIQazYoUFuV//uZbjgrw/r5BPEhqjSROKoT7wRp+TnLY
	qNezr6lKmMEW8q7bWaRdl9sU=
X-Google-Smtp-Source: AGHT+IEs/HDVU9d1bKYBVI4/TMeUANvetKf4wROv5hAy5IcHo1GI7fn/8BsZupvd1dRYhfXL5TJCeA==
X-Received: by 2002:a17:903:124a:b0:261:1abb:e302 with SMTP id d9443c01a7336-269ba43a195mr54404335ad.14.1758300030289;
        Fri, 19 Sep 2025 09:40:30 -0700 (PDT)
Received: from muxbit.. ([2401:4900:1f25:17d2:d73f:a989:54da:943a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016ca44sm58453735ad.37.2025.09.19.09.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:40:29 -0700 (PDT)
From: Manish Kumar <manish1588@gmail.com>
To: vbabka@suse.cz
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/show_mem: update printk/pr_info messages and replace legacy printk(KERN_CONT ...) with pr_cont()
Date: Fri, 19 Sep 2025 22:10:17 +0530
Message-ID: <20250919164025.98930-1-manish1588@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8121724-a436-47d5-af3a-a16f81cd0649@suse.cz>
References: <e8121724-a436-47d5-af3a-a16f81cd0649@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the feedback. I understand now that printk→pr_* cleanups
are not accepted as standalone cosmetic patches. I will drop this patch
and focus on patches with real fixes.

Best regards,
Manish Kumar

