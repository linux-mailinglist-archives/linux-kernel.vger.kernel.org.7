Return-Path: <linux-kernel+bounces-741887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB0DB0EA48
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BD0565580
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8032F248F5F;
	Wed, 23 Jul 2025 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrVvFcps"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7053A20C037
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753250466; cv=none; b=rznuzPWk2Xm+Pc9yQum3i2m7dyKgG3yhdL0A+JXpywcKu6PgCHRp3DZfn0UN9HgksQiU6aAxSKxtng2qDMbWNJ2JQ/udEOpcZoSAyPAOI6pXh9kwDiz/5RQJRXnVFcqhFJUoJduPEB1cKLPnNoecyHZct4Nj3MpeRo3PlGZjNvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753250466; c=relaxed/simple;
	bh=W3OEZPSUScGaKIkoKNcKNemh+3UB9G5qvWLv5ZR7u3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOvZ/+dESflfLwAvvQ2cYtO7Pna2o8SO6heY9Yr8ID6DIKBVKrCsvLouJ2CtZf+eVtiGUuPrcgoDv/ubnsoawAeljUF7PZShoxAHqsknROcQKiMArFiSNRvSshW1n+OELob/GKNW6k+zSLnNL9ZbBw+K6P4arO7IgAKM8gbbGvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrVvFcps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753250464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3OEZPSUScGaKIkoKNcKNemh+3UB9G5qvWLv5ZR7u3g=;
	b=RrVvFcps9EniAgRVq2eZ9lN4c4MyPl5aFT3+WGLULLr9iPl/tpJE/QL2+hk3WxuMABfsj8
	rFMV/Lzhpo3PIW80sQIeEu6EKwzBOaGtxS43Chs5YLpbSFtsAUJ6tCyM/N8qHIuRWs5ihX
	JNS4YJfftmeL4jP0L3fwCJQuVjus2s0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-q23GjPkXMP66d_i_ADyXfQ-1; Wed, 23 Jul 2025 02:01:00 -0400
X-MC-Unique: q23GjPkXMP66d_i_ADyXfQ-1
X-Mimecast-MFC-AGG-ID: q23GjPkXMP66d_i_ADyXfQ_1753250459
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31cb5c75e00so576302a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 23:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753250459; x=1753855259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3OEZPSUScGaKIkoKNcKNemh+3UB9G5qvWLv5ZR7u3g=;
        b=dLGFloTPTGZlnPRS7yl6lVdWaVeXg8PNXbIPrxEdMJ3q6ySQGc51IgUj8fpXmlwNGk
         OFlvNhbqNv61qi1Aym/wqUp4LCm9jZlwsvJtjBVyVEdCbj/LN00CNhkVsU+9lw7yqQcm
         IjX17r7/AxIynDgJOLy96di8F8fawm0e1c/3Q8zH/XVMkPHaQwd29HYxmlxvGhlnyGaU
         szVVgG6bUYi2OQGIhk+WaGOBaWhTIFXV/jJPo5Q6u7HFSMuKlORyVfaww5K2lgRX/Fv3
         s+hEgv4P/As1+JEQ0hfxWAkqD0KH7kCuYp2p+Xb00LMwJHDQAnaNtwoswdHcN3biVG4p
         Wszw==
X-Forwarded-Encrypted: i=1; AJvYcCVH0hzMiI1xmr4PzBuFJmWRJPmr3s0jBW7zeE0UunK5M73mn40uu4sV8gOd0RijgSmI6YJaYIkMr3N50lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CdZ+CaPeGV3RXnN8phvBVhlbYa3Asyid1JWv+4zK1Hr723nf
	gzanXbeEeFhkgnln41nDWXdk3HlszT7+nlBLIqCx1vQscy5Wz72nF8fv8roIuMXbNXrRwJnLZLe
	fVGY2Do4CllwNuuDX9NQOgW2rAyNNpu4wq5zUs31I2xrZggXdgeG0N5r4hNo7Gd2xTX7SXFOgLH
	O6ST0T7RUgxk6p3sR1td1JNKkj6aFtqX/yAiAMS58x
X-Gm-Gg: ASbGnct9HljFgJe70P5LvgHmZC2+hKFLJPyuSOgdvxAZmeZG60kF72Uek8nblHfMe+a
	7hlRUZjGQKyp/uQXKUUtPv+ZjE3pDNXaiWuKi5gIzKMF7uWxlf8lf6rHXxupRpgXxY33mDbWaH0
	dw4IXNzk/trFKtDfXxY2Q=
X-Received: by 2002:a17:90b:1c8d:b0:31a:8dc4:b5bf with SMTP id 98e67ed59e1d1-31e3e218aaemr8741151a91.17.1753250458817;
        Tue, 22 Jul 2025 23:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfliq5NGtPU/ziGbtu8YM4b/iq3mmjjPMpvlbkNtkuESyW0l9icnltubphyWJS/Lk+K+taORz5U6WVf0EI7c4=
X-Received: by 2002:a17:90b:1c8d:b0:31a:8dc4:b5bf with SMTP id
 98e67ed59e1d1-31e3e218aaemr8741094a91.17.1753250458228; Tue, 22 Jul 2025
 23:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718061812.238412-1-lulu@redhat.com> <20250721162834.484d352a@kernel.org>
 <CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com> <20250721181807.752af6a4@kernel.org>
In-Reply-To: <20250721181807.752af6a4@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Jul 2025 14:00:47 +0800
X-Gm-Features: Ac12FXwsu5AMgm40YID7nIeVAKGIxY3SiYvCb26wbwKJM0nbVKa8OQafZHUHruE
Message-ID: <CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cindy Lu <lulu@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michael Kelley <mhklinux@outlook.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Kees Cook <kees@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Guillaume Nault <gnault@redhat.com>, 
	Joe Damato <jdamato@fastly.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 9:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 22 Jul 2025 09:04:20 +0800 Jason Wang wrote:
> > On Tue, Jul 22, 2025 at 7:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Fri, 18 Jul 2025 14:17:55 +0800 Cindy Lu wrote:
> > > > Subject: [PATCH RESEND] netvsc: transfer lower device max tso size
> > >
> > > You say RESEND but I don't see a link to previous posting anywhere.
>
> Someone should respond to this part, please.
>
> > > I'd rather we didn't extend the magic behavior of hyperv/netvsc any
> > > further.
> >
> > Are you referring to the netdev coupling model of the VF acceleration?
>
> Yes, it tries to apply whole bunch of policy automatically in
> the kernel.
>
> > > We have enough problems with it.
> >
> > But this fixes a real problem, otherwise nested VM performance will be
> > broken due to the GSO software segmentation.
>
> Perhaps, possibly, a migration plan can be devised, away from the
> netvsc model, so we don't have to deal with nuggets of joy like:
> https://lore.kernel.org/all/1752870014-28909-1-git-send-email-haiyangz@li=
nux.microsoft.com/

Btw, if I understand this correctly. This is for future development so
it's not a blocker for this patch?

Thanks

>


