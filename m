Return-Path: <linux-kernel+bounces-818487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD622B59263
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878003B0A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821CA299A8F;
	Tue, 16 Sep 2025 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOem0TZy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4672283FFB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015471; cv=none; b=hDefCZXIHEdtHoVrVAt7teOvciQ1rBihkBW+zrv3QUeuGq0S5it8t7m2qpWQ9yPtxA+Xm3YCmzMPd5lvu0paB44y1RavmxqDZ8snDNbgLxwBamoPzH4FOblOzjLP8WC2dma+VmBchMtbx/y/Rjy9mvZV0/yp2r8IKz91YrT7jBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015471; c=relaxed/simple;
	bh=JsKvXZf16gFxMkeh1H5MR/rTqxol3ZetNqtosBoRFDc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=reyS1ioXclHbqxOAapQV8+djsWcynXR7Q30GZqcJFksGK9EpdWWVP7U717WXau8fDgQ9KSKuhIQ8Nawb5ayrdEllIpE3gkptZb7jB0OdYx3gMJxckrJmTlGAzkySHx02fPXs3eUdC8fXEPadSifhLw0UJAFpjt63twEz6nNjFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOem0TZy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758015468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zf08R8nyJZM1unNfA8nj+QS6nwSWS7QnqLFVWYPYD94=;
	b=iOem0TZywwXIk6V8dTC1c8Tr/AzNZ/6dp0zSOe99puStq5appzzIqi0/2jOVpNQtPQE4pP
	da3ALvcQHLYCr+LgcvLOJgVhb/zFo4lo72dvpSJCWzEzwh3f2hFJ3LtRrhr+RbHpl5FSee
	seB/6DN2AFQq0Cx36u9Eta12QxOnC7s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-_yxwNnbjOyyRybn6xBbt8Q-1; Tue, 16 Sep 2025 05:37:47 -0400
X-MC-Unique: _yxwNnbjOyyRybn6xBbt8Q-1
X-Mimecast-MFC-AGG-ID: _yxwNnbjOyyRybn6xBbt8Q_1758015466
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f2b9b958aso12168575e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015466; x=1758620266;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zf08R8nyJZM1unNfA8nj+QS6nwSWS7QnqLFVWYPYD94=;
        b=or/cZbAs0VFnS21Dg2KEDIUHc5FH5DPatokqbm3utEVC0HbjsBOlHewRhAXJZjt1k0
         uxM2HOduH/4xK5QAnsP3RC8s9M2RdXrYesrhORAz7B+2k5gjQY+D8HoWi90OUhvsNKWw
         0y4Dvm2GaMwLtIsPRe40OVlWVd9iqEWUE9vrAa8Qm3n/RegtPPEUs/nIIqLApuhXEyRl
         It09MqYc0A32YefHSrVIYEgutJA60cfMym6m21dHI3Ii4HsoPinDgTtUzqW/i9s+M1RE
         sdzd9naMqmSMqmkWhG4aqii8EyMIK05lSI6iXGum5CR4/i25L+VC4mgclvMRii842Cen
         pbhA==
X-Gm-Message-State: AOJu0YypHP7UOpOz4lfvI5duhtGZwBXRXKuSyjP+H7ZxQifnosTUHYZc
	NxJsZOMkWEgIT3cSvV4Vn6TtDUoytWgzBHvDn83RONBk6VsXMzebPrcDDq2bits3oSaXbVvgDTG
	VUb+0mitl6SEzgm+2mwKis2H1t5XAqpDcdV7ifVC/vtUkU6t93bG9eaWgMkb5CaYxqA==
X-Gm-Gg: ASbGnctn+cjwt9F2DlmGZbmXgKii1Zu9A3dlhL7BB5g2DT1qy2stVPT72SCt/qOCS5e
	eO1N02STtmPj863EIeB8mG9OKMf7piU3avZLCHiAbVKi9Bc2bm63RJhrbWKXJUjJUEhiCHj6AEb
	gSecM+CBC7tOoT/JCe6eoF2O8rJXzRDLNgUHJEi1zFfTJNTQb9wKpiMLK/9dAtnk6Gn0rAXkR3U
	P1KKJGKPYhI7j91SEOU3ddOhRMh6DjKSQVjxVjoTa8aITVQ6AiJ6q3G6r+KtHR/nkUbYkdBiIdj
	I39eaLMKaE1DJT2p+LCI4WUUkiUIzi187Q85OSF1/t1xrmmvfbfaPc41QyIyNj7TxQ==
X-Received: by 2002:a05:600c:a47:b0:45b:47e1:ef69 with SMTP id 5b1f17b1804b1-45f212089a5mr147295315e9.36.1758015466386;
        Tue, 16 Sep 2025 02:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz3A+hTwx8PXOtCqhpLtFTrejUAgQYwGRq9js49jLeMuPKv1ZHqMuB9OCaiP9e1Ur5cgHTNA==
X-Received: by 2002:a05:600c:a47:b0:45b:47e1:ef69 with SMTP id 5b1f17b1804b1-45f212089a5mr147295035e9.36.1758015465987;
        Tue, 16 Sep 2025 02:37:45 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd6absm21436968f8f.34.2025.09.16.02.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:37:45 -0700 (PDT)
Message-ID: <243819a5337a7eb3dc6e87b97dd5269c2cd14002.camel@redhat.com>
Subject: Re: [GIT PULL] rv fixes for 6.17-rc7
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Akhilesh Patil <akhilesh@ee.iitb.ac.in>, 
 Nam Cao <namcao@linutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>, Zhen
 Ni <zhen.ni@easystack.cn>
Date: Tue, 16 Sep 2025 11:37:44 +0200
In-Reply-To: <a3563dcd-80e1-4091-87ae-f1ce1e22bf6e@redhat.com>
References: <20250915073529.20364-2-gmonaco@redhat.com>
	 <20250915192527.38f80056@gandalf.local.home>
	 <a3563dcd-80e1-4091-87ae-f1ce1e22bf6e@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-16 at 05:24 +0000, Gabriele Monaco wrote:
>=20
> note the link above is gitLab:
>=20
> https://gitlab.com/glemco/linux/-/tree/rv-6.17-rc7?ref_type=3Dtags
>=20
> and yes it's public.

It seems Gitlab doesn't allow anonymous access via SSH, so yeah, you'd
need an account to clone the link I shared.
For now you should be able to clone via HTTPS:

  git clone https://gitlab.com/glemco/linux.git -b rv-6.17-rc7

But I'll try and get a repository up and running on kernel.org for the
next time.

Sorry for the trouble.

Gabriele


