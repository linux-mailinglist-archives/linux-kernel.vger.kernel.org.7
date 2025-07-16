Return-Path: <linux-kernel+bounces-733870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F33EB07A06
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1054D3AAFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8712F4303;
	Wed, 16 Jul 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G/Wx82xZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939642641F9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680184; cv=none; b=AsA1i1otcRlmoeNV/N637N/rBLvhoXwXNtTlJqtdySbbv3vpwOti4pDZ50aXOUSGJrjjAQeTePQuw45mCtCGK/V0QSkdV30pRQoQOHUSOdY93klB+QaabBo8jX4jhFRrfelZhZgKwRKK/GDJK8iuhpnNUixD14Jx9E6h5w9R9lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680184; c=relaxed/simple;
	bh=t7DSi05slPCkN4UsojGxy4oP5CIR3/pwbBY7inCPQo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evw0M4hQkiH2V0940ZHtW9U7cF+xX+hr7erReDFjHu5Aiu1VJMZ3shjLI4jqRb3Dfjs0uBZhjI4ms4+pLm1CdcE1yxbS0nbJ1j/wmLK+hLOSL/DLf9grQ473lzadOOBwXlIoOPDrnI7MQQze/KRfq8R9JChG+zQ985zkA2ht3KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G/Wx82xZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCs3WB025762
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Q7Y+AqcTKt1Ceta1AaX3XL0N
	rlaKK9iAw6+wkY7W8rE=; b=G/Wx82xZSe2Wc0oWbzWkzHTDG35xXiA2MkyjjaVH
	sqVYAileg22MC05qJnFNUV+8vjzDAtcjKYzTA5bI87UXmzNmt1hzYgc2x5Qgzah8
	vsbMNiFZXXohjuSFLiyC81WKdYYBnaYVn6bPkzKlPonuYiBArFFM85OhMCKS7Crn
	oRIMR0kz7XTJn4xr9S2UDAcVzebIPWlbVtNpd032NpzHuht1fCeFYPZp8vgMmLDK
	9fXDGNBTaFAH84h5EmC4uqSDyT+elVrP1izxx4pqylM0IGvnt9jIyBqtO3594eq/
	+3UC13+ffAndvuiU4vhXedqJGB0ju7FJsxLVthcJKUZsNg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy4ckh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:36:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7da0850c9e5so1112361285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680181; x=1753284981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7Y+AqcTKt1Ceta1AaX3XL0NrlaKK9iAw6+wkY7W8rE=;
        b=RX3DjG7aWP7oqkmkPLh7po1STIkzSBG6R3c1b6NR66Q9/137bILafPPPXebtPKxqtS
         HJqzzfe+a8vuZyltQT+1qnjqkxDBxlpRcQxv67pWQFercZFHfDbVNFp1v67JoUlnlkJ3
         rRBUemyx5RZv2O9avLvCK3iWxwZmaUVWL3ehLG45/exBOy8KNkctrEN60tRWF6lM5lee
         iawpU9oJrJkziqeJmMsTXngOP2hytXdN0YpjnK2YMjVGkA9VXPiIivWhFUvQ7wm40TCA
         lFVsuTarq6StKkQ4F3SIKq/hYv0/9UEdt08jmnjP4d2F4htxGz+S2QuVAlLfIpWpHzjl
         SpgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8hALIfLcWPllmB4TARFXlu3moKQ5iaXCfxsQ+3AA+PSkRbvY+us164qSYxb2/0UVzuznW4PpAjANYVf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbl1CMMvb8d/tQwjbJ2R1x26p31s/S6plFDhRAlOzfEZDBcmr4
	cecwTmoTAOLztJO5cB+y8heNfTx+xIhJoxyALio3edLs/DJpOxaBbYb4StjCuaOKx+xpz9dTc2j
	MrjzMzq1TQ2geA8PwZEH7eU83O8Is3tZ0MTqHjv4TcSzNSZaDKFyImqmxYgFxvqYfkFo=
X-Gm-Gg: ASbGncta2+KcopDu+fpXYWob11VQ+eGt6hZaGJ0n6SLIS53bb1dUDirVBBV+Xrj9idQ
	g/KXg96s8pnT8CCY1aQr6pFNRQojY8tqIWPhdnpSH7YPx9gWV9YEfGilm0l1Gav8EzjwpO2cpGp
	yVVCQa99+WI8ss0B5nN2R8T6y0HOgOxxA3VeTDqYLdG+mD6DNRIg4CrAnLnCBnmzIkC8mv+5C4s
	XpPHJLtaFXUUu/3DU3DS59OCOyDqZSOXV9SSN3hjZkFPDMI0R3dnKHSW3sjMVYExJo4r9kpQ4Q2
	rq5+Fc/SA+jyn6sicvLyc1ceV/AnGUhJDN3rQo9un13rxouAsE+4iV9UBJ42lxd0EH8owfHCuOa
	y1tgGXs0PzmQlU+ugV63LfkwA2r0cW2Kt7oIe9S8dMjLjWaTpWow3
X-Received: by 2002:a05:620a:4546:b0:7d7:2647:da9d with SMTP id af79cd13be357-7e342b5d5d3mr506342285a.42.1752680181190;
        Wed, 16 Jul 2025 08:36:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhZ0QjrGWwHaDPGp/F9PqlexGFcR5X+X3OWVCipgtBtA0DpbAzcIF8dPzibaOM7PevWMFHeQ==
X-Received: by 2002:a05:620a:4546:b0:7d7:2647:da9d with SMTP id af79cd13be357-7e342b5d5d3mr506335885a.42.1752680180581;
        Wed, 16 Jul 2025 08:36:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbb5dsm2690071e87.18.2025.07.16.08.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:36:19 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:36:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: sboyd@kernel.org, mturquette@baylibre.com, andersson@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        quic_rjendra@quicinc.com, taniya.das@oss.qualcomm.com,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] clk: qcom: clk-alpha-pll: Add support for Taycan
 EKO_T PLL
Message-ID: <3exm3tytxfyc2f3vwah5gkxftibf2xrbzowe56gbgtk5j7as4j@ocnobxe7dspl>
References: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
 <20250716152017.4070029-6-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716152017.4070029-6-pankaj.patil@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOSBTYWx0ZWRfXyRCXVXk0TIwh
 ooIIl58t+ivR7IqsfXJDce9EeK5T/19oLNeviWSckWrqgjayfZUSSTJJ/A9T1NBRQrazYkqvvdG
 MAf9GAjMrhyAYLnFWHcFD+M5sqKAETikZhNQOn2RRwhUvSir4qcNVLkkBpHQRofspDEaR+Rfr0M
 WpMuNN3p4Qv5IV35alk39qMI8g6YmhdWkm+QWXZaCP+565siPgt1jo9kseyFIqT0sZZY5P1/7DO
 NA/gWLjvsH2WYUZWmI5/34jtz4ey2AUHzc3iyOs9efGveJz+qU7sjCb8PlITHecKfUXbq/Vx3fQ
 2JAMXqmsVTOOKMLPNCqANAqpcEClghfWdPHpD5mFYGiZmkAyPQfF7M0QnCMp8/4Bqks3VNzpj0r
 z4PxtEXegSVrhuvp9l7onf4Xi97IFJROItktXJryzYEhXHK180eMy3Cn3WlIay4MTN2WC7oL
X-Proofpoint-GUID: ALUekpgmQ5ltc2t2GzaxoFtWyCCHVEvR
X-Proofpoint-ORIG-GUID: ALUekpgmQ5ltc2t2GzaxoFtWyCCHVEvR
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=6877c6f6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=zIiPdt3-swY5NxfCfPQA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=951 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160139

On Wed, Jul 16, 2025 at 08:50:15PM +0530, Pankaj Patil wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> Add clock operations and register offsets to enable control of the Taycan
> EKO_T PLL, allowing for proper configuration and management of the PLL.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-alpha-pll.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

