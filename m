Return-Path: <linux-kernel+bounces-759918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C920B1E477
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596F9169CBD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E7325DB07;
	Fri,  8 Aug 2025 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJDjVg4a"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B025228B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642140; cv=none; b=Bqu6wp7dsOXcBc1xt/2omeSDRmHfdTP9ffXy8pEaC6VVRHvDS/itx9MzVXxzIPGYeCTDyE995EWUql2WHKxmwrlDFE5Dt6MaCSNcqpa/rOq3D+PgpXVbnP6j/yXSsKIrxjkVs18xB9pCo9dJADH6jSP+oAThs4+mqOEbwqxkm7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642140; c=relaxed/simple;
	bh=vKceCiGfd3IVcIs98f/Qu+5VwMWaT6kmEXI0d+RFbZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OZPgbMVFA7BLO1eMKHFJFRcN7CmeG7B7apgu23db9Eco0qqBeZjpuIH9cg5HJhbp03NYe1xNfeKHogSkgaaW5PD16teHBd5fcQzPyht8tB5tHXjeyatTfoh5AfyDEnigX5Q37f06FSfAoRasfib9OX3X+7gSCMcuZL7salN7CHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJDjVg4a; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45526e19f43so6626925e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754642137; x=1755246937; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/R1bV19pK3qvSZa+wMMUXQzKmczCiuKCY7TytXZ0iqc=;
        b=TJDjVg4a7jrT7nl1J8B1Cwf8ffS9fYli8bbs3gXlxulTNUdvfWoWEin55TCTlpi/M8
         MzqfPiLKQy6ydMx4fxk2WnAaanhnLl2kUVLDvKOKOzruYgEW89U73KkAUAFAj6st9+HH
         zevjLYWfd/rXDwiX3eaLIAtM0Oj4JbtSPb3qaEn9r0J59p9xB5JEDeisWUqiuuCURNzT
         RPJkDy3zf1D0Rj9sYacVDXoRO8fxenbET98/s62X8n1dfaQkaYeFyy/sfCe1JRE7tKfD
         P1sR9ENr3XC1+WUtTms9m0hUGqa6GsHiK8l0gXVtVcaKBb0tGpZWVkX6bCn9BrQWR2ut
         QU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754642137; x=1755246937;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/R1bV19pK3qvSZa+wMMUXQzKmczCiuKCY7TytXZ0iqc=;
        b=LgfNVRfdO4apXuIT4TSQ9Usayjme07a5s3VmIT6yXQb33JyNXpWzhqnind0PYYBn8k
         1q3NsqcBX7YDQ8pCf+BGzJ6qUlkTYUtlFmd+tdwvlwjj9bKIC3AdLQvEgre7j+x70d9R
         3BU7kXD2dVSeeW9zi5DqgftSubM+eAvwtRoN4H76E86QCgPTqhKd7BX6NtBPLogy24sS
         sA0XwY17Ps1EkSly952xeek3bYQG3CYJR3kvwhvQsEIjrjbDlRXU61eXsf/MJOR4ZfAb
         ajVhgD2csBK7IwaM0U0ySrjzPIbBsN2aiNdbJKzACA1GgOUDuPpRyoNMZimyM2GMlyPH
         gSLg==
X-Forwarded-Encrypted: i=1; AJvYcCVyKH5zXFwsKNMuHWwL1ODC8rYYZP2BtVXlG+S+y6uRQTiRUB9CN290ljOw9C85HTFBDOchNQioUvLEaMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3M+xRAi9qrFL4AcnBeig1xlEZobPOlLXWZNCFe+wFQtvfxMuz
	GVA7tpI1P4XS4EP54ZlPOiEYB6dTqub5ga2gkqaayQdgaOCULl8u2mb9eJ9PVqU98+aeIaqh0qe
	TyKWvLIZlNdbdwyKciQ==
X-Google-Smtp-Source: AGHT+IGKioo4/mPR0GvMMcSDoArJNfBPaVCcGranqSUlVsAF0ZD3fGdgTPzyNQOZ/mXV9Qs7yu/HmncxP2+dbew=
X-Received: from wmjq13.prod.google.com ([2002:a7b:ce8d:0:b0:459:dcca:571e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19cb:b0:459:d3d0:6507 with SMTP id 5b1f17b1804b1-459f4f519ebmr16137435e9.32.1754642136722;
 Fri, 08 Aug 2025 01:35:36 -0700 (PDT)
Date: Fri, 8 Aug 2025 08:35:34 +0000
In-Reply-To: <jfqpnx7iatu5q3tnzwhuv6cav5y2444jyyjxnia3py6bqfb3bl@ijqc35utzpwk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
 <20250726-maple-tree-v1-3-27a3da7cb8e5@google.com> <jfqpnx7iatu5q3tnzwhuv6cav5y2444jyyjxnia3py6bqfb3bl@ijqc35utzpwk>
Message-ID: <aJW21gy6HH0qUcAp@google.com>
Subject: Re: [PATCH 3/3] rust: maple_tree: add MapleTreeAlloc
From: Alice Ryhl <aliceryhl@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Thu, Aug 07, 2025 at 12:29:19PM -0400, Liam R. Howlett wrote:
> * Alice Ryhl <aliceryhl@google.com> [250726 09:23]:
> > To support allocation trees, we introduce a new type MapleTreeAlloc for
> > the case where the tree is created using MT_FLAGS_ALLOC_RANGE. To ensure
> > that you can only call mtree_alloc_range on an allocation tree, we
> > restrict thta method to the new MapleTreeAlloc type. However, all
> Typo here  ^
> 
> > methods on MapleTree remain accessible to MapleTreeAlloc as allocation
> > trees can use the other methods without issues.
> 
> I guess this is for some rust side error translation because the C side
> already returns the error?

Already returns what error?

The API here makes it so that it fails to compile when you call
alloc_range on a tree that isn't an allocation tree. That's why there is
a separate type.

Alice

