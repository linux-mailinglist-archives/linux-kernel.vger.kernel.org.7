Return-Path: <linux-kernel+bounces-797044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A74AB40B0D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBEA17DD77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59614337697;
	Tue,  2 Sep 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVxktnQU"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352EA31AF24
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831820; cv=none; b=WCeXnI4uwrkz8uC2Vm8++1lzMwtQi/urxKzc03oFYDP+msnay9pqkOIhVT/EtD7TdkX9/1On7ng+2PTqA+s70qjcM3G7RKzsoywOIDnx//rvq068FPCSHgydtRrPfqVubnOxRZ2qtm7OFcFa/mmE7/4IoCV/j4vpv99fLVU48/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831820; c=relaxed/simple;
	bh=6RIt17l6rtvY+nJ0OVVe8xaeq2YQCf529Qu7R8rBWQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HF5cFMoqiAME1ibu03Ce6we17woW1yiJlmYo7NBN82A8H4nmJq20suzsHUThZjSW+Q6ZqDrG1FoCWwIhDrOxPl8m1VYbpjrJkurkmQNPtmeOVeCmnKpilC9Y/aQ1UbMb1t3FVvtfiLwECyDpo3smQnnma1+pAv0E7TnDZxE4ZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVxktnQU; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b327480fd0so16961cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756831818; x=1757436618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSyrafM1QcRv6+/JfnS79ZJ1CJUifDSEbVFOqe4QmfQ=;
        b=iVxktnQU/yyZtqB1mdae3VmF0wyDDvDDqcx1s1j0PTIexofEpiSA718bzBpKiOX6w8
         83lSP+TyZqilKHdJ10uEg3P9ERWyc32e3OLf8Tu9TJseIuLxF+EwcAyA0o6f+8EzAM8A
         OqUK7qRzAbDZFNNvLboqlkocnmQbrXGimI9HCJF3a51xpqWANjGE9cNioMyzG7O7VYPA
         47uHqbzkTjlwCfjJcJUxZ4SAwpLOgssfan37jzxc1IkO/8t/pWV+Hb9ExJew8Bly/QUg
         Wmq3Ty5aUZKrWED3sDSDWgqYBfsifpLvN0scFj/qnM7NjcTevkUFrwMSUqbXdu6HNRDb
         l+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756831818; x=1757436618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSyrafM1QcRv6+/JfnS79ZJ1CJUifDSEbVFOqe4QmfQ=;
        b=MMLAfk7U6Sz127NK+uQ0Ir7BWoUVJ8snFrjjjIHku5D85GfjAI/AdQ7QE0PLHCPpzN
         T2/yfEogR82S4Zx88uLI/WETCZHgtz+Ezq2+912qYfaaLnnRaf8ZGsK6epiZiLbMyI89
         BCpR0YgrpZR394Y/AbC8isL+wJVN65Zo9shv5hGyOIER61YczgNkcGxCHiV4xygk9ocx
         DOPt4cPOJEVe1SY0kv1seDfFhMAlyaJp56XLbUhxjWhj/0BeweImkIHsd4bJjU20D8z9
         xGDJhQMOEkXOuWmwXQgPgyeIXIPVjJBUTU6WM+XRqtr93cILEXqZcr1tM/jbDLs2RTac
         0ItA==
X-Forwarded-Encrypted: i=1; AJvYcCVuTzIfMMMHD31ytNC8oBMmJiXn8GMtzaVp+VFuz2rx+K2y+OMgH4ePWEyQ9uvxS1LhucZqf4uMIPOu9jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLpXjVFXjdcsz9u5imFxoSLDtIuX+i/0dtbek9+q9fQU8qlBfO
	lMngpOEVw8xMYibrQFSkLjW/wKzrzVlVvpJmW5mISov90talUnGnvQL9NdSNkWoydi3ZJR+QdRz
	fTLl/JeMsdULhNqwuvaRMfrgJAEmLWu/xMizzLIdM
X-Gm-Gg: ASbGncu+LHD1fpcoHjRX3OQeuTxmGlM7/m9CgHS0dPZU6K9+ci4A7iOHf943Fg1/k6z
	cOIoerVSMgVy7LhoGUEcfJy85FqKRzpPPwhZRmrXVFfR04UQNvUYHSxoA6DSUgPO++thf0+FLsR
	Tv3K4JBzZQLt7qLQYNlKHdrLoaYOouROeS7DL6t8Fqr/mqXVFJepv+VJTezYB8zAXhPhcn1VzyR
	s795YQSKUkE8qf/0CXnXEwAmqKGwHn/R1V/AU6RMQ0=
X-Google-Smtp-Source: AGHT+IFZRZdIhfajnXhlEKBqcpQ9ut7xCYenusy5bPozjAHfG8pzHkYfdT7cPUFCcvttQ5R84/Zpo/4ZOtaDR+q3ZIc=
X-Received: by 2002:a05:622a:a28a:b0:4b0:9c14:2fec with SMTP id
 d75a77b69052e-4b325008444mr11392681cf.8.1756831817870; Tue, 02 Sep 2025
 09:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831150710.1274546-1-harshit.m.mogalapalli@oracle.com>
 <CAMuHMdXSNoXjxAbALr7O_dD_btJDGR58XaDa5=bd8NmL50wcaQ@mail.gmail.com> <d2a5b07e-2da1-47f0-b2cb-a4ffa12a99b0@oracle.com>
In-Reply-To: <d2a5b07e-2da1-47f0-b2cb-a4ffa12a99b0@oracle.com>
From: Rong Xu <xur@google.com>
Date: Tue, 2 Sep 2025 09:50:05 -0700
X-Gm-Features: Ac12FXynsWsvMltp57ATRpCXmM0Uhwu2CvmIEafU2UjtQeosXaKLslnu08g_VGQ
Message-ID: <CAF1bQ=TB6KMAkwXfEF=ZJvJZqV8B9kEw3jbVMG4gRoLOUjksiA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: dev-tools: Fix a typo in autofdo documentation
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Han Shen <shenhan@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the fix! I meant to include "/" in the original patch, but
I overlooked it.

Reviewed-by: Rong Xu <xur@google.com>

On Tue, Sep 2, 2025 at 6:03=E2=80=AFAM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> Hi Geert,
>
> On 02/09/25 12:43, Geert Uytterhoeven wrote:
> > Hi Harshit,
> >
> > On Mon, 1 Sept 2025 at 17:57, Harshit Mogalapalli
> > <harshit.m.mogalapalli@oracle.com> wrote:
> >> Use cat /proc/cpuinfo as opposed cat proc/cpuinfo.
> >>
> >> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> >
> > Thanks for your patch!
> >
> >> --- a/Documentation/dev-tools/autofdo.rst
> >> +++ b/Documentation/dev-tools/autofdo.rst
> >> @@ -131,11 +131,11 @@ Here is an example workflow for AutoFDO kernel:
> >>
> >>        For Zen3::
> >>
> >> -      $ cat proc/cpuinfo | grep " brs"
> >> +      $ cat /proc/cpuinfo | grep " brs"
> >>
> >>        For Zen4::
> >>
> >> -      $ cat proc/cpuinfo | grep amd_lbr_v2
> >> +      $ cat /proc/cpuinfo | grep amd_lbr_v2
> >>
> >>        The following command generated the perf data file::
> >>
> >
> > One might say the path depends on where the proc filesystem is mounted =
;-)
> > However, all other documentation (except for two occurrences in
> > Documentation/networking/proc_net_tcp.rst, which you may want to fix,
> > too) assumes /proc, so it is better to be consistent.
> >
>
> Oh very good point, yes I did check other instances and thought we make
> it consistent.
>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
>
> Thanks a lot for the review.
>
>
> Regards,
> Harshit
>
> > Gr{oetje,eeting}s,
> >
> >                          Geert
> >
>

