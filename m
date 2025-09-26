Return-Path: <linux-kernel+bounces-833756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE47FBA2F99
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256E21BC579C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D472295511;
	Fri, 26 Sep 2025 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXb70RI3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3517535950
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875878; cv=none; b=uugIX9wStT93JFEjMw/z3a+6jPJ5ExmpIdCe640M3KwRNcx/+sFfC6GPABYBHgk95e93Et8KjUoS32pZnQxXwrVcl8aI19IbuV4UcPVoyyQsqbajgJZ+nbBwlD6WSHUzGgcUKO+pDWH+yiS/q6xJFs3lq37i3ekyTdJqwuVJp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875878; c=relaxed/simple;
	bh=l7ccryhsdYTnF0StFj5adAoUTTZjM7CJm2tdkS/IsoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qu/PwnvcGoseIkLzBJLa6dLL7ZKpAZWCifSBfJbD+4wuxGpUO4VN0Wy7StDBPtH8aUTKTiz6+HbtUL/LWMu8CIsAHaL59zKRqb7wcTZGUOMd1Rpnf1d2URxiQQshy9aJs89d37TCUMrVOvGNxj9rQ1+H0EDU3oW1DpaaD7sP0VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXb70RI3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758875876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWIS+M2+D+NxPOxD8BZpU+DFrxLryhzIK4I38vFOSLM=;
	b=VXb70RI36PXOLeg1jtM1fOYkOrPVttBOweR+HxRAxQb/DTNmXka2XObvYzuVBmhy6C6T2d
	ZdWizKVx2GmkTQP7VnDYb71B51m25CjoyK26TeOzNgnesdx6rVNSIFJT5ri7pDjUre4IWr
	I/bwg2fFsG1WLqJXIk1tDyIRGWYVHkE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-dnU09gQ1OOuZtWSh01RzNA-1; Fri, 26 Sep 2025 04:37:54 -0400
X-MC-Unique: dnU09gQ1OOuZtWSh01RzNA-1
X-Mimecast-MFC-AGG-ID: dnU09gQ1OOuZtWSh01RzNA_1758875874
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-332560b7171so2350379a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758875873; x=1759480673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWIS+M2+D+NxPOxD8BZpU+DFrxLryhzIK4I38vFOSLM=;
        b=fFGpzKzgyKegcsO3EEsJk0clQligOEIFeWLjKCTHBwt8gN4pmunxouUXALTLmyhqIo
         UX0vQ4iEAaEcAbf0+RJcS5hK9KqoCDGZa5+nvJM1UWUJUFGD0gQUEi5e8Xe6Xy3ElqAw
         aTv4N5GhZ0rl5tYYjEVq9thN62jfO1WK+997UjpwEb3y90rrnGf2gqNaJsRmqBaKlthJ
         tLn2P9+e0NVsyI6AQ0fs7G/pVI3sHTHSzpD/U/YfwiQO4qpr8m7dE7KtBsE1R6fTqG9f
         hd5tc03Xcf9iRDh12XI1KQ+c/c72wA8wpOwFOhfPVXtT0W7OahypI4qJDwqWlU6N0pYK
         He6g==
X-Forwarded-Encrypted: i=1; AJvYcCVJddDvvO2bqvYecFlIyRK2qOpLYMYuCK1vCEYid4mkz9IatOCWxIHggc+RDBrYV01B7LrJ0GiLWVL2QqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6eflQqofQtw0jtnfN/0lVKyP5qExSrdyf5pLiW1pMFFarZk/l
	IOBs+7W1G6evupQW4zFZ6l4aNcWm+Dc3FVnJFWwh8xrk1QAbn/CxQwrhWznl1goJIg+/VPjO2cK
	xRlhb0GWp6VsNLr1m9ineoHfI5SNQwF2FiUCYj+Iuf1ZNLFlBHcNsuhtBDnt1JghpDS0f20Hbdo
	IYi1LF+szPSPWuck13ZsLeP1t1oz5WSuS8ye7Q0400
X-Gm-Gg: ASbGncsc/nk9U5vTXMsBrOQI0wBJoeVGRdgzuzXZv/gawnk6l/1stm1wFqj+i4PhQP8
	c6Inz/SmmUFsTWaZ3OeWc4N3gybIUPhupcOwf5T98BTHHiZd+8H3HItNSRwfHj5bL7trjwSkIAi
	wE/y7+dJNZqrgGJjDFSA==
X-Received: by 2002:a17:90b:1d12:b0:32d:e309:8d76 with SMTP id 98e67ed59e1d1-33455ee3d23mr5868328a91.10.1758875873468;
        Fri, 26 Sep 2025 01:37:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNdP3jcqkB/SoDVWTNElXZF3uJPrDyZBO4hpIYz3HUA2RYGm5n9SzDuM3YCq9dzEN8BUadAUt14kF1KaNWMbQ=
X-Received: by 2002:a17:90b:1d12:b0:32d:e309:8d76 with SMTP id
 98e67ed59e1d1-33455ee3d23mr5868294a91.10.1758875873078; Fri, 26 Sep 2025
 01:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925091335.1964283-1-eperezma@redhat.com> <20250925091335.1964283-6-eperezma@redhat.com>
 <CACGkMEvYw4=TPqQ=R51vYdgE786MWyPP0UcApiDhiCKWMQXR7Q@mail.gmail.com> <CAJaqyWcZGE0SD6Eed2WhiskYaSR0pSm3dMYf2j4TyfbZe3Qmrg@mail.gmail.com>
In-Reply-To: <CAJaqyWcZGE0SD6Eed2WhiskYaSR0pSm3dMYf2j4TyfbZe3Qmrg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Sep 2025 16:37:40 +0800
X-Gm-Features: AS18NWDaBIUtxrPONpil5WxsdzbxQccrHy2wvcmJyDtgutPrSWuat8Z7z0Ymi_4
Message-ID: <CACGkMEu6BcPfzuPFJ8REO6WGKmH+8n6S7c0Gjjzi+CP-q5kHQQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>, 
	virtualization@lists.linux.dev, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:17=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Sep 26, 2025 at 9:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Sep 25, 2025 at 5:14=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Add support for assigning Address Space Identifiers (ASIDs) to each V=
Q
> > > group.  This enables mapping each group into a distinct memory space.
> > >
> > > Now that the driver can change ASID in the middle of operation, the
> > > domain that each vq address point is also protected by domain_lock.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v4:

[...]

> > >   * Structure used by read(2) on /dev/vduse/$NAME.
> > > @@ -334,6 +376,9 @@ struct vduse_dev_request {
> > >                 struct vduse_vq_state vq_state;
> > >                 struct vduse_dev_status s;
> > >                 struct vduse_iova_range iova;
> > > +               /* Following members only if vduse api version >=3D 1=
 */;
> >
> > This comment is confusing since padding exists before.
> >
>
> Ok that's totally right. Should it say "following members but padding"?

That's fine.

Thanks


