Return-Path: <linux-kernel+bounces-883515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728F8C2DA8F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01590188B7D0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5953B314A89;
	Mon,  3 Nov 2025 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSwb554f"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B42D5432
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194144; cv=none; b=rO29c2P47eiand34R9A7IkVmCVUv4JOhXhv+U7MhXk1NIIwMRRTMZHB8O11eM/mzd5TfKzgpMlt0hOolz96vwLZo7EKGh5SPGqrffdFlTrq0bCXgKHm0mZV9UBqjoHhrrZYIHZpM/zy+bgSDJ7kw6GoA/+XwG78anigaR7QFLB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194144; c=relaxed/simple;
	bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuwuGVZskrftmk0EvmVXVsFCrrQmTQfjA2mHNLpvkjvPf6w02lnvo7vILC3NMfBepctwC/pKGULCD3Sw7vSDVpsU6tP/KYpH2K1JT9OCBX86gPCuIgFEPYdjB8CgOW8RPw5sRahc0zyE1U4PAzG+opDNpSNWiV34sB/u/Z8lEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSwb554f; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-786635a8ce4so17513967b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762194141; x=1762798941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=JSwb554fKmClyMWwiljXGsEkLDNbwg+2uIqqJGEqGQDqeVRKI2xB5zhTr75c/SUlE6
         6wlTDm7brLFjHRutrs4KlyYLry92Vpf1uqG6X45Und/e10uG7Z/2Szvylr/fpnDmpAKR
         mh2h7tBwUkcYQjmiR3bi70h4oJP9CFiJn7IGiHBW8ksWH/EKlrMEtA8NuUyJyDIXtVl+
         JFh5kshHH/s7Wot6u1f0Yj48XvFbDUDVBOPutB6b1aqnmev6Ys3d4Re4b3GhZTdbHFmI
         46qK2S+aKhoJLmqgkNRn8yqG8sNRFbBu+MJ6ns9KggNooX2zZdy+rPgSbZFPUZ6fRQPy
         ALjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194141; x=1762798941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=l++UabIwRRBAiW4td9d0ovAcJlx6n9YC7P4Nhkq0uh7Qnz0rP/Hjs5QAm5EaKdwFf0
         ePM54HuHXgi7Mzq36KS7uqIEbsf0RaDAcGwrkzwQu/rsnLz0dBYl2OPrp0WKIxqz8n5q
         lg3IKgG6ix5EfF37dTJdaI8BxDfQtj6RVzF0AQeQUaGLhBUXGmuLBqfjP5+57xeKX6q0
         yWVXyox9dKSRtosUx2PaBbHoPeBQr05nbEm7B2huxh54WvdutidAL+YoNLXyoqodS8yO
         s8wgJeY7GIyqFKcg6yG3kwge7BLOhbKxaDfOsyouZKVQHLxGos7pO9dlVVKS58XvI67U
         KtJg==
X-Gm-Message-State: AOJu0YznGi3thuzmo20dGPVxHYozPKocAvc8rD442j59m6mDkOewMVmq
	TTNU8v7Fay0O5Fj/33uAhJ9RXlD1K9povLcfRzLQ4vc7XiOYvnCM9WoY1eY8HlWu4IngDoGRiyX
	PMpXZLYisa7ao9QC5CCjaIh/KtH0eA8FtpBCxPlM=
X-Gm-Gg: ASbGnctfKdk2Cq+HjZHXDjUbVWOxpPAM22J6JtrOgn+s5GYPC8nLvXjgYmFBwI+qwQM
	S2aQEOiN/FJyCMPlLn72J2QWfQRt1YAE32cWnSQBNmzvJYbbFlnR9sGQc2Iib5XeFvXNtt20Uea
	mIz1cc6bZmnkn21JV9MXZzkHVw6e4N9D7DhmF2sHDxFf6djK+GGhIxFBy0CnRkDU3UnRR96/Gy0
	EtiMkipTahRgAFj4o51Ky2oicobBuvhW8oI1N7300oIlxs/7762eiMYIRZoHw==
X-Google-Smtp-Source: AGHT+IG5fl9Ca6IoFVXCby3OjpqI8VMpFebri/sOCkK+nWIHAzNm32WsbYNZ/ksmDEU40LCIfXNPgLPM3KOdt8Ty3tU=
X-Received: by 2002:a05:690c:e4ea:b0:786:5499:634b with SMTP id
 00721157ae682-78654996821mr73008517b3.23.1762194140728; Mon, 03 Nov 2025
 10:22:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031095643.74246-1-marco.crivellari@suse.com> <20251031095643.74246-5-marco.crivellari@suse.com>
In-Reply-To: <20251031095643.74246-5-marco.crivellari@suse.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Mon, 3 Nov 2025 10:21:45 -0800
X-Gm-Features: AWmQ_blcPg1mU0jAAEnoVK9uPDIOp9VK-IcJyOwAXQxd100Xu_HVOLJgLqbdWSM
Message-ID: <CABPRKS9eiAq6USotto=kJzhKxJvVWkQgm=eHFN11v5_hnKfM7g@mail.gmail.com>
Subject: Re: [PATCH 4/4] scsi: scsi_transport_fc: WQ_PERCPU added to
 alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, James Smart <james.smart@broadcom.com>, 
	Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin

