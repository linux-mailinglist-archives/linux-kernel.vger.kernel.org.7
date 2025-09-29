Return-Path: <linux-kernel+bounces-836071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C03BA8A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CE33C6918
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A7D2868A7;
	Mon, 29 Sep 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RgMP935D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C721FF36
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138503; cv=none; b=YMHKTsBC1tI3pTEiwSDzHoyRjn1Pc8yilL7uzDT8bpevih3Kdhu4XhvACFxmyc0w6NwCSCdyJD6em9AMkAvwCI4TVwQWs/cdUJXX10du7f4KR0l7ojQoVqChexDShdP0Wy+RbkQL9jGwGwR9QWdQWmCGNbFepgdPCrXmR6v07i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138503; c=relaxed/simple;
	bh=mRsX3dKnTVn76I3diVMRJ5PswMmK69nK7/3BH+Z/a+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxNEOXkyMOQ+Nav6zlqhCqbpFbAxXsPcH2KvqWPkYOunkf9VQqQ2sa6yF5pITvf8yI1KTYAX63uh3I0BDNmkayHDEc1PoHZSEOGn8PAGzKy+E3w4DVaJXIc/Rp+7SG1+vkm+urwZIkrZFYOGK+hc3leg1UGbohoVBQrbWG+blf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RgMP935D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SM6xo7001866
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fmYtyuvX+TYSvsQjEOU3V3kUhRzcJFG8FYtCxH2TOxc=; b=RgMP935DOHr3mR/S
	eBCkOClNI0KyaU6v5fUmAs1NJhHBRm4YeoR/LeMdiSzatVciUR1yTwE3k7ZQzPxL
	AFX3iwt11Ele7NWRlHPq+6ov1+8sfzU//Y2MbM21pjqL3Bcpjr0ZlDA/Uo0aFdas
	N7AHE9b3OgrFAB5hB3ZQaa9BdEDMLJ2Zw0RCZws2c/KdrHBUdppaF4KLuQzsMUNu
	WCUBJg+58UBd1zbNXTBAvTR9NfDPVxrXaBRk0d3fncEQthttjyCHaHjIPtBBRKS0
	4onkcwrIbrcWpDUaWSMZZTLICsdjFENv4pF+u1s7c0ft0sH5QsAgjJEMkl8uAZdb
	Sqw93w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5mr2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:35:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4de2c597a6eso95780851cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138500; x=1759743300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmYtyuvX+TYSvsQjEOU3V3kUhRzcJFG8FYtCxH2TOxc=;
        b=NQnTmuT35yx/FDwrbetx3+AtCbOLIX3oRS54SADwt59G01EFAdFbxt+s3ElstPHOKa
         agDZZTGiATZVBDj+HeBa2+QhARh6VHis7YmHZF93qntdrl7KTPgQmSrTpJztSdEJ3ZD9
         6CNvh7R8hvvro9G0iNkGe2p5uF5GBqa4zhI/OfnH/RfdpqyC/qkIjMUnruFaVSALus2L
         QwYrsgFlwjKtwm8MoIclT72GZQofyuW+hIaXVJlAY6pNtAAnYQGwBhRrtxyTBLO28Nlk
         l4wkM+2x0TPf+euHx3UpGpRd+lGrCmAQRPfIbbgu2tSGsTXJFYl/v5S2qtqsoaNFqUza
         SuiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdbqvXNO43DkBQIbKRZlnlq9tWJtfDdjrht2v7CO/y75kmlowMrgTbRcpGvjkC3pZ6bEmYwAOSCage8uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJrnNspN1O+1ZI6qtvAQl/ZDNXgMIS/jvtllTRO3S9GTbITLoM
	nup652On/9mU7vXHnr9L7MW+MolWE8LpeuWzD4VqIsko6ntPWaX4f8o3GgDUvR+rJbav1Y+o8vm
	n2I2Em/Lv/VsRLLiek2Jq70Bg/hIMRTF5jjMgeka03BMWtR0kuljSkWPLSiQDx1mZ1pE=
X-Gm-Gg: ASbGncvdBnmKD06F4GbiSBXYLRlicrpHIeIJk2ZYah1f+8mTwgldDi+CxdbRur2GJno
	EIHLl3PlKnG117WUSOlIT51KMqfRst+r3QU5p4pv2AfxuV8qh25CODArnFRa4Gl75SbMnq3F7ZR
	JQ9veZCgW3w7yJa3XJNOK8iHmuMbJoGtMhkA1ArJfprKRoSzsEqrvREcURGVbLLZLsKliVZXUdU
	OA4BissB6jllYDzmR6LBBCwGnNtoJQRGSiOi/cPepYvrEtPwxbpw7ZjTjA6+j5uq6ymDiMZhb18
	apQqrH+WMAxWox0vkYgNK5lbm6VXXcfcjsq3DJJgs3xvWmrKOCmKmeSjL8j8OII1ZDN8boIZZo1
	DixCw6DDzO1Fed5T6VUplOk4p417oZcbmXNnUZn9gNg2XfDhVT8RC
X-Received: by 2002:ac8:5d02:0:b0:4c4:695b:9712 with SMTP id d75a77b69052e-4da4b809717mr225385731cf.42.1759138499598;
        Mon, 29 Sep 2025 02:34:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAVn+j+N/RqaW9AiYNNjjr5aDBEy6eHhXUJcQNHS/ynl5kMhAJNVTVzSOT1Symi2t4TjZugQ==
X-Received: by 2002:ac8:5d02:0:b0:4c4:695b:9712 with SMTP id d75a77b69052e-4da4b809717mr225385321cf.42.1759138499151;
        Mon, 29 Sep 2025 02:34:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583139fb04dsm4059633e87.44.2025.09.29.02.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:34:58 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:34:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski.k@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 2/6] dt-bindings: remoteproc: qcom,sm8550-pas: Add
 Kaanapali CDSP
Message-ID: <o6dzhmlicwiezmxlb5uqitx7e3pjpyuhbjqfumivbdkru42hvn@r4ksfa6m5nd2>
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
 <20250924-knp-remoteproc-v1-2-611bf7be8329@oss.qualcomm.com>
 <CAJKOXPc57_0pJ2ZWf2cKSKAcQMc3S_mHKQxJDzWH7t=mgim3CA@mail.gmail.com>
 <5820a9a9-4474-4c4d-905c-0efd9442e5e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5820a9a9-4474-4c4d-905c-0efd9442e5e1@oss.qualcomm.com>
X-Proofpoint-GUID: OVv7qEHz4L_ccdOTMrAlFYdzUqAz_l9-
X-Proofpoint-ORIG-GUID: OVv7qEHz4L_ccdOTMrAlFYdzUqAz_l9-
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68da52c4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Gqe_g9I57pFxb8mTp9UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfX99Ik18G70hyn
 I8moo9QHMZnZ12sCfY8IFr8rM0Kz/bejalU/8zwi6xXwNuWMdyklBLRROrNn16hUYVMJYjgINHD
 8QTpaA3et1kh4ak1kDILsi3IGNv86cP9kBemb7TJVQspx6nFMlawAYqi8TNDLAYvXNeOAJRSRAf
 l+UTCk+N539R1GzIzoLk30DIjCy/C2oUVTPWScQAbM2mtfFUG7wF4OYzE+pIBsmMbeX8kbGLKDE
 /MZCvd7b2S0JrnHDdN8v0MIKPJgRSGQfu1G7kbryABFtxDJCgdJ47LlDwWn9Y68ANTrjQHBPZmq
 apEn1ohNIV2oi7eULdL8yAAdkrxsVPHUpdy3l4VAfi5Z+KNB7XlFgja5o64IeNd779KTFxAP84S
 V3DS/Nmg1TA94Sigw+kD/6N9XV/Siw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_03,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

On Mon, Sep 29, 2025 at 02:20:54PM +0800, Jingyi Wang wrote:
> 
> 
> On 9/25/2025 9:48 AM, Krzysztof Kozłowski wrote:
> > On Thu, 25 Sept 2025 at 08:37, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
> >>
> >> Add remote processor PAS loader for Kaanapali CDSP processor, compatible
> >> with earlier SM8550 with minor difference: one more sixth "shutdown-ack"
> >> interrupt.
> >>
> >> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >> ---
> >>  .../bindings/remoteproc/qcom,sm8550-pas.yaml          | 19 +++++++++++++++++++
> >>  1 file changed, 19 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> >> index be9e2a0bc060..031fdf36a66c 100644
> >> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> >> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> >> @@ -35,6 +35,9 @@ properties:
> >>        - items:
> >>            - const: qcom,sm8750-cdsp-pas
> >>            - const: qcom,sm8650-cdsp-pas
> >> +      - items:
> >> +          - const: qcom,kaanapali-cdsp-pas
> >> +          - const: qcom,sm8550-cdsp-pas
> > 
> > 
> > This time maybe without HTML:
> > 
> > This looks wrong. This is not compatible with SM8550.
> 
> Could you point out what is the difference from your perspecetive?
> it is the same as SM8550 except for there is one more interrupt,
> which is also described in this patch.

I'd second Krzysztof here. Your description points out that it is _not_
compatible to SM8550.

-- 
With best wishes
Dmitry

