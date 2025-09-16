Return-Path: <linux-kernel+bounces-817941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968F6B5894F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4087D2A3D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB101B5EC8;
	Tue, 16 Sep 2025 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xzDtOXgv"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36291B532F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982466; cv=none; b=DsOtqk4VPFIDq8EbdGvX9ZWCGVDL/n4MclfwigmkWOYIW5+ktovvsXZxYuiR/+Z/BlK7Psg9G1kYihNKXV460qNoEQ3agwpTUby6H0rdYlwBf0G/s4Z0CdRtXoXxwdqj2OskTpeT+WjawIOGJjMLingFlkXWulMzwVrdaHrdXDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982466; c=relaxed/simple;
	bh=1oJy3t3D9A6U/J4Pp8/Z6t8AcYSf4anlFOYj3n/kmic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z9Z15eXRweOMMhCJWZRpa4Yid74b8BDE+7p066saAm7KT6sZb6jFE5QSxHhpnpzmzUQtOnM7ADtssWpeRXR0CVK2NB/PbkiUed9T5OXdid4UJ6Zkaj7ch+4Af9Qdw9/ws3QxRsOirwlcuCfXYnDFNn47LrelbRh1szUx+bjDPks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xzDtOXgv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457f59889so49130945ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757982464; x=1758587264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDbjWcZNzcieNmuA7ISo7ilZYMwwvvd15EIzi1Rs304=;
        b=xzDtOXgvjcIk0P8R4Z+SUpCxaxMai/w+LRQJN4gznvQ/4+LUws5RHz0EuVOSiNJy3y
         dpyz1Mp7tsBoMc9CykRiKfbvn075ojCE6gpKASfUNSjPUncsALYwZabiDvnNF9pciT75
         R4JhAViltttSj7P4qelzICfCvPQ5jCg0gnC2HuekZZGv+MiF19UCaa/awujFeyp82UPY
         Tf+80FNRAbPjN3wDpXC19TPtxT8jEqgRJ0Kr5e/4uS8iJg0Rp1DRRypwK/IdjZlK7Ase
         IQF2TC2pCxsauorpAJ2born0fmeqKmkQOCk33RCvw9MSUsxKEkb/ehyJdSF5WsYbI9G7
         ht3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982464; x=1758587264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDbjWcZNzcieNmuA7ISo7ilZYMwwvvd15EIzi1Rs304=;
        b=hZDI+YNpdVW1ByARIMIDOEsQUPkfEq0Jy++ro362Q/wcaRXLLtS9eJxYGOXgZFq8wX
         oyHRK4BXcozBfCAOQhLAdTTftmFWa1soYjlv6/2iJtJ4DBONGcG8XkTm/8Ut0TdFRWay
         PTguOaHiyg4noRgA7Q18OahaVHLprnQr8g6zYQypkX4z5FCrQdzzqE4dQbJAiZRTrLpj
         uHkIgTcBGmEVsv9pn8VO0XtJ5VONmq/GNtpXYaV3ClAgmTRmdKAk0VtuLarQFRaHeTe0
         P4xB0ysPQ9iQv1uz6Suh8TvoJgzsRvbEo02C9Qh+0Ts0V3OIGjthostU6SsF5cnCkUIM
         MOZA==
X-Forwarded-Encrypted: i=1; AJvYcCVPn1uolS1xpcoPcRj7oiWHynXDTLP48kmVGHYI9/WVOiTmU91Q2Hqf3nHjrOsOxzeJrWa8cKrUqYIRoio=@vger.kernel.org
X-Gm-Message-State: AOJu0YymrehAvcsY3iVzpEgbm+5QGOTjjkdcyV1OfSRDWwwMYHPR4cvI
	0scGO+O1k6POizbqj50YiRY+VKSgM+g0itRWnaAMxjM+oQaQr5jzstFFK+0diMjSnSZ6QoJ7bPW
	dZoJ7Mg==
X-Google-Smtp-Source: AGHT+IGcLhcUiPZLuLKKgf6Vk/vqvaUj+Rsg3wKEDTuj0TzSmlSBMrE7u2VuuWz1jgCPWuXQEzKnlZuh00A=
X-Received: from pjv8.prod.google.com ([2002:a17:90b:5648:b0:32d:e096:fcd5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db11:b0:24d:1f99:713a
 with SMTP id d9443c01a7336-25d26865e66mr186677515ad.31.1757982464308; Mon, 15
 Sep 2025 17:27:44 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:25:37 -0700
In-Reply-To: <20250729153901.564123-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729153901.564123-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <175798204580.624108.8402197370232306041.b4-ty@google.com>
Subject: Re: [PATCH] x86/kvm: Make kvm_async_pf_task_wake() a local static helper
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 29 Jul 2025 08:39:01 -0700, Sean Christopherson wrote:
> Make kvm_async_pf_task_wake() static and drop its export, as the symbol is
> only referenced from within kvm.c.
> 
> No functional change intended.

Applied to kvm-x86 guest, thanks!

[1/1] x86/kvm: Make kvm_async_pf_task_wake() a local static helper
      https://github.com/kvm-x86/linux/commit/657bf7048d77

--
https://github.com/kvm-x86/linux/tree/next

