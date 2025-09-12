Return-Path: <linux-kernel+bounces-814008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558E8B54E39
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6871B188FC26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CA03043B3;
	Fri, 12 Sep 2025 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW6D4zKl"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0BF27E045
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680539; cv=none; b=HHkZ2EY5tiU21rPosDOJaQ8lV8oO5drG7Na4LWCzXKi+gvKECqXjTiwgwqftMnlkPV9360Zny5VSDrEOeXlWpCX3p4P+3t/Pmk+elGwiEwmk/rraVD6wp4RLbeuXYYp3TP3pBUySi/2eItidjS0RMiiERuhoGQrUU7qW4Zatlic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680539; c=relaxed/simple;
	bh=Tj2+e83du4vC4DcQ+WEChWjKDbfxZ6nCt/evqIC5u40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctLr3AGpplDSMSOJORqoO4iKtddUMgaz5rRN0CrbyUTlccyLSxDgDruZOLzeb8tvzKMnzm8ambGOeCwzQ8vBBjqUspVFdRc/0/7iPXIQOnEx6I9FGCfiQpmMVlAX4MXrUf6cG0fOWBxHFE/25sEM5n86+vmMYrMysvgPoGi61Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CW6D4zKl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7741991159bso2742607b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757680537; x=1758285337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9JiQChWbox7CofESJhE4xi9hVI02nwJJqT2Ui2FNY0=;
        b=CW6D4zKlKd1R2CERax75KozKtOYEiZaN8ATGM3mXR3Yxq84ER2FpzYXNZGcOVsY5eN
         7uy0b8fAgj7ZPepqIm6+LTCHUz2cbgXvuRk5U6HRebTELAksQTatkjP8kIvnNQVxOUbk
         ISSqSa0KBQNY9Oh0Nls8PjbxXVaE/Ru8jZFNgmorjn09/XKnDksocn5T2OWeqwg82J5t
         24Vo5vjhFMdz4hKfa+5uqecSBF7N+9WgwjFABj1ZqjbYhQrvN0rtdgIZ3QRPAnLzWCQy
         fBekNT0+Ddn4FGBN4KepizBHqae8Jb1shTgVH7pMRHphn9lnwmLKwARzcfHxE817KvAd
         Tc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680537; x=1758285337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9JiQChWbox7CofESJhE4xi9hVI02nwJJqT2Ui2FNY0=;
        b=VrQKQdPI3TemnShUI5npyEKapk6IZbVEfzafl/5rYKcHaYO812QlzlKTHpRTzqKcGX
         sy9qnFCl2gG6EOntSQEz9JlKB66QEW9NuCeK+2/T3WDyGNKvT30HOQGbbNQo8AhwcSTy
         ClhU/XpYKCMxagoXq+DHg4vM2fUiRGFbbVfs5Ax4NeHJookYfiTocS/YYZc01/am9xzX
         QKHFf+9las9eHmCpcl+XBqVutG4h5DzuRuYA1TRxZPDzt85C4ft5YrQOMt5e/FZlWegR
         2q9h7i7XVMV6837WGqOZ4NH3ykgqBsRPuob6zTzIja38aXIgKXcmlaZqI0M/ZWA2KWDg
         1HrA==
X-Gm-Message-State: AOJu0YyF66k8b8m7589t82SeVKeByROUNoVVTyQVJtuwddNuytVYqk6D
	3Dosm2HDCQYO/6lt5yBvHx/bkLQgVAAaqLy/AXrfwekVc3v8P/UeWLFh5UBkHtzxxQe2LJanXHo
	rL6A47Qt3Y2bK5/mEK9Yv4lkRHb++vGo=
X-Gm-Gg: ASbGncv/XLaEnphVGSFnbrcG0hkYDVZVeWQiM2heh5ThAOnay+MLR63pAtOavpKnNVa
	dY/mbrlyAzO2mECfZRIN8v95uMxBcaG8e+CvT1vkFYU3cJQWwdqOkj4o2SUbZLxqnQuXXEqMbjh
	k2g6SaoMK5h8ysHfY2fKu7agM0QIm683zaIzlxTWpX48zQQ/3H4wViW0qrVdDNpo+PA427hayZ6
	jM9tOE=
X-Google-Smtp-Source: AGHT+IEQx1PETSfMB/6QLGHuYxCf5yh/1hM526+nvA7AYVYQddNTgpSwAE2ETgu3zPA51ZIJcXY8WaU5282fceEbiAg=
X-Received: by 2002:a05:6a20:939d:b0:243:78a:82b3 with SMTP id
 adf61e73a8af0-2602c71d516mr3395424637.59.1757680536658; Fri, 12 Sep 2025
 05:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4naa66Aum5YO0jntY5-reXxF5Z-=JYTcmb7WFCBODAHg@mail.gmail.com>
 <20250912105939.1079014-1-zhanghongru@xiaomi.com>
In-Reply-To: <20250912105939.1079014-1-zhanghongru@xiaomi.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 12 Sep 2025 08:35:25 -0400
X-Gm-Features: Ac12FXx0D1xfyO9B8MbVlqQnGLXE8gX4XRYLx_eQw493PStSRkAcgif0AwZ25zQ
Message-ID: <CAEjxPJ72UfNaPC0QXW61ENzCYLRUuYQCXeVxir4UFj4eP4PROg@mail.gmail.com>
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 7:00=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.c=
om> wrote:
>
> > > > Baseline: 512 nodes, 512 buckets
> > > > Comparison: 8192 nodes, 8192 buckets
> > > >
> > > > Metrics (Average value over 1800 samples):
> > > > * Bucket utilization rate (higher -> better, same chain length assu=
med)
> > > >         * Baseline: 52.5%
> > > >         * Comparison: 49.5%
> > > > * Max chain length (lower -> better, positive correlation with wors=
t-case latency)
> > > >         * Baseline: 7.5
> > > >         * Comparison: 11.4
> > > >
> > > > Experimental results show that scaling buckets and nodes from 512 t=
o 8192:
> > > > 1. The distribution uniformity under the current hash algorithm doe=
s not
> > > > degrade significantly;
> > > > 2. The maximum chain length rise significantly, potentially degradi=
ng
> > > > worst-case performance (ignoring other code in avc_search_node func=
tion).
> > > >
> > > > Details:
> > > > url: https://gist.github.com/zhr250/cb7ebca61ff5455098082677d75b179=
5
> > > >
> > > > I will modify the hash algorithm in the avc_hash function and colle=
ct data
> > > > again to see if we can achieve performance improvements.
> > >
> > > If you look elsewhere in the SELinux code, you'll see that others hav=
e
> > > been converting other hash tables to using the jhash functions, so ma=
y
> > > want to try those here too.
> >
> > Or you could follow the example of ss/avtab.c which was converted to
> > MurmurHash3.
>
> I read the code of jhash and avtab_hash, it seems these algorithms are
> more complex, with higher overhead compared to avc_hash. For cases with
> a large number of nodes and limited number of buckets, the benefits can
> be significant. However, for scenarios with a small number of nodes, the
> overhead may already outweigh the gains. In my case, 8192 nodes are
> sufficient, and I'm not sure if there are other cases with higher
> requirements.
>
> Based on the 'Max chain length' data I presented earlier, if we want the
> hash operation and table lookup to yield an overall performance gain, the
> overhead of the hash operation should not exceed the cost of traversing
> 4 additional nodes (11.4 - 7.5 ~=3D 4). If measured by
> 'Bucket utilization rate' (~50%, means average 2 nodes per chain), this
> overhead should not exceed the cost of traversing 1 extra node. Otherwise=
,
> even if uniform distribution improves lookup performance, the hash
> computation overhead could still degrade overall performance.
>
> In scenarios requiring a large number of nodes, it seems necessary to
> optimize the hash algorithm to avoid excessive bucket allocation for
> maintaining performance, which would otherwise increase memory overhead.
>
> I will first refer to the avtab_hash code to improve the avc_hash
> function, and then show you the data. I will collect the following
> information based on several different configuration using the same test
> model:
>
> Baseline: 512 nodes, 512 buckets, original avc_hash
> A: 512 nodes, 512 buckets
> B: 8192 nodes, 8192 buckets
> C: 8192 nodes, 8192 buckets, original avc_hash
> D: 8192 nodes, 4096 buckets ("large number" of nodes in limited buckets)
>
> 1. /sys/fs/selinux/avc/hash_stats
>         a. assess the effectiveness of the optimized algorithm based on A=
, B
>                 and Baseline. Expect bucket utilization rate: A ~=3D B > =
Baseline.
> 2. total latency of hash operation and table lookup
>         a. A vs Baseline: expect A is no obvious latency increasing
>         b. B vs A: expect B is close to A
>         c. C vs B: expect B is no worse than C
>         c. D vs C: see if we can save some memory with no obvious latency=
 increasing

Thank you, looking forward to the results. Fun fact: the current
avc_hash() function logic hasn't been changed since SELinux was first
merged into Linux 2.6.0-test3.

