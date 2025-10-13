Return-Path: <linux-kernel+bounces-851211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DABA3BD5C94
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87FAC351765
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E042D836D;
	Mon, 13 Oct 2025 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bHjf/+eq"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5632BE7AC
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381491; cv=none; b=fvjktPCo3QZlLHPURjzt8vly105t2Qji8btV81QrEPp6ph1ijv/AOeDrIZZxxJhtFqjJFkNs88azzKJuDcWXfJ/KPdklUA+2oErvyCxkHpY8ob5qq+FIXdHSDsSo6gNwOuLpvnxylGmFZw2u0LyOg1d+L+4koCGKPGLLgglEfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381491; c=relaxed/simple;
	bh=Ny01Z+tUMuPTp2sCkuYOHV58NBNOxAXF1UzukOG01P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ow3kR4bzZscPq1aS/YN3oXxu8rZXMC8eEVvctv6UfUpldVTivVNlrigENKkOP8ESAHIZQmdpGcDxnyq1hhHcYj0v8TyF5yyj416ZfpVfF1K8mOjPCx2eLaOAVz8CHsGIUS9hJ2iIVl96PqmayfxzQqJviIhr4qiwFZ2fBaj3Q2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bHjf/+eq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3304a57d842so3678318a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760381490; x=1760986290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ny01Z+tUMuPTp2sCkuYOHV58NBNOxAXF1UzukOG01P0=;
        b=bHjf/+eqj5vY/bF2BPG+IBWrL862vg9upeGqiY7tF1XTFjeL/A6Zh1nWIKT7+IR0vv
         V5ZoA3eicWyBe3LnMF7gHpr4O3nDZNgEZ2XJsctatsYUWCrfJ8M44bHY6oG5jxE8UNH1
         xeAQulsuR+SWtgw+rCkUTtZ/D+S0x5A/1c+UyuGvE+cR4Cfh7QMGwpMk1qw0xn7ArO9E
         9Y1lyUFJ0RBmMriiDsDExRMURgH87JXmvdCWqn3GXuqbBxMSVzjrPLmxzw4hP2xZiMAM
         yIz6KgAj4urgu1fjk+zI6JseZEo2ocKhHNGRC7qmNzvjWYKuXbTYP1EOhzwSCQas4MGJ
         skWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760381490; x=1760986290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ny01Z+tUMuPTp2sCkuYOHV58NBNOxAXF1UzukOG01P0=;
        b=roSDmyVtJmXKtP+qU+RSlNoLTvHWkL25M90DRjgrDoJgcTAjk2/cYEbm7EnSXrw4Eq
         Vil0/8DN5Y+zqYRTk4lsAMxQf9ocMIK5Lb/DFfc2NY6Ly9COHj+M/MXIQTKi1tUw5DZL
         e2DmHGCwh9lFjIVLnNnDDkiCGeASl8DxltZsxdlKgtjKOsqttLpw2dy+B5xLwKVIk6vX
         sH/GDBZZo1b9nbrI0Kh61KnDe9cME9VUy3sjvloInFMHpjpXS5j/LbHTq33mM+TfNTZU
         7DmJL1j9m6xq9R0bkisFCCRD3NOGu5f5lIGXX0rNtwa1tTTT/UzADopU5PAvB6Aw5GFF
         PwVA==
X-Forwarded-Encrypted: i=1; AJvYcCXrzO9FhQEvCdoOLmyF8e8EAH9Asn2GhO1JO+ljLvVyxlyt3Ir0LH8fzaSlnh8fNlSLjlw011VljoSV2xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS8ZVTCv5T4nixzWmgvha+anHZPgElTnpet0lx3/3ecVc2ms4L
	FhDQMNupgENYxAnxeW2+vRYKfHJpAtuZKekmJUvPMPcy84LBkEjhD7NdUZbTrqYYOtEGBR0d552
	oY9SoZ0Qj+cbClaWiiCqhl6JjjFMpWdwMhq4O/5PGZYpdd1Fe/qiALQ==
X-Gm-Gg: ASbGncvBY0XIqf+IyuGBYrqGBxRG1NDmJqHIB7lLL4zDQpS9Hzn12+MQurIYCjsajsu
	MvlWGgoVxuOmX/yeXhOUjQFP6w1scnAEsD6pbZ/gEwKceBjqHD738D9DfeaLnR+C/CpoZJ5c65W
	ubZxGlp4HS/lQgypOoxpobfmSVmvl+vbn93Baf1oYu5SHN69nuVa4U3NHc7HgIa/udfDLjH+HZz
	+5koQPFYBYT1VfbBICXoLsHmf4sE+Tjj2z/
X-Google-Smtp-Source: AGHT+IFMC9e/vwhBwj0ALme8Cp8fCsUdX3he4mM8zid+ESaytCdihd+ScwemDPrM3iGDaixXxrSTv0P6mAS0ElBGhM0=
X-Received: by 2002:a17:90b:4b06:b0:32e:9f1e:4ee4 with SMTP id
 98e67ed59e1d1-33b513b2d70mr33835189a91.17.1760381489825; Mon, 13 Oct 2025
 11:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926193035.2158860-1-rrobaina@redhat.com> <aNfAKjRGXNUoSxQV@strlen.de>
 <CAABTaaDc_1N90BQP5mEHCoBEX5KkS=cyHV0FnY9H3deEbc7_Xw@mail.gmail.com> <CAHC9VhR+U3c_tH11wgQceov5aP_PwjPEX6bjCaowZ5Kcwv71rA@mail.gmail.com>
In-Reply-To: <CAHC9VhR+U3c_tH11wgQceov5aP_PwjPEX6bjCaowZ5Kcwv71rA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 14:51:18 -0400
X-Gm-Features: AS18NWCCxvCqhwe_ZDUQ1QESEd77z51GhuMdOVqnR8miGtQcczLoD65PJ8boWMA
Message-ID: <CAHC9VhR-EXz-w6QeX7NfyyO7B3KUXTnz-Jjhd=xbD9UpXnqr+w@mail.gmail.com>
Subject: Re: [PATCH v3] audit: include source and destination ports to NETFILTER_PKT
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org, ej@inai.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 2:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Oct 3, 2025 at 11:43=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> > On Sat, Sep 27, 2025 at 7:45=E2=80=AFAM Florian Westphal <fw@strlen.de>=
 wrote:
> > > Ricardo Robaina <rrobaina@redhat.com> wrote:
>
> ...
>
> > > Maybe Paul would be open to adding something like audit_log_packet() =
to
> > > kernel/audit.c and then have xt_AUDIT.c and nft_log.c just call the
> > > common helper.
> >
> > It sounds like a good idea to me. What do you think, Paul?
>
> Seems like a good idea to me too.

A quick follow-up to this ... when you are doing the work Ricardo,
please do this as a two patch patchset; the first patch should
introduce a new common function called by both audit_tg() and
nft_log_eval_audit(), and the second patch should add new port
information to the audit record.

--=20
paul-moore.com

