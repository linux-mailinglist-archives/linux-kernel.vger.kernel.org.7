Return-Path: <linux-kernel+bounces-826479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A038B8EA27
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE8E1896365
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A51384039;
	Mon, 22 Sep 2025 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yaezq6v6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA78772604
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502298; cv=none; b=bfINjnNHI8D7jE9pUhDvW7xfSF5tcTx6zA2uJnSgB+efPevtEF9TsoAX+oIqDpBq5JEMgF9NrhbmDs7k5ecH2vfiqSrLSVkUaiBe1Hxe5+3q2QzLYCdATAOA+3ufU+gt1aHAJ0cGIrMw+kviExGKLx8xa2qJClUIyKQ9PvbPp4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502298; c=relaxed/simple;
	bh=F8SykSU3lPdLjvpiYnlAUhi5iNYVQF1x129DI9Omo3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcGLwx+WxOju5HuCsTsFph6MgZhA642vkyIhdjNTF47BDNOAyhnZxd3ezHVFqThrxurOEu3IclE61GjiPJ98APShEsGMn4t7ZzmM9c2HwmVdCisawXzkMKJUuCha5zA1RqLEvtYx0t7EyoLLQD8cxalwSAX1IFVZ+qtJaUhGxpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yaezq6v6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758502296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8SykSU3lPdLjvpiYnlAUhi5iNYVQF1x129DI9Omo3E=;
	b=Yaezq6v6m/1cRDnDdSoKxrJb30xFJrYjSIms2TAb4mvFZOSAKE4WQ/Q2O5mtoXo11qufcw
	Nw7IbtLT0+0QZtefwWGysFyUETsgAU7FQ1fwFGbZ/Y2AImFrCncwXQYrbaFPAg8oW6Tuxa
	7UKE9/VE8B3QFdxPtm3k4dUMNW1/3pg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-6Y-hqTYCM8m3BwTZibWArg-1; Sun, 21 Sep 2025 20:51:34 -0400
X-MC-Unique: 6Y-hqTYCM8m3BwTZibWArg-1
X-Mimecast-MFC-AGG-ID: 6Y-hqTYCM8m3BwTZibWArg_1758502293
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5535902495so1029827a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758502293; x=1759107093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8SykSU3lPdLjvpiYnlAUhi5iNYVQF1x129DI9Omo3E=;
        b=XdWJPUVEmiyu0vvRE/dSCpyfeOX7nS6PTMQfxkaialGlWp8M9XCCCHhQL5ixE99qpT
         4HVYC/zV/8qOeX+U4Ctz3IfwiHrf+UY0l2LExNaXny28YdrLwcMONayfYvFbes9a1cqs
         Xd+FD3dRmx5/6vzzTT7ymZDSlD/3jqfNKRO9joadReonIBKiOsw5dHznOabNYCi6Xwfa
         HHjENUApvF+8LJsNhNc3q2PCyOyGm53oY6V/DGOTkrb9biTvQ7lGPMo3YCfDoM9r2o5H
         xqHeF0/TTOyPs8XwtqQV39/xBprrRMj0DN14fqwUrP61OkMeINgTqDSy2Pmsn1EVlmof
         cZ4g==
X-Forwarded-Encrypted: i=1; AJvYcCWtrmy1Xxc2uJ7LjZlYO+3nOXxe7lUO8jVnP88ZZKaDyJfRbunb4tDF3m9e84a7mnsIwEbp1wrSI6kj0L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjxDKnXRVJeM0yQwBK692o8tz4poko7T2CYrMOFhPYQNplF9S/
	rqPo3l3LLaxKF5MbfzgLqc/XLLphyeqkSRA2fn8tT4OFUQqNdzjB2drJo6GnjmH2XyjYUlc+sbV
	URHioJMLiAp/ca7atoDuRDzRNYJ3HizT+odcq5CWn3FeIAq6vecNOng1LdPTR2/1Ii1t3VJOe3a
	h6mz076Fp51G+VbKA61RLXpH+FqwL72FdyGJoZqIST
X-Gm-Gg: ASbGncvYc7CVpNTIgY083RAhG4Bmef6yHkBtmFmBhTjpe4JY/iNbVib4ZRYeiJGR9pe
	yZnQe1VJ26sLNPECMPEDzrxz4DQMZWyaKYEye0yAs9s5xQZAsZLCVN/BexShotCiNdKZ87k9hbl
	FTAPe3na13AAqxUQmCplGr+A==
X-Received: by 2002:a17:90b:5585:b0:32b:8582:34be with SMTP id 98e67ed59e1d1-33097ff8745mr12323826a91.13.1758502293183;
        Sun, 21 Sep 2025 17:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmPZ+UCXWP9ATTeYvrzC84/XjGYdnilWnlBNRFnXGo6v3f7HDJUGzqyEe1RfF03zBJ35TmhW0n+fWbmX49p60=
X-Received: by 2002:a17:90b:5585:b0:32b:8582:34be with SMTP id
 98e67ed59e1d1-33097ff8745mr12323813a91.13.1758502292864; Sun, 21 Sep 2025
 17:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-8-jasowang@redhat.com>
 <20250921134504-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921134504-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 08:51:21 +0800
X-Gm-Features: AS18NWDmFIyEOZnaarbLoyCKXQe5TDpfrHph2NR2KgwbgMUxuUxt6mV4iAQXhtY
Message-ID: <CACGkMEu83s0d2UdQL+PT7yT+P2K54F7Q1B7bjotkTjbN_ChqFA@mail.gmail.com>
Subject: Re: [PATCH V6 07/19] virtio: switch to use vring_virtqueue for
 virtqueue_add variants
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:45=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:42PM +0800, Jason Wang wrote:
> > Those variants are used internally so let's switch to use
> > vring_virtqueue as parameter to be consistent with other internal
> > virtqueue helpers.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> This one actually switches virtqueue_get_buf variants.
>
> Previous one is for virtqueue_add
>

Exactly, let me fix it.

Thanks


