Return-Path: <linux-kernel+bounces-826485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D2B8EA51
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE143BDB0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D00114EC62;
	Mon, 22 Sep 2025 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+INTU25"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A4136672
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502722; cv=none; b=ALmCIACWB+8mV5poiafiRGO5V1skbCF0Y6cz75RQ0axDsEDH/xLDm4KM6xt6sE+s8HhGDT9VZYS3iWHcXAjM78kD1xdDp8M4KdmixBy9RpSIo0pGrd+eu9l418aR9BzeaN8x0AidLB1sv9bqtD385ViW6COCJ4bTOtPd/x4w6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502722; c=relaxed/simple;
	bh=T6tfiulQG+spNomadDuTnkC/nFyjA7NR0xNHBVgdaZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrRw5+VYcmgByfgYb7y2DyESrV4tixBkIct6EDlJI3mA46yZRY4/Oez+MzMZ+wmE6dbWOUqv5vhnGINHqTqRX9HCkv00oA22ovcEdBvERiaCVMRQgW9DW4qLzjr2yRCjKaF5iAqDzJZoNC9hGGD7el1jEWc3qJD5W1wNFsfHcko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+INTU25; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758502719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6tfiulQG+spNomadDuTnkC/nFyjA7NR0xNHBVgdaZM=;
	b=N+INTU2544aohOPTr0TCMvnmrku7FuIcgrikoAQtTCBzffc8ganBZCfMY2jaMTHzEO/5ew
	1JzQQPaHq58FGC/AxuAQZB/0j9yyz4A+NteRWi9KBaZ6qZd5/onSxUMKd1b4UplYiV/N1N
	La16mL81DZef/ui22UYN+//D8lbnrM8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-0KCMgwi0ME-o87XPlV8jrA-1; Sun, 21 Sep 2025 20:58:38 -0400
X-MC-Unique: 0KCMgwi0ME-o87XPlV8jrA-1
X-Mimecast-MFC-AGG-ID: 0KCMgwi0ME-o87XPlV8jrA_1758502717
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77f2f0c3e62so436478b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758502717; x=1759107517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6tfiulQG+spNomadDuTnkC/nFyjA7NR0xNHBVgdaZM=;
        b=I29t7kVxtNAfURuGkWRpjZyT5Az+3LaDG6l8dq0yeadCIqlNx9L2tte4cqCnQvYTlz
         h+Kn9NLPiftCg34WhaDnsveZZMOtxogJnKEgH7mRVK2zy6QcR3MZHe4UEkFsnKAVcH+f
         HJij1X+LkkV5vPTkUJRIUzX+e6jwW/Y5BUfw/QhFvkJLkJ7AUg0zUs75qjmjq4o/hv+q
         aeyKQXUf2BblJnqrYS99TZkN5z21X8eAqQeFBYKUXctdpL0KjJA3AypoQlJXlxT/7ypl
         +fJwrnBhcdDdsbRCvHZgqqN9fP8IgV4sxsmOqOkRph3U0EtF5CmUHORCkhV9sF9shli7
         qFVg==
X-Forwarded-Encrypted: i=1; AJvYcCXu1H6tFocwofpU7wQB/HWp/hA1zlNxAafh29akIXTXOHoVrg14HNrkgT3uueUnJwUxZT+IvOB+uJTkmYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+AkV4bJBKKNvtdsHDzGHACvO5WnCziywHtos20fKaoXlZPLUj
	YHA40hOpmD7urvxue//o7MZOduKRoYkp+oTFqnHDanERK5hN9DYp5CLrp4rqK4OWhGy1f0Tx5Tk
	Rc02Smu42b+Hb7yXSPIipPMBeBvSXzA1/w6QV8IxDWIDP54dSRrDgMCJLv33wV2QXTL3Z2DHHNe
	+EJaUbflQ9HrFc59blFTqIou2wmp2jCAl8HfT0h7wg
X-Gm-Gg: ASbGncvyq9dMbTLmv8zZtXqadn+iFhAMTRnecPee4L+qUBJKggwBk1sAXgcTpyCy562
	A6OuddxG+i8pCK7gy6VNhLRD5IBWY4pWF0+jB5jgKULLKnyXQUqG9QtLFVjY9g1wvw8HFz3HVZ3
	YA5HWRVl+ugs/iai9jF1RWQg==
X-Received: by 2002:a05:6a20:939e:b0:249:d3d:a50b with SMTP id adf61e73a8af0-292762e1e5emr15160569637.59.1758502717292;
        Sun, 21 Sep 2025 17:58:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU49b1OLZTShTMzjMrSzEIICcIsG4gza3XDPGe0wySbldoNRcgacZ54sjtyDmDtkanSS+3TiA+qzduh6i6+lc=
X-Received: by 2002:a05:6a20:939e:b0:249:d3d:a50b with SMTP id
 adf61e73a8af0-292762e1e5emr15160554637.59.1758502716923; Sun, 21 Sep 2025
 17:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-18-jasowang@redhat.com>
 <20250921143014-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921143014-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 08:58:25 +0800
X-Gm-Features: AS18NWDJs_S-haReGVLawFCJUQJfYQJ881bo57npl_YRU2E1RTwRiJjUTnRbrv0
Message-ID: <CACGkMEvFL6ZbvdWtp8W+pBE032ictXMP4Nm1XySceW_LuaYG=Q@mail.gmail.com>
Subject: Re: [PATCH V6 17/19] virtio_ring: factor out split indirect detaching logic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 2:30=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:52PM +0800, Jason Wang wrote:
> > Factor out the split indirect descriptor detaching logic in order to
> > make it be reused by the in order support.
>
> and I think you mean "allow it to be reused"
>

Fixed.

Thanks


