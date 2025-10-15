Return-Path: <linux-kernel+bounces-853836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37375BDCB85
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC2819200B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EBB30FF00;
	Wed, 15 Oct 2025 06:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5BNcal7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2371130F93D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509584; cv=none; b=CoEnBNrABZwoWLpqEX3bbFAWJ8jGIGpOAI58v2NMOf3vWAH9QFvREhlZlC1CSKEWsjKsWPIIYJ8qfVxdFciL8u+2F5n6/6LtCYOqi2D3+aVtNRVo2NhqokycteRTXKvsgGJbPGATQcujd0UmvA0amD3rjIW67D6EOSv61K8Dt40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509584; c=relaxed/simple;
	bh=1X5r5A1B2kjjGeMbXGSpjomcqgwt++arkl6QDDiWrAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUgdGUVB7zlzPY4OvUoXCIMSVMFzaeagsLQpSWN0CqFqqotRf6XNgf6leWWme1PXKCcIb5lFrgm8xP1yE0rF2e5KRPddzGJ1DnNrUrO+UizEZPM8Vuiblvbq5H2ZVZtkLXWCnbV/3HU/YID+xhjZG7s4LiC0ZAtEg0CPX5kqQQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5BNcal7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760509582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1X5r5A1B2kjjGeMbXGSpjomcqgwt++arkl6QDDiWrAs=;
	b=d5BNcal7oxxKMd54gr60BmONV+Rn12S9jnvnGxzdEQ0ZkD1gVrI2aE9yQITN83u5uBjCjp
	8wUrEz0xOybh55RTTO9Sd0sLt4AcYJD9Z/5bZAqIY2K9ORB+oBGm+bLPmMpIA2JctqzRt9
	GN8UJ5SLtFA/r75dlDWSYmKkRpOIz3w=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-DReh66BIMGyk--1L4FKBtQ-1; Wed, 15 Oct 2025 02:26:19 -0400
X-MC-Unique: DReh66BIMGyk--1L4FKBtQ-1
X-Mimecast-MFC-AGG-ID: DReh66BIMGyk--1L4FKBtQ_1760509579
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-78120957aceso49900867b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760509579; x=1761114379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1X5r5A1B2kjjGeMbXGSpjomcqgwt++arkl6QDDiWrAs=;
        b=ExaM6yT3MU2kWlkc49SOmgA7QScINJ5Gm/ScfI5uJsmPZtY3JSIDiF1wPeMbTd+hHE
         ON+RJJuEILM3QzytLsmlpHNJ6C1AQ3VV9bKLrb8U3kiDZyeyxyJqCtlsBMIkblmwEYeY
         FQUyD/pESN3M3nFXz6K0CmJM1P/fbnrGk60G48WNpL5nqhBLlxLSAyhW9N0QOFjtMFAW
         zZwcJIiOWekl+UY4+j8sHA1rOX6ECvAPmtXwpH0J0vMBGBTgFCoYsnZ0XDoOZ1h4Ru+C
         SxxmkAVGyHQmZTBCs3J4fTWX6ZmOrq4KLa9n6M5Yvffpvp4yz/1mxZT180X9t3ckiHM6
         dDvg==
X-Forwarded-Encrypted: i=1; AJvYcCXTEnguYo0WB4OqbRvxjzlJPm5Y5oqEfxUcb+cUD+V1ThR3e1oU0gCo+TD7SENy36ShfF/SKCzXfhoEYhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRRNpLzFzE7Xs2eq/VS1JPE+ZrjjEPJJylz61pZRTTGhKvMBgO
	PO03+RaAbS8xFN59/GJIYZ1Cti3B6/CLLKzYz2MzEtrxlQvCb1ymuulgenoQwT9/lzhEwzaTim9
	cbZBz/76Cdncs9sHkrmX67Q5Lnv/LZtIsDZxHbF+LF4BHyKZS939qfD3WmQp9eJVA8KnY0CO00u
	Gj7gCzNjRQcLflk4MQg+Z+APt9XQxhWyWXqqmpAYfZ
X-Gm-Gg: ASbGncuxxn6trdHL4bVJ5ctNrPQ63wEGTsmZflXjtqUBURCsXxfcY947RBVmiHcPLZC
	WrpEPaRfmsE9eX/GbFfpBIuFcoXpq4VUdlFy+Yfn8hHizlFLnptoFbi3QMlkxwo5fMLfQEJm8YQ
	qE6vsFvSue5VAZVfUfwC/LhudUIy+GGFstPjSKzvy7wZSjn3T0jkYFT19TRoHa+TGS73f5xoS7l
	qIYU7wO
X-Received: by 2002:a05:690e:d4a:b0:63c:f5a6:f2dc with SMTP id 956f58d0204a3-63cf5a70856mr12235640d50.62.1760509579243;
        Tue, 14 Oct 2025 23:26:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX+vfx8qv1isFFCeU+W/mGqMDeDE6Yla17ZwBRh+wdPY1fE4diJLaULX40JUFbrevmDIlQOeoiti1+NWdvJQ8=
X-Received: by 2002:a05:690e:d4a:b0:63c:f5a6:f2dc with SMTP id
 956f58d0204a3-63cf5a70856mr12235615d50.62.1760509578517; Tue, 14 Oct 2025
 23:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-3-eperezma@redhat.com>
 <20251014043004-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251014043004-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 15 Oct 2025 08:25:41 +0200
X-Gm-Features: AS18NWAg45RzyOP9tnUy5nGSIH1lniNW6YGYImHL_ui8inHzxlsdS5EdGSEbSVM
Message-ID: <CAJaqyWd82UMT9Ddtt0LfXz_L8WLi_4rKtsefo=wuYKKBSOtvAw@mail.gmail.com>
Subject: Re: [RFC 2/2] vduse: lift restriction about net devices with CVQ
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:31=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Oct 07, 2025 at 03:06:22PM +0200, Eugenio P=C3=A9rez wrote:
> > Now that the virtio_net driver is able to recover from a stall
> > virtqueue,
>
> it's not able to recover, is it?
>

Maybe recover is not the best word here :). s/recover from a stall
virtqueue/unlock the RTNL from a stalled control virtqueue/.


