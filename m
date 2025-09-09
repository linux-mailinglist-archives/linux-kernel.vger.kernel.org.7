Return-Path: <linux-kernel+bounces-809164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED967B50974
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47DE6546872
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9D2296BA9;
	Tue,  9 Sep 2025 23:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B07KJqz7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697CE2737F0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 23:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462294; cv=none; b=G8zdHk7OUePb/H8bvKK/rjIYID5sR3uazW5cA41m5zeSwl5Gzd4CNNWVQDDcTkU3mcMnYKXcUo5yipI6cGK3cyxoWevPDw06QmLKA1vKQt0f+bPc6eHQQXdNJ7gddt+Ohz325UATzrkeN1vWsm3zifaYvmST/sBUnnk3wI5HI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462294; c=relaxed/simple;
	bh=fe7Tr8F9drQOnFSUuKLuzNZswkmtaijTbbG1u6UrfTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5AwgxFbUfxUktHb8Ey9wmPnBQGfPKfXborplvOEVsk++nDyBhIln3CyvQ8pixEuFrUeG3vJzmMbuSowjgl+jLClDZ59y9GvJjXU2QmaZNENws+L8NwGKw9viAJnaboMxvjub4PXuEDKMdxSG9ZaE8EzzO2SaJzi8dgdg1jLVcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B07KJqz7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589HbN8G011070
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 23:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BTLfkdmSnXwPfhf6JaLsw/cB
	ZJCDHQaerobrECuqh7I=; b=B07KJqz772Ekiebqkp4BJPj+PnmNyQFPYeAE8AvK
	BqZsy/mET0tSovK8PcmO647bz077pjf4fRRFvkMaSgXNgST+DFXP4oVqJ5K7SzxC
	efzj7zDnZjCpKpTJZbk4JGO0NrXcLRs5SFuyaItdLHRnurBpPaNEgujJUNkYVEl6
	gbDugvBCbl/sHlaV8Cj1E482PV40HKTVXbiOK3ppk+s7JBrJhyXr9LQHsQ/+J2Zo
	7BK3NxOhxK+Uo68GwEDQDAOeqaCapWT8GcpxOPNyleP1k3wkwnW9jCkQiR3ZJQGm
	Zlm73u8Da6x+F7nSzMZ0n/5/SgsPk4kBQkr/ndaQYyV34A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0syvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 23:58:11 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-728f554de59so186129036d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 16:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757462290; x=1758067090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTLfkdmSnXwPfhf6JaLsw/cBZJCDHQaerobrECuqh7I=;
        b=Nf3a4STFIr9FIha6+HMDi1BM+Ut+Iw0jdrGMVDJrxAtxgxC4MRxEaSRZIs58Gyx5rI
         CwxQ2dnMyr2YpnWf4h4kkvMyUdFAeO6tv/X/dbVt1ML6CuuPIYyTYxpubkVZGR5SSw3d
         jkSXw4u0y/8qgycW4Ndo1mqTFbhoXM7y0YNbRaCyfqZRUVo3T+3wZGpfrAwIns5TE+fi
         mKlh328zeszZwVqGGFIfzlsBnnzRHK47nKyPLInr1cuEBUmkwOqjBxwK3s4pcgu+1J+/
         HVacvIYQFM8DXbEnoWEINvOyNBjgraEDmYckeAadyiJfgiAerjTtTVbOEEdwS8cfuFN9
         k6fg==
X-Forwarded-Encrypted: i=1; AJvYcCXLY5T6wv1MszL3WmdjbcTpwvFu4LRxOUahOFWBzyAMyhifZpo+9Uf2PLigimcXtPaSzdCNTWipzWTBZBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG04qucZkb2x0HzXrtZhq11tGyjz9gKNuoWQzbNTZ9G0ZWCc9h
	QJjjzbztFACUlFf/DohMCp6gosQziwIGqItrjnOF6MpYTrMcn/83r2pyHDyeI+7lhGgCCqLpze0
	+4z/Nch5WNBDkYBc+mgvp7Jd1DQiJME9U/OsL33VqJmuIqUcxSMvTzO7nxk7nRCmhjlI=
X-Gm-Gg: ASbGncuV58nJ8LhFXnxQllFzoMdJNDypAbgBUzxJ/oJZE1luscTWc8wYvonPoYzduo2
	yMw2DOPO9R86iFV7IdX4Wbt0G+AmaKslIKVRV3z60g9Tx+CzIfP3ID9GVuTDk4+mUOdkW4F3Jn8
	IoCoJ2el9Pn9q2Kk2jWyuXNPBCIaKDZW0gIkRDUaRhW3TvL9bDLzxyJNbn4H0zQFc1wWbzVIDvq
	/5XHvt+U/q9w9Dj8ar2sEu7iHHCN5YRmlGMxqWIe4jwACpDwJK4lZccs4oS01KRGNuo+qc60z/N
	RsFab/KJjbmhfYtluDrEqPvmiOP5T6O2pnLOZJyCzNaMlmoru1urxj6aAszO3LIvENhS7pG/SlZ
	iLxVlXsvfFpMpzKf4gvIgD/ntran3QYeLw8naI0xtw0ChD0tR7SGl
X-Received: by 2002:a05:6214:300b:b0:72a:4781:68bc with SMTP id 6a1803df08f44-7393f986de9mr142154166d6.51.1757462290516;
        Tue, 09 Sep 2025 16:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiKNC2l10D22DB5gczvPewShZ2x/WB8v5Th1kURt3OI/11b/Mje9eWmxCIFjoP8p2aZpkQeQ==
X-Received: by 2002:a05:6214:300b:b0:72a:4781:68bc with SMTP id 6a1803df08f44-7393f986de9mr142153946d6.51.1757462289908;
        Tue, 09 Sep 2025 16:58:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50bfda3sm42505471fa.62.2025.09.09.16.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 16:58:07 -0700 (PDT)
Date: Wed, 10 Sep 2025 02:58:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: monaco-evk: Enable Adreno 623 GPU
Message-ID: <uk3dkufxok7sgjizgvppcd6oh23fae6sglilqzhytl7pf4rkbw@5qf6yn2wivrm>
References: <20250909-monaco-evk-gpu-v1-1-e14938780411@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-monaco-evk-gpu-v1-1-e14938780411@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: rRILwUTIKaAz5HF2LDjv-2FQCz5_DVs-
X-Proofpoint-GUID: rRILwUTIKaAz5HF2LDjv-2FQCz5_DVs-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX0cudJ1K3eRpT
 L3QLTxQEul/UMGo+Hm4bp0ABBNH9vcRbTvV2kPuzoqc4FNQNN7jKU/eBVWOT8OR8BZzwBD9rL+u
 r3R35Qi1DBrjg/mJEUzhfVXtsCJEmzZjDeZq/+vdQixS4eNyTuQkVzlCfNpolcyZBeg4jUybnPY
 o4g2oiL1p67987Nhi+/z+r0sn7Su7/QQ8MyFz2I+IxCZI046zpT8cJH0vgC6ReCQvI2GPBXJfqE
 Qy2Evj+xsz1V9k2B++x/BXmh+aGy/pZ/agPVRU152ETVSMBN2YlhmxhQo/syUlLzD/G9sax+8cz
 aEylvDjGKDQoFaj9nOcYMfEr7p2OP47PXl3j+ujYVj4mlnLEYP5cPtiyb9fP/bRm2B5ND7txsWr
 LRnuv83E
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c0bf13 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=aDqWJWFMxCdyT5shlmgA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On Tue, Sep 09, 2025 at 09:16:59PM +0530, Akhil P Oommen wrote:
> Enable GPU for monaco-evk platform and provide path for zap
> shader.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco-evk.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

