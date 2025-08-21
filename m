Return-Path: <linux-kernel+bounces-780078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF6B2FD51
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EDD1C22302
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFF425B1CE;
	Thu, 21 Aug 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0nYVNDR"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FE91DF749
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787343; cv=none; b=Pi84AngmzrcXLFXHivSngQsAroBisr4ZT/r6Y1IP/07p9cG+Vxu/tsgFvvjTTjaiDXE6Mj/FBtPNadISEEYsLLxdodMKAfZw4fr0JXZt6uBKGm9Tmmmyz105fb0tzG7673ynpB25ObRqYwf/Dr/+d7WC3AosLVamVWW+UQnU7i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787343; c=relaxed/simple;
	bh=BX5DAhqdzslnO/91gi/bXKLfgy/01PP5THxGap5lJvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z2Pny7CFJQb0OFqGFaGsfocpdFEkl1iac0SKp0ju9SuY0GEXXx870AjojkCXzcMzXcAYTq9GmNqZz1ZGGDEOpNZ48ERGF5pLEBmkAWm8nyrOwIZzxTxO4pvqmgEYsz/m3/wulyLRqkY0Qw1O42PAki1JNgiE1hD8SSSal0DTjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0nYVNDR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3232669f95eso1151343a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755787341; x=1756392141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwhaOsDZKjM31to5aYQy2uwlBTUbbjztbU3kR381HLQ=;
        b=b0nYVNDRA1kOYjQGgCHB5C8rfDce4HmsKtSRI3W36RslK8RxjKxfzISVXA7Tr3duK+
         Vq2n9n9I10HqXr74NS3RJkHugMJbfhnyQfqt5kzklh9qQDStznW5+qK8hUvecm9294J7
         tLCpQgjRZy8iDoxS2JYrHKVuLXcBHc82a4yqd55zaL7JJYQDWtBdjkLyegoo8OpC6wWI
         SKby1HzZdHroOIpzm8kG/v2WYXOCkg+K5GkNJKrGbQ57ZHDvDzovDASldYZ5RGjQpfbn
         V9sPPC2YXHBdtnS+fbAo5+PADkuHN7HukvgMVh1GPstW3aYMajyr20IUlOEWCl+bkqIV
         IPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755787341; x=1756392141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwhaOsDZKjM31to5aYQy2uwlBTUbbjztbU3kR381HLQ=;
        b=s5H8vzJ+umHhKCWQPI1prkJELSdBHAShqpbszSb7sstmiqeo2mshmzzORA10hYsVIM
         khPmifDZES3MnpjyNYd3e9OE6euz8YL6ghD+6mg0A3ofSfMoF/n6Sh0yLxsCf0vAIEbS
         Oxlb5Gn/tZFRWjrtQKx0S/b78pu7CuGzR7je0RU+AkQvBOwnAXaIrm237npKApGVaYyp
         LlPTvUwPvOt3InQ3F+XTF67eS3qymyLzp2uAa3XSqq8sJ0v0ZfqoLmuoAKLbTamrPsLo
         chORSkM/dYLFtY4RM15hXJcnN6YYi+aD7mnlnZ4L18PXsPbThkVGy3hlYckEaUUfVQVu
         2WmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrOVbcCUYlaUWV9Ug+0czbLYRBZvoMc1vdpz8zlW+GjXAHCpGe7I0ZADxsvxMPEplnaYB0ldDJnRTVNK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7FO8kCuH34KhXLJ6nI+FBmFQKH4JteuOSbwYptfc8O0rLshD
	obLwW/lKw8eCvLZnKz/NT/H70DHQx2k6bb4ApBTre/vLW7fRWLZla9Tu16ClaZM7O5oIpq5IosV
	UQ88qKg==
X-Google-Smtp-Source: AGHT+IHVlRF4YOtCmwKhiHtV/w+adEcX043CzoyDKgxhaqZVVCG0NLmbgeDnpXrLHXuQ4ZYW1MGM4IlOTFM=
X-Received: from pjbse8.prod.google.com ([2002:a17:90b:5188:b0:311:c5d3:c7d0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5183:b0:2fe:85f0:e115
 with SMTP id 98e67ed59e1d1-324ed1d36ebmr3436941a91.26.1755787341218; Thu, 21
 Aug 2025 07:42:21 -0700 (PDT)
Date: Thu, 21 Aug 2025 07:42:19 -0700
In-Reply-To: <68a72f36be3db_2a6d02294bc@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-2-sagis@google.com>
 <68a72f36be3db_2a6d02294bc@iweiny-mobl.notmuch>
Message-ID: <aKcwS9uY1WSvM3uz@google.com>
Subject: Re: [PATCH v9 01/19] KVM: selftests: Include overflow.h instead of
 redefining is_signed_type()
From: Sean Christopherson <seanjc@google.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 21, 2025, Ira Weiny wrote:
> Need to add the selftest folks.
> 
> + linux-kselftest@vger.kernel.org
> + Kees Cook <kees@kernel.org>
> + Shuah Khan <shuah@kernel.org>
> 
> Sagi Shahar wrote:
> > Redefinition of is_signed_type() causes compilation warning for tests
> > which use kselftest_harness. Replace the definition with linux/overflow.h
> > 
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> 
> Thanks!  I've seen this as well and it fixes the warning for me as well.
> It might be worth picking up separate from this series depending on what
> the selftest folks say.

Again[1], I already have a fix applied and will send it to Paolo today.  And simply
including overflow.h doesn't work[2] because not all selftests add tools/include to
their include path.

I appreciate the enthusiastic though!

[1] https://lore.kernel.org/all/aKcqRFWuGZQQ3v3y@google.com
[2] https://lore.kernel.org/all/18f2ea68-0f7c-465e-917e-e079335995c1@sirena.org.uk

> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> > ---
> >  tools/testing/selftests/kselftest_harness.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> > index 2925e47db995..a580a0d33c65 100644
> > --- a/tools/testing/selftests/kselftest_harness.h
> > +++ b/tools/testing/selftests/kselftest_harness.h
> > @@ -56,6 +56,7 @@
> >  #include <asm/types.h>
> >  #include <ctype.h>
> >  #include <errno.h>
> > +#include <linux/overflow.h>
> >  #include <linux/unistd.h>
> >  #include <poll.h>
> >  #include <stdbool.h>
> > @@ -751,8 +752,6 @@
> >  	for (; _metadata->trigger; _metadata->trigger = \
> >  			__bail(_assert, _metadata))
> >  
> > -#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
> > -
> >  #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
> >  	/* Avoid multiple evaluation of the cases */ \
> >  	__typeof__(_expected) __exp = (_expected); \
> > -- 
> > 2.51.0.rc1.193.gad69d77794-goog
> > 
> 
> 

