Return-Path: <linux-kernel+bounces-750332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2E9B15A20
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153083B6282
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F17323B610;
	Wed, 30 Jul 2025 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SbQOqfqC"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABFAC120
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753862584; cv=none; b=hFg1qen+832decg8KbVNKkgoj5m2nzBb4sjseWjpvBexasoKjk9N6N90sacpxZOdvlv8JHjN2r1zj+gFqpqBp7caIQV/7AvLoC+DPZq1BScvqPjZ060TqRjVLxPEhqCN7ssHwLVt6qu1RHSngQfFZwyFfcq4RRDEYivJvPwxbQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753862584; c=relaxed/simple;
	bh=/MyQIhv+oxPmyUOEjR2JSMI/ss3MtMNPBs6GFmylKCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gfC3XEe34M7jdTUExq0HXsD/g01VMA/KhR+CpuM80xgvyM/Bryi+I2inTlstvpkY/Pn3rc++3tM60hbNPOKuw+V5aYadk8w8mVpRGy4S3dmHmuouV7VlZBVDfe9kklmNO4NdYmjh61vSy2Wm6ts7pdPcTgc8wZDzZfI8IVGqgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SbQOqfqC; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b78329f007so3739426f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753862581; x=1754467381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hvkA2k7IhdKqaN2G4otDNr6r/3eIO7r80AxoAqkt6Zc=;
        b=SbQOqfqCGTnp8x6oja4VPOoz5apwWkqHRYNNoaUEJtQlgNd203GnBZ6zJd3xIHwoTO
         iC6+GLm/Mp0GKKPUlhIglFZ2fV/3gEXbx6U2as0hXrwpTaqaociN/boognIJjA3LXV5w
         Ih2KctKNYjZO4L9lAdFv4anDhgr4fPO+uyELMa/Eu7JFrCSorjTswmxp4R4xoKFOO/k2
         AfBYpjSllPj+uDEVzg8IFC429w6FrTv7/Y4wqB1FeciQyUA2xbKiNdVv0No1Kz7sabee
         S4ftby+qxTX2BcKe59j/5FGdMJqRW7lGefSyqAatB/QTW+199n0hlYz1ZwWPLyfFmZIN
         dTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753862581; x=1754467381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvkA2k7IhdKqaN2G4otDNr6r/3eIO7r80AxoAqkt6Zc=;
        b=Fs/WXV4qMONw5kKVBhfPXYXXXoD0hTLtEpXE2aU3ah4JNfe2VE+AyZjEOpFCIzcqih
         gbc5t8zTto+FH8/ktFp+f8G8NYKeLCQBlMrpCM7ctDiGkEBsIHz8+TP5z+TT8X+gTY5l
         n5/6uOXROPKFMYC2rxsR16ZrHDVltQVFVkc2r1REnU5X5uBwy3C0GxyZCk//CUmbVm82
         MZXg4sZCm1DksY5BQ2TTw9UFAVmRFKKauxFl5VCdcJvUYIO/pFMmpvLIt3ndyV8DaFdT
         KIsGgn0K7LhFVhBFig6lxiXMuZf6y+4NPb7WO8SUkw7g0JgDy7AN7yGmw3GO/PHzGKlz
         OrWA==
X-Forwarded-Encrypted: i=1; AJvYcCVdvakJWxeyAlLMSCutROXkEX8joEX29zI1JH6/fy96F5CndaYIZH7vXcuX02JA0fRJ0i4okY28BFHkRHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSA7JpCikqyZISWJleKxUHbyMbsQC8KxSc7WLuMb5Q/u2Crl2o
	Ol+XenQF0/ukQXUgMy3NqHbCS+oiZYv5C91SJrTBBUJ6XkN9w8UCFpCY6Vd+mA2mOBsz5L5jKGz
	m4Cw26rKV8SHPs9iLwg==
X-Google-Smtp-Source: AGHT+IEidSsYhJJCRxV8YYcCIYNFt7Gb9o74E15I/wFzPhPbknnSTFyghHsxc1psxDPaRTI0N/KtvprllEAM84w=
X-Received: from wrs14.prod.google.com ([2002:a05:6000:64e:b0:3a5:2a0b:d7a3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4408:b0:3b7:9546:a0e8 with SMTP id ffacd0b85a97d-3b79546a3a1mr1061367f8f.41.1753862581345;
 Wed, 30 Jul 2025 01:03:01 -0700 (PDT)
Date: Wed, 30 Jul 2025 08:03:00 +0000
In-Reply-To: <786e88abea2557080bde65fa9892df3b956731f2.1753841900.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1753841900.git.zhuhui@kylinos.cn> <786e88abea2557080bde65fa9892df3b956731f2.1753841900.git.zhuhui@kylinos.cn>
Message-ID: <aInRtC5CRxyDTy5B@google.com>
Subject: Re: [PATCH v6 2/2] rust: alloc: kvec: add doc example for as_slice method
From: Alice Ryhl <aliceryhl@google.com>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	vitaly.wool@konsulko.se, Hui Zhu <zhuhui@kylinos.cn>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, Jul 30, 2025 at 11:35:22AM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> Add a practical usage example to the documentation of KVec::as_slice()
> showing how to:
> Create a new KVec.
> Push elements into it.
> Convert to a slice via as_slice().
> 
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>

It looks like this did not change since v5 where I gave my

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

tag. Please make sure to include the tag in future versions if you have
not made any changes.

Alice

