Return-Path: <linux-kernel+bounces-818232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC205B58E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87AA0487C33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8C82DE71E;
	Tue, 16 Sep 2025 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHyBGWKU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19CE1BD9CE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758004674; cv=none; b=TrYS2toA1r97xp2mE7duEuRjxtI9UDsCYk6zSoSrluZGYCOb0mwS/uaHHdKuZL0fNgP1l7+aG7FU1Cbv4t7q5wlNV83hiazEsB0pOvRu+sWa11TuqEo6J7XRsUXhupAeYkvqIgLqIOmTgdQl73vRJ0VO4LlS/RRIG2ETfgqCZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758004674; c=relaxed/simple;
	bh=W4K17Xgz86RjMnxn5TYpq043Q6o53dAX2EopwT6+spI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLVR8XaeacRReQsJhay51qUX7CT0iFr+PCFRtaJvNssbr00qspQmwyQ1c0AR9HVn0V0Vp0V6TTnclC0YXX9EEBbWfF+qxrfXpHvaRsVF2mBBW1AiY58NaRXnSHJpwMqzt9zzj59uNeeAbz2VfSBoSJ+HPpcC10uyB6BdWgmf7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHyBGWKU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758004671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4K17Xgz86RjMnxn5TYpq043Q6o53dAX2EopwT6+spI=;
	b=dHyBGWKU0tsezLvE1x47hmjb8Pcp82SaR8QzGGFsSgbEEcHY6T+s8EzoBbuQyO5wscgWmf
	feVwHvFpPu006U38/jhZ6IHeeRb0dxkLdfd7vPGGdOnBK02EASb9buVUTlaiyV9dAIE7Of
	LyKxQ6t2aRdWKKnd1hEU2ff45LnBKXA=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-lPdffBJKPj-KmCgnry8dGw-1; Tue, 16 Sep 2025 02:37:50 -0400
X-MC-Unique: lPdffBJKPj-KmCgnry8dGw-1
X-Mimecast-MFC-AGG-ID: lPdffBJKPj-KmCgnry8dGw_1758004670
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-606b7cad6fbso2740292d50.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758004670; x=1758609470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4K17Xgz86RjMnxn5TYpq043Q6o53dAX2EopwT6+spI=;
        b=TdvFDQJ0drW3GBRIQf+lZ+KtuWEuBvrcFD90T6D30hfBOFhlnS0rVUGaMNfLPAkd7D
         cb07955PPPv+o4fQQGmqTEr3GwNdYeUdjxMldTmglWxu/1sJL6yI8fyAVXup/216qcVp
         YaEKrAujr/6tPgzr5SQ6r0V/IzL4kQMoPVHZwaPEaZhOv8OIg4nA7Vz4GJ0Zp2k6addp
         l0puKL9tHv2VYwjdtF6bkRap9ul4EHQZeAOukzq66jp0d4MQ08JmpiWFnWSHsYCAAhJB
         Q1ly0zJi0tFrYIRstbaMtfWN9Wi1l0qhs42gDmYpPDOdCqwYuQQ8StWb8enu9n0CP1pD
         jcuA==
X-Forwarded-Encrypted: i=1; AJvYcCUsa7aiD9NvuDsrY7FMPSo6SlmAcI+vfd/9PPM5CWVl5BmreCNSM89hZSqazZkRqMD/wPZHlkMeGjONyHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxemqFKwMd03dOYSYjS83ahHSZICAkZ/Kl2PJ+FId44+xmDJzD1
	iHcesjnQfWgdru76yCgSLW+YgyoEkd0asg335J3N3Tk3cKEHxjbdzBV+1IuB0TrDz5AW991YsJd
	qzXMlOuJUeKea+OE6hXunf+ibsaedeicrP+LKI4JSkcd+gfkCiFd68yxi/ZhcHYnX1dcWD+aOC+
	AIvFTl0ennyWPMAv68GMHzfYrvP7caE7SVJ3ydeGch
X-Gm-Gg: ASbGncvGVmTG/1Efp7fKkFQUYx3c3LX6p3wEe0wEED9/Ny0zo2B1kKBDhP5ql2gfqd1
	z6iabh3r4OHXVXz2VUkn46uJj91jIha7ycPPaqMQKpghPHJA7UZB2U8be4wRlIPV5h2k7YdNojH
	uwSPgjMPR1GNTIWLAw3CLDDy90zicf2xpGP42MiZASU1V3nfvSY6rzDUQLz1JEpDCUvzQVYtHjl
	Ha+KijL
X-Received: by 2002:a05:690e:25c4:b0:5fc:a995:69ce with SMTP id 956f58d0204a3-627225a757emr10100351d50.20.1758004669904;
        Mon, 15 Sep 2025 23:37:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGGn2W7kG6BqGefO0xIXacaiXghzf9KhbnCuK9dVqfFwyXoxNkUA5tzwB/f13a1h5iXG2WNShRtzNd+AXPZvQ=
X-Received: by 2002:a05:690e:25c4:b0:5fc:a995:69ce with SMTP id
 956f58d0204a3-627225a757emr10100335d50.20.1758004669385; Mon, 15 Sep 2025
 23:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250915184200-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250915184200-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 16 Sep 2025 08:37:12 +0200
X-Gm-Features: Ac12FXzYOFF9kv0KHhH8HVvtk04Rp75094MEuDRwZh40OOUbBnBS4J9acZkwBK8
Message-ID: <CAJaqyWdLB1dWASf6NXW_8VXUNoWQ=G4pGjZLRbD_3U=2rfXkig@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add multiple address spaces support to VDUSE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	jasowang@redhat.com, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:42=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Aug 26, 2025 at 01:27:03PM +0200, Eugenio P=C3=A9rez wrote:
> > When used by vhost-vDPA bus driver for VM, the control virtqueue
> > should be shadowed via userspace VMM (QEMU) instead of being assigned
> > directly to Guest. This is because QEMU needs to know the device state
> > in order to start and stop device correctly (e.g for Live Migration).
> >
> > This requies to isolate the memory mapping for control virtqueue
> > presented by vhost-vDPA to prevent guest from accessing it directly.
> >
> > This series add support to multiple address spaces in VDUSE device
> > allowing selective virtqueue isolation through address space IDs (ASID)=
.
>
>
> There hasn't been a new version of this yet, has there?
>

No, I was on PTO last week. I plan to send it today.

Thanks!


