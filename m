Return-Path: <linux-kernel+bounces-776911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD1CB2D2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADEF72305C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE6C246766;
	Wed, 20 Aug 2025 04:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJ/cKPFg"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CAB23B61A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755662936; cv=none; b=VkLzPC/qJnjL+sQ3CkBgxW9gXZO/j66IGaoZTHOsYsRNZM52dUaLC8WiXA/RyyzN19Dz8MznBT520k21pLS2dFkHyhWv8+2gXYX2mO85bYrAgtfvFXVY6fFF13VPobAsz6gXC2OjIwXxOTUkjWXBZ+On614sZAaLWqh7Fc2mOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755662936; c=relaxed/simple;
	bh=cZveZFpGt+kr4tv2eYJJ27WLY1j1jY8DTi+7Kle+qvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFTZH4Hp8jGpMfDPrZs4nRcl0xsNSnE09lr7/wQbh0shHLkc2OP4lQkWztkGLTYkG21xxCg1B340EPZm+Dlw6brSB2FRIrhtJV6Z4E2VebtINouaBdkO8CeV3uM5pOQzAj4h52nJqfWs5Qs8jzxTCSqgbGfLKoQ48jX0qXqB5n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJ/cKPFg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2e629fc4so6128647b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755662934; x=1756267734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPsQnvqMxASRCLEED9v2AlwRctOJ3ys4veuU6QCCD08=;
        b=qJ/cKPFgpAXS9ZiWLtrN8INgphQIH1VdvCzxui+0j0qRopuKCQf0gD4ZLRUNjm5CK3
         vfnOKvdn1YA90LV6pvFOmlukMkTxL30aFW1AR1nlS7NQ6+MQp6TC0kiJdKjO8NL3PfTd
         wDFCuqhLZTHeMQsJ0DUMjte9QC0CbCR7id0nmy7xNxQGYmUCdbcfE/N+fcptAswBy1qO
         NDK6BlyTS7BQdSoUA2eEXgAd4ruL18R4eQX8/DPHxopJWjJbIlq/40z5BcWuiWYyC3UA
         wZBInK8ovPjghbp2rrlBgWmtULMjD2uTBVgRffjd/5erKnLcLobXQftI5mtcrknICdPZ
         sypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755662934; x=1756267734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPsQnvqMxASRCLEED9v2AlwRctOJ3ys4veuU6QCCD08=;
        b=c00sAyw9tyYAa9o8HqNYnhF4ZFqs1pF7BFjF8cgDr9HuqhHAqjaljgArZToggtajyr
         mAkbZsMtDiq06UYR8u8pfxmlHoqP8xIFOTg8vlJm1PqA4tK8fr8D5LN32Hiz4XXNgD9b
         2vjiRqniUIdsC86DmxAypvKNH1wqBeoFIfvqW+2WfASC0anqngvsyT+aKrqYHC8PANP2
         HVFnCPsNJmPXAheo/7eOH6ROHLmhh899SrFr66C6qpw8HGqBQzpk+wcz6s0nbJJlaDE5
         yCt0QzJhb03xtnbpF/oJi7912VXG4262jOXQq54wr/tPaauWQGRSkqt4HZRJXBFA7u2p
         RLwg==
X-Forwarded-Encrypted: i=1; AJvYcCWp2KTyXgoZl+cKdWoVpZowhfPgmI52MrkpAspKZ/WBKpB8Q68JUlo28iZgIXpaD/cs8665qe5UsW+yAK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHl+9IXaeEGi0pk0kljnQdxnXR7dplR2l2rPr6oGZ10luLHkoZ
	TG2+AyVi3JI9hmX06XRmaX0H5ww4RQIw/UFOG7ovFOKKpqHxMw9RKKmnxU5WmZ4LChg=
X-Gm-Gg: ASbGnct3C0eEDLC4ToIbnMGrsCS95bM4I/295DrhMINk45w0xZzf0+OGrpM8mJ/3jZz
	uDbrDoyFxCxyDoVeyoVhneB34/avmRNqnWI3wkeZmAVe3HvNM6rAc3tucgbvZHHmT6F/4NLULnC
	mbhuUlW5KOCQlIT0pwj0PI4OPLX1obeCYc8ipxdXGKAzaGzErA6ZLOcTdy9meTAY7vxXCLTOJlz
	RAFL268Ov6iFebXPk5QpxsVG6dRZTogNJybtHe6JuF2mkC8k8Zdvv32HW817+L2Uu0IoZLtzJzq
	5ocvFfMohIMabu+zU+pqbQVY78niE1FbXbPaNQ9zdOJGKkRLG8+7RgoS8NJWzAN/LihQsK1Bs8x
	Mjd7Tf/NqcHLoamWfzwmw0ewO
X-Google-Smtp-Source: AGHT+IFu5A5bISXV8FB/K461gR7zbA9roHVXBQ8EWpE6xiSbYT5Vb03ik3iZvJ80WNqy9YA5A69QJg==
X-Received: by 2002:a05:6a00:3e0f:b0:76b:ef0e:4912 with SMTP id d2e1a72fcca58-76e8dd0a9b6mr1753204b3a.20.1755662933893;
        Tue, 19 Aug 2025 21:08:53 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e82d18cecsm3264977b3a.95.2025.08.19.21.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:08:53 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:38:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: opp: update ARef and AlwaysRefCounted imports
 from sync::aref
Message-ID: <20250820040851.nn3ysfyurc4ukqg3@vireshk-i7>
References: <20250815174521.1413560-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815174521.1413560-1-shankari.ak0208@gmail.com>

On 15-08-25, 23:15, Shankari Anand wrote:
> Update call sites in `opp.rs` to import ARef and
> AlwaysRefCounted from sync::aref instead of types.
> 
> This aligns with the ongoing effort to move ARef and
> AlwaysRefCounted to sync.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Applied. Thanks.

-- 
viresh

