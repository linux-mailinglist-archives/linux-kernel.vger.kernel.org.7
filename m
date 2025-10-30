Return-Path: <linux-kernel+bounces-878879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F31C21B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10AA64F6791
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123B237574B;
	Thu, 30 Oct 2025 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C75Z2qjU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UWOQ8fUn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F6D225761
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847340; cv=none; b=b6BGbRajq9LhO/8E8O2zI9mZDV651f8oelf6O+WcYJC9v/+97dE77uVHTX52uyabmLL1dK3qPydEnNRamIzFcyKyZ7fzzSiSrhQMjziVQaCXsKhDwZ24ohqP+/3q5jApYH7CGPvje9B4BR9Yh56b0fJHUcSKAVrNLVMeW8eOgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847340; c=relaxed/simple;
	bh=ebYkUjTkInC6W+kEnq2zOzMCHyxPH/pnXbtdqaHTyik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSkoco/l/PZzbiAYU3pQPw0Emtf/PdWFiVzPncb/tg7tEayirEBuZq1+VYfsvNH4epd3YDGSHtB575CFh6aZml49xDYZfluuand/ByaZ48OY190nu4Sn4VnWbl2OzgvB9Yg83TMc6mnHWLJ/sWLoCJKqAhjQBmmZr254LirGNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C75Z2qjU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UWOQ8fUn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UG6Lls1655594
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RheHgo5pVuvCVdocn9ENbXAi
	PLiZAdlGRP3oP5F0h2E=; b=C75Z2qjUoMsGdoIq+At1x0n8FOS3Hrzy2R6drmju
	eNqHssKq+SuqRZeOGqSu57BLljrDLuBxYjeKsmD0dFqwlNSvzfdkfX8W9+tdbsEW
	ouK6mQDYttHoYvDvx0yx7T3sSLLXPhplvhCrPcKWuIhLLFPYjt7fpZrFHVepawsB
	omVIbrXJeqvvdJ4BV0H683ffQ1TuNJmdIoSNdmeBJcoDatyfP6lx+w47fZ76RrLI
	Hhs1GZA4zelYxuuM3xs7oS92TSNgIUWtXzVbrbI/9P+HKz/oP9nNcYPLRcNrPRk1
	Vkhc9RM9nf0ocH9ooR3sK5flM4VC/Q18+0v1vVohntiouQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tptu8et-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:02:17 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-556a28eb409so2704701e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761847337; x=1762452137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RheHgo5pVuvCVdocn9ENbXAiPLiZAdlGRP3oP5F0h2E=;
        b=UWOQ8fUn17GSmkAOubSCYYtBMjoywiltdlQbiEikLAJHKJIS5m/HUx3qP1tD5ogqyv
         QYr0FK58f8D+Z7boS2RFYCnhmRY6DTlOjJIhO4dcTQtCd8Nly9IBGP+oN2uJEjNHin4J
         BHCE/arwZ8+Jglu+DB+aWdrZ3txzYSmedzxweYUBV2rQCOVk2DPjjH7rhbvAkOv/bFRN
         7jPhz83pWUlQiPj5dJQrOjCPRCBzMZBLGxE86YQ8AG+Mhm9b3BANIK7eKxcPOIk/PeXR
         fW1usY+xMuNg+gBT/LOt1S3kxPGHXE7CDZ2xMxqe9YT++spI1fKar28p6Bdahm6b5CVv
         G0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847337; x=1762452137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RheHgo5pVuvCVdocn9ENbXAiPLiZAdlGRP3oP5F0h2E=;
        b=xJU6bkf4IoVR5ymNZ806eoivXZNg95aNqwMD67K7fX+RINkUcuNdPy5kUHftjo/1Hr
         4JFpaGb/I5g4vTyYphhjDM5TQYyF+W8PsE9Nz6lD6jHPgF+9YYTfLQUNquGm0Q2nLTXc
         jpnx21SRwqp6nf0DW7mpgtadrDwjeONdsBDzi5EVrJxhWGkuileS6VrM3NAFIRNUEgDo
         ZGPF4KpjXHnB+su9NTKWmEz1GLPPE1JvViKHJHnB3bUPrQnQUTB6I6NR3kcPaDVq+fgt
         cTrp0kqcllO0wTz+9E7XlQ12tIFwUmFa1gv87OyuZQ/VjoDWg04ouMb7D13pneSK0QH/
         egpA==
X-Forwarded-Encrypted: i=1; AJvYcCWZtCz8iRCmf/KE3Qo9zI9yuh9iHygWkKLIAQIKzqEg2EEL0uEAWsZtf20HRbb4odWZoRvZWzoxqKS/5X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcB7JOYEsTa4Pr2Pt0lNInEiCASg1XTtiLv2AmxWopJHDb6FbO
	qZwKGcCPGc3pGsOo4NDHO4JBTnub+bMXQPglkswbHRpSuVyUVMMD31NJ9BPanXztG86PCYCFFF5
	p+tenxzqhXZTw0gDTJPCbQlyZdvpk1C6BmtS5qmy+XEVk3sfGqdhPdR4rzrLEIbyG7ag=
X-Gm-Gg: ASbGncsM072toEYQNSM53LXEY/m5YnIRybbZCWecvIXGcDj3ZGRS6QzHFgvbYPgb5F/
	0FFW7uEHQzPB7dCnPpaY+sqUU8D+NrRgewHEfWqluZNUhenHCXRGKBSVaJ+YF8V6mxFpP0F9SJq
	uS0NbukucJsBOImySHfKBtP8rzszhl96ltwk0xcdJUWlSLjgG+7+qkH86mfh28rxKnHWwzAWg4d
	BVonIxgAThyU29pHBnoodbvWgm/dw1K5lren0uMqH8MvKtAsj/XQB7gmJevmeIcolUtNCLf3k26
	lpMNqOQuM4GE6yMEnvWelv4Sfmm1d59SF2d5iJmIW4amOKFZrR/4zjRA0D9yXBbVs6sNFUZ1379
	i7+mz6G8YjJmKpcINVSyiRLjjtyVZNJn+Ake04ikxFKqLvlFcNoKVLA060wlVgOGYoLPe1KzvoR
	wVZ/bybb+AFCx0
X-Received: by 2002:a05:6122:1b8f:b0:541:bf69:17ac with SMTP id 71dfb90a1353d-5593e47e35cmr384128e0c.16.1761847336535;
        Thu, 30 Oct 2025 11:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTUInpRsTJOc8SKFIzEahxJdQTKBRduSeEFhBOHHqnWR1cf+EOntfXk2b22CcXF3blRRpO5Q==
X-Received: by 2002:a05:6122:1b8f:b0:541:bf69:17ac with SMTP id 71dfb90a1353d-5593e47e35cmr384016e0c.16.1761847335762;
        Thu, 30 Oct 2025 11:02:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee092282sm44025471fa.5.2025.10.30.11.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:02:15 -0700 (PDT)
Date: Thu, 30 Oct 2025 20:02:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjiey <yuanjie.yang@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 03/12] drm/msm/dpu: Compatible with Kaanapali interrupt
 register
Message-ID: <br3aukcmx3p2mtowqglcuf77s5xfnfv3eisjexabxhjzigkjno@wk7sqptjn43a>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-4-yuanjie.yang@oss.qualcomm.com>
 <nfekr4vi34ftxzyyf5xv4tsb5cr3tokiyfkerypqjf26dos3uq@42wcn6ji7nnb>
 <aPrre+WXogSZIE7L@yuanjiey.ap.qualcomm.com>
 <st53uwtdow2rl6bvmfitro2dmodxtzfnhyzon4xeeetkkwekxh@ewlzkelq25wm>
 <aQGAvLFkH80Id3p3@yuanjiey.ap.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQGAvLFkH80Id3p3@yuanjiey.ap.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1MCBTYWx0ZWRfXz2H+8GaNoqvO
 k3bJJrbz9wxVwKNT+02W4eZZdbhT7GWMym1andtTSCx2lSWCKJET0Jbs+4zZjYsYvgezJhCtsZT
 DzpecNWsgX/LcNsEDc/CmJ+hEykHlZUqLyp/ML5vZr7ZwJmNDKkPnOoW1bO+o3ZuoKXBpUU4PTb
 ys14m1fx3qs6mm0KDyeeeN1GYo13Z09Sg0JD5lmBKmEyAMJqXJaKo3JOeoGUk3mpLU1bYyM2A2U
 I+dExNi4puQEUMO473ZLJThapFs2i9Ze9Ct32KN/iZt0RqjnlzVD9iFTzliMI4h8LYtjyGqFKj/
 vKBWyd4TCRc26SlaJ1Nm2pEooD6mOsfdbOgNev8d5eq0mB6YxOD1jTsoXn1xRrvsQz+P/FKyAyu
 JJCYuGEYZUefKnJDMWDb6tz3PG9mVg==
X-Proofpoint-GUID: 9RS4o07sBFGqXdTkFK-l444Sbw4mFpjm
X-Authority-Analysis: v=2.4 cv=MuRfKmae c=1 sm=1 tr=0 ts=6903a829 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=4LvRZMndKBpg9nUHPPEA:9 a=CjuIK1q_8ugA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: 9RS4o07sBFGqXdTkFK-l444Sbw4mFpjm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300150

On Wed, Oct 29, 2025 at 10:49:32AM +0800, yuanjiey wrote:
> On Mon, Oct 27, 2025 at 03:21:33PM +0200, Dmitry Baryshkov wrote:
> > On Fri, Oct 24, 2025 at 10:59:07AM +0800, yuanjiey wrote:
> > > On Thu, Oct 23, 2025 at 02:59:12PM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, Oct 23, 2025 at 03:53:52PM +0800, yuanjie yang wrote:
> > > > > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > > > 
> > > > > DPU version 13 introduces changes to the interrupt register
> > > > > layout. Update the driver to support these modifications for
> > > > > proper interrupt handling.
> > > > 
> > > > So... Previous patch enabled support for the platform and it has been
> > > > using wrong registers for interrupts? I think that's broken.
> > > 
> > > I want to express DPU 13 has different INTF register address, so need to add new
> > > interrupt array to let DPU 13 interrupt work fine. Maybe I should optimize my commit msg.
> > 
> > Make sure that patches are structured logically. You can not enable
> > support for the hardware if the interrupts are not (yet) handled.
> 
> Kaanapali Dpu interrupts: 
> INTR_IDX_VSYNC,
> INTR_IDX_PINGPONG,
> INTR_IDX_UNDERRUN,
> INTR_IDX_CTL_START,
> INTR_IDX_RDPTR,
> INTR_IDX_WB_DONE,
> 
> are handled by irq handler, so here enable dpu_intr_set_13xx. 

You have enabled DPU 13 in the previous commit. And only now you are
adding support for interrupt registers on DPU 13.x. No, that's not good.

-- 
With best wishes
Dmitry

