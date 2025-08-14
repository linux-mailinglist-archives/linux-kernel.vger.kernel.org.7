Return-Path: <linux-kernel+bounces-768461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A78B2614F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AD15811FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0A2F83D1;
	Thu, 14 Aug 2025 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDBscpxD"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F52E9752
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163998; cv=none; b=G2ZiKBcrknrnlqxT+CZ9L5Z5kticQ1eLEdqtX9zeXyM9jInzrYsy/OvytfcB26nR8ib1IuiDgb2E1uEdi5cR6Z0k2MKJ6ZkT9IXm/fMRI2eQhC8pW5F/ziDSf5xsMfVLhWdzH+S4kmrQz1772reaGi+oXmHQdFyysoOJ/47tVVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163998; c=relaxed/simple;
	bh=0gM4P2+1/T/+38ZTBChRF/kXSK6T1iDcWw4qbZja++o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcZ1bM7KIQ9F4rYO/DXene+Jd903Pu3f2IjU248XSV2TTWYlfcpbuTkztRSprhkDEArRt3FWfjG5Q0MTw9kF/Rxzux7uQ1V9PLuSZSnXfLB6Z8q7npXes875PM3Y5bH5aSLCKllirG1g3XLd9fa4GlxSsJb5BdR/K3rDKhnn09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YDBscpxD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2e5c0d4fso640507b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163997; x=1755768797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=97uhtudkNMK5UOUbW8xAkf4ktNa2lEEMb/M2K9wPi10=;
        b=YDBscpxDfuxNoFpC8tHnWpRopz5ucs/vCcV50Xyl57Q9Dai7rsAQdobrrda7uxi/cm
         GfLHQZhHtnBDJoqv8sFtrw4wLo0g0LASeXo9KnOXTzfqlWMJT0nGnabtjQVgM9aYTnUc
         n9RNRg1ovKQ1nCU8CIefO9RV2Vf+iq7Q62nHsYGaq+ZaPVO57UDQYMNEjkX/LuhGaeTd
         SQydQ+K6hEGmnwEI4mtqOhOyWphwGgvKGKhYIbtPujOsjrZDDZhjWA0rwEgNlArLWuzI
         pxNiRcMuIlL0/VFrqZUc+jBaKX9HxZbQlOZkYWopFAfB/Gwjyw3zXcnvJHqGS5Anzl2z
         icXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163997; x=1755768797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97uhtudkNMK5UOUbW8xAkf4ktNa2lEEMb/M2K9wPi10=;
        b=dh+E+EANaR9IcC7aL84LmgYj7hvIx/1JpF01Ky5PE6tsNOnh+g+7wGCDIvJWJP+poZ
         qgqzLqRamD8rYfNvf1wDyTWgQue48EpCjTYHehqTVfoezipT3+YSiHWHC9APJOVgdfqM
         kE88KJRUZITAMen7Z0WVSTFCuprKfWVC20nFrRqEIHcaHGyAxDDek240QThH+LXDCm69
         aV7yqnRc8Xo2f62MqVogLlgnQNc6WVRBh8lAYtl+Oag5lxM04NEqn+SjD8dUdYSv32+y
         GjsNU5BBownmhEwD3Z9Ve7xPTBNVMX6MEuxIgRUkoioIbynWgS+ownkEQpNlHpZZUU2i
         2FEw==
X-Forwarded-Encrypted: i=1; AJvYcCXLFWOpeVYrv6tYbIBAIc830433MT7tuQSmkeHK1zeSFERQnyaf5M7t5xjZSv/3OTco/z1ANV3pqAu4ZGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhSo+5o8Jr5w4FpXHJxB/BDBkvfTiXN/aP63iqSjMRuwoMrF1y
	6ocBkINFZejWvfWD/uvg3794a6YTDipdHHSpbwQ06oaEEoiSRqWkM+Vq0nTze5KpL4Q=
X-Gm-Gg: ASbGncs6aHYDRzX6Giwuqcak0TP8ZvtBtHyUzC8pmrKu90YevO9GUYnxcZRLdXAZZiM
	H3FrIzmhCSNbxTQw9abAFhSXKdNBeS6oEtDDFAAD7e9XRvRBbEfYw6GyYW8txCZbCa7vuieZmiF
	UiWdzJF5mVYzcMpDieDAs8vr7g3t/O/Dg/52Ea3j1hsVBPPclKEt2UD1vvAfNKYwbEl5ub3NH31
	qqvbmtba+uS8k+cCALgzmgCBuOe6ZdglmquD7iKFBcVa6ncoE1deBMIku2s3n/8ER416D55PkYW
	O5/usIfUKaWXgczEPMK0aUXAgKdOFkbpJ3yEFqe1rrRBa2reQMC94BhA/2DyMmagM7ttA0Uuce6
	OJVmZwiQbVncYtr1sHcTfvCek
X-Google-Smtp-Source: AGHT+IFy/7RDjF0U+OSnhBCxHWxK5dAZ48NiN2cIVg2ZnqQ/azV24PgRQXm1YdY8wqvBXOnUK4P7OA==
X-Received: by 2002:a05:6a00:22d5:b0:76b:995c:4bb1 with SMTP id d2e1a72fcca58-76e2fd434e1mr3525599b3a.15.1755163996646;
        Thu, 14 Aug 2025 02:33:16 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcdd40f63sm34159888b3a.87.2025.08.14.02.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:33:15 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:03:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Benno Lossin <lossin@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/11] rust: cpufreq: replace
 `MaybeUninit::zeroed().assume_init()` with `pin_init::zeroed()`
Message-ID: <20250814093313.wossgn7jk35pc4c4@vireshk-i7>
References: <20250814093046.2071971-1-lossin@kernel.org>
 <20250814093046.2071971-12-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814093046.2071971-12-lossin@kernel.org>

On 14-08-25, 11:30, Benno Lossin wrote:
> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
> 
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
> 
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---
>  rust/kernel/cpufreq.rs | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

