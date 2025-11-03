Return-Path: <linux-kernel+bounces-883529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AA5C2DB0D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEE01899CFF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC61284671;
	Mon,  3 Nov 2025 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="NfWqPfNL"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910FC7262B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194837; cv=none; b=qWWKpDhS+KEmX+heyXc99zE6Ik4+Agar/V0c0haOKHRopQ+pt/Q40a8vkPhZXx8qHGmIagsFnLucZbJ7zm07A5wSECFAdXDm/agkIYohRiKMvmGKFEcD0tPY9wA00oaYHPVtGHC+bv6tuPygXByco5JfjjctNtQjhDmRfML1k4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194837; c=relaxed/simple;
	bh=7RFL2JLNfzKTvp1hqb7yXk1A27+KQsMMiKr3EtxmPzE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GV8c6t1PfvD56ujT/sI+XM+l5i4IApAJxl6kmivnoGuqLa9N9VAExncZzXzEBYg3RrTmbW9UNmLHSno51GMp3CSDW5ckCjRvZcubceuEl58sySEKVrNtAOnsjIJa3BNHp9cUuqC86UD7DwC8Ik/+hdAt42/qSEzOZEf9vWEPF+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=NfWqPfNL; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ecf03363c9so44919211cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1762194834; x=1762799634; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D6IBkTdRfVpO1bCNLk2LNL0B21F0Pxa2e8J5b4QlK6Q=;
        b=NfWqPfNLcnrLKKmICZQvbVUhMtYx7RQ23nZajIdk7huiH+LpCSvpgfXb6+j2rQA+Mb
         Xc00lTdFfGRSmNSBX0ZnX34nDHB6rbc2VhkGmwkcqhZoxbuvqSsWRDEgovRkxEvTT/DY
         HO7TW5/0lgHe5v9sfdbc0bnpLl51hxG3s5J2eVBcmxVFMI/Dnso2NlVJLqk82RokXPJX
         KA+SKHMU6V+jCDCAwDp9cW7BvXEvZq5FD8pLz1tZs2/ikTZcq0WcammScS1HV+83EXm3
         Xg7j4wYh5Dx3Jq2dYWRufds5UHKrnJ2APqwY5jLP6X/r4FZNZfp0XFXRTA3pLdXNCQk4
         JiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194834; x=1762799634;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6IBkTdRfVpO1bCNLk2LNL0B21F0Pxa2e8J5b4QlK6Q=;
        b=YrCvScsWYK/7zwjKH7AjU/PKdrsfkAUYJuGxsp4IBRE/AEFFfcwvpmyI3jllkJS+6i
         W+cbAIlPEak11aS+8HfXTP6tZacMPxke8lt8zt5NKj40qd6W2xSs9LphID1LW/kAf0ie
         JvROqdQsPMpQnO7fWsNHOB5k6YkRD8as8coEHQQMbV79iz+HHpZvdDFDkxawMXHxd1SW
         +4IdR/+EW/mxTNDVOhyy9oPPqBbY2DQ27xlX7NjhDlrVX9UQNu3zna/5Xw6DtIbYaUrv
         khp/i/6RJ3rd0S9daoeWrL7yi9uO7Nf+UH1PJnkc/G8bHLFs8flPjNhResH4GnPaNAwM
         PN1A==
X-Forwarded-Encrypted: i=1; AJvYcCXnGQXgSCe86MoNOQGRLFK4bvd1u5nEZMK/tajPgug98Dra+w/OYIAv2Q8q+z8qc6miqNiEtjpU3BKCCAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1pXXJSRZExxSSWNcr/8i/HkSV0xqZZe8VC/ngST4iNG94eAxf
	mK3GLa71NmMndxrun2fvkG2LoORBOZOHU9yPL7uq0Qn5xFp3JKMSqOzKYeT71cezc4s=
X-Gm-Gg: ASbGncvHPNqduV6g2oZRFlj6C3S8kQEghYtPmGns79YZCcP0lx82UqsfW4NyNRbRX4i
	E4/lSJPsnBn58BjjV1I+3gtYl/bgfFGbMnjnRnpeJjrc5IOjOD8v0oG1Qw93FP2P0xs8v9Lhvew
	ORsVKOFgz4Wo+ndEXv56INufbM4vsmtqfurFKiQ4l1JdE4+TVvavgrl6lVmZbfElak2tWq336UX
	6SRJ1DtTprRqNW7hlOvTMLM1v6p+ZUjCXuWlzfW+vo+nqOvZnRVAOdEdWb3isTgGr85bfyAbx5r
	zPc9MQTOsuL/cksnMhhj9tby1lbmSMEH+gxZdYUznVxycGz7EKfAG/ixkyeUvPAHeVDiFWcQ6G7
	TbgaTPhWt3P+uw/NnWdWemBq2COsM/ylc297Y7ODTmfvFK0Az+yD9tvfWJVwBgnCXCny20tSpeH
	VP1+0dQLRAAjixYJh2
X-Google-Smtp-Source: AGHT+IHiLwkkP/T5WfRuyyDGcNUXxAsqql06SKeSmgibPQwsNkXLFhIvFubFnKycp+mU6mAdcvP9fA==
X-Received: by 2002:a05:622a:986:b0:4e7:2844:b5ba with SMTP id d75a77b69052e-4ed30df358amr195696001cf.27.1762194834405;
        Mon, 03 Nov 2025 10:33:54 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:ebd3::c41? ([2606:6d00:17:ebd3::c41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f5413f43sm38727485a.8.2025.11.03.10.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:33:53 -0800 (PST)
Message-ID: <41ef734f56c0168e65e149cabf28d585ee5f2428.camel@ndufresne.ca>
Subject: Re: [PATCH] media: iris: Refine internal buffer reconfiguration
 logic for resolution change
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Vikash Garodia	
 <vikash.garodia@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>,
  Bryan O'Donoghue	 <bod@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Hans Verkuil	 <hverkuil@kernel.org>, Stefan Schmidt
 <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Val Packett <val@packett.cool>
Date: Mon, 03 Nov 2025 13:33:52 -0500
In-Reply-To: <20251103-iris-seek-fix-v1-1-6db5f5e17722@oss.qualcomm.com>
References: <20251103-iris-seek-fix-v1-1-6db5f5e17722@oss.qualcomm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0U7duYWV/opQAYp/tD5t"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-0U7duYWV/opQAYp/tD5t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 03 novembre 2025 =C3=A0 16:35 +0530, Dikshita Agarwal a =C3=A9crit=
=C2=A0:
> Improve the condition used to determine when input internal buffers need
> to be reconfigured during streamon on the capture port. Previously, the
> check relied on the INPUT_PAUSE sub-state, which was also being set
> during seek operations. This led to input buffers being queued multiple
> times to the firmware, causing session errors due to duplicate buffer
> submissions.
>=20
> This change introduces a more accurate check using the FIRST_IPSC and
> DRC sub-states to ensure that input buffer reconfiguration is triggered
> only during resolution change scenarios, such as streamoff/on on the
> capture port. This avoids duplicate buffer queuing during seek
> operations.
>=20
> Fixes: c1f8b2cc72ec ("media: iris: handle streamoff/on from client in dyn=
amic resolution change")
> Reported-by: Val Packett <val@packett.cool>
> Closes: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4700
> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks for working on this.

> ---
> =C2=A0drivers/media/platform/qcom/iris/iris_common.c | 7 +++++--
> =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/med=
ia/platform/qcom/iris/iris_common.c
> index 9fc663bdaf3fc989fe1273b4d4280a87f68de85d..21e176ce49ac2d2d26cf4fc25=
c1e5bca0abe501f 100644
> --- a/drivers/media/platform/qcom/iris/iris_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_common.c
> @@ -90,13 +90,15 @@ int iris_process_streamon_input(struct iris_inst *ins=
t)
> =C2=A0
> =C2=A0int iris_process_streamon_output(struct iris_inst *inst)
> =C2=A0{
> +	bool drain_active =3D false, drc_active =3D false, first_ipsc =3D false=
;
> =C2=A0	const struct iris_hfi_command_ops *hfi_ops =3D inst->core->hfi_ops=
;
> -	bool drain_active =3D false, drc_active =3D false;
> =C2=A0	enum iris_inst_sub_state clear_sub_state =3D 0;
> =C2=A0	int ret =3D 0;
> =C2=A0
> =C2=A0	iris_scale_power(inst);
> =C2=A0
> +	first_ipsc =3D inst->sub_state & IRIS_INST_SUB_FIRST_IPSC;
> +
> =C2=A0	drain_active =3D inst->sub_state & IRIS_INST_SUB_DRAIN &&
> =C2=A0		inst->sub_state & IRIS_INST_SUB_DRAIN_LAST;
> =C2=A0
> @@ -108,7 +110,8 @@ int iris_process_streamon_output(struct iris_inst *in=
st)
> =C2=A0	else if (drain_active)
> =C2=A0		clear_sub_state =3D IRIS_INST_SUB_DRAIN | IRIS_INST_SUB_DRAIN_LAS=
T;
> =C2=A0
> -	if (inst->domain =3D=3D DECODER && inst->sub_state & IRIS_INST_SUB_INPU=
T_PAUSE) {
> +	 /* Input internal buffer reconfiguration required incase of resolution=
 change */

There is a spurious space here and also, "incase" -> "in case"

> +	if (first_ipsc || drc_active) {
> =C2=A0		ret =3D iris_alloc_and_queue_input_int_bufs(inst);
> =C2=A0		if (ret)
> =C2=A0			return ret;

cheers,
Nicolas

>=20
> ---
> base-commit: 163917839c0eea3bdfe3620f27f617a55fd76302
> change-id: 20251103-iris-seek-fix-7a25af22fa52
>=20
> Best regards,

--=-0U7duYWV/opQAYp/tD5t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQj1kAAKCRDZQZRRKWBy
9PcZAP0b/914MBOGdLEOJRB5qlfQHO7FmZggakf8Kjv9KEIB+wEAoKCnmEfLLA51
Nr5ICFgwip/3oMGjlaa1EDmEGyBpNAk=
=op9q
-----END PGP SIGNATURE-----

--=-0U7duYWV/opQAYp/tD5t--

