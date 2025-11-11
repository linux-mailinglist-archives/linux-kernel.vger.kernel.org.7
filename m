Return-Path: <linux-kernel+bounces-896041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77464C4F89B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3552D4EC0A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C932E6CAF;
	Tue, 11 Nov 2025 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNTMDZ08"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F262E613C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888137; cv=none; b=AJqunTXlJj+s4vpTPVCTCq6RBgEB0tV92XtwXvX7StmYYlvjssQmHJh3U1whacA482QUJs075J0O61zhSKuv0SC6NHRutWfhl4f3Wg2xBDmKsPSor1AQUcXgKizNgNVEABX1EvXo/3oNasTfTas1/0wAsf0sekYStoQnDCAhIyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888137; c=relaxed/simple;
	bh=h7FlF4BMV+arYOfntRMdetQaRIEqw8kUtvoay/VGTo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I94rL0MQ/Yd4+4wkb+pbKPKhewCT1ggqcQg7ecVAFONicA79+WPMFphoI04RHMpgMnmvHaeJoMuRALFAmJvjcYRI4UOW4c9Wxq/DAePAp/nC4VQ6pF4atD+7OjT/1hLALiqxgS04CrRJRqn4Z/Kh7yKQejVe4JJRm6b/HO5vSXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNTMDZ08; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4edb8d6e98aso45921cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762888134; x=1763492934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLdgTRrax9wnf8NiL9wgiY/MnfL0mFsQ3EVzxvRaLGk=;
        b=mNTMDZ087+fYvAGsNI8/abn4BfltilXn7gzwPhzZKVmTZWLapGjaqwaK8jEzkxjyLC
         ufhylHUyBDyCqhySDhMD5e0IRYFodOkJ+xz1vQLTaE7O5GR/ADCmyTZMisEyMEIuNz9V
         K7bkQy9/91jv44HPlIfDjw3PD3NLc0h6YaY8lIIF3g76NfGgDvAmW3q7ViKsQ/ZlRq25
         ECNjZJIoWAJ5MnX3Ilb02IjEnztAHV0DDdWCKosonaf5EkkpDP3eeNxkbWVjQvOKeRYW
         BQ3VdRhSVNBLr+K5OfIgubWsIAZmiSt7m57cwa6zlHOv75XK/+rxM9AO7ieAPjVEyidi
         0u4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762888134; x=1763492934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLdgTRrax9wnf8NiL9wgiY/MnfL0mFsQ3EVzxvRaLGk=;
        b=dg5YPV4wzwIf8Bs+JCNHJvoo++a7EZBGHKPW+yk7Qy4byTYFj0DDvTRG78l12LoF+s
         Up5Ge7aE1299a0YEJVGIpdhETAoCMbtH8qlXnh63W00bv3lEQ40EDs9y+cQKiREkhNpX
         uuwcHueQJPdfMsvP/SJr63U2FYl/weup8mJIdu3WYamoxCTmeBPrFQvlv5hj9JZM95zb
         hbxjryzIPmaKfeEbDNEvYmvFx+uGO8cEdebaFW8+pFBfOOvCWdmNymI669aoDYp754VZ
         wxSP8hu5ftOkeHH7yRsU3GoST3VbzqZn8Hy+QxUDcY2PcZ7GVynfAAIPnXcn+QcA4+XH
         K/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWYzJCFC4evrOT8eRiWDFW472PvDwjOiuK5GcKOUV+OjMlZuGdrRgTVRW2XA5/kqRB4nY6mMUOumMn43Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzwMsNV2iMRZt4wJvvc+A4fnwdCqrTyYAjsz1ylcMS/4DkZNY3
	E21b1rxj1uYKBqKYDA/BU9mo3F0y8tTB3Uc7oVHF/h4Bkj5EatJOca3a75M8t5Hn1GCIgVBsQbA
	OfptXXxv3g+TBOO84sXjSwlHbIovV/xmTRRIoEJ02
X-Gm-Gg: ASbGncu81KKt4VKo0Bp5WmEcMZmDv/+KMax2JRiD8SjifAr/dTYU9EFMnDXQ1YXuuZV
	CtY3wZEj3rbps/wFhmU6tBM1mac2idWkzBZBpjxzybCDQTqCt2gcyqLfXSLY4TLDg1wyn3zyvtR
	zO3pw2yOSBH+SKy/FjHruXJilnY7q16QePQestIhWfojurAx41YnDlkm6qOslvo5PIrJosoXBKW
	vB8zIy7yOLzQXFOfKE087BT+Kk0Wdt1x20JI4zwyYMUwlVBNtjaJLCYOmnqf31esmshrx0c6od4
	3MKvDdA=
X-Google-Smtp-Source: AGHT+IH1E1q/5syC1l2Q3IJIXeGgWH1c7T0XgV5GcldBD5DzHdN0zW5DpxbQjpBSXk/kp0HgKpCoWEmNURf73Xoky+o=
X-Received: by 2002:a05:622a:309:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-4eddc16031cmr517761cf.7.1762888133529; Tue, 11 Nov 2025
 11:08:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107160645.929564468@infradead.org>
In-Reply-To: <20251107160645.929564468@infradead.org>
From: Josh Don <joshdon@google.com>
Date: Tue, 11 Nov 2025 11:08:41 -0800
X-Gm-Features: AWmQ_bnYg_t3UYnFFfkArMajn4W_Z0J9_xfSXIedWfeXU8w2FRe0Aeb9nxTpmaM
Message-ID: <CABk29NvD4EPx_HN4DXwZLf=iyDSysgpcUyQw=3YwYiT0eKNXUA@mail.gmail.com>
Subject: Re: [PATCH 0/4] sched: The newidle balance regression
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chris Mason <clm@meta.com>, Joseph Salisbury <joseph.salisbury@oracle.com>, 
	Adam Li <adamli@os.amperecomputing.com>, 
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Peter,

On Fri, Nov 7, 2025 at 8:18=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> Hi!
>
> So most of you ran into Chris' commit 155213a2aed4 ("sched/fair: Bump
> sd->max_newidle_lb_cost when newidle balance fails") [*]
>
> And I posted a patch with a few alternative options. And while I've heard=
 back
> from a number of you, indicating that NI_TARGET (the effective revert) wo=
rks
> for you. Not many tested TARGET+RANDOM (thanks Adam!).
>
> In my limited schbench testing that combination isn't horrible, and per A=
dam
> that combination also doesn't suck for him. Chris, could you please see w=
hat
> this does for your machines with your actual workload?
>
> Anyway, here are a few patches that basically do the revert and introduce=
 the
> proportional newidle balance -- the NI_TARGET+NI_RANDOM equivalent.
>
> Also at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/ne=
widle
>
> Please all, give it a whirl. Hopefully I didn't wreck it, its Friday afte=
r all :-)
>
> [*] https://lkml.kernel.org/r/006c9df2-b691-47f1-82e6-e233c3f91faf@oracle=
.com

Initial signal from our originally failing tests shows that this new
series appears to fix the regression :)

I'll run some additional tests to get more coverage (unfortunately
these take quite a while to run).

Best,
Josh

