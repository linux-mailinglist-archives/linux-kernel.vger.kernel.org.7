Return-Path: <linux-kernel+bounces-731849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E53B05A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A722B167CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6E4212B1E;
	Tue, 15 Jul 2025 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMbDR23j"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08419C566
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583666; cv=none; b=fHc6w6Y+IBYWinFXl6WFAULP7+Sk2tEw3tt4XAG9nwW8FO25xOTfkXLmOVCOyjmmxyKHTLBXBQKCngHqXUBWqdmfgWHSmxU3EEzZ4DxE3r6e3QrSqgQSRmf935aKgSaHSmjONQ3vb2icoVYK867nGyI0x63Z22dew1B5CVqGw3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583666; c=relaxed/simple;
	bh=KYR+8WGWnfv9Y8T8MKK6057v1ckaI5RFw4T5Nl9bG3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avIAWIODOPDk1gl+/uWfYEYgk8p1R2khXeaL8GYQ5ywnflm+33V9GG2RdZje6J9ELHF5bDBFWaWWHn4cnA1qK1wTqf8aANNaX3SaVAK+LySUy9lYOq8n0kPrsbCjE4CBU3zg5k3e/X4XWPGGzbRE0yaDkBgIbswbx5IMRguOgT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMbDR23j; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235e389599fso195575ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752583664; x=1753188464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aj7ubsCPwZOZJpEqxVz8TbpdGSsesLgcauIRtiEwO7k=;
        b=JMbDR23jM9gRQzDKri6DOIbCBbeUvnUOrp3r3L3f0Vr9ooey0t7db+fi51HMqSEe9s
         h5822u3cmAH24gIvYS2UaMpp8aur8kbx3LEeRm/7O2ZXtvGR0i/dXwmgRqxRgO9vLZBX
         ONsOjYys71aALvNHVA09agqIn4+6nQHXaALyL+1PkM81KB2CJ+HH6RC4jDeFYd49EYV6
         mgrQ6q4irO5br/YdQRxeR/kEAiEM3jkDi/iF6yWcDku6iG7bEcTebvN+AUwU/KlR5LGR
         dcD5DEFEAfbp6QBrDtqzl/plYpjyo696KRvEOoB+U0STl0ceP37hfh9UVfMtzqHscmEC
         iqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752583664; x=1753188464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aj7ubsCPwZOZJpEqxVz8TbpdGSsesLgcauIRtiEwO7k=;
        b=OwCW3hGVzBnYX1E3avivDEMWe35ZfOHGr4DQygCN3yO9sXM4DiIJ4EgjTy2DnbKRKx
         0ZlLFc3Isqv6AGRXcO/w3R28wGxRHT5yOXES2HGmyOIbEv/+HpZhenQLMWKGhxLx37bb
         +nHLZ5x4iPqECV7JogRcgY+MRp1k4Ncwj0a0ecTHctRytDSEysJvnbqLLM/KfyMdWTPl
         xWHUCj/ThUtHgDr08N87Q0U8f3efJdol0b/JPPybny9fTFQlZgjDssyoQvMJGro3pDhk
         /bGwNzACKaOS/eObzxFIjG49hA93u5EJL/kmvpeO7cuz0pUZ8LdFE6rf7RmVfxBPiTsE
         Eylg==
X-Forwarded-Encrypted: i=1; AJvYcCW1LjHMr+QVyD+w4TV7TTCTQb0qE7DmPRg9qL8Yv/cGV6PKV4UKmsenb7ALseU/I6erM/rLG0nQYTcBjBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrBfmD0B4bMk63+Z6121xZbz9//YaqGHtou6famr24imEnr6Hw
	c8C7ZOsda58nX7QCD4+LtHIHVbeBzijUG3lAFYL191BrclA9aq1MfAJO7B5ylD59zx0nsbYxWWJ
	7mPG5DUVcE7jzKXUmudZBbAYxhk1SeA8bFMPHAcUU
X-Gm-Gg: ASbGncuRlmaDzz6E/Nt7smmSckKsE17CAftUDBIP2hVJ59dxDSuLkE4CJJaVl6SdO8q
	UO0UpITfw/SHTcyz+R3PeWxy42YtDN+JGkXO0FO6qMKNYooAmU1UB4bUDkRFEi+Icv5VItvtg+Q
	hzOm1pcfwtNl4Ei/v1xfSU6PS//WmbY7ll/GCgebsqRGECXKGa0OYOLk7JRMnA2Go6zrIRepE+H
	esX0uDODUUOy5oQR5Gx9BN0ODaurspqWeUZ2ik=
X-Google-Smtp-Source: AGHT+IH6FhoFqjhts9hPrxy/0Fq8QGuoieFjS6j7sof9NlS1UqMiOBs9T+m5042HRhsk8TgMmcHFmjT0Kfqpm1cbk+Q=
X-Received: by 2002:a17:903:185:b0:234:9f02:e937 with SMTP id
 d9443c01a7336-23e1b55fab4mr2002615ad.25.1752583664056; Tue, 15 Jul 2025
 05:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613005400.3694904-1-michael.roth@amd.com> <20250613005400.3694904-2-michael.roth@amd.com>
In-Reply-To: <20250613005400.3694904-2-michael.roth@amd.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 15 Jul 2025 05:47:31 -0700
X-Gm-Features: Ac12FXzMu1OlGDkOTawp9sA6enrjnahYfgISzdZFft1Fez6ANKUKFtOIvoCuXnQ
Message-ID: <CAGtprH-vSjkNyQkdqjgnqkK7w0CM2CbewxTwq0XBOXkE8C1WvA@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/5] KVM: guest_memfd: Remove preparation tracking
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, david@redhat.com, tabba@google.com, 
	ackerleytng@google.com, ira.weiny@intel.com, thomas.lendacky@amd.com, 
	pbonzini@redhat.com, seanjc@google.com, vbabka@suse.cz, joro@8bytes.org, 
	pratikrajesh.sampat@amd.com, liam.merwick@oracle.com, yan.y.zhao@intel.com, 
	aik@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 5:55=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
>
> guest_memfd currently uses the folio uptodate flag to track:
>
>   1) whether or not a page had been cleared before initial usage
>   2) whether or not the architecture hooks have been issued to put the
>      page in a private state as defined by the architecture
>
> In practice, 2) is only actually being tracked for SEV-SNP VMs, and
> there do not seem to be any plans/reasons that would suggest this will
> change in the future, so this additional tracking/complexity is not
> really providing any general benefit to guest_memfd users. Future plans
> around in-place conversion and hugepage support, where the per-folio
> uptodate flag is planned to be used purely to track the initial clearing
> of folios, whereas conversion operations could trigger multiple
> transitions between 'prepared' and 'unprepared' and thus need separate
> tracking, will make the burden of tracking this information within
> guest_memfd even more complex, since preparation generally happens
> during fault time, on the "read-side" of any global locks that might
> protect state tracked by guest_memfd, and so may require more complex
> locking schemes to allow for concurrent handling of page faults for
> multiple vCPUs where the "preparedness" state tracked by guest_memfd
> might need to be updated as part of handling the fault.
>
> Instead of keeping this current/future complexity within guest_memfd for
> what is essentially just SEV-SNP, just drop the tracking for 2) and have
> the arch-specific preparation hooks get triggered unconditionally on
> every fault so the arch-specific hooks can check the preparation state
> directly and decide whether or not a folio still needs additional
> preparation. In the case of SEV-SNP, the preparation state is already
> checked again via the preparation hooks to avoid double-preparation, so
> nothing extra needs to be done to update the handling of things there.
>

I believe this patch doesn't need to depend on stage1/stage2 and can
be sent directly for review on kvm tip, is that right?

This update paired with zeroing modifications[1] will make uptodate
flag redundant for guest_memfd memory.

[1] https://lore.kernel.org/lkml/CAGtprH-+gPN8J_RaEit=3DM_ErHWTmFHeCipC6viT=
6PHhG3ELg6A@mail.gmail.com/

