Return-Path: <linux-kernel+bounces-788368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A65B3836F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF60746260A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87DE35206D;
	Wed, 27 Aug 2025 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsgBNfjf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D834A30A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300302; cv=none; b=O0JQh6+xiCOKSQnmC7h13ERbrWm0mZxn6J1NM9itbDw4z5p+Cj9GkDoEWMAAzPIq33AwvTYflPU6yQXwqTFEIRZIa2WNJfFWjXAFUna7UQtslPjK9xOoYyhRtOG6dvUFy7bFyu5/2EgkL15WxkX4PJYmaPKO6lH7ZLsFHkyR5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300302; c=relaxed/simple;
	bh=YdlTsQZNNrmq7u3Z5M5rk595Ss//u8ZKePXJNnxhb1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLNEUO/6nGXV3HpXH5pm5/Pmrr7740jJ0V9bSzAny+hus/E88/Y8zYlp2CQrhosM3AvVpLU4+pslsLBKceE1hp2o4sKT1MlPOUKQQ1gTtPydd0qfB2OTtQwZJXrPfJLgjTQW1cwTTZRf2DzkW6fJVCFofF7NL92zm5Zvis64ab8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KsgBNfjf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756300299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YdlTsQZNNrmq7u3Z5M5rk595Ss//u8ZKePXJNnxhb1o=;
	b=KsgBNfjf/C56wKrrAjdzI5LbfhlMU38iWjWx6KYJORwj0yBnRxCOE0jvg8f+rcn27VTf/A
	W/svys0LiBziZxYu7G8/kmoOGvjhUq38x6PF6ha8rCyQpTq9Lr727w95QjhmARW0LXR9oo
	RCTe3og5vBfajyT6VycaACforChRojU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-ziMXwL_TMf6bn-NOXx_-9Q-1; Wed, 27 Aug 2025 09:11:37 -0400
X-MC-Unique: ziMXwL_TMf6bn-NOXx_-9Q-1
X-Mimecast-MFC-AGG-ID: ziMXwL_TMf6bn-NOXx_-9Q_1756300296
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3cc3765679fso449339f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756300296; x=1756905096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdlTsQZNNrmq7u3Z5M5rk595Ss//u8ZKePXJNnxhb1o=;
        b=ugQs6/KkhXRrHzDU2ycrReP/0px2qlyj7aNcUIVTgecpbhzDQliJqez8MhKiZSWQnE
         p7RX52Cju30TTpIiRbRi3KfQzdImW6ZH1CqEqpEvrVo5sA0MpjnWST4Gnmh8InsdrC7f
         P4GxOKdo7yzWTeMvhyRO5iyHoP1wZW3G61q86M+QfzzAhsLqqbUb6vSjlING4NESDM3I
         0mXm6FzhJnVNJkd2NXlCB+1kz7oq0Ard6wU4CuRG4o/0L3mpDdp4hUtODOYFLok9rUTB
         nBZVdrLih09EBqN6NiT7h1WgO4l6ed1etud7fsn+ObO6SL9HyhkZFX1Ajowpa6hl9R9y
         3cCg==
X-Forwarded-Encrypted: i=1; AJvYcCVqUr+0tdHYL1TF05rvuEZfipPJM6KLGTE1otNzkWVRozfA7T0RXkzHLSFK7vk70XdssEcS/ixCtWC6sVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXcxEpJG4YXaEa0e9txS7ExUu6wsNYeGkSPHjUrbNrAg/xkQBA
	CpIk/e/RdmazzRBxrOUYuBkC62MATv2nRzoUZuTlKDjSwD92IQTdr4+nS2d3xXnmAYE00mWWGoL
	UE2USQs1P05gnInjDdTLXS4E1XZqfbDHz3+89BZtH1g/J/qiBEkdZCeWZtCceDcRAO2g8b/mx3V
	LK0Bmd/GXeokSIpQpf4Y9iJdg2Q8d+6T1SSjmeaV0W
X-Gm-Gg: ASbGnctYi0hxwQpN42OEpC5lIi8fkCIt85nxVCVdzR4DKut1sPAQj5oskAVSOmdB78j
	o7hm2inYIeoA7DYTH81TfU91WpEQ08b8grsY/eYH00PHAqDz694iE80GhwEhBpxVMcXwhZMAeGp
	aYU/BNfEYKWJa4pLsLqKOW9eDzeUzJ19hdO6ope1vfNyS8tFLEBoW0DTD7Rzq/VJqXrUTapx9ha
	FMOziyHKk9WxMsCCjttio9o
X-Received: by 2002:a05:6000:144f:b0:3c8:6b76:2ee9 with SMTP id ffacd0b85a97d-3c86b7633cbmr9046540f8f.19.1756300296497;
        Wed, 27 Aug 2025 06:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIu95W78Kd2FcqoAMBmRWc50Pfjv6n3rRZIWnWs3jErMyKSztWJGNEOWQHM3H1SLdXfBJS+ZjUc6qHuPBUxAQ=
X-Received: by 2002:a05:6000:144f:b0:3c8:6b76:2ee9 with SMTP id
 ffacd0b85a97d-3c86b7633cbmr9046516f8f.19.1756300295999; Wed, 27 Aug 2025
 06:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729225455.670324-1-seanjc@google.com> <87b10d94-dca2-4ecb-a86f-b38c5c90e0cf@redhat.com>
 <86frdcewue.wl-maz@kernel.org>
In-Reply-To: <86frdcewue.wl-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 27 Aug 2025 15:11:22 +0200
X-Gm-Features: Ac12FXyek3cfAXJUDvWryX-P1WU7M6mjVSZlZC6o5IXedOpceLYmHnNxWJaWG74
Message-ID: <CABgObfb21UEZf4aQVv_-v3uFCp08G3SWhoTbpmSFz7qL0Xm63w@mail.gmail.com>
Subject: Re: [PATCH v17 00/24] KVM: Enable mmap() for guest_memfd
To: Marc Zyngier <maz@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
	Gavin Shan <gshan@redhat.com>, Shivank Garg <shivankg@amd.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Tao Chan <chentao@kylinos.cn>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yo can

On Wed, Aug 27, 2025 at 3:08=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Wed, 27 Aug 2025 09:43:54 +0100,
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> > Applied to kvm/next, thanks!
>
> Can you please create a stable branch for these patches? It is quite
> likely that whatever I queue for 6.18 will conflict with that, and I'd
> like to be able to resolve the conflicts myself.

You can just base kvm-arm/next on kvm/next, but if you prefer I pushed
guest-memfd-mmap at https://git.kernel.org/pub/scm/virt/kvm/kvm.git/.

Paolo


