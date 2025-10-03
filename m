Return-Path: <linux-kernel+bounces-840919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F71EBB5BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDF014E5FD0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D7B25C6FF;
	Fri,  3 Oct 2025 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="adZtzzby"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141641DFCE
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759454235; cv=none; b=LDqCXgXOLT9du6U87JAYtdYEHuSofgXxswXRNAFckAVatm5acLeiK8TUFsXMg4Ju5i7UQrorvo6OyHtTm0GtDm4hbZ00h3HXym6Q/hRhExxhrzrWL547YQ1VjlzgZRymYML5vA0QvYNY4wKCWWIh5d/C573CsI8O252qEPK3KAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759454235; c=relaxed/simple;
	bh=wkhLQL4KhS4ElM81BbFH38DckUlg241GVOJ8Gk+Ooo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvAPTIKvog1m638h+/cug8QlEI9Acu9llq9P1J5GYM6iBAafv57luqtXQWRGqc3gbD3aFqRh4AeMiJ9V4czvoIvOmKAQw7S/v19uRVPuIULIWoIxYpG6Ss0bH3ka3daWBQH7/L9hKgOwRzVbQ7/aAHIOU9ENolZGtFLoA8oQeSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=adZtzzby; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592MVmhk023581
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 01:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NszYJNXUum61Ftvgh9BoHIbg
	Xs/NhaLC23ASv+k9yTY=; b=adZtzzbyNJG4Qibg2lpRct8Xd0WYI9m+fpgiIP8j
	RUWhvSXufHfFkNhTt/Qd4g6Y8vxXkw43zAYs/r0yTk0bpYNl7JdldY73vSVYXhRa
	EnaS+KHtE5qBhBiMhyp0Bk/sto0n/QH/NS3Wk9wXxMzB9YugqdwOAXgkkO3K9qyV
	NeJEycjjHKmqwWbxKdLJcYd3Y/WvhzxU7UK7Yci9U6f/MHThFUhY9d0TPaQTumCt
	GCLTj7XkejVhZjM0N78nBT91y4S7v3S5RTSEjGvKzxckNfErhPQMmzSC8H6xwU3Z
	eYIHRp/S6Z8B6iHyLgdkY09AQrNaM/d5OqeRbg2etQ5xew==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a69f7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 01:17:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d905ce4749so32831691cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 18:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759454228; x=1760059028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NszYJNXUum61Ftvgh9BoHIbgXs/NhaLC23ASv+k9yTY=;
        b=je+hugfq1rskh2J7cIfSBCiWXsALrilgqT1QlfFtRM9Ge16jmPgwMnSoxOgKr+rr3Y
         zlpmvuQ+SH/rnW6UISGMY7eiBgWxJetXtiKqP27JkqbVxRrw3adSMCHG0blsCj213ouK
         Smtc0VnvBDSQcrbedVRuUffm/Ntvl5GSCpgVsC03njY9NUaTBsBZHaY9yAK5TmO2ZnXE
         Z41HI9Ma5B3qknSNEcWQYrnWrAfvhwhGJOZXe0dgKJ6wD0PiEVa+0J+Hk2mjdFuq22JG
         SkByY8qcZhbnlPaf9qVAuNimsDlGnA4NMQuSyfJxb+JT2mtZ5dfpi/s8qM6znuVOrBEk
         g+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ4iGdQQ14idEzkX6WwdEXrHolImFfwtacFYtcUaAm2id/DuBpMIXzSZdSnAIHJw8xxkYOCHhiDN2WYGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeki+twDKdzJwIxL3VjAjwNsxOgDpirSzEKY+ZlgE+MQSqXdOG
	VOqLZ0db82lQXfaobKZOU5VeJMzm20tshkax5t8EZj2HgpL1JEokt3mU7u7fImHIRAZBDkGeLgo
	sWtMTrrAqa+7SQneLh89EG169+P63FSyETXwJxWdhCRDCyNHe/CaeuBRude0tot925gE=
X-Gm-Gg: ASbGncsOG8s6YrnyBcBQKay80p85/oiIFIzNDWGCa9L3iPldVd2EX8VMXjnSGd2pWiZ
	xTRsxvKVP6cC2cj8Yva1/v35MiZRBDbyNPyIyqQ6/Q7A3nysu4l7t1NFaNB+t+TWduyP46idTxG
	LlUoUW/O3CwPmnrAkwzA+pzKk9orpzBFZWGXDAn6q7kTQ+3bhAwu2LgcKRnmJyhQ7YhYZvlPl9f
	4Ps933BSjfH0GdjbRNI717VRAWcV3whsj0xBXz92pi20tD6woXNaiuL89OX1yFy8tCtSX5x1Iqh
	cN0jg4mYSQAMz0+tjdpiwTJPisweyF+oZB7uSGgWjNXxrp2gr+bF5ITmCw2VGj0C0ggwkP9pEee
	b7Zyo523IzmLaUliiVwipOjgifhgTXR4lSk1azy4wU+a/U0NlWTXll7W9Gg==
X-Received: by 2002:a05:622a:394:b0:4ce:dcd9:20ea with SMTP id d75a77b69052e-4e576b13f4fmr21738131cf.57.1759454228036;
        Thu, 02 Oct 2025 18:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7wGlhN9Q1fx9OZHmwE/WJqZbiUdV2GSH/vjmHZyoClwDnnRtTJTDDldA0C+AO+Zy05bZYKw==
X-Received: by 2002:a05:622a:394:b0:4ce:dcd9:20ea with SMTP id d75a77b69052e-4e576b13f4fmr21737781cf.57.1759454227579;
        Thu, 02 Oct 2025 18:17:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f3ddsm1316191e87.52.2025.10.02.18.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 18:17:05 -0700 (PDT)
Date: Fri, 3 Oct 2025 04:17:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH] MAINTAINERS: Update Jessica Zhang's email address
Message-ID: <35jqgias5o4ruhkc72oacepcq4skfzpe4gyivg2pz7bnpy5luj@d5saa7y7rcus>
References: <20251002-quit-qcom-v1-1-0898a63ffddd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002-quit-qcom-v1-1-0898a63ffddd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68df2414 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=snQqrI5GwQTDGbkEZYgA:9
 a=CjuIK1q_8ugA:10 a=2MHBSq50hwYA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: ptArN9eZ3GI-oQKONuS0ZXwX6N30AcbP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfXwyilI6X95Twi
 ZJF9XPNNNPE0xJYKOg+jwsk9P+6t/YGrGQHaGcySmg59tDAC5OwhSsF09G70rCtS75RDT00fhWK
 IzjZrNkBjyvzQ3unkqfOxmxrNS9efYTc2HM5w0A7+FN02RNUEiRDi8vf4uAaPD76e0m9nbT+xKK
 Tspj0mRX9e5B6qAnkLu6EwvsiLbRuBO9uCEP1gHDirMQWGVVl++1mOKKU+SXwZVAuJFgzyisRDy
 Yu0zwD1u0g7Pd/XTe9qRW+iWPvjgwq8okK6AIeQ/2cF+E4a5pl12JuqBrFQySXtI2T9brFdPDP1
 YLLolQxcp4HmRPy0PqWDl30IaZn7/52X7yY79fhw9SW09HkLQocQamwnddWYgdrBYgsutMq0Eca
 DqeV3/Kf4mCpDAXd5tjGLXYcND3daQ==
X-Proofpoint-ORIG-GUID: ptArN9eZ3GI-oQKONuS0ZXwX6N30AcbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_09,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

On Thu, Oct 02, 2025 at 04:57:35PM -0700, Jessica Zhang wrote:
> My current email will stop working soon. Update my email address to
> jesszhan0024@gmail.com
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

