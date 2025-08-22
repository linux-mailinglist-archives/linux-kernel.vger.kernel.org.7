Return-Path: <linux-kernel+bounces-782568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA0BB32239
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 793D4B645E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793FA2BE029;
	Fri, 22 Aug 2025 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IpuGHeU4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754832BCF46
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886809; cv=none; b=Ap9GuZW/0KZAC0k8s8p29iW/eELKRkFiyc26UtOuANF2sQHvr094JI6cNG5bkAcbGRi4ObfsTgT+KwpnIIkMz8PjFVOf/wOGNuAIGTy22x0Q1jG0SKt2qFzkJtGV+RHdBWeT7+062IoJJ/0cSpbnQf3jAaTfnz/reI2L/KLBkfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886809; c=relaxed/simple;
	bh=mrp9EhKWJd+GF1xGjXo69QDr3zuHXRhZLJljxro2Nk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxfGDnRzaeixsg2L70u+XBwxvR3k55jyi8Sr9Z0/JKKYv+6ILECoOjX0rzaldhd1A3YMHY1s8cXtQa2fYiQxxje7fBzgJi46pAPi30Rg8EelvxhRIBC+8n0fqZRPETYmmoif6bnKBdAI+2DU3l2nVzodQXjRdDY0OeL2oHTfk70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IpuGHeU4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MHUsip018291
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NxtKtumnK8P7jbCRmulzU2bs
	GNNl6vGrxyGS2XDmajI=; b=IpuGHeU4jrXI4gbTONzrAZjNBA3CK7V8iBxkC60B
	sj5U69qXm/weLcj1eell4vGtNtYrJ/EY1pqfDac2TlDKpUBlsZSEUFqMThAFz3dI
	PB7nAi+FUyA7uegSWpZ03reG70vEsYs+DmT+jHmDdqIm/vb70nQeG04RjGcbldUp
	KDVoeVy7/lUgc1zAd+udtwxFTvlbJLTsJG5nPGBWN36FOH7ln6o7k0coLlCqgf9q
	IgaPem2IJFvGh8FZADYK6QmqEDp1jAn66IT2uIEw0s8Zv7whlF62C9JKbk90oYCr
	ziV1i+Q3PLdv0hbvAZE2tDiMWSsWQ4/RlFd36Do2GuNbYg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48pw10g53p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:20:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109bd3fa0so24909221cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886806; x=1756491606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxtKtumnK8P7jbCRmulzU2bsGNNl6vGrxyGS2XDmajI=;
        b=XZshHK3pFH3rAHWdpPKvfAs9OanYq/pTX43xX0iO9D8Gb5rb4kCHR53eTEuoh6i2pR
         D694J+A212jHKafERmLCzviHyj/YHziGq+nxElalK7iXGgKAVqqFYxR3c9jDEfZ67l48
         OjXfH4leNTHnLSATgU49Gznd6UL2le7GMek5Q2nR0coZm+El9lIYQQ/Ls7Gyy3QAg64T
         iX0CCVzL+HNxKD5MHJtcvppfe+n+RfSuOPF+bJeU/2pUqvVUnp386pnKEefsio4NZc69
         F+cm81Vig3+yTcox3P13No1sqbCDG4AGQRyfJ27SgIDBgAxKkyGjmvRiZEmhf0M49iBZ
         wD7g==
X-Forwarded-Encrypted: i=1; AJvYcCXnscOxUIhgO+V/shdMpovotfYUZVnz7L4zv2OdyMWYhqy6NjyfA34eqbVjuSEkP+xiIeTOWazBZLzSGwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcgayeAlAmuy7+eWjGk8CQ7mEjhkFmkxkrKurFQSWocy3rVHuu
	c1dha81haWTBEPCsrpm3CXkaZXoeyc4EhAsQFHwxjJivJMwJ4hBEFJKkdrDIc273czZWT+1WlIm
	bHosEO07VSJJc+u+Meh9pm/qMA5/Uay1TomHlWq6nqA8ZHRmXp8EUKTCpjHhdvE61jh4=
X-Gm-Gg: ASbGncvIhfv5cW36w4Y7tNp648SIGT0xitsbZJIoz8TUVM8q3jt9LaDADBPzr4FzhK8
	8UpKO8Q1ybgPgEQRlZr+KOBX2CarVv/KaHcLN2K4/8ZYPAhaapW02S/UwxnKy/57b3vCtc+jCc0
	Q/oOie5m7Xa1IdZGXaoQHr0U4MxRXcow5HJgL36/1FPhOQjJnYJV4DDRraPMnIjuZiU/pjI7/UR
	yD2Vsr8SUcPW5GDERPyBFFgFk9JB3lzTaNUvqRHxTYIGaV8hX/d7eh9vFE+05kt/zvEQjkhiwbQ
	stv42Drok1G4d+jtmh6U8BfVqbv6l4h+K8iKj8uIj2uYAdGkl849BhO0jiPs/IkUhOv/vnpj3h6
	5vVXnV9nqToYX5teMt15WfGQpuJYKfnpkMj7yYvaKO69na/iamRlt
X-Received: by 2002:a05:622a:1189:b0:4b0:8e2e:fd9b with SMTP id d75a77b69052e-4b2aaa6e774mr45148291cf.28.1755886806041;
        Fri, 22 Aug 2025 11:20:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoFNCLWAF2tAYF5UUONq++OfHCr9UeqtIPtGxLe6haKB6Cwu0mLgt3aWR5hszae30Z3Zz6DQ==
X-Received: by 2002:a05:622a:1189:b0:4b0:8e2e:fd9b with SMTP id d75a77b69052e-4b2aaa6e774mr45147641cf.28.1755886805361;
        Fri, 22 Aug 2025 11:20:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e2373acsm665231fa.18.2025.08.22.11.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:20:03 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:20:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>
Cc: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
Subject: Re: [PATCH v3 02/14] dt-bindings: phy: Add QMP USB3+DP PHY for QCS615
Message-ID: <vbzqtpsjkxd5qhth4k2exo2dsnfmfn5km5i5z74wun7jc5j7nb@n7dqdw3t235v>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-2-a43bd25ec39c@oss.qualcomm.com>
 <20250822142230.GA3591699-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822142230.GA3591699-robh@kernel.org>
X-Proofpoint-ORIG-GUID: 4lM2CiGIgafeVQBTrSPxKvMBckCdNVVd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MCBTYWx0ZWRfX+k5ezi47dBqs
 ZzV772OKWv0alwscxzdm3g1oRmuy4N/9YBpzmnuuVWkS0M7DA7gLoVOpLMt17+YvsD1GxyM2NJb
 RRtp+RGfajG2b0iMSiQGYy7ndQGDyPb8oH+/KiDtIxq0euaiBcUg+C207PbPv5X7GZacTI7QqRC
 UxtozzuPLK1b9ccU2a+lAoQZSXsazhXCrrNwbZRswLlbf7XftnDlFWr9w2dZIUfQz2qQ+A3z6W6
 JWgEqabVSSa6rvwYeoiU841u26T5N6Ea3Q/7nA+Lovc8xqbuY4ccGr1EH9dxYgSEDKH0hMbF3SX
 3K5JmFHjEyu8gGZwQJg15g9YARugjoAy5T/uxvgj++8KKtra6mmCK52vozRKGcJQyXQTGuXNlE4
 8k0X+PG3
X-Proofpoint-GUID: 4lM2CiGIgafeVQBTrSPxKvMBckCdNVVd
X-Authority-Analysis: v=2.4 cv=B4G50PtM c=1 sm=1 tr=0 ts=68a8b4d7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=FkOoeBMDyMZldznMw-cA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508220160

On Fri, Aug 22, 2025 at 09:22:30AM -0500, Rob Herring wrote:
> On Wed, Aug 20, 2025 at 05:34:44PM +0800, Xiangxu Yin wrote:
> > Add device tree binding documentation for the Qualcomm QMP USB3+DP PHY
> > on QCS615 Platform. This PHY supports both USB3 and DP functionality
> > over USB-C, with PHY mode switching capability. It does not support
> > combo mode.
> > 
> > Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> > ---
> >  .../bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml   | 108 +++++++++++++++++++++
> >  1 file changed, 108 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..c2b1fbab2930f0653f4ddb95f7b54d8fe994f92d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml

> > +
> > +  resets:
> > +    maxItems: 2
> > +
> > +  reset-names:
> > +    items:
> > +      - const: phy_phy
> 
> phy_phy?

Yes, see other Qualcomm USB PHYs. And unfortunately we can not use just
'phy' here. Once this lands I plan to push corresponding changes for
several other USBC PHYs (described in qcom,msm8998-qmp-usb3-phy.yaml)
and those will have both "phy" and "phy_phy" resets.

> 
> > +      - const: dp_phy
> > +

-- 
With best wishes
Dmitry

