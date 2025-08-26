Return-Path: <linux-kernel+bounces-787085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08D6B3713C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF21036001A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AFC2E54A1;
	Tue, 26 Aug 2025 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqfI5FOU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4352E3AE6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228871; cv=none; b=hMI3UKLHxVKDYoAqdNrN/p7jqcOYNCvlQMTcVnmvVlnUEKOWdV7wc0ocwDR7MCt7ob5zJJOsBuRSvwXK42Rg5KZqq5NN6PVsUiY23x2DQkTHf62cyqwDixLLAikLYzbrICyIzc0FK+giFLAjiOBwk1HsjgIo5mgH+1/vLotIF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228871; c=relaxed/simple;
	bh=ObpM4zfxjeNqLpjh6zKTISSq/zqH9nAe3Gg+D1X5idY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hE6XcwwLAf+KcwwgtkvUtjRAycqNJcac7t5EVkbV38D1RXbzOq7mXpgxwARodLk/bSTRxNpyleG9+xvrIGNImWWU3tfr40Sq9OxPbcDZS5wMrHYZB8CBebpVf1bhx3zenJ9hzQ4J0UUP2jjWsmWhqZ3penRduoiP+IWcHk5f3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqfI5FOU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756228869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fixj3Stcqv3YSb/G1fSDEpAaxUmrXH3yvg6FMQ45Vtc=;
	b=eqfI5FOUowe1supvsPw6bcwnwrqeU+AixjavXyuvsYa6tTlsU+oFV72ad2wChIrHGOCI/j
	pfpX8JU/sSANLk/m4KzRuglua5JgtyVHpXUAOK5WQcp1eu3n4qcPDUGffRr0WDPiQJxggd
	Nzo+8jgF9iWB9sMlICe3ss7AEAP/59I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-96i63Ek0MK2sQGpxeGOXug-1; Tue, 26 Aug 2025 13:21:08 -0400
X-MC-Unique: 96i63Ek0MK2sQGpxeGOXug-1
X-Mimecast-MFC-AGG-ID: 96i63Ek0MK2sQGpxeGOXug_1756228867
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0caae1so30249195e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756228867; x=1756833667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fixj3Stcqv3YSb/G1fSDEpAaxUmrXH3yvg6FMQ45Vtc=;
        b=fNAP60KSVNYqiq/lYC2wM4CFn05Q/bMyRFuId2oYCsnMuERWL5X6h3FK7U6UjkpOaN
         SB0dIEnmRrhRa3nip8DKXahcqZPG6m9e8M/LaJPzBr2OgbU7gUWccVS1mbG26Q1jT8oy
         1iBn4/HEc71hURzIni0IrujoB3k2325irBEjXUGXnkkHZa507DT1SgbY4BJk4xBC8C0G
         QVjVsLwT7Iv0143tYiJHdX71gA529o8QNP1XayLdYrjH2Z4ZoV1k636nAC0Hwu3NwV/3
         s4oUJuy7CBPKlufdjcrhZCm2p0L6z2DEpVYlXbqQ1QcqwCztf/ZYSchynQKqXm22MiYC
         KzKA==
X-Forwarded-Encrypted: i=1; AJvYcCVEXMqWXidxp9TsstFIsF/+GiQFGd2J6C4Us4ffMqXmFftkKmDjc7a12QqBOt95PtHH3+Nf+8DSX6p0gHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7NzwJm9HGVdUuTw8fFZQJewZp9q6v0QmutewblrBi1nMq9CT
	sX/bodZs5l1huG8666m0mPLj2uJ1xB5V9ETWqjYsFbN5+m2auJKUdey0IeijlRvghgsHJhaNKiC
	fQEWdwwyIh+k576ZT5NnjQtSBd/PuUBG8SqJiPuTtj9LIhLEMn3CrZMWhXBW0+4nFuwGA3El4t7
	FmWelT87xBg1+JsY5dcv4OTdajB/aSx7Z1p7VQA3ea
X-Gm-Gg: ASbGnctEBn1e6WbyMsaTY4Gm4OvrCrjnRisTtPCdFWEjCJKmvQRrA2py7NIyg9GcwVs
	iBp9MTP4sivSVH+D1w3a95abr+v243Ik1HL4CW/eOnC2Lz7b/gbUxgJDPk6k0DxM03+oYkSNBZ0
	T6rFzAGEW8NlbVDaDc2o0EH/vX57ifH0TzhelQKU5i0cfVIS42Nb2RkXuIlK04OMkkxiOQnGz0f
	mTU004M3j6Wa8+jNX81qbVK
X-Received: by 2002:a05:600c:5494:b0:459:94a7:220f with SMTP id 5b1f17b1804b1-45b517dd998mr127408185e9.26.1756228866784;
        Tue, 26 Aug 2025 10:21:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQK+UMrmTalA/0yt5zGTuiTwqwEKe+V5z92y/ayCCHYPF/64dT/Zz/jRg3RjoAUNG5Qs7uJdCqXDZ8Y/3DTtM=
X-Received: by 2002:a05:600c:5494:b0:459:94a7:220f with SMTP id
 5b1f17b1804b1-45b517dd998mr127408025e9.26.1756228866380; Tue, 26 Aug 2025
 10:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756161460.git.kai.huang@intel.com> <14f91fcb323fbd80158aadb4b9f240fad9f9487e.1756161460.git.kai.huang@intel.com>
 <aK3qfbvkCOaCxWC_@google.com>
In-Reply-To: <aK3qfbvkCOaCxWC_@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 26 Aug 2025 19:20:54 +0200
X-Gm-Features: Ac12FXyzQ1leHRicGbaeNR93onBSfmUg8YaGLjd2_nEWUKqlyFd7oqoW-3jonEA
Message-ID: <CABgObfaZjcDvFVWO7rsr2e_M=F6r=sEq+GHjtEp04uhj29=MuA@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] KVM: TDX: Explicitly do WBINVD when no more TDX SEAMCALLs
To: Sean Christopherson <seanjc@google.com>
Cc: Kai Huang <kai.huang@intel.com>, dave.hansen@intel.com, bp@alien8.de, 
	tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com, hpa@zytor.com, 
	thomas.lendacky@amd.com, x86@kernel.org, kas@kernel.org, 
	rick.p.edgecombe@intel.com, dwmw@amazon.co.uk, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, reinette.chatre@intel.com, isaku.yamahata@intel.com, 
	dan.j.williams@intel.com, ashish.kalra@amd.com, nik.borisov@suse.com, 
	chao.gao@intel.com, sagis@google.com, farrah.chen@intel.com, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:10=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> Can you add a comment here to explain why this is done even if the kernel=
 doesn't
> support kexec?  I've no objection to the superfluous flushing, but I've s=
pent far
> too much time deciphering old commits where the changelog says one thing =
and the
> code does something else with no explanation.  I don't want to be party t=
o such
> crimes :-)

I asked on the review for v6 to make this conditional on CONFIG_KEXEC_CORE
with a stub; Kai said he'd rather not and I acquiesced, but now it looks
like we're going to need a v8 just for this comment or to follow that
suggestion of mine, which I still prefer to a comment.

To be honest I've never felt so frustrated in ~10 years of participating
to Linux, and this is not even *my* code.  Not your fault though.

Kai, if you're also frustrated I can handle the v8.  As you prefer.

Paolo


Paolo


