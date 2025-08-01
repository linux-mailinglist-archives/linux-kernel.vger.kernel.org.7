Return-Path: <linux-kernel+bounces-753777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B6B187C5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BEB563303
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2122928D82F;
	Fri,  1 Aug 2025 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHK+K7Cu"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236631F03C5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076660; cv=none; b=EofK+w7kPyhNL8CFE/yvMToAhzisoKV0XOR+9/5yYXrHj4YaL8532TPe/bXjfk6CPYEQjWb6zuthapakpp0WiMEMI2bo87UokxXbr3M65P7vqBXAhpJCXXc+l2vL43vNM59c1T15aBe6UF+uVUTGXiXBo9wIyDqe9JBG81OuFXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076660; c=relaxed/simple;
	bh=Tn75XQYhjJo+TWDkRdCfnZdS3TGmeZchqZWPBeig22E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8WBlY98jeH2aABdHwpVuMcvkAm01oxJg1BmxDGELvaMAHo3D543mls10KQ3n/XI0VO0aix5pAagwyYq6hJBeuMP7OqMZtrlG93jvAzghWH4cq3Y+Prb7QrNMl2gck8NF6Md+hBxpwSl28LdqQZYVa6WaftjCtXpIIPT0NbiL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HHK+K7Cu; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso72331cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 12:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754076658; x=1754681458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn75XQYhjJo+TWDkRdCfnZdS3TGmeZchqZWPBeig22E=;
        b=HHK+K7Cuj+m86DT7fUiStpyZ5py/pKWNDGFBifxgli2bNVoJWs1jedmfpSPP6MweDs
         HrCWqp1qkNrSd0KFHsGjvZF7fBmHRqRpYB9qW1a2MIfk/UD9OMHEmNAot7lTteF2D4Z0
         LlEqa1PrSneOGuWDrMxVAi3bLwPxyLyrbkYnWfwWqoeQpTEQjb/HsnwBfzdK1ixotYRq
         jBfmFcWCdSjCpAgdXK6jtOWDDV8my+k3LyupzBXF33zpIHvasID6uGGFqeZFLDBOnl1k
         6x1xt7RDB79GNnjDJPQ4cSYXGKWImXJXWouM9SQ2aAkMu/vOu749Q10gg5Foi6aMk4ur
         9Q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754076658; x=1754681458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tn75XQYhjJo+TWDkRdCfnZdS3TGmeZchqZWPBeig22E=;
        b=guyl8OsM+SrbP96ERuSev9t50UiTOiEKnNZJedSpmkhhnYMiZ5E79Sue1k0TXz7b8O
         1pOOTrDlQrcsdEErsep32vTZtOzs4Vhxl9UUNFHYbuq2cb4DU+5/afFs3O0rqUB8bcq0
         SEzRG8fJi+8My8nghrtW9K3/r2HXN8xNCuQlG6B0fdVnPmP5CVkd90kDxhMKUi/+34gC
         Zil/DRL1iOE1FCzWg+1bhY7CULSLu4oY9b/c9bHgkWxpnJDRG9Ba0I1WZD5sSw/ywzGJ
         kiXutPKVqDCc7lCpchCtuoB1fu86SqXt1xGxru3OlunXlj+8ypBVWMaJNLwFA3TBPSFr
         gDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU07mXYGvEOyXO92ZVzfiPUwLdyFVwfHA4gqk/RDVCBOkO9H3HuwbP7VhMQ+PGHIhuFaT6loFOpXTRtmb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYq+0OdYz2ntemDFuTy9l+Z0XUzSDvx7NZPBbEOYrv7J/0uGmH
	CTEhJa9YMwxzHXIODwC3we/RLBK5L8I4nTqkyhDcrd32JI/PgR5rzkckyf6B+a4X86GUVO1xdr+
	aO+ahiYhW8mI1IftUbdh91GDD2MnSjDHLGDa+c1Xe
X-Gm-Gg: ASbGncsGltBbrEysQVsTUhrLOg+fN2MzEOTqQ9NMsh3yJ+whtu5ztV4voVDKW6lB/jQ
	MpkfxWipIUbdkvQlENkBKEYn09Nfdu0LfMw36nnF3MoH9NIAhhl3rr9ne6iUKU+c0l3gjtp/cRq
	SOhBCg1f/e858spicAlCQLpB5IQAQpV7FMDlZ3nXceTqbY1F1l4Cq2/d/hUsI0kJmES3aX4YqIA
	YsThC5+uakueYUQHUy1yMoLRYj/Gqd8FYY=
X-Google-Smtp-Source: AGHT+IH0mW5f/qmqu9jwFpseJ5sBEGT+3smSxDV4uopSaI0KwsbmE/+dq3CsqpUFK06gNcNwwYnxKt51RS3MEF3u6D0=
X-Received: by 2002:a05:622a:1984:b0:4a7:1743:106b with SMTP id
 d75a77b69052e-4af12de2691mr759991cf.6.1754076657499; Fri, 01 Aug 2025
 12:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731220024.702621-2-surenb@google.com> <20250801183833.30370-1-sj@kernel.org>
In-Reply-To: <20250801183833.30370-1-sj@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Aug 2025 19:30:45 +0000
X-Gm-Features: Ac12FXxvF4QVnElqOuim-YcXYx27wMsfO8zYCFlPV8Iub6EM4IPZ7MZ5jF-KLug
Message-ID: <CAJuCfpH+bXgm0RK=CRxD_evnwkdeqg=-hrf5dtejCMXhxg5cpg@mail.gmail.com>
Subject: Re: [PATCH 1/3] selftests/proc: test PROCMAP_QUERY ioctl while vma is
 concurrently modified
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 6:38=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> On Thu, 31 Jul 2025 15:00:22 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Extend /proc/pid/maps tearing tests to verify PROCMAP_QUERY ioctl opera=
tion
> > correctness while the vma is being concurrently modified.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Acked-by: SeongJae Park <sj@kernel.org>
> Tested-by: SeongJae Park <sj@kernel.org>

Thanks SJ! I'll include this in my next respin.

>
>
> Thanks,
> SJ
>
> [...]

