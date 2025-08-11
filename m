Return-Path: <linux-kernel+bounces-762389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E4CB205E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E086918A328C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBDB23C506;
	Mon, 11 Aug 2025 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fzHvd2rR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6C0238D32
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908935; cv=none; b=VFo+4ObKaxnHrTUpWc5S7wJz8qB7fnU3CLais2TPCk/SMtmrJs04pY78xwJF+w2GyMsXwQ4Ory5GkPLT5jLCnkjQDNENxiHOYxAlScnw+yR3SdX1AwBhFv9oEDOluJsYl5YU0H4NOKqMh6cua4Rcsxl3j726kn95CR7Vlui7G58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908935; c=relaxed/simple;
	bh=rFk0obRi8hQtLDiwnMoImh6BTsNZLVJ4wl38YdBMggg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiUwl67Q9tslM05cezhiF7stbedjCE7KGrwwrKhj1Jc05Z8fw9cpAbu7rFD28JLF+IXnOTuSuT2DEH5jllDA3j+4Raqqg+SjwgSuc9fGdTsxjQHJ+eYtfj0u5ZIw4SBOzawtdDPygZx9arDm7uSd2ycIXiN8A2PqWEvlSXLJTNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fzHvd2rR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dKvl018311
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/qUBFM4nwPLNpeQX8mDV+PjW
	qifSyvBHQ3VDet7iAq8=; b=fzHvd2rRBOx/3w/ZRNedtMiKH0Vue6b5+BXkuq6q
	/m2PzNgdcKiI1nZunQRLkjX0sBfSEuXyBssJfuEmRRR1Pluoe7eYanjkfV69Gazi
	XLyw353tcX5YW+wNP2IvMtXAXwzu9VAfUgoDjQOwJWlz3uQzeRjgrFwyhTAiDUy4
	lAYuadNcCVsTEKrl0KvE1cTgMFAF+fZ5avF80rYHoVcTDo2O60bStr4pGV6F7C9Z
	TSMmXBNy6PwNvXsElf1V5ZZWBjcn3Xt8sue+lnYweqJHQko0XFVX1XEjbAj53o+k
	T3/IUXrP60gxOvEAchwPcZKANiYjmVI4WBj5Cgh9fuLBzw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g4126-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:42:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af1a20cbcfso111475581cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908932; x=1755513732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qUBFM4nwPLNpeQX8mDV+PjWqifSyvBHQ3VDet7iAq8=;
        b=YzTappULu8XquR4KQfTorYM5Zeq3/ktRONk2lGbgbxrHQQ3G5BmdMY4I5KrJehJmbn
         5YYf5PqnHNVD8BYmF0Wi9SVriJ9jx7v/fAhd6j7QwQc3vhZg50DYma4+zW3pPatAqV6Z
         xc9SCDkGH2IJm/6rNO1s4FAa6LoFXbOEk7nPIvGxoLV9Y+wh9acrPDMrVoDaDYL8MfDD
         pl/jl89+8ZMSn0/DgqduiaBZTY71kstvYvApnB9FBEkUxbGN0D9NvMfNDgiZdgGj5QRF
         sKLFfHq8CagDwcs817DWC3O5HPv4EQOTqUXQj+bCoIAiDzlI+tOifbJFvPSuH35bN5wK
         J7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAnKHsva6Xg1aYrYc1KEER6TzX4zaA9/aZURce64evhFY7K/HZP+U7g1/CN8SRVmOr0mcsM+uVdNKWvKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/mcmjFCprKeiIaBXJwm7yxjsN7oWDFz4vlDIP1aoD+CzMbibf
	7HHggcw5Sbl84mfSFKBkzQur93UspJd3w+dBTJo9MsH7zftuu5VQ4T4slo1M1c9o1Up1Kbr7KDR
	uqMtFkyd0VFrf7KXEBMIgAVPlsSSpijeWYRPoCCYeZXi9mSPhldn9ySt5zEnHeXDHyFA=
X-Gm-Gg: ASbGncvIwJgDrRgXVKHJoxE5fZwIReUWzIpUVmIpU9T4HDloWwYbrjicQiKSYGzVf4Z
	GY55kKr7FYEOfTaUsI3emP61X1CWyoPFuHth5FjHeyPXAfqyWJqX/WRu/oGnbhbfLERABOqI5Mw
	PM91XpX02t6zQmsefxH7615daxNlm16RX7FdatXytEBb9QzY67bGDBSo3Z6t7iFzdgJvySGFLC+
	sgd0BIvVbojjODOtIjqLibRQ7UeBmRAtgvocFtGb3xle3cwE7Hzbs1laXPyIO0ZyKVWItoMD0NU
	ZCHHveM2GLtX/AejaKMg5JZPDXurBFJnBHHFcD+Q6Ydz4qM6QN2b0zR/7K7E6eJTn0VhGq6non2
	miEyRwokX2tkn/OJBgz/9Ju8VVdze09PrnHvI5BuwmbbCi/gKmPx/
X-Received: by 2002:a05:622a:228b:b0:4b0:863b:f4e5 with SMTP id d75a77b69052e-4b0c97460f4mr73204051cf.33.1754908932150;
        Mon, 11 Aug 2025 03:42:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELrav4533j+uvOnzVBe8xzk6N6rVbp+g4DT4hCXZsWxjgBxbE8yTLhqAz+7n7euXWDM2dFgA==
X-Received: by 2002:a05:622a:228b:b0:4b0:863b:f4e5 with SMTP id d75a77b69052e-4b0c97460f4mr73203741cf.33.1754908931719;
        Mon, 11 Aug 2025 03:42:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332385b11d8sm44123051fa.38.2025.08.11.03.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:42:09 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:42:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ling Xu <quic_lxu5@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_kuiw@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: sm6150: Add ADSP and CDSP fastrpc
 nodes
Message-ID: <wf6kf6u3q6na6abvev75bvg7h5nmn6hqvdljvip2ppmk5hkt5w@u7r52cd4q3b7>
References: <20250729031259.4190916-1-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729031259.4190916-1-quic_lxu5@quicinc.com>
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=6899c905 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=HRKZ4ecyPLDWXoXHFa0A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX5k27Mkd9uzc6
 EC0wmJ1bfiNKKA9kw90SBXXiGa+iAViHz1snFPjknee63kY1mANr2DaKTZWGajLbirVk1Pb28zn
 lr8JbwAxVzT42aRKF1Fom0zAXVCuVKFrQI992m7dMcSAFBs1t6chhZJ026AQqwDONp/BqzSLu+b
 JNAWt1Gf0RRIXeMiQ2gmICB2ZYC/EHQsngGzpQB/JZUIygr7Hn0dlcwxjwQ6l+WJ7kqVlHpLGZ/
 FI0XB+Ghon/xISqeKCPUIKPwr6AU8KNOIsIHLGkTmCNWSCYDyGnjt4IIhcJn1dsW0Bux2qZpYDB
 6NZ8IYgNLvpDLB/fPuvpwQqjx/iHuzRAH8geIYQCadh23IGNhdCgDy+ITgV5Up8hamMmRR0E0h+
 mQ/I9x4H
X-Proofpoint-GUID: CgpsdRInHCFSW6NdBkUsQFwum3tlbipB
X-Proofpoint-ORIG-GUID: CgpsdRInHCFSW6NdBkUsQFwum3tlbipB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On Tue, Jul 29, 2025 at 08:42:59AM +0530, Ling Xu wrote:
> Add ADSP and CDSP fastrpc nodes for SM6150 platform.
> 
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
> V2 -> v3:
>   - Add nsessions.
> patch [v2]: https://lore.kernel.org/linux-arm-msm/20250703055532.2199477-1-quic_lxu5@quicinc.com/
> v1 -> v2:
>   - resend patch.
> Patch [v1]: https://lore.kernel.org/linux-arm-msm/20250523103853.1538813-1-quic_lxu5@quicinc.com/
> ---
>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 87 ++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

