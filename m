Return-Path: <linux-kernel+bounces-790818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45FEB3AD8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B014566861
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFDE26B77B;
	Thu, 28 Aug 2025 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jk+aQYB9"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87F9DF72
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756420385; cv=none; b=lHTvEjkhoWDA7T4Nv9R2kzj7V8IyVoYmSkl+nZlGnE55LYRB55zH/Z6OX41Vsm/JV9HSyUMxonJldLi/wKXaA+r6P8qSkn19vF5NQMm51Bmhbv4h8BA0UwfxbtfGKksN8U4T/z63MsNlYFy/n2qO4t7RjyXZY+xPCYtPvhrRG9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756420385; c=relaxed/simple;
	bh=K6rbSywr3liMBziHfv1QuO7HBNEd/Ua1JS7Cr5kgfMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L1zcrIlTQ3vztJNoZ1jJsz1M4ovNz0Klkf9fc8Th+isp0qpuVSg+T+L/z5HK61JM8AlwXBwemmxpI9nNo7w8DMJFt1uUuxs5KO3B3uvkAkAVMGPWfqG5nMUayoujKJqEtJCAMt7DuhHVHrvcGxf5n/TFU6MLuAq00SjDiFc3GZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jk+aQYB9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2461c537540so19433075ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756420383; x=1757025183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+17/H+4kWKkZnVGa0TR2RJPgmi/ghOmC8YbLPrEO9j4=;
        b=jk+aQYB94aFEpRTw7dNwJglwfgc9ZWnNMpyQ6t4YFw9PqDMzBJkmzSsZNPodixF4lm
         NMiiK5TOyuWYy0VkAkRaYvSIMf6QrGKgeupnXUnKwgm1syVB5zgsF3Cmpvup8L1sMm/q
         cuK5ngR99hula1NunrOB34tzv9haFKLCVecEqN9oJEgafdJmMiJpKdXGP6ROLkN4UD5J
         OUiL3JJLv0D67/eky604zaUHei8c3NOCrSsP0fxcRVGvOC6tllsRvpqxEG6ZlnpUwAYF
         lBAiJordklmeKJRAYmijCTeWBcNhnsgRYE5iuKxGm4o5r36G9h3Laclsw2RLVQuKdUJU
         9bsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756420383; x=1757025183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+17/H+4kWKkZnVGa0TR2RJPgmi/ghOmC8YbLPrEO9j4=;
        b=rqsHqbbolxOTHRoqQyZYP5oZu44Z+hQtArSd/AhntbHWXCRx0+4C5w0hM4DJj9czjt
         M0R3a6hWfa4wd+OFBMTm6vopJwn9Gaamt3e79yBXRTVn01GHVwruzZOvOVcb0zTBzr7p
         VNxhajgDSE3f63CbeOORVYrMbCDSsas3gywZecZqTYzGDPstxTYuxNL/yYYyy2p8jwXa
         wiIKU954N206CPz3c+cJXHUOJMcJTZELFYb0sO/5BKo+nwmCXBIfB/h8p6qW+aZZftn+
         Yy9qumd+fqNbGUjd39mq3mOTa21vaKJbYujWeR0cpHTaq8dHoICharDuQEYvM8R0EIwR
         UBmA==
X-Forwarded-Encrypted: i=1; AJvYcCXsAbJ0lY3b/X3TzDmYjiHlZ8jhD7F7DlrH+hQF8ch5W92WgEBIzdp3x4JertlQyj5CBvlYVf2ljLRmjSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrX0NPmPUvOGgTAMd6/P7dbc+DraIdM1FpqO3D9DmcVpyR+qz3
	/G+umTVTuVYT6TDFu/zgMy1xbMMaEwNJfmJ088ew3r8v7DBGu1EULgmp+FZkyIIyElboWPwQMyo
	FnncpVA==
X-Google-Smtp-Source: AGHT+IGWGemAf7sAjdH9xZVVyY7xAyGsHoqC0dQYyou09JIvG20T8o9Jf0H/opcOFvJvKlImeT3IY+2mDoE=
X-Received: from pjyp15.prod.google.com ([2002:a17:90a:e70f:b0:31f:61fc:b283])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e80c:b0:246:b3d4:5c82
 with SMTP id d9443c01a7336-246b3d4620amr272986145ad.16.1756420383166; Thu, 28
 Aug 2025 15:33:03 -0700 (PDT)
Date: Thu, 28 Aug 2025 15:33:01 -0700
In-Reply-To: <128a19f38bb532a91cfe23b7a7512bb883b276cd.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827000522.4022426-1-seanjc@google.com> <20250827000522.4022426-9-seanjc@google.com>
 <afacb9fb28259d154c0a6a9d30089b7bb057cd61.camel@intel.com>
 <aK/7rgrUdC2cBiYd@yzhao56-desk.sh.intel.com> <128a19f38bb532a91cfe23b7a7512bb883b276cd.camel@intel.com>
Message-ID: <aLDZHf55rz1W0n6b@google.com>
Subject: Re: [RFC PATCH 08/12] KVM: TDX: Use atomic64_dec_return() instead of
 a poor equivalent
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yan Y Zhao <yan.y.zhao@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Vishal Annapurve <vannapurve@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 28, 2025, Rick P Edgecombe wrote:
> On Thu, 2025-08-28 at 14:48 +0800, Yan Zhao wrote:
> > Hmm, I still think it's safer to keep the nr_premapped to detect any unexpected
> > code change.
> 
> When I checking patch 6 I saw how many more KVM_BUG_ON()s we ended up with in
> TDX code compared to the rest of KVM. (even after we dropped a bunch during
> development) We have to differentiate from good safety, and "safety" that is
> really just propping up brittle code. Each KVM_BUG_ON() is a hint that there
> might be design issues.

Nah, I think we're good.  The majority of the asserts are on SEAMCALLs, and those
are no different than the WARN_ONCE() in vmx_insn_failed(), just spread out to
individual call sites.

Once those are out of the numbers are entirely reasonable (WARNs and KVM_BUG_ON
are both assertions against bugs, one is just guaranteed to be fatal to the VM).

  $ git grep -e KVM_BUG_ON -e WARN_ vmx/tdx.c | wc -l
  25
  $ git grep -e KVM_BUG_ON -e WARN_  | wc -l
  459

