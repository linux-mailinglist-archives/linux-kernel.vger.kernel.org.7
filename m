Return-Path: <linux-kernel+bounces-747790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D599CB1385B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975653BD3DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320B321FF4C;
	Mon, 28 Jul 2025 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FY7JmOAK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F618871F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696056; cv=none; b=f4Kup1vIVMB7mFebGNjFfe4rUuQP1wmJDaK/STgbU5onqdG5zILbJvEJzl9b9X6+RGo36HHx3Wsw+z10YXbim5PvmBrnOWO9wp2Orb+XEq0S8yVYEd5msrzN9MfyMjgji2MPR2d/YAij3SAqzjqcAcJSLcbFRoCLuRJ7T1K/mxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696056; c=relaxed/simple;
	bh=V5v51/y/EDwGpe5nPnEeveCat4hEczx7n5xKlzu2KBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/nEsYyhvRwYNhsmQI5pcbqubW9nsUiui9xXQFEl6WfJflMS6lpyIklh5Dt8RrmpPrjHxu8emqYgHW8+cpLFPVZliwa8OUFr5WUtFNRTHeGzhVZTkIuJFWatN5csb9pTcaaUlaJ9K5xLz3YR6OV8xBxbmXHGneEM4yk/BSmmOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FY7JmOAK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4rZLH023360
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=b9Lab31gEFp/hDP2GVsnvv+B
	yECgPDDTBcTF566eV/0=; b=FY7JmOAK8K89eLGi/UkgJAJ0dqy8rM35QIEd7sDL
	tyJ0KWGVmtBi2QyffYEmDu7egvhYhTM1YHGUzxNbSaxclh0FH9/StjIB/6zwpn7z
	KfH+RhU8ZBmUccKkVRr7jlo5Z3xPKE64aU3OsGbtHsQ/fmLjbNcU42qjX3Z+sp6p
	K5ggEY5E80WyNceoxcMeCQTKu/MVamoh2u1YcLodlcpJGHgG0Y/Eaae4oglsfzZX
	OAvUS/2PoYz5GDu7KDOTg9fjpNe0IskQ1D6lGkHmOJdm7kZCvD/C2WILdcN21KXb
	fHRUq6kZSJSM8G+XRMDmpHcWYAHS0+09/sqHcKGIlVoUKA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 485v1x9eg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:47:34 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb01bb5d9aso66102976d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753696053; x=1754300853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9Lab31gEFp/hDP2GVsnvv+ByECgPDDTBcTF566eV/0=;
        b=Sec85HCqf7F6XZP753m1z2eplhQuc4m/fId7C0IujNmEuNYUQ5eL7e3Fjn8Oio5Nmz
         1iSf4CFND6GMhp2K5NxRZ6VTk0ZIgBUgfiHHLxvjbd8nsPJR+eUAHESYL6I9L/HswYzY
         YEohWl/vpbd9edP9DNCE+gHmBLVvb8qUZIFytW+rBpkWJb+5z8kq2WL8SJyGIiUm8FQ5
         BvV/xoDgW51gGKUqPHunBhbrmSWJ7szDGsl8R609oVo0Ve3cWnFaDmUN5yKpZQK2KvzV
         OtRLN6V9ADa12YHT1O94f/37x4y3843OKDiljIiUIanLKxgYfwYraZGw2QL2xF5f0uH5
         r6qw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Zl/dZT/uXkouKsKfJlsSxdXTjYn4fpb9G//7xWVVXdpuaID4Eyya/zm437LkLeId0GUQugcKNkhT2og=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwaJTa6KP//KYBZNle/cWYnf2hm4NmD75QU9chZhdiQU7w3oc8
	BqaqyfJDJrD/D1Y5tzg78y23ancPmfA8FFU99qXnoo8Ci5UAodraLYAoTMuB059peDzEBG0TT0d
	DfrJ7El+f109j+k53iVs/iiZn7hMraurL4gcqEx/uuzz/qNtM4CuSZgVRTK5V7zz/lk0=
X-Gm-Gg: ASbGnct964eyusWa1QKNOEGoz9Sg8rW+tOI921CkWA2W945fbinNrraCOxnO0iljkNz
	vYHNDhJLvZ36E30nRqkTkMi0bdUTFuXg0b3ipHQBxbcYPtpKpFnt69atYim4w5eXciiNksDTUJy
	45bIZtgdgVfOzRtBJCVpEDga3XrvCMDajGzXuXnz02pp9OaWfIx+MAmbkf/QYod4qOcFGsDKnyB
	BLEZbFuqHKuqQ7yPKuMkDoXtjf1ivKCh5OmdoA+Aupv2z3nHFGPKE1XeWiDlolSZP02mEGE3i7j
	WQKzKTesGkb9cFBwhdOtizL8Uv8PYdUYssqT5JDLSEoDol/w7RNdy/1Xx+MX+5Olgc6v6QZ+J0S
	RuH+TUCdBgPZkTMpsPIeMRYTqn8icckvhY4mKcpIhZLZ7BKX6xPAq
X-Received: by 2002:a05:6214:29e7:b0:707:1ab5:3787 with SMTP id 6a1803df08f44-707205a898dmr117877876d6.30.1753696053026;
        Mon, 28 Jul 2025 02:47:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG86xL83cEvXn5rUOfw1+S9RzGG5TSNJ9B4gIrX/EQyKkUkuVDASfMailmNVSy39NbPS3hl1g==
X-Received: by 2002:a05:6214:29e7:b0:707:1ab5:3787 with SMTP id 6a1803df08f44-707205a898dmr117877706d6.30.1753696052457;
        Mon, 28 Jul 2025 02:47:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f4297067sm11596761fa.88.2025.07.28.02.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:47:31 -0700 (PDT)
Date: Mon, 28 Jul 2025 12:47:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7280: Flatten usb controller nodes
Message-ID: <eqj52yo6ke6pfwgbldztmxhm33ut5qs35z6fs77uyvyknngrod@2qs5e6san5tm>
References: <20250728035812.2762957-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728035812.2762957-1-krishna.kurapati@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA2OSBTYWx0ZWRfXzXVxEm2/S/vj
 kuX+YPtz4Z+c0rySJYK1btHh1ZSgyMsQIXRwYuqb4iEhpdB5p9TObCJWM7n6KVLh44w7tbx39+L
 0LErUgq6aEtwkpDaYDWsAQXE3fkIqlacU/rt1qoL8Zjkzr9SGiIyBPGKpmuDPJMvo3/ZtgYFQ0E
 Bj+2GsXQWa1ATbzyL1Nr76L77+g8GpO8CqXr/LK3PkMM/Ra/bq8TvVCroGYutkVn2dkF/RhAtCQ
 4DnFe6TMXLs3ttgunNPuYVoG8txkirj8nd337pIpUR3oJHZu3Ek6j+FN7rCGpeOj0UCHk8Ul3kz
 zAnt9h5qwMcLCntL5ikAbxA3c93T2GLN3+gc+xKHFpyop7cJB25z8lqIjt/yFBS8saY4vqfKA7j
 KtPv4gR/wQDfvLqg7+TM2fpOhtHHWsR8wuofGxsfG2/PgRD2qQllL1Do3icB3r3kjJxG9X3t
X-Authority-Analysis: v=2.4 cv=JKw7s9Kb c=1 sm=1 tr=0 ts=68874736 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OKk1g8ew7IGzsuuaGm4A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: Av8uflxaQZyfpdPOiGPe68zmbWeGSKoe
X-Proofpoint-GUID: Av8uflxaQZyfpdPOiGPe68zmbWeGSKoe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=438 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280069

On Mon, Jul 28, 2025 at 09:28:12AM +0530, Krishna Kurapati wrote:
> Flatten usb controller nodes and update to using latest bindings
> and flattened driver approach.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
> This patch has only been compile tested.
> 
> Changes in v3:
> Fixed dt labels as pointed by Dmitry.
> Fixed DTBS warning pointed by Rob's bot in v2.
> Flattened second controller as well.
> 
> Link to v2:
> https://lore.kernel.org/all/20250725050216.526327-1-krishna.kurapati@oss.qualcomm.com/
> 
> Changes in v2:
> Fixed reg base address
> 
> Link to RFC:
> https://lore.kernel.org/all/20250720072125.1514823-1-krishna.kurapati@oss.qualcomm.com/
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

