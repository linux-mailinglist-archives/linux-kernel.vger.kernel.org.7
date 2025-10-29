Return-Path: <linux-kernel+bounces-874944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116B7C179B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E0E40239C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153982D323F;
	Wed, 29 Oct 2025 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kZZbu/Gv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mhl6srEb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF332D2388
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698664; cv=none; b=LhfnuJdKMzJF2UBtQIpnA//r1XIMTxd90oZNsG4sQ5Xz/H2gD6k9J2m8WrN6rh9AT+LQfTbhhYU6uwcZJcun28k2MS2vfrd6SUDqxGHp1mjXOdN7T4i54uhpkzZ46CQ/leY6RiiEXMfq2s2bkcw+YU4YBn5v/2CQWhAXHZmj4LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698664; c=relaxed/simple;
	bh=nLeva2zSpXV3nhCKR9ACW8qXvwW1aVP8v7Am7fsyW2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjlZgsD/eMGc40NaUV6cje5vPgMnX5+scDoPJOP5NDOwuNjzNrmlct55sjiR7fp0WIKrC/PWuErXmucMf5ZwlkIpTxdavHd/mGZkvVbrfNynrsuxHvI5G6RO1FVsVI5sBCQkCXa++bof9dIwynzdpI8GzMtSzul3TazqJ/go5tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kZZbu/Gv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mhl6srEb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlHDo2615908
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6m1lp/maWmvkM4kpSKfjG9Mk8h53h8a5RuhM97V0USg=; b=kZZbu/Gv6UZ3uOJR
	rj9W+hPvzyk0P83akXcP3ZjJ1y7md6Qbwq2xm3SKl072+j/GaGzxJOy9SaRVs+Lo
	MrwJpc2X2FjuT9/EvDlsa6ROjolbFcmCdDoqsReunZLdBOEHXKTrjcPpji070ul5
	QAp7seDd5L4Xuosdm0gmXlcBsGPdrjYfviB07GaSQ14I8CH5Hw1qQsv3gp6tXISH
	OoZJjMBO5U5hWaS1y4L8rMehxS8kK2cpbYGIVdT8LoUBl6GcIl7x+TJS5lhQWznS
	KJ9f4FDfqS/Fz9RYVwGgWikgLUmf4nByDq0ZvyT06rLLIMZggKtuQbjKS+sijhvQ
	gvsIzw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a0gngj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:44:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290e4fade70so55378375ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761698660; x=1762303460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m1lp/maWmvkM4kpSKfjG9Mk8h53h8a5RuhM97V0USg=;
        b=Mhl6srEbesh5AHUMJK8NNJhgG22HdwICQV/UEfojZuic2bTQZF0zxwJKoImb+XQfau
         vC/FyKhoukkscwdday7QufsUBShZyVT9HxiA0rtrnH0vtzl1rizY5486yTCFuOMK6dHX
         agPT48FdWF5g9iP9CLbgIUTLrBbRs4YdQJOYuDUlPgY9gxHSX1l/X4+deDrZzghfCabC
         fu8zKzZZYz0vROnNZKNvDW2aSjFOsEh750U74HW2OwFqkMqNqp9A37gdoc9m5tCcFkZF
         ZlUt40jOS89o2abqTN6TUqTOvNbvSZoC7e6cKW34xsNf9ATC6UFbVLOTYyu2F8idSkCa
         L9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761698660; x=1762303460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6m1lp/maWmvkM4kpSKfjG9Mk8h53h8a5RuhM97V0USg=;
        b=i1yUPy6gng+w8f27BahPPXAJB3/KrcBU/GcCEFU5SYTJV0UWh7sB2lmj1ZsCPmAetu
         SxirO0RAzy67O/nSWmFZitA6vWbZOaqA8mMOnh4OaTEKXPrzWCtVkDkai0EHi5ARd9+S
         EhEB/frFqgh8wILZ5U45OadZEG6r6hGFLnMAgxAT+wSRhFGDwAh5wnCD2jBRG0Qbv55y
         ivWNqG34eboVYiSAiiNykW34lr1WGSURad0b0k//+yY2jzCgJKYgmrLRjfla6jXf6l7G
         zmT7gcpva7wGtxj2Z+decziwgdnO6YhMh1B7gsAa7UnDhXVWb8Syoeijf2qAbB0nxg3w
         Fnew==
X-Forwarded-Encrypted: i=1; AJvYcCXxVtfv2HbuwzooEoQtXnIB16ltBYnlxrpZkrpGF+5gbxAmLb5vrY+0Hzwn2HBo3efYymk29RnVW4w5Uec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoifS3dMHP33yIFeTWrzPrfOIh5c7KEmJ2G+EVuPZzNpqjqmH/
	D6/Zc05x3kx28EKvag+BwALVbzH1qfXiej7abJ9AaK2kFYGSFQxWPO00BbDkVdgLUDnMjEEqtzz
	uqN0E+fW2w2Sl0M/w1zqlCWSmfDSjpAWRhJ4T7nczfTMZ3Z8hXtT4/yDsz8RQgGaNYcM3QevAUB
	vDq2eOokQ+KpSgSxqijwGjOuss7gFtZUXtbvqAt05Mwi7FdZmp8g==
X-Gm-Gg: ASbGnct+wabFwvxdEW2bsYZ5CnEGmyrxzaZ+v3jEEKJpwr+9PP+Sv4XaajPzAkR3/fQ
	U2poTvPnuOm/UC/Z7S5In4dChpPNHbQErja2N5OEDSoloq6b9ABblPIthZxrDmRgo0/LScn1RGO
	84jPK4m9yt7UNZnM1mi/+gHmSn5QvLaLRu3nHHspNhO3PmvULzKG25jPgC
X-Received: by 2002:a17:903:948:b0:28e:cc41:b0df with SMTP id d9443c01a7336-294def3d458mr10101565ad.61.1761698660159;
        Tue, 28 Oct 2025 17:44:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU7pEW3awf9geQ4pM7DBD/6siNYBhuIjxJvuWjFIacmLdv0RPpmgeVO8UUWF/8LKkGbvXCk5YqvUOQy5zX7No=
X-Received: by 2002:a17:903:948:b0:28e:cc41:b0df with SMTP id
 d9443c01a7336-294def3d458mr10101335ad.61.1761698659611; Tue, 28 Oct 2025
 17:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923-smp2p-v1-0-2c045af73dac@oss.qualcomm.com>
 <20250923-smp2p-v1-2-2c045af73dac@oss.qualcomm.com> <76gekllxr5meizr7wbvxjibdncdw7kp2q4zjjxtmdtfnwt4owc@dum7e77j4bie>
In-Reply-To: <76gekllxr5meizr7wbvxjibdncdw7kp2q4zjjxtmdtfnwt4owc@dum7e77j4bie>
From: Christopher Lew <christopher.lew@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 17:44:07 -0700
X-Gm-Features: AWmQ_bnyMWGj74bgEXMSd0pMIOm5WQmpOX6PuWZ1znOeum-cgrY3NLwNuJW-iiw
Message-ID: <CAOdFzcj0qqercZrcgabwU2opsKsEo2OnEgOQA=VGrefCdrT9bA@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: qcom: smp2p: Add support for smp2p v2
To: Bjorn Andersson <andersson@kernel.org>
Cc: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Lew <chris.lew@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=HvZ72kTS c=1 sm=1 tr=0 ts=69016365 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=baDIM8u29knSi3rfoG4A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: IhJAztyygq9rGSYq7R_2fXfIuxNOWtdq
X-Proofpoint-ORIG-GUID: IhJAztyygq9rGSYq7R_2fXfIuxNOWtdq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAwMyBTYWx0ZWRfXzTFuuMdHvmul
 kMnfdPUl5PvxZXFVqktUIiDJQipWhNsp6Rx68V5czu0oPvsh/tIwUrXRCRMUC7POGdBUKL5XS5d
 vgw0C01ZcbpkPegaA2TsmjPOQjkhwY/5ftHtHfSZTemA/gi3BxsbjTdJpXSzIzhNJxp0LRpx3cG
 odJX/igUaLUIsdLn3aPNyX2jSj5HuTswDAgPkouLgzMXq1+WC5mTAJTRaK6T2nkGbuz0d76BRX8
 vZNOeelc1RHn6ZHwv8Ctp5p/1+uD38VWjwsaWE1wgwzcP3yM3ewUOi21J8AuSEIh2XT7GTK8Tm6
 +EaYu+w+a+WS0EKDlUMsJU8wcT0HMcCpIEaJ52aqQmsTq29XCCSlQ4a4zYWTfyuOQg4o9CwIl0A
 tVnbv2Hqvt4YIkPVtjuBvHhkORi1oA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290003

On Wed, Oct 22, 2025 at 3:16=E2=80=AFPM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Tue, Sep 23, 2025 at 09:18:43PM -0700, Jingyi Wang wrote:
> > From: Chris Lew <chris.lew@oss.qualcomm.com>
> >
> > Some remoteproc need smp2p v2 support, mirror the version written by th=
e
> > remote if the remote supports v2. This is needed if the remote does not
> > have backwards compatibility with v1. And reset entry last value on SSR=
 for
> > smp2p v2.
> >
> > Signed-off-by: Chris Lew <chris.lew@oss.qualcomm.com>
> > Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> > Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>
> Please confirm that you really co-developed (pair programming) this
> patch with Chris.
>
> Isn't this a patch from Chris, that you're "forwarding", i.e. both
> Signed-off-by should be there, but the Co-developed-by shouldn't.
>
> > ---
> >  drivers/soc/qcom/smp2p.c | 35 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> > index e2cfd9ec8875..5ea64a83c678 100644
> > --- a/drivers/soc/qcom/smp2p.c
> > +++ b/drivers/soc/qcom/smp2p.c
> > @@ -48,10 +48,13 @@
> >  #define SMP2P_MAGIC 0x504d5324
> >  #define SMP2P_ALL_FEATURES   SMP2P_FEATURE_SSR_ACK
> >
> > +#define SMP2P_VERSION_1 1
> > +#define SMP2P_VERSION_2 2
>
> #define ONE 1
> #define TWO 2
>
> #define PLEASE_DONT true
>
> > +
> >  /**
> >   * struct smp2p_smem_item - in memory communication structure
> >   * @magic:           magic number
> > - * @version:         version - must be 1
> > + * @version:         version
> >   * @features:                features flag - currently unused
> >   * @local_pid:               processor id of sending end
> >   * @remote_pid:              processor id of receiving end
> > @@ -180,14 +183,23 @@ static void qcom_smp2p_kick(struct qcom_smp2p *sm=
p2p)
> >  static bool qcom_smp2p_check_ssr(struct qcom_smp2p *smp2p)
> >  {
> >       struct smp2p_smem_item *in =3D smp2p->in;
> > +     struct smp2p_entry *entry;
> >       bool restart;
> >
> >       if (!smp2p->ssr_ack_enabled)
> >               return false;
> >
> >       restart =3D in->flags & BIT(SMP2P_FLAGS_RESTART_DONE_BIT);
> > +     restart =3D restart !=3D smp2p->ssr_ack;
> > +     if (restart && in->version > SMP2P_VERSION_1) {
> > +             list_for_each_entry(entry, &smp2p->inbound, node) {
> > +                     if (!entry->value)
> > +                             continue;
> > +                     entry->last_value =3D 0;
> > +             }
> > +     }
> >
> > -     return restart !=3D smp2p->ssr_ack;
> > +     return restart;
> >  }
> >
> >  static void qcom_smp2p_do_ssr_ack(struct qcom_smp2p *smp2p)
> > @@ -222,6 +234,20 @@ static void qcom_smp2p_negotiate(struct qcom_smp2p=
 *smp2p)
> >       }
> >  }
> >
> > +static int qcom_smp2p_in_version(struct qcom_smp2p *smp2p)
> > +{
> > +     unsigned int smem_id =3D smp2p->smem_items[SMP2P_INBOUND];
> > +     unsigned int pid =3D smp2p->remote_pid;
> > +     struct smp2p_smem_item *in;
> > +     size_t size;
> > +
> > +     in =3D qcom_smem_get(pid, smem_id, &size);
> > +     if (IS_ERR(in))
> > +             return 0;
> > +
> > +     return in->version;
> > +}
> > +
> >  static void qcom_smp2p_start_in(struct qcom_smp2p *smp2p)
> >  {
> >       unsigned int smem_id =3D smp2p->smem_items[SMP2P_INBOUND];
> > @@ -516,6 +542,7 @@ static int qcom_smp2p_alloc_outbound_item(struct qc=
om_smp2p *smp2p)
> >       struct smp2p_smem_item *out;
> >       unsigned smem_id =3D smp2p->smem_items[SMP2P_OUTBOUND];
> >       unsigned pid =3D smp2p->remote_pid;
> > +     u8 in_version;
> >       int ret;
> >
> >       ret =3D qcom_smem_alloc(pid, smem_id, sizeof(*out));
> > @@ -537,12 +564,14 @@ static int qcom_smp2p_alloc_outbound_item(struct =
qcom_smp2p *smp2p)
> >       out->valid_entries =3D 0;
> >       out->features =3D SMP2P_ALL_FEATURES;
> >
> > +     in_version =3D qcom_smp2p_in_version(smp2p);
> > +
> >       /*
> >        * Make sure the rest of the header is written before we validate=
 the
> >        * item by writing a valid version number.
> >        */
> >       wmb();
> > -     out->version =3D 1;
> > +     out->version =3D (in_version) ? in_version : 1;
>
> Doesn't this imply that if the remoteproc advertises support for version
> 3, then we suddenly also support version 3?
>

Yea I think this is a result of a quick fix and certainty that no
firmware was running around with version 3. We can clean this up.

>
> I don't remember if we've talked about how version handling should work
> in this driver, but we should certainly define and document that in the
> comment at the top of this driver.
>

We did, there's provisions for the remote to version down or place a
0xFF value if it isn't capable of versioning down. Unfortunately I
think this versioning down behavior comes as part of V2.
Because we have to support older firmware, it was better to mirror V1
for older remotes in case they couldn't understand Linux doing the
version down sequence.

We don't have any remote with V3 so I didnt implement that part of the
V2 smp2p spec.

> Regards,
> Bjorn
>
> >
> >       qcom_smp2p_kick(smp2p);
> >
> >
> > --
> > 2.25.1
> >

