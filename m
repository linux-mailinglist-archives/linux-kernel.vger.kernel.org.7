Return-Path: <linux-kernel+bounces-799245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB564B428EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869153AFFDE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD90A36809A;
	Wed,  3 Sep 2025 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="Jo1eOqAT"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2857C3629B8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925031; cv=pass; b=DuEa8nj3+bfXMA4E3xqj9z3sZ1Z5QdYIyDU/IkBthyD0VaOs/X8ypwPm9S2IBEyN5x94WCMX7qyUf/GIsMTfxYqEbFyTCutxr8vhjGKONYZg7euz+gPnhyxBh4KcRCgZem1h6PnSnQes1skVzhtxLJv/e8nMolHyePAKFqpvhzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925031; c=relaxed/simple;
	bh=mVVxg8GWE4G6crBZIhefiyImIkUh+D8hyZX7Ycao6FY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CFh256V5lyTBNwrCAd7IuSOFKuSnN/JvVQ0V59/KasicqaLkHKWBr285nDlZRMAhVS8AMcvHvl5kyer0gsR//UTk3jco4LHQGQ3y+H/YG84RCPW1e7b6ZYwtdJ0+kgUVRIoxhM8yGAGDsndC5jFzmlaht4yPELi+qkvGmp19/sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=Jo1eOqAT; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756924941; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XPN1vKcx8Ej224AtZVj8ZCULAAnbkrzDGKmbONvCEkg8h0+2l8E9mxYRh78Jd211J5Yl85xXARVlrrmU5TVjV7pD7h/TFxVW9Z+i554tUn271xCAWqOvs29yNsgTTvRYZ65XJ9RS5WPvJ4R0NhZ7OVH8KsFfOyps1LB1+/AXE4I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756924941; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=N3wTVuzRWFsLOmgF08rX8v9agtMLx+eUNjsrlNZ33Qw=; 
	b=ACPIjUrLHMabibtDfsKXZrSSris3uh3lJmHY78Cvvmg3t2l+crKWa+Mz1P4NIZq1rZLWNCGmzOvJZN1jIAtx07UjCWQE5k/LdRei/w25nl3QI10V743TrG1VqaO42yYlcmYikFfknR58tTlcboCH5WIcRhzwLUZd2BTvZhzpMNI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756924941;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=N3wTVuzRWFsLOmgF08rX8v9agtMLx+eUNjsrlNZ33Qw=;
	b=Jo1eOqATLjRJA8HTdL2X5U8rl6y8yyfGPZYaNl9OH+UqdX57//qTAM0JeYml0vJM
	zQHHIrC/TKwg5vZBW3hvpMxQtb7zaxUWydAb1f3eYfei+stG3e75zv6/B0N78IqP4YT
	EHlzVNyxP/1DhFoJbKHHpNUBd8aThUouP2eATzTM=
Received: by mx.zohomail.com with SMTPS id 1756924938273225.66438221064573;
	Wed, 3 Sep 2025 11:42:18 -0700 (PDT)
Message-ID: <269ca85a59f613568543f45867fba7e604cc9f11.camel@collabora.com>
Subject: Re: [PATCH RFC 1/5] drm: Support post-blend color pipeline API
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: Daniel Stone <daniel@fooishbar.org>, Xaver Hugl <xaver.hugl@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Chun-Kuang Hu	
 <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Alex Hung <alex.hung@amd.com>, 
	wayland-devel@lists.freedesktop.org, harry.wentland@amd.com,
 leo.liu@amd.com, 	ville.syrjala@linux.intel.com,
 pekka.paalanen@collabora.com, contact@emersion.fr, 	mwen@igalia.com,
 jadahl@redhat.com, sebastian.wick@redhat.com, 	shashank.sharma@amd.com,
 agoins@nvidia.com, joshua@froggi.es, mdaenzer@redhat.com, 
	aleixpol@kde.org, victoria@system76.com, uma.shankar@intel.com, 
	quic_naseer@quicinc.com, quic_cbraga@quicinc.com,
 quic_abhinavk@quicinc.com, 	marcan@marcan.st, Liviu.Dudau@arm.com,
 sashamcintosh@google.com, 	chaitanya.kumar.borah@intel.com,
 louis.chauvet@bootlin.com, mcanal@igalia.com, 	kernel@collabora.com,
 daniels@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Simona Vetter <simona.vetter@ffwll.ch>
Date: Wed, 03 Sep 2025 14:42:14 -0400
In-Reply-To: <CAPj87rMTOD3_tC70QX4xz3G4zdG=tmwt5VgPhq6jNyf8bbW49Q@mail.gmail.com>
References: 
	<20250822-mtk-post-blend-color-pipeline-v1-0-a9446d4aca82@collabora.com>
	 <20250822-mtk-post-blend-color-pipeline-v1-1-a9446d4aca82@collabora.com>
	 <CAPj87rPAoD2D99zTdsvJ=9K8+G17mTS2jDYHMPYmXNtUyp2L_Q@mail.gmail.com>
	 <CAFZQkGwotQ6cxVCSgp-BhUi5DaZ7MyVvbnrDJW11Z7ztzqy58g@mail.gmail.com>
	 <CAPj87rMTOD3_tC70QX4xz3G4zdG=tmwt5VgPhq6jNyf8bbW49Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-ZohoMail-Owner: <269ca85a59f613568543f45867fba7e604cc9f11.camel@collabora.com>+zmo_0_nfraprado@collabora.com

On Tue, 2025-08-26 at 13:25 +0100, Daniel Stone wrote:
> Hi,
>=20
> On Mon, 25 Aug 2025 at 19:45, Xaver Hugl <xaver.hugl@gmail.com>
> wrote:
> > > > @@ -416,6 +417,24 @@ int drm_mode_object_get_properties(struct
> > > > drm_mode_object *obj, bool atomic,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (post_blend_color_pipeline && obj->type =3D=3D
> > > > DRM_MODE_OBJECT_CRTC) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct d=
rm_crtc *crtc =3D
> > > > obj_to_crtc(obj);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct d=
rm_mode_config mode_config =3D
> > > > crtc->dev->mode_config;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (prop=
 =3D=3D
> > > > mode_config.gamma_lut_property ||
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 prop =3D=3D
> > > > mode_config.degamma_lut_property ||
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 prop =3D=3D
> > > > mode_config.gamma_lut_size_property ||
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 prop =3D=3D mode_config.ctm_property)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!post_blend_color_pipeline && obj->type =3D=3D
> > > > DRM_MODE_OBJECT_CRTC) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct d=
rm_crtc *crtc =3D
> > > > obj_to_crtc(obj);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (prop=
 =3D=3D crtc-
> > > > >color_pipeline_property)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > Hmmm. One issue with this is that it makes things like drm_info
> > > harder: if drm_info opted into the client cap, it would no longer
> > > be
> > > able to see any GAMMA_LUT/etc programmed by the prior userspace.
> > > So I
> > > think allowing at least read-only access would be reasonable
> > > here.
> >=20
> > FWIW the cap for per-plane pipelines also hides COLOR_RANGE and
> > COLOR_ENCODING properties from the client.
> >=20
> > From a compositor POV, I slightly prefer hiding the properties
> > entirely, but ignoring them on the compositor side when a color
> > pipeline is available would also be trivial.
>=20
> It makes it impossible to do smooth transitions from legacy clients,
> as the old (current) properties can't be read back.
>=20
> I assume the atomic state would also carry the old values (even if
> the
> drivers are specified to have to ignore them), so there would be an
> odd transition:
> * pre-colorop userspace sets GAMMA_LUT to invert brightness
> * colorop userspace takes over, does not set any colorops on the
> CRTC,
> brightness is no longer inverted (presumably? depends on what the
> default set of colorops is? and what the drivers do?), but the atomic
> state still carries the old gamma_lut blob
> * pre-colorop userspace takes over, does not touch GAMMA_LUT,
> brightness is inverted as the colorop from the previous atomic state
> is ignored and the pre-atomic one now takes precedence
>=20
> This isn't necessarily wrong per se, but does seem kind of janky and
> error-prone: like should the old state be reset to zero/bypass for
> commits from colorop-aware clients? Or should we explicitly allow 0
> but no other value?

Hi, thanks for the feedback!

Based on this discussion, this is my understanding for the changes
desired on the series and their reasonings:

1. Add a driver cap, DRM_CAP_POST_BLEND_COLOR_PIPELINE, which drivers
will use to signal they support post-blend color pipelines.
  - Reason: Allow userspace to figure out that the driver doesn't
support post-blend color pipelines and choose to not set the client
cap, DRM_CLIENT_CAP_POST_BLEND_COLOR_PIPELINE, so it can use legacy
color management instead.
2. Make it so setting the client cap,
DRM_CLIENT_CAP_POST_BLEND_COLOR_PIPELINE, fails if the driver cap,
DRM_CAP_POST_BLEND_COLOR_PIPELINE, isn't set
  - Reason: Prevent userspace from making color management unusable if
the driver doesn't support post-blend color pipelines, as the legacy
color-management properties (GAMMA_LUT, DEGAMMA_LUT, CTM) would be
unwriteable with the client cap set.
3. Make legacy color-management properties (GAMMA_LUT, DEGAMMA_LUT,
CTM) read-only if the client cap,
DRM_CLIENT_CAP_POST_BLEND_COLOR_PIPELINE, is set
  - Reason: Allow drm_info to print legacy color management
configuration while still enabling post-blend color pipelines through
the client cap. Also to allow smooth handover from pre-colorop
userspace client to colorop-ready userspace client, as the latter can
now replicate the legacy color configuration through the colorops.

Side note: Smooth handover back to pre-colorop userspace after tweaking
the colorops to something else would not be possible without making the
legacy properties writable too, so that the client could update them to
match the colorops setting before switching back. I don't imagine this
would be a common use case, and colorops are a superset of the legacy
properties so there are cases where it wouldn't even be possible to
replicate the colorop setting on the legacy properties, but thought I'd
mention this limitation for completeness' sake.

Also, as Xaver noted, this feedback also applies to pre-blend pipelines
and its legacy color-management properties (COLOR_ENCODING,
COLOR_RANGE), so the same changes would be desirable there for the same
reasons. So we should share this feedback on that series as well.


Does this sound right?

--=20
Thanks,

N=C3=ADcolas

