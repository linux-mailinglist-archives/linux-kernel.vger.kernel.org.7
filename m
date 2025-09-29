Return-Path: <linux-kernel+bounces-836066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA28EBA8A62
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6467B7B5F80
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD792C08D0;
	Mon, 29 Sep 2025 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZ4MsD4p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE50287242
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138344; cv=none; b=nBf0r39Rz2AzaXXeShV8bWciZfJTA3B4Ln/CFLnQghcTe+WoMHJEo/GW8TcKovii0QSS2xVXYAZAsIKKP5cixGOyC0kCfY8bSkSa59N3Bh3Nsb6IbQdEYJz3K3/sCxwt9pB/qfJOqW8vv7j4469iArP3E9gaFmpDaGerBF0yyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138344; c=relaxed/simple;
	bh=tRlCeKapaHivi1z9mpOZ4dZsC2e2BvGEiyL1Q6ztdYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGfGZUlzhxmSU5k8aP+vejxqjBAh+4dO3ku5nbK4o+CwlKZtt6VCzcBQzeMAJCbYRogPTtf+v9x9rpNSyKTxO4pjuwQxrjX0BQ2x/foWUZhVRS+Qv3eolVqSh6FbRwVw2vFbIqH9AoVKIYZLAoG4BELokzqh8TR6LUR34FZtJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZ4MsD4p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759138341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlMsLwy3WLm54JkcIfPWsIORtQrkYyQjfvD/TAnZkcU=;
	b=KZ4MsD4ppMd7URyJUhq4JZzARNkIddjf4RrDOQ+tj2FzT0ARdv7EUQswRaz6xuyEoRBhcC
	ZxNIzEyiEEn/Jf1jY/9vhLO4XmWGAVZQUIebuLt87/k55OH4QIIrst8139S172DaK9tQm5
	Y5SrJDsXo+k+lrUg2En4VGpkYcU1V+o=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-a8hSjEiUM0SuHXwakJ5u6g-1; Mon, 29 Sep 2025 05:32:19 -0400
X-MC-Unique: a8hSjEiUM0SuHXwakJ5u6g-1
X-Mimecast-MFC-AGG-ID: a8hSjEiUM0SuHXwakJ5u6g_1759138339
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-633b0b69560so5510560d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138339; x=1759743139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlMsLwy3WLm54JkcIfPWsIORtQrkYyQjfvD/TAnZkcU=;
        b=KkeVf9uAyGWiNekFgGELBPP50OTQpsfuV2tI53kevfZ5zGB3H75yQFwOSQn/XrBsd9
         AVIq0AcZjf5bTAPDXU5lK+7THf5FxLMLh9KFuhxqoO3AqeAWtqv6NxhOysyAdlClZa7o
         WppDVd/Fz8DTa3sVX7YN6FCSuCyeAx7BQSxFn2Hr/hqzk/dJFdypWy4/0SUrAKwGn0/o
         roYygAuJ31yY/O7SgkBbbj22geG7NFVM/LtU81BrRuaWy0SGXLpT0hUD4vz/hIT7U9FR
         XXLiBcvwy0Q4Wzu/s/2EGjHzL3nIAP3+C4yneGq+VPuYCPc51cnrItmk4GNqCxJUpKTM
         Nnag==
X-Forwarded-Encrypted: i=1; AJvYcCVfQqT/3B7cnh18+yRVDkOyKmH8VdXqMi5kxS/Wu2EgUxU8m00OAtPH0SyU4RKlp1xQhkUZr7urZohvlBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw75WBIr0go8O/pdPt8nwRqrGs5lWROxtvePi1ZkaEGlU+5SnqI
	3Qj8fHlW3cD04UAGH1eDpFaFx+ggtQ+kNOxKxxFIGeWwugYlHA2/BfEN3aXLlkTKFXnh1mFGk1N
	o+SL6fskcEZpaG4XlBG8pYpMS6CzYfrZlU98gD52gWhUrXXk38lvr2Kk7SgvxPdBMfTLbRznN7w
	CA02DDfgm5pXgqtMroPr15HbBxSplq7/y02UHhGVau
X-Gm-Gg: ASbGncsPUxGyoQZp91OhKLgOmMUskTGfAawlK4/y/vj91mU1UE2w45fjxo4fN7V0xcB
	TcKNx/SSzLopSaP3gUKs/GJWfIsH/0TGH5BcB83y2Sa1muZuiOqccyMmIFnzvSppjNrXA49DVNC
	UnPvwrSLUSSIh33zeprpieYSIYdTe4XoEY1c7dK5/cEynVxlFT4OxaGjDMg+vqGAwbQBOern2bn
	Upr+TRI
X-Received: by 2002:a53:b101:0:b0:635:4ece:240e with SMTP id 956f58d0204a3-6361a8942a4mr11353296d50.46.1759138339071;
        Mon, 29 Sep 2025 02:32:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHy+bULXPDOs/qHcu9LtFCBeRBbU69BmiLaVMmQBKXPClmvubqUFg0/zFKG+EzGjCEwcb3k78I723etJseX9U=
X-Received: by 2002:a53:b101:0:b0:635:4ece:240e with SMTP id
 956f58d0204a3-6361a8942a4mr11353287d50.46.1759138338745; Mon, 29 Sep 2025
 02:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926101432.2251301-1-eperezma@redhat.com> <20250926101432.2251301-4-eperezma@redhat.com>
 <20250926112622-mutt-send-email-mst@kernel.org> <CAJaqyWdeA5xcozCsaYD3_bQ6riN1pdDGHLpMGjU7ejZmNZ4qig@mail.gmail.com>
 <20250929035510-mutt-send-email-mst@kernel.org> <CAJaqyWdQkJgUKqne0_ivLTpQ3rD9tfzcEZL26o5ZdcQsjrJL_g@mail.gmail.com>
 <20250929052852-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250929052852-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 11:31:42 +0200
X-Gm-Features: AS18NWDuOBT2bwV9nzqyFm9hfDzUHxeT7TYwcpE2HUEQRG_j9iM5gtnBrZ_KOY4
Message-ID: <CAJaqyWeAHcrMmsM2u+LqRhbFBBgoTuQFc1m+=XHWHC3UqDUfxg@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:29=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Sep 29, 2025 at 10:52:45AM +0200, Eugenio Perez Martin wrote:
> > On Mon, Sep 29, 2025 at 9:55=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Sep 29, 2025 at 07:55:59AM +0200, Eugenio Perez Martin wrote:
> > > > On Fri, Sep 26, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio P=C3=A9rez wrot=
e:
> > > > > > @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_=
dev_config *config,
> > > > > >       dev->device_features =3D config->features;
> > > > > >       dev->device_id =3D config->device_id;
> > > > > >       dev->vendor_id =3D config->vendor_id;
> > > > > > +     dev->ngroups =3D (dev->api_version < 1) ? 1 : config->ngr=
oups;
> > > > >
> > > > > Is this < 1 same as VDUSE_API_VERSION_1? If so, maybe use that?
> > > > >
> > > >
> > > > The macro for v0 is called VDUSE_API_VERSION, so I think it is less
> > > > intuitive to put:
> > > > dev->api_version =3D=3D VDUSE_API_VERSION
> > > >
> > > > But I'm ok with the change if you want.
> > >
> > > Confused. You mean "more intuitive"?
> > >
> >
> > Ok think I misread your comment,
> >
> > I find
> >
> > (dev->api_version < 1) ? ...
> >
> > more intuitive than
> >
> > (dev->api_version =3D=3D VDUSE_API_VERSION) ? ...
> >
> > But now I think you meant
> >
> > (dev->api_version < VDUSE_API_VERSION_1) ? ...
> >
> > Is that right?
>
> That's right.
>

Ok, take it for granted in v6!


