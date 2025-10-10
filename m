Return-Path: <linux-kernel+bounces-847755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8AFBCB963
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8211A63D32
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC2A1D5170;
	Fri, 10 Oct 2025 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2gMUaDe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49E3FB31
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760068750; cv=none; b=jQY9ehCJwD03hD+3lW7rt2qXHgzefrkvEbYNYnvDG24xbLqX5qiPa8BrW/wvO0zSGPLFo5/gjVLF52J/jzLazsLBncMDru8g2cBckp7ymixd0Phfzt81W4oTZcwSBpLXm1b5EdV7LiaZ5qnOyyrpud48A3/JtwZ0LPVKmlRTG9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760068750; c=relaxed/simple;
	bh=OOowEg/kEpwQ0lfAfbo1RCLo+763fhF3zIXfDo/uL2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UN+nwimwIK5ZuR3h8F5ZNDUmGsDGB/IfOhp3igu5S+0ypbKznUPgfeyFfqi9DbGRoSU+Ny3A3AFXzppQwnu1z3V29/lO6jBZ+THyG1X4Cmdjg/Ge9DLzT0lp16pbksLYzUPsE6yEABhtBunRYXjxZ0/gdWNKuEnXxJzexBXvpkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2gMUaDe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760068746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTGZcY56/dokYZNCRBhJDePRYFdQBXGbtHcTvy8LlVQ=;
	b=b2gMUaDeZF9TP2rDmWmdqVF4uGYjeD4kIUXI7SaW19yG5RjQTiZ9sN9bNB4pzxhc/U3CiG
	tPFDWWrigg6ZjiLgzpPyxxmqQQpU4mT3ae5KKjWOp+GCk2QsFvbAnp+wRnHbgbwdQlq5SL
	92Wi3cYZwpCZCp/leg0t/yE90Sp/d+w=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-FqYqQsGKNgiXUBlTIUQlug-1; Thu, 09 Oct 2025 23:59:05 -0400
X-MC-Unique: FqYqQsGKNgiXUBlTIUQlug-1
X-Mimecast-MFC-AGG-ID: FqYqQsGKNgiXUBlTIUQlug_1760068744
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b630753cc38so4352009a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 20:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760068744; x=1760673544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTGZcY56/dokYZNCRBhJDePRYFdQBXGbtHcTvy8LlVQ=;
        b=Oun6bSEJxuHxEqFiceDCade06ZF1n8xXXcpANj6l7+lcwHXZKu3sAyXhvhdgGu/Bdq
         EhOV21SThdnkOWgAyi5Be5IW5orpKeNCBSdnzOkTVx+PjFWh9hkkl5oCsu3AtCxnb0oJ
         QQ9nwTHZi4198gnfANijnbk6HoFeb7g+wozdIrfDIGmNZ+DFxbAjR36RhlQSf44YZmN9
         IQa2C9xQLCLJYfpm1bhGoqqcYuIxhd77Ej1diuhsyUTsgKaWycZuxDtkY8O9+IncgdRJ
         dmhRwrPgRSvZAmBu2/Bw588aVi5/EIYXUxgiT4vfIFBnvPhUdK6uWR+QGmKNOZR9emnE
         Rvkg==
X-Forwarded-Encrypted: i=1; AJvYcCXlGfZA67eGmF9OEeCGIWJSEUah6x3tgMXHa4W+jJxNnrlQnNQX7gAjkXTVEtiv92h3WXDZS3jELCvJEhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAplwk7pD2zZcerVJFiaEahENEXTSznp58lk+DsiqDNpCAe0N
	a46YMnxhyLT6lxYkYl0hOxzZIn27mytcc+ms99FJ9tPvu99S8HvI8FxRTPtJkQdGevhsF7CHWY3
	mD7kDMZNbzn+mtRpw5EsbESUlXXbEwO+i4ulMjBriqg9adhfkuu2IBSQNMJltqYq9sBqNrD8l12
	meas9emgbVlk74Gtl6E6I1D1kAasz+kkHqsZEPEwDL
X-Gm-Gg: ASbGncsPn4gr7yGZyxK+jOsTzxyUvYj6nVw7PhB2zAb0g5znu4jmRqWfF/0ui6G/lr8
	9wgKLtCp5hscLKnPzOicr1ZklfDBzcGFvX/ds1qvqlGefPFPtbLNv2jcMJG4ayZWZGhW0OAFjnm
	dG9fgJZKiHTFInHJ/0v+1riA==
X-Received: by 2002:a17:90b:1e05:b0:32e:64ca:e84a with SMTP id 98e67ed59e1d1-33b51162572mr14729295a91.12.1760068743871;
        Thu, 09 Oct 2025 20:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3LgHkeItfKnzksx2+VbTfs5eW8tDQx+zY+LgfqMUL2flkA6GpUP6M0cgBlsLMGMJv8UZaOLmaiFPSWsXCyYM=
X-Received: by 2002:a17:90b:1e05:b0:32e:64ca:e84a with SMTP id
 98e67ed59e1d1-33b51162572mr14729270a91.12.1760068743399; Thu, 09 Oct 2025
 20:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002103537.308717-1-eperezma@redhat.com> <20251002103537.308717-3-eperezma@redhat.com>
 <CACGkMEucnJMs0QcH4ggourizEGsvkzF-d_OYXy0XBeU_opdNAQ@mail.gmail.com>
In-Reply-To: <CACGkMEucnJMs0QcH4ggourizEGsvkzF-d_OYXy0XBeU_opdNAQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Oct 2025 11:58:52 +0800
X-Gm-Features: AS18NWBtRCPzDFJG5Q7UQQXe3VTwnoyqKwTQOUsdAeF4GtUTRJFpiT8J0K9euhI
Message-ID: <CACGkMEtG_zbbXPx8ZYfCm09GG4hRVeEQp6FBFzXZLP_-PrvCJw@mail.gmail.com>
Subject: Re: [RFC 2/2] vduse: allow to specify device-specific features if
 it's multiclass
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: mst@redhat.com, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, Cindy Lu <lulu@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Jonah Palmer <jonah.palmer@oracle.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, 
	=?UTF-8?Q?Be=C3=B1at_Gartzia_Arruabarrena?= <bgartzia@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 9:39=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Oct 2, 2025 at 6:36=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > Even if the device supports more than one class, there are ways to solv=
e
> > the ambiguity of which device are we creating.  In the VDUSE case it is
> > the name, for example.
>
> This may only work for VDUSE but not other parents.
>
> >
> > RFC: I fon't understand 100% the motivation of this limitation, as the
> > backend should be the one filtering out the invalid features if any.
>
> I think we can avoid these tricks. Currently, there's a one single
> mgmt device, this seems to be in-convenient. Could we have a per
> device mgmt device? For example, if user space creates vduse0, vdpa
> mgmtdev show may see vduse0 so we won't have this issue.

Or if we specify the class, there won't be ambiguity.

Thanks

>
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vdpa/vdpa.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 34874beb0152..0fc32f3bd66f 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -688,15 +688,6 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_=
buff *skb, struct genl_info *i
> >                 err =3D -EINVAL;
> >                 goto err;
> >         }
> > -       if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
> > -           config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
> > -           classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
> > -           config.device_features & VIRTIO_DEVICE_F_MASK) {
> > -               NL_SET_ERR_MSG_MOD(info->extack,
> > -                                  "Management device supports multi-cl=
ass while device features specified are ambiguous");
> > -               err =3D -EINVAL;
> > -               goto err;
> > -       }
> >
> >         err =3D mdev->ops->dev_add(mdev, name, &config);
> >  err:
> > --
> > 2.51.0
> >
>
> Thanks


