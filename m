Return-Path: <linux-kernel+bounces-873471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56000C13FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B1A44E67A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152DF3019C6;
	Tue, 28 Oct 2025 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ov0SiEeX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBEB202F70
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646084; cv=none; b=IoNnBUQWgP7r1hzyC5cXUgNxye7L2Hm7ZRYzfQZsxR3j3dh0cXvkNbh7BAHsgx0KrcjOEfs0MTNRiquEStBgVShJTEQflisjU1tGxd2GU13GqXHu4796luiEwcw/1vVb1dHObUyyKz6rC7233yGqh7evVSjtWufsIeWtpu1+dvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646084; c=relaxed/simple;
	bh=GqS5YZgkq8cny8rkJuSXt0cOfrho4136xi4TMhibHPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMC2PhVWzPvKo82fC8ueQFssQtbKSLBURqWND5NlFlSuIizOwm/XuHs0H9cGXRNfTSUIvqCK02yHDGLF3G1TxB/SgvjgmGw5CpzrUQ6LlbDNJmJ2NifJWbmdkVkVAtPS/gqjIKtwpTpHpCxjPWbIkyE1CNL8Mast8h8ubr2zZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ov0SiEeX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761646082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xj8LBCzX8LJmWzMdp8W85zEkAFig7TXNyDoN0MesWYw=;
	b=Ov0SiEeXSpwTws36tv2XS3MmjbuhsA14n/D6Ouj//K2U7+Y6hrWzqVq+wYKItQVg+wdKZA
	JmWA51KHr5rUxmq2c51jwQAnqF7O0stAHAAh/jlY/QiK5SGtwnDRoInDYiCJhSx649qsrE
	Hfb98iySp8SIlRAfE9ORloGsCNmtVhc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-bM414wL1PAmA5_3OJs3tTQ-1; Tue, 28 Oct 2025 06:08:00 -0400
X-MC-Unique: bM414wL1PAmA5_3OJs3tTQ-1
X-Mimecast-MFC-AGG-ID: bM414wL1PAmA5_3OJs3tTQ_1761646080
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-785c67bec06so63388247b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761646080; x=1762250880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj8LBCzX8LJmWzMdp8W85zEkAFig7TXNyDoN0MesWYw=;
        b=slYOi9jvfMotaCcrj2mQ5D0EJdR4bBdSGeg5luPV4YofUGO3HNtNxSUsZOJhGGR3tZ
         lCv55e6mY/Q03iowHBI9/EhoNnYR7a/T8kPs84maOi81TK80PTyTcMfYx1MYduPamYZD
         dqsccjl8o3RU9ilZJFvY0QPw4+2HJMRPlvreHS2nmxJLM+0DvHUg1gCp1IoX1tDY2V6v
         q7nPiWixDQbFWAsNkFqJR6QHueR306PgoJIt7AjvgQpPY2XPUoNZJhT1HMPfwXBOLNmN
         f2WMIEKL/qz5cdH6m6XJAKiDf21OR/c3sqFYWnNuQG+vQyq9h0zQTDiJtivF0dPqP0pO
         jACw==
X-Forwarded-Encrypted: i=1; AJvYcCXKVyOoovMHDJojZKb1q0UZgZI0Peu6tjdo5j9SQVOhYQNIHA1g7vswp/heR/7lJgxyGTTlHERbfjG9sbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR5m9n6INrRpUwmx2ws4Gr/+Q3yWzLWyUFQiiqw9WWt6mDKLSW
	P/DH8RoIGz4kyaji3C3lJrGZ5buRm05X1yzRCSMknxwEgmfMXoXIiLn3KLi4iOIt/FNKFd3+m1/
	CisRebQKSfGSnykJdlThKMfWb/Aj6++RvfzMOOA4TaRfXUUa6OJdx3Z8JOr3o+81s3RdR49TfME
	qVnBoMeTvZlUCyfKCQkBJfqj/an8NjfRXgvM9/S/FQ
X-Gm-Gg: ASbGncvELmO+Q4aIL4+1O+AFEE10LCfFChHd7aO9JkTbdgzqgjAogDDXoO1Pw8BdvKJ
	IB62d2/FsyX8x6zWgSMuawk1nSYvdqrwjQIdj19TbmpD1cH0nDYi2KpuF/OIvCpIbfQcbV7qw73
	u3ZORT8nJJr2wWpml+akBTal8vUmH7Rh7AIkhHBX3oB5RgUVrbPqZNTg==
X-Received: by 2002:a53:d007:0:b0:63e:22b1:21ba with SMTP id 956f58d0204a3-63f6b92f77fmr2414445d50.7.1761646080108;
        Tue, 28 Oct 2025 03:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFx/GfvxsfTd+6dhGpIu93wCMrLMghQK4gRq00glwICMhgo0YRDanztGVVvNApzngH11UOdDJf/aBvqoRGVMg=
X-Received: by 2002:a53:d007:0:b0:63e:22b1:21ba with SMTP id
 956f58d0204a3-63f6b92f77fmr2414424d50.7.1761646079789; Tue, 28 Oct 2025
 03:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027110041.426022-1-hsukrut3@gmail.com>
In-Reply-To: <20251027110041.426022-1-hsukrut3@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 28 Oct 2025 11:07:48 +0100
X-Gm-Features: AWmQ_bkz6SxHJddTnDiI4TmSykmKugAy99eWur8qPyHRD_vTfTlIvGnmY06clos
Message-ID: <CAHc6FU6FanLe+b9RX=Lao2MQ2JOJU3JKNOsTTX3NUzNNzWfuAA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: document ip in __gfs2_holder_init kernel-doc comment
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: "open list:GFS2 FILE SYSTEM" <gfs2@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, shuah@kernel.org, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 12:01=E2=80=AFPM Sukrut Heroorkar <hsukrut3@gmail.c=
om> wrote:
> Building with W=3D1 reports:
> Warning: fs/gfs2/glock.c:1248 function parameter 'ip' not described
> in '__gfs2_holder_init'
>
> The ip parameter was added when __gfs2_holder_init started saving the
> gfs2_glock_nq_init caller's return address to gh_ip. This makes it
> easier to backtrack which holder took the lock. Document @ip to silence
> this warning.
>
> Fixes: b016d9a84abd ("gfs2: Save ip from gfs2_glock_nq_init")
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> ---
>  fs/gfs2/glock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 91d0afec4087..bc6f236b899c 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -1163,7 +1163,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number=
,
>   * @state: the state we're requesting
>   * @flags: the modifier flags
>   * @gh: the holder structure
> - *
> + * @ip: caller's return address for debugging
>   */
>
>  void __gfs2_holder_init(struct gfs2_glock *gl, unsigned int state, u16 f=
lags,
> --
> 2.43.0
>

Applied, thanks.

Andreas


