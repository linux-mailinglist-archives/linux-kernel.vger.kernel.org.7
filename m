Return-Path: <linux-kernel+bounces-880657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C3FC2646F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5264257F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A9302144;
	Fri, 31 Oct 2025 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BiAMWdgC"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B972D0C7A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930102; cv=none; b=fqmdsmLcrjmwp9ti53QRgU6PM87RdCRoS8JBu0KyDy42ggtoz2fhfh+55DGsXH39F88nTvx0giAxoaetDZMA6/crcskpDKaYlOlSYH2/pl/42sLNMwk/t7IBuGEkLUse9fZ95IYngPMC8LbStJMtzmq9boPLoCYamznTrArcP5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930102; c=relaxed/simple;
	bh=ExP714MhRpE/X2S1bgAsGplYXRnkY86iAwV9dqwqkTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qEaCDDRlGsPV/sMbsqb1qMDlp9krVyLClsI3JsJBZIAo8Vgn76EZh++t+hYJZXZOEaBNU7eRKZ4qRWHl4gQ/wwqz1ZgvLyRZqNXQXPAp8lBN9/8GhOlXV8/iwSRsU08/LyA3gKCG1XgQbQOQ/1Tt9/wn3ay5k5YWFAeNl32gL+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BiAMWdgC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so1915027a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761930100; x=1762534900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/MRbBtlEvav5GDT1r+/BrezlWRnmNwGU9mv00LO9a4=;
        b=BiAMWdgCEG5fj3u5rMQhLIVleLkQkzAxYX+RZLhfzMKRNdvcTpeYAQ6MpoULfgNaa4
         44G4BZe5EorU7NjtoUazEBB49XFI2uvz9U/mDb35IuEs8dlYQMBE3UJjjVWINxJCx576
         YVXakuP2qFvigki1O7TLrE2jWEPDqKc54g6kpTH9U9MXb8E6kPt2IrdXn6m7ScWPRom3
         yCjdWocfF7xLL+ins9cf3hUnS31/s75ejUSoCGQBYt5+NiuuBtIPAR9U3nwKijwa19Gv
         Aw3x4di78OPaWZjOIXUX975yLD62DvtPlaBuRG8ZtAqdIT33uoTy7nnyenxDhYSgj9LP
         PNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930100; x=1762534900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/MRbBtlEvav5GDT1r+/BrezlWRnmNwGU9mv00LO9a4=;
        b=ZiX/WXr3euoUacrDzhPm6oCVwJwiXLMoVd2ub2abSqErYYJoZCMmQBNWRBbrjKvAcK
         toQEz0D2Bq2yfXIyCfuFtrwSlTMBMfFazaO2jFQF8r7mYv8rmFb+/ZoFLkqnYZpTPBvV
         k976/DfFnHN+iInanffz697Q2zk/9k8DI+W1l+oyuIo9Lz+cciW9p/e+vmgvgzU+mZDo
         crLhGhU734MftMGTVwX1mZbCQ1lQ4uuvpo75aF7drTyPfVRR9eglV6lDQtRTdEa6602n
         qjYo/EeT/Ad8bZREYN5jQphJ/93wrjGXpwMILmyYmFI3vXDtVBHSei7/9kB95qwaEQ0A
         +8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXeLU9smZiqF/Rg9gUkwhj5L5CNLXrfE1a+qny85HYq0xA0mCrb4IQWbEOj6W2+Lao1L04ryZSOj72qMqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrupPyw3tK1sLH8xfUX4H/LTGoXVsnAD4CeprRow+y7aYoG85L
	pAp0XUxlIPQiYSlv+jGJJCNM4mLL2AMnAk5IE9CRWah0hSySyQjB0hMrkvqECxcYNkxOLSMqeey
	YN2qRDg==
X-Google-Smtp-Source: AGHT+IH748GsxTeI/Q04BSQ33R6BefPTyOvqnz4pgeN1lbp9XyK8W64dvo9aC285XLDySIC0ETt+QAl6jJ0=
X-Received: from pjbgo19.prod.google.com ([2002:a17:90b:3d3:b0:33d:4297:184e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1812:b0:340:299e:dbc
 with SMTP id 98e67ed59e1d1-34082fd608emr6573642a91.16.1761930100216; Fri, 31
 Oct 2025 10:01:40 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:01:38 -0700
In-Reply-To: <bophxumzbp2yuovzhvt62jeb5e6vwc2mirvcl6uyztse5mqvjt@xmbhgmqnpn5d>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030185004.3372256-1-seanjc@google.com> <bophxumzbp2yuovzhvt62jeb5e6vwc2mirvcl6uyztse5mqvjt@xmbhgmqnpn5d>
Message-ID: <aQTrcgT9MMY_69wh@google.com>
Subject: Re: [PATCH] KVM: x86: Add a helper to dedup reporting of unhandled VM-Exits
From: Sean Christopherson <seanjc@google.com>
To: Yao Yuan <yaoyuan@linux.alibaba.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 31, 2025, Yao Yuan wrote:
> On Thu, Oct 30, 2025 at 11:50:03AM +0800, Sean Christopherson wrote:
> I like the dedup, and this brings above for tdx which not
> before. Just one small thing: Will it be better if keep the
> "vmx"/"svm" hint as before and plus the "tdx" hint yet ?

It'd be nice to have, but I honestly don't think it's worth going out of our
way to capture that information.  If someone can't disambiguate "kvm" to mean
"vmx/tdx" vs. "svm" based on the host, they've got bigger problems.

And as for "vmx" vs. "tdx", I really hope that's not meaningful information for
users, e.g. the printks are ratelimited, and users should really be gleaning
information from the VMM instance, not from dmesg.

