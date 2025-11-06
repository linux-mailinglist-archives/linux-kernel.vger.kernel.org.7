Return-Path: <linux-kernel+bounces-887606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A0FC38B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44DA64E5A29
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548C8222582;
	Thu,  6 Nov 2025 01:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hnWn1rcW"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171B221543
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392279; cv=none; b=o37/kMLA0LBO/C4hDD88w98mXkW810QId4yYZsBku+KMWd1y4OsMBMbUQNUg+z5UW/5yx9aYSLnD2Epsrsho16v0+DMI1q5bh+am1Vl5uhwB74VEnFYcALEksNAeLqI7aWuZwQR9wASEO1Hkmx7u6PJA2NvQCgVR32pUo4/gB7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392279; c=relaxed/simple;
	bh=YuqAP9iw5m0k8yqDCbNn6GdbDJxLVkg7prdjTg/+whc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qk67BS3QFlgndxeuvM4QPe1aybNNr6Uz2sE79EC2fJfUe/hdnKqvBZiWjSJFCNgK7Nk+yyzS+P1ZohWcr8YxNGCTGbd1IzSAM4IO6xMXtxn/iObbATz57r4XkXxBUs9Kblem+gUPyrQ8dvosgIxgJl1gf1tvMgHMeB+QtXtGkSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hnWn1rcW; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8801f4e308dso4970376d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762392276; x=1762997076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciojNVrmV7+Z0WHPv+m6AyJCXXR4qy2RoeHAXQm3Zwg=;
        b=hnWn1rcWiEvK+/8nGBH4voib+NAhkQMsQwYHlxXZhCot0+xsfB+pR/bZN2DmSjxBx1
         cs9XbK7vCiqpeJG0kW+Natq/4emg2wySJpLdmcIA8JE8JD2MTAo4K7OkIPc9yGoJnaTu
         kR5u+bt3LK1aiXklebnSquDuV6Oal+KAKtmoAPHZAL2JoB7JqhGylKelb9u1ZRVvuOPC
         rsSOdYxCEZf03cZMp8Omn2wqMDcO/a4lEUoL87udBflbnvcZYxnDSW9i3j/Qhrucko+D
         cGwacZZR2/srFAtxqWNMej7Z8h1Qhi4uYzlwJa39rapMpYGzefpzvFvhoyjFX3Vfdp7z
         gSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762392276; x=1762997076;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciojNVrmV7+Z0WHPv+m6AyJCXXR4qy2RoeHAXQm3Zwg=;
        b=ezoATdhuiPd2ED7KYdD5/tEOCMJ7/xlmc6kUqR9UHLHwtmIJrTqPvazod1ky1ypy6t
         mIV07sKgiVwYjJolTPRvgLkhHOwBKmprFO6o99hopy1envYl6y3YSZ0aZ84jg9dgqpCQ
         8PBiL5M/McRaF6xFKYWzvgbCxgk2au9dU82vg9V33dU0RR2ZUr2CuhVE7QPykVth6PtI
         NiBzzsWDArVpdBiV0UeaMZpAc4r8UgdPksSqYgZ8IxwFkxlCKItTxl1MaKULF6VOCX3P
         NWOdtvcO5fiCg59f1ycg1s8bG4ZpxxS8Y0/3fe6UxJE89ylgGkiMnWbTv+lTO4+jClAh
         12Og==
X-Forwarded-Encrypted: i=1; AJvYcCWapQHwg+bpuhkFE3ohDt6EZsK9nviY5HLrsqPmZb/N5Gt3jyZadElBZUal1ddXa6UTGDrUVzySO4gj/Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTDlhn4DBoEKjMRuJk9n8rNcui1QHx4dwWF6X9LyuDKl/3Lijm
	UA0P+63A2+wDOyL1G8hFeYfsoqXG1emwfx2tUs2QK/FWxl6yLi0oEh8A7zICb40UjA8=
X-Gm-Gg: ASbGncv9UBAjBawIiRXYIphuTPaRfIeeJA0/fMg6d+2SpEal4Qk7Ov+MXUqoVeQeIy0
	+uhQxibkLjA4JZ9tLnoPcUjjBNEBwTbiNau2mMm4rIp/+m9QjjF3h4i4qtbpaET3Lg2p4JcFNBR
	p3TxH00rl5MNGQfTmEHDDubQH2Ngur0Isdz2fXhNClmNGtWuCRHPIEv0lLD57LZGIwCahuEDdJ3
	Ep5lOVqrhEt0hatgKFl45Z9efxqYA3mj0aL+p/l3JSlV9pX3dwcyrNnJc2IJbx3ooUCONhCGkFi
	CVyN/xj9mJeSsktLk5vZLoH+1Wju1Q6T/3bD69rigrBtLj7WJZLw/3TNFYyOeLAaQvzz5TpzqK/
	/cS28F6JHQfiCqYJZb6bWz4FmYe9v6NWOPMScaFCp7eMm2P08hZpzD/HnsB1wAqgT2EMhzts=
X-Google-Smtp-Source: AGHT+IGW8dMBI8W38mAKSfcpKPv42jStcm1Jq3Lm9nyg1mPUQx9NVElx9coA94cKj7jGyUgQKJ01ow==
X-Received: by 2002:a05:6214:20c6:b0:880:638f:1a1e with SMTP id 6a1803df08f44-88071188e82mr86814876d6.46.1762392276316;
        Wed, 05 Nov 2025 17:24:36 -0800 (PST)
Received: from [127.0.0.1] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8808290ca3csm9180786d6.25.2025.11.05.17.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 17:24:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shankari Anand <shankari.ak0208@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
In-Reply-To: <20251012142012.166230-1-shankari.ak0208@gmail.com>
References: <20251012142012.166230-1-shankari.ak0208@gmail.com>
Subject: Re: [PATCH v2] rust: block: update ARef and AlwaysRefCounted
 imports from sync::aref
Message-Id: <176239227492.265257.9458847625438366848.b4-ty@kernel.dk>
Date: Wed, 05 Nov 2025 18:24:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 12 Oct 2025 19:50:12 +0530, Shankari Anand wrote:
> Update call sites in the block subsystem to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
> 
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
> 
> 
> [...]

Applied, thanks!

[1/1] rust: block: update ARef and AlwaysRefCounted imports from sync::aref
      commit: ba13710ddd1f47884701213a3b6a5e470f6bc81e

Best regards,
-- 
Jens Axboe




