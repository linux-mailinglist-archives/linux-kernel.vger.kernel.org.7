Return-Path: <linux-kernel+bounces-836210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F375BA9039
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433D63C3D30
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590EE3002A7;
	Mon, 29 Sep 2025 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bdd2gLkl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3D2FC00E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145317; cv=none; b=WPGqDf5WUKeHPyNyxYPz37pPxy6p7xVNRw6Fom/ZgzOeKkCc/mG6C31Kh/G5CStisKXIcN0xcTDXT/fKfy+6lYgvPnKkXkmGn8MFN66c3m1w0Qvh0SW9RuxVMn5mE3pgXfgFy6/j8liM9HsetAPwTU93hEy5miHLcleJNvpGJOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145317; c=relaxed/simple;
	bh=xhjsvfXdO5SYlYsKGWf6Nq4OBRuCClBU0c1pcHzd/y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i23B2I+z8YYu36D50ySEpBQaY49BNc9Tt1rPaFJnZpPDZ7ce/DbYbGtHWpHXPf2X2xRN6gdlSrF7rZqRfK8tWkYKUM6GiWUnMbBDOuyuImuxNS0vPxrVMQLtspMhrmhdyPdi/0bj9NEobHCH/wJBPSMuyqHFN8vYk3vz5c2UvtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bdd2gLkl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759145315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Wwy06Ljl0BBCyv2VUlnRxmOVniJjHrri4cTVWPbGTI=;
	b=Bdd2gLklKpI4mjPCUpo1qi5ZXT0scjDUihhEUm/2YmKB+eTSfOtMeLqGfqx0L+44xhIdGt
	43O8CMn2QYpXWU83sX8ecusoM2fCUZOvcmJwByNYuML4+5iiCxkumLoL7DX48J9/sqyXc4
	+51jZnXid3gllATGN4Sr5RhfmU3qJag=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-tSCgNzggN5qE9s__JGVc0Q-1; Mon, 29 Sep 2025 07:28:33 -0400
X-MC-Unique: tSCgNzggN5qE9s__JGVc0Q-1
X-Mimecast-MFC-AGG-ID: tSCgNzggN5qE9s__JGVc0Q_1759145313
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63610e0c8eeso5055649d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145313; x=1759750113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Wwy06Ljl0BBCyv2VUlnRxmOVniJjHrri4cTVWPbGTI=;
        b=PSvREIyGd4aNUeFT1oc8L+illuFhIi8+552HM78MQmi8uz4PXStHGm/05Oak+neLRj
         mQtrsT7cYwsBaMqnvX4NGZGVOOZzsf/qo1oijTjnecCMpcfZy+Kp7fWhEAIJv8faHGO3
         /KaVWadEP78ddyaYzaGmh2H5HvqlqH3v/msMiN5JwP/qxRNoEbQd+sn1E6/9drr3kK73
         0gexNWS8hv1S4DhNulXuj8/CRZDOhQbgWyW8Cyr/TY8PUTZuWwlvH3EuCPLDG4GuzpJH
         qimTFSSSK52jUfBqCi/i1i2kZ9yEn6W5Ivw23Se/yJO14w1Z35vQ6Qq9ZdorhZU0dMcY
         RjyA==
X-Forwarded-Encrypted: i=1; AJvYcCVdG94sPdDrVhlf9QTjDbayN5MZl4h4CHwt5GZIXuHL2uMKOvqNr0M0BxnPVO4d4U+cKomE/ifhCxd+jNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLS+vSsjDUZ/PJ2XNboY3fGS2lik6RMgmR6RDN0/x+6IUa+BQ
	GLw7pgzBgUlDa7JkiBNCV4vv7JvyTNpDLcVIwKX2PLRNuvQsy9rRbA1v1JYRAF7i9QztQ+DZMfx
	rDJW8f43L9DOrdcQyiRoMD6dyrFwwYObYTsggTOeGsSeTsa1dkd206BpLE2JeS2DDe8lTSZmYdT
	v/y+a2R/lqv8TSGbldhWOUMgg0n5c3H3mOfeRCv89H
X-Gm-Gg: ASbGncsA/qFRqWtYJU9nTXIlvfmkERfbkRr6hjLkf5uhdz0OPKQDZRZt1HqNaSG8S8c
	a4LGOaMiQJfPZ0tOl5kaAFKSlU4lAOU1tZfTXijU/7CoK5KQxKM69m9Io6H4wSiSjfI+OFSiQX0
	jmCNf+6Ceuzv3uSCUTt98Z6/U2bgiGYTtBbrBFJqQX3fNUAgKrN3lKRh0tk6sLP3NDYzvT8xSLE
	VKbXnps
X-Received: by 2002:a05:690e:40e:b0:629:7a71:ff8 with SMTP id 956f58d0204a3-6361a820fe9mr14186960d50.28.1759145312795;
        Mon, 29 Sep 2025 04:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuDBuJWNZwxfGsSc2MO0wrCuwt2NOJAY/Zy9NzygM8/lNwEH7TCf+dALzc0a5g/oX6DhafT7R1g1/FWE6Wkl0=
X-Received: by 2002:a05:690e:40e:b0:629:7a71:ff8 with SMTP id
 956f58d0204a3-6361a820fe9mr14186944d50.28.1759145312427; Mon, 29 Sep 2025
 04:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926101432.2251301-1-eperezma@redhat.com> <20250926101432.2251301-6-eperezma@redhat.com>
 <20250927155955-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250927155955-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 13:27:55 +0200
X-Gm-Features: AS18NWCwOJPe6fL3S805w9mrXhyY5mwgA7fITy-Y21RYdWPFm4ggqzIO6QhSP4M
Message-ID: <CAJaqyWcSR2cc3Mwsm46SQr2uqf4y6tqiLA3HCq30ESqVdCr0Fg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] vduse: add vq group asid support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 10:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Sep 26, 2025 at 12:14:31PM +0200, Eugenio P=C3=A9rez wrote:
> > @@ -166,6 +179,16 @@ struct vduse_vq_state_packed {
> >       __u16 last_used_idx;
> >  };
> >
> > +/**
> > + * struct vduse_vq_group - virtqueue group
>
> comment does not match struct name.
>

Fixing in v6!


