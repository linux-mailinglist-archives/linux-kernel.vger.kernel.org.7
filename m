Return-Path: <linux-kernel+bounces-779487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DD5B2F4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80698581EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54382E11B0;
	Thu, 21 Aug 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GEKIUoI0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA32DBF5B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770253; cv=none; b=NVKRWRU/TKDIIgmz5szECw27Cl5tl6Re7Co2/64HEvNq1PeFR7pJJ/AQZ0mVgWKnpUdYOfhpHr80HIaNe/dU9ZftNoQIOs4jE8BRCtZPpa+dyfkrxtjBnBbLmxqxpb5rEF0uCyqBUn5ueo2++OKxoUgdOlu943SBEOXgXeLQIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770253; c=relaxed/simple;
	bh=vy2/4IDxVTP8B1054laffR6LkPGsxI0lLeNGiepTPwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/7jKwvOkt2AZBDHWiEsiD6BkwfbOpnPPJku5+xucLonxJZp15hKo9KfYut8mSG7JpIdEhaRicnNVHdsCAP7riH3OWJIu0VpCbDEYwEgQ1uD+gnCv6Rjn0GEkcePY+bg9HOKbJScLPleoHfFR+qQne69N8u6cJdSA4b26AosfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GEKIUoI0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9b7Zc014976
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=g7PwJmWud4LLm5PEBKc0rhlg
	wmfYyGE456fNQ+YMjxI=; b=GEKIUoI0KrJX3ctpuKhvi/fCWZUkiKZNzLnRXHmA
	RF790C7FnptHnL8LvovYOR9qsce3k5T+jFLaHV+KgJLVyh4FQpJQG3O8gB9htIMP
	EX8bHOnCEamW0p6jclZb4yg3W78A5fbTLf3zJlstXJeciAl7ahRKFxurfIxxgH0w
	F2Ql9/N7HtQSwqL8FcvTbcmXfh4G1XUYlWNI1Hsi+bVG1TdE1Eav6nrJoGAgpqME
	MbAK8asuZKKaeRtz18XTy5RR9LuggXf2OtanGCCI33iCaUOnFXXQQpr0KCTEaEpw
	d2CIXgTFqB7oCEcJ68F2aJQSBEHSNjqNCpVMUBqwF0m8bQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5294xr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:57:30 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a927f570eso17454316d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755770250; x=1756375050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7PwJmWud4LLm5PEBKc0rhlgwmfYyGE456fNQ+YMjxI=;
        b=bPumaxbAz6VS/WxSM7Dp3pfhNfsxvnZHoCVqeJIHOKtO4Rc6g3Bk9vAS94FxAMS+6q
         ZjvQWJM/Atzcb9vJJl+vgkkg1gk82FbcDvdf412BOe4vb1lMNbL+vnNc0+QhhGTpwj8a
         WkkjnyVin5r8hCgSt7D8UzfqDFxgQPLKEbKaHFIEh9ccBJd1dxHv1Oc43koovzwrFhh2
         6DhEaUNXYbZpSFvF6koPQo4sLPCZXSjkHazk5BPC6U8Wcl2W01/llwp1nFo3lW16Jf5x
         WNFMGlWsUdZ+h20n0cy4o4wLaGN1e6m4Y4nMfteshf55s0u3g4AccVzMeXspULz836oe
         RIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbFf+pqu70thi2pH8b/fna/IfMjT3cxpfZRRsCOsWX0bsDrE/R/cn/vu6L29PC9H+1qLIGntbaE5HQnPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6S/jLFyXCZ48kbHjNFHJG7NLcYy9SRo40MCwU0ubRT7d0zt/H
	tD8m99W+bB1lHvxmCg+jJJ5sI0S3b9hhX9EG8hPLQK5LMgE0TttvdWGrJ2YvfD/DozfQIthUGVF
	wfIUivCf3OiNJmwrJKCq/WHQbK2ygKsOdkfpaxLTY+BVD+e99r+8b03jqKl9XCsJPKC4=
X-Gm-Gg: ASbGncuh7ddFbuER1qWyPIWyzjUBoCKZcg2Cqdam3mE4qCN/3yELJ9iJDq4mjqb/zut
	n0REyUthOIKtqQXzojdNydnWfRaDkCipULTPNXHt7cxynDPypZZllv6kOlmPfImYKcUt6B0+7Ox
	nZljCfSEouexQizqQxjY5rpe91rHK4biLl9t+D6Mriia99vaqVacc1SjDQ1vztkKFLNqxTN99My
	mXFJEUaGAk9imryUexdrh6vBuVkoIQh3tpoU3ModGy6NU9c6XFeVN95YpF0v266OjpdONn+MjBG
	UDr5sHh9lEi68+JzBWnExLw0ShzrjUA3HoPUWNOZL2dH78HB4m0dIoOb4iceYL0AuG05ih2jNW5
	ZU0I9kw3+ZNLc4iiI8kQtgUu/vxMoaPFOfPc8qTRqgLlo4MENBrIg
X-Received: by 2002:a05:6214:c82:b0:707:76a8:ee9d with SMTP id 6a1803df08f44-70d8904ec58mr14210406d6.51.1755770249853;
        Thu, 21 Aug 2025 02:57:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOEFy709p/UfP4jm6FhUpBzgWM0SGkek8iTlc5fP6qfmNzP7NFOaAd+rkmJecj03zIVotF/A==
X-Received: by 2002:a05:6214:c82:b0:707:76a8:ee9d with SMTP id 6a1803df08f44-70d8904ec58mr14210196d6.51.1755770249441;
        Thu, 21 Aug 2025 02:57:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a41d325sm30632461fa.5.2025.08.21.02.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:57:28 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:57:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH v2 3/4] phy: qcom-qmp: pcs: Add v8.50 register offsets
Message-ID: <utakatkrxgfggm2fo3rtg3w3t43vibqaomnwfsp5wi6okuxv62@sdsx74667hgz>
References: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
 <20250821-glymur_pcie5-v2-3-cd516784ef20@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-glymur_pcie5-v2-3-cd516784ef20@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Aui3HO9P c=1 sm=1 tr=0 ts=68a6ed8a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=oUcIdNJcVQQXXIIADcgA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: RsfOOAax5luryKRcqMSgkq8OPEOxwZMR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXy1wF4V9XPQFD
 NZt8mEJFZCNIFI1hlzPnfidipTZZ5xGsrzv6+k4q/flmZtIYLODPaJxhqgIcwOHoGKM5ujBNpk1
 074DgpvAy2HTn86QgZNwtJBtL9+PoJYwY2UoRGrDq5PPStFSinPIYg+M1Jl9HTuiB6efrm4uvPD
 Ay4gV/6pVQIjg+On6jYlJxKrRE25OHqF2C6PHVAEISyqfdeP9EZtC4H6f12pR3rCqO3dle9UoNF
 meTgNYNtW8NGl6nS2hK/BMmSRBXoFFRYXq4E1rI1EA7RmLA0sRdSQ0JSct4i6goxbOuSYbmshvF
 kQryNpl2Ucjm1yA/ytmVbOtfuEDUzvBZ/VJM+F63AsQTvtJzFA0C4askBhx8+HRNMzBTC/bP/ac
 eNRq0KX+Imnl+Fc8wBlOGVvzMpxeLg==
X-Proofpoint-GUID: RsfOOAax5luryKRcqMSgkq8OPEOxwZMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013

On Thu, Aug 21, 2025 at 02:44:30AM -0700, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> The new Glymur SoC bumps up the HW version of QMP phy to v8.50 for PCIE
> g5x4. Add the new PCS offsets in a dedicated header file.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h | 13 +++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h           |  2 ++
>  2 files changed, 15 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

