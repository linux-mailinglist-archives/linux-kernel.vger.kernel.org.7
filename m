Return-Path: <linux-kernel+bounces-841522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D97BB7941
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCA84859A4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67722C15B7;
	Fri,  3 Oct 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BDAabfTB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2FF2C15A6
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509487; cv=none; b=OKhYgmkP16S/6C8MUSTr9fbYwfJdnysfr/vPXcpxZwtoos3pHv8ZNIWUzd5DYQiA59MjtmjdqWOYJjiyp2rJY3rv8Ney5uAVwGG3425AohxE8BrrA8GSocaIiHgyAbEzyepo09zBLEFbwl17x2zFrP2dk217L1qaBc3C1N3dCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509487; c=relaxed/simple;
	bh=Rd4ITa1ufTX9QpDN7o4u6/QA3cwL90cyiRqHsHecpUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnoDSyCjci4ef6Mm2u/j/UFYAq9yqE5X8Kp8XnL9pnQbNVYgK974eprSux0rjle6t/RlE2zG3fufFfztuPV7kouGdK6ZnN3SiLiEZHKBV14Acm+En4Kmacz7bZTajzNIFnxqUxpJ9RkGYoFJWVHEpHNfOzyuzuLJFV7468CpI4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BDAabfTB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593C4Li1010615
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 16:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PaB05ReHzVkjcgDOQJ8wCEcv
	GYDkEolJa/U3B3s4jhQ=; b=BDAabfTBHu4Qu7hHQcd4IUutsFopPzc789XbybRe
	tzimqUkbL+tppeZO0qOdF4ae7AbWNAr2ewqk7VA4DRN0VBawMYahdyLjSNZvPO5Z
	wW7YVot4zjAiwsgzl7HQ3u6gDxNHcgI//Gy3/hnKOYssKKxqixoGbog/jtwbC2hw
	p8FFXFFJuRrfRvpmEaSadBLlCN552h4+fAQUuc3+vol+H5TKYaiPXwZr/BKz1/jV
	KU2jbNZ+R+r0lM9bnAw3DEBwULi20Ndl5XVUo1ix8tKuocoxXxMiBynlsgXtwhiU
	GCwz2Zr/jlzRNlqtU/iA63FyGrk7TSpwt3VKA1grlgQ1rw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hu1s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 16:38:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e0fcbf8eb0so59999261cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759509482; x=1760114282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaB05ReHzVkjcgDOQJ8wCEcvGYDkEolJa/U3B3s4jhQ=;
        b=KzludHrNZD46l8ZD3rHE1xschpgA04aXPTUlHTI0i4vlDaDIfjYxm97ut7Grcy8k0w
         BsWitln0x/28FD0rFrLKtPQQQYV7v3TFg2OnmOQzzbUVNCRcgj+YZtrmYfJMqnu0Y+6g
         YdpPP8LmHBjWqp9ldXz36lYTyaG1Hehu7TyPzStQtXU0bXtUvpO+ldkgBHeRDe8ziVUL
         Lba0RRHgRWrOQYg96ksjHnKgtNJEbmWBanZAjgjQI8z/y/mhAj1QrwRCU/CZW4vxsJ4+
         gyrj8cwyLF8HilN3L1Y3XLKS0PBst+8pvG77Jxpr0jFBoQFnEkIx2thQ3uoJHB9aSBB1
         xvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuCEWHjJ8gnTBQg/X8PSzgi5WNN0i6dNGKOLugGElTFdkArg7eFzHvgIUjYbbjzlXR08J+5thkrd7xL9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDclnU8SUzizAzABTiifexQGq4xvMX+/cLRccrKY27OvCDER/+
	QWt2rCnyzZgcapgZ6T75Vk8RTIbtWLmdLJmJsVRLsFI9jvLfNyycrJssFKbJM4dDQijJxPttBA5
	4DWr8yWPA7Hq6xBEorripwwbA6WW9rypiPOL4Jfic2CoLIdj51jCKJOcPmn3fJucdpSw=
X-Gm-Gg: ASbGncvwEbA4dBsKl1QVKEeDPvHwn67Yb34ptuPVuCj5+g53QNIILvN68lVBra5t5m0
	ziJ9WdAHA9JW1u6Y3F4uaW+Ri6nLICa/y/avL0AWT6jVAwVLRx3+oce7Wzhzm1pwc/Vrcv+PSQZ
	a9lSnxl5fYXkj+zaWj/qWs/QJpsQR38uTSrKGPm6Th1a34/qM0453WV5jT0Q8V4oNGdIcCRgtlD
	vhYd7fPs8Ob4M8vsNopCPWodafJRtotsEpKZ6rjaob9TxGBh0S92lCtlk4AwZOf7Dfr9NBQxmqE
	7hAaLr8iobexlJO24EeWAiVe+fySuE+tEfo9h5ZCXY22FtYYSKmZeRdsK6Gw12InL3/NNRSHB2d
	1V5pzt8x5tID0+sLtEvfq/LfOt525Z9a+aKcaGXvRoSnRAh8c0bFgwtRTYA==
X-Received: by 2002:ac8:5a84:0:b0:4e0:33d8:c636 with SMTP id d75a77b69052e-4e576a80529mr50279171cf.26.1759509482070;
        Fri, 03 Oct 2025 09:38:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSWbvfWkZQINoQDGTwKD6Xs8g7eq9/yE76D0brkwEkWdt9KSTmMQhBBhVaw7u8NS1F6T0QKg==
X-Received: by 2002:ac8:5a84:0:b0:4e0:33d8:c636 with SMTP id d75a77b69052e-4e576a80529mr50278691cf.26.1759509481479;
        Fri, 03 Oct 2025 09:38:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119e878sm1983385e87.99.2025.10.03.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:38:00 -0700 (PDT)
Date: Fri, 3 Oct 2025 19:37:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH] MAINTAINERS: Update Jessica Zhang's email address
Message-ID: <v37d36nd7ues6fp53ncrqdzvmikzjn4pf427wztzatc3pvqhvn@kpg5jrkqbfc4>
References: <20251002-quit-qcom-v1-1-0898a63ffddd@oss.qualcomm.com>
 <35jqgias5o4ruhkc72oacepcq4skfzpe4gyivg2pz7bnpy5luj@d5saa7y7rcus>
 <e42176e9-cac0-4142-b463-9eaf86906c46@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42176e9-cac0-4142-b463-9eaf86906c46@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfXxpADFzQi1pzE
 QgmWRokicCe5O58+uTKXBVQ23aM1Zhc74TqmzyW/g3lf+5UrYecQ9y6nH7ZU+WSJROxUhUsOGy1
 zYfOZ+uvvn+2thofVnkWDt2bp7yh05AZndyL9Co1LCWGZHoStTWqOJ43T0SAOF0SepkBYB5wOzP
 o8Yn7CBvpqmpgLCgTA00UiaxBdabOKYEjsJSs7sSd7ecZjfI4n4zCJ8m9RsSSbjQbU1X1Qa3lVA
 OWeU7c6qzfi3fa1ZsVBgvavqDj8Ekp5/v7VkPZXFJmKERgtGaq+Tj2HFCuNEno+aBuFuptQtZrA
 sOZ/6sYWJ7ubAXLDY/j2YqBFU2rg1k8gVwOuGz0JQN+ApPNDoExUirE6wAgLfd68wa5abSn9CvX
 DN46IHidK/xj3l3njrKv8GPHwHExxA==
X-Proofpoint-GUID: 0azEHQS3E0TIG9yumsyTT9zVSiJZInpb
X-Proofpoint-ORIG-GUID: 0azEHQS3E0TIG9yumsyTT9zVSiJZInpb
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68dffbeb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=qOohxIfdt6ZrimawmyUA:9 a=CjuIK1q_8ugA:10 a=2MHBSq50hwYA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On Fri, Oct 03, 2025 at 11:01:56AM +0200, Neil Armstrong wrote:
> On 10/3/25 03:17, Dmitry Baryshkov wrote:
> > On Thu, Oct 02, 2025 at 04:57:35PM -0700, Jessica Zhang wrote:
> > > My current email will stop working soon. Update my email address to
> > > jesszhan0024@gmail.com
> > > 
> > > Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> > > ---
> > >   MAINTAINERS | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > 
> > 
> 
> So dim complains you didn't review with the right address...
> 
> dim: ERROR: 261785a47e0b ("MAINTAINERS: Update Jessica Zhang's email address"): Mandatory Maintainer Acked-by missing., aborting
> 
> I guess it expects Dmitry Baryshkov <lumag@kernel.org>

No. It is a known limitation of dim, it expects a maintainers's review,
but there aer no maintainers for MAINTAINERS file. 

-- 
With best wishes
Dmitry

