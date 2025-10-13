Return-Path: <linux-kernel+bounces-851486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 402D5BD69D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9862418A252A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4631A2FE066;
	Mon, 13 Oct 2025 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LckEC/Dp"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122412701DC
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394689; cv=none; b=bhpY/m7HJOENjHEEzrLXBC7bbrN/hpaMEVlsPAsfVS6QrYVmZtm4QDqum94YVYUrfzhuYnpwvuu37sRcrHerfteVNH0bfBXYqa2ukmdGKN8YTXQ+lfl3Thq2FDruyPZUPo6f2+ouuc1tRKYTmn3dEYorBXVlHfWv2p8bi2Ii99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394689; c=relaxed/simple;
	bh=+ySgBYKp5sgJmpYv5oyU08u88544UwIMJoZQjMVM5Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxNm7Je8ZdQmzklgp7pLkJbw79odYychQVfYXetcbZl3TvzjMc2IpxltIMlf1XQqeV/l3Nmfz8NG6W3ID9WPYd9B9V8NmdsXdLyk1jJATVnXjDlxL+bLOK8HgCClDrnG7sFcAK9JY/c7ogKAnVFBWvyvlPEqApt/69XOVFVA/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LckEC/Dp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so25270a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760394686; x=1760999486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcR8QYF3LC3OedvBD3xFc4hECJtuzfDK+Smhc5CK5JA=;
        b=LckEC/DpZUdn3iSxlOAC+5XPRPkUHjC4nlO2Ou0FXFBbQxNWE/58BPjVWkfEnTvo9N
         tgOpuX4/FfcCRKBmvz0FfC2OcvqtqdpVTusX/gdLEFZSDKOi6auvEVscac6/cdW63Lz4
         9mG8nu0U3fqdwb22G9TeJLeKH0ws1oFvjz15wtGib1koWlQwUZiDIoEmwfYSVgf1eWvr
         cjb1WqqMqzD4H7CgxcTFs+KOgwFqs9XjYOhQNd4gpHQ0Xixn96LoqB3pUVQJ5Ta3V43W
         Pfqv7WGM7RTL52L891/Y6lQXrBDtUQxikcIXRQNsyXlXAU5+GrVo51MfAJyryjRYlJZ8
         vIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760394686; x=1760999486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcR8QYF3LC3OedvBD3xFc4hECJtuzfDK+Smhc5CK5JA=;
        b=oYJECAmwwJfKBvPiOX6JrtzbaqKe3pZ1HveBZ31SqkLvTK71yowZxUe17mRZ6oAsJT
         LHCh+nU/tEfZd1zxM9aANns/CBIABkjaqSi5W8Gcny8SO59jUH7VTcRYRqVdC78pHA2W
         X/w/qYfiLYacbbvrTYEGhlRzoYOJ09QKpRQnmrlOS0wmawKknAS9QXOYfVtCqB++Lqfi
         hmu34WQaCZBGkuXPEVAnG7kBwqUxGKDJcLfO2BiHeikRHOqZLl+LF2OtIiSHdatqIdPn
         VOab7vN8/mgnXjRtyMYTU8DW8+UZL3yridSdfeF/fI1MeQBHZ/wTwwoPTkW3OqQxbLK+
         Gb0w==
X-Forwarded-Encrypted: i=1; AJvYcCWsVBjGOJC897kBgyYpBK1VIl4TjWIwojcrp8MXmlk7w24YfwwGr7aKVnLh2fOF573iuiUlFqQg470cb/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSBaPPCDCkOswq5vqKToTQnpl7k5DNWGfJ/bzQVdSHHBNpcDYr
	8HB3jWAkGgyN43Tg/2ZboWGnyHU2JHGp3OWLz9qwy3eR6gbXpUhoU+HL8p0wV49QJxGGhG4pIq2
	ugtpBfiXUZQxZko0JEeIyeLhRGUpfhfEl6LCG469B
X-Gm-Gg: ASbGncvNd9a7vQCcZBr4xlVIiv5fqN1Ep0WdJ7t8ua50Br5jUkqlQC0wo/aLHvm65En
	pHVciFreqPPiiSCkr7i0d4US8ZV/izUlSfi3JVQ5cudhGcuF0u7d6B7JcgEs1Lb+CQzobkHdwDW
	hDrcgHvrN8DO47pISg4IMrTAUkDuP/Fa+L5CqmlO7XnTq61rxLpb3Uj8lhrR3GozdZPMNfGDrWs
	7ZNrU4krRKWuRuSbzWRUeYfjd+KWCjjQU0UayXWeRw=
X-Google-Smtp-Source: AGHT+IHmNmEO8UjVvewqClbQGgSN+TsvobxIhiIwo9csw6fcanDJv8mEWMQbIpvQc5+JpEPlcVIyIMZhpv/3rMzG93k=
X-Received: by 2002:aa7:d889:0:b0:634:90ba:2361 with SMTP id
 4fb4d7f45d1cf-639d52e9f0emr650243a12.7.1760394686126; Mon, 13 Oct 2025
 15:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922162935.621409-1-jmattson@google.com> <aO11A4mzwqLzeXN9@google.com>
In-Reply-To: <aO11A4mzwqLzeXN9@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 13 Oct 2025 15:31:14 -0700
X-Gm-Features: AS18NWCUVfXmqLoMJQM4_72eVGSE-rWiwIwZWPFi4AijdWXJ2AtP924z8ut-JgM
Message-ID: <CALMp9eQN9b-EkysBHDj127p2s4m9jnicjMd+9GKWdFfaxBToQg@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: SVM: Aggressively clear vmcb02 clean bits
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 2:54=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Sep 22, 2025, Jim Mattson wrote:
> > It is unlikely that L1 will toggle the MSR intercept bit in vmcb02,
> > or that L1 will change its own IA32_PAT MSR. However, if it does,
> > the affected fields in vmcb02 should not be marked clean.
> >
> > An alternative approach would be to implement a set of mutators for
> > vmcb02 fields, and to clear the associated clean bit whenever a field
> > is modified.
>
> Any reason not to tag these for stable@?  I can't think of any meaningful
> downsides, so erring on the side of caution seems prudent.

SGTM. Do you want a new version?

