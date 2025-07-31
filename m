Return-Path: <linux-kernel+bounces-751798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C5EB16D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10163BA85C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2129B29DB99;
	Thu, 31 Jul 2025 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IF0mrk5R"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CAF21B9DB
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950862; cv=none; b=bMzRrRaevq8P4MkXshJXT54p+97KR2SkcC7KnSEdWx7TWjmXzc4aCrYiK1+Np3fxTpZON75oYC3285ijQjn/ky9Afe9bKbt5NJnim2TzS0E8l9fSevOPlRlViBnWeotjjMV2dVgEFZ+VowPlt5y2/p0tA5a9srj1XaVdTRm6KFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950862; c=relaxed/simple;
	bh=eiNYedotPctc6xPTtf1N6xVN29fIlNTNoGPInQPwrIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOy7KTx7yXlDVyLJiKi2rPNayYxar73wbYtSgP69c8Eq465mFfbGbSaYwNtXP2YBGSdJSl8fGDkdGor55sG51sWPWjun2KJcDqEvVk0SzHOnWHAxv/EiLpWH+Fvj2FxhFV9r+qEtKXOkvia+AaorL91YTjkrDwnc4KBQVSOhxlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IF0mrk5R; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab86a29c98so209651cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753950860; x=1754555660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eiNYedotPctc6xPTtf1N6xVN29fIlNTNoGPInQPwrIg=;
        b=IF0mrk5Rist5J0IRks9DJHDrtbC63bkqftZMIJ0sRIChBfQNu9Mdd2/iN87vMgSYNO
         h2g+AAVjQt1XvGpEUFiKe+PtkqdZYPQroX6hreZIz8qWgHt0HzL+aHkMAVnhbesktTO3
         VUJBao3rZfbfQaoMzN7GPjVddX/BsqQvq6F02DzGSyh8H+asWkBGT8Ij0pajkpC5udvR
         VB8mFiMj1UN63IPYWIEU6AYwfW802j+GNpFvHcy2BkC3NFCQdJYXYAflsODOnMExhoa+
         0Yhb+PzbzcgxEpT7YRgCe1JPhMxzYnmOfHLOWviAcG0KJiJw8tsQeL2OLj5Z2rS6T7Ms
         HsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753950860; x=1754555660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiNYedotPctc6xPTtf1N6xVN29fIlNTNoGPInQPwrIg=;
        b=P+NfqkLR1reiuSgJvXCJvjOuEJx35yHz5TYxmdgoBlttN3qi7dPOE8jh+lqwH3kYFk
         vHhge79VgkndmUVSf+lvul7rEtj4ylTlLAXFn9HCFx2L4nNk/HupgLOwosmpVH37x+K4
         ISqWDHKZG7VJdUdIN1JnAm0/ZzKJwNHgM0mLSjSnK+n53jGr3V2ymNDaVlIXGFBiz6jb
         GJ9/mGr6NtDnw4cMMI5xlGd1SIq8nZoUJ11GgjcTbpMijgleSbQjI6BZhAbOAX6ilfPm
         caDSSxuwsMTjKxfsQO943Xe3xypKeXxSp4TgrgiJ02vt3UI+V0GmhCoLMDqdnvWtbVz7
         SUBA==
X-Forwarded-Encrypted: i=1; AJvYcCUH7Da+Ai02btbOXhPypSqw2IN19r5lwtnsaMmolMVuxeh7iR+tNAjFm5Z4IDMXXjNC+9nshx7eZ1bKdII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn7yCHQk42Qp+Xwc1NBprs1Jg4Y2kVMLMySOjJM6TwOOQl2m6v
	NbUZjXS/hDELoyHxJLG1AlpWrj88xbKWn7hnWTOhcVoy78uukiVJjvohPnTmAATapzgnjyp+uYL
	mkRiU9uLA0lmjhgsAqXqC166zEzko0kekYnx5E9oI
X-Gm-Gg: ASbGnct8eOzinpfGMtxtbqsOo/+K1RyS+YzpHHBIK8k4ACFk7vQOb1gKbel78/1SyJU
	4cEA9HmPPrET0sELancI9Cuo1DDrKP4Lz7utZH+foMOSXYllGSGfM+uhyV360H6IvTbuIFRqoGH
	5/DxkiiVAlTEzP1BjCdOp0vqLq2rw/F+HSKBe6np+y4pQhzwIZ4Derinz8Tcp+rq4PjaHvgKsGx
	6b/5IySG1WforRZCQ==
X-Google-Smtp-Source: AGHT+IHWSj7+ppidqQQ7crIyrSg2wcIE/rWj46ZOv/ucXGZB3xZ7fB2xhdup8ZybMJXt3sd69EoqALJyiMp0TePdZrs=
X-Received: by 2002:a05:622a:9:b0:4a7:e3b:50be with SMTP id
 d75a77b69052e-4aeeff8952dmr2421461cf.16.1753950859428; Thu, 31 Jul 2025
 01:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729225455.670324-1-seanjc@google.com> <20250729225455.670324-13-seanjc@google.com>
 <CA+EHjTwuXT_wcDAOwwKP+yBetE9N46QMb+hUKAOsxBVkkOgCTw@mail.gmail.com> <c320b7a3-bf75-4f9e-bd72-4290fd9fe9d9@redhat.com>
In-Reply-To: <c320b7a3-bf75-4f9e-bd72-4290fd9fe9d9@redhat.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 31 Jul 2025 09:33:42 +0100
X-Gm-Features: Ac12FXzoE81EGQG0C5ZbrL6pv7Gwfmxe6c2Z4n5qEJHhSLSLb8R4m4jCH0y1OFY
Message-ID: <CA+EHjTx8KiDS+WcB9gpWaKtmEaC40gdE1ZDaMJydHfMJLVLbwA@mail.gmail.com>
Subject: Re: [PATCH v17 12/24] KVM: x86/mmu: Rename .private_max_mapping_level()
 to .gmem_max_mapping_level()
To: David Hildenbrand <david@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
	Gavin Shan <gshan@redhat.com>, Shivank Garg <shivankg@amd.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Ackerley Tng <ackerleytng@google.com>, 
	Tao Chan <chentao@kylinos.cn>, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 09:29, David Hildenbrand <david@redhat.com> wrote:
>
> On 31.07.25 10:15, Fuad Tabba wrote:
> > On Tue, 29 Jul 2025 at 23:55, Sean Christopherson <seanjc@google.com> wrote:
> >>
> >> From: Ackerley Tng <ackerleytng@google.com>
> >>
> >> Rename kvm_x86_ops.private_max_mapping_level() to .gmem_max_mapping_level()
> >> in anticipation of extending guest_memfd support to non-private memory.
> >>
> >> No functional change intended.
> >>
> >> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >> Acked-by: David Hildenbrand <david@redhat.com>
> >> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> >> Signed-off-by: Fuad Tabba <tabba@google.com>
> >> Co-developed-by: Sean Christopherson <seanjc@google.com>
> >> Signed-off-by: Sean Christopherson <seanjc@google.com>
> >> ---
> >
> > nit: remove my "Signed-off-by", since I'm not a co-developer, and instead:
>
> The patch went "through your hands", right? In that case, a SOB is the
> right thing to do.
>
> "The Signed-off-by: tag indicates that the signer was involved in the
> development of the patch, or that he/she was in the patch's delivery path."

I see. I thought it only applied to the current re-spin.

In that case, sorry for the noise! :)

Cheers,
/fuad

> --
> Cheers,
>
> David / dhildenb
>

