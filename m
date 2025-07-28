Return-Path: <linux-kernel+bounces-748649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0BCB14440
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144C43BBE56
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8557121C18A;
	Mon, 28 Jul 2025 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EOOZcutJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F570813
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753740923; cv=none; b=REQ/RfYP7a8iJ02n1M2p9t3J/90nrJcueaZReWYmG4Y01jiMNwmpvITbSFDDjkv6q1CQ+ipaaTTAvReZhnhaccUxSUKRuEDD1BV+xJeL5ZjaULnnjtidYKvfCCVWZLnt0QMx4zSoTT/2JJeV4X5OoZhpLCDYf6ELQu2rBI1gYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753740923; c=relaxed/simple;
	bh=zLQdrVxX2PRWd5WJQiNUkj73ADxmmzT9JOuFxjTOoyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEX5gOyb+lrZ7JqtTTjfBntmsK5Xpe+t1eFO4QBdJT+DeeoZmODvhw0y2fybk2z1wlftaS1jaxIujYbN0h4UvJO7NRlgJkxsWmaj4RRBdTN5Paz3rpxJFYaWc6ndPb32CFTxsPrsSDoSszv9GZtCIVGxiEo7bRtZgxIHoiGAtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EOOZcutJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SL0Heg016257
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=Lll6iG9jjiafodgAXUYVjtDfwGIt1eByg5KgSum8/2o=; b=EO
	OZcutJvKonX2omZ+NL3a/EO4wrH3sBDazzrQasl0tJGJfX3rM5H/MfDm6wuLZED8
	IHpt8lRWYwOg8B0032HGRNnWtJtk0aawEsSW8+62FzH52gaYRgIUruNCbDHdrFOc
	8ZtJhGkU8lL1qAxQtV69KZpJj8HoKBEWJf6ZaalGWEifUrtRX9hdirpKeWg1iLdP
	Qrx5RIwEMFRimF6enBlXmp17SYatnZuQtBERhJ+Z1i8b+AGAvMLJSioAiVuj6QvO
	k+wpN74hwyunZ6Jts6uat0/Klco639TMKUn9x7DzqAiz4ST1GL713384m337aTwX
	ZAXgd5KkpO7uV3U8KEsg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qd9wy1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:15:20 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-41c66de9ac8so2128419b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753740920; x=1754345720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lll6iG9jjiafodgAXUYVjtDfwGIt1eByg5KgSum8/2o=;
        b=L8y2j8z07F4RHqqSw0+CExV65b3pqAp7tZJI2DFgKsHkJmSHlOdHbLeJEEURHXrWU6
         kXX14xd2541uTn7wcwHGUHZmyjN3ylR2Qd20G3UTjvhK5RK0I7BKRWKShycrUsm3TmzV
         GkN9tG2JL0eo/BLIhJ9J8M2jrf9kFK2o0sBa3R9CQhFpWqnbSxM59qxvv2vcl8mFsm8W
         fcAOct8QpGwOduudn1p0iPNV/NweQlSqWJ186otTGA6j0HSUCaCfC9zXLPJlP4YVnKBO
         6CqVVm4ZTMDab1sqyAZE087bwswu+Ns4tZ0ndHR3BQW4P2x4n9uHUd9c98vYw6Teaiik
         QPqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYHMCELz5i8vcEqqY0vnzBPc/AhK/dmnp4UkdlhQok9v30RbTrUevBXXa7birVvzd0pzBt2vpUp6QPU+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YydbPRe0AkyEcoExbirl7LXTgEcoDy7ORN9uCTu6Zd7WjSR1swy
	jxrIq/TKCTPS3QCr2AZsO4bGFnnc1AV6aoxLlPOn2Uhm1axj+xbwR//u8zpM6NTFAKSCEb4hLyZ
	sZwGWYMreIYD3LTiAgqvI7zgCLWzcOvHLSs5OSjYJTeP5VMhc8bxHBMYg3BwO9vemPJaXrk63h/
	4VbXTKrUgDnxTTVwzkJJxmmK/T27RS4mEuFmQAMjvy2A==
X-Gm-Gg: ASbGncs3oOHot/RIRhiYf8WmaEvkLxaSGlJbYsniJziw0vtdmmMR/c79Nj9DYPz98fw
	qTKoyVFpe+LSyeSSWkyUrvTex/hijLa3vwM44Wmbe3HiPs5ODGEgM0CHww/mW0Wxn3CBBHQgpsR
	KJyqfJsy1S5ghPO819wxjHOInJumwZJMNPNi8uyoRZoKlV3d+MBF6N
X-Received: by 2002:a05:6808:14cc:b0:40b:3816:6637 with SMTP id 5614622812f47-42bb92437famr7502071b6e.24.1753740920059;
        Mon, 28 Jul 2025 15:15:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUWxjH77ANgUCz1gxut5vOzlfOsvuZGqBiRxeSnrpoSOaKr0Axu+0/yp56ejEjtW4vvXW/jn7lkoZRFSnkaJw=
X-Received: by 2002:a05:6808:14cc:b0:40b:3816:6637 with SMTP id
 5614622812f47-42bb92437famr7502059b6e.24.1753740919614; Mon, 28 Jul 2025
 15:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728203412.22573-1-robin.clark@oss.qualcomm.com>
 <20250728203412.22573-2-robin.clark@oss.qualcomm.com> <CACu1E7F=Y2oKfiWtD0VYfmLkL24e7JrZYMt8dmoGW7zrq7bd2g@mail.gmail.com>
In-Reply-To: <CACu1E7F=Y2oKfiWtD0VYfmLkL24e7JrZYMt8dmoGW7zrq7bd2g@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 15:15:08 -0700
X-Gm-Features: Ac12FXxKcQE-jGXesSBh-SermxAqmB7IQG6RNGuaqlm9uwFHrxNfWtJsGTe3B_k
Message-ID: <CACSVV02W28L0MS32J0n1PTpEsaq_6RxEPgb_6y6G=6TryGEPQw@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/msm: Add missing "location"s to devcoredump
To: Connor Abbott <cwabbott0@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: TxCb4x8Dk55YHR38e8xJadz9bc1QDcL8
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=6887f679 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=GWzUntYCYND7tZVuv0EA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: TxCb4x8Dk55YHR38e8xJadz9bc1QDcL8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE2NCBTYWx0ZWRfXwZYdhskUNvrV
 SEt6C61mrk9qbZH8HEhuAQMF/IuzSnDHAvEhJ3Tz88D58diZV9wNsSJ7COaTe9+TvHAPNQ0lABB
 Kmzo30u+ZPHzi34QavJSqI9aCryXGKx7dsbnWx/b1Iv1p93YkZsHKcL9nLpnYhaIEk2+cMCRZpo
 Xg1wBmerfDGAari2OCr1ACtOLvNgn/O+zX+tXW3ssEDLLS/z6NeHXxhe4V+YnNzUBE3e0nJFqbv
 742kq0LeS7zu/k4nQOOFJ4FA8wyHY8LPXQNgEZgrnc2QHd4OiqM7WiJOeLMiydhgq9bES5N3sgj
 wXpLT5QubhVq8Gb1+jQ96wFAMD940U3JBAiIIe6n1KpEfDosXUu2/GzVMkv1TGFzWicAXXvXErN
 cWGkujQ4EvT3rSl4ubZfHWEEnAjfaHWBCMYbMHvjrpoTncGH0cffevuJ4ClvSJp67Qp83KAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_04,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280164

On Mon, Jul 28, 2025 at 2:04=E2=80=AFPM Connor Abbott <cwabbott0@gmail.com>=
 wrote:
>
> On Mon, Jul 28, 2025 at 4:43=E2=80=AFPM Rob Clark <robin.clark@oss.qualco=
mm.com> wrote:
> >
> > This is needed to properly interpret some of the sections.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/=
drm/msm/adreno/a6xx_gpu_state.c
> > index faca2a0243ab..e586577e90de 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> > @@ -1796,6 +1796,7 @@ static void a7xx_show_shader(struct a6xx_gpu_stat=
e_obj *obj,
> >
> >         print_name(p, "  - type: ", a7xx_statetype_names[block->statety=
pe]);
> >         print_name(p, "    - pipe: ", a7xx_pipe_names[block->pipeid]);
> > +       drm_printf(p, "    - location: %d", block->location);
>
> We should probably at least try to keep it proper YAML by indenting
> everything after another level...

this made me realize I missed a \n... but otherwise I think the indent
is correct?  Or should location not have a leading '-'?

BR,
-R

>
> >
> >         for (i =3D 0; i < block->num_sps; i++) {
> >                 drm_printf(p, "      - sp: %d\n", i);
> > @@ -1873,6 +1874,7 @@ static void a7xx_show_dbgahb_cluster(struct a6xx_=
gpu_state_obj *obj,
> >                 print_name(p, "  - pipe: ", a7xx_pipe_names[dbgahb->pip=
e_id]);
> >                 print_name(p, "    - cluster-name: ", a7xx_cluster_name=
s[dbgahb->cluster_id]);
> >                 drm_printf(p, "      - context: %d\n", dbgahb->context_=
id);
> > +               drm_printf(p, "      - location: %d\n", dbgahb->locatio=
n_id);
> >                 a7xx_show_registers_indented(dbgahb->regs, obj->data, p=
, 4);
> >         }
> >  }
> > --
> > 2.50.1
> >

