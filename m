Return-Path: <linux-kernel+bounces-762391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13717B205E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1553618A336E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A9C241C89;
	Mon, 11 Aug 2025 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CbqRhEV2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CEA23B613
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908972; cv=none; b=MjXJ8JmT0rKs6rb7nBuds0J8j4VNCQJTwjoLMmHF/mP732hlfUNSBG2cv+Z96oIYCk3imt9CHhXeUomfZfKNAFLhxdwgVRNKABJPckFQxvn4OoWhudos+bEF3HQMKJPLVzKdtYu1NxHFNboW55VA8QLHbhmvrRQtMrLIb5OxZcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908972; c=relaxed/simple;
	bh=mOqDDZoMPgZc/q2InubECuGkg+D4J7jCU/bx+daf1oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqVLUJrYFErKd/G3kQyybMKuUqM3Kq9JcvSnojqOvZz7wAQieMmPX/oS/f6Gg1VAhGnQOmSIFMXpF+B8ZgKVEhzjNshcia4STJWj/34QkFn/v4tgrrIGZPm7pYyWUHwo6Rvv7Pb3dA1NWDcVi23tFRDiOgMvVMfmDyxZqPgzXMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CbqRhEV2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9d9r4019056
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Pb7PNgxyX6af/pkPAfBKFKXl
	YtK2ycRVMe0bVzsJyyw=; b=CbqRhEV2s2G6zCU8ZygCmMY3mtRh20yFerIav3WD
	fn7XdFh7JP40C6JZvVG+w2gR+FF7zDRESbjE0VYchl4Ux+UZCItLU80TY6GjeOyn
	44vHuvmqyamxOcic4b+Odul41hqRMd7pV0Dc5A6S/PD6hp3NY5XcdO8FlNwROWAM
	7c0wE18Bm76cN/iHwSfV7rwesq9o5/mNDxL8b5W/yYmA8sfydE7AmxUWwSWmCgk/
	zgXz5bEDhH5oFjh6UewbgLJPwvOnuzsYwDHlDsq5Y4KXPRYR7NwNZP0XlYmOvW/O
	7yTO5EHbL26pcvvUaJaaOuo9GBeutoUwam135Paq0zN0/A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxduv1ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:42:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b0add6d192so61718621cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908969; x=1755513769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb7PNgxyX6af/pkPAfBKFKXlYtK2ycRVMe0bVzsJyyw=;
        b=xIg9EO6Ktx2wnBu/Dj/fpm7Q4oEK8L9sjtg4fIrs7DYs8ficHeGYdBt05amCX1BykL
         OVUMyS79pmpcWHDW/dJVPAPoytOKvj2yoONmIa2WKMob/zs9jysifQm+D8aP6xmJqrap
         ZsNZQ4QNP/waC9zU1Zwe0J59FYDUWpADS6HDpK+HDG0tyE5nfVGVNdzSKyNapNTy99QY
         aRo1fEajlicyANOHmjrQlncL9Cox+Be0HFrByqrynPFYD8sb8AvsKqblwOwc+SPOlHwR
         7Xc7KwhoDFLY6TxcaDKDlMRTm+8maZ5Rp9+cjplKII/Lt/6RPuaJbAjXITZ/j8CohEbB
         25wg==
X-Forwarded-Encrypted: i=1; AJvYcCUU5qd3oqOg00x2mpgBizhf3iWvgoepZb6FTA8sPcVB3cQdcHzaWzVaApkvXsiSSI6XkcuBzLpAPzX0AI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoZLPZbjV7n3HnRccHIjj1OEp5daisw8HddqG51wUuEhdnWEOM
	EZgj1z11I1DCH0FCLVT90+3zJ+ExAIik37iw2fwDeTXg6jLnVOXhwYGsZLsSCjNpcOwFtEXjxbu
	gwnNqqRidXFF1ajQpo5EjN5bEqNa1tQL0ki8zYtyy5szqKdWmw/6qnzzz1BIO8o462Ws=
X-Gm-Gg: ASbGnct7ddbnK1aM27eO7TSoNmaG9fPVXdXqwYDrTf7eGToajPcEPKiRlIGIp8SqLyV
	Q52sqmfj34rX1iZzooQIV+jJUh18NPux6fjVDHgHWr2lJfLBT98z4mCM245iLELnOA7vEzMcCRT
	yzfSepvfmTWQceXJlS0C55GCzmNzNb8/6BZXfjsI8h64Yp4Z+CaPtUO4+DfdJ831W3XIR2QJvLD
	QQzoXm47BayYgJlS6UjNuwu68TiIscIx+SAK1VsoiaseJpYqZbZogDvtFKp2qLgxH0ALkriWebg
	JUfVHTDRt8iMsJzZz7X0EhiARI5727BkeDsPAZgZ1wcO4BATz7JRvnOaGbbz6x3NLqcClPLEiWs
	ldpMqht/FRTuuDT5vPBfO+Bby5dbSIz4JzKfwUBrNNzGv+mWMHUor
X-Received: by 2002:a05:622a:4c06:b0:4b0:9c0c:f62c with SMTP id d75a77b69052e-4b0aedd616emr175052711cf.31.1754908968593;
        Mon, 11 Aug 2025 03:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+m2ZgpaOJNB+Ce23VikAr12x1UWOFBCp/jDY7SVCnKs0r8fMG1zNm5IJWeaCGYSHLmvDLhQ==
X-Received: by 2002:a05:622a:4c06:b0:4b0:9c0c:f62c with SMTP id d75a77b69052e-4b0aedd616emr175052441cf.31.1754908968150;
        Mon, 11 Aug 2025 03:42:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88db2214sm4161713e87.177.2025.08.11.03.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:42:47 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:42:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ling Xu <quic_lxu5@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_kuiw@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: sc7280: Add nsessions property
 for adsp
Message-ID: <nsdj4ytpdn55mn5l2gr23w4whpbt2ogxbaomimqoarvskz3uzs@5mbrq7jvxnp2>
References: <20250701084905.872519-1-quic_lxu5@quicinc.com>
 <20250701084905.872519-3-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701084905.872519-3-quic_lxu5@quicinc.com>
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=6899c929 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=y0QActD64cBbDUrEtRIA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 6FFtrGdYScT4lUC62basu9c11zXw9qYV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX0FxS78nBQliD
 MobmreNe3WeDr4Wd7iuvZ7FMm8UHRCetdjyMtVNI8+kQipOvtZz7lc17Bsowl4nMOjl7OX+81PG
 aJ4kl/inrr8KIsB3u+4uMN2IYK5peK3xaf47Ql9DJPlO3Pk7keshwlgCxAsgBxsb1IOPLBGDnKs
 BnCshFC6dQFbqpRAI0MVwof6JhtTUuZhOTVJHbo8/k+r0wMgf6mWY3+FcoHFw86rTJ5dlWLVJp3
 RFRhm75ArQxZKa0qdNP//U3KJuxVgfa23BrZr5vNJ+NolGvN1Yfg9DCKX07EmmWUYXaQZn3Heew
 jKvxFWXjCbeyHlfS7JlVW7WSfHvzF9eHlxCjWpGMSFRwgyCLL3J5AQj6UzKJ7vh1Ik4ZzMFnoiN
 i5C3oquv
X-Proofpoint-GUID: 6FFtrGdYScT4lUC62basu9c11zXw9qYV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

On Tue, Jul 01, 2025 at 02:19:05PM +0530, Ling Xu wrote:
> Add nsessions property for adsp context bank to make sessions
> available for ADSP offload.

- Describe the problem, describe _how_ the commit solves it.

> 
> Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index b1def5611764..5a1eacb6685e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3939,6 +3939,7 @@ compute-cb@5 {
>  						compatible = "qcom,fastrpc-compute-cb";
>  						reg = <5>;
>  						iommus = <&apps_smmu 0x1805 0x0>;
> +						qcom,nsessions = <5>;
>  						dma-coherent;
>  					};
>  				};
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

