Return-Path: <linux-kernel+bounces-874157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88270C15A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4CE3BBD14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E5C33FE0A;
	Tue, 28 Oct 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zD7qzO2c"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC8331A52
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666802; cv=none; b=mX6iqte13dOOPZGCxS5C2/XZaYgoSN+plpoJ9JXHbzH3nnGqyv+hIam1cWuL6zQlngdR5xwmJioO8XT/EN/rWnCiU9mPajjE1wApCRJy1StkmL9wFGgD5jRMBaB6CvKQDWg1T55fyu7l9L/z7NRCZaCduuFIrh3+Y3JBTAxUAUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666802; c=relaxed/simple;
	bh=bvubLNry8i2KgFkZtrgq5oxD9xLD4eBmItr1+AV//cQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mTC4d+U3p9vJVLwT7vbu789dbwrwpTFXb+3ytjvgny1iI5pMKUMnsEiywou7gbdc6uWva9pboj+A7eGqY1YO0i623MQ/eXmYgtxPLUuZuTKMlOGxBzazuZMaUFAoM0cN1+cArir3NBkIGs7nMn+49eiUzJm1jZmH52sqLDWdqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zD7qzO2c; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340299fd99dso1151859a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761666800; x=1762271600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghHNPpIkVrYu62/YqFMFKRWudpG1mODk+3kt3NmNBok=;
        b=zD7qzO2cJnFg9n+oilba0f/J69xmkMPbY/mbMWM6V9Pf69cL7kWebvmq/BK3PCBWze
         BMfiRW8uiuumUlyRvm/Um0ih9HFx0ecFiUwle4RetUGUGt8/S8myskPuUKMid5GoPuUG
         OMvHYsQms202Czb+FvR1ttrm31VUlHesNhgW6g6Uc/P05IpGyms0MXpj5ACk/mewW4KE
         toabygEvXx4GJMSGbx6DFUHZdmtPqEgB/x0Ow+aCTibpviTSy+hqLUfdjNaRXecq4JsN
         U/cnt6Cn5EY76Av6wRk9mZOOpmvw9O+hmj54eLptI8uteBa8nlkwbVF8X2fv191MB7GX
         XEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666800; x=1762271600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghHNPpIkVrYu62/YqFMFKRWudpG1mODk+3kt3NmNBok=;
        b=SAb91PEy9jE9nLqupK81zI7ELsY+myzs7Q2bLKKiTouKVrVI5R1gXCe+7CyhO08H+I
         joB70TRuHnZc3oud57SdioAnsVv/ZZO8HdDEgvSH88pcERrMbGBcbqBWMdzDYmeXb5aX
         ahfoUslnEFn72hIEEVfSPKzQjp1nqoHq1Rnniaj/Uwh4C2ja1ZJR7XbTt69XKuXwBcXa
         W7oVFw1B5ZxxUkOA3u3uFa5ouEM9/nB9r3ivyR3zq3PoS0+/dXELjObViQz6RG/pPiJ1
         e015YU98SCuUNN17kq8c1k7GXyuk0DX4P3q8hu9WHPpNNugisI09ckt0uEBoer+lZG0A
         5P2A==
X-Forwarded-Encrypted: i=1; AJvYcCU2HMhoaSVIrTTCokbA8ZgXciPL6ubHO2Q1/L6qNifgJ+P5HO4vBB21AHwK40/ipCc4oX8AhqA+K5wd6/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc0eaXD1qmH8HbOydVaFx95rDHqPQOQW9RHUpB8RE7E6xSEafW
	3dLL4dvL4ejVoYKDXUHQ6h0MVsVrtmc0hTyUvOeyb9HyiKXE+nO3qU4q5DeRnHEGE2A94t0ZH8J
	ziyK84w==
X-Google-Smtp-Source: AGHT+IHFuR5DYWudiyV7h1agovuZqNOF3NC0YcpaGD25SCPgJSDGq9HjUwprk8+VKQsrML4GoiDI522EkQ0=
X-Received: from pjbsb7.prod.google.com ([2002:a17:90b:50c7:b0:33b:51fe:1a94])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c8c:b0:33f:eca0:47c6
 with SMTP id 98e67ed59e1d1-34027aac14fmr4416665a91.30.1761666800026; Tue, 28
 Oct 2025 08:53:20 -0700 (PDT)
Date: Tue, 28 Oct 2025 15:51:50 +0000
In-Reply-To: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028155318.2537122-1-kuniyu@google.com>
Subject: Re: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
From: Kuniyuki Iwashima <kuniyu@google.com>
To: richardcochran@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	junjie.cao@intel.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, kuniyu@google.com, thostet@google.com
Content-Type: text/plain; charset="UTF-8"

From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 28 Oct 2025 07:09:41 -0700
> On Tue, Oct 28, 2025 at 05:51:43PM +0800, Junjie Cao wrote:
> > Syzbot reports a NULL function pointer call on arm64 when
> > ptp_clock_gettime() falls back to ->gettime64() and the driver provides
> > neither ->gettimex64() nor ->gettime64(). This leads to a crash in the
> > posix clock gettime path.
> 
> Drivers must provide a gettime method.
> 
> If they do not, then that is a bug in the driver.

AFAICT, only GVE does not have gettime() and settime(), and
Tim (CCed) was preparing a fix and mostly ready to post it.

