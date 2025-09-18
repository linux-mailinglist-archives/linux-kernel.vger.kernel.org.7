Return-Path: <linux-kernel+bounces-822328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BA4B838BC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD5A724493
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA15D21CC4B;
	Thu, 18 Sep 2025 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHCO6IPE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A652F362F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184590; cv=none; b=bm9OQZua0d1LQIBqo28DWjbVutd+2FFvZF5PgJsOnKrITQ8du8BExoKEgcOj2ffIEj7rlceM3lrgMhVrf/yheo0yuNOkvcIyD0e61LZIlRtTE/WxOnHzp8nruC9ptDhEqL96pgo2JzWPNYFrcmSUR3eTwRvQiY3jgibOwpKcsqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184590; c=relaxed/simple;
	bh=Rlr84JJZ62/Nuxw2Fu9RYG036Nc+e4UQUaz7yZ8stIA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CNZ/rOm/IZYyMJw6oxgCwDKqxD5qpwxyal1drXccbzxRw9Q4PsorC8cZVZqUxiVS0hywC63CLXdmaRbpmKXQbgrybT8BfYj4aMyPyTF01rr9FSJQRmFhTkwdBqdAitybk+sBSdneMJXAvcaOM1FPfNAQrZhLBdDVT5oOkFaAvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHCO6IPE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758184587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rlr84JJZ62/Nuxw2Fu9RYG036Nc+e4UQUaz7yZ8stIA=;
	b=MHCO6IPEhyahWBd7lI6xskyMLvJwmrcLGjIyRmuoXMaMXpqFBxn24CuluFD0ZN7BnDWMq8
	Xz1Sn11cmr46Il8UoYJ+0KPgpTVhDXu/Lv25Q2F/ZDwhgsuDcoFj3hmKoARxaNEGbHcxVE
	lVI7V3KB1CQ7t7bAIuZ9moAbUZViqYY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-BIoHUlW9OUaFQ_vD9iv1GA-1; Thu, 18 Sep 2025 04:36:25 -0400
X-MC-Unique: BIoHUlW9OUaFQ_vD9iv1GA-1
X-Mimecast-MFC-AGG-ID: BIoHUlW9OUaFQ_vD9iv1GA_1758184584
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b920a0c89so2805155e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758184584; x=1758789384;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rlr84JJZ62/Nuxw2Fu9RYG036Nc+e4UQUaz7yZ8stIA=;
        b=bqeswsaB6KQQ/Hp/gDkgRS1OrbNaM7LvC/ZvBI80ShKZJs8wx6ryatO+dSPy+7JL+E
         tjRUKckY+T4iKGiwTowCW2ufAQxdCoSEu6fuWuBpSe0ioUCpVfoJEwWSmhAS/E9ZwvQi
         8cOfahno7K9fhntxOnX7L31XEhkF4JAnLbX26Q3KfBcaRvPxfM0hEh3i/ZNof7lHi5NQ
         ivozOg5Nf2nR7D38NDfN6+jtTvjuG0jwAjtuP663IjPtxLjsOj0S6mlydayzI7CVRy7i
         vVqU/DvODMr+zOfVguyNOnVGglUP/G9+qwA+sPuMc7BjH/vyQtwD1V9fPoJGjz3NfBQ8
         5U9g==
X-Forwarded-Encrypted: i=1; AJvYcCV5JAdEj1PTY01w6zmg9TDu+q7YusGDpjcG0FG3fH768w70zyX2cgHTthtoOKGrfXPRP+VSjnJmzGSsdV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaq4tY0PHu705yhKuRFnKvbi64zxHrk/nfV4c0qNIZverzpmaq
	Za6VY36UHslXu6onqVNnSrB5xtX4Gl0SZjzKU+9UtOd40PKmYZvKlnSSEQa57ApAvjvXYrFcBHH
	yr+mwvPQdU0cRW887xXUGpsoYYlYzEva/Vf9/IKQXeUT8ijsTJxET1YulBy9xuc1Zd947O9yE1o
	Cp
X-Gm-Gg: ASbGncvvWSuFalfGcgJpyqHwyyXfKx05B/jhPwf0nhvLViQVyzr1ayCQcxaGu3dYzDr
	NO8j5gtTZ83YDMDHvAniB2hYwbqeyfZXuNp2mujE9tjHsztsIBWLyBjNF48GuZ2qn9rhmknZTa9
	03+zuqePpYvPjCHZYs3vPgQc1Q2oet9zUrVxFxmMyCbdig6n1ErecSJ8sK5qFHEKCLSC3XHYypR
	TReQMrcz4SVmMDz5zt3MelAFGbuFmhB1sFygRz+O/SIBi54n0WM/A/So37W8EV8jPvVb2Zlo4b2
	06R5/T6HkouNYynfrzWYMYkuIUlkzciLeLW27IHM29z5lEd7/AcaCDBgCRkpXdKDWw==
X-Received: by 2002:a05:600c:3509:b0:45f:28d5:fae with SMTP id 5b1f17b1804b1-46201f8a95fmr49233275e9.4.1758184584237;
        Thu, 18 Sep 2025 01:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJwQaWps09FUQbRplYlP73A3sT975M4X7bZCBgs52Sypt9AWp9lkzJwtUN7xK6hJS/87aSuw==
X-Received: by 2002:a05:600c:3509:b0:45f:28d5:fae with SMTP id 5b1f17b1804b1-46201f8a95fmr49233045e9.4.1758184583853;
        Thu, 18 Sep 2025 01:36:23 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325cec0fsm57279915e9.4.2025.09.18.01.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:36:23 -0700 (PDT)
Message-ID: <4e8bae6a0ada1d52893381e7542220973f0367fb.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix boot failure when kernel lockdown is active
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nicolas.bouchinet@oss.cyber.gouv.fr, Xiu Jianfeng
 <xiujianfeng@huaweicloud.com>, 	rostedt@goodmis.org, mhiramat@kernel.org
Date: Thu, 18 Sep 2025 10:36:21 +0200
In-Reply-To: <87wm5x18bf.fsf@yellow.woof>
References: <20250917125733.2346923-1-xiujianfeng@huaweicloud.com>
	 <b2c19df4c5036e956e4e892ac983d5488a8b9614.camel@redhat.com>
	 <87wm5x18bf.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-17 at 16:07 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > On Wed, 2025-09-17 at 12:57 +0000, Xiu Jianfeng wrote:
> > > From: Xiu Jianfeng <xiujianfeng@huawei.com>
> > >=20
> > > When booting kernel with lockdown=3Dconfidentiality parameter, the
> > > system will hang at rv_register_reactor() due to waiting for
> > > rv_interface_lock, as shown in the following log,
> > >=20
> >=20
> > Thanks for finding this, the problem was already fixed in [1],
> > which is on its way to getting merged.
> >=20
> > [1] -
> > https://lore.kernel.org/all/20250903065112.1878330-1-zhen.ni@easystack.=
cn
>=20
> Yeah, but it is interesting that this is causing real boot problem. I
> thought that commit merely fixes a theoretical bug. I guess this is
> an even stronger motivation to use lock guards.

Yeah totally, I have the feeling that with the kernel there's no such a
thing as a "theoretical bug", kinda like a good consequence of Murphy's
Law.

But I agree, that's something we may want to do sooner than later.
I'm currently not refactoring the RV core so I won't be touching that
for a while, but any patch is more than welcome!

Gabriele


