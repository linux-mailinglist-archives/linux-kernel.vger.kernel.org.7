Return-Path: <linux-kernel+bounces-755306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A095B1A466
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB4A18A20B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7F227145D;
	Mon,  4 Aug 2025 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RMp4iUAd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65627054C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317087; cv=none; b=hHput4aFtS0hTaeuEGf+/Jty3zF0BLRsNu7NjyNlOtJkAROrJd9hyTn4aPxLAslI4vf/md1hZrsKnDU7B7X7J5xArTsPG1bIViCzpmZ0gDL+xAS+XbIHyeIhwkPTGRa2uSFpindISP4WTTQzfNUsk5gnMcxTlDnYE/gDWWYwYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317087; c=relaxed/simple;
	bh=VKZmdjotUC3YbS16o6pwylau9DHkDdk5aDr5RC+8Sb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyYJ/+JlDNKasSND/tEYeYO4b6FR3u1qdDy4Onwvow4eXhlsSBBkQAlf4/i2DmxvblpBEIhr+ZicCficSYF8XullLGiLBP2DzAwMFoKg5cxP5iuzOInnvxOC9rZjehm1ZkZ9Lv4TdfBNCyunoXJxgIdmEuBALV1f/WCpBzmBlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RMp4iUAd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5749OTsp031634
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 14:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yV10ozYgUe4tzTx22lApIwGp
	t095dJ2LaBUIJh0zJQw=; b=RMp4iUAdZ9MiaxFspe846207a/m9KYLu8rIGQKjJ
	qB4vNnU8PaDP1Ad933PHN0PyrgvOI0fhe2SGeJ77pV9WJgEDfyRM1Ae4aDn7aWNf
	IArKKl93H++Hq7ONRD+H4cj1YfYK67jEveI1tDzu0H3ULUuMenzm0QKUmIhAfn78
	eP/TJ68EYRxJALyFI17JPBWUmbN/MiaxK8jEF1ZMT/gakSrO37rUX60yFUKn3OWA
	BXG9d0aoFqfMM+IqudbsaqHxRQycBnRzuVyfkbun6/f9EN7LiFNusGcsS9E5lwp8
	vgrmuF45J5XPyfxVbmtZycCTKPTarVb1uTQOK3ybKwJnTg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ak5a22ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 14:18:04 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-75e28bcec3bso5974420b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754317084; x=1754921884;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yV10ozYgUe4tzTx22lApIwGpt095dJ2LaBUIJh0zJQw=;
        b=qejK+LsHSQuQBo4/USWnKL8EQuzA05wATvLiWq8cwiiGOJyR9wkt7LnSXOqFgU/KvX
         v4w0YXHZXGNp7lmmEJyz27M7UIpl179grktCUleLXufohLq/Ohs3SCU9oGOcTrGfx9FY
         4IzM3VMpdcR1SyyZytFMAghUGdkdFnZe7vgCnS36ZBx7sS0jggDHFYSIliK2jcOtooMD
         ZWBJcI+9sdZTqVvb+7t+2d2aSdrUMPrfwzo41C5YMaffWNleUfFArzI5wwftM0V8o7DX
         C9dHspY2RIAsaU7xymNOhumVNhgpb71rrfzYjHPj7z3FtB6xw4ZLRJnslHfnctu91Ydf
         IcAw==
X-Forwarded-Encrypted: i=1; AJvYcCXTJ3N3WWhkWsvnqBkQqYoMQfZxUqP9RkHPWOyIxPkpGgMfByMwIl3S19MRzrOUHwsFiM5HED8DaLeQSJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZP2MLyikTjHPp2WNL9RdVz09N7Ia0EYwh+XQse8M8b5n58xk
	W6jw09Wbe4T7awLVbQPDUsAFlZsh/qf6HKmFQ94+31blnUoOQYDlUMLjnxLovg44gM+zkk/NKrt
	HLvmAzQLV22njI7vXkR5qGfnmmzsNYQFwHxE4O86ticowqgtDjHKdqxTSuRxDwoVPXRs=
X-Gm-Gg: ASbGncuUgOHXqQC2KebZENN5byWhOYM02lqV60lf9LLgf6uwUv+CDY7IuzV0CimJR+D
	PuH3xJNPwyECixCc0Mxdl21xWsVXMMzd4+FiCuNmNIxiFYB2RXW+9hPyc/TEvkA2KzyGN0MgHlH
	JptBhuDDpmNG1194DLlIKEVudG3Y+/YpVJKSDbYgrWwUx6Pm/Dd0vYSK03GU8ac7PDoyj6QlyQR
	oW4L0vDFx6OKKzOYgVXzN1HByZ3xjLbnriQjBBgZVBuGE3s+4IGOOrJnNmEVRCp0fiVVl3IyYj/
	uLCTtD4l2cev2jVYHEnQmvJx0/kPTNZv/HujemoFUi9xqfSRBIQ+41MG7CyyRUhLbas=
X-Received: by 2002:a05:6a00:744f:b0:76b:f06f:3bdf with SMTP id d2e1a72fcca58-76bf06f4064mr9615998b3a.17.1754317083693;
        Mon, 04 Aug 2025 07:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGDsTzlLGqDnAvh3MpUA8PVpt35YKMpiCWpzipsOhlEqGhm5w5CMVTLOTYyI4L20glEIYSNg==
X-Received: by 2002:a05:6a00:744f:b0:76b:f06f:3bdf with SMTP id d2e1a72fcca58-76bf06f4064mr9615955b3a.17.1754317083308;
        Mon, 04 Aug 2025 07:18:03 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bea205365sm6411378b3a.83.2025.08.04.07.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 07:18:02 -0700 (PDT)
Date: Mon, 4 Aug 2025 19:47:55 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] soc: qcom: mdt_loader: Remove pas id parameter
Message-ID: <20250804141755.qzwfgqjdx3s6yc7q@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
 <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
 <095ab6dd-9b0d-4f58-872a-852c5f19818c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <095ab6dd-9b0d-4f58-872a-852c5f19818c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3OSBTYWx0ZWRfXxFFyIlHTQ95y
 6qbXdKOadIO+/n+TC5JoV8BEz/F0+eXyByBB/UJh5VuI3FsURs2foQGGVqZpztUaiPafhNPEZdB
 Pa8vPfa5GCaqszqzzlo2RCuuYTpUD9L0axaOzTgVHCXpdZwOoA+maENvTq3vnNQecvWjOjLgTEn
 PC74w1UfDu6407h20ys94xywpPYmNIOfKcrLbZabg7suLI79Ve74Aq+x5tUoqgzaDaizjJhSoNx
 x3FKVzGKQe/JhrxGly2Y/Do0s19/bX10srtPc3td6BsepTzl3jA0pJyjfcT4OYiaFnOY0yEelEg
 xsE467bdgDJJ4yWG4IuQ7wav6812aGYruN0nvqZjUzuRKgbFpm7BAw0GVVlZi0z7x+UyyuvSkL5
 VmathGn6BxhkBUN6U7YPa8We/0xBAoRGBOmWEOT9p8P7dIcT9u97f3WWaK+3ARYk6LS7b5Ts
X-Proofpoint-GUID: SpxXKyIUNtIOarEAZW2LdiyHxSwzR6pn
X-Authority-Analysis: v=2.4 cv=LP1mQIW9 c=1 sm=1 tr=0 ts=6890c11c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=6krb5mtG3PrLwc7-ycAA:9
 a=CjuIK1q_8ugA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: SpxXKyIUNtIOarEAZW2LdiyHxSwzR6pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040079

On Mon, Aug 04, 2025 at 03:16:35PM +0200, Konrad Dybcio wrote:
> On 8/4/25 2:41 PM, Mukesh Ojha wrote:
> > pas id is not used in qcom_mdt_load_no_init() and it should not
> > be used as it is non-PAS specific function and has no relation
> > to PAS specific mechanism.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > -static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char *fw_name)
> > +static bool qcom_mdt_bins_are_split(const struct firmware *fw)
> 
> This seems unrelated (or at least unmentioned)

Ah, Missed it.
I will keep this as separate change.

-Mukesh
> 
> Konrad

