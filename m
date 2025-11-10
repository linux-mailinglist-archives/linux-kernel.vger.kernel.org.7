Return-Path: <linux-kernel+bounces-893587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121A6C47E84
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59381426F05
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A333A266B67;
	Mon, 10 Nov 2025 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OIehK0CL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QJiZejO+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ADF25A340
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790352; cv=none; b=sNSCQhfHV84vP9/S0sqopdfHGjba/M0LjiE+zMvtO5+zGzN7qA0mjGk5gWu3Gv7QE5ZoSJlrCWoiJoGCiCSA0ZtqwHnDci5TbwDWO0quLWx+KwV82XKwZO2dYlD48y+sFjVyiE4gr8LqM1qMB1FgxkYNPXm4O8EEpRU2lu5XINY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790352; c=relaxed/simple;
	bh=MRx0liLxwwjdaqyTRdesnQ7CY2LbmOfssXBSH9YMeyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWTNRgxsaOKHcga7NHX74M1PKeyiw7gYha6Ni6twv/J4gGMDhcDFUaBdN3NitY8XrIleR2KZJ6R1Q0VZ7Pbc6t/w9ZbBwPZlpLbcmKo0eak9Zgh0M3rjO/oT0oYP45UoC6KKzCKtgKAkPpIpg4HQs+mq64XxWQKsI7F18hVy+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OIehK0CL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QJiZejO+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AABZpkC3271842
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=t44ZoX+OCNSqApq3I3ABJHbi
	eiUu0iSqHG34zLANGOQ=; b=OIehK0CLRG0uaZdEa2h0EyqOKPKYYgur28MTqYFv
	DLIMJaq9w0RsEFJgw3qYbBWRdtkMfm6ta6+sd0KG1kSQnKdXe4iKatb8hz78uFbI
	kqgS7KiYf62njySyApWs1mJlFLI85dUXG7exAnUjkSBPfVcHVXdS4vhhz2fP1F2w
	A2yoGRR1HgX+5UJm6cH+Mw2ZkZI5YnpaFDmKJZFBqd0hFv9CjLIDTdjPwlSaCmQp
	l2hwzM3aFNhsutHpBM1HnBh/xpsIL2+YEH2XmodANjOuNQVqgeMsUB9/9ZdgxY78
	xz9ZOEkhn3H5V2XjmgEhse9LBo4EnixiNLQUY1gKaXVebA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abfafrr64-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:59:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4edaf614c7aso35496701cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762790350; x=1763395150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t44ZoX+OCNSqApq3I3ABJHbieiUu0iSqHG34zLANGOQ=;
        b=QJiZejO+5B9kY/5X2RMI1fDhH14jalupka0PeayZAI6vO6WQWeSbhH53pfD36otqKk
         AW6eBc3hSxnrqqnVewVIKU5lVV7d7XR+43oIUiHo2H/U9pW9oU4t3JlSvG1bNdIc6UsF
         guLpEY872+42FhNu4lYBl4s8J8gRDySZDbv9OWfeLhRidqkNPoyECtYGk+6VLY0t8RCA
         u/IC+dCgsdI78jI45OkpsURugT6H/znmjBztrfGqBQF4k5jUcX8f+MNQlliI1MnJYKF+
         04FIH5wMsVwdxIyGm+WV2ETN4OQ81ORkqROobyQT5qYJlD7eTinD21EsEX6/QtxY8Wv+
         mcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790350; x=1763395150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t44ZoX+OCNSqApq3I3ABJHbieiUu0iSqHG34zLANGOQ=;
        b=R0HoJfekGC7gtHo9WNN37xK/Yms/uPh+alJemDMxZKSDJl6wopdNZI87eLFpHH4jTR
         4EQ0IooBO8OHcjmdEoDC/Tufii4ljpPbttzkGoq/0tAyywEHNNrOwimDwHHp+oWD5XN9
         QwCem6XwlQaLklL41oc5TNN7+7nUdvr0ltryMRylkKc1rWriCdVpBFxBSY1xQSwDbfnD
         F00+jjchEoh2Ror1vguEB6UHraU+6kZuzQItNOTyDu3Xn9ksy8LbgqrgwWgdExU+CU2R
         LjrjNk1iLoB5+Lc7W5H5knffG7QDp2H5dE1jdlx/GqbiHbWMobt3XW1mJIsyzAq3Oewo
         J+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxkBCuxsm/1pxFSZnVRSv4znPo/7qHveVKBUjPXFBC30gE86hcAx/oAD9F+5N5oPIVryQCiH3wI0DYZ28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7lMqHIRP9JmzLLd9l/q37yGLMBHQmI8r+I9vtn0TRph88exFk
	k6obiwm2SznUu+PiBv07+/tJnQ3wyJsAdU5s9q/8kthfWBQYJ6bdwHc2lQIhCGqlu4gyT9b0As4
	Eh+7oyd6aYzOYeYIKVt0ZCiHaL1ZPRT3lTGAdhTNHpFR30huIYhXvuJ0UjGIsvYmYVE0=
X-Gm-Gg: ASbGncunQJtyGTvw5yUZhvoYMejB0jLWkk7kS2bcvhyXKoMhQh0xMwPu++WQMnP8Afz
	iPOY7i0NoUhnvg/StS4Z6HBZHXkLRYUieOmWELUnLXwbtezDq67PJPp+15/e3kRbYZ2UWIrAxOE
	y83EOhePJFNsgM7C5kk7UlldL8ePfCCKIhiKmgChQMrK26MWDB8LaiXS41l3BBRCuqHNbtqZgH0
	CGoh4yw8ZpnWVvhCMlB+6zm3X5Yk8ge5gpM2kH+5gaaru5a+IF9Jl0M0eF20LTMh4XEjm9UUUSf
	z8avEeQF/fzQuUoqPWCR8OuzQ6KjbmbqBpftpmoeVLlGfh6jUxNcQgo3mFA9HSGoLN+egWlMVxn
	XzZNtvu/bYbkPN7nTD1ar8GCOx/4SoA5B/dNF3ryNckryZn4A3sktUGsQ7Urduq7F9G7s4Bzuz1
	AI6+JhSXj6vYXh
X-Received: by 2002:ac8:7fd3:0:b0:4ed:635c:17dd with SMTP id d75a77b69052e-4eda4e9fae0mr109401501cf.21.1762790349674;
        Mon, 10 Nov 2025 07:59:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyG1JLLeUFIOUuxfZXg9+JKwbDXX/NfxH3k4+DgtgJPW110VLxhoWxeZqyBAiRTf2OAuPWlw==
X-Received: by 2002:ac8:7fd3:0:b0:4ed:635c:17dd with SMTP id d75a77b69052e-4eda4e9fae0mr109401161cf.21.1762790349240;
        Mon, 10 Nov 2025 07:59:09 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a5930edsm4080456e87.94.2025.11.10.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:59:07 -0800 (PST)
Date: Mon, 10 Nov 2025 17:59:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Dylan Van Assche <me@dylanvanassche.be>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sdm845-shift-axolotl: Add ath10k
 calibration variant
Message-ID: <wbe6z6z4q6xnbw4otq3vy62iepgsb6rf42sldkrsap3n547abk@ako6cd4tzryu>
References: <20251110-sdm845-calibration-variants-v1-0-2c536ada77c2@ixit.cz>
 <20251110-sdm845-calibration-variants-v1-3-2c536ada77c2@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-sdm845-calibration-variants-v1-3-2c536ada77c2@ixit.cz>
X-Proofpoint-ORIG-GUID: 3YhwktP36Q4GpIIWFGWFerJAEgBmF0nW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEzNSBTYWx0ZWRfX8V28/zFgb1qs
 J/JXpL8AcpXOioIoNKA0vhXb9KTeOsEH5WyNb+8vqgINlaMVNbGAesehNpKTqI4I6Ery3Uimb4a
 v0tuuaIASyRdT699NYxoQisEZwTcZue3zDswiLMOIAhc4CLK3imji1UTM7o/vF8VCYzk4qjJhh5
 IdbEgz0S6LrMXlHdGZTc5lDEjYzILOYPMgjYJT3ysjVfU5whisay4kUZkCDP8unEO9nL86btDmD
 QvsMDEqG7LeGIOxIeCC7a5lfH9w7AolujjfUNLMLdrT1snp+duDY/UswcqvcYdGGzsxDMLPQsXi
 AVmC3EAsc4DaZD/bdeC5SlmTU1vYv1PcXq1cxvJRLv978iSGNgbmzoEB5S1lv4zXc10KD03gTeA
 Fu1jV/CKUB0mkCPV0evOxp32q8NeAw==
X-Authority-Analysis: v=2.4 cv=UZJciaSN c=1 sm=1 tr=0 ts=69120bce cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VnAOb1fkWFh9DQKIKVgA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 3YhwktP36Q4GpIIWFGWFerJAEgBmF0nW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100135

On Mon, Nov 10, 2025 at 04:37:48PM +0100, David Heidelberg via B4 Relay wrote:
> From: Dylan Van Assche <me@dylanvanassche.be>
> 
> SDM845-based SHIFTPHONES SHIFT6mq has its own calibration files
> for the WCN3990 WiFi/Bluetooth radio with the ath10k driver.
> Add the calibration variant name to the DTS to reflect this to
> allow using the calibration files from linux-firmware.
> 
> [David] Adjust the compatible as ath10k-calibration-variant is deprecated
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

