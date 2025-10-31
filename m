Return-Path: <linux-kernel+bounces-879313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E90C22CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D18834E6C0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1EF1EEA54;
	Fri, 31 Oct 2025 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tt8CVoET";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GpzWEeeX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463E1E32A2
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761871266; cv=none; b=nVs3o2v7akUOgdxH0wgC0zs4ICcaGy4a5LIDEUrrw10UJZrfII8c3IaKWdhbNxdSZ8gWhx23VNAZNF70ppEpxyGV43LwSoz+5wi8VVUlNMiQgpIK02Zp5+S908YmV922RNt9Xzc4tnGJZ/q8xKvwzl7H8i1tK3GHLLQzeGNhtyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761871266; c=relaxed/simple;
	bh=9OwIj9PFMRwkVbM/tIEg+J1UpDfMhn0akcMcMbZ4JFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEE/CrPbvcBK5sJkYBmqW5My/OYgRqgs/wtfaYb9YHE2esGIM0HPzh8nw2N4QGP4Li7IdfXuROqCys0l2BVHyNCbAyHuX+rc2D+QuzXY8JPnYbtrdXlL0Irj7kPMFO2rklB/jeo7X/nP6bBOMB12JAF/Xzm0O0E9Adrfpk/M+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tt8CVoET; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GpzWEeeX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59ULGYVs3809707
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fieI57xasLw9EncC0Xevpb3EAjDUZA+fje4i8+ZdQHg=; b=Tt8CVoETy5L+OSB9
	+I2Bt/TKXSoaTVnNnC5uNVLRwG6inkgWZptgp+oPoN5ztfMmhut8m1gVkkbH8+7q
	5IBXIO2AkeP05QxNO7hlM1XVdpt7nsZyVIIBy4ZUi2a5wrfIMf4n5LkVWm+pDWmJ
	pM7F80JKFxxgS6SH/fpZgNx2ZIH/7ApfaIYFBxjlN0NnGM+7BJDS9qfQQTmHjSHC
	tioNPj0cDnk8YD7RL0NdPWRZM9+r+m1SvlxRaoAkxvo7j5zq1OE1L2O1DHec7GqP
	WNZMEOS58jopVwGG9DksPG7HnXIDzYDVBJcFD8+HAOSSSrkgOGLos9d4E1BAesMe
	gtKA3Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a46vva4a6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:41:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33bc5d7c289so3054741a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761871263; x=1762476063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fieI57xasLw9EncC0Xevpb3EAjDUZA+fje4i8+ZdQHg=;
        b=GpzWEeeXHSTIevW+jZlbaV/O37MPyzHxYec4f4upTMBvE1C02+19Wozs9D+1ko5Szx
         Kky52OKU7xXwbrQH5sOMzlmLfuCzHDRN48QmAO9dBn4gsgQS7XlQWUjZ50hLoS6GbUJR
         Ao0CRluLJU4vHgkS7u4GZFDo4VxlAdh/KecD0tW+kX0jYQg7BmbeQuA5jbo1h+PWQbd2
         RSU0y92L6kgqS+mddi8hDyvDf55n/19cmtm3JuIjxj5YEOj9UUEW5Tlahnp/lEjYvNeF
         7lSnQZhW1bJOplyu9EE4zpTICoGfX1HCBcvqe8YLwxb+a4WyijRa/DrFFczVT5hl2TKT
         7ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761871263; x=1762476063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fieI57xasLw9EncC0Xevpb3EAjDUZA+fje4i8+ZdQHg=;
        b=f5vmZcB/xznxcCdimOtUVagEXKK0+4O7nA5szDzQLb96Wl6MJcBPtUXWKcQ7FoPZXT
         yIWEVSIybVinHOC/hwptAMs2VesjgmYJf/iPg33x9EB9S5M/6D4uNr4wlKWfxH9TxX/0
         0jBCwq94YcHhi37IYDI8ywRKC23faKBvuqS7AwRLGAowYh4gGH1AO+CLe4L2rtDD2J+J
         0FGd8UuF+iAvo0aoy4+uCMti8Ms2DFoBGuSfQFmsC0Ny3oyveH9M7/LgDW+ZVOC3Xzsu
         jZrJ+s0eOincosYxgSyi70xW9FSJIrX7ql2qmWif2EZT2rrPHVJ+mk9edLoFlffXT8as
         HU1A==
X-Forwarded-Encrypted: i=1; AJvYcCXWXfqbKyhVH+FSivp8213AFLo57Hkd558yeJtGqEDcf8JXcWcCDJenZ6RhFGtBLSmLa3O9ZVh6m8AgK6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT/qA/y3w77CoaXuUKxPXbsAvSJTerxjYzAhIv4AEgJ2oGPljr
	0UBp4kptPbdrw7osYZg0wRNvM5TZv5I27/JlCGumlLAZCy7zzUatxV3sWCUo6C1toKg6JlkbnQa
	yjH24G52OJtzQQz1jnejVgiYE4Xyx4eSR+i+xapffnN/gk2wTSYlrspEJOK9/sWaULLXAo/Osb9
	CDE+gGBmJjjKRX52D3TfBkO1yHbHTjLD6lIE2uFwy5Sg==
X-Gm-Gg: ASbGncvp+k66cXsllKQ7xTTnJu/5Nh8FkSeKJmb1nqHEpJWBrMbdsJ3/1oSqhVsm+VM
	M+N5GRjapeg5mU/zpv0K7oPajMMOEIdQX2J5ebsm6XYIfrkbH4/h8ehEmS+XMb6QG8nZS1opfLo
	nTij+VhchXC3Ie+lK5vz4p/d6LMa/oKIPGWaut72Jl6U2zjvKO7GjxEDGu
X-Received: by 2002:a17:903:2312:b0:294:ec7d:969c with SMTP id d9443c01a7336-2951a50c692mr21434995ad.49.1761871263423;
        Thu, 30 Oct 2025 17:41:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC9d0NbRoeYA85hEQkJWEwVJ+EE4LoE6kzbyP6aWT4TNxoNQbGWC2q7luvndHS11q8pvC9sXHuUAdD1HJo7dI=
X-Received: by 2002:a17:903:2312:b0:294:ec7d:969c with SMTP id
 d9443c01a7336-2951a50c692mr21434765ad.49.1761871262918; Thu, 30 Oct 2025
 17:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030-image-crm-part2-v1-0-676305a652c6@oss.qualcomm.com>
 <20251030-image-crm-part2-v1-1-676305a652c6@oss.qualcomm.com> <b46wt76zmlms5h6zkner2rr22hwmsz422jy44qziqe6a2c4qrt@i5x7j6vgrzqo>
In-Reply-To: <b46wt76zmlms5h6zkner2rr22hwmsz422jy44qziqe6a2c4qrt@i5x7j6vgrzqo>
From: Christopher Lew <christopher.lew@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 17:40:51 -0700
X-Gm-Features: AWmQ_bkXlYO_uuXkcSoBngT4E6PKPtcwdTjS6iU6XK7p7ke8Zy-YreTFeA8H-yo
Message-ID: <CAOdFzcjzzymRxqoeF+FDidDo1aa-fNzV-3kERoV7HRW7RpQ1kA@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: smem: introduce qcom_smem_validate_item API
To: Bjorn Andersson <andersson@kernel.org>
Cc: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Chris Lew <chris.lew@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: nz5UTt03Zoiy-vWFMavI4m2L5ZwzH9BJ
X-Authority-Analysis: v=2.4 cv=dK6rWeZb c=1 sm=1 tr=0 ts=690405a0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=0zU5oqwhyjOOBdmDFkEA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: nz5UTt03Zoiy-vWFMavI4m2L5ZwzH9BJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAwMiBTYWx0ZWRfX+sQqYDuRwLnI
 n4kUSqt631tlz6yM8XJRp6TSDdjzGhxuCX/hF9E/qmffQpEtz3dqxr0ib8dT/v8cveqNhZX5amF
 e/od+epb5B2BAkZ9A7/FhpBpCtMF1jAsnD/FtDrsVecU172rpoGnktJzjc4rZ+HNChwS9BvpyBM
 lADtOuImd+cz8uKyGIr98BuV63OWLtCVySV0y89ov9dmmIzcLPMRw325TbHGmSv7XznIdnsbLIL
 s0x/ZZR6Yu8l0kI2Y3Qw4QAxYA9u5X3tOgCocYMEWBtX2NcL5MlDsAjeXgkh4jiG1JWAqgu7O2r
 R+5g9HU4Dk/S/b/wvFRHB0XnHDw1VwkkbHYz7wQfJQCtrz2mtouHb0ytgihlqX4fCNoqrTg5B3I
 y+g51eTNSsLnnhHqkosDyEsonb12/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310002

On Thu, Oct 30, 2025 at 9:48=E2=80=AFAM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Thu, Oct 30, 2025 at 03:07:48PM +0530, Kathiravan Thirumoorthy wrote:
> > When a SMEM item is allocated or retrieved, sanity check on the SMEM it=
em
> > is performed and backtrace is printed if the SMEM item is invalid.
> >
>
> That sounds overly defensive...
>

Discussed with Bjorn a bit offline and we couldn't come up with a
really good reason to keep the WARN_ON() check.
Dropping WARN_ON() and returning an error back from qcom_smem_get()
that clients can act on should suffice.

> > Image version table in SMEM contains version details for the first 32
> > images. Beyond that, another SMEM item 667 is being used, which may not
> > be defined in all the platforms. So directly retrieving the SMEM item 6=
67,
> > throws the warning as invalid item number.
> >
> > To handle such cases, introduce a new API to validate the SMEM item bef=
ore
> > processing it. While at it, make use of this API in the SMEM driver whe=
re
> > possible.
> >
> > Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qua=
lcomm.com>
> > ---
> >  drivers/soc/qcom/smem.c       | 16 ++++++++++++++--
> >  include/linux/soc/qcom/smem.h |  1 +
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> > index c4c45f15dca4fb14f97df4ad494c1189e4f098bd..8a0a832f1e9915b2177a0fe=
08298ffe8a779e516 100644
> > --- a/drivers/soc/qcom/smem.c
> > +++ b/drivers/soc/qcom/smem.c
> > @@ -396,6 +396,18 @@ bool qcom_smem_is_available(void)
> >  }
> >  EXPORT_SYMBOL_GPL(qcom_smem_is_available);
> >
> > +/**
> > + * qcom_smem_validate_item() - Check if SMEM item is within the limit
>
> If nothing else, this contradicts the comment by SMEM_ITEM_COUNT.
>
> > + * @item:    SMEM item to validate
> > + *
> > + * Return: true if SMEM item is valid, false otherwise.
> > + */
> > +bool qcom_smem_validate_item(unsigned item)
> > +{
> > +     return item < __smem->item_count;
> > +}
> > +EXPORT_SYMBOL_GPL(qcom_smem_validate_item);
> > +
> >  static int qcom_smem_alloc_private(struct qcom_smem *smem,
> >                                  struct smem_partition *part,
> >                                  unsigned item,
> > @@ -517,7 +529,7 @@ int qcom_smem_alloc(unsigned host, unsigned item, s=
ize_t size)
> >               return -EINVAL;
> >       }
> >
> > -     if (WARN_ON(item >=3D __smem->item_count))
> > +     if (WARN_ON(!qcom_smem_validate_item(item)))
>
> When we're using a version 11 (global heap, with toc indexed by the item
> number) the SMEM_ITEM_COUNT actually matters, but when we use version 12
> the items are stored in linked lists, so the only limit I can see is
> that the item needs to be max 16 bit.
>
> I think we should push this check down to qcom_smem_alloc_global().
>
> And have a sanity check for item in qcom_smem_alloc_private() and
> qcom_smem_get_private() to avoid truncation errors.
>

For alloc, I think we should adhere to the platform defined max
item_count. I'm not sure if the remote hosts validate the entries
against item_count while they are iterating through the items during
their implementation of qcom_smem_get().

> >               return -EINVAL;
> >
> >       ret =3D hwspin_lock_timeout_irqsave(__smem->hwlock,
> > @@ -690,7 +702,7 @@ void *qcom_smem_get(unsigned host, unsigned item, s=
ize_t *size)
> >       if (!__smem)
> >               return ptr;
> >
> > -     if (WARN_ON(item >=3D __smem->item_count))
> > +     if (WARN_ON(!qcom_smem_validate_item(item)))
>
> I think we should push this check down to qcom_smem_get_global()
>
> I guess we'd still hit your problem on version 11 platforms if we keep
> the WARN_ON(), but I don't know why that's reason for throwing a splat
> in the log. Let's drop the WARN_ON() as well.
>

I think it's worth keeping the item_count check here because it acts
as a quick short circuit out of the search loop for absurd values in
qcom_smem_get_private().

Thanks,
Chris

> >               return ERR_PTR(-EINVAL);
> >
> >       if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base)=
 {
> > diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/sme=
m.h
> > index f946e3beca215548ac56dbf779138d05479712f5..05891532d530a25747afb8d=
c96ad4ba668598197 100644
> > --- a/include/linux/soc/qcom/smem.h
> > +++ b/include/linux/soc/qcom/smem.h
> > @@ -5,6 +5,7 @@
> >  #define QCOM_SMEM_HOST_ANY -1
> >
> >  bool qcom_smem_is_available(void);
> > +bool qcom_smem_validate_item(unsigned item);
>
> This makes the API clunky for no real reason, let's avoid that.
>
>
> Adding Chris, in case I'm overlooking something here.
>
> Regards,
> Bjorn
>
> >  int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
> >  void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
> >
> >
> > --
> > 2.34.1
> >

