Return-Path: <linux-kernel+bounces-742904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C14A3B0F80E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47E01CC01B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B43F2E36F0;
	Wed, 23 Jul 2025 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOTbVh+k"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE731EA7CE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287953; cv=none; b=kFrPZDCFu5uvuhEjN+daRwG5d9BKDlkWXueSNytpJ0FRsBWX07OB9KrjGfxZC30Q2T1WI8GatfK3pbpxkqAxHOXWsqcYgJdBihoXhjsSrWj8Sr5pNT4msOB9Rc1qmS+P6O15bXjjdkEi3hZ/FBJ/7ieOZ241WBv8IfOAqqANAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287953; c=relaxed/simple;
	bh=crGSmEZZzBdX5XwVo1TjX4JZzyiOlGt+tkX5ORlR/dM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eBOiVWAH0BzsSl+LLXYrPjmsSqN49Pio/IClDdOT7HEHrTs8E5YdfxZff8xrJDfLxiaSSDrjy7Snna1UDn0kXsSpEyLWR4H6iASxxDSRfZrp9y3fQ7NQRD4/KvHhfHNK1i2AJvWL+lUlPUYBhTVHVKM/uYuUFblSqioQikuE+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HOTbVh+k; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4fac7fa27so20314f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753287950; x=1753892750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7nlf4Cqx5uEEwMr05M8xGLym6bdF69iKrcAxYvQRwA=;
        b=HOTbVh+kaMfLmxlJdO7VY6gY0F/XY8jp0OO1Hiy7br9DFCyf/HRdohTzqlfomENCnN
         qv2Zp6yzfMkVIzjkhsUk/oI150/x6qaXhz4/yECOYjdrVsupRGn2NJuBR8GO4Z07C7tJ
         RUa/CHIOmagVTfBzxtDmsjNJ+NhnDcXk/yLb8pGg0ZEEAKTERkGLA7utNaRRVDMhSE4q
         /QhQL48UCYCGlCaQYvW1eixLGiQerdnsVlHxSwNCeCwS9JLQ3i4XtUUkSa2dccsn44kJ
         gAgB3gRMOM1Vo+QlEdYDzbkTwSK/2NnDvmt12wGekd4WKeRw2oLlPywL5GC2fY1yYBMV
         TOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753287950; x=1753892750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7nlf4Cqx5uEEwMr05M8xGLym6bdF69iKrcAxYvQRwA=;
        b=iBKdyxkY8VMxZcyC05vQje/n+GWrxkFgygh0/bLWhJRS/Z2uRqNeejltRZakA+rJ73
         qF3i8SMgHCqwZXxVt+JRR1dzpuxjIfX3Np4ogDnTx7CUuQmwKro5rFVucV+fxuRKwvLn
         0tWnRCsmanwgGMAOqEddb88+mVdK2uZ17S07QqHzASKXl8LPJgywQK9zwy9F0USkKg4y
         Y/tdQ2HuxLWRh9dOw1OTMM/+m85X7yrsu5bTSxJsdUYDy3YNqzlkv9GgGIJi5OsE1YHT
         NEVQNBsohW5wMKSh2O2Cd4qZoH14A6P+MUO9RKw+ZBErlo0Iuf9WESVBaiXEL/Rw12+r
         ttog==
X-Forwarded-Encrypted: i=1; AJvYcCV/0PRw/mgKIT9gSDekHKF4qMB2Iu3QTc2zTLzIqTW7FjaEsYpm2HfzpmRPNbEubVyw3jZmwxNIXCRHUIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJSJn29Wn3d10LHoQzLlJn56SkoLLd+oRYxsHIFpXql8YZShc
	lyxplZ9d8C+613G+lrCC0UITj52KYAT1GpGjrl7XXaIHLW4AWFvEz7YxbkTvdPy47guCo4C54EL
	N2DtVjg==
X-Google-Smtp-Source: AGHT+IF1gZj7uYUs8D8ao+ag5oMJ8erDSIHrlj2XvlP24E0UVjCruiGOe8gDPJKfTVGemA9iyDmfCNj918Y=
X-Received: from wrnt1.prod.google.com ([2002:adf:eb81:0:b0:3b6:1610:fc9f])
 (user=nogikh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2c03:b0:3a4:f975:30f7
 with SMTP id ffacd0b85a97d-3b768f12e09mr3084562f8f.56.1753287950449; Wed, 23
 Jul 2025 09:25:50 -0700 (PDT)
Date: Wed, 23 Jul 2025 18:25:47 +0200
In-Reply-To: <20250722100743.38914e9a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722100743.38914e9a@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723162547.1395048-1-nogikh@google.com>
Subject: Re: Re: [syzbot ci] Re: net: Revert tx queue length on partial
 failure in dev_qdisc_change_tx_queue_len()
From: Aleksandr Nogikh <nogikh@google.com>
To: kuba@kernel.org
Cc: dvyukov@google.com, edumazet@google.com, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Tue, 22 Jul 2025 Jakub Kicinski wrote:
> I think this email is missing a References: header ?
> It doesn't get threaded properly.

Yes, that was indeed a bug that has now been fixed, thanks for
reaching out!

-- 
Aleksandr

