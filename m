Return-Path: <linux-kernel+bounces-731378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E019CB0536D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFB64A0619
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712F326CE26;
	Tue, 15 Jul 2025 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYDEWeIN"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49499DF76
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565113; cv=none; b=qukdaLlqHxfyXjuAWQ8WXZ7HoG1iEeQsYfFXq8+0F1XuNZclL3tlVv+2oE+dFtrMHHxLy0Y8mx09I3oxhZXkEZ/9GrEipbG6EipNVMxYylEzFZVs+TSRDF3cgY8Mzx4k/x+CpvbC6XOafQ5qzyN5hMu4ZTMPBoHVGs8xNenbcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565113; c=relaxed/simple;
	bh=txbBPuITR8MUqWl2okcvq0Nf2JSCNDHvgcGIxk7gsDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RJwCtigmEHcmo9kSnbfti66aQNBXrkX5w/g+DZ3n8ewkLGSECO0CehgKeG69OOwblgvVr5zYiyF0xPL9PlaVApYcOrALi+tvgZLpzXcoEhv/r6W/Vc9UZ5Eo/oHEVHfUuy4o/dUEKy9wGqMq9DP+PR433W+E6E4tvJdt6Mz1VdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYDEWeIN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45626e0d3e1so3862855e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752565110; x=1753169910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBEKzMNMZEpdWEcZBeYWBKVoqOZg5l07Q3t6CYKLIBA=;
        b=uYDEWeIN6R0D1FH7kjkaLHA+mvTfvqe89CdR9qZyflVHBXEE/20GA85umtxO+ZXJ4A
         PZo6ULA31Knn2Cs+Oj1pCPSxMcKIZdCekJAC5dCAF8vXEcJCA+gG0aFALHn/bwGrMRa8
         vAL2HXh19c4J/N3D/BmeUjbsll0UrUqzYe+bx4N4dkqcNlCL0X7Vs5fuA5AMeDNZTkHH
         xcdKezzTfYuuozVPl4CVPYY7YVa9/afYKC6w2C4mWI7Q89NWGkdgEYRfsUdkcMy7H0GB
         4nH9aAIByUMlCXdmuxFxFwMGgVvwUVl0mS7WWlBH4a8MixHMbsEe8W5zNg5OX0p5RjNK
         Oc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752565110; x=1753169910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBEKzMNMZEpdWEcZBeYWBKVoqOZg5l07Q3t6CYKLIBA=;
        b=ah5utM9ZXQg8PtiUdWYGi7t4WEykgVNU5QEIoAx0+8VtEVDlzXDRbIruiKkfW7wth6
         jw9j1vkZngttvs4XY46s4ETLiyk2dQRzoV7teLFdHcPlvZrUaAvCx8DCK3aCGYlf8eBb
         ZXVGk6HDvYmh1pjQz+vez8URUNvvD6myLPoV8FHE6d7Ij96hisok1oo88RCEQdAP8mU6
         kJQNDKdL8BmCLPInr3GFhkuQ//Q4RYBkVnx3rfQUw0RkAdPMbfRqZW44yumowH7D4N13
         YZGwmxaAU3wdUFOMymNhhjL7ewB6uj1fxfH+q4UbTTO6GDETW6CIhnXSpiZATEpS3bu6
         HBUg==
X-Forwarded-Encrypted: i=1; AJvYcCUpBjDi+kpPn3GplZmHtgaL1iMpUySfCH45y4/bX3O/iEig+RBzdfd+iNlJA2kPp1m5P1v2gfINL0afhfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4s620Sae7QhrRX4IPwzOJRPsKdeyvS371lRH7XK5pk5B3qTgZ
	/zFS/DBqTbOEt6fNJQZxTNXOKVIR/D94yCP4ZWg2iSyfEm+uhd3PD0P/dGV4jeUrjeiINjMYLUl
	L2rrWUNfELFtDl7gphw==
X-Google-Smtp-Source: AGHT+IHmUIjjEiCvZ58AooTaGTosLMsc9Fv8QEsH3aci6GBNCm5K3VJNur4Tbp9HA713rs3r8jI2KlHwlMWGNNI=
X-Received: from wmbej14.prod.google.com ([2002:a05:600c:3e8e:b0:456:1bf2:2be2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4583:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-454f425eb60mr149362805e9.29.1752565110744;
 Tue, 15 Jul 2025 00:38:30 -0700 (PDT)
Date: Tue, 15 Jul 2025 07:38:29 +0000
In-Reply-To: <20250626073054.7706-2-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626073054.7706-1-dmantipov@yandex.ru> <20250626073054.7706-2-dmantipov@yandex.ru>
Message-ID: <aHYFdbKgcEo_buVF@google.com>
Subject: Re: [PATCH 2/2] binder: use guards for plain mutex- and
 spinlock-protected sections
From: Alice Ryhl <aliceryhl@google.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Carlos Llamas <cmllamas@google.com>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	"Tiffany Y . Yang" <ynaffit@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Jun 26, 2025 at 10:30:54AM +0300, Dmitry Antipov wrote:
> Use 'guard(mutex)' and 'guard(spinlock)' for plain (i.e. non-scoped)
> mutex- and spinlock-protected sections, respectively, thus making
> locking a bit simpler. Briefly tested with 'stress-ng --binderfs'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

