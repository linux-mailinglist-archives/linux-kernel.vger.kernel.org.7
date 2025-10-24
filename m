Return-Path: <linux-kernel+bounces-868137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A8AC04733
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41A63AE4F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E99E219A8A;
	Fri, 24 Oct 2025 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hV/iQ0Ve"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1F2242D6C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286245; cv=none; b=dXUswZR6HtUof6AybxmFboxnKQqljbKTK3ALasiNRKp6gSbTF/UupWo/sZuCKmgoQb94B7jXgTNwQP0s/DzE34iQ/E01YD5P5gSMX2Z7nfnK6DuFMAO8wSEij53EI1adGWPHMviLMW1XX+EVyD5tvqQB5MNJoCJ6kBxxX4JAJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286245; c=relaxed/simple;
	bh=Uflu6VZJJ5Inn7mIJ0KBnxD7bYqrB+u8/dlCHjMtfto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HI3C09WAzoBSF2pSabA2dpdxLwnYByDXqAp7q/urchxm3BZqpcmbpZAru/WZM8W8r52TKYoLdyydqrbhaG2r895mTK/Oitj++/RaeEHxl3y5xY95sI9N1LZPkYXhY+XnBH9fAWbKwE4vICnJbFth2nE3l0oCXWXr3uhinQRjbSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hV/iQ0Ve; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FQ0a001156
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iPDyisl44Ds/H4LrsIWE8heq
	Yin0PT0m3dP+JNRSHeI=; b=hV/iQ0VeW4QjxbWm9Z8aa1teHm+fAYtwOBru/D+u
	pN+54kTGbayJ6FViPbZT1uY9Yg33/T5rzquz//sIlwCumVOqXeE/MLjjCBPzwkEE
	eXRezn091PeuNcxYpdQRZaVxzP8wNTo3hWQSJ+U4VHHqJIPxhX0QGQSrf1tRfHCy
	3Pf+9PTcT5v1GPFtQRD7K3gR2uKIxv7crkRiDRzVdVVK3JhbWaRfMVv6WLSuOESV
	D8kZckRAB9VIvxbhuTecApkFcDFv3pkZwZzrfFGoA4qWIpexxWBl6m5f2oYemGJ4
	oWqZcu5Lh/In0a2ifFQfkQIr/r632CmX7xjMJb0Jxc2IhQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ym9j2ksh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:10:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8adba545aso56262431cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761286242; x=1761891042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPDyisl44Ds/H4LrsIWE8heqYin0PT0m3dP+JNRSHeI=;
        b=vUL/wbRj47Exfmo3mdvKbbnVh6Dl60XCSKdYz/LurybO3g0YB/kHCkfNeUEwUjY/7+
         jU8pq0BvaV4O7zkoQtlnQSUB9ryRGlURFCeC2f2g4n4ub5NWf7Oem6aW+JBMFInA/baK
         CNhRYKndm4/N353AHaGeCh0lApxXpySJartF5Gn7+dF+zFvK6ZBtE+6RIjsY4JNmqsks
         603mMknKWz3JvH7NOnzLbYVHorIgdL1uHyGCHPg2eZNYdwyYQ2ROGFZlGPtc/FY+vdUG
         q1ejlPymg1PQsT5Zd+TwAVfblkv3sHIxDXQhkOZH/o8NlFgFp+DNmuzZOxmNB1+JWoEO
         jM+g==
X-Forwarded-Encrypted: i=1; AJvYcCWRuuxlrxKMxBYYSSV7XVjEMuuyipECuN1+3/ynl7F1HJ9+TpxECZkG3bPhOziAhKgIPm2emU6vyw9Ue8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxKcxTJH7nh4rWoTi3lye5FacbmNIWQwGTnW417c2aD4Flm8lU
	CW424zlOyfPz4hAQpXhcdsPxdtxke0IaFJGYtiVwK2A7EST9TvLYVY5iegyuu5TBPwqubj2i+oM
	cD1zSxUWdkAVT7PUEYaJmknsSDJZ7+ECOutC6FGlgGqYix9dXahYoeRuNBHdYe3L1EBY=
X-Gm-Gg: ASbGncteBf/ezchP3mee1Uv+rOWilt4OUidxuA7gsRjbmJ092xl5fErAgqncXAsUDZh
	4EKYo6mWzwcYR6BdmKbtgBM31GNcIenf64qmAj0IoZebeZpxDYHbT5BFIbnETOyxC2Jx6Kq3tCB
	V56pNN1z6UgvIfRNUAHsiLekwDGAz4Q3vKS/Zw++2/HqZ8fcIplfyeeLIVBQ2zsO3YvLKp+ykhy
	zvpnnR0BuMhxTmG/m5PzH3h/y1gfGQ/7FcxIoPl+amY1JJNn8v6fvgBgPRy9donfgDwM2F0VO+f
	cVKBpBswJJxMjJPXIz5oiDMTa+1NobCf7iJPJmwGjOmUwrflXHGrkxWkJbpAweVNreYsXpqKutG
	L4Ujwm/FIeaI0If9zFKe+zrChhKsOp41tQhvOUyT+VZcIybVVjbL1ORpAbrRl
X-Received: by 2002:ac8:590a:0:b0:4b0:677d:d8e1 with SMTP id d75a77b69052e-4eb947d0b75mr10195071cf.17.1761286242096;
        Thu, 23 Oct 2025 23:10:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEtR9U1iGlrQGZPr6uA0Clma7yT4910fb9qum1J+IWWzJ2J/Ji+vn8lfUnOE0P2SRWMpyyYA==
X-Received: by 2002:ac8:590a:0:b0:4b0:677d:d8e1 with SMTP id d75a77b69052e-4eb947d0b75mr10194911cf.17.1761286241626;
        Thu, 23 Oct 2025 23:10:41 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c120567b1sm320507385a.51.2025.10.23.23.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 23:10:41 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:10:29 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Subject: Re: [PATCH 10/12] dt-bindings: display/msm: dsi-phy-7nm: Add
 Kaanapali DSi PHY
Message-ID: <aPsYVUjyPru5FwPe@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-5-yuanjie.yang@oss.qualcomm.com>
 <em666johhzrluo5z4t2nu5jo4yuowegaemlrursvczx2zze5o5@uakt5j22ygwm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <em666johhzrluo5z4t2nu5jo4yuowegaemlrursvczx2zze5o5@uakt5j22ygwm>
X-Authority-Analysis: v=2.4 cv=CLknnBrD c=1 sm=1 tr=0 ts=68fb1863 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WIVAG7BfrJY6p4e7JxwA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDExMiBTYWx0ZWRfXzwjjI7BkCd5Q
 OCqJ0k1zVzmRcqkv6SoFC6IwCi9BEWFXILWokGxDlJ2Y5gPyRlFV+U450/v0VQlS3POfI+WPS0M
 pvbZ57MXlG/nc3XQTb2osA0s3CZx7wyON7a67lypKXVl6FuyCctO3TdUmrzZ3buXav+vgeaUAE7
 la7kGeF4+/tehNzUAbf77V5gVAUU/25DQOmZqD39gKfv7QWlMkP9ao/e3BqrCvTMXAUdrTdwILh
 3nbSkkPc54yRB/lnzBYmhi4g9n6tliuV2mpbYwkM6kKsDBRGf7P7I+QF8xQNwUFdgSe9f9PU6aJ
 OMKQquY1iQCiAUBFsLUISP9tTfbngDWhOXIP3r99RVW9vfdSeH/Cr3+Bm56PCHf3+jB259y4qzR
 VJYxdsh714KHgBaGoPOASCDv0xlsOw==
X-Proofpoint-GUID: gYKinMo5-M2tKNVUkzvNntxDExmyRpDY
X-Proofpoint-ORIG-GUID: gYKinMo5-M2tKNVUkzvNntxDExmyRpDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510230112

On Thu, Oct 23, 2025 at 03:16:31PM +0300, Dmitry Baryshkov wrote:
> On Thu, Oct 23, 2025 at 04:06:07PM +0800, yuanjie yang wrote:
> > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> In the subject: DSI, not DSi
OK will note.

 
> > 
> > Add DSI PHY for Kaanapali.
> 
> Why?

DSI phy for Kaanapali have no significant diiference with previous version(SM8750).
But some register change make it imcompatible with previous version(SM8750).

I will give this reason in my next patch.

Thanks
Yuanjie.

> 
> > 
> > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
> > index 1ca820a500b7..a6e044eed3df 100644
> > --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
> > @@ -17,6 +17,7 @@ properties:
> >      enum:
> >        - qcom,dsi-phy-7nm
> >        - qcom,dsi-phy-7nm-8150
> > +      - qcom,kaanapali-dsi-phy-3nm
> >        - qcom,sa8775p-dsi-phy-5nm
> >        - qcom,sar2130p-dsi-phy-5nm
> >        - qcom,sc7280-dsi-phy-7nm
> > -- 
> > 2.34.1
> > 
> 
> -- 
> With best wishes
> Dmitry

