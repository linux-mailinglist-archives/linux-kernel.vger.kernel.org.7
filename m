Return-Path: <linux-kernel+bounces-764744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45996B226B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F4A427C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6861A8412;
	Tue, 12 Aug 2025 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="QztAltTz"
Received: from sonic304-24.consmr.mail.gq1.yahoo.com (sonic304-24.consmr.mail.gq1.yahoo.com [98.137.68.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB4E4A21
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.68.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001471; cv=none; b=t5FLTgVU/yORw1LKcZmzaGzGrEqy0jNtJmcN+is+0uT9VHxc7+o7a2oPpIEbcCcj4GmpYa2kmqka6aagj+uE/tDpJ3fk0vHaC+KnOZQxSCoJhnXOIK9Q+fg3NkW8pj5FbLsZYa4/Vlg8SkL82O1HP8FlsRX9e1Ndxn2RKBG9Ro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001471; c=relaxed/simple;
	bh=8mE+yPaYps+tf02DZwYbao3F/WMY+dUsniOo+WWlkPw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UzExuqgtjPQ/qV6u/rsbIzRrz1E+MyOuOplE7AUrSVkqxjEIzpKNTvQu7Ws/VQKfl0LcEtjb0fStilz8IUOG9Gh6i3hx6LJAsEI9O8f80aKiy4e6ee6vYOTyeqEjt4EX9dTsCJT8Hb7a3hu05f17majMPXfnVvYur4QL2DdD+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=QztAltTz; arc=none smtp.client-ip=98.137.68.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1755001469; bh=6Z7MIGE80cLDmSJLlybCN1sFLxGCVH7fJFHYw/omHb8=; h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To; b=QztAltTzIggh/m4oH4utEVk+qx3GbijkGcZcdU/9X1xsL9QgnWCaWnQUqmKKBvw/PCrYLhkiQz/pfXbeV9zxVZ2JRDq8ahAP+w9HTaec1CiAZqGAFTBiMeF//4UO0hy99YxkhHHKMsObILCKd7Ao53YAHtSDvvKjCAAgZnUBvX08P4Ip6NcJQm+VymCVqSWnPXKUFBuvb98CcjqLQ1LfS/T24fUdm2NIu3vuGPtUvttqIN2JiTH6mFlLRBM0OMLg6q46sYdnkL/+DpODso98lwyCFhuJ0UuY6Gj0852nO7JYmLeFKbp1ruaGMD/tj0stw4OTccNxXRIzza4zkW8LAw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755001469; bh=8s//fh6v0SYo7tjssUhGRIDXRvuptXZIcmHrrLmA1r6=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=ebBIfnnvpZYvkdFKsLeimf+U4e8xo1hYGXCe1CXtIzV7fcMJ3FDoi+W1YE1am4ly+tYSMjxKdT+NnQdmFOwffKpLKlJ6MUd4Q/83qiEhrM/NlVXmN3BxDtEaUtqDt82qoPXOk5y2rqu6n9j6UjSoPrP9wrzQ6jqtmV1tAu1Iq71f6rpnyhyI7pLWN6O1YvL2AOW0bn9UytpYyWhZAXJHOVmk8F1bHP90RluTeFOYW5Awa6H6/ny4D7//T0T2iAgkc7geWpN21RlFyAqQRCVILC8bBn21D4dunKfn19icoL//ksUigLINRk0XjcqI/p+RLksydrj+3FlxUk9vq0rRag==
X-YMail-OSG: JbsBywkVM1llghskNdAqdgDn95bDzDw_gTx_gSEngTWikNRxQ.J1PN30xF331Vw
 ghFlnpTGEK6dvo5xQxPTQHd.FmealPuTFw9y9JaYkXLA1_F4uDzQi.Zabujdano60c34lzlA0HZj
 VzZF6D5xcNTXmrPAfx0JR2TcDj0K8jPbloLYOkERsI_XBG7gOeCiz77alAgIS5hV8.b7exr5g.G7
 p3HiPG_iPfl9.pwzSmM.qi8d_lSyznPqqYOOINnUkWzB81pAjMvkeEcApJmGLHxvz3I1WIn4DJvW
 TViIXC_.i2SSh9dGeEtTyTVv.bi8nrSX9Kd6CDgaH9MF1C1ok2nDKedQMjbyrh..ofxS.9_noKtK
 cT3Oye8P09yGMIEZpIIf479gtxxwHPU.x4IAh4Px38aLVdobuhVZNdokiJ1WCpTg806sR9sBrs2K
 rPR3Q5TsnRY7Qvmr2tSySzs53X2o3xQVpZ6ZqyJjiFpsE2izQXcpQqrouMG_TI_nYcRxmPClnEkh
 w55rc_.cuVQxz7NQdo57pThYL13mIjyDZhWDCmpacNJbP1M1gXvCUih5esoRv_rCPcNugdjwPr9o
 CqW1x5ShxRhaccTrOVbd69rUirpr1rjccoXcQ.nzvue7EmRNmPTMeF33HBBNox_oeFRr7HIQwJ4p
 g.AfGASULt.SCr45rmY4Di1k5CXjdzsPpWV2eTdJYFDJL4ysfmqOBIcPiMVva0UrEP6dA2SkuFBx
 rQ8AQTfbLyDn76spc56_ouznLHomiQeCYEs1i0CeEvIbzKBKeM0D6oDf1iO9uA_RFoY.3S5kRM5f
 jvEAsBbAJ_NwiUjhYLIZaDXact5BBEOuus6JV_jV74G5JMXRQ3yuW37E0RN1GGcVt2kfvriGd.GI
 fZhW8iUAEXKMl7k1m_p9_nKPucEp_SI9.1jb.HdbxsTKmh9y15bIQ7VDMO9pjVV_yafmjRM9viBM
 WiY1EhA5T7kqchcjljOppb9xcFXinE7mDLFBZqysimfLV95FSeUcdj2LlS.9OjarGSEJhVgOIIVB
 FDezFc6eFKVnVal7WsCz72G6RM5zsbzc8nBrT_5zbJ_en0DU1Dil952Db8P1AHOARMDTW04jv.Yt
 USPnnI8knLDrAsNCEKUEs8LjVfiBc8BB0ZWag77BJ_KS3rnXdZXhZHWOna22l1CCBg2t9X2F7MRQ
 RnPx6kNYToNiSiXZxt_wkW6P7yfMmZcU8pA.coJJFoBMF3DKq29fr5OTxrREfKLY2K5R7G_jlZx.
 VNtB.CXojar.A8rmw414uReGhEkqS58j4DdCKWPKL4ZHgiGB_..clbb3IDc9q22ZUjvYXNUhG9Lp
 EDYXPgTJVAlHEm1qIfrTrcqJQqCjeBKEEvNxNeZfsojy7kuFu8lbZ0uIGUUUurOPA846ATjUZ6Da
 irYIWDBVOiFS_svNNlo_RkPBmlBrz9txOg5Hn8NWAoCPhHX9hWT5bU1_QMdviP_oXYGOM5RE9kqh
 SFnXLMgMGeI_nY34nz0tBoKIh6lE2LvAk3Z5rV4QIHCIFSRvrcNN.p_50.qTOfiVBC2o2KijgOlB
 ir13mCsSbosQ9KSZA.RzBqwIoJxLRcz8SCduD.9i_NGeDYmIt8iaFJXcPa7oYLALyYvGbaK.psfQ
 6pm3FhmufKx.b1WCelps61zdM_mBk9VmHLqCDsM5dahwiPztFIt4dkF5l8y8k.Lj17TWeGI2PZeU
 oR9IJiIFxMXj5qEilrys1fP15VJs1E4Gq31maPtEmGlIkTbdn5jw57dnA1Y_5rrWJA8.obQP8Mlu
 8M8cdoRojbVvio.oLZSk.Uetnw0IjLDE_gPbA9LSq9pVsrSKj_WZ7iC8XYAW0nK_Y.yeobU0zHLc
 aFVl9jaV_Xpa9Vx.9C5o1LI3E53JquciOwhHUmxAzD8tS4.Xqm.dnpDW4bYpf16eb6AUF9Lenf0y
 FHRcYtCTl785tlFOiQtrn8ATOtYaaPc2wxjcogRPLldUqoP4m.aDzm0u79hYsJMfwq8ur2gMgVGQ
 NirRv.FhAI9MxrV7fXMj4yp9nrSDcdnBwpf_Ob8DJk6rutP.ECrqoFlJ6HerhI8gNspkRU8PaYvp
 xldlkw2ct_l8tKTNDhy9vCGXE.ADciTZg2_Y.v7sxxAkXWIAFc.FuNgyBOEDIZdjev2wZA__njbv
 jDVAM8EtBmLR.tBbXiyD03ITfwgY6WXvdrJgz34IC2jde0InT4Smsx6Y9aOp6WNMzPcgo5usWji2
 VxeA.25C96uSD1Cr1hQ1YZ_pIK0Pfr2W5MjhoWUs2rFwI28UVbRqLAmYzCPNND9_BOoliJw--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 5a64da4d-c8bd-4dff-9033-766d57c29a53
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Tue, 12 Aug 2025 12:24:29 +0000
Received: by hermes--production-ir2-858bd4ff7b-rtzhj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cae78e7927277b29999d806693e7e8c6;
          Tue, 12 Aug 2025 11:23:46 +0000 (UTC)
Message-ID: <90341ed8cdd644cd363660d765ea764da08b4a21.camel@aol.com>
Subject: Re: [PATCH] drm/gud: Replace simple display pipe with DRM atomic
 helpers
From: Ruben Wauters <rubenru09@aol.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ingo
 Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jani
 Nikula <jani.nikula@intel.com>, Jocelyn Falempe	 <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 12 Aug 2025 12:23:44 +0100
In-Reply-To: <91ccb201-123b-4899-bc44-7f08bd6baf43@suse.de>
References: <20250808133634.6839-1-rubenru09.ref@aol.com>
	 <20250808133634.6839-1-rubenru09@aol.com>
	 <91ccb201-123b-4899-bc44-7f08bd6baf43@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.24260 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Tue, 2025-08-12 at 11:02 +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 08.08.25 um 15:36 schrieb Ruben Wauters:
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
> > Unfortunately I have not been able to test this on hardware. It
> > compiles without errors, but I sadly do not currently have the
> > hardware
> > to ensure that this works as intended. I would appreciate it if
> > anyone
> > would be able to initially check the code I have written to ensure
> > that
> > I have used the DRM atomic helpers correctly (as I do not have much
> > experience with the DRM helpers or system), and then if anyone
> > could
> > test this on hardware to ensure this patch displays identically to
> > the
> > current implementation, it would be greatly appreciated. If that is
> > not
> > possible, I can hold onto this patch until I am able to test it
> > myself
> > when I am able to get the hardware required.
>=20
> Not being able to test is not so great, as the changes are likely to=20
> break the driver. But gud is for an abandoned hobbyist project, so=20
> testers might be rare. Getting a device to work will help. You'll
> need a=20
> Raspi Zero with the firmware from https://github.com/notro/gud/wiki=C2=A0=
.
> (It would be nice to reactive this project.)

Hi

I've got one on the way so should be able to test myself soon.

I've noticed that in the GUD github repo above it has a gadget driver,
which is not in the kernel mainline. Since this is needed for GUD to
work (albeit on the second device), I think it may be a good idea for
this to also be ported to the kernel. Once I have completed with this,
I can take a look at that, but that also feels like a bit of a step up,
depending on what is needed. I imagine most of the work was already
done by Noralf Tr=C3=B8nnes, however I'd also presume that it'd need
adjusting for the current kernel, and to meet review standards.

This of course is for another patch.

As a side note, it is nice to have concrete things to do, even if it is
in a driver that is not often used. It does look useful to me which is
why I want to take it on, and reading through the code, discussing with
maintainers, and looking at the documentation I can pick out
improvements that could be made, which I haven't really been able to do
much of in the kernel so far.
>=20
> I left a few comments below. It looks good already, apart from being=20
> untested.
>=20
>=20
> >=20
> > Thank you
> > ---
> > =C2=A0 drivers/gpu/drm/gud/gud_connector.c | 24 +++++-----
> > =C2=A0 drivers/gpu/drm/gud/gud_drv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 54 +++++++++++++++++-----
> > =C2=A0 drivers/gpu/drm/gud/gud_internal.h=C2=A0 | 13 +++---
> > =C2=A0 drivers/gpu/drm/gud/gud_pipe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6=
9 ++++++++++++++++++++----
> > -----
> > =C2=A0 4 files changed, 110 insertions(+), 50 deletions(-)
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
> > index 5385a2126e45..ac723b4ea7bf 100644
> > --- a/drivers/gpu/drm/gud/gud_drv.c
> > +++ b/drivers/gpu/drm/gud/gud_drv.c
>=20
> The changes to this file rather belong into gud_pipe.c but the
> current=20
> implementation of gud_probe() mixes up feature detection with
> pipeline=20
> init. Untangling this would be another patch later.
>=20
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
> > +
>=20
> No empty line here, please.
>=20
> > =C2=A0=C2=A0	if (ret)
> > =C2=A0=C2=A0		return ret;
> > =C2=A0=20
> > +	drm_plane_helper_add(&gdrm->plane,
> > &gud_plane_helper_funcs);
> > +
> > =C2=A0=C2=A0	devm_kfree(dev, formats);
> > =C2=A0=C2=A0	devm_kfree(dev, formats_dev);
> > =C2=A0=20
> > @@ -582,7 +608,15 @@ static int gud_probe(struct usb_interface
> > *intf, const struct usb_device_id *id)
> > =C2=A0=C2=A0		return ret;
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -	drm_plane_enable_fb_damage_clips(&gdrm->pipe.plane);
> > +	drm_plane_enable_fb_damage_clips(&gdrm->plane);
>=20
> This line is part of plane initialization. It would best be done
> right=20
> after drm_plane_helper_add().
>=20
> Best regards
> Thomas
>=20
> > +
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
> > +
> > =C2=A0=C2=A0		gud_fb_handle_damage(gdrm, fb,
> > &shadow_plane_state->data[0], &damage);
> > +	}
> > =C2=A0=20
> > =C2=A0=C2=A0	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
> > =C2=A0=20

