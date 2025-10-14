Return-Path: <linux-kernel+bounces-852629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC4BBD97ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B398189AE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D426A1BE;
	Tue, 14 Oct 2025 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5GxntrZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F0B3148AA;
	Tue, 14 Oct 2025 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446786; cv=none; b=AZa8JQAM5Zpz95ymVB1bIhbbw268wzjxDG0hh0qgNb5TYQpuTWyNFSADfcuSplj0fv32KerOtPhPAvTYXLgSVXYfUHjpil99w+Er9WM+zvsdWo8iiV3K01MdUuXnSjOWfk0ZGhdS6r4GGQQzhZfQXDArkCOrB/p3Bp4wETXLQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446786; c=relaxed/simple;
	bh=ZhISUXySewUzN/ns2FfxFiHN9csHHGyNg0LrJVsNY9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0iLSlX9ToWiwRdqa8RzGtzHQCtDbOIepz4FWXl1qG/qYL9X7AB7R16klBGmd57/+Ik8D5VA+yruPWH+04oeJCfXizNC9Jcci8BEgtBTA1uE6GCLFb56//irQ6MEOxv2BdWuftqDykUJ6WW2WWGBcqdFmvJ3BxACUckEhZvZqwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5GxntrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D81EC4CEF1;
	Tue, 14 Oct 2025 12:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760446786;
	bh=ZhISUXySewUzN/ns2FfxFiHN9csHHGyNg0LrJVsNY9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5GxntrZGSVfV8cfOzjBIyQVpgAh8GbR01ne23uHNx1XTCO9lnM4Q5r4tp9aaLJJT
	 FC7S+Xit/kxfdxh39Uu1Iv4XJHQamnRoaTkpmyK+vy4GdHOwhaihLx9HM4KtieCxm+
	 WimjbnMKDtAxlgtMUdqXRw7+qhEOxgmOs2GtoS2vFXKVKyiqnX2CmA71tiSfwmMg1E
	 ZRslKZFVPwaZ881xNcMC8X4fippQtqdGTmavb7fYd6ibSnKoOteYrpX3NRKvs/F8cV
	 GH2KRANMCAdF/C8ckLajW1fsorjFaUZONH078XWsdLHjUMCADbJyW3g6dmGzUM00U9
	 ullDWMLksH/+A==
Date: Tue, 14 Oct 2025 14:59:43 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Daniel Stone <daniel@fooishbar.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Liu Ying <victor.liu@nxp.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 00/11] drm/connector: hdmi: limit infoframes per
 driver capabilities
Message-ID: <2a5fitdzr2bz235fj6rvqzxr6ckszkjbazjfszlvnizdh2cvbt@w3ypjo7vahhs>
References: <st6wob5hden6ypxt2emzokfhl3ezpbuypv2kdtf5zdrdhlyjfw@l2neflb4uupo>
 <pe6g2fanw65p67kfy5blbtiytngxmr6nkbazymojs4a66yvpl3@7j4ccnsvc6az>
 <20250910-didactic-honored-chachalaca-f233b2@houat>
 <x562ueky2z5deqqmhl222moyrbylfwi35u4hb34dpl3z52ra4c@dyw4iayrewnz>
 <20250925-fervent-merry-beagle-2baba3@penduick>
 <qx5ashx62pufott6hnsfna3qntnoyvxwxze4rihhuxcsdxi37s@bbdvc3sfsgne>
 <20250929-gregarious-worm-of-memory-c5354d@houat>
 <itgffxygopi7etkt7xhvmyuvyl5ad3k43nsxvjzw3ubtwiikn7@ocugfdaigtu7>
 <20251003-uptight-echidna-of-stamina-815305@houat>
 <zpygq4kapil3swsmhhqkdwny4ry2dznnzixsw5rkza5p2kqnvp@abvf2vxlbwif>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="pv57vmkekis4fyrx"
Content-Disposition: inline
In-Reply-To: <zpygq4kapil3swsmhhqkdwny4ry2dznnzixsw5rkza5p2kqnvp@abvf2vxlbwif>


--pv57vmkekis4fyrx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/11] drm/connector: hdmi: limit infoframes per
 driver capabilities
MIME-Version: 1.0

On Fri, Oct 03, 2025 at 06:54:47PM +0300, Dmitry Baryshkov wrote:
> On Fri, Oct 03, 2025 at 03:22:23PM +0200, Maxime Ripard wrote:
> > On Tue, Sep 30, 2025 at 10:02:28AM +0300, Dmitry Baryshkov wrote:
> > > On Mon, Sep 29, 2025 at 03:00:04PM +0200, Maxime Ripard wrote:
> > > > On Thu, Sep 25, 2025 at 05:16:07PM +0300, Dmitry Baryshkov wrote:
> > > > > On Thu, Sep 25, 2025 at 03:13:47PM +0200, Maxime Ripard wrote:
> > > > > > On Wed, Sep 10, 2025 at 06:26:56PM +0300, Dmitry Baryshkov wrot=
e:
> > > > > > > On Wed, Sep 10, 2025 at 09:30:19AM +0200, Maxime Ripard wrote:
> > > > > > > > On Wed, Sep 03, 2025 at 03:03:43AM +0300, Dmitry Baryshkov =
wrote:
> > > > > > > > > On Tue, Sep 02, 2025 at 08:06:54PM +0200, Maxime Ripard w=
rote:
> > > > > > > > > > On Tue, Sep 02, 2025 at 06:45:44AM +0300, Dmitry Barysh=
kov wrote:
> > > > > > > > > > > On Mon, Sep 01, 2025 at 09:07:02AM +0200, Maxime Ripa=
rd wrote:
> > > > > > > > > > > > On Sun, Aug 31, 2025 at 01:29:13AM +0300, Dmitry Ba=
ryshkov wrote:
> > > > > > > > > > > > > On Sat, Aug 30, 2025 at 09:30:01AM +0200, Daniel =
Stone wrote:
> > > > > > > > > > > > > > Hi Dmitry,
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > On Sat, 30 Aug 2025 at 02:23, Dmitry Baryshkov
> > > > > > > > > > > > > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > > > > > > > > > > > > It's not uncommon for the particular device t=
o support only a subset of
> > > > > > > > > > > > > > > HDMI InfoFrames. It's not a big problem for t=
he kernel, since we adopted
> > > > > > > > > > > > > > > a model of ignoring the unsupported Infoframe=
s, but it's a bigger
> > > > > > > > > > > > > > > problem for the userspace: we end up having f=
iles in debugfs which do
> > > > > > > > > > > > > > > mot match what is being sent on the wire.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Sort that out, making sure that all interface=
s are consistent.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Thanks for the series, it's a really good clean=
up.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > I know that dw-hdmi-qp can support _any_ infofr=
ame, by manually
> > > > > > > > > > > > > > packing it into the two GHDMI banks. So the sup=
ported set there is
> > > > > > > > > > > > > > 'all of the currently well-known ones, plus any=
 two others, but only
> > > > > > > > > > > > > > two and not more'. I wonder if that has any eff=
ect on the interface
> > > > > > > > > > > > > > you were thinking about for userspace?
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > I was mostly concerned with the existing debugfs =
interface (as it is
> > > > > > > > > > > > > also used e.g. for edid-decode, etc).
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > It seems "everything + 2 spare" is more or less c=
ommon (ADV7511, MSM
> > > > > > > > > > > > > HDMI also have those. I don't have at hand the pr=
oper datasheet for
> > > > > > > > > > > > > LT9611 (non-UXC one), but I think its InfoFrames =
are also more or less
> > > > > > > > > > > > > generic).  Maybe we should change debugfs integra=
tion to register the
> > > > > > > > > > > > > file when the frame is being enabled and removing=
 it when it gets unset.
> > > > > > > > > > > >=20
> > > > > > > > > > > > But, like, for what benefit?
> > > > > > > > > > > >=20
> > > > > > > > > > > > It's a debugfs interface for userspace to consume. =
The current setup
> > > > > > > > > > > > works fine with edid-decode already. Why should we =
complicate the design
> > > > > > > > > > > > that much and create fun races like "I'm running ed=
id-decode in parallel
> > > > > > > > > > > > to a modeset that would remove the file I just open=
ed, what is the file
> > > > > > > > > > > > now?".
> > > > > > > > > > >=20
> > > > > > > > > > > Aren't we trading that with the 'I'm running edid-dec=
ode in paralle with
> > > > > > > > > > > to a modeset and the file suddenly becomes empty'?
> > > > > > > > > >=20
> > > > > > > > > > In that case, you know what the file is going to be: em=
pty. And you went
> > > > > > > > > > from a racy, straightforward, design to a racy, complic=
ated, design.
> > > > > > > > > >=20
> > > > > > > > > > It was my question before, but I still don't really see=
 what benefits it
> > > > > > > > > > would have, and why we need to care about it in the cor=
e, when it could
> > > > > > > > > > be dealt with in the drivers just fine on a case by cas=
e basis.
> > > > > > > > >=20
> > > > > > > > > Actually it can not: debugfs files are registered from th=
e core, not
> > > > > > > > > from the drivers. That's why I needed all the supported_i=
nfoframes
> > > > > > > > > (which later became software_infoframes).
> > > > > > > >=20
> > > > > > > > That's one thing we can change then.
> > > > > > > >=20
> > > > > > > > > Anyway, I'm fine with having empty files there.
> > > > > > > > >=20
> > > > > > > > > > > > > Then in the long run we can add 'slots' and alloc=
ate some of the frames
> > > > > > > > > > > > > to the slots. E.g. ADV7511 would get 'software AV=
I', 'software SPD',
> > > > > > > > > > > > > 'auto AUDIO' + 2 generic slots (and MPEG InfoFram=
e which can probably be
> > > > > > > > > > > > > salvaged as another generic one)). MSM HDMI would=
 get 'software AVI',
> > > > > > > > > > > > > 'software AUDIO' + 2 generic slots (+MPEG + obsuc=
re HDMI which I don't
> > > > > > > > > > > > > want to use). Then the framework might be able to=
 prioritize whether to
> > > > > > > > > > > > > use generic slots for important data (as DRM HDR,=
 HDMI) or less important
> > > > > > > > > > > > > (SPD).
> > > > > > > > > > > >=20
> > > > > > > > > > > > Why is it something for the framework to deal with?=
 If you want to have
> > > > > > > > > > > > extra infoframes in there, just go ahead and create=
 additional debugfs
> > > > > > > > > > > > files in your driver.
> > > > > > > > > > > >=20
> > > > > > > > > > > > If you want to have the slot mechanism, check in yo=
ur atomic_check that
> > > > > > > > > > > > only $NUM_SLOT at most infoframes are set.
> > > > > > > > > > >=20
> > > > > > > > > > > The driver can only decide that 'we have VSI, SPD and=
 DRM InfoFrames
> > > > > > > > > > > which is -ETOOMUCH for 2 generic slots'. The framewor=
k should be able to
> > > > > > > > > > > decide 'the device has 2 generic slots, we have HDR d=
ata, use VSI and
> > > > > > > > > > > DRM InfoFrames and disable SPD for now'.
> > > > > > > > > >=20
> > > > > > > > > > I mean... the spec does? The spec says when a particula=
r feature
> > > > > > > > > > requires to send a particular infoframe. If your device=
 cannot support
> > > > > > > > > > to have more than two "features" enabled at the same ti=
me, so be it. It
> > > > > > > > > > something that should be checked in that driver atomic_=
check.
> > > > > > > > >=20
> > > > > > > > > Sounds good to me. Let's have those checks in the drivers=
 until we
> > > > > > > > > actually have seveal drivers performing generic frame all=
ocation.
> > > > > > > > >=20
> > > > > > > > > > Or just don't register the SPD debugfs file, ignore it,=
 put a comment
> > > > > > > > > > there, and we're done too.
> > > > > > > > >=20
> > > > > > > > > It's generic code.
> > > > > > > > >=20
> > > > > > > > > > > But... We are not there yet and I don't have clear us=
ecase (we support
> > > > > > > > > > > HDR neither on ADV7511 nor on MSM HDMI, after careful=
ly reading the
> > > > > > > > > > > guide I realised that ADV7511 has normal audio infofr=
ames). Maybe I
> > > > > > > > > > > should drop all the 'auto' features, simplifying this=
 series and land
> > > > > > > > > > > [1] for LT9611UXC as I wanted origianlly.
> > > > > > > > > > >=20
> > > > > > > > > > > [1] https://lore.kernel.org/dri-devel/20250803-lt9611=
uxc-hdmi-v1-2-cb9ce1793acf@oss.qualcomm.com/
> > > > > > > > > >=20
> > > > > > > > > > Looking back at that series, I think it still has value=
 to rely on the
> > > > > > > > > > HDMI infrastructure at the very least for the atomic_ch=
eck sanitization.
> > > > > > > > > >=20
> > > > > > > > > > But since you wouldn't use the generated infoframes, ju=
st skip the
> > > > > > > > > > debugfs files registration. You're not lying to userspa=
ce anymore, and
> > > > > > > > > > you get the benefits of the HDMI framework.
> > > > > > > > >=20
> > > > > > > > > We create all infoframe files for all HDMI connectors.
> > > > > > > >=20
> > > > > > > > Then we can provide a debugfs_init helper to register all o=
f them, or
> > > > > > > > only some of them, and let the drivers figure it out.
> > > > > > > >=20
> > > > > > > > Worst case scenario, debugfs files will not get created, wh=
ich is a much
> > > > > > > > better outcome than having to put boilerplate in every driv=
er that will
> > > > > > > > get inconsistent over time.
> > > > > > >=20
> > > > > > > debugfs_init() for each infoframe or taking some kind of bitm=
ask?
> > > > > >=20
> > > > > > I meant turning hdmi_debugfs_add and create_hdmi_*_infoframe_fi=
le into
> > > > > > public helpers. That way, drivers that don't care can use the (=
renamed)
> > > > > > hdmi_debugfs_add, and drivers with different constraints can re=
gister
> > > > > > the relevant infoframes directly.
> > > > >=20
> > > > > Doesn't that mean more boilerplate?
> > > >=20
> > > > I don't think it would? In the general case, it wouldn't change
> > > > anything, and in special cases, then it's probably going to be diff=
erent
> > > > from one driver to the next so there's not much we can do.
> > > >=20
> > > > > In the end, LT9611UXC is a special case, for which I'm totally fi=
ne
> > > > > not to use HDMI helpers at this point: we don't control infoframes
> > > > > (hopefully that can change), we don't care about the TMDS clock, =
no
> > > > > CEC, etc.
> > > >=20
> > > > Not using the helpers sound pretty reasonable here too.
> > > >=20
> > > > > For all other usecases I'm fine with having atomic_check() unset =
all
> > > > > unsupported infoframes and having empty files in debugfs. Then we=
 can
> > > > > evolve over the time, once we see a pattern. We had several drive=
rs
> > > > > which had very limited infoframes support, but I think this now g=
ets
> > > > > sorted over the time.
> > > >=20
> > > > I never talked about atomic_check()? You were initially concerned t=
hat
> > > > the framework would expose data in debugfs that it's not using. Not
> > > > registering anything in debugfs solves that, but I'm not sure we ne=
ed to
> > > > special case atomic_check.
> > >=20
> > > Well... I ended up with [1], handling infoframes in the atomic_check()
> > > rather than registering fewer infoframe debugfs files. This way device
> > > state is consistent, we don't have enabled instances, etc. However it
> > > results in repetetive code in atomic_check().
> > >=20
> > > [1] https://lore.kernel.org/dri-devel/20250928-limit-infoframes-2-v2-=
0-6f8f5fd04214@oss.qualcomm.com/
> >=20
> > I guess we can continue the discussion there, but I'm not sure we want
> > to have more boilerplate in drivers, and especially in the atomic_check
> > part. If drivers are inconsistent or wrong in the debugfs path, there's
> > no major issue. If they are wrong in the atomic_check path, it will lead
> > to regressions, possibly in paths that are pretty hard to test.
>=20
> You've responded there and I can drop the extra handling for HDR DRM and
> audio infoframes in the atomic_check(). What is your opinion about the
> atomic_check() unsetting the infoframe->set for SPD and HDMI infoframes?

HDMI infoframes are mandatory, so that's a big no-no.

For SPD, It's really not clear to me why atomic_check should do that in
the first place. Your initial concern was about exposing infoframes in
debugfs that wouldn't be used by the driver.

If the driver doesn't register a debugfs file for SPD, and ignores
whatever is in the atomic state, what's should we force drivers to do
that?

Maxime

--pv57vmkekis4fyrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaO5JPwAKCRAnX84Zoj2+
duEAAX9yKv7uO8VdcjYR4Kwp6gikm4F/ln5YezNtMS7ZHqhWc+NrtUr5L8x46LXk
I/EVxMMBf1r9Titw4ePMiR4JKKB6wRidwH6Of9oE3SGDW33XlGXF4J2CPSg6crPm
SdIMbyrDLA==
=8YRt
-----END PGP SIGNATURE-----

--pv57vmkekis4fyrx--

