Return-Path: <linux-kernel+bounces-746989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8A0B12DF9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB07217C3D9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83531D5CE0;
	Sun, 27 Jul 2025 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BU+ceU4t"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF2A35959
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753600578; cv=none; b=kctVGZqtX8cc3tWci23sqIwOg6yorgNC2Y/aGJis9Pwv6xBCN8GkmdZ7u3VUDzVq6qe2ems+NIwLR22p/2qDJ4W8AKEnSUu7GAPKPtwh1x5MxkF0GznpStw20mhJPoffKfbgnNInpbm7PtLsX2g6v6CohVGrn/7iTGQRpJb2gYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753600578; c=relaxed/simple;
	bh=WxIS3k4tG4PBAzt6QvpOD6KjEtIZ8/MPp3hgjsTlbLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jaC5pP0Yd91aVaZXH2rAvRF+ltFLq0yxorhPA7KSdgkRl3vuK27E/ySl6sbxSVYI8XyD1eKmmE0jpUd0EBUkrJgwiI44KTUm/tF8B0RjqaO3LTfLqFfobTqeIz709wM7Q2+GQaA7XCamUKhJXjmOLfHfst3pAZqdAgqREDYZXJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BU+ceU4t; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-455f7b86aeeso14767335e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 00:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753600574; x=1754205374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5s0d7xTMqboAeQUy1lb4rWAvQTFKv28WU2Jjc6lc4pg=;
        b=BU+ceU4tRe0hVEEOEuJhS+8dud8V9uecJFIREG2FtFBtZBpaGT0Gx/oeMzrDKwiUn7
         GaDuvYcLQeG+hlG2s/TFSZS3Dy6fYZVjRTXe0P/CVCp/JN+3MajaiIEHyAJ5x5MMqLZZ
         XVkZJMeje21zqx0k03LnN6J3ZQ2t9Z99/vlHg/8OCVHTZQ0lznpqy/m/S3NFdhSVGN9P
         4/WFhQzxKEnZO3R/0Eluxd0hbmwHTwGduQlW8kSUfHvM6qlVjqYwxAb91ChrxH+5tWX5
         GMAqFcgQ7ToGLWHP691F9PAcHgdoMkw98QC53HU6FXmbaKiUNEaYdJUx+Xm0qnTa7oCK
         dUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753600574; x=1754205374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5s0d7xTMqboAeQUy1lb4rWAvQTFKv28WU2Jjc6lc4pg=;
        b=CxeqoyqGuMWsU4FbImejynJl98W9g0UvleynrBbsnJtg9gpBWxlEHXyUkZSzUH55+V
         UTdCmXTuDou3RZYqASTHGxyHvKt46UTBxIFp6fGg/mXi+K5ea62njmUiH+5HGq74iF5B
         XOgx+mdHdBq8Rf1OoyfYbYsSbhq6RvsJK+EJ6VqiGHfs/EnqMcbU5JK5xjtiV+/PQybd
         fXzKpl5R+gUe/26W6mk717JJ/vwBGNcZPfe4KLs9NsamHCuR5yU0OK0S0KgwJAjuTiqu
         9KvGZfXzrZXd/L3yByQ/iEBJtkEkft3C4i9ON2bwuYLyScGxuL8Olpq7m38ISIS35cYI
         2CGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCzvAfJH3vR01BhnIEzR5Ns9rOiHc01GDMk87THJW6prcgSqLr6CfUFoorLd5AbrBT+XZyG5AJ0tqe9Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUsujA/b+SEAEXogvQ64C2s9V4EMOJ/8nvNXDsJdTfSQ3q4gAf
	XizPNR0w5delLqgiJYZ4Jjidu4J9IXzvnakH5VjdwNrFbi2x24oS9BEj55XadmiWe2ZiAFpbBxA
	jOpjfvvy2DZNtVB8fdw==
X-Google-Smtp-Source: AGHT+IG18wt3J3Ec6FFHchIY4tklf/q9QZjeL8R6loGFvknBQEuHb93kZkOGgSbRnJe/bNXntYDW3To20ZXl7DQ=
X-Received: from wmtf6.prod.google.com ([2002:a05:600c:8b46:b0:456:365f:428b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3f15:b0:456:58:1114 with SMTP id 5b1f17b1804b1-458785288ccmr61331425e9.9.1753600573839;
 Sun, 27 Jul 2025 00:16:13 -0700 (PDT)
Date: Sun, 27 Jul 2025 07:16:12 +0000
In-Reply-To: <cover.1753423953.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1753423953.git.zhuhui@kylinos.cn>
Message-ID: <aIXSPI3cNfrJITOE@google.com>
Subject: Re: [PATCH v5 0/2] rust: alloc: kvec doc example and allocator unit tests
From: Alice Ryhl <aliceryhl@google.com>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 25, 2025 at 03:02:19PM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> This series includes two Rust patches:
> 
> Patch 1 adds KUnit tests for alignment guarantees in Rust allocators.
> Validates kmalloc handling of standard (128B) and page-size (8KB)
> alignments.
> Confirms vmalloc/kvmalloc reject oversized alignment requests.
> Ensures Rust allocators respect kernel allocation constraints.
> 
> Patch 2 improves the documentation for KVec::as_slice() by adding a
> code example. This shows how to use the method with push operations and
> assertions.
> 
> Both patches are co-developed with Geliang Tang. Tested on x86_64 using
> KUnit.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

