Return-Path: <linux-kernel+bounces-770802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5976B27F15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D96D5A729D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA17285C8A;
	Fri, 15 Aug 2025 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="NY2Lp/jR"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013F27D784
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256681; cv=none; b=TVTnlpUcCA1/D/p8QWTBg1NRHvB9pjMeOE0t/ZdaDp6WmDzDDS0ic84S2PPkIjpGampUmjRHDaynTVBeigIbEgp/jkaI2gGWOm0muRb8yHolDfBtDy9SEuOZOJU8g2T9rrozyqT1Ylz0yMZiCjtaDKfyIVGPLIC2YQZFXT+c0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256681; c=relaxed/simple;
	bh=NQuxMnIum4rjvf5wJelGGvmNmA6J6RH2z1zUhaLT4T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofjXq9ZeBkLZ/+FCy3iN/G+EsbWr0CLAzVUW+9t/P9q56Jz9yhmkHpnHKVOpLYDGx2UyRodrnS0A1LQSgDp8hGfx7rA7+Qsgfpnkku8Eb+dG5i6fQTeDKP2JiuDpha4bP3dybUBjlR+pZQNmqEgcN/P0x3o8u1OV17/C6BYttiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=NY2Lp/jR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e872c3a0d5so174648285a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 04:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1755256679; x=1755861479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NQuxMnIum4rjvf5wJelGGvmNmA6J6RH2z1zUhaLT4T0=;
        b=NY2Lp/jRU7T1UfhJuhkUmYtZXGmCXCLRIDNN2XmEqDMf77iOZufUQvUNYYCv+A7tOo
         TSgwiTDWl5tjxHZGFBcSeQctsPel5mmYBuPMEHYci00Y3e6ZaiX1hC//Yo9rcea6k3RY
         +VDIwxfb665RDm2TMBvhRQt7zhynCSHPsXw2smYP0RZD0XrHqD7Kr5xXaE/NZJXAT/lB
         t8/QbBd0kpmmyx0Z/fSzVSFzw6nMfaCTBBGZfXpzYnedAQId4izLD5hr8/FATL0nNLYA
         hEWJaN4n3j4wbBclkwYYhQqODWOtsG2qw6siLNFtjioynNgA8PX/Wul+otL5xswZnaw8
         zSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755256679; x=1755861479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQuxMnIum4rjvf5wJelGGvmNmA6J6RH2z1zUhaLT4T0=;
        b=Uy/Bh+6TRAyWtHN2FRLUsFqAXubStyIW6O1WJ8+7gN8vi/DabmnTeTvo/jO+3fqGGe
         UirkRC5Ce5V+vi7zAVbZV/njlmdgj5D8E5sW2LMPBQIS57uREsMn0N9Kxu7Pm92OO+3Q
         SJ+qnk0qVJdmBl76jQzw2nS/MbtV/cBsCx2xrJHnSlFS8bFv2Ls0Cfw9Vxp+XMzGDtpm
         dQgOh+ruLo7IZyJLMcTX20U3nkE0qg1NbzenEzyE3RfLlKjrHIV6Lx9pbNbVX67jGKv2
         swzMX73PihbZKo1/F9LRJRfNJKq8DCOY+74dDCkEzE2IL4rus0m+PYdG/jnIBbCdtsBO
         4QOg==
X-Forwarded-Encrypted: i=1; AJvYcCX1uFHSIVnt8tvhtcioMPHuK/GFy1dwJS9CE2U53+LRpx5ycJY+CzgrdHr8Z0MMrG+JOHmBWADPu4jsqmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtOLYpULyUxEWnfSZsoT9FizeAl+ZVZuKrA8+LRmsrkovBfO0+
	+2brKi5WhZ/zm3tuMemZ5cQ1E6QhPVTgic16PcFOkKYYKX+YhCs/9/a3LjumFNgKJUjA6CGIono
	HfyAQ1ibOGSCQoi7v+uTpmoQTs2np/DvjOo1uwTv3cg==
X-Gm-Gg: ASbGncvwjaXPFv8cXL4ZHljB/MimaFeEPDWUCSjE7USpSOxKigboEIofR9776lGv5A+
	TkcXKJWzxPMdcpYpn4x/j05ktLre8iInSBWNhA2Z8V/Uq9cXidxBe+Ox59ZsSv6OhxmKb09weiZ
	vty8yo7fxSikugtU63Ux5Gy7wfmGKURnlJCTNrPVloqRleyK6TbaxbMSOQ2sMd2wRTT1BZlBoqa
	SW5yKE=
X-Google-Smtp-Source: AGHT+IFgacFlGX+wQD71QQnZi8rjVfqAYc3kQpR6Lpo+nRIokXuryBMbxhyDQFzjfuqPiOWbzEJ45Qq8/CfCGpJf/HE=
X-Received: by 2002:a05:620a:1a9b:b0:7e7:fe10:60ac with SMTP id
 af79cd13be357-7e87e05f9c0mr188670485a.33.1755256678577; Fri, 15 Aug 2025
 04:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815102539.39711-1-steven.price@arm.com>
In-Reply-To: <20250815102539.39711-1-steven.price@arm.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 15 Aug 2025 12:17:46 +0100
X-Gm-Features: Ac12FXx9MLgVJhNinClmSB-7eBe7dwYDiVAAxdaVcixGjfFRjKyYhpR2-6JFfcI
Message-ID: <CAPj87rPSoYe10JqpwYO=-tTX2EqnwB29wrYfhyWwpAyAczRVig@mail.gmail.com>
Subject: Re: [PATCH] drm/panthor: Remove dead code in mmu_hw_do_operation_locked
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Karunika Choo <karunika.choo@arm.com>, Chia-I Wu <olvaffe@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Fri, 15 Aug 2025 at 11:25, Steven Price <steven.price@arm.com> wrote:
> The only callers to mmu_hw_do_operation_locked() pass an 'op' of either
> AS_COMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT. So remove the code paths
> that test for other operations and add a drm_WARN_ON() to catch the
> posibility of others appearing the future.

Thanks! I think it would make sense to also inline
mmu_hw_do_flush_on_gpu_ctrl() here though.

Cheers,
Daniel

