Return-Path: <linux-kernel+bounces-862132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23907BF4808
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCC2E4E7E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFDE2253B0;
	Tue, 21 Oct 2025 03:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0iuDP5+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76822144C7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761017158; cv=none; b=WIJfLv3m9MsA7yIwl5OcaPHgMmJPOU8xq6UqGec+WGIcdDMl6YPhuFw7prDbd/eQkxWAGa4i6XagF73uqj1Wvj3PKBlf4IEown/A2sEarxS2VT3IcPpSMoBghbkccPlcN9WFmocpXXVb6TefmeQdN8ZK1zGDm09ukyJz0rrdwqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761017158; c=relaxed/simple;
	bh=4XjbvpmeB8CFbftLLp5xjmfmwhK5ug0qxb7qEsIO++M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8upVqBc+H6vS0T4UiatLuRPlU3cOFG6EHcvthDhb4VP2vJ+Fw5vZqGVMDtXOfbN01dBqRv13lwrqr+AD2furf+OfDzVmbGgk8yuEleUXGmuUTtDSjVT1RnyJCoBDrIH0PPnK8kPSTdVe+R440sOLH1MDab1KtahrdCV02RUqJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0iuDP5+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761017155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O34Wpp/uWAHWU6aGGI3BbU1pd02MrBFStEOZ6H33qA8=;
	b=f0iuDP5+vbbFmEEV1lFEn43BErFSE3OoEU5eZ95YDBmCUIRdpWTOw9WsjRX3woFAdwWjkh
	WVztFXb6zyRnI0QjkQT9vhGowige6ByrqxY2wG0Pxmzy5HQnM39jp7tLo3INddkGJenxD7
	JvFUsxGD7q69UipPxK2y0L2IiPI3nG8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-nvQanSmLOMqrzDkmNXFtfw-1; Mon, 20 Oct 2025 23:25:54 -0400
X-MC-Unique: nvQanSmLOMqrzDkmNXFtfw-1
X-Mimecast-MFC-AGG-ID: nvQanSmLOMqrzDkmNXFtfw_1761017153
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b632471eda1so4291173a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761017153; x=1761621953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O34Wpp/uWAHWU6aGGI3BbU1pd02MrBFStEOZ6H33qA8=;
        b=TE35W2ewRmL9NkRukILLs7IWe/RdZzK20cEkitb3Mqzd1WUcONB2771X33IMqIDW4p
         OWnruz0H7SrpmrHXpIcjHbhw379yfzyAul+o5iCKIuUyTokhIiX9BO2SM/hxXK9XacJd
         Tt0ofzj6GUAWmbodVKBIMxTBoR4KI+/FALhySjaERiZ7yZ3ZauP3tNlByQ40mCIvPMQJ
         hHaGe6SxkmCs6hYW3jD9Yn4EOGwIdtLJSeMI+Nq0yu6U8yZH7iSny24lcFOTsaPU5sdA
         7vnqd+zw4osnf3cR4jcy3n0z1oX9g7lO8Fy+3X0npGO7CsHMNETkOBP6C+qrOSPG4wvJ
         Egng==
X-Forwarded-Encrypted: i=1; AJvYcCW3IHHg9m8t/oT8Ku84oCi0WnxsJWAupTiN3K/5iaAHQ0tVjr4ScB8GoU04zBAdAKbRZTlB0VjWqYrYtU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGMMl7HWCIahkJGXdoymua2VBOQBTN5Ma9cl5nE2of9s4uJeVK
	fIw4jdukgJLezXqpLqiVOxvvzNazHo5fmsDKLPuVrlkE8Tt9HAMC4R+DyoBWDMl37sh7RA3u7Aq
	Fv+AjINOCHKL60r2mI5Nd50+wutl8OxZWXUUo2COxO5t7XhVgRtxZaLYGijOEL08MLAydqbcd8l
	5EqrQlfD0TpOiMyEDFCmxPWaPnu+cM0/r7y6aCj2lu
X-Gm-Gg: ASbGncv58ETvBFB9AAh+2P17OaubC6rpB9/756PGtVzkvN3xNYFIxO44qOv18/+TZEL
	Hhfe2jC7YFMYXikoy01D4/fjzoS7hbadVV7+JL1N7GGDahYjXEByOl+nA+3GkogDXRDJpYdpTz9
	f6dcxpAaqY7NEmCTpNC0dmawjQMcW6tShw1mgl9KPQsEqKVZjzGpvNnvZL
X-Received: by 2002:a05:6a21:6d94:b0:249:3006:7567 with SMTP id adf61e73a8af0-334a8607433mr20823233637.35.1761017153147;
        Mon, 20 Oct 2025 20:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJMM8VRzK9zumCmP4A21xwTKQ8iOGB8leiB5Rmd1ArSdY0b4Fs7PVaUuIwZby1VH35HMdVR6ozvJw1DzzSC6g=
X-Received: by 2002:a05:6a21:6d94:b0:249:3006:7567 with SMTP id
 adf61e73a8af0-334a8607433mr20823197637.35.1761017152668; Mon, 20 Oct 2025
 20:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-20-jasowang@redhat.com>
 <20251020051214-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020051214-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:25:40 +0800
X-Gm-Features: AS18NWBI80otGQLOB3_7-L-CjmNuFZpJDc4NEAiysS0jOFwUtxEK5smdmY0ute8
Message-ID: <CACGkMEsegw23-N75QqUWfS_e5TuTX1122n7B8dgZXch=z_Y96A@mail.gmail.com>
Subject: Re: [PATCH V8 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Oct 20, 2025 at 03:10:03PM +0800, Jason Wang wrote:
> > +
> > +     if (vq->batch_last.id =3D=3D last_used) {
> > +             vq->batch_last.id =3D num;
> > +             *len =3D vq->batch_last.len;
> > +     } else
> > +             *len =3D vq->packed.desc_state[last_used].total_len;
>
>
> another coding style violation
>

I've fixed both virtqueue_get_buf_ctx_split_in_order and
virtqueue_get_buf_ctx_packed_in_order.

Thanks


