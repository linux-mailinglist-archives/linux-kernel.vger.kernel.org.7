Return-Path: <linux-kernel+bounces-773678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E11B2A4B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A84B4E317E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66629322535;
	Mon, 18 Aug 2025 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="snd89r91"
Received: from sonic309-20.consmr.mail.gq1.yahoo.com (sonic309-20.consmr.mail.gq1.yahoo.com [98.137.65.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE2531B11A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523074; cv=none; b=k5qHlEJIAzrbvB8pQr7iGzoYSQXP7rn5KM/WAy8Qa2DR2gNGrlss4eIP5OAy8QEsvmPLdhhkigEj9j1Pmqb6M7qF4noT859hq1c8mrVHaIkOPAPjqbbOdNQuG4f9aZEK1wA5vhOysjclPv8esGFOh0eWsf0R85xE6YL8SlsLbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523074; c=relaxed/simple;
	bh=D1/vHO98Rrvr/zwgi3fg8jor565iNiDdeTLiyphje1U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qvEw6nbyx/D9EK0JxUNkBMtybqCrz4+e51yNl1Rfdnw9YS3Pz1PdT1yg0TEzuMnqD6wala8fy2iHthD2RcfPdfIcw9AndSsQT58m4/DuhEoy1wyK4yTinT2eFJZwOw3XSHpUxUcU8eiAPZV80Ob22jAIyqV2m+iFX9/l96H3LBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=snd89r91; arc=none smtp.client-ip=98.137.65.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1755523065; bh=Tfj2h3v2XrCHWqMdE8Jl5Ygb8ad8l63eI9fPnhdbxJQ=; h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To; b=snd89r91fXLH4ehnhF/4QGlzTfisLzQEkdbHvpfVfkw8fjImUhkhqD7iPMWvL7fEqNj4HimG92mJKbxIGO2FNClTVRydtYpBW5zA01uHbHatUz6yMZQNaPdTAOftzuiEqMm4tKrPAB63dPoGCKv1ntYVEzk2wL9xICyaumm7wJHUOhyEGzo9SEMM1hr+5f4+Jt4R+L4YnnrhELDq74VZu+LbXg6MZ7kEIJiUApftrxsCIuUUzi0EO2vbIiD1zBRZgCoTMK8CBej8FFOtDRPy0pr38AHxJlxeu5Bx7mEtSGX9Adu8r+stUMgNrdREwhBVfOjdldD/uBTndxVlh7Fsxg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755523065; bh=8tWYkMQurhXW+9gJY9v6rtzmaFbgRVVLh0meKkokyyO=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=X6rF9vbXnprkOt8vgXokEts0KO/0hbyuvU6e8mYD+5i5VBbBmGr1TeZevHfXKPcbMoaEfvPdBWWIkROLzbod0qJAgvhbaUhnvdG4uImw4ibr+1HnYahUfPHZ73B/eX7HFalNEi4KNazRMuJL2kSL4Ro5JnyAqO1HwOUgnhzMyRRkP+ro7teI7m3mVahIAfrz4j6h6Bobj0a+THh4dkrQdAQ7iCvzUBBij3d+UN36DWidWVK5ejxndwC46C8xxvouykmKq0pocuAv4XevO4l22yWFzBKnGxdRgqlEBl6VplaEQ9imPI2pZW5/Z7cW9yvcrURIexX0NZCeiUBthyLNnA==
X-YMail-OSG: o5FpWwcVM1nSNXgFw1bE6sBDeQ5m5AEDxUQeFiC9TeFOJkK.HXiD.17L48ADrgt
 rAkYfNZqvCOlNG9QhqgDWe_dKZjf5_NGtBPhjh7_Vz4gPF8GxYBEtXUYXRU7pmKxIagCLY.Wxw2d
 XSSGV3kCZ0lqyoEIzhjZXwsEILnz0yYWqIKlkLtBotN_XbnFBUsozjPRBg8BGdQshzhf_wlLx3kH
 Ow1dpLxWAAfxyFrG1U.EEvU9YwSb_3cqRLjVjby4QqgD5EvTUiPQJQGdcNYOHrlRWO5OCnr2J_Qp
 6wgZj8dO5SXFbz2FeKrC22DhfzYqBXhNcjUnk7iHVrfPb9PpESP2MVZvJhvDYGGRmin56FzdYzb8
 1yYj5Jy1mibY8mt2VR8eEzCosB7Gw.mDDYDooBTHpJa3ODXW2MpYAEENZhJqkNm2DcQ.REWsEDcj
 TSOEHxvNxPqAoalJ9LBuP8xAdGxEhVYeZgzzqqdEJTyNuPx45MakTmuegDG1pD6wA1YH.X7_kiP1
 6U6lhrgq16mfWd8l44sZuINef8C0mGtK6rjedJ3khudt5TSLvhUTlgtIISrcoPc_o5D8GEXk0hF4
 MvQlfP.U8bJxHM96c0BkRwwo8el8FOV1dJJukqZ.EYPy1ci8gOKEfVH63z0T.WiwEAXqQdVlrmLu
 tc8hkpHs19YzNQ5se92JwEq6D2lDD6vet5jzO57YgEB3q6vMArzBNVpb3lJxNKzu_ijR6Q.IZM2q
 kE4xaEzt6VzJY3XBA8LCVQEiWSfZRkdroaBfJmafkjBv8LFkTCUr7BoBUkSJReDE4esf1Hkrn41a
 Vq8d9uCr8M9ibQUw9p3phA4cSzFPsQ4pNFkSY3Pf8ZFra5R5rqDJ7SowqCyCQqgY0rUVmjJZUOc1
 QcjMyxOCBG_Io2iZyktckhOMOO7nZFg6M1YxmqdIYqIhC_1Ib1kKeLvbQHg5_TriEulNtfAlk1MW
 uW74lNLjITTIg8kJhO_YWUvkO0dngrQUwO1qa6wJHmGDAdc_cuAUqzDT.GKT5vo_O.hG8cPxzehN
 BxikhACLnV4DnNMe8CSHA_Vn8HaZAaJ7ncaH1YiJTqT6W6sJ_VVItnWi_kRnnA1gosNGNfhOH0eU
 Fmp9UHIGlJrBHAJDLNK0tmdmOwLbEoaiHlu0wCCLOsEJGcqQPtvQiDiDpIfr5f9Pll_8cG_p8AtO
 .LlAHn206FD95SAamJ8RvhwxLZhvH27StOmEsCqIbi3RdnzIfcAy4ETxoD9MgiJ2rngWKZZXLrBU
 Vy_Xp6p2SUzONvUyckc98hZyGDgVY2PmGTK.hnNdEQ36CS.wML37vOJNZ87oCAp3WYcOO9hcv_D7
 _WBbemxt8.mHyPDGdA4zVparrAH.6Lnjy5s0MZLKeE_JbUpQN7W.4Db0sdpfpNHZzaUyOkBoR5rH
 OkyNCahDI5XyUByhUWelW8pz5giI.m4zRGFxg_vDy_UfiPdvftcyxn5ogRTVAAVS0Iko8vaeb4Rt
 LoDOfsARZ8gsSgot0iaCRe0Kr4AFHVZOxu.xx6pqNXpUk4Ivj9eYLt.G45cqStVRTXMByU.0Tv6P
 M_o9Ly9ymRUbk72rtQyC7rfUpYjLyiaLbSLCokK.VyFCRg2a.y4r1fSgB6QAUq_QGUPEa3I0IZOE
 8YAjDeiQAUpicFG75CCnSSvdtkWruxZAj8TO_M38IO2Tfm6dmcjzFyVM8TtiJ96v0xj6uzZMrSJ7
 eO4N6lccM3xZ8Mu6SvKHzCvbGN_dAxbHxadnBHc9B.zRVlg6HlLvF8YbZyQ7vZAaI9zmWEj5fQTq
 zA7kDfc2TjHcw1TQkU4k94XQJdrTitwPok63V8pyTLptQe3KTKSUiTN2JfAu2QNFJaYSj_5ghfEw
 2nKt9GEs9aLg5vVuwFqYsme31M_gGjtrwmvTmFKI50YQk8qJOvTRBVnMGAamepD9KMZfbKM67zCe
 fMGETMmEYLbDOFHd7WIa0BBAJBg7CGygtruGvgvCLxbrxT861FiaOyIOaRghk4fLKE7ND947FWT2
 wc9hSmYUokGaLsP6LIecFgfAIviGhoPMo1n6vFX9KKELEliEm30xQ3F74eGfzy8okZDYfyYBZK7U
 auDaW.PvnsZzgAIF5EUJa3lPN81PAQ.yxrdfzTJoAEHUlibZvbn5tXITOKgple7FEOOMN31ZXUW0
 SWI5G0Mw2AQIsdOcaO.vKhxbwro0qM4xlzYqr_EcOOlu0XgCc7Z4OjlIwXr7uNDVv547pB.1YNoK
 WwPvY_0YrMJNBy0bc5atbiiPYVPWxpnrR0GViSepYk3Dc5GtEq_fzG3lKOitnOe5yCc9O
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 23fca202-10d9-47ca-8574-52f0b4e9411f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Mon, 18 Aug 2025 13:17:45 +0000
Received: by hermes--production-ir2-858bd4ff7b-4tj4l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a548f3378bde8381fa8cc06238f5d92d;
          Mon, 18 Aug 2025 13:07:36 +0000 (UTC)
Message-ID: <5c067d9a12b1e31400454aae47487af9f481b09a.camel@aol.com>
Subject: Re: [PATCH v2] drm/gud: Replace simple display pipe with DRM atomic
 helpers
From: Ruben Wauters <rubenru09@aol.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ingo
 Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jani
 Nikula <jani.nikula@intel.com>, Jocelyn Falempe	 <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 18 Aug 2025 14:07:33 +0100
In-Reply-To: <e3e73378-b9d8-4bf4-838c-66794dc1fad4@suse.de>
References: <20250816100223.5588-1-rubenru09.ref@aol.com>
	 <20250816100223.5588-1-rubenru09@aol.com>
	 <e3e73378-b9d8-4bf4-838c-66794dc1fad4@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.24338 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Mon, 2025-08-18 at 14:27 +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 16.08.25 um 11:57 schrieb Ruben Wauters:
> > The simple display pipe is obsolete and the atomic helpers allow
> > for
> > more control over the rendering process. As such, this patch
> > replaces
> > the old simple display pipe system with the newer atomic helpers.
> >=20
> > As the code is mainly the same, merely replaced with the new atomic
> > system, there should be no change in functionality.
> >=20
> > Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> > ---
> > I have been able to test this now, having obtained the hardware,
> > and it
> > works fine, though some other unrelated issues have popped up,
> > which I
> > shall try and debug and address in other patches.
>=20
> Thanks for the update. Great to hear that it works. What's that other
> problem? Maybe it's a known issue with a known workaround.

It's mainly latency issues, and problems that I had with the gadget
driver, I initially tried to get it to work on a different raspberry pi
but couldn't figure that out, but it works well on the zero.
>=20
> I left additional comments below.
>=20
>=20
> >=20
> > v2 changes:
> > - address review comments by reorganising gud_probe()
> > ---
> > =C2=A0 drivers/gpu/drm/gud/gud_connector.c | 24 +++++-----
> > =C2=A0 drivers/gpu/drm/gud/gud_drv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 52 +++++++++++++++++-----
> > =C2=A0 drivers/gpu/drm/gud/gud_internal.h=C2=A0 | 13 +++---
> > =C2=A0 drivers/gpu/drm/gud/gud_pipe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6=
9 ++++++++++++++++++++----
> > -----
> > =C2=A0 4 files changed, 108 insertions(+), 50 deletions(-)
>=20
> AFAICT you should be able to un-include <drm/drm_simple_kms_helper.h>
> from the various files within the driver.
>=20
>=20
> >=20
> > diff --git a/drivers/gpu/drm/gud/gud_connector.c
> > b/drivers/gpu/drm/gud/gud_connector.c
> > index 0f07d77c5d52..75f404ec08b4 100644
> > --- a/drivers/gpu/drm/gud/gud_connector.c
> > +++ b/drivers/gpu/drm/gud/gud_connector.c
> > @@ -607,13 +607,16 @@ int gud_connector_fill_properties(struct
> > drm_connector_state *connector_state,
> > =C2=A0=C2=A0	return gconn->num_properties;
> > =C2=A0 }
> > =C2=A0=20
> > +static const struct drm_encoder_funcs
> > gud_drm_simple_encoder_funcs_cleanup =3D {
> > +	.destroy =3D drm_encoder_cleanup,
> > +};
> > +
> > =C2=A0 static int gud_connector_create(struct gud_device *gdrm, unsigne=
d
> > int index,
> > =C2=A0=C2=A0				struct
> > gud_connector_descriptor_req *desc)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct drm_device *drm =3D &gdrm->drm;
> > =C2=A0=C2=A0	struct gud_connector *gconn;
> > =C2=A0=C2=A0	struct drm_connector *connector;
> > -	struct drm_encoder *encoder;
> > =C2=A0=C2=A0	int ret, connector_type;
> > =C2=A0=C2=A0	u32 flags;
> > =C2=A0=20
> > @@ -681,20 +684,13 @@ static int gud_connector_create(struct
> > gud_device *gdrm, unsigned int index,
> > =C2=A0=C2=A0		return ret;
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -	/* The first connector is attached to the existing simple
> > pipe encoder */
> > -	if (!connector->index) {
> > -		encoder =3D &gdrm->pipe.encoder;
> > -	} else {
> > -		encoder =3D &gconn->encoder;
> > -
> > -		ret =3D drm_simple_encoder_init(drm, encoder,
> > DRM_MODE_ENCODER_NONE);
> > -		if (ret)
> > -			return ret;
> > -
> > -		encoder->possible_crtcs =3D 1;
> > -	}
> > +	gdrm->encoder.possible_crtcs =3D drm_crtc_mask(&gdrm->crtc);
> > +	ret =3D drm_encoder_init(drm, &gdrm->encoder,
> > &gud_drm_simple_encoder_funcs_cleanup,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_MODE_ENCODER_NONE, NULL);
>=20
> The display pipeline sends pixels from plane to CRTC to a number of=20
> encoder/connector pairs. Hence you have to initialize the encoder at=20
> gconn->encoder. The encoder in gud_device should=C2=A0 be removed.
>=20
>=20
> > +	if (ret)
> > +		return ret;
> > =C2=A0=20
> > -	return drm_connector_attach_encoder(connector, encoder);
> > +	return drm_connector_attach_encoder(connector, &gdrm-
> > >encoder);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 int gud_get_connectors(struct gud_device *gdrm)
> > diff --git a/drivers/gpu/drm/gud/gud_drv.c
> > b/drivers/gpu/drm/gud/gud_drv.c
> > index 5385a2126e45..65c3a83c4037 100644
> > --- a/drivers/gpu/drm/gud/gud_drv.c
> > +++ b/drivers/gpu/drm/gud/gud_drv.c
> > @@ -16,6 +16,7 @@
> > =C2=A0 #include <drm/clients/drm_client_setup.h>
> > =C2=A0 #include <drm/drm_atomic_helper.h>
> > =C2=A0 #include <drm/drm_blend.h>
> > +#include <drm/drm_crtc_helper.h>
> > =C2=A0 #include <drm/drm_damage_helper.h>
> > =C2=A0 #include <drm/drm_debugfs.h>
> > =C2=A0 #include <drm/drm_drv.h>
> > @@ -289,7 +290,7 @@ static int gud_get_properties(struct gud_device
> > *gdrm)
> > =C2=A0=C2=A0			 * but mask out any additions on future
> > devices.
> > =C2=A0=C2=A0			 */
> > =C2=A0=C2=A0			val &=3D GUD_ROTATION_MASK;
> > -			ret =3D
> > drm_plane_create_rotation_property(&gdrm->pipe.plane,
> > +			ret =3D
> > drm_plane_create_rotation_property(&gdrm->plane,
> > =C2=A0=C2=A0							=09
> > DRM_MODE_ROTATE_0, val);
> > =C2=A0=C2=A0			break;
> > =C2=A0=C2=A0		default:
> > @@ -338,10 +339,30 @@ static int gud_stats_debugfs(struct seq_file
> > *m, void *data)
> > =C2=A0=C2=A0	return 0;
> > =C2=A0 }
> > =C2=A0=20
> > -static const struct drm_simple_display_pipe_funcs gud_pipe_funcs =3D
> > {
> > -	.check=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D gud_pipe_check,
> > -	.update	=C2=A0=C2=A0=C2=A0 =3D gud_pipe_update,
> > -	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS
> > +static const struct drm_crtc_helper_funcs gud_crtc_helper_funcs =3D
> > {
> > +	.atomic_check =3D drm_crtc_helper_atomic_check
> > +};
> > +
> > +static const struct drm_crtc_funcs gud_crtc_funcs =3D {
> > +	.reset =3D drm_atomic_helper_crtc_reset,
> > +	.destroy =3D drm_crtc_cleanup,
> > +	.set_config =3D drm_atomic_helper_set_config,
> > +	.page_flip =3D drm_atomic_helper_page_flip,
> > +	.atomic_duplicate_state =3D
> > drm_atomic_helper_crtc_duplicate_state,
> > +	.atomic_destroy_state =3D
> > drm_atomic_helper_crtc_destroy_state,
> > +};
> > +
> > +static const struct drm_plane_helper_funcs gud_plane_helper_funcs
> > =3D {
> > +	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
> > +	.atomic_check =3D gud_plane_atomic_check,
> > +	.atomic_update =3D gud_plane_atomic_update,
> > +};
> > +
> > +static const struct drm_plane_funcs gud_plane_funcs =3D {
> > +	.update_plane =3D drm_atomic_helper_update_plane,
> > +	.disable_plane =3D drm_atomic_helper_disable_plane,
> > +	.destroy =3D drm_plane_cleanup,
> > +	DRM_GEM_SHADOW_PLANE_FUNCS,
> > =C2=A0 };
> > =C2=A0=20
> > =C2=A0 static const struct drm_mode_config_funcs gud_mode_config_funcs =
=3D
> > {
> > @@ -350,7 +371,7 @@ static const struct drm_mode_config_funcs
> > gud_mode_config_funcs =3D {
> > =C2=A0=C2=A0	.atomic_commit =3D drm_atomic_helper_commit,
> > =C2=A0 };
> > =C2=A0=20
> > -static const u64 gud_pipe_modifiers[] =3D {
> > +static const u64 gud_plane_modifiers[] =3D {
> > =C2=A0=C2=A0	DRM_FORMAT_MOD_LINEAR,
> > =C2=A0=C2=A0	DRM_FORMAT_MOD_INVALID
> > =C2=A0 };
> > @@ -567,12 +588,17 @@ static int gud_probe(struct usb_interface
> > *intf, const struct usb_device_id *id)
> > =C2=A0=C2=A0			return -ENOMEM;
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -	ret =3D drm_simple_display_pipe_init(drm, &gdrm->pipe,
> > &gud_pipe_funcs,
> > -					=C2=A0=C2=A0 formats, num_formats,
> > -					=C2=A0=C2=A0 gud_pipe_modifiers,
> > NULL);
> > +	ret =3D drm_universal_plane_init(drm, &gdrm->plane, 0,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gud_plane_funcs,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 formats, num_formats,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gud_plane_modifiers,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_PLANE_TYPE_PRIMARY,
> > NULL);
> > =C2=A0=C2=A0	if (ret)
> > =C2=A0=C2=A0		return ret;
> > =C2=A0=20
> > +	drm_plane_helper_add(&gdrm->plane,
> > &gud_plane_helper_funcs);
> > +	drm_plane_enable_fb_damage_clips(&gdrm->plane);
> > +
> > =C2=A0=C2=A0	devm_kfree(dev, formats);
> > =C2=A0=C2=A0	devm_kfree(dev, formats_dev);
> > =C2=A0=20
> > @@ -582,7 +608,13 @@ static int gud_probe(struct usb_interface
> > *intf, const struct usb_device_id *id)
> > =C2=A0=C2=A0		return ret;
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -	drm_plane_enable_fb_damage_clips(&gdrm->pipe.plane);
> > +	ret =3D drm_crtc_init_with_planes(drm, &gdrm->crtc, &gdrm-
> > >plane, NULL,
> > +					&gud_crtc_funcs, NULL);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	drm_crtc_helper_add(&gdrm->crtc, &gud_crtc_helper_funcs);
> > =C2=A0=20
> > =C2=A0=C2=A0	ret =3D gud_get_connectors(gdrm);
> > =C2=A0=C2=A0	if (ret) {
> > diff --git a/drivers/gpu/drm/gud/gud_internal.h
> > b/drivers/gpu/drm/gud/gud_internal.h
> > index d6fb25388722..6152a9b5da43 100644
> > --- a/drivers/gpu/drm/gud/gud_internal.h
> > +++ b/drivers/gpu/drm/gud/gud_internal.h
> > @@ -15,7 +15,9 @@
> > =C2=A0=20
> > =C2=A0 struct gud_device {
> > =C2=A0=C2=A0	struct drm_device drm;
> > -	struct drm_simple_display_pipe pipe;
> > +	struct drm_plane plane;
> > +	struct drm_crtc crtc;
> > +	struct drm_encoder encoder;
>=20
> As mentioned above, the encoder field should be removed.
>=20
> > =C2=A0=C2=A0	struct work_struct work;
> > =C2=A0=C2=A0	u32 flags;
> > =C2=A0=C2=A0	const struct drm_format_info *xrgb8888_emulation_format;
> > @@ -62,11 +64,10 @@ int gud_usb_set_u8(struct gud_device *gdrm, u8
> > request, u8 val);
> > =C2=A0=20
> > =C2=A0 void gud_clear_damage(struct gud_device *gdrm);
> > =C2=A0 void gud_flush_work(struct work_struct *work);
> > -int gud_pipe_check(struct drm_simple_display_pipe *pipe,
> > -		=C2=A0=C2=A0 struct drm_plane_state *new_plane_state,
> > -		=C2=A0=C2=A0 struct drm_crtc_state *new_crtc_state);
> > -void gud_pipe_update(struct drm_simple_display_pipe *pipe,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_plane_state *old_state);
> > +int gud_plane_atomic_check(struct drm_plane *plane,
> > +			=C2=A0=C2=A0 struct drm_atomic_state *state);
> > +void gud_plane_atomic_update(struct drm_plane *plane,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_atomic_state
> > *atomic_state);
> > =C2=A0 int gud_connector_fill_properties(struct drm_connector_state
> > *connector_state,
> > =C2=A0=C2=A0				=C2=A0 struct gud_property_req
> > *properties);
> > =C2=A0 int gud_get_connectors(struct gud_device *gdrm);
> > diff --git a/drivers/gpu/drm/gud/gud_pipe.c
> > b/drivers/gpu/drm/gud/gud_pipe.c
> > index 8d548d08f127..6a0e6234224a 100644
> > --- a/drivers/gpu/drm/gud/gud_pipe.c
> > +++ b/drivers/gpu/drm/gud/gud_pipe.c
> > @@ -451,14 +451,15 @@ static void gud_fb_handle_damage(struct
> > gud_device *gdrm, struct drm_framebuffer
> > =C2=A0=C2=A0	gud_flush_damage(gdrm, fb, src, !fb->obj[0]-
> > >import_attach, damage);
> > =C2=A0 }
> > =C2=A0=20
> > -int gud_pipe_check(struct drm_simple_display_pipe *pipe,
> > -		=C2=A0=C2=A0 struct drm_plane_state *new_plane_state,
> > -		=C2=A0=C2=A0 struct drm_crtc_state *new_crtc_state)
> > +int gud_plane_atomic_check(struct drm_plane *plane,
> > +			=C2=A0=C2=A0 struct drm_atomic_state *state)
> > =C2=A0 {
> > -	struct gud_device *gdrm =3D to_gud_device(pipe->crtc.dev);
> > -	struct drm_plane_state *old_plane_state =3D pipe-
> > >plane.state;
> > -	const struct drm_display_mode *mode =3D &new_crtc_state-
> > >mode;
> > -	struct drm_atomic_state *state =3D new_plane_state->state;
> > +	struct gud_device *gdrm =3D to_gud_device(plane->dev);
> > +	struct drm_plane_state *old_plane_state =3D
> > drm_atomic_get_old_plane_state(state, plane);
> > +	struct drm_plane_state *new_plane_state =3D
> > drm_atomic_get_new_plane_state(state, plane);
> > +	struct drm_crtc *crtc =3D new_plane_state->crtc;
> > +	struct drm_crtc_state *crtc_state;
> > +	const struct drm_display_mode *mode;
> > =C2=A0=C2=A0	struct drm_framebuffer *old_fb =3D old_plane_state->fb;
> > =C2=A0=C2=A0	struct drm_connector_state *connector_state =3D NULL;
> > =C2=A0=C2=A0	struct drm_framebuffer *fb =3D new_plane_state->fb;
> > @@ -472,17 +473,35 @@ int gud_pipe_check(struct
> > drm_simple_display_pipe *pipe,
> > =C2=A0=C2=A0	if (WARN_ON_ONCE(!fb))
> > =C2=A0=C2=A0		return -EINVAL;
> > =C2=A0=20
> > +	if (WARN_ON_ONCE(!crtc))
>=20
> Please use drm_WARN_ON_ONCE() here.

Should the fb WARN_ON_ONCE be converted to drm_WARN_ON_ONCE as well?
>=20
> > +		return -EINVAL;
> > +
> > +	crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);
> > +
> > +	mode =3D &crtc_state->mode;
> > +
> > +	ret =3D drm_atomic_helper_check_plane_state(new_plane_state,
> > crtc_state,
> > +						=C2=A0
> > DRM_PLANE_NO_SCALING,
> > +						=C2=A0
> > DRM_PLANE_NO_SCALING,
> > +						=C2=A0 false, false);
> > +
>=20
> No empty line here and before similar "if (ret)" statements.
>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!new_plane_state->visible)
> > +		return 0;
> > +
> > =C2=A0=C2=A0	if (old_plane_state->rotation !=3D new_plane_state-
> > >rotation)
> > -		new_crtc_state->mode_changed =3D true;
> > +		crtc_state->mode_changed =3D true;
> > =C2=A0=20
> > =C2=A0=C2=A0	if (old_fb && old_fb->format !=3D format)
> > -		new_crtc_state->mode_changed =3D true;
> > +		crtc_state->mode_changed =3D true;
> > =C2=A0=20
> > -	if (!new_crtc_state->mode_changed && !new_crtc_state-
> > >connectors_changed)
> > +	if (!crtc_state->mode_changed && !crtc_state-
> > >connectors_changed)
> > =C2=A0=C2=A0		return 0;
> > =C2=A0=20
> > =C2=A0=C2=A0	/* Only one connector is supported */
> > -	if (hweight32(new_crtc_state->connector_mask) !=3D 1)
> > +	if (hweight32(crtc_state->connector_mask) !=3D 1)
> > =C2=A0=C2=A0		return -EINVAL;
>=20
> In case you're wondering: this is really a problem with user-space=20
> programs. Most compositors (Xorg, Gnome, etc) don't support a single=20
> display that is mirrored to multiple outputs. It's only found in low-
> end=20
> hardware and complicated to get right; hence there's little incentive
> for user space to fix the problem.
>=20
>=20
> > =C2=A0=20
> > =C2=A0=C2=A0	if (format->format =3D=3D DRM_FORMAT_XRGB8888 && gdrm-
> > >xrgb8888_emulation_format)
> > @@ -500,7 +519,7 @@ int gud_pipe_check(struct
> > drm_simple_display_pipe *pipe,
> > =C2=A0=C2=A0	if (!connector_state) {
> > =C2=A0=C2=A0		struct drm_connector_list_iter conn_iter;
> > =C2=A0=20
> > -		drm_connector_list_iter_begin(pipe->crtc.dev,
> > &conn_iter);
> > +		drm_connector_list_iter_begin(plane->dev,
> > &conn_iter);
> > =C2=A0=C2=A0		drm_for_each_connector_iter(connector, &conn_iter)
> > {
> > =C2=A0=C2=A0			if (connector->state->crtc) {
> > =C2=A0=C2=A0				connector_state =3D connector-
> > >state;
> > @@ -567,16 +586,19 @@ int gud_pipe_check(struct
> > drm_simple_display_pipe *pipe,
> > =C2=A0=C2=A0	return ret;
> > =C2=A0 }
> > =C2=A0=20
> > -void gud_pipe_update(struct drm_simple_display_pipe *pipe,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_plane_state *old_state)
> > +void gud_plane_atomic_update(struct drm_plane *plane,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_atomic_state
> > *atomic_state)
> > =C2=A0 {
> > -	struct drm_device *drm =3D pipe->crtc.dev;
> > +	struct drm_device *drm =3D plane->dev;
> > =C2=A0=C2=A0	struct gud_device *gdrm =3D to_gud_device(drm);
> > -	struct drm_plane_state *state =3D pipe->plane.state;
> > -	struct drm_shadow_plane_state *shadow_plane_state =3D
> > to_drm_shadow_plane_state(state);
> > -	struct drm_framebuffer *fb =3D state->fb;
> > -	struct drm_crtc *crtc =3D &pipe->crtc;
> > +	struct drm_plane_state *old_state =3D
> > drm_atomic_get_old_plane_state(atomic_state, plane);
> > +	struct drm_plane_state *new_state =3D
> > drm_atomic_get_new_plane_state(atomic_state, plane);
> > +	struct drm_shadow_plane_state *shadow_plane_state =3D
> > to_drm_shadow_plane_state(new_state);
> > +	struct drm_framebuffer *fb =3D new_state->fb;
> > +	struct drm_crtc *crtc =3D new_state->crtc;
> > =C2=A0=C2=A0	struct drm_rect damage;
> > +	struct drm_rect dst_clip;
> > +	struct drm_atomic_helper_damage_iter iter;
> > =C2=A0=C2=A0	int ret, idx;
> > =C2=A0=20
> > =C2=A0=C2=A0	if (crtc->state->mode_changed || !crtc->state->enable) {
> > @@ -611,8 +633,15 @@ void gud_pipe_update(struct
> > drm_simple_display_pipe *pipe,
> > =C2=A0=C2=A0	if (ret)
> > =C2=A0=C2=A0		goto ctrl_disable;
> > =C2=A0=20
> > -	if (drm_atomic_helper_damage_merged(old_state, state,
> > &damage))
> > +	drm_atomic_helper_damage_iter_init(&iter, old_state,
> > new_state);
> > +	drm_atomic_for_each_plane_damage(&iter, &damage) {
> > +		dst_clip =3D new_state->dst;
> > +
> > +		if (!drm_rect_intersect(&dst_clip, &damage))
> > +			continue;
>=20
> Where did you get this code snippet? This test should not be
> necessary=20
> here and can even lead to incorrect display updates. Just call=20
> gud_fb_hand

I found this in the hyperv conversion, I'm guessing then it may not be
relevant here and is hyperv specific, (unless it's incorrect in hyperv
as well)
>=20
> Best regards
> Thomas
>=20
> > +
> > =C2=A0=C2=A0		gud_fb_handle_damage(gdrm, fb,
> > &shadow_plane_state->data[0], &damage);
> > +	}
> > =C2=A0=20
> > =C2=A0=C2=A0	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
> > =C2=A0=20

