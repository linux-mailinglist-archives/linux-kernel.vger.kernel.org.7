Return-Path: <linux-kernel+bounces-736448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF5EB09D01
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95950178C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE9F29551B;
	Fri, 18 Jul 2025 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPaYuF3h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD69293B48
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825168; cv=none; b=VYDQzfQvTcKQcSXwmU2scOIJB0H9TTG7/iJol9qOuIdSbQbrLjxl9eOlh4FdrZwfpoEQd3LjsDT4JoI8M/FtPrsAop9qoFfKHE3K6zD4+dI271roNb30OkBQHKMz2Gj81oMFijFzy7X9AjCjEfMbzGYCNaW2oyTk9jJcZiT6O+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825168; c=relaxed/simple;
	bh=2pi8KBcoIPlm4tOCt/inqjOUYuaGd1omaspVeZAZA8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OW76E9vFCQJVoZ/+jinLPu6Wsx8LfTF+PS7SXIJ4GBT8hIpHaVYuaVWDaDcwrHxyrYrltBeRC0BekrCsglfCrIcqaX1V4DDEgfb/SzpgpgMzNeKcdMyPj4m0AGFsIgZD5OZHowrR5LfKuJHDD6Ei/36d8B5QUZZ3dGxjVtIBNzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPaYuF3h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752825164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pi8KBcoIPlm4tOCt/inqjOUYuaGd1omaspVeZAZA8w=;
	b=RPaYuF3h+bcigEPAjovnmbMBqzDoWJ41RVYOQG7XMf5kZXlQpRNIgdx11gDEqRwzJtplKQ
	tvb7Pg+mm/eBcDaRMipyoZT8AZbszu+/bfJQu8lPL+WX1yUYnz6FKqVgTxjNElI18ZpfQz
	2xBuUAGGi6u/YYcqSeYb4uFfcu4Wyx4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-C-S5MnUZMjex5UnKU0Jpmw-1; Fri, 18 Jul 2025 03:52:42 -0400
X-MC-Unique: C-S5MnUZMjex5UnKU0Jpmw-1
X-Mimecast-MFC-AGG-ID: C-S5MnUZMjex5UnKU0Jpmw_1752825162
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234f1acc707so19032585ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825161; x=1753429961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pi8KBcoIPlm4tOCt/inqjOUYuaGd1omaspVeZAZA8w=;
        b=jcnz7sGMpBTDDBuoFAQ8Ip1fFRrJpWtnm2fY4Vb9I57itsoXyRhdcSbCCp3K96RZ1c
         2DNSjas/HqYyXevouwO7/tmF8Oo6HlIhaZH9egYJMq5LXgOPyhwQP1n+PiUtmI8pmtrh
         Ycq58aMmFtQonoalj+jDw+pnmj8y4b0JF31Bjl4CBRbXEvhOpF4eb51iuPXwInFWc8uu
         fAE4h9572UzpcR4BprIYvyVPWVrsplIf0qUT0F9WwOCkqVWWuD8ZtevXP156L1+WFvCy
         TxG7sA8YvZE9Uj9uOeZIMicYUvmKK2JGqeDkvjBnKDuq8OrNou43gPm4xs74WbLNrPU5
         wiIw==
X-Forwarded-Encrypted: i=1; AJvYcCXoBK2HrVXXPJ/bN0aixpF2jUykw775R4+XjvWJzSlMI6xk28xHdHDiEUXVtEa4Wodj5YGSO1c+g5v0EUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytFwumAshf8hkMPB2yzU1VFcd13Z6UFNBsuEpPE3abKxe0xkwe
	zmkBdC3FmkiSsQExoj+yBJMB/UJIk1ppf900+hiCrBn5rhdUE/+QlZqnS38K86YUvyKwWoNMht4
	2utfuEHQHlrNzfZ0vHmeYXhhnhFNHp0YRog7NI8Z7wVEwXEUN+2g0dDoWJTzTvZRxhLzurxL2BB
	VnnbkApHQuO5p1/LRqv1SlliGOETWR0FucNyYEUgp3
X-Gm-Gg: ASbGnctsIoxJtzUAQ2IyPP89fKss7LrBheC47nISmF6S79UreZ5uwwJASK5td9F0sf7
	D6HLX+CagAKbrMwacyKr7C4jbxJ6/aIPvFuv46uxzeC2NL497N2eq3AFo8B7gmZS6XSW2LRD5c0
	w28xVgvJfKLYB4L2Id7H0Wrg==
X-Received: by 2002:a17:902:ec8b:b0:235:f3df:bc1f with SMTP id d9443c01a7336-23e257451fdmr133641835ad.36.1752825161539;
        Fri, 18 Jul 2025 00:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEczHEQLoKluvpGtGTxZAFG1Ct7SS0ET5wuggRJXsSha+pJGDGNiCavb0Lfm2+EHUkt6UvPo3yU43N4AaOjSqo=
X-Received: by 2002:a17:902:ec8b:b0:235:f3df:bc1f with SMTP id
 d9443c01a7336-23e257451fdmr133641485ad.36.1752825161093; Fri, 18 Jul 2025
 00:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718062429.238723-1-lulu@redhat.com>
In-Reply-To: <20250718062429.238723-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Jul 2025 15:52:30 +0800
X-Gm-Features: Ac12FXwBVT6a31yvU0qqbtQu-2z0AJwY7ghH6LYTEkWi9oJSf_Mb34yGWOF4UH0
Message-ID: <CACGkMEv0yHC7P1CLeB8A1VumWtTF4Bw4eY2_njnPMwT75-EJkg@mail.gmail.com>
Subject: Re: [PATCH v1] kvm: x86: implement PV send_IPI method
To: Cindy Lu <lulu@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, "Kirill A. Shutemov" <kas@kernel.org>, "Xin Li (Intel)" <xin@zytor.com>, 
	Rik van Riel <riel@surriel.com>, "Ahmed S. Darwish" <darwi@linutronix.de>, 
	"open list:KVM PARAVIRT (KVM/paravirt)" <kvm@vger.kernel.org>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 2:25=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> From: Jason Wang <jasowang@redhat.com>
>
> We used to have PV version of send_IPI_mask and
> send_IPI_mask_allbutself. This patch implements PV send_IPI method to
> reduce the number of vmexits.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Tested-by: Cindy Lu <lulu@redhat.com>

I think a question here is are we able to see performance improvement
in any kind of setup?

Thanks


