Return-Path: <linux-kernel+bounces-750232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59960B158EA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD81188426D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A36D1F30B2;
	Wed, 30 Jul 2025 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glC7O/9/"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313E1E32DB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856642; cv=none; b=qNiXiN4G1NhW3C8e9IMc5h62OTtvrgDu4TrdYzILkeCxuQU60w6qTWJcgeXCRBi9NLXnFBIXm0cR5bwQNJZ4o16uFSWjOEhJDOKjWlccMp/8Ld31OvBKoyj9Cl1dd/HkPiuqMk+CYEINbcC5c/LbNpKIcwXI3fk6sGrsEnZqUCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856642; c=relaxed/simple;
	bh=dGxjiNGntEIpDeEM5UuFmfE0zBkCHQ41vYKGFK5F1UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dahcMiI+8MNTjUtM7RvmiJmVZV0qZT9LRuVVTqHKja1SJb3OF93rfRYwM343iqmfBdsOw61DgUnUo+avii2qobo7XyqqS+RGNbnGH3Y6TpCDF9lk2niDgN1t3K0oUP5q2J9Dk/i7oOXSI4eXYYOXIb3BUYdJqxKQmKs5CcFaFSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=glC7O/9/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76b6422756fso140549b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753856639; x=1754461439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CidS/GccUuP6Xpj1XQrTjZ3SEq5HS8jiXMJq8sMBjg=;
        b=glC7O/9/yWsxnYal0JEbxhj9n1fopOLNO+udRVRQ1C6QtBWifvxAUS2j+EtDpSElG6
         Mz31rEo1/8Qon7KT4m3PvzRPrOywX5YXSa+RuA7tfv9m502YSWZ0FXiZWlT7/dKOp2gQ
         /aFabtAw47jpaZdGgILKxrz1TrLE03R7pSAH2JZh7XlcZn6d2SNgalMQFXi0TT9wb6oD
         Ea0zxP0PO7VzdD04kE+N7Rvidk60MdgiBZBIv+gZPbt15qdgvH8bUtVR6bH8LTPY72Ge
         2YMrCKtgQzL3ORXxJNaLOMSZdjVMOPkvbfi4e8qnPr7OOK4JMFoDe3V/2Bx61ZvIvkIo
         tf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753856639; x=1754461439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CidS/GccUuP6Xpj1XQrTjZ3SEq5HS8jiXMJq8sMBjg=;
        b=WWzXmx120XmqkSjiqGufPONyncbnRuMv3lddxqGVtx1eGGdLNfde2mqisp6lNw4mqk
         FHaZk5cmD5g1+Na0p8LNdTvVXNJLwWu9oOlU8y/VfEgPGI7Yz6DvT6amfdRhvKZxeKFQ
         bkIoBRqt4Mu3Vwpv55Pqg8TnNBZkGSxba4oCvuGW4QMbx3YxumaXMTaO5ExHHk/qQQia
         JgVy/JGKk8i164DZ+N9Mu/CXQ048znxZmbaVpmXFNKtD+njTIi1ZQyR+NkNCENOGwjC2
         a7sIqp4BPL6oL9QWvFtoYInIGBcJBa05w0dc96aBCU/I8HFLmugXcET3pF2Grh4q19JO
         uecA==
X-Forwarded-Encrypted: i=1; AJvYcCVRS3UkX1liIS+UeEk64VqWSOkT3mXGNV/VR8TASDXIinwCJkkkbeOuBurvECHmQcNdPI50kaCQ5KUlVIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznXGs1u76rs66MUa+awhwKffjQuU8FCmHVK2EolKUL9fwpt1i4
	gdXWtwbS9gbw2hwhnFfvJ2WxUIoMuCa55mENJ/1T5PxllTekX7IxgXuWl1ljXzbL65M=
X-Gm-Gg: ASbGnctDhnXyGwUx8QZhuq7hw+0qS/lYK+yjK+qkqct3aLYFVNsUWmfHEhtgcgsyej/
	Ozx5Tjbx04DXg90j18gRxpxPKc7KMX8DACXzJN/zrTFOSnGnAHvYI6iNggWXDbH9qcT9bAyx6vY
	c6MQvZRRJumVc26L4Slc2eLXie3ztPb/eYoIWdQjlptXs6sAsQQMj/BQm6fjTsL0+Q/VuKtqgri
	PoXGzsRDK33NhDs6mnCxZFiyBJ4tHuFWmZdjVEHNjjm1Pjg5/6zb52t8FPEbGZEGDFPu64jrwFH
	H3MlfQiMJnwKnFUPqTd2gOenmd2L3ESYHmnT7onG0XwKRmiAk+IltIZQ7kQyzBYZIG9IsrKAMyK
	yUj6CA+LoQL1f3HtCxIT8tOI=
X-Google-Smtp-Source: AGHT+IFRAuObLQYS4Oy55+Xz2guxb/KTSj4E0KIUP/TcZUmzaODEEpLK7Md4GtPX+Txxpk521QOfKQ==
X-Received: by 2002:a05:6a20:7489:b0:233:bbcf:749e with SMTP id adf61e73a8af0-23dc0d595d3mr3912159637.8.1753856639378;
        Tue, 29 Jul 2025 23:23:59 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640881f595sm9045271b3a.27.2025.07.29.23.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 23:23:58 -0700 (PDT)
Date: Wed, 30 Jul 2025 11:53:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>, linux-clk@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] rust: clk: use the type-state pattern
Message-ID: <20250730062355.bqifrzvxfmaaugnk@vireshk-i7>
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>

On 29-07-25, 18:38, Daniel Almeida wrote:
> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
>      /// A reference-counted clock.
>      ///
>      /// Rust abstraction for the C [`struct clk`].
>      ///
> +    /// A [`Clk`] instance represents a clock that can be in one of several
> +    /// states: [`Unprepared`], [`Prepared`], or [`Enabled`].
> +    ///
> +    /// No action needs to be taken when a [`Clk`] is dropped. The calls to
> +    /// `clk_unprepare()` and `clk_disable()` will be placed as applicable.
> +    ///
> +    /// An optional [`Clk`] is treated just like a regular [`Clk`], but its
> +    /// inner `struct clk` pointer is `NULL`. This interfaces correctly with the
> +    /// C API and also exposes all the methods of a regular [`Clk`] to users.
> +    ///
>      /// # Invariants
>      ///
>      /// A [`Clk`] instance holds either a pointer to a valid [`struct clk`] created by the C
> @@ -99,20 +160,39 @@ mod common_clk {
>      /// Instances of this type are reference-counted. Calling [`Clk::get`] ensures that the
>      /// allocation remains valid for the lifetime of the [`Clk`].
>      ///
> -    /// ## Examples
> +    /// The [`Prepared`] state is associated with a single count of
> +    /// `clk_prepare()`, and the [`Enabled`] state is associated with a single
> +    /// count of `clk_enable()`, and the [`Enabled`] state is associated with a
> +    /// single count of `clk_prepare` and `clk_enable()`.

You have mentioned the `Enabled` state twice. Also clk_prepare() ?

No objections from my side. Thanks.

-- 
viresh

