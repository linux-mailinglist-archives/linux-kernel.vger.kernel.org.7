Return-Path: <linux-kernel+bounces-851769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB874BD7355
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65779188575C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A743043D9;
	Tue, 14 Oct 2025 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L21ei0N+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60512BE7C6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760413869; cv=none; b=icLU1BpgblYfT8OBo1j28FBRo7P7TgRjSgk2igk7YTYHfpnYJN63eV0vhnaEsLJIC8V95C/PDcqB/o1LjbQ/T8M+X7jLE8l9tjmJvn28EGvBKUnv8REMBqG+J56nAtcJq/LQXmL92BsDNLNhLPuAPfOCdYoZgCsepVXUHWLND9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760413869; c=relaxed/simple;
	bh=hOX+xfcv0FIXlgYcgzNXwEUXshb3meXIYtNPtNEbGhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4lOcbmSSes7w6i1pfhTAiADJ4aoewDDa3jRxEor48Szel3LZkqDpZ55GXXGGKbfXLp3uVULM7FO9+wlNqboH/UXkRM12A9sszOlg4UpeAG+bXF+g2maRgZo6nT01VjG+7xXfTag8JPJLJq5jceOuGDtt4A/5cmLvhuXiu0kSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L21ei0N+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760413864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpfuPsZvAQi28LvBnYfBJn6au1wKMqKBywHgQemOBWs=;
	b=L21ei0N+4/MbXI5PNiP3EmXvgtSqU7p8y8ulR5jMw3Hbqd3aTxSQQva/7CEmnIlv6QJamY
	2+cQurtE7pcMo3I4gg8R7y17DvnUiSaPT+/JKMFSQN+rsOUM9S6yrtYIW++JhQU024kNMk
	MIxxTeKXiUyHyYfipHwHmFlTFi1H+YQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-TfqKrBNDMjWB-yGB5nSJmQ-1; Mon, 13 Oct 2025 23:51:02 -0400
X-MC-Unique: TfqKrBNDMjWB-yGB5nSJmQ-1
X-Mimecast-MFC-AGG-ID: TfqKrBNDMjWB-yGB5nSJmQ_1760413861
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32edda89a37so8714286a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760413861; x=1761018661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpfuPsZvAQi28LvBnYfBJn6au1wKMqKBywHgQemOBWs=;
        b=T7xdzOAt01QHqQd0OKnuNWvlhDet0ouNOqKKPS9777aQeFEARegbUi8qLAVt9hB+sk
         4MvoVJFr6j6fkKriZfsBSmDfrOpkeSuEa6Tk+kgBi+x//ajIYVhFRK/URzyBHQKXfibL
         tuuWPuDJ+/x9vYqBEuxqxB4jRo36VYAHvsY+VUDoRAz154oAygG5O5JE1xF8yfyzVz1c
         wF0MdnDvcEQte2eoARKzmuwRqshcwepK0fzph798c3dEwY3dAc/6bNPEDIZ6iFBX9zVn
         cwGyDDJkkfgK7rqjA9yi1Jy0zcT2aDQr757s53iKMS3LGZqiIstmxEMje3BvtauBHTiY
         4wdA==
X-Forwarded-Encrypted: i=1; AJvYcCW4XVw+1Uuo3ox1n500OwG49vJ8SV5hfL7t0nbHDTdHarE+wbf24SYukAKpnMvqq++1tUgpESr7EvtEKNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7OhEBoqQZC1WXeN7x5RdLxLKdMfthkuALcYay59G0kS/vavA
	ShfmEGgVjT0Nn/BnAT8qV2Tmxig/Q3zpr3glS/bEyuMqFTCNIt1PH+N4wOl3nCRawIgD8nJINsg
	pxiOfyauHEX0Z0/6uCwPCegsaJB17eqYjdEuVj+bbgsDGEyCIfM6sBk5HaDtw4NxHryBEab7tSj
	M2VEWxtq9FHwth3k+HURsF/Fq7Vicg8Lm9U2YijV2R
X-Gm-Gg: ASbGnctky12wsCRz70OsS8E021WMmVzw++WT52G0bpuLDq9I/IkCZIod5MIa6hOaNPH
	1ZE/trRN+G3TDqqgX+12PjHr2K5gChC3VvIQDdfYd+gvJZscmaeWOkdgYUekMq/FZ/ilXdPR/Rm
	3w29amG+yiQznv1g9Pd145FQ==
X-Received: by 2002:a17:90b:1e10:b0:336:b563:993a with SMTP id 98e67ed59e1d1-33b513b3554mr34160947a91.23.1760413860931;
        Mon, 13 Oct 2025 20:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpXfKpuusbBQVRGGSDCDbhv6EzerfzrHPaJASDdrjMHe9ZbODDG7uY7dgAL5EIgQXRHBvuyZ4sdGfm5mo29Pk=
X-Received: by 2002:a17:90b:1e10:b0:336:b563:993a with SMTP id
 98e67ed59e1d1-33b513b3554mr34160927a91.23.1760413860471; Mon, 13 Oct 2025
 20:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925103708.44589-1-jasowang@redhat.com> <20250925103708.44589-20-jasowang@redhat.com>
 <20250926104551-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250926104551-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Oct 2025 11:50:49 +0800
X-Gm-Features: AS18NWC3-stlUAKfricYSQ4uF3kg5PAe38zj7A50TpRJE1eY7ej27zOsnOAV7Ns
Message-ID: <CACGkMEszC5kvkWpSiK9pZQ-_T1-74perH=FXkAOYeCffy7kc0Q@mail.gmail.com>
Subject: Re: [PATCH V7 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 10:48=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, Sep 25, 2025 at 06:37:08PM +0800, Jason Wang wrote:
> > This patch implements in order support for both split virtqueue and
> > packed virtqueue. Performance could be gained for the device where the
> > memory access could be expensive (e.g vhost-net or a real PCI device):
> >
> > Benchmark with KVM guest:
> >
> > Vhost-net on the host: (pktgen + XDP_DROP):
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.20Mpps     | 6.20Mpps    | +19%
> >     RX:  3.47Mpps     | 3.61Mpps    | + 4%
> >
> > Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> >
> > For split virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
> >     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> >
> > For packed virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
> >     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> >
> > Benchmark also shows no performance impact for in_order=3Doff for queue
> > size with 256 and 1024.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> I'm not sure why my signoff is here but it does not look my
> comments have been addressed.

I will remove it.

>
> For example, see 20250921133711-mutt-send-email-mst@kernel.org
>
>
>
> Could you pls go over my comments again and check they
> have all been addressed?
>

It has been replied here:

https://lkml.org/lkml/2025/9/22/28

Please tell me if it's ok for you or not.

Thanks


