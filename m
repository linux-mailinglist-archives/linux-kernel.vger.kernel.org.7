Return-Path: <linux-kernel+bounces-732705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13321B06B00
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752724E09AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0220214814;
	Wed, 16 Jul 2025 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENPkD07o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E08635D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752628392; cv=none; b=l1yA0ZFuoSYOZFKO0zQuEKyeSIpx2m/SQMT6KvSmyD/pVu9wVRkIB8NuZkfyroIFQKmvaM95RxDwg24VIQkMqhMw+zHKkDTP3acQRkni9ZDDlkZ/9tm0io/qCTSe8UFyLLDkmrcmujIJ7B2CX/pFJgzmEMI0miSy8xF+I1zVppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752628392; c=relaxed/simple;
	bh=BKWyQDlgpduqK70y5bsJ48SQyWbfCqQEOJF0Pjbu2y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNq92iSlVcSOpfdiKeDCuiQQnW3KdwAEOv95rqQSXGEcJIQI1ASD25KyV/CEenNZ1IuvzKIl6v0VZFbry5/wQ/SoYKFr/6BbIFNXbtwKGy2tDUW9AwnxqQAXZj+IiMonmXPs9uqweTQwcW2p3qDLFbLNx3OzW5mZt0YqaN0bTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENPkD07o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752628389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/keS/EUkYyBiSPiys9/nqLBkkMQLW+p9NKDLAaBTJK4=;
	b=ENPkD07ouisyU8WItzwUq5QZFcdCpG7onJkf+7bzyjGYZb0zzwID4vffrzQdj52atFaoOo
	xvd3beDoTSvMypMhIKMma6zSoeSR0owYP29bHq/Rk/2OiTFyVyR9UnXoF+RviYVRYdFtNQ
	mKGADuqwCUW+Fq/bAA+GOcK9AWO9dR8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-6y1uoAtAOBKLUEzw6DB-oQ-1; Tue, 15 Jul 2025 21:13:07 -0400
X-MC-Unique: 6y1uoAtAOBKLUEzw6DB-oQ-1
X-Mimecast-MFC-AGG-ID: 6y1uoAtAOBKLUEzw6DB-oQ_1752628386
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6105223641bso4779947a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752628386; x=1753233186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/keS/EUkYyBiSPiys9/nqLBkkMQLW+p9NKDLAaBTJK4=;
        b=DoHHGJfd9+7c80EZlR5kRqjgSBm9M8nR7SYF/esC3x7caPSRS8GgYJpBMun1Pn5TPW
         6LaVUe+UgNO4/uDNfUmPz8BmWeMCsTgH/WB8eSL438Ze8/JLSVoXPEfZdRkw2BDSpNs0
         K34MD7cwxeto2pKW8Fs2UvWkQuXhxGBxGST0EoFMdnDK33d/paX50tLSTyH5OeBwcMz9
         6ISa91j2V/qJ6mmxsOgqmleOANT0bGTX9DjTduQIbE/FNO9WRICvFM9fzdSHxwwVi7bb
         0dM+73+Ej5B0OPgcsFsdAnwYAkfYPasyZFcXHl+cHGO+UlxrfznR6ov7/w7mCrUdeLOm
         QRug==
X-Forwarded-Encrypted: i=1; AJvYcCXSPwmjIWBADcxqpBQYfmWiL56soy4W5Yx9UtYXvLILRGhZU0S4sJpRRsq3pFHuWO6+H/ob0iiC5wknVlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVe6LnNWRzSFFmPSlg96RW6tUoxHpWRRAMbiXugF5z0gL9E62
	XqMcfS4uDvF26kT8TGBUI/otaQLzqF1tHmVbObHcJHyGp44AaRr33YKO2cz649IqwAYQA1dkgSL
	UZXOQ9tsZP7HSTHuVg1+m3QWB6+lc5kxwKX+8arE7L9fqkm5WDl8Dkpfkw4uqKHxeGfyl7AspMf
	LidkTDp+p0quTkc8iXKJqkyOY0EoNCzQ+QR2JgiNk+
X-Gm-Gg: ASbGncuMrk5HZj4QTZvlQ+OwuS07SrxKDr/q3EN5M1dAkVx9Vyt62IZ1FRzlIwfcRTr
	bQZ2c9HKybqhGU3k4Mw0SUzc5975tOxWNIoSommvLs+kON5UjY5IdiWJ1bG/w78YcQLNOELBVXL
	cEeAcB26I+0Xan2sTj1Z9//w==
X-Received: by 2002:a17:907:c89d:b0:ae3:6cc8:e431 with SMTP id a640c23a62f3a-ae9c9b6c4f7mr138674966b.57.1752628386132;
        Tue, 15 Jul 2025 18:13:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUD3HiOIYDUW7hX6g4mjiRwOrmAALXXgw8/ypx88cvn2L6gXAwS9h7hC+qro3T7N25vt1Mq+1Ot39s20uVR1Y=
X-Received: by 2002:a17:907:c89d:b0:ae3:6cc8:e431 with SMTP id
 a640c23a62f3a-ae9c9b6c4f7mr138673666b.57.1752628385746; Tue, 15 Jul 2025
 18:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714084755.11921-1-jasowang@redhat.com>
In-Reply-To: <20250714084755.11921-1-jasowang@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 16 Jul 2025 09:12:27 +0800
X-Gm-Features: Ac12FXzEZyLhkQ-ZlRuaRJizHbPzC5U2b0INYQwKCqtanE6LNjchFHQweOloptQ
Message-ID: <CAPpAL=zo2nom7=nL6y8g5N+7qR3oG+bVip1KFxCnJCu9V-M8nA@mail.gmail.com>
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jonah.palmer@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches v2 with "virtio-net-pci,..,in_order=3Don",
regression tests pass.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jul 14, 2025 at 4:48=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Hi all,
>
> This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
> feature is designed to improve the performance of the virtio ring by
> optimizing descriptor processing.
>
> Benchmarks show a notable improvement. Please see patch 3 for details.
>
> Changes since V1:
> - add a new patch to fail early when vhost_add_used() fails
> - drop unused parameters of vhost_add_used_ooo()
> - conisty nheads for vhost_add_used_in_order()
> - typo fixes and other tweaks
>
> Thanks
>
> Jason Wang (3):
>   vhost: fail early when __vhost_add_used() fails
>   vhost: basic in order support
>   vhost_net: basic in_order support
>
>  drivers/vhost/net.c   |  88 +++++++++++++++++++++---------
>  drivers/vhost/vhost.c | 123 ++++++++++++++++++++++++++++++++++--------
>  drivers/vhost/vhost.h |   8 ++-
>  3 files changed, 171 insertions(+), 48 deletions(-)
>
> --
> 2.39.5
>
>


