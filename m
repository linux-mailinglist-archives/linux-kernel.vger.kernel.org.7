Return-Path: <linux-kernel+bounces-848311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DBDBCD5EF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D8519E4157
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422292EFDA5;
	Fri, 10 Oct 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GY4TqvJd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5182EF673
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104676; cv=none; b=YUPvttWfif/4VGDErv65sJHJ+YA9xGQQQ87ZedQE0N9uyegi+I/gxpo/g1/+7+NwGA1ocTf/ndFBU2cxpdcks//W2ocIiK3WNaxl2o+KbEIiX6riLRJzUyjlNNhN7A9u3jjNc3ksHQn6+5ZWgAiFCnt6Fd04E05XYvfGM96q9Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104676; c=relaxed/simple;
	bh=WmMLjpW8k9D3Vj4lFyZiM0FU8HeMR5e01Jo/usM3Hig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNwXLMKUkOBrV6UTU38FnezD9jh06+85njg1uaXDxfBrVGfNIMvrynoTRkSrDcIQRAot4EFh5gX1vuwLymDODvrPOnjR+es0PgSbEvxPPB6OP8P/CG9k6sH3VwbUvXoZTkMFjV3kQ3h96MTRsTBg1YrD+TTJsR0W5CTyqn0WeWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GY4TqvJd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760104674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CSXAn3HygFwbaOpzUgisVz0Zeld7FaMqhQ8KH6Xb10=;
	b=GY4TqvJd3dBmZd9xrdTl1gQudUr8+7Apx79Nt2APtuSBfTPbvrm/K13bXSSiB1WqWXqeUJ
	beBdms9EGrQYK0ricbrDrZuGPVVwjT4yTbyIF9h9PcTk4BwL3M6ixciDg591RooPfSONjX
	3thlpkL4jX6FJF0dMpsNoeDJB7x+T6g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125--dMMe78APHqMT5hYwJ9Wlw-1; Fri, 10 Oct 2025 09:57:51 -0400
X-MC-Unique: -dMMe78APHqMT5hYwJ9Wlw-1
X-Mimecast-MFC-AGG-ID: -dMMe78APHqMT5hYwJ9Wlw_1760104670
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e4cc8ed76so10655705e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760104670; x=1760709470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CSXAn3HygFwbaOpzUgisVz0Zeld7FaMqhQ8KH6Xb10=;
        b=qauYl/mqtUX86cHHeULD6Us2TmrPkeTuLNTNIxkZnDu4/B5gV7DREAayYeAJdQNMQu
         rdMhEGOxacFW8fijppEbgS1Btvl537qWD0Cl/cDCnT2Yngyr5yZZeUgJESlfSEc6/Sun
         UVfg3UGjpNX8hdLIaMoUYia35fGNMKzf7ATR18Zalob4uNd1khTycoCizMG9zDs0urIW
         mIhEWmZAMtOH/k2Anrp/zoc+gzgZRR/1P2javoWbrfqrfscRZCR6OUBAQB3KK41qYqRV
         v6ZCqUOPS9c9sXI3/ghUxzRcwSERnMcssWVayuNuet3g4EMJAlT6qDjR6LQPcOj5+nn/
         Dkew==
X-Gm-Message-State: AOJu0YxwGobR1A86xYye8/N2ndi1ibBX1z0JTB3qyt65yeTuKKGouC3P
	t9E5dWkkb/RIsxexzHtdr6DodMlcSSjecWPesRGC/fzm9yAYzbOSyaNz6ZlIua9Y0NVUf5UKGy5
	iz59LHjxzVMGEKAyh3ImGvoXKgX9PY/u65Q7Tk8O/pmtsgtYGegvsGHTVi+HDobvxqTiV/wiFq6
	FIYYYuL98WiPRNI3Y428q/tEbF/a/uIhrAPkJ1QYWN
X-Gm-Gg: ASbGncvKKcmbpTBH/ufQydiRAdjLMEKvuthJlIknkxI00ugHLDTKAa2/DBqjr1a5nrG
	piMTCoHI0n/Wi1YiSR4a29htSiGk+auRiHPlukt0AAdU8KKGe4muU24ww1qBzHrMvE56vSFKHKD
	JMgemjZUdkLgJjrps4NWSzXVvvwAUgWvfV18GiY3AWe03MEKH5Iawo1y0=
X-Received: by 2002:a05:600c:138a:b0:46e:506b:20c5 with SMTP id 5b1f17b1804b1-46fa9b092aemr75146275e9.26.1760104670117;
        Fri, 10 Oct 2025 06:57:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0nYvzZV/UpgrZSIsve1rRA0msPcsLYg020u5V/WHCcwHFFt5xA47G7YOSbI1lFXf6FO5ZLsE+5y5nNR6t9tQ=
X-Received: by 2002:a05:600c:138a:b0:46e:506b:20c5 with SMTP id
 5b1f17b1804b1-46fa9b092aemr75146085e9.26.1760104669691; Fri, 10 Oct 2025
 06:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009082013.1331361-1-lzampier@redhat.com> <20251009082013.1331361-3-lzampier@redhat.com>
 <9ae53c6d-613b-4a25-b672-88ffabfef4fa@kernel.org>
In-Reply-To: <9ae53c6d-613b-4a25-b672-88ffabfef4fa@kernel.org>
From: Lucas Zampieri <lzampier@redhat.com>
Date: Fri, 10 Oct 2025 14:57:38 +0100
X-Gm-Features: AS18NWBKt45vJ_tgZM0w0Qd10JOQmvNvfOo1vp2NkKU9_HUvebFUX254BfYm_oE
Message-ID: <CAOOg__BTJw53uTK4h_o4GK6x2D0XutTSQMpb-BDXh22Ac0-q-A@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: interrupt-controller: add UltraRISC
 DP1000 PLIC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Charles Mirabile <cmirabil@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 9:39=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 09/10/2025 17:20, Lucas Zampieri wrote:
> > From: Charles Mirabile <cmirabil@redhat.com>
> >
> > Add a new compatible string for UltraRISC DP1000 PLIC.
> >
> > Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> > ---
> >  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml        | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sif=
ive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controlle=
r/sifive,plic-1.0.0.yaml
> > index 5b827bc24301..a419de50f5a8 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,pli=
c-1.0.0.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,pli=
c-1.0.0.yaml
> > @@ -74,6 +74,8 @@ properties:
> >                - sophgo,sg2044-plic
> >                - thead,th1520-plic
> >            - const: thead,c900-plic
> > +      - items:
>
>
> Missing SoC specific front compatible, me thinks.

Right, if I'm understanding this correctly, I would need to add the
sifive,plic-1.0.0 fallback compatible to indicate register layout
compatibility. However, the DP1000 PLIC has a claim register hardware
bug that breaks interrupt handling without the driver quirk. Should we
still include the fallback even though the generic driver doesn't
work?

>
>
> Best regards,
> Krzysztof
>

Best,
Lucas Zampieri


