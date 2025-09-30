Return-Path: <linux-kernel+bounces-838091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CABBBAE692
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260F43B509D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1618728640F;
	Tue, 30 Sep 2025 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e17CAAdP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BE028541F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759259623; cv=none; b=sHFV8fkk2d5X1AWs427Aa0+Y4EfDWlBV3RMS4n1Snej19GM67JoPBjVH/+7wp3KfKGn2S/FkaBddcnmJKToneIg/lsB6Gr0QBhmXkgzfPxPWlCqH6/4shLycRLpZxzmZ4sHhgbecHkKl9Zvsqwr4B8YhQ9ioCLbFB+m4lsPmdX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759259623; c=relaxed/simple;
	bh=w4MMi2h8A5GX9+b9Jfk6wj8TawNywWGn759hh7b6Yuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVchAoxogq02n+ElfCZu8dTl+X3RZY7sB/iyRCnYVqdor++xUiqGnnPljBu2icgwuwO6Vk2/eTnWETexwEX/aBY61Wsj6vZ0JEmZwXBQeoXFPZFKBRxYW0U0bIHg3mg9+aqA5ha19pDp3MgV6AuJ0Gcvtiy/wKxbO7fOB6PtP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e17CAAdP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UChie6027458
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xSV9Cq1e9SR7LQlW44w+/ize
	/XOY0Num8chSiEvfZ7I=; b=e17CAAdPmEViiiRfz9DjP7RWN8bu7dQFSMUkU5At
	rqFHUetkJCwyTtYhVlMAyzfNjmQ+COIt0RzoX1LbuOQBVm616mGtDPTsEOZo/cHa
	rn3O33q//t2dUqleoTN1Yn2BSKwsu/2dzUTc2LVbD3uaTn58OpB4+sG+Rx3zfI6y
	IW2gAyQAQUta8xwKOG+Bwe9eUxSESA0SNMNA4iTS7i1lgsxOJY17i0u5tDWGqi2X
	4PDWUEcdJhCZ6m85DefF7S97zf/ylZogMYoJE3EyqePdM8mmw5zhX8Y6d6/8Fk77
	+7XnWiNhdFwJyrC6x98xfWrZbmMt/z/M9skQTSZBAX8ybw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851j541-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:13:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d6fc3d74a2so179995761cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759259620; x=1759864420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSV9Cq1e9SR7LQlW44w+/ize/XOY0Num8chSiEvfZ7I=;
        b=dbasWvBgm3W2uYWMNbSyEuW1KbS2fEQPk8GZ6e38hd9UVTAmUVxRLppNgQaOFxUehy
         Xw9wd5JKPxft7YGLtg28yt9i4uCBDhqWbt1FiQGVgItYA7lyGV85S1t+47k0asEUQ75X
         idJVhCWG/l4BvbaYmWQJ5VpTYrGhKDXkRfuT9RJn9ePVUdkCSEJ825TvRqEIEjmiqGt1
         NkcyYuyxxhsyobX50NGNRAaRjj29GMi0GxNx+tDjdVPnjPllPZMmvHtU018vhx3kA5CI
         pIxq7A5m1NTfQcxWFofY+itH0s6VwBBtQqzi8ISnk2MTAsWkCchsZn86VeOSewXjZXCI
         mxKw==
X-Forwarded-Encrypted: i=1; AJvYcCX56UcjYTUgwI9A1Hlx2cQiAfVxtgOYY3N2LdIQqBY3eyKlKeUCbFiuMNV/5wdMJAVmdtk23zH3CqwvT9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbX+GzQpqmybGeqxmpWYWrjAiwdd4sgNkFXhbKvUcNtEO+N2K6
	RGOqLJgTQRqBguHjMMEl5zNEiiT2ptt/JqdN+Ss3qR5RzpsZFoFobd+ao66k0rJy1ET+KUVJcCl
	vw5beLzMCq8KrQZR7HPxxdtvhzPUfCYMqlrsAyJnLamDVWnK19VTZDU4AlRY0yjqJI9g=
X-Gm-Gg: ASbGnctmW/kD2zYwBNiCVRDHriOriOGGTagNa5txZujUgSt4fhkcCAhlDyZi+Tr3Yvn
	mvj0xq8cXg+HPCPFFZM6WJ74RQAY9Gqf551jgVyKpqV9zdJtmkHXRTeRo5c9uaAmSBeEtpKwBLV
	QuD8+Z3id6mg0BVZJ850ujWOmtGikQXqLPG1UfsItvVTF5xTmd80DSdIq9I6IEJzmegP+QDuG1V
	loSA8LTtg8e5gvDpcvhelSi82CRv4mfPkBsOfVguonjeS7oLqAddHbFuxdDtHwIGeFBw3RIj4mC
	CP1zpDM2CZP7QDoPZQ31OYWfBJOsfT+RmQe/D6GQHRhrT/JmdEJjen5DmVR0exDjnWFbFeSXQ6s
	GmUPCw4Fq07nahBRuqMIDflK4rpivysAWkLxa2EFtrjbTq0pfmbHT0ZUphw==
X-Received: by 2002:ac8:59cf:0:b0:4d2:4df8:4cb5 with SMTP id d75a77b69052e-4e41bd7a0edmr10557531cf.4.1759259619558;
        Tue, 30 Sep 2025 12:13:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWLFpkh8hsbF0BWjWEBKzr7EQDGz46NeB9GyBzVRvHn8dRxUQboxhAGEfSv3X96BGi8K3Eww==
X-Received: by 2002:ac8:59cf:0:b0:4d2:4df8:4cb5 with SMTP id d75a77b69052e-4e41bd7a0edmr10557091cf.4.1759259619073;
        Tue, 30 Sep 2025 12:13:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583134312c7sm5264888e87.8.2025.09.30.12.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:13:38 -0700 (PDT)
Date: Tue, 30 Sep 2025 22:13:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Romain Gantois <romain.gantois@bootlin.com>, Li Jun <jun.li@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: switch: split out ports definition
Message-ID: <xxvexvdedkzbvhhoh6tubqkbrtxjskhgjockawa22onzwqusp5@iggjnospkryv>
References: <20250930-topic-sm8x50-fix-qmp-usb43dp-usb-switch-v1-1-060568de9538@linaro.org>
 <vwlshz5li23xlthn5delxwxdsdci5nc22iey3xih4qf5uhbory@clskdsy64xpx>
 <426679ae-03c4-47d5-895d-7c927b2c3b07@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426679ae-03c4-47d5-895d-7c927b2c3b07@linaro.org>
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68dc2be5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=0GIP9b1rOs9S8cRHSfUA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfXxfTITHTMNjZQ
 0LzhDhE7lVQNIb71fs62QHI5MoOpMEt3PNVNyImSm6SqJ9dJ231VFv+oNOY35blTGgfhY/7MiA2
 pA4clilp7wGXLi4grFuOg0IbwbrJJdSkXzh4JkO1s/NvDngfgAwiyTvtJNT29fELev2MSVIKZPT
 8VEIpH1qFWrS9eqgipiPsuhbk6n8d5LLv20PcgIGCCxdaDKjkvvPX56JMzpT0Na7VcOfDOHcNaA
 s6Wfh3E6IgSRkO9rZaW0o06gM+X8f1J+3kee4GEZgrbyPCXP3jsoNdH+c8fQdnQ3e4u9TP2xfFy
 XHhYk9IGAXLpaV5QmqJ2CkYUwuLVB9J8VUEAH0YgqhprlDxue6EwQAEz+4dZ3OVb8NH73l9GFUc
 4ryJCGUvKaRVrIagdudT3w6GZT8MqA==
X-Proofpoint-ORIG-GUID: _wjuQMhlL8bsIGEbroXoZ89eixzDA4G0
X-Proofpoint-GUID: _wjuQMhlL8bsIGEbroXoZ89eixzDA4G0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On Tue, Sep 30, 2025 at 08:48:13PM +0200, Neil Armstrong wrote:
> On 9/30/25 20:43, Dmitry Baryshkov wrote:
> > On Tue, Sep 30, 2025 at 07:17:21PM +0200, Neil Armstrong wrote:
> > > The ports definition currently defined in the usb-switch.yaml
> > > fits standards devices which are either recipient of altmode
> > > muxing and orientation switching events or an element of the
> > > USB Super Speed data lanes.
> > > 
> > > This doesn't necessarely fit combo PHYs like the Qualcomm
> > > USB3/DP Combo which has a different ports representation.
> > > 
> > > Move the ports definition to a separate usb-switch-ports.yaml
> > > and reference it next to the usb-switch.yaml, except for
> > > the Qualcomm USB3/DP Combo PHY bindings.
> > 
> > Isn't it easier to make QMP PHY use $ref for port nodes instead of allOf
> > and keep ports definitions inside the usb-switch schema?
> 
> Rob asked to not do that... see https://lore.kernel.org/all/20250905175533.GA1000951-robh@kernel.org/

(Just for the sake of keeping it here too): your current patch allows
using mode-switch and retimer-switch for the fsl,imx95-usb-phy device,
which it should not (because it can only be an orientation-switch).
Likewise our Combo QMP PHYs should only be orientation and/or mux, but
not retimer. I am not sure how to solve it without actually allowing
properties to reference nodes from another schema.


-- 
With best wishes
Dmitry

