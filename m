Return-Path: <linux-kernel+bounces-786609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FA5B35F12
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15255188D266
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3A5322557;
	Tue, 26 Aug 2025 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abhboZjJ"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDC92C15A8;
	Tue, 26 Aug 2025 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211026; cv=none; b=qfCZX8c5RP+7RnY1ZGWkKlfeynPMWPl+zq38oFQUPc2cNVDkuHvZoL+Exp/ZZlNDHJTnJk4B7IWtkzd/BzRu95MHa12uuXkoVaaxnXy4JpSYabESiIzXbyINlg5NpvHltSX4NoQehK2PpcJXJSrvKtC+rwmlN1uZNQU/ShFjuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211026; c=relaxed/simple;
	bh=zlaA/2aLr0/qJ+QFDrPDb5carJ2Z+6pUwH26wxcn2kI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eWyoOYpFFyT9YzeZAgWy3vL/Ksf99jP//MAnvpJrYdsXgA+ioEz7MxiNLBqvkBXiXwriw4OhvzUY5AvFRKENA0Hic5bJhb5uyGRZsTVXVXLkV+HzFvmCLg2+1XwGys7xp49MqfGI0g7Y5chO9xbMZfTlLZvjrB20puBa3IJ9Vj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abhboZjJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4c1d79bd64so1886491a12.0;
        Tue, 26 Aug 2025 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756211024; x=1756815824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPn/MDrvW0knyDWxAtqIUJgwCpYh7nd+A1Y/ljsF188=;
        b=abhboZjJkxV/JFCQi0cRwHiH+pjuSQ91eixKcCTRebj+dYSRtWngWQJelr0Jq0qFDY
         19Ekxp7kyVGRZdEWmZYL6kXxtQUPDzZ+dBAUR+d0NMqsyTmWwULBaBKO8enk7Yn/k9GR
         rZ0l18ALvduCbMNaMFS53UvTJIMPC7n82PWVpX4hcIvgf2nddVDL442ZFzQZqM3VClzS
         N6CxJX248w7p3d1zKMG5i5M2p3BmpOYzOhF0D904SheGFILAn6pKCqX7rYDRzPBBE+hO
         vTKSLVB0/PbiwpMVFv62UgRffhyrf2EKu0ZNBFmjSicrefvf4/kEokgGDFZHCOZwcX87
         QRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756211024; x=1756815824;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BPn/MDrvW0knyDWxAtqIUJgwCpYh7nd+A1Y/ljsF188=;
        b=S2E9ogy7V+RHAB5uWK3HaxCI+5IMb5brw9SU6val+VybQ3L0JEJgg0+Z5Ldn0TatwR
         tYNGS2rcltRqfJHDEL/W2a7KUxbwKHBbYEZ87OcaFkpL1xOgcBbhZt9EzxsK3NLAgGDX
         f/W1ZkU8gcEra5y1ctoxz5QgYTVpvohN+U/bSjch2okRlUVN4k/oq0Kp1/wCjU9sSQO9
         ioVSiEDy2LHvRZVe8Buqjvb3WmTtScA1APLqk5MxehACE50c2GJIOKnV67Y5+kuQgqhY
         L3hcfMf2KVZukzyfcnhTQElLyUSTyI9YpOtchKofURDD+wnGmXyQMfvcVteRy2tVqpp7
         Fgug==
X-Forwarded-Encrypted: i=1; AJvYcCXLoMUCCspee/K4lm3VkVNij53cdBP0TE6CiVD61pCYnEdyMcc+bNc4G+GJxbEteYsBVLuoN0QxLtrc2fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPD4ua2tRXHT0DGKmLU6AkZd2mzVWwL66xUrQOIC47Sb+kTl9
	8uZNi9KbclPxKRcOosIbidhzsE0RvnppAknB53WX9n8r1P1cB7VCqWHQ
X-Gm-Gg: ASbGnculZVYK40uwIbLYFAo5Pqlj/E4RYaIV8zABAgfogR/gEkDNDbK8rWWrAxkdQvf
	857d8nydqdyP9wAlf39MfzLA93pKMncMYjVeTZCa877IfDCMq2gRMlQPHldNSZ+uFhB0l0r3zG1
	BDA2Fwi4JKP7f0qT4k4306qyQlk9xZLAjJwi5W0E5KMtluHuti4twUO2sSAvJ/LRWWppGidxTmz
	eCryPDDwpvi1VfKBUFFWqYesDaerqF6A+bNAhfpA1ALqrRhzwMemdgljgTwsuXwL41QKbMJSV9d
	dz/lqE/K+etWbgCkXVemzI2dnbsSGKtfNsyhX9cKLbu/ppPOoyslNaxtfhU6VuUJxiJ6AGQQKAD
	hCPawJvtVvFBZ0mohcB4al3i26AFSoHXDJrkLJloFbDD3AFRVtyXMM3l7n+QGS/fmgIFFEgyeG5
	5k
X-Google-Smtp-Source: AGHT+IEX2gui6OULwsE3JxeSgxoEUBEJy/RoGPRBfBNIgK6CSFXUyOzheKhr2zaT/FB5xiDY4R7yUg==
X-Received: by 2002:a17:903:1205:b0:248:79d4:93b5 with SMTP id d9443c01a7336-24879d497a4mr12142995ad.33.1756211023782;
        Tue, 26 Aug 2025 05:23:43 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668779fb5sm94674995ad.17.2025.08.26.05.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:23:43 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:23:28 +0900 (JST)
Message-Id: <20250826.212328.1387093980490118773.fujita.tomonori@gmail.com>
To: lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, a.hindborg@kernel.org, fujita.tomonori@gmail.com,
 boqun.feng@gmail.com, frederic@kernel.org, anna-maria@linutronix.de,
 jstultz@google.com, sboyd@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org
Subject: Re: [PATCH v3 1/2] rust: time: Implement Add<Delta>/Sub<Delta> for
 Instant
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250820203704.731588-2-lyude@redhat.com>
References: <20250820203704.731588-1-lyude@redhat.com>
	<20250820203704.731588-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 16:26:43 -0400
Lyude Paul <lyude@redhat.com> wrote:

> In order to copy the behavior rust currently follows for basic arithmetic
> operations and panic if the result of an addition or subtraction results in
> a value that would violate the invariants of Instant, but only if the
> kernel has overflow checking for rust enabled.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>


