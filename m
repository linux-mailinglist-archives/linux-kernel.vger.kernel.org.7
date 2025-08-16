Return-Path: <linux-kernel+bounces-772046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFDEB28E32
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54810B02032
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38D02E9EAD;
	Sat, 16 Aug 2025 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kiFVLGCz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15782E9EAF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755351672; cv=none; b=px8czW/FAL2n0lg9pcWdw2MjJwSXADfjXyez0G1ieIynCLv19j1f8veTyc0LGKZ4nAqBxeZLf96npTpywRaexGlWBGDmxbxtKO3Dpa1bbMlNKRO3Tpy8KkJtBUVW5pBQacjzVJbvaMa1e3CY74CMAgvP/rnTmj5xJWuTAaTxfhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755351672; c=relaxed/simple;
	bh=88GiwkZKNCDwLk6eXHAa0jmgVZHYyj0WA8z7+AIxL0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEAsP8koW+SskiS3irG5ZtlWVX1OKhGr7+1VgQT2tM02CrivY0LLTtgKqziyP19AHfBpYJ/CNiD0dtpqx/Hw/XDCIM8BEdnWu6VLUHBQODNpLLLmCbcfKeeeqBu7i75Eg+G9Mne02N/lsRmPs1wJ6TgGW88kv07AmZ8hhT6hGNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kiFVLGCz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G5dDLq001113
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 13:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hqvOIjDAPfjbJ7ekdh2Wrz7OtFU5MOufOc70nYN4Aks=; b=kiFVLGCzDJmzm1p2
	wGcKx3n75MVDAA3cJpW6gZa2HGrFZcdvkL2p4d499htRp3YmBs/HMkJP+/w5Dftw
	HEm0K/WbZ2TQRrZMh/sL3EPqGTM6FnifA4+kF2A7f4d8C80oTt5Dz15iC+tYvy/0
	YtxxOoVmcQRUKAxJyMBxEQxKOcloOJ7r/bRuTJp5MdSrlHBIf/iBajC2iMX+QYNz
	AgA1QBnyo0xGNK2omPbdQrmbrQfx1yG8hRs/IVbdONheSiU88BhrcHTuLILGMd5C
	8kMXX5NzLJidANjVtBy52M4vfc3tgTfytoOKrBqri34NpbIcWbVqKb4gWV5w5NNI
	AbobNw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jgxt8t2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 13:41:09 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a88de16c0so61376916d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 06:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755351668; x=1755956468;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqvOIjDAPfjbJ7ekdh2Wrz7OtFU5MOufOc70nYN4Aks=;
        b=NRRERW4j055czZDGK2NRbX8/XdPOksyXBLMnrayNxlyYvzrCvnothoal9hanXidoJN
         z01xyKn773oIobNi0eZwB5ZcxFVZH/1mHVf1Rn0+M6atJPlD9ixJ+Tw0yiSV1yh2qen3
         tm1ecovlRC5QnJYL1IAFGzFHdjnr9ltHhq3RgOQnGfYMhPDOwC1SnJFYeB3M9NpGRoao
         bHSSQQbTnhCy19lUWNOsKz4FCalzcGxvLZawAD7jtcObFsnV8pZqxq9i0f//8ULCTLtK
         10GPzft2d8aZ70nuPIuucLe6y68x6EWKRh9PXe0zEtBs5drhWLPVO2aDeY3xVaOLrKuR
         emZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOWWNFWPA/HX0QNb8pTMAf6VrqMq1XIlZTShuwjLg4xN/RW0ZbfW4i3KtVKPuAoyXoeBJHD2NTPIYIvYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7j5Qe9+yFI5QTM1vsb+AnsYRRpXfAUqD1oQ67ptMJBkBt7GIl
	9Fob9mfl+Ex/a0Glsrlkxvw6RazNMqDfqqNSar9m6B3s4dPT5cbID1UF8Iy38XIEYIYrpyupoYS
	IP1DRGL2QiM+e97mbvhif3IFGKqyTAXXm7gKqvk9JVPyeu/l5fmduZ+BE8k6ZGz6iB/Y=
X-Gm-Gg: ASbGncuiQxS+Q7am5FwlW4Pj1aFT5ZsFgTtAN+JPbieLhTI+3iHYFx83jmFlzI98AYC
	7Bb5jDw6DksPAXu3GWpEYuausmuCu/sWTTezzMsCvv8zDaPr84HYUMNXeSr5XhlxM/saQ7UYMCC
	eXkyfk7PNyAKNqGGSOlZrN4sWOp2uernm/m70QvscXAri5ohpg4RzrybcC8MQMAho6/CcPqQg9T
	TupL8m8WOXFDoB59dtlrc3rC3RPxtPBTZsWVoZF2jYSH/7+556Rc6Z/Bb02X/d4ngkhs04VUAQQ
	gZXLCkih/gplsxOrnwVWryKzXrSVmLi3dPu2tSJpMJJH+G6lsG+BmTU2/jyI2IQ3fiJnWME7V6P
	wiaxqJyGONti8lnZbWNIiOU5EogcjjfL0R6PBjxwQ8BCL7Fuuu85i
X-Received: by 2002:a05:6214:2584:b0:707:5671:c95e with SMTP id 6a1803df08f44-70bb060b2b8mr33508806d6.27.1755351668494;
        Sat, 16 Aug 2025 06:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbdWW1cI4h4USqekauYtnWURjxz4AY4R1pFpb3Rh8HerRaOk8RjnRwNH7bTYXS6VfcvXmb9w==
X-Received: by 2002:a05:6214:2584:b0:707:5671:c95e with SMTP id 6a1803df08f44-70bb060b2b8mr33508556d6.27.1755351668039;
        Sat, 16 Aug 2025 06:41:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a625b9dsm9979421fa.56.2025.08.16.06.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 06:41:06 -0700 (PDT)
Date: Sat, 16 Aug 2025 16:41:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric =?utf-8?Q?Gon=C3=A7alves?= <ghatto404@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: add initial support for Samsung
 Galaxy S20 FE
Message-ID: <464pyyfa3wtwmismlwizaxsdt2edt4flik5cxatjo34pldsk6c@bz4vzdcefcnr>
References: <20250815151426.32023-1-ghatto404@gmail.com>
 <20250815151426.32023-3-ghatto404@gmail.com>
 <xmxo5uogkexiwq5zh2eza53pnl5jrqidd7an7bftjtq4wpaup5@mlekuufdbg5v>
 <31CA09B3-E451-4EC1-8273-A1F09735D1FB@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31CA09B3-E451-4EC1-8273-A1F09735D1FB@gmail.com>
X-Proofpoint-ORIG-GUID: hmP888OJ4cKVpGgXE9NZuXp4rlU-5sLB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfXxIrlLnZgQow8
 ZtH+cm+ac/NFairUDEwgwPxG/0+/+v01SBvEFsZslWfbDxNXU3V26QqtVB1kD4K0HeF+Y6+1ec5
 bzwegM0/ZB6Fm/t4pgUjDNPkWZ+Jv0yiLWGBlb5uqIUhdJ1iKHUbpo3ViogFm3daogX6EhFmsuY
 DgqSQl6tL0qACrJExn6ihDK84Bqwwj4KqfmPNR8opa/dsWHsdiLwAWR9EhXvNMkPg+lZVKRtHgH
 MDWUwhNZ/cX5szp5CmuL5rBJeWHZ4YFg3uLk/uWJ5k67evj12d7vV9wAdehP1yH9EEbyPIpJJ7w
 OyjQBQ3yKDxkJjhmUGjx8dn25EXaWT2CMW9mWD7lHkOnt3HAlyilXlAMaG+NmaMDsNlQ8+4P32B
 O663zfZY
X-Proofpoint-GUID: hmP888OJ4cKVpGgXE9NZuXp4rlU-5sLB
X-Authority-Analysis: v=2.4 cv=V7B90fni c=1 sm=1 tr=0 ts=68a08a76 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=MQc2VpArWmwKgF-1X_AA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160020

On Fri, Aug 15, 2025 at 08:28:32PM -0300, Eric Gonçalves wrote:
> 
> 
> On August 15, 2025 19:03:20 GMT-03:00, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >On Fri, Aug 15, 2025 at 03:14:26PM +0000, Eric Gonçalves wrote:
> >> Add new device support for the Samsung Galaxy S20 FE 4G/5G
> >>  (SM-G980/SM-G981B) phone
> >> 
> >> What works:
> >> - SimpleFB
> >> - Pstore/ramoops
> >
> >While the patch is correct, are there any obstacles in enabling more
> >devices on the phone? I'd say, buttons, remoteprocs, PCI and USB
> >peripherals should be low hanging fruits. If you can read pmic_array
> >from debugfs/qcom_socinfo, then you should be able to identify PMICs and
> >add corresponding regulators too.
> >
> >> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/Makefile             |  1 +
> >>  .../boot/dts/qcom/sm8250-samsung-r8q.dts      | 47 +++++++++++++++++++
> >>  2 files changed, 48 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/qcom/sm8250-samsung-r8q.dts
> >
> Hello Dmitry,
> 
> Recently my device's battery stopped responding and I was not able to
> work on the DT any further, so I decided to upstream what I already
> have so far. Thanks for the feedback, I'll include more features on
> future patches.
> 

Thanks!

For this patch:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

