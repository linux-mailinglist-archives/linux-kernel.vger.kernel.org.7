Return-Path: <linux-kernel+bounces-838332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A24ABAEFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695C91C408B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBEE2550D4;
	Wed,  1 Oct 2025 02:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BR6T08QP"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4B24469B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759284354; cv=none; b=gB2KR0OphjGOfMwYyQ90bHcLEThf8Zd/vOnI+bjHmeEAzIF74LwWuniMyS6ih0oAuQzMYvvGTi40nNsog3TFeQN6XnnBh5xC/5K5411P4Y8l6OVaJj6NZZHVUEWRZWty9uWE7+wUiOZ0GayEkB7jtZolb14vSnQlsOWD8ff6D0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759284354; c=relaxed/simple;
	bh=Y6HaAtFJtLGOJV4yfr/jVQuVJHQUmCOcC36xFKcXxFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgCcgZIYca2sexAZAl80eJyYyOGN4Mb92iAOvLJTB3Jjpp22H0Lv0qoIa/2ksu++LQcPmFLAcGcP9GaN00yGYkBYkOJhwjhzYx1EzdqfZmhqr9jwGNkiSgV62u2KP1Mz8iI/UTv1CCU5ki9E1jNBtnoufvgK/7BxoW3FmfKKS6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BR6T08QP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2681645b7b6so49195ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759284353; x=1759889153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVeC2yR6/fyOcGwJdvETBf827K0Hnz0K4NiV4bbwCLg=;
        b=BR6T08QPSkSwqQK5LVF9lSMh15YGNQjzrIH1LWk8MJtox5UprzzdSq1tNx0ERAMap3
         oo0VNGtauzV7pyBOuGTRa7yVD5RIjvpJVm5rpNv8E2qLiKFeMXS7CdU1pKaB8Vy3r4fI
         F1QMznVXEJVHZ8TvwAbhJ0IpN2e8yR3tAZ1lC1e3UtXlrugA0/nYWFqSIb9af0AqQ9YG
         +mrjP96EglgEc4P8BRnLDvAeO7VlISl12CYZFu9CR3iK78MClTCsVQw6CjFEDPeWywP2
         udOubu5Ku84oT2FU0dMNrtJd/b2BcQdq66GG8W+J/3bynCJ7KqwKxeOKUFEJXgoK+Z/U
         9T6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759284353; x=1759889153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVeC2yR6/fyOcGwJdvETBf827K0Hnz0K4NiV4bbwCLg=;
        b=bYyGNOo09jyQralwjKpbgMzZDLclOW0cPm4+H739dB4V1Y4I7LOyDqYmIUdjxFOV0q
         Qvg1qjlTGMNNxmtWGEg1b7Q7LLy5Ej8ESQ0U4jrCUrTDSXcn0ejG7YmQmBbvXrQboQOe
         q4sJAiCMLSRNvjYdShZYFG4DNS/TG/pZU8C1KyQItkKQ1tLR1fHjHnVlDQp0kTf/eToY
         4Nv312q9bmeHNrCiEIJEdZgXsa0bNFcWfd+Dkn3XV/cmd/LR9YjGDyVBxCYgn8ZmyFE2
         Aaz3Evsom6+4t9+I7iGOwWNMhG2CICEi7jsiUnoH+YGEogwjfD5avyl6XLFiWpNKMQKn
         Ne2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBg/dMCykLX1F7ofwY5tzFjA6TNtWH12uzdmZIaj9VXHx59FQs+0Ic1dZRgYIsmAAcKTZ2zTNLbjWcsmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9qpUwm59eMnEMbplUGSYCgpQTrCRzhkWcHmRsoeNrgHzYcZ+
	dYapK4rjMYcB79SSLZOpoim39I0XR+qT9pyuNQiuTRMQKfp4mTn01PEt3sdZLLvfzvhr+bTmuNh
	QbqI6tdEdz9NKHH0m5CtR9J84lEmTfLd0mrYs4MrY
X-Gm-Gg: ASbGncv6z6GjMqLcDXdU+2WH8yYxclYTFadi/8CiI2jyjxb5X8xielzOF5rnufk9NRm
	WOSoCqYp0j7xIh6jX+zKeShv23QM+24EVXZqFOozkPcB0u80v7SL6ZafvZqG6rdc4NoPZjGFukS
	nPfbIUsKuh8ZxWDWAp4NtG6/dNBgc9E5lRIhRoFnFXcYQ3YkANtO1nLuvZDIren013igTIYu3R2
	Bc/iaIS8Yv6xUJterl9oaDkNcxB2+vVWrQWWaoxyHaYxscmq1Iu6u59tUqeXhlxRkyJtNp+14U6
	Fg==
X-Google-Smtp-Source: AGHT+IHNcj1SejlF9v6ljVGsWNKD2HUwrJwrNFztxLPCk0u6IVhVAr4lvWL+0HiJx8NWvVjDAG1A0mX0Hdeet/twNsY=
X-Received: by 2002:a17:902:ce0e:b0:24b:1741:1a4c with SMTP id
 d9443c01a7336-28e7fcf1f70mr2567495ad.0.1759284352345; Tue, 30 Sep 2025
 19:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901160930.1785244-1-pbonzini@redhat.com> <20250901160930.1785244-5-pbonzini@redhat.com>
 <CAGtprH__G96uUmiDkK0iYM2miXb31vYje9aN+J=stJQqLUUXEg@mail.gmail.com> <74a390a1-42a7-4e6b-a76a-f88f49323c93@intel.com>
In-Reply-To: <74a390a1-42a7-4e6b-a76a-f88f49323c93@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 30 Sep 2025 19:05:38 -0700
X-Gm-Features: AS18NWD0egat_nfpK-bvQfE8ox60B24A14Eh4qeClxcfsjJofgJuyxn0sTJC9_w
Message-ID: <CAGtprH-mb0Cw+OzBj-gSWenA9kSJyu-xgXhsTjjzyY6Qi4E=aw@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86/kexec: Disable kexec/kdump on platforms with TDX
 partial write erratum
To: Dave Hansen <dave.hansen@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	bp@alien8.de, tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com, 
	hpa@zytor.com, thomas.lendacky@amd.com, x86@kernel.org, kas@kernel.org, 
	rick.p.edgecombe@intel.com, dwmw@amazon.co.uk, kai.huang@intel.com, 
	seanjc@google.com, reinette.chatre@intel.com, isaku.yamahata@intel.com, 
	dan.j.williams@intel.com, ashish.kalra@amd.com, nik.borisov@suse.com, 
	chao.gao@intel.com, sagis@google.com, farrah.chen@intel.com, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 2:32=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 9/29/25 18:38, Vishal Annapurve wrote:
> >> On those platforms, the old kernel must reset TDX private memory befor=
e
> >> jumping to the new kernel, otherwise the new kernel may see unexpected
> >> machine check.  Currently the kernel doesn't track which page is a TDX
> >> private page.  For simplicity just fail kexec/kdump for those platform=
s.
> > Google has a usecase that needs host kdump support on SPR/EMR
> > platforms. Disabling kdump disables the host's ability to dump very
> > critical information on host crashes altogether. Is Intel working on
> > enabling kdump support for platforms with the erratum?
>
> Nope.
>
> Any workarounds are going to be slow and probably imperfect. That's not

Do we really need to deploy workarounds that are complex and slow to
get kdump working for the majority of the scenarios? Is there any
analysis done for the risk with imperfect and simpler workarounds vs
benefits of kdump functionality?

> a great match for kdump. I'm perfectly happy waiting for fixed hardware
> from what I've seen.

IIUC SPR/EMR - two CPU generations out there are impacted by this
erratum and just disabling kdump functionality IMO is not the best
solution here.

