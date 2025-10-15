Return-Path: <linux-kernel+bounces-855298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6937BE0C97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74BCB4F1F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC12F7457;
	Wed, 15 Oct 2025 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ILikasog"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6902EB867
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563080; cv=none; b=kwCIW40AmX16oZdJYqLzp/wFnKjR6vrVLRTNx4Fl6bNe4cLaYv6QN1WUdncJlKiYBmZCEN893bPyi85d2FDQQGCoUsivdAvckuW6F8KuHFSQoUTh3gTAoGdiX9MOVtVu5zkvljwBIN9QjV2e47B0DqoMt2kFFQzVxDrpvpmMrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563080; c=relaxed/simple;
	bh=zk0BBT4Hk+RcSV6kfked05wBSaFZl99P+G64EyCQFE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XV9sGirIzZXdC9beBhlfIr+8KRd0Qhopifzcet9vMetHZGvDVV5Msn5ekBoGI/ULa3W/dI7732q91Yw3lwavY7c3hioCn0nNDlm1uJX3iddaluXp6vGWf2TrPmm/YhK0FONZg/dbwQJ0/+dH6eWA2E+ovBgsC7VJStQhf7n5Sfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ILikasog; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FJXoEH017026
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VJeGrgf9qBiX+zK6vs7ZHMmh
	QNY8bpXGFobNX4Fu/fY=; b=ILikasoguN8vUw9dY0Of4A5sKqiegwg4lgOnqIHC
	92cSed539XnnkW/n8gS+c0nlz5XMj32aN14MprGKJYOCq5H9foyUGa3FyQ9JtxHd
	/HjrIr1rlXkJgbIPmZB2iBYhsYZTqNjc1usYb363E+IJP1CPG1Ug8XQgs3/KnEAo
	kWhCtMt4jqZFEdIhyrC3F9WASSsDmKDtP08T8zcEIGD2k84iHHY0tkyHDFm1ZIvt
	xlJaa4Q5d97EguT4RpVki88wEOwnAId50KFjeeig7R0b49Xcb4CPK3ccUkhE3UG4
	CRKtgU1eYgCXdgQp0OY+kSvvOfWNXh2JE+zXHUswp1d6Kg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkdxyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:17:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-88e91599ee5so13070185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563077; x=1761167877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJeGrgf9qBiX+zK6vs7ZHMmhQNY8bpXGFobNX4Fu/fY=;
        b=AfAkgPLpiSrUX/H5FFanq2iORdSdV6M38OI+rcvFXrhKW8o6YmvMo7vFYrO7n/Dk4Y
         Z+8Gw24g80qegWSJBfOscBZXT1zRp1ByofG1vOHOO32Pofxe9tJePFonqlKIZ8H0BXf+
         JoVoNK0TDQIAgokbjQLcDtDChZKpUFPpafvfeNkWSQVJnYE/IWHAiAOfqMnr4O3YJfJS
         kIQu4wjOaXHZSb0RcegDPN33gzwqPpx7aZIcpKJNpB4c5bxlHqGZYgI8rX5bOr/2U+Y3
         eV1kr9ZdKyDBnQgjzs+lChC8AB16eOqTBtIueeT+e8qZzTsJI+lkgdtqlRHLWdBhC2xj
         kgNg==
X-Forwarded-Encrypted: i=1; AJvYcCVuqn/edXoGSE7FZ9U2Wtd55KZpaSclDyL6c7mbOS30tFVX61s6AtGHdgSwZ7Jn1leXg435RajPau/0/Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6dYEO8WZpc8JqzCNv1qHKVqAtUya593El03B5RURLu+SrFFFQ
	jw37skm+5aAM6Gvszqfw80MQoKPTOOyuereUP6PmKPe5Lt5Fi7EFWShfRke+8i8XdbzJlwqHFA9
	/GKr3xtD+kCC+YS+Qmv+5Xx4rrEqMW5xot3JPntvR6jwCFfJQ82k9S06+jfMLwKqMy6I=
X-Gm-Gg: ASbGncvxMGwfBMJhSmQsiqzDgbwH8+kamzWRBHhDWH99F0Cblh5BRls/C26tvgquXoa
	wPq7MEkGqP4XSJBbQQUHw7deWi+RRX1Kd7Xl6jrYfdIAO4LUYMZhL2RJgrSaEkMsryRHNeufHsC
	FQiBRbzip4ALHreVSGOJVrZFsj+UJk19v2UpC7ryArfJoVkDR0akPJaO2hKC6yVVjHA4xmtYzN1
	+W9eiz+v17GIJvZX9ebXfTo6Vl+ScqfvnRDbvD/XVi5U4VAqmtqIaGq4ZtFQRDgCOuvJjIofKrC
	Z6z05YGmLzSK4yCPwKc5r1AFDwUEYZy50L6ZpiqmAH+t+V9UHwv7J1aT55xqsAEtHbfvhavFL5W
	DgGIj30O5IH01YnpZDa1tkgUYyg+F2Wc/jkJrePpUpe2iNlaUjiJwNQQBDlZr5nhgPIwYBcS594
	3F5Bz5/emXAfY=
X-Received: by 2002:a05:622a:4ce:b0:4b9:d7c2:756a with SMTP id d75a77b69052e-4e6ead709e5mr430447371cf.77.1760563077221;
        Wed, 15 Oct 2025 14:17:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWUJjpWuy2SQ3uK986PVDHVWiBrMZNqixssrAxbnP8C6oKcxQyRgYATBifnIDH6x3LpocicA==
X-Received: by 2002:a05:622a:4ce:b0:4b9:d7c2:756a with SMTP id d75a77b69052e-4e6ead709e5mr430446851cf.77.1760563076717;
        Wed, 15 Oct 2025 14:17:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea3ab05sm50829681fa.44.2025.10.15.14.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:17:56 -0700 (PDT)
Date: Thu, 16 Oct 2025 00:17:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: Re: [PATCH v2 4/6] phy: qcom-qmp: pcs-pcie: Add v8 register offsets
Message-ID: <3frncuf654d6wjvegmlwvljouk2xehsmouwjkf2zlgke3t27he@3uh5zyfyglxe>
References: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
 <20251015-kaanapali-pcie-upstream-v2-4-84fa7ea638a1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-kaanapali-pcie-upstream-v2-4-84fa7ea638a1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: YJjURj2DCkAF42XUBdxG6UIQlduEtngq
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f00f86 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=aHvCONSEC-igqZHWBgwA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: YJjURj2DCkAF42XUBdxG6UIQlduEtngq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX3vaD2HxJ4be4
 KA6luASna9X6ySge//PSkEhYer/ln7rwQEaK8ntsdWlaxvgXLGL2yf8eTVumY1yuQmsyn9ShTSV
 H+0ktW7+VEcWOY2uWeXwpjB8nsKqB9yKmdDS7I8RvGoll1HD8JthB6HiacTkJ0IiCtKsRmv5xXi
 L7KEyJHIBFHGhmAD5m17YRChckTsTjuglXOPKTf5jswcAHwdOJjQH1+LrB1ySIwvtbvcAZ6gKi7
 7KSoWZqUdOTgCavNC3QU+FRgJKMVFJo0mpq+S89hXfGK4i9HQZ6EywXhqVEAh89yLxX6rRWRT5X
 +5hev3WJZTJTT4if37yqQjgrqeu3reaMTNrhgQxFwLmbw/ZxfOj1gclml1S/Xbx5ZKVd7wz/sbD
 ZQXv5EolQDGBfv92p0leb7Rsl9fCxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Wed, Oct 15, 2025 at 03:27:34AM -0700, Qiang Yu wrote:
> Kaanapali SoC uses QMP phy with version v8 for PCIe Gen3 x2. Add the new
> PCS PCIE specific offsets in a dedicated header file.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h | 34 +++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

