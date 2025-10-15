Return-Path: <linux-kernel+bounces-855171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8C1BE0741
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55625845DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBCE30BF52;
	Wed, 15 Oct 2025 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USuqdtMg"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F601306486
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556787; cv=none; b=BLU+GdrhyivaFvQ2hRa43t3ld4k5BmoFBdxxW/mIr+jsHmPkZVTrxAee2MxOTXJWkFi6HKWvPwuSFloNcCNBSN1YVnP7BdDlwEN91ar3YmcWsWIOCRq6AevibeUZqmg1HJqXy+YIhYQvJkNL48n8qUUGkYaPbLmNF38dKYKZpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556787; c=relaxed/simple;
	bh=ScQQFFkpeGO6loW/Fw6rKSCOy2E7ESI95v/KoWzWsv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WOU+Nc5UsGuaMNh5Q5c/hoTKcdAkWX2vwGD4+fZ0rEYR3zJt009qymtXVG65VtPuQE6+vR646naK/VP001lX8MkrpBY4VmbOzz2I7VqsqNdNjSV3ogRplO2O9PnRoLEK7gLTEtwOTEWKEB6GfJfXlXVM8iaNyXhx2UyuesZw2GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USuqdtMg; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e509374dcso30900165e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760556782; x=1761161582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAevwT93im92Z5B9wqQwoYCZ5JIudJs6adex10E8WZI=;
        b=USuqdtMgPc86vu+Dd8mgmkCVDdkSEt5FxJ2HvnGcj9DTcpEEXBbhFGyg24pYDTpjQ0
         wzIdOr2D0MC0oReDEyQ0sUeML3MkfO1+S+t/AqjcUKl/V6IQP0/GVSpnmR9dJDvLSouk
         VF4FbMmEUQnCgPNp66Y5UTBccCwTYds+0a1Rp/Q3kxsAah0oJryCu3uoz1Hk18lN4nVF
         D82Q5gIy5EMXQX2pYL43MYxJ4NJfcRoyh8eYD4LXWtXB1Ci7M9uibI2tn3DDJeLkhM5G
         LJfamWA73nVg1dHg9+RL8exd3hSJl+Abh3EbVfltQ9JDN0s66HpccPnIAmMfZ7n2morh
         MoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556782; x=1761161582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAevwT93im92Z5B9wqQwoYCZ5JIudJs6adex10E8WZI=;
        b=Ct5NPn8bYjZlPDU9roow8UObPo4thZnwz4j78UR6IQGGK7kRtAWepyRJd1Szl2VvfW
         VNlTCUKfOwoiAahYI9Wp5C7M0f4uAbXKWvVxdJX60I6JYL5GJYgAOlUWs5iiB8eqycj8
         zFjqQU6HhWfnfgzDIGQw60sof8jSZEPpxAadcyQpJ8sh2QlWbNhvH+cPR6FomeKGUvZ2
         UJW1l4HK46t+hQWjM8MJr9VYrBwJWZn4x/WHDa2TSJTJ2wy9gjFcxB3h96Vga5OgIEDP
         r1BAxlgGT3SZBm4UDHa7i+2THbwi6LybijXT4CHj+XyArfUPS+KrVcHsZzsmff4LVDxn
         v1gg==
X-Forwarded-Encrypted: i=1; AJvYcCXF01CcUjUO14hwJhoKbdzhjxyMgGmluy+MqYyi0AC61W6P5Hfwakrm4FDDMOCJuWWPFbGT6oGOvZufaO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJkPfXSom282BtkZLbbHEmEnwJ+SyPACghUPjivSbbJQEvjJn
	WThOdA8Ytj3hLlQf9ghtxZhTXOHYg+HvQ89J8bbgRJ/Ch/cgFEBKJphooEwjolf9bdzo3Q85AtG
	FsSs9UC/1xehgi2fTWw==
X-Google-Smtp-Source: AGHT+IGwzEplF/i+o3IChMoByalJPkPhIN2u4u73RuMgfnJGb89VTvklkfzoM/vxf4PIDBos9Yu+r9TLw3kNcog=
X-Received: from wmbh27.prod.google.com ([2002:a05:600c:a11b:b0:46e:2f1b:4ceb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c0d6:b0:471:c04:a352 with SMTP id 5b1f17b1804b1-4710c04a443mr1959265e9.4.1760556782126;
 Wed, 15 Oct 2025 12:33:02 -0700 (PDT)
Date: Wed, 15 Oct 2025 19:33:01 +0000
In-Reply-To: <20251015-cstr-core-v17-9-dc5e7aec870d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-9-dc5e7aec870d@gmail.com>
Message-ID: <aO_27dG0j3zbnBCX@google.com>
Subject: Re: [PATCH v17 09/11] rust: remove spurious `use core::fmt::Debug`
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 15, 2025 at 03:24:39PM -0400, Tamir Duberstein wrote:
> We want folks to use `kernel::fmt` but this is only used for `derive` so
> can be removed entirely.
> 
> This backslid in commit ea60cea07d8c ("rust: add `Alignment` type").
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

