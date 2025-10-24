Return-Path: <linux-kernel+bounces-868136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D669C04725
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EA6A4F18AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9B9241696;
	Fri, 24 Oct 2025 06:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KEEy5YYW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA6E239E8B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286135; cv=none; b=eCNcFL+JyPAgbDu9YyRX0oRK8MyVCKeNI7TPG0VJgSNzLvAMQLbJrMQMpJnIgaPklhADDRnKfBajjyBOYuq8K6IxLLMRY0SmIUAgLN1HsD7EJjHQBKssknarl/e7joc12mevyWIGrMdJSeNtbKi/zpc9CFMs854jGLaAd8Xuhp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286135; c=relaxed/simple;
	bh=k/yqgXIND7kabul+nluZrnak8Yt8KlfUOJNkzs0UD/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su6WGUnuy113bZn0hZcr71s0iTwTCPZ3TEolqSl3HQ2hCHxHlb12IME1ip+SgZf6CGLG+LRjXuymyrZvhErtsOcfz4apwiZEOtpMEOlXOfkMM3fMHHPyDgM7bNBkO5Xp+p97HvIcSBnaa+NrayuVinZu+KcIRuoG+KKpx04s8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KEEy5YYW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3M7L6010228
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5paQZUXoZhbSMdqEbr7oDMWv
	5wYg/eSHa84AvpMQ1gU=; b=KEEy5YYWmGISqZocseXqFvvaaUAPB1sOLO3rqjvo
	KU2JgAV8n6Joarvt+LHc7yBgdWDf0m7m+vEWqORLJf1frTF3vDqE8P5zeMk/5X/w
	HQVRqFAwnYc5vNQES9Iqf8gMP8C4QU2evE0EBL5HaP/16cECqMGIZfh7QDBs5C9z
	wkIDgrgKOtaiBmghZxCT4Z0Ka6NJDAK64YoX5D+4QB01Opv4APoRwOxGU7wFlQyV
	+VZElCAflFA3Qf7Rdn76yUIjBSREdea05oxzw4vYWrOBwkCuKKYCFFCBanWJSVxg
	35BlkTKW8mlwQcLetyJFcvBpWL/ec7QZzMZduNclkrT8Bw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524d61w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:08:53 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87c20035ad3so38599166d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761286132; x=1761890932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5paQZUXoZhbSMdqEbr7oDMWv5wYg/eSHa84AvpMQ1gU=;
        b=XarXsJbf9JztuhZB076cglgNM648dQehRAp2NwvXSEHog5s5ljrwW60EKz04ql4ndm
         DbdMynogagrV4611pX0fAp8PLJHRZhgi91BMad71/svu/FQ+Q/SjPWWG0zYXkhgr/v1f
         uu1aBWuQK1PugeGudqPMQyw0nQLkZ4KVJGbBIVeMRRZkrRg5utX0u9btqhmGQjjs9Sk0
         FI5aZx+jdTiX4ZRkpEzOVNvOXeAc2jO9tnUgfR2VVNtvkZBe+Uj7Mrtn9XTffeWKE8/i
         NjBoyC18Ai6xfk01yADQka9Hb2gFbFpSP+Rge6Y5Qd3OtRBx3Q0l4Z518hFAJ4Odicyp
         Dc3w==
X-Forwarded-Encrypted: i=1; AJvYcCXT+v64QK/pygoX7t2i/AG9RPbmsUDV2pSkSvsSnGzX9KkV+C7X+kKimNP+il1X9tjXFMdxEfAB8tTNECk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRcJnghPCjZQDpepAWwgIhD32PJVDPMo1Msm5dAZb9ZDU35ctH
	u2CS6Ds9Ry56ivhdorFMvhZNcjxt+wkrsgP4LNOYvk6h5FOx1FAf2y8QiomI2qIYEWDSLy1HaYX
	ThEs1R7WSSG52Zo1z2DZSKPUzgpy6FltpSrO7urYQ/uyMhySIVkbAqybAoLNfFEFRLHg=
X-Gm-Gg: ASbGncvklj78hDgxQbsxGsZtmqhJr/b3I92fZrso62rnXx0bK70x4/DHmjdVFlWQ+R0
	WwqyY9Fhy6XJclwMH68q6DrMPan5PiVwmWcTdu8hMIC+ZZ1Kb3fbO47115FnP9wO4Jj+ygW3UFm
	YcfOukRNIQZGyuLExfbAAbVbzGD3msSY2+cM/0o3vYv2MprEezutRWOOGOJKOWTCIeN/GuJHBio
	bHcdsOIwcu9+t1Ze538P9evG8Oy+Netg7OMbfotwkhDLnqV8FRt5dfluD2V8tczVXWWRMeNvtSc
	tsCS32hbP3n/BSH5A5mBksyVzkY6huCrqoV9j5shRP7mwo9xY020XZ8vLK1YLLNKwy+9jnPxLsj
	dlCSRvYHHgS0CCqt7Lj/ohmBQwCx8rbA6DnZBcplVqanJbVgWjsfNCm6mqWOW
X-Received: by 2002:a05:6214:762:b0:78e:2582:fe4 with SMTP id 6a1803df08f44-87fb41405f1mr18971116d6.30.1761286132399;
        Thu, 23 Oct 2025 23:08:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJfims6BmldfbNUzzEmlDV12NK3CNrXycYwMc9WdMoAhC7GnzxeZrG4DxKcu5+ArENqYaIDQ==
X-Received: by 2002:a05:6214:762:b0:78e:2582:fe4 with SMTP id 6a1803df08f44-87fb41405f1mr18970886d6.30.1761286131954;
        Thu, 23 Oct 2025 23:08:51 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9e7f52e1sm29575846d6.51.2025.10.23.23.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 23:08:51 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:08:40 +0800
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
Subject: Re: [PATCH 11/12] dt-bindings: display/msm: dsi-controller-main: Add
 Kaanapali
Message-ID: <aPsX6Fh0tiGuUox6@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-6-yuanjie.yang@oss.qualcomm.com>
 <binhwh2sb72ipt2qhqdmnid2hygdnjx62mhzn2cl4v2do467gz@wkmsvroshkcu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <binhwh2sb72ipt2qhqdmnid2hygdnjx62mhzn2cl4v2do467gz@wkmsvroshkcu>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfX05vIKjcwO0Fj
 Lvh6YvBfibnC5lB9IHF7VpcNDQAGmGRi0Im9YRCjiyXQADgNKJpi1rsl+O09sB0XZCbqvZtDB+2
 Qp/s8C2IpCXQuLGk8oHnqWJ0BXPZoGNSlfbodLofbhIBll8IcYDekjeiVqjF4K8/Z2fGmbNhesC
 dqz6L3voFPFfozd3H9cuUOFW0JMGHitTskvrkNuqFdAigyFrr7fuBMiZmL+Z20YZf85wgcu/cik
 GXMYWlgN7b8mdTwUj4jGaCNGMZzwWgmnQPV9ToZHHe990DiqGul3Ec78ZeMtPETyUdulPiMd2zT
 3ZFlUaK+NYbe4JJrh+TGiwac7jX9UUsDYMWCspNmfftQKqHb8Aulu7v3y6BICfspV4n1QYmcBwY
 Z6KGQTh/i0+jIO0zhSH1aLJzfHEuWQ==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fb17f5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WIVAG7BfrJY6p4e7JxwA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: qQN8AzqS1L4FrY4KlfTRg9LnBvA8lEJa
X-Proofpoint-ORIG-GUID: qQN8AzqS1L4FrY4KlfTRg9LnBvA8lEJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

On Thu, Oct 23, 2025 at 03:16:11PM +0300, Dmitry Baryshkov wrote:
> On Thu, Oct 23, 2025 at 04:06:08PM +0800, yuanjie yang wrote:
> > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > 
> > Add DSI Controller for Kaanapali.
> 
> Please say something more important here. Why do we need new compatible
> for this platform, etc.

DSI Controller for Kaanapali have no significant diiference with previous version(SM8750).
But some register change make it imcompatible with previous version(SM8750).

I will give this reason in my next patch.

Thanks
Yuanjie.

 
> > 
> > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> > index 4400d4cce072..536ebf331828 100644
> > --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> > @@ -15,6 +15,7 @@ properties:
> >        - items:
> >            - enum:
> >                - qcom,apq8064-dsi-ctrl
> > +              - qcom,kaanapali-dsi-ctrl
> >                - qcom,msm8226-dsi-ctrl
> >                - qcom,msm8916-dsi-ctrl
> >                - qcom,msm8953-dsi-ctrl
> > @@ -369,6 +370,7 @@ allOf:
> >          compatible:
> >            contains:
> >              enum:
> > +              - qcom,kaanapali-dsi-ctrl
> >                - qcom,sm8750-dsi-ctrl
> >      then:
> >        properties:
> > -- 
> > 2.34.1
> > 
> 
> -- 
> With best wishes
> Dmitry

