Return-Path: <linux-kernel+bounces-882068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 857DBC298A7
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B083AE943
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E4A23E229;
	Sun,  2 Nov 2025 22:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh7wwobb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6421632C8
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762123794; cv=none; b=QlxZD/ReNJDc2MH9o2Q3qCR32w5y1ZmmCat1Ar8iKOPp55ayylXD2umXZBskQpHut55Ut4xhFmHWHGFsXXVrCCGIcEi7Eh62d912H1aPek+LGdIt2xGqfvAEJiTI9/aeU36c0OsRGQS6GK5FgCRGeVbr6mdZEewl0Z6yE1nbPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762123794; c=relaxed/simple;
	bh=6i0tXaGpPRHI3y0fdNRPiXjwzY/va2gCum+8pnK6wqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8bCb06EMhWbr8f/2MQcFDMsT6YAuqkUhOWI5hyM9+Jm/2zobebLRHwF+hnH36DsyLZjHTwG+Fs8n1CCYQ4KrnK3tX8r+KK6QBWsCRK/GRFEx1edBPsxN61OUAwFvu1PzAcWu5eC9alaFOx6oPsR/DrKTWvp4gJtIH7GtCDEFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh7wwobb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47710acf715so18271315e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 14:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762123791; x=1762728591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxZfP1EgwtZ2tiYeqX+Jv36xFp2c8XGw5hNT53dpp4c=;
        b=gh7wwobbOnIbz661cXg6YCBqfSN6SWN1yGX76d6mtAV4Xx+8kmOV14XjHWvOMvOrsR
         csUcI+TtTuH9gYk7NHBHP3Fk/qo5Fm/Gvi7NUkfsx+BvGCFcpkF1smR7Z+hzfH+GlTn+
         ujrzjK/uqofSr90vc7qHitb+PJCQGrCoaD+Kx4wx6pGr/bGgYkGDhcG058iUQWXDf6xN
         BsKjnWxChIuLgshWuwmX/CuWseBkMTekZqNmkwzuPj1QudK3uSAMAI0oUu7M5OUMekaF
         2OuNI+dC4WnWYnly51WcZMfv8FPva70W6ThxZfEOYegraCfXSzd2jWE9J7FeD6/A80My
         SGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762123791; x=1762728591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxZfP1EgwtZ2tiYeqX+Jv36xFp2c8XGw5hNT53dpp4c=;
        b=vUKEYlt+5jJFHqT8fYUhD2W+RDugHRWkgHOFW4QcDKCgVCdKZXfyiaR4Zous/Ky+h4
         uGG5K7aGF2M2C6wbDe/KdjjC7CTTd/JjOn1CVqCBDwi1ovENtNcB2L34y25nTnF0CZYC
         2RnPBiWyRj/YH+K63bnKvfAqeB2H78TRIxYL03NZ8mm6reSmvVBv+EgbNI2FbcKtGqTW
         E6PwvY8iVjoLjpy0PBN9t/zSzI6fge8qFpqMxoSHHeTWlnX/vKCrWLAmPmG9bhfbAIGK
         5MeSPxkaXN2G2F/xOXSYaj0ENU5IuVG+kdzQhSc+btsQ3SuxXXViHv9sswlEqdiPwWrn
         Rp6g==
X-Forwarded-Encrypted: i=1; AJvYcCW0DDlwpJp50kg1Zo0E+iMg6oeMZ9TCVMijK4t+opDnvMp7dyiCh7caeI3bOyFSgiUiRauQmxDYjcQOPcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNt/Uc/3qAMeRRdSss4oN05aiYTfF4S+gknsdxXowgrSaDVdU7
	eGwNpxd0x5LQsm4JLUiWaI1u9Uf2kHVV3umLDQrdJpEwaqgbGD4Pw/Ni
X-Gm-Gg: ASbGncsqL+J5T7FnArMdwGbJ+VcC0BxFxNT5ElIcM5nrtHHmMOqCJEmYP+k09a/jg96
	4wkGKR5asNyLsvkD3vPWQhw2dEp+4ezEdfhpCmgKTaI04g5437/dSbnzP9o4n8JLYgi0XgSIYv4
	KNvP1/t8y9H9XgMv+mAg537Me+W5ACIGWkSgvvLKpPsVASUoTG6DZUaKjAjzXJpWEDlpL6MBIH5
	+eHKqVDW1x6vSQv0zlPqJczIcwdt5gbR1t0niLO8jqWYQ6lOnYwaIVvx5l0NlSWbPgjVhxqYGze
	4cU/Ye0NjQNnBpULoi8ShWrjIKcjfhMpfG0tM0NTRcNWSjwbIwWXvWipA9wY5/McqhOeCGPBIBc
	nYRi6t9YOpBh0SqRRLYPe59WhN0HQFD78v/jpGkd9Kn86ZMcIILoQTE7DcWQnfN3rkJinB7BwDM
	ZCjKVK3gaSpCSLrx/71SohqKi+cIanZFM97Xvuaz6N3xOwn8oby4UOo5ygGohMUr/n1AI=
X-Google-Smtp-Source: AGHT+IHLr7QHAYyCpR7esydH0iZxndus/Yszg7n3Mbh2EIBSjYHhxzLG4Xv/sUpvArKaCvluQvwAug==
X-Received: by 2002:a05:600c:848d:b0:471:12c2:201f with SMTP id 5b1f17b1804b1-477308b5986mr103587185e9.32.1762123791099;
        Sun, 02 Nov 2025 14:49:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:acc:bb60:756b:64e3:20ef:1d08? ([2a01:e0a:acc:bb60:756b:64e3:20ef:1d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772ff83182sm72828245e9.4.2025.11.02.14.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 14:49:50 -0800 (PST)
Message-ID: <4b910f6f-9144-46a8-95c6-8e53bc83cd8c@gmail.com>
Date: Sun, 2 Nov 2025 23:49:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] nova-core: Simplify `transmute` and
 `transmute_mut` in fwsec.rs
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
References: <20251023205146.196042-1-delcastillodelarosadaniel@gmail.com>
 <DDXC17HXPXFZ.3TIX7FHUJHAI7@nvidia.com>
 <70210168-ee28-4996-89f0-83f8590cb716@gmail.com>
 <eb51b5d5-7f38-41f3-882c-eb87eb2b9f44@kernel.org>
Content-Language: en-US
From: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
In-Reply-To: <eb51b5d5-7f38-41f3-882c-eb87eb2b9f44@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/25 17:08, Danilo Krummrich wrote:
> On 11/2/25 4:09 PM, Daniel del Castillo wrote:
>> About this, I was basing myself on nova-next [1]. I will rebase on top
>> of drm-rust-next for the next version.
>>
>>
>> Link: https://gitlab.freedesktop.org/drm/nova [1]
>> Link: https://gitlab.freedesktop.org/drm/rust/kernel/-/tree/drm-rust-next [2]
> 
> Yes, the nova tree is the one I started the project with. Meanwhile we have
> moved to use a common tree for DRM Rust infrastructure and drivers [3].
> 
> For the time being, the "original" nova tree is not in use anymore.
> 
> - Danilo
> 
> [3] https://lore.kernel.org/r/20250901202850.208116-1-dakr@kernel.org

I see, thanks for the explanation!

