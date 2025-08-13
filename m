Return-Path: <linux-kernel+bounces-766109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D76B2426C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476FE16551C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB7A1D5CD4;
	Wed, 13 Aug 2025 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OKSKh8wJ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE212C21D0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069368; cv=none; b=uAwbSwHC0X3i6VOM/w3M0xUOuugW35MY731ZSbTYmQTOtmNt0EPost/Pchv9Q/wLzZ/h4grzGEqwtZ+4C6+pOiu0Z7a5ZEYTL79V0Jrp7O4Vfp8B9NRhTIjgCk9cTW3cNml5KkabeSJR0gRUgFRgWzaEbQT9oK2sGOJ9hZjFDHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069368; c=relaxed/simple;
	bh=NhVTFbvvpqfogNChl/Cm4fS2mV3xXJQLZ40lWN95q/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tbeItJFdU+vwFKmEmOW1jjM1decdeaDS7WS+geNquZI5C2nZcdGeHtH2d6AudQdKYYkc2UrGpBROso6nRPibhAjSJxv42QMwnIDpiobW4rdiDQl5C9jA2MTpWaE6PhAAz48nllcWlT8MT9DO8OUAYd0dMNJVvf8em5VL9EBgSdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OKSKh8wJ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-458c0845b34so43389625e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755069365; x=1755674165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JLjeI8+9ea/bTSV4n1k4A8UNtWc7Tl8iuoP8d9RZlwA=;
        b=OKSKh8wJ/Powo6xA8xVJ45D0cOZ2buG24eb8WbzUDP8OvbtgSdmHBYaHaVS1JnqvYQ
         cUWBtqmsAlOD9T6YvSxB/AN8qHv+CnxsTeBCL0qAiB+WsTNjqxpT7aT1segvSCuEoCw1
         bLmP+sOB/WO2xsABIoD0XFr8jVBhVXxWReDl2FJ1GRmuYugww1ODFOLE7cT8FeQhaQVA
         XHXX6gDA9Xda89CD4ApHrV6wcoH6VW/uiSdMRPLrPaDAXzzojqN5zmDc6snBKVC6NHvl
         VsSKMIE5NQtkIf9mhlWd/15bn+IWdl6VFcmuiMTkKbFy+rSZlBGIuSW0mqNdE+Xx8RkB
         VdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069366; x=1755674166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLjeI8+9ea/bTSV4n1k4A8UNtWc7Tl8iuoP8d9RZlwA=;
        b=H8dekZ30metGAhhS2sH/X6fQPxion4c6iPBHmv/jHsG2bB4UpFQ5mRovAX4Y1lunfq
         Kwb2g1ZsRk8dMkUA82ZHo8KAODq3gALdQLCMUO16CdfBG4a8G0cVZ6qzhXx9msWxXZoB
         SlBiz4VylEHWziTAogHsumtqtmXtETrInie3iME0SXMn8AOXRFnrS1zYPUlgDd91Oh/4
         eAsJoS0duKgPvn91CJiJhFuhTM43bTSfCO4EPhYRaHYXHE6cSTczFJApihHcCsEDMIOY
         HtaGtNDdHR2yj1IMOeeVJOxGwo22HZDZi+08gV8zHr7329oCGf+IXElT92mLtHKu4v3I
         wlkw==
X-Forwarded-Encrypted: i=1; AJvYcCWsujo7FBmihi0sbbCPB3xF1YiLVDi7Y6x//otGaPr0qL5IjvaK12wJsAOP2m3iiEd/d+B8GAqK5gPNPks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwuIbs+S75SYGzk+MKwyusWpAWID/Hc10iDZxKaj25p7pM8gdI
	ch2EGLmhb2Dl42LFu/+OT+wTC8vZd4sr/zwm0Ag/CnO7a9rtyMxYTFAfMLqH/efHVBr1vTMDYxD
	3Totw6GJJxYzJiDWtKw==
X-Google-Smtp-Source: AGHT+IEnDE33D5c/8svampQZEEl4cLQ8i9FduHgUIGYYPQxm9xf8zHlTArRqFNlJ998MjdEqs896WniYniitZ2A=
X-Received: from wmbjg12.prod.google.com ([2002:a05:600c:a00c:b0:458:bed1:8923])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:524b:b0:459:dde3:1a3d with SMTP id 5b1f17b1804b1-45a165f00e0mr15511875e9.26.1755069365626;
 Wed, 13 Aug 2025 00:16:05 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:16:03 +0000
In-Reply-To: <20250812130928.11075-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812130928.11075-1-dakr@kernel.org>
Message-ID: <aJw7sx0p0Ec-oLkz@google.com>
Subject: Re: [PATCH v2] rust: devres: fix leaking call to devm_add_action()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 12, 2025 at 03:09:06PM +0200, Danilo Krummrich wrote:
> When the data argument of Devres::new() is Err(), we leak the preceding
> call to devm_add_action().
> 
> In order to fix this, call devm_add_action() in a unit type initializer in
> try_pin_init!() after the initializers of all other fields.
> 
> Fixes: f5d3ef25d238 ("rust: devres: get rid of Devres' inner Arc")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

This looks ok:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

But can't we do it like this instead?
1. Allocate devm job.
2. Initialize inner field.
3. Use allocation from (1.) to devm_add_action() infallibly.

This way, there's no risk that the inner value may get dropped, which
could be an expensive operation.

Alice


