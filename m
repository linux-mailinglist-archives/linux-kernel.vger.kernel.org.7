Return-Path: <linux-kernel+bounces-841393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8572CBB7302
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D30819E7E92
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD7423AB8D;
	Fri,  3 Oct 2025 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgtkU7tp"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B44C6C
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501983; cv=none; b=nw7zlPqIOmIVnct+VYY5KVomksX8XRjc5OtRt7PBnGA29Bx4TLNXaQpIkfp5VvZkkOh9ZtrhynPK2gNSfV1Lk+Vh45q5P3Fl/Uv5Nctdr+0uPSfWPDTFEoh0z1x+6U/6Ic1uEBVef95UGtKzp3at7C4MMVrXV4e4RPJuzgIoqc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501983; c=relaxed/simple;
	bh=ArI0GMic8uk/1kAkM79WN6gznjdosKe4PSqQZ8k9PK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euwQ71+j9iknTCmaFmEJqlIoa/vrvktSZiOGy506K8kQHyTpB7WGDkRdnewqiGLEeAbiFDHI3WyJ21+2J+LHsL/Bo474aV7Csiow8AeRLzxlmRTYrEo5UYNP1HTjb0lpf3GphIASvznQ7TXq9kwu72BArM5Rk5HWtRd3csoNYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgtkU7tp; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3737d09d123so25397571fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759501978; x=1760106778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mxBl+91XREs3rrt+Mm+HGe169ZpfgbUuMF9IKmnb3I=;
        b=fgtkU7tp8t9FJx+n6MdmpSaI96wKnMB946Ia6juEpMapqFaiDzBKU6Myu/l99TPONl
         X5NzYAznh9OzpsvyXuK+O8vHNGlTTUQ1WjUPFWSSi1o3O4pVptvRrU7M0ADp7xg313qo
         Go50Y9Q+75bf4JbHAzc72ujOQu5a5jJUpSrzrR3PA09KstyJbTEkjzZNOvf5fBxYqROX
         5v8IYWSutFofAk1ESXC42mRAIHRn3kXhGopqySi46gJwiXHBTy6/rvHRwNdFwxLx1PN+
         M4zyU0ka9hzeLELILZOgUcgvH3jnrvBJJn/8HxfwzfpX0Iloz7Z9St9zi8x8iRLHF+7d
         r6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759501978; x=1760106778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mxBl+91XREs3rrt+Mm+HGe169ZpfgbUuMF9IKmnb3I=;
        b=cjZGhWlPYJwPk2jtz5Q2R1j1mRBaxqIzBHolPUuV1U4fcVu+qxu+g4qC2VAD5dc81e
         mQbIHHlUovo/Z5/0prDI4XWDTT+y3MF75B81OmFDW+pcz/uMp6kddAkmici8IotXbSaE
         KJTC+A3HqtwlnOHb30MHozGFUgBDRfVR1wRYNc6nZeRumokzAeHnNVACBSCbi6sJ+0KU
         lGuomoRNw/qCXZxt9bsZ0SbFSTjjcBa060MP+sgq7KnfFZAEzhUeihIbEzxkoYdlaBSn
         KaGbp7BTFtKHWUxmgtdQpcKu4X41kb9Zl3flOG7GJAcbaM0GND2WUAU2QGBLUxTBXk9P
         u48Q==
X-Forwarded-Encrypted: i=1; AJvYcCXA/9xufcl7qE6P4OA0SwsyseUpsMyXseGB9I2d6Z8RwcFv1T3GPrePEibpbGl1NGV9T5wdmKc2rF25JQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuqn4yVLcT6acH4e6oYUm2i86iN2+tRhDaia79mRY/7rp+uTAz
	f3lR67JZcLPD/+MMsSaDjsjxVE5aWtiXN19HqGWQQVsjLpGnx8mgofY2w9pV7Qe0LN0pR9EwVeF
	h/tC3TwtPqxFnCd+f4aanRKUGHsc3jEc=
X-Gm-Gg: ASbGnctQ/wJ3fKIZX8beW3OaKz8WfcLhCvFWJwVIEeq6UVDFR4X4wYtdnVUhwm23a3T
	uPidrwvdNt/iD5BbFg0813gQ1eOWspzELK5EfY1Qazg3RSmp8T9a36BBm0fvty9RpvCp9VY6vAZ
	zdQzsO+1KvoZO/M1W+Hi+CckNlgssqo//dy0DGncviVO7GTcWCDFRaZhbXtXYKudrvb3odZggk6
	YR9Ll0M+bupmenb5hcL2kzKBa/tcJGtlCfINlIP
X-Google-Smtp-Source: AGHT+IHMEYf9LUvT+7M4GPywBvEmEbLwMBFLFIBedNHzqtzmaPYWYwMrkMOiqneX0J3Yyd6PeW5sBlD7r5kNWSSHALo=
X-Received: by 2002:a05:651c:a07:b0:372:950f:2aff with SMTP id
 38308e7fff4ca-374c37eb5d7mr10596021fa.27.1759501977328; Fri, 03 Oct 2025
 07:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001183320.83221-1-ariel.dalessandro@collabora.com>
 <175943240204.235529.17735630695826458855.robh@kernel.org>
 <CABBYNZKSFCes1ag0oiEptKpifb=gqLt1LQ+mdvF8tYRj8uDDuQ@mail.gmail.com> <CAL_Jsq+Y6uuyiRo+UV-nz+TyjQzxx4H12auHHy6RdsLtThefhA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+Y6uuyiRo+UV-nz+TyjQzxx4H12auHHy6RdsLtThefhA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 Oct 2025 10:32:44 -0400
X-Gm-Features: AS18NWAxN1IhfgHRDQEAVNRk-gv2qRra_zfz_DZsOprYcJI8wwK8KzxwPe_vG4Y
Message-ID: <CABBYNZKxGNXS2m7_VAf1d_Ci3uW4xG2NamXZ0UVaHvKvHi07Jg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: net: Convert Marvell 8897/8997 bindings
 to DT schema
To: Rob Herring <robh@kernel.org>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, andrew+netdev@lunn.ch, 
	conor+dt@kernel.org, kernel@collabora.com, krzk+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, kuba@kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Fri, Oct 3, 2025 at 9:38=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Oct 2, 2025 at 2:18=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi,
> >
> > On Thu, Oct 2, 2025 at 3:14=E2=80=AFPM Rob Herring (Arm) <robh@kernel.o=
rg> wrote:
> > >
> > >
> > > On Wed, 01 Oct 2025 15:33:20 -0300, Ariel D'Alessandro wrote:
> > > > Convert the existing text-based DT bindings for Marvell 8897/8997
> > > > (sd8897/sd8997) bluetooth devices controller to a DT schema.
> > > >
> > > > While here, bindings for "usb1286,204e" (USB interface) are dropped=
 from
> > > > the DT   schema definition as these are currently documented in fil=
e [0].
> > > >
> > > > [0] Documentation/devicetree/bindings/net/btusb.txt
> > > >
> > > > Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> > > > ---
> > > >  .../net/bluetooth/marvell,sd8897-bt.yaml      | 79 +++++++++++++++=
+++
> > > >  .../devicetree/bindings/net/btusb.txt         |  2 +-
> > > >  .../bindings/net/marvell-bt-8xxx.txt          | 83 ---------------=
----
> > > >  3 files changed, 80 insertions(+), 84 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/bluetooth=
/marvell,sd8897-bt.yaml
> > > >  delete mode 100644 Documentation/devicetree/bindings/net/marvell-b=
t-8xxx.txt
> > > >
> > >
> > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > >
> > > You'll probably have to resend this after rc1.
> >
> > In that case I'd like to have a Fixes tag so I can remember to send it
> > as rc1 is tagged.
>
> A Fixes tag is not appropriate for a conversion to DT schema.

Ok, but then how do you justify merging it for an RC? Or I'm
misunderstanding and that should just be merged to bluetooth-next and
wait for the next merge window? In that case I can just merge it right
away.

> Rob



--=20
Luiz Augusto von Dentz

