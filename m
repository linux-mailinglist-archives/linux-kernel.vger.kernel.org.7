Return-Path: <linux-kernel+bounces-869935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE89BC09087
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 14:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3473B7A04
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD772FC02C;
	Sat, 25 Oct 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKI9Hrav"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D8256C71
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761396305; cv=none; b=L2939zUd5RXQQ1vrhd6eFtQQNkk+1sbscDeOZKiUsmjG6toLovsRbwhjnydIo6rV5sojfqiTnemsBoO0Pu/DjdYSqcocxo4ij9Uy3+uhHu0D8/lAQt4I3YIHBygZCw8dt/ZdNLFx2vxPA3SFBAJDFlOynoB4pKUPN5otJzLVyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761396305; c=relaxed/simple;
	bh=C7RCMPYJxiHbIff6uyGxXLWmOareJd5pab4+KHZQmA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neYFG4ZjmEEJ67bL6sn0JTgl8T3epO0CBW+ZEZ6Q2Py3zgMPVC5rHTDCfoi7JAGwcuesMvXPSRYdUUuWpSdcQ10RX5VTPw7PK2WyjUOg7Fj713iHhHatgq1difCdd6NETLdFqcnLH7AfCaYwiWuxCwJcGg8NLj9gYPn+qVDZwto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKI9Hrav; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29245cb814cso5926055ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761396303; x=1762001103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7RCMPYJxiHbIff6uyGxXLWmOareJd5pab4+KHZQmA0=;
        b=QKI9HravYuYwQwLhsLKCL/dtmWKTJGul9bgAzNPvQrM/7AA4dcM/TtsWIsMDQFi29u
         2b9c3DPlRrA4NCfp0gARe2ghRnyoum/ZtV5UHHXMKF+K9wyntg1GfzCgFQUoPTeJoypL
         rpKkVGPOTNuvUj4bHVdt1MT5SN/R1wH6TA07kPTqKL/+ElyLA9fDpYul1jvox6DZADlR
         dOn46Qajidb96sNRuhLmWaaQZNlObM3jCG3mdatsRLJvczrPN6lfzizk/Kkphf1Wolt8
         qjjuWJkaX7IpqP7qqKWZLhyNBeb/QV/1dyLnfLzFtECdzK3w9B84CTKYDS/C2YpRhJ79
         dUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761396303; x=1762001103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7RCMPYJxiHbIff6uyGxXLWmOareJd5pab4+KHZQmA0=;
        b=SvIlbt89Tb7p6fntTcLXbgro0NtSG8+UntAlh8Gv79dhLNwSjQM0CzPONKeSXdL1Y1
         n6UVHcJPrP/NrHV3beyONHGsri9rIHqqvl4iBGqb7sSNBN1jWsBzDoIVknHUQwvGKC4R
         Pqw876MfFNgz2W1BIqFrzt9E7APHmY1Ct+mzST6LHSril2JKGEYYN9gJbq8+v1zHXJXy
         +kK1E7OhAR3zVR6jWQICDQNlkpAHFO6Dhpsnxffd1BjT5q845aO/xvDaMtOwpTrw+mxD
         5TXoPWkp5RfzzU6PYEq3jut/JNhlGaMea1Ap5bRDld7wCehpX3szsrJTASeWk35tOJOA
         y06w==
X-Forwarded-Encrypted: i=1; AJvYcCWN8uUMpsTAXgrqsDrTfFBLjEAds2nfrE4belCLkyCjMBRuUXLLCGaaVglCw6ZGLXwFY6dN2qg9m+zLcrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5opLw7oSjccT3a0zi6w2iV0GhCEeoLlduJry/9PQVrLA9838x
	KMXox8jKFj1rHI+Q8v+CZcEUZqhymaGjboxGH5gfZsI+nB6QVlMkvvlbo6qjoxmZbLQuLCe4kf7
	8W/M4bdM8Yq11pFtqfo9wF4D9PJKOcuwXuhzN
X-Gm-Gg: ASbGncu/iw+tBIWNQ7qGXmwAfk1sWw7VfkJb9DRlN0NVJ3zC2vj+h9aunEXS4bEJxnz
	s36am+ppNsQd4F/57qpPFhTMMF7ugsQYUfEpUUFJFfp02VAYg09wBhZxwFh2Nv2kkgk3gd7qPnF
	NY1kVLBftvpuYzvER9eJcueOfxOCTw9tBj8zRTM5ZRLYUfCw7e/ySKltpSDT1VGYAkR/r5jtmKn
	P7IEWhh9GeuJs8f+SalQB4/AFx9mvMJPI28hR9kfQS/ukyPeo2FUvQxFhKqnEp0KeqgPCfd/nyh
	XpIC244pYTfBD6IqZUrfjujsImrUFdjseEi/JyE5bl3ZNuUel0R/S8qMHHmJBO9LSxGqUeOs6eH
	6I9Kqq4/yyUOzfg==
X-Google-Smtp-Source: AGHT+IFnwtuPM1t4cSFlyMdWfosAkAQDsFe7ldATnnuYeEiyjQeUZlc+gbfwi5fU05sJQRiLpWnjw94QHjb7v+hqPPU=
X-Received: by 2002:a17:903:1212:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-292d3fb7f7dmr114055105ad.6.1761396302912; Sat, 25 Oct 2025
 05:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025124218.33951-1-sunyizhe@fastmail.com>
In-Reply-To: <20251025124218.33951-1-sunyizhe@fastmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 25 Oct 2025 14:44:49 +0200
X-Gm-Features: AWmQ_bnwo3M8FN9w1gVNfQEyRU5EK1H9Fv1DoP63Bar4frG5RXkcOVmvftK9y80
Message-ID: <CANiq72=d0zXWAryVXHUKLUkcM_dPoC_uPM2drMXAVB7kh1YSjg@mail.gmail.com>
Subject: Re: [PATCH] rust: phy: replace `MaybeUninit::zeroed().assume_init()`
 with `pin_init::zeroed()`
To: Yizhe Sun <sunyizhe@fastmail.com>
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	tmgross@umich.edu, netdev@vger.kernel.org, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, dakr@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 2:43=E2=80=AFPM Yizhe Sun <sunyizhe@fastmail.com> w=
rote:
>
> From: Benno Lossin <lossin@kernel.org>

This looks wrong -- is the Git commit under his authorship?

Thanks!

Cheers,
Miguel

