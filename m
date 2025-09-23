Return-Path: <linux-kernel+bounces-828665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 156B9B9521E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0887B18A6517
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5759F31FEF7;
	Tue, 23 Sep 2025 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="kKRpg/SU"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E62E26560A;
	Tue, 23 Sep 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618433; cv=pass; b=m+6xlMFAAXwpRBptULKZDRuyZ5sZFO1dKy6t+B1t5NjciTUlGxoZ2E6Ctt0zSv1utAonPNOL3sqxb9GwzfBpTeJrH9vSZThMLyovUsJ8GvTH5EaCVHtkvlumDdPve6k7yj9QC2yRCS/3+pPWnf08Nm6pEEoyn5pR+t9gShIwpvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618433; c=relaxed/simple;
	bh=ukzqrYf9k9pS67YLftTtdCVwlVyx+OoIivE/4WwDr04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icmwfzok9G3eJFKSyIj24b2LX+/GV1ML29SLz2EU6+Zwea5FUI5IZh0VL+wFSg08yLsyu1O/h7X31LTnb4zuU8n/tzrVQBzehH04lh6zawYY4BBuvdpK3WtUYUxKzmEn4h8hlo5myhe5+DZ/DJmOYIu+UGvGSlJKMsnu01Sapro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=kKRpg/SU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758618417; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WUVll49IQ+H3NMXdoaT6K2RFOubCRIh8nTVDC130XCwvQtEqkgW8odYao0QpHWGZA2xf2Jbv8o0qKuvI0tFfylr9/nxi3kCX+idBXWtpHEJcFAlKIaoz0hoVm71HDpVu5PMQLDiz3LNzcUdlHe2qJS4++ljbea0gqmb6pMpDexk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758618417; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lDSLbWRe3/XSF6EHknU6DwHbBjpQeYWU/BRQOn+S+E0=; 
	b=iyt1yQ/3U0uKZsgnULMdD3f/prailyEXuo2yvBU6agBfC9hJYFRVhlb6Br75wjrLOitUQtw/oerKm/d6sCnnBRwp/BkIBbf+1WO7F5bqfOdQ69Ip+9imwWwAsmSJODvnX4LhPC+z5yGpfklXY9EPiS0Ueu0imU4nidq3sY9DKDg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758618417;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=lDSLbWRe3/XSF6EHknU6DwHbBjpQeYWU/BRQOn+S+E0=;
	b=kKRpg/SUMjRrSseNMULThv4AZ7il2w6TbWlp+iHoeVtfTNv9szWRJZDrbtPUkxQY
	3GUrqSzx5yxcXQaVFMbe0AhUSJ4BSHR01kILwd2HHJGoM34dbY2Cc8uozi9d7FxMtwq
	ftuXMxgrlPcDErDdb4GFWLL3L2WgpA9GKLS6HaLw=
Received: by mx.zohomail.com with SMTPS id 1758618414479846.6177567826774;
	Tue, 23 Sep 2025 02:06:54 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
 Jjian Zhou =?UTF-8?B?KOWRqOW7uik=?= <Jjian.Zhou@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "wenst@chromium.org" <wenst@chromium.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Date: Tue, 23 Sep 2025 11:06:50 +0200
Message-ID: <2382077.ElGaqSPkdT@workhorse>
In-Reply-To: <eb9b0ea70abb09f45c50e88b6221948ae09be6f7.camel@mediatek.com>
References:
 <20250822021217.1598-1-jjian.zhou@mediatek.com>
 <13850137.uLZWGnKmhe@workhorse>
 <eb9b0ea70abb09f45c50e88b6221948ae09be6f7.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 23 September 2025 04:35:59 Central European Summer Time Jjian Z=
hou (=E5=91=A8=E5=BB=BA) wrote:
> On Mon, 2025-09-22 at 15:10 +0200, Nicolas Frattaroli wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >=20
> >=20
> > On Monday, 22 September 2025 09:17:27 Central European Summer Time
> > Jjian Zhou (=E5=91=A8=E5=BB=BA) wrote:
> > > On Sat, 2025-09-20 at 23:02 -0500, Jassi Brar wrote:
> > > > External email : Please do not click links or open attachments
> > > > until
> > > > you have verified the sender or the content.
> > > >=20
> > > >=20
> > > > On Fri, Sep 19, 2025 at 2:02=E2=80=AFPM Nicolas Frattaroli
> > > > <nicolas.frattaroli@collabora.com> wrote:
> > > > >=20
> > > > > On Friday, 19 September 2025 18:32:12 Central European Summer
> > > > > Time
> > > > > Jassi Brar wrote:
> > > > > > On Fri, Sep 19, 2025 at 3:31=E2=80=AFAM Chen-Yu Tsai <
> > > > > > wenst@chromium.org>
> > > > > > wrote:
> > > > > > >=20
> > > > > > > On Fri, Sep 19, 2025 at 7:50=E2=80=AFAM Jassi Brar <
> > > > > > > jassisinghbrar@gmail.com> wrote:
> > > > > > > >=20
> > > > > > > > On Thu, Aug 21, 2025 at 9:12=E2=80=AFPM Jjian Zhou <
> > > > > > > > jjian.zhou@mediatek.com> wrote:
> > > > > > > >=20
> > > > > > > > .....
> > > > > > > >=20
> > > > > > > > > +#include <linux/module.h>
> > > > > > > > > +#include <linux/of.h>
> > > > > > > > > +#include <linux/platform_device.h>
> > > > > > > > > +#include <linux/slab.h>
> > > > > > > > > +
> > > > > > > > > +struct mtk_vcp_mbox_priv {
> > > > > > > >=20
> > > > > > > > Maybe 'mtk_vcp_mbox' is a more appropriate name ?
> > > > > > > >=20
> > > > > > > > > +       void __iomem *base;
> > > > > > > > > +       struct device *dev;
> > > > > > > > > +       struct mbox_controller mbox;
> > > > > > > > > +       const struct mtk_vcp_mbox_cfg *cfg;
> > > > > > > > > +       struct mtk_ipi_info ipi_recv;
> > > > > > > >=20
> > > > > > > > Maybe also have "struct mbox_chan chan[1]; " so that you
> > > > > > > > don't have to
> > > > > > > > allocate one during the probe.
> > > > > > > > Also if you have  "struct mbox_controller mbox;" as the
> > > > > > > > first
> > > > > > > > member,
> > > > > > > > you could simply typecast that to get this structure.
> > > > > > > > Something like "struct mpfs_mbox" in mailbox-mpfs.c
> > > > > > >=20
> > > > > > > I read somewhere that this way of subclassing is not
> > > > > > > recommended.
> > > > > > > Instead the base class should explicitly not be the first
> > > > > > > member.
> > > > > > > And then container_of() should be used.
> > > > > > >=20
> > > > > > > I don't remember where I read this though. But I think the
> > > > > > > explicit
> > > > > > > container_of() is easier for understanding the intent.
> > > > > > >=20
> > > > > >=20
> > > > > > And how does container_of() work ? :)
> > > > > > typcasting the first member to its parent is the simplest
> > > > > > form of
> > > > > > container_of.
> > > > > >=20
> > > > > > -j
> > > > > >=20
> > > > > >=20
> > > > >=20
> > > > > Which is why it's completely equivalent and since code is
> > > > > supposed
> > > > > to communicate meaning to humans, container_of should be used.
> > > > >=20
> > > >=20
> > > > Nobody is suggesting typecasting cfg, dev or anything else.
> > > > Typecasting between mailbox controllers is fine and arguably
> > > > easier
> > > > on
> > > > the eyes than using a container_of.
> > > >=20
> > > > -j
> > >=20
> > > OK. How about:
> > > struct mtk_vcp_mbox *priv =3D (struct mtk_vcp_mbox *)chan-
> > > > con_priv;
> > >=20
> > > Thanks.
> > >=20
> >=20
> > An explicit cast would be worse, as at that point you're telling
> > C to completely ignore any semblance of a type system it has.
> >=20
> >=20
> >=20
>      struct mtk_vcp_mbox *priv;=20
>      priv->dev =3D dev;
>      priv->chans[0].con_priv =3D priv;
> The type of con_priv is "void *".=20
> Would the conversion mentioned above also have the issue you mentioned?
>=20
> Thanks.
>=20

No, in that case the cast is implicit. While void pointers do
subvert the type system, they are needed in this case because
the con_priv member needs to point at structs of any type.

The problem is that when you do something like

  struct apple *a =3D something;
  struct orange *o =3D (struct orange *)a;

then if the two structs (apple and orange) are incompatible,
the compiler won't even yell at you, because you're explicitly
casting.

With an implicit cast:

  struct apple *a =3D something;
  struct orange *o =3D a;

the compiler will tell you if you're doing something wrong.
Here's a userspace code example to illustrate the point:

    #include <stdio.h>

    struct apple {
            const char *name;
            unsigned int weight;
    };

    struct orange {
            int x;
            int y;
            int z;
    };

    int main(int argc, char** argv)
    {
            struct apple a =3D {"Granny Smith", 200};
            // won't compile, good!
            /* struct orange *o =3D &a; */
            // will compile, bad!
            struct orange *o =3D (struct orange *)&a;

            printf("%d\n", o->x);

            return 0;
    }

If you comment out the second struct orange line and uncomment the
first, then you'll get a compilation error, which is what we want
because the two structs are incompatible and we don't want the
assignment to work in this case, as that would be a bug.

The second struct orange line always compiles, even though the two
structs are incompatible, and will cause nonsense to be printed.

I hope this illustrates the point I was trying to make, which is
that explicit casts make it harder to find issues because they
force the language to simply accept the cast rather than give us
a compilation error when something nonsensical is being done.

Kind regards,
Nicolas Frattaroli



