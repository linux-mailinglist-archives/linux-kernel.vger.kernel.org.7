Return-Path: <linux-kernel+bounces-885093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC51C31F94
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B8414E9831
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9520C2F7AA7;
	Tue,  4 Nov 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PeySt5v1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3F2FABFF;
	Tue,  4 Nov 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272437; cv=none; b=miZgFd2+PpLclSGyKTM4l0tXSSv/wI0koLs/dmlWNuzJ40y3Ca/gzyYxOFJxi3hQx/c3+9LioQrVyG8vhKB7fUlT1d6Rc+ecckiJr77sAmj0ttsaJuZZyOoVvyQl5GC1nLAQiKvApAMNaCBZOYWz/bLIo7WFxYiSgcNtmCR5OTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272437; c=relaxed/simple;
	bh=a5GxNjkCvPp2VLoH8Oqj+okJ074BdV9VCpmANAZjfs4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I4F7ANffBMRXRuqAz/csFDZECUN7d/VXCapPxnroH0yVbDzo70EpjghNesbf7s1VxqH98vzpWl6GBsoEJWUkbgj3eCdX8ET1TqqpBAHSMjbhSqy5iOxfPsTMbe2dMCTc62DbOx4ggk6nz9BwqBb9/kumGZY6KgwzXo0/3KA4OFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PeySt5v1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762272432;
	bh=a5GxNjkCvPp2VLoH8Oqj+okJ074BdV9VCpmANAZjfs4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PeySt5v1mQGqEoAZrjwuWa1I332AXwYr7l1tvudB6QVbiqM+THUOecHhiQBpliTxG
	 t717t1jBvYxmiRDgfaDLXX2P7TcaAKYORth9yOMX0UO50BVPp/G+QLLxp4UMv50pH5
	 R4XN3HXRjYsFrGlSkJk36I16mU0U1evVz1Y2FmBxhiZJX8kpPQlm3S1DWwt0kCUMxu
	 2iNtpiw7hwxMdMZyQ9af3PBZ3X7OMbYtbGCyavd64WJDPfLDS1hMqSadhOXOyv/JU+
	 Q5fjWW7bpeqCs/kEhhXxZrKEJtf8F/Q3zObpGYSDL0++qLV5iZdMWEKxswT0GE2Q6O
	 RWkXFjMbveLuQ==
Received: from [IPv6:2606:6d00:17:ebd3::5ac] (unknown [IPv6:2606:6d00:17:ebd3::5ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5CF3417E0CA1;
	Tue,  4 Nov 2025 17:07:10 +0100 (CET)
Message-ID: <b4c041d6603fcc107c466bd1ed8c402c96aef5e1.camel@collabora.com>
Subject: Re: [PATCH v4 02/15] media: v4l2-ctrls: Add hevc_ext_sps_[ls]t_rps
 controls
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Hans Verkuil <hverkuil+cisco@kernel.org>, Detlev Casanova
	 <detlev.casanova@collabora.com>, linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Ezequiel Garcia	
 <ezequiel@vanguardiasur.com.ar>, Heiko Stuebner <heiko@sntech.de>, Ricardo
 Ribalda <ribalda@chromium.org>, Hans Verkuil <hverkuil@kernel.org>, Hans de
 Goede <hansg@kernel.org>,  Yunke Cao <yunkec@google.com>, Jonathan Corbet
 <corbet@lwn.net>, Laurent Pinchart	 <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,  James Cowgill
 <james.cowgill@blaize.com>, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, 	linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com
Date: Tue, 04 Nov 2025 11:07:08 -0500
In-Reply-To: <6eaa8b26-edab-4bfa-9c6a-1fbb54c36b4e@kernel.org>
References: <20251022174508.284929-1-detlev.casanova@collabora.com>
	 <20251022174508.284929-3-detlev.casanova@collabora.com>
	 <6eaa8b26-edab-4bfa-9c6a-1fbb54c36b4e@kernel.org>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-EgYc8K706Xiy5xAdYVZQ"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-EgYc8K706Xiy5xAdYVZQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le jeudi 23 octobre 2025 =C3=A0 10:04 +0200, Hans Verkuil a =C3=A9crit=C2=
=A0:
> On 22/10/2025 19:44, Detlev Casanova wrote:
> > The vdpu381 decoder found on newer Rockchip SoC need the information
> > from the long term and short term ref pic sets from the SPS.
> >=20
> > So far, it wasn't included in the v4l2 API, so add it with new dynamic
> > sized controls.
> >=20
> > Each element of the hevc_ext_sps_lt_rps array contains the long term re=
f
> > pic set at that index.
> > Each element of the hevc_ext_sps_st_rps contains the short term ref pic
> > set at that index, as the raw data.
> > It is the role of the drivers to calculate the reference sets values.
> >=20
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > =C2=A0drivers/media/v4l2-core/v4l2-ctrls-core.c | 18 +++++++
> > =C2=A0drivers/media/v4l2-core/v4l2-ctrls-defs.c | 10 ++++
> > =C2=A0include/uapi/linux/v4l2-controls.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 61 +++++++++++++++++++++++
> > =C2=A0include/uapi/linux/videodev2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
> > =C2=A04 files changed, 91 insertions(+)
> >=20
> > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/=
v4l2-core/v4l2-ctrls-core.c
> > index 7c660cd61e48..b330bd7719e9 100644
> > --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> > +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> > @@ -418,6 +418,12 @@ void v4l2_ctrl_type_op_log(const struct v4l2_ctrl =
*ctrl)
> > =C2=A0	case V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS:
> > =C2=A0		pr_cont("HEVC_SLICE_PARAMS");
> > =C2=A0		break;
> > +	case V4L2_CTRL_TYPE_HEVC_EXT_SPS_ST_RPS:
> > +		pr_cont("HEVC_EXT_SPS_ST_RPS");
> > +		break;
> > +	case V4L2_CTRL_TYPE_HEVC_EXT_SPS_LT_RPS:
> > +		pr_cont("HEVC_EXT_SPS_LT_RPS");
> > +		break;
> > =C2=A0	case V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX:
> > =C2=A0		pr_cont("HEVC_SCALING_MATRIX");
> > =C2=A0		break;
> > @@ -1248,6 +1254,12 @@ static int std_validate_compound(const struct v4=
l2_ctrl *ctrl, u32 idx,
> > =C2=A0	case V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS:
> > =C2=A0		break;
> > =C2=A0
> > +	case V4L2_CTRL_TYPE_HEVC_EXT_SPS_ST_RPS:
> > +		break;
> > +
> > +	case V4L2_CTRL_TYPE_HEVC_EXT_SPS_LT_RPS:
> > +		break;
> > +
>=20
> There is nothing to validate here? Any value is fine? Just checking...
>=20
> Is this something that should be added to the visl driver so it is tested=
 during regression
> tests? Or does this not apply to visl?
>=20
> I haven't looked in-depth into this, but I wondered about it.

Seems appropriate to add to VISL.

Nicolas

>=20
> Regards,
>=20
> 	Hans
>=20
> > =C2=A0	case V4L2_CTRL_TYPE_HDR10_CLL_INFO:
> > =C2=A0		break;
> > =C2=A0
> > @@ -2000,6 +2012,12 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4=
l2_ctrl_handler *hdl,
> > =C2=A0	case V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS:
> > =C2=A0		elem_size =3D sizeof(struct v4l2_ctrl_hevc_slice_params);
> > =C2=A0		break;
> > +	case V4L2_CTRL_TYPE_HEVC_EXT_SPS_ST_RPS:
> > +		elem_size =3D sizeof(struct v4l2_ctrl_hevc_ext_sps_st_rps);
> > +		break;
> > +	case V4L2_CTRL_TYPE_HEVC_EXT_SPS_LT_RPS:
> > +		elem_size =3D sizeof(struct v4l2_ctrl_hevc_ext_sps_lt_rps);
> > +		break;
> > =C2=A0	case V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX:
> > =C2=A0		elem_size =3D sizeof(struct v4l2_ctrl_hevc_scaling_matrix);
> > =C2=A0		break;
> > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/=
v4l2-core/v4l2-ctrls-defs.c
> > index ad41f65374e2..167286c9e424 100644
> > --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > @@ -1233,6 +1233,8 @@ const char *v4l2_ctrl_get_name(u32 id)
> > =C2=A0	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return "HEVC Decode M=
ode";
> > =C2=A0	case V4L2_CID_STATELESS_HEVC_START_CODE:		return "HEVC Start Cod=
e";
> > =C2=A0	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return "HEVC E=
ntry Point Offsets";
> > +	case V4L2_CID_STATELESS_HEVC_EXT_SPS_ST_RPS:		return "HEVC Short Term=
 Ref Sets";
> > +	case V4L2_CID_STATELESS_HEVC_EXT_SPS_LT_RPS:		return "HEVC Long Term =
Ref Sets";
> > =C2=A0	case V4L2_CID_STATELESS_AV1_SEQUENCE:			return "AV1 Sequence Par=
ameters";
> > =C2=A0	case V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY:		return "AV1 Tile =
Group Entry";
> > =C2=A0	case V4L2_CID_STATELESS_AV1_FRAME:			return "AV1 Frame Parameter=
s";
> > @@ -1578,6 +1580,14 @@ void v4l2_ctrl_fill(u32 id, const char **name, e=
num v4l2_ctrl_type *type,
> > =C2=A0		*type =3D V4L2_CTRL_TYPE_U32;
> > =C2=A0		*flags |=3D V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> > =C2=A0		break;
> > +	case V4L2_CID_STATELESS_HEVC_EXT_SPS_ST_RPS:
> > +		*type =3D V4L2_CTRL_TYPE_HEVC_EXT_SPS_ST_RPS;
> > +		*flags |=3D V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> > +		break;
> > +	case V4L2_CID_STATELESS_HEVC_EXT_SPS_LT_RPS:
> > +		*type =3D V4L2_CTRL_TYPE_HEVC_EXT_SPS_LT_RPS;
> > +		*flags |=3D V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> > +		break;
> > =C2=A0	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
> > =C2=A0		*type =3D V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
> > =C2=A0		break;
> > diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4=
l2-controls.h
> > index 2d30107e047e..dd9e29afa155 100644
> > --- a/include/uapi/linux/v4l2-controls.h
> > +++ b/include/uapi/linux/v4l2-controls.h
> > @@ -2093,6 +2093,8 @@ struct v4l2_ctrl_mpeg2_quantisation {
> > =C2=A0#define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_STATE=
LESS_BASE + 405)
> > =C2=A0#define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_STATEL=
ESS_BASE + 406)
> > =C2=A0#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_COD=
EC_STATELESS_BASE + 407)
> > +#define V4L2_CID_STATELESS_HEVC_EXT_SPS_ST_RPS=C2=A0 (V4L2_CID_CODEC_S=
TATELESS_BASE + 408)
> > +#define V4L2_CID_STATELESS_HEVC_EXT_SPS_LT_RPS=C2=A0 (V4L2_CID_CODEC_S=
TATELESS_BASE + 409)
> > =C2=A0
> > =C2=A0enum v4l2_stateless_hevc_decode_mode {
> > =C2=A0	V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
> > @@ -2548,6 +2550,65 @@ struct v4l2_ctrl_hevc_scaling_matrix {
> > =C2=A0	__u8	scaling_list_dc_coef_32x32[2];
> > =C2=A0};
> > =C2=A0
> > +#define V4L2_HEVC_EXT_SPS_ST_RPS_FLAG_INTER_REF_PIC_SET_PRED	0x1
> > +
> > +/*
> > + * struct v4l2_ctrl_hevc_ext_sps_st_rps - HEVC short term RPS paramete=
rs
> > + *
> > + * Dynamic size 1-dimension array for short term RPS. The number of el=
ements
> > + * is v4l2_ctrl_hevc_sps::num_short_term_ref_pic_sets. It can contain =
up to 65 elements.
> > + *
> > + * @delta_idx_minus1: Specifies the delta compare to the index. See de=
tails in section 7.4.8
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Short-term reference pict=
ure set semantics" of the specification.
> > + * @delta_rps_sign: Sign of the delta as specified in section 7.4.8 "S=
hort-term reference picture
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set semantics" of the specification.
> > + * @abs_delta_rps_minus1: Absolute delta RPS as specified in section 7=
.4.8 "Short-term reference
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pi=
cture set semantics" of the specification.
> > + * @num_negative_pics: Number of short-term RPS entries that have pict=
ure order count values less
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 than the picture ord=
er count value of the current picture.
> > + * @num_positive_pics: Number of short-term RPS entries that have pict=
ure order count values
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 greater than the pic=
ture order count value of the current picture.
> > + * @used_by_curr_pic: Bit j specifies if short-term RPS j is used by t=
he current picture.
> > + * @use_delta_flag: Bit j equals to 1 specifies that the j-th entry in=
 the source candidate
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 short-term RPS is included in this can=
didate short-term RPS.
> > + * @delta_poc_s0_minus1: Specifies the negative picture order count de=
lta for the i-th entry in
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the shor=
t-term RPS. See details in section 7.4.8 "Short-term reference
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 picture =
set semantics" of the specification.
> > + * @delta_poc_s1_minus1: Specifies the positive picture order count de=
lta for the i-th entry in
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the shor=
t-term RPS. See details in section 7.4.8 "Short-term reference
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 picture =
set semantics" of the specification.
> > + * @flags: See V4L2_HEVC_EXT_SPS_ST_RPS_FLAG_{}
> > + */
> > +struct v4l2_ctrl_hevc_ext_sps_st_rps {
> > +	__u8	delta_idx_minus1;
> > +	__u8	delta_rps_sign;
> > +	__u16	abs_delta_rps_minus1;
> > +	__u8	num_negative_pics;
> > +	__u8	num_positive_pics;
> > +	__u32	used_by_curr_pic;
> > +	__u32	use_delta_flag;
> > +	__u16	delta_poc_s0_minus1[16];
> > +	__u16	delta_poc_s1_minus1[16];
> > +	__u8	flags;
> > +};
> > +
> > +#define V4L2_HEVC_EXT_SPS_LT_RPS_FLAG_USED_LT		0x1
> > +
> > +/*
> > + * struct v4l2_ctrl_hevc_ext_sps_lt_rps - HEVC long term RPS parameter=
s
> > + *
> > + * Dynamic size 1-dimension array for long term RPS. The number of ele=
ments
> > + * is v4l2_ctrl_hevc_sps::num_long_term_ref_pics_sps. It can contain u=
p to 65 elements.
> > + *
> > + * @lt_ref_pic_poc_lsb_sps: picture order count modulo MaxPicOrderCntL=
sb of the i-th candidate
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 long-term reference picture.
> > + * @flags: See V4L2_HEVC_EXT_SPS_LT_RPS_FLAG_{}
> > + */
> > +struct v4l2_ctrl_hevc_ext_sps_lt_rps {
> > +	__u16	lt_ref_pic_poc_lsb_sps;
> > +	__u8	flags;
> > +};
> > +
> > =C2=A0/* Stateless VP9 controls */
> > =C2=A0
> > =C2=A0#define V4L2_VP9_LOOP_FILTER_FLAG_DELTA_ENABLED	0x1
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index becd08fdbddb..ae1d33fd37b7 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -1981,6 +1981,8 @@ enum v4l2_ctrl_type {
> > =C2=A0	V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS	=3D 0x0272,
> > =C2=A0	V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX	=3D 0x0273,
> > =C2=A0	V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS	=3D 0x0274,
> > +	V4L2_CTRL_TYPE_HEVC_EXT_SPS_ST_RPS	=3D 0x0275,
> > +	V4L2_CTRL_TYPE_HEVC_EXT_SPS_LT_RPS	=3D 0x0276,
> > =C2=A0
> > =C2=A0	V4L2_CTRL_TYPE_AV1_SEQUENCE	=C2=A0=C2=A0=C2=A0 =3D 0x280,
> > =C2=A0	V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY =3D 0x281,
>=20

--=-EgYc8K706Xiy5xAdYVZQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQokrAAKCRDZQZRRKWBy
9CRrAP0T63QfmgbLlSMXTPW4GUXXWbfgHP1Hwo6UUnxwbExjVgD7Bd45RyDtdQKA
BrpngGZRRjg65wceMOHG9pObvy+VUQQ=
=T/U4
-----END PGP SIGNATURE-----

--=-EgYc8K706Xiy5xAdYVZQ--

