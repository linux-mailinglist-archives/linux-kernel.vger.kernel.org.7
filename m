Return-Path: <linux-kernel+bounces-818718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4EB595A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B814E163BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33130BF6B;
	Tue, 16 Sep 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQOP8Ij/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA9B2C21CD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023782; cv=none; b=LdrV4cy6b2uUqeWXOSp/JTskcp5ak5Sw7y9cipyt+lRXCRiJB15obcy+MOzEtQOZYCtzFr4reuVlvtjHdtrL2VecdgT9LHstvZP1lfgi/94kSCDYkNtd50/5eE2muKT8MM/uI4r4lSkIMVxRlpkuIRu/kK3aKN4shoNgAgTApiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023782; c=relaxed/simple;
	bh=3S+jNxmDYUUUXfEI5vWwrT9ih7WaBA7z3QtFabvleW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgFrCJOS065JSHZiIpi8t7fdVoi63CBerlXogHjGytLHl+Kdo2ZMEkcs49iLTYxGeNvuu3cTy0DN+rv6kxNS6FS5OzXMu9Y1y2jiKOsXUxmOh+VcFvk4BNcQ+ByEwR4T1Bxq8qX/B29rKHMb0eu0OC1MXpDpLZns3jlGUNd3SIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQOP8Ij/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758023779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0Ra6i2f66P59CRI5N1spBjW+VhT7ES9HuZ5VOE5NFk=;
	b=GQOP8Ij/LCrdQtY5WnS2rgHdew1mNpfwtjdUsUYhtNUVel78xtigsFWIO9S46DWLJ3sSgP
	nLNJvKHac8uEMlM+JHbfwRoLdStChslmx+rUvyn42w40u6KywY+KtrGNHW/APhcp6WTqo+
	SacH9TiYJM15HagluisR/GQQeJbfhC4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-y5wPRE2YPC2OtYzQiYIbUw-1; Tue, 16 Sep 2025 07:56:18 -0400
X-MC-Unique: y5wPRE2YPC2OtYzQiYIbUw-1
X-Mimecast-MFC-AGG-ID: y5wPRE2YPC2OtYzQiYIbUw_1758023777
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b04206e3d7eso602641366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758023777; x=1758628577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0Ra6i2f66P59CRI5N1spBjW+VhT7ES9HuZ5VOE5NFk=;
        b=oe8/ods7Hl7JSCmYEmlEYxFRQC2H+CgsbEkAwfu7HyiNm3DVIUVF3KWV7L4dGLlOx2
         r7ttH2G7OQHCSXX0CfRkDEI1kNJW9BLvKxnI5DVUiSBY93brMHSQrgfAD9SJsqSP8gZ4
         gc2qvQPUVmyCJGBx7A1FauJcWHMKwAwNbbpVSyVhg0nFn20qYJYHGNG8kcAvZ/1Ifdx5
         kfdk1/gHOvokDmy8y4JiMOzDsdmv+hRXuxV8NiXepKwkFC3JkDuNM0tIS3BAGzkT/HWO
         os07/VSO8/foi0CTnOuw05MKRnT75akwQCq5YWfvl6LCXSJ/FIJLrWhH77SoekzkaUla
         489Q==
X-Gm-Message-State: AOJu0YzKD/hTrQwSCWEjQRrGFvGeJZ5Njgpeng3cydcVSxDHtGLZFzq+
	jYWYhmdaLkwbpXcnfrCFo4xDdt03LvstDnGSEho6zMO1xMHolpCx4oQlIkh0XVdTTX89HnFmdeF
	3izhuM8pGdSpu8rN+GcmK9MQAlkqLgiD7ux5iKerSCm2t71nntN6S6iJ+7imQacm6qvac914sgp
	3XDZcbOTALlrBLNnRESYfzkoNTlrB2XzQee6w9Ehjl
X-Gm-Gg: ASbGncuMtQv/9+ht6bHYpHuCbRXzpmBVvOAXNmpD6Q4ShWtkHLRDDz9yIhel0SVUK+U
	v8x333USEPEXC3m7rrMfecxIfbMT1K6WyjB2YBztT3q3CrNd/837imwZa7WnaLtJuMxeODfYzye
	7vtijV7iv0BIX9yAvq7/Vpgw==
X-Received: by 2002:a17:907:3d02:b0:b11:3760:95b4 with SMTP id a640c23a62f3a-b167deddcf6mr245928866b.2.1758023776668;
        Tue, 16 Sep 2025 04:56:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0PI35/hEV3tO6/rTmDZsusJRuSn/cMesYTaXeGJ6BLt+Imfx3eO+iuaBX8kz/r5FsIazYF9a5oXZ9S/+4tTA=
X-Received: by 2002:a17:907:3d02:b0:b11:3760:95b4 with SMTP id
 a640c23a62f3a-b167deddcf6mr245925266b.2.1758023776230; Tue, 16 Sep 2025
 04:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757951612.git.mst@redhat.com> <A8EB32B8-1AF2-45AA-87A9-4068E405B284@nutanix.com>
In-Reply-To: <A8EB32B8-1AF2-45AA-87A9-4068E405B284@nutanix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 16 Sep 2025 19:55:39 +0800
X-Gm-Features: AS18NWDfz5SNTBZIUxlhuLZxRAY5mBqwnEKmFaFtzrsqK0Bx9ahhPEpbA2uZSho
Message-ID: <CAPpAL=zNOt0ke-12k_Fo1mzFyfi48h3v__6pb3+ZS_7d=pwnZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] vhost-net regression fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jon Kohler <jon@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches with virtio-net regression tests,
everything works fine. Please feel free to let me know if these
patches need me to do more tests.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Sep 16, 2025 at 12:39=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote=
:
>
>
>
> > On Sep 15, 2025, at 12:03=E2=80=AFPM, Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> >
> > |-------------------------------------------------------------------!
> >
> >
> > Two regressions were reported in vhost-net.
> > This is based on a patchset by Jason, but with
> > patch 2 from his series split up and made simpler.
> >
> > Lightly tested.
> > Jason, Jon could you pls test this as well, and report?
>
> For the iotlb bit (patch 2/3):
> Tried this out on a 6.16 host / guest that locked up with iotlb miss loop=
,
> applied this patch and all was well.
>
> Tested-by: Jon Kohler <jon@nutanix.com>
>
> >
> >
> > Jason Wang (2):
> >  vhost-net: unbreak busy polling
> >
> > Michael S. Tsirkin (1):
> >  Revert "vhost/net: Defer TX queue re-enable until after sendmsg"
> >  vhost-net: flush batched before enabling notifications
> >
> > drivers/vhost/net.c | 44 ++++++++++++++++++++------------------------
> > 1 file changed, 20 insertions(+), 24 deletions(-)
> >
> > --
> > MST
> >
>


