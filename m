Return-Path: <linux-kernel+bounces-720286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9291BAFB9AB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E27176840
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92A42E7F36;
	Mon,  7 Jul 2025 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CosisA/n"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD020C000
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908167; cv=none; b=rHDTGsgJtl08P4Lmt0No9zk3s26wi+INiHyykD+vRUlSF43RIz8fmw98oV8KTRSxKuxitMclWCzdb34EAnjyqsEeg0n/zdJmE93j9Yl0GkmUS3ICpPD++UPdusj09QMU6zPiVDHCewcKjixYpBDrSmP/zglWfEzq++TC+sERlIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908167; c=relaxed/simple;
	bh=CAw4r4s8A3zwCVG37cGZ7evQRzMirsghvG1uh3y/t8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsvI7LSuNk9CzwP6yCMlSn1Z+cNkj4my7Isku2h+zaf2DH6Ey5APpCMNFREsBm/LS/ksLpotBqIiUeLfZw24CEsedaUQxVl1P+OIO80zsfpHHwkJez/y4o6MO5Kp9C2as+GNnRjBLGGF3Xlz3xdVJpDFJ68cJ5WMu7C8ME++QWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CosisA/n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5679TJWW021652
	for <linux-kernel@vger.kernel.org>; Mon, 7 Jul 2025 17:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=oT1DtUsRaA/zcFPtBS//4Isnss8E6kQPFTLhfURqEU4=; b=Co
	sisA/nNcWtS2/DV2jolq9HasCQctsMa5kfPmFIqLDrVOD1SDgP0JSJgyJ1+PFaS1
	zjXJ1V7DJ1yyptbgELitJYpBKHrxrieEgYp5KbfPTqfnPWHCIkO+CxmK/CMNu6H+
	1O/QSGgTmGJOo63j14IBH7EBOM97D6IUYWh61F7qbeX4l9LLcvIHZKP63SaDU8+V
	y2ewIpWM/aj8VE13eJtZv1qU+7/RTiNKWHayoFuWlhvsV9dDPmsqeXo8rqkMPy3W
	q6X6h0xSyp2wAs2whPMcFR7/wRHbjR6qJPAPx7yPqK8ICRqILPop9LqpjpX0QRj7
	BPn03wJP/Zj0p6K3qCHQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pw7qemr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 17:09:23 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-73a17986d6bso3049193a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 10:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751908162; x=1752512962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oT1DtUsRaA/zcFPtBS//4Isnss8E6kQPFTLhfURqEU4=;
        b=HfLOX4mAc3IUQ5rYk6NyXlwn8jy1e9u67EQ1Jbd62F6IsGaXDlspHMliYa16Y6XWPJ
         TsoRWRsqNkiHzgaD0s1Q+LluTkLkGXncPKne7+9jzcxVSNXbS+vOBL1OKAmvGSYroNcM
         9j4CxAT8Nd0JjgW1QkCepL61P+fBSwJ/gMUmgipyOyH9j1qz2xVrnnQB7Ycc1bpaN0pG
         NF3MZw7h57eZHhAXZEmu91ZELLrSuPFVc/lLFVKJZ4pDbhhXSsUh2vT3tr25qRzUIMCa
         2jT6KM4YCxU9M4TGFTL6n8GIRwAXWyyqvV9IUltvrg/cJgqBpLL4kW9eeTby6Z9myRKS
         lIHw==
X-Forwarded-Encrypted: i=1; AJvYcCX/xQd7Tf9n1Zcd+ErjuLWbHmFDTd22E8CQzAyt4aSvSyYMaMNeFbk2FySCWLop8g6Ol5YSxu/A6kRlnjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiyb/MKexYD7mVAsP70Bhwj6lAwa23VOe4/rwEVjRASTmZ2thq
	jK38CVWZXIeOmD9bDKPW9IhMfy5prWj6IU5wPSWtpq1B4HrGdaltCkctCTO0G4gAJAclMtn6m6e
	06ctR5RsUTSSTArz/cL3zVbRP2oECt9LzvQHfDYKhlG5GTpgcXfgWevuTBgCaLpIH/TE+hVsonv
	4S4fVrh40vtuKQrs274+nWLWXzzruwEhIa0l6k3BubviNWoArshw==
X-Gm-Gg: ASbGnct1flyfEWPIK8xGcvPPsufKiiD9N02A8+7qorv6km6glQcuWtbDxl1kBYhqg/8
	aiJGBH0eEIgGwQcc0HLSaY6QurT9kWZxFwvfwHieJqFZzL9Ii6X7g6peI3xlTHCH2brNhb2SOK/
	g3PAww3u9fpApDfcqy05jXdbgL7q68sHhCKcc=
X-Received: by 2002:a05:6808:211f:b0:40c:5b58:c9f9 with SMTP id 5614622812f47-40d073ccd23mr8743852b6e.22.1751908162422;
        Mon, 07 Jul 2025 10:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJFgTDJSExh2v7ckh3Wk01zSJ3P5QE5VWongvlxIz7t3sbZ/GbabrbWMQ+rzFK8GgUIeDgxM2pypdJm3Jto6Y=
X-Received: by 2002:a05:6808:211f:b0:40c:5b58:c9f9 with SMTP id
 5614622812f47-40d073ccd23mr8743829b6e.22.1751908162097; Mon, 07 Jul 2025
 10:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705145242.781821-1-robin.clark@oss.qualcomm.com>
 <20250705145242.781821-2-robin.clark@oss.qualcomm.com> <6579c65c-877d-44fe-aa81-5b0e602b33f5@oss.qualcomm.com>
In-Reply-To: <6579c65c-877d-44fe-aa81-5b0e602b33f5@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 7 Jul 2025 10:09:10 -0700
X-Gm-Features: Ac12FXxuUa5Yn05AD9M7jkS94r-Rdb6D2yJUjRtTcPRlVGpITucDmRppAplnMyc
Message-ID: <CACSVV03U75=5LYdWkbQ-FOU6L-F50iZ+XgpT=f6+-sRNkEv6sA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm: Clean up split driver features
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDEwOCBTYWx0ZWRfX0vVKvki6RvLS
 O6a6FGhBDS+TFF7Y+0VLLxI65j6QDwRIlG4pxlT6GiHrYo4xHeq3LLISmRxZBVRTxVWAo8fAPUy
 uU6w+oUmdiipxLkd6GrsTxomNHhmgxKORy2/JMjycVXVzxFZbWeBv4zvXx/lJ6Rfx1XbWbgm6mg
 4uWIo1ci5tdNILC2qnuyMUzoIQZA93GoW0rNLZAWtqK6Bp7l5AunSiEt+fEYNQno/Oi86yuPr4H
 YuM1OinA9NksP1vUPRS0Y8fKxwIr94C73lUjxvQIJCsIWY3VvoRTVRn+9hX1x5JYFF7TLSqdhOr
 X8F4ozavFU0DuithqV0bGXcqcJZvIoFWiY6MESSTrT33d6Iw337q8gAorhmwEtiihdNL7rmNW8I
 paVdL29hCVbNrTX1n/3EacJvZ3qGW74JEu4o5UlpsWuFlDL27qD2DQDOn4b2v7prPa2C+aSb
X-Proofpoint-GUID: aT5zkvC_owhzcrzbLxmls9BuumTX6Jap
X-Proofpoint-ORIG-GUID: aT5zkvC_owhzcrzbLxmls9BuumTX6Jap
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686bff43 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=mFyTvTkbTY4ge-DhZPYA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507070108

On Mon, Jul 7, 2025 at 4:42=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 7/5/25 4:52 PM, Rob Clark wrote:
> > Avoid the possibility of missing features between the split and unified
> > drm driver cases by defining DRIVER_FEATURES_GPU / KMS and using those
> > in the drm_driver initializations.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_drv.c | 31 ++++++++++++++++---------------
> >  1 file changed, 16 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_dr=
v.c
> > index b6efc5b9933b..5695de1bbae2 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > @@ -816,14 +816,21 @@ static const struct file_operations fops =3D {
> >       .show_fdinfo =3D drm_show_fdinfo,
> >  };
> >
> > +#define DRIVER_FEATURES_GPU ( \
> > +             DRIVER_GEM | \
> > +             DRIVER_GEM_GPUVA | \
> > +             DRIVER_RENDER | \
> > +             DRIVER_SYNCOBJ_TIMELINE | \
> > +             0 )
> > +
> > +#define DRIVER_FEATURES_KMS ( \
> > +             DRIVER_GEM | \
> > +             DRIVER_ATOMIC | \
> > +             DRIVER_MODESET | \
> > +             0 )
>
> Perhaps I'm missing some C lore, but do we need the "| 0"?

It is just to avoid later diffstat noise when new flags are added :-)

BR,
-R

