Return-Path: <linux-kernel+bounces-743108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B749AB0FAAB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3361C80C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096E8236A79;
	Wed, 23 Jul 2025 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QI+dBWLr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B9D230269
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297404; cv=none; b=j7TqIFlbT6yLfUhmzEMUxQ/c/UA3KrDACZIttgch9Ql2ZQQBSo66hxOfJu1B+Ld04ZFxsnZnL1j7ytM3YH15dG4tNNqE24X9uzejghaQeAzaMLIdhsx4hT4Dh7aQWjmRI/itkpDOU/y8WrlHCL3SvUVHiyogwpNorl5hx67sWKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297404; c=relaxed/simple;
	bh=5ea0Z5iW73aQbfmp3MXeFXInCTR/m6Xn6x8V3w9GG+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaqurSZda8vbTAkxOQ7KZP+PevV7b656ytJo33HQUX14zjbDVVEoEDyKjM5zbjtnVyspWeySNygsyZ2KSbkwWG8W9iJaSUCufqD/mihP+WDHrGAaaYpM9WlTeqe87+f81sfyvXkP34pQEcM2VWGtIPk9KclFZQ2AqlnQFvEUMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QI+dBWLr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NH2I9S010846
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3JeOLC/VutJgCxJf2dGFWjbm
	lsKNIl0elH7h0M89g/w=; b=QI+dBWLrdZXvYiJUQm8wJwIKWRPJMfS2lDB6PdgE
	vBEfa9P8C8kQ283BY4qbgd6k81mgh43p0ih6ufhVACuL+sMXXCpTBjpSG98zS/bA
	hH+o0/6XfBCUUgTCqX1pcQRTpOLn6yTdaq5oOYfsUn/HUs7puTtfW3E0omVpLwgM
	JJZnsClG6u/qGbUrkGwZwT/F8ar71EaZGnYYfn4k2cgVKWfOd00llIBqArDSg2+s
	53aERgpWRL1paTOKSzOxtAwM421zKtXEFhxRUdUp+cnGFtrdxgQ1SwqnJHapASXo
	/jNpKxVSnwGQH9H1OO6oFverNyon8UQQMd9KTdRgpxCCkA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na4r2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:03:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70708748fbaso2707726d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297399; x=1753902199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JeOLC/VutJgCxJf2dGFWjbmlsKNIl0elH7h0M89g/w=;
        b=TRNIUvk0YaiLPnkFE5JXLMqchBqcSTUlCc51pSzgJ3cIJoJwJcQhlv1I0FBG5O/nE2
         FCIgb+z+J/bZEEr+K82ypewcmlD8SlZTyim1P+V3m33bckuCYJE0/XkP7uPsS5IiR4ig
         WsSTwaIfFYNHJQtAmvkIhpaHR9xh8MRHskjNRtdSL+7/dG2bArw5+h2dGdRk3FUVvQrh
         qcOI2Kw+LtNXxifRbGXeAtV8fjQZ67GKY4TmoKhmI+s6UA3a2MDbs9E9tZ9cJCsO53LT
         kmjaAnuVkTJ4euV30KBn9lFk046XOLXL8yECcIgCZhlfE4k8eDiPJbaPr1zz0jF2qjsP
         8N9A==
X-Forwarded-Encrypted: i=1; AJvYcCWHWkpp19PfQalpmwaxkLGUCWQlY+JeUBUTLoI1fJcNHhxvcEDSdOUTf74AO4gqjTXcowNnyZ7qrhpQN/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTDxQg6FO1en/htheqQPRwr1QHKd85/UCnSu+zZ/QVBusNoPau
	z3sdawHTVMyesBOh0lmcnU56cz2Xf5vkyGY6Pz+XXQnkh5zE7AIyGsKgBi3XL8o7o4FMyVDctY4
	zz754+b6vzsBELrqZpW5449qkwGIqkO/ktdMFUbW5I3SniDptF6GIIEPHRLuAKC430rs=
X-Gm-Gg: ASbGncv8mpIDp8YXHEpgOLbmff4I/W9Xylpy6AWrXwbojPgkjb8C2+4buU9o8wme7y5
	vvqNqZuOacopElgZIueYRvLko63e7uLTyz2ruz1ljwBIYtIpsUL2yhBwYhFqkW/b3iRth90DV6H
	xqu+QApD1cuNzV9cnv6Mz/G0ahHatlEiX7dcVFuNnIkbPL3JerCgDVvgn0BZ2ja1YetPmMdImMc
	tPL2TV+0CvC/B+z+j8WJKYmCdz/YH9inQcm2WF4l8HUozsOg1MZUcNk2d8wAo1t1I2gI7jLAjzC
	o/N7lpvJ83fyzE5Dm/kZwxOC8kxp9Minh0KOCbo3K7O3EIZ7MxHy7ANhpcpKiXmJqHpVVIJpVoa
	k076tXamxcA4j+HBPz+fnoiqiGsR/dWrLYqLQtsBDAU+SFF55WzdO
X-Received: by 2002:ad4:5942:0:b0:704:ae41:df2e with SMTP id 6a1803df08f44-70700789c2bmr52781676d6.43.1753297398642;
        Wed, 23 Jul 2025 12:03:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsaankh/5EYi7v0dpnHuuH5wHWyyjdX2jkQSgmx1+drNNrAFDbQTC/0KMBPqf+Exsye9uSCw==
X-Received: by 2002:ad4:5942:0:b0:704:ae41:df2e with SMTP id 6a1803df08f44-70700789c2bmr52781206d6.43.1753297398112;
        Wed, 23 Jul 2025 12:03:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1475sm20370161fa.53.2025.07.23.12.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:03:17 -0700 (PDT)
Date: Wed, 23 Jul 2025 22:03:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: ubwc: Add missing UBWC config for SM7225
Message-ID: <blibzpqgbjbbwvnsx3cu3fzjxk776lamnmd4erokc5jx7qkubh@7da6ihmb6xxj>
References: <20250723-ubwc-sm7225-v1-1-d688caff70f1@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723-ubwc-sm7225-v1-1-d688caff70f1@fairphone.com>
X-Proofpoint-GUID: A9LTlODjZPAVP4g0-4txyYxsGQVNYrEI
X-Proofpoint-ORIG-GUID: A9LTlODjZPAVP4g0-4txyYxsGQVNYrEI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE2MSBTYWx0ZWRfX51xcKxykMidP
 w2f0Ivhlwnul1TUf5e0i7nJt7SalayNeXA4vmm8QUWBNWKm8nOpHn/xAJd9QmnsvVnNEnmJtB2G
 6WzsqAXHRhvCoLWGfBLmRdGZsN4fbCrXA3d4gVAJ5Li5P3qG3el/rwJabIYoInoGie2FRJEZhsL
 hQLcnvXPjkFdl+mENIlBwtizEBBRteCmBF/PxzljKiGlnzKzebfflyHgscm1NistRV4FHGd10GU
 7AA7PlVwIYeHaNwhtwf6otjjLMHfF1oMaIVHzEY9GhyH8yhr3rIxKzvkmIAcy/sEbTxKLn2OCEj
 eoWx/mABW3xKFpd1MH41atKXsixsCJpecGp09l4NtUW7qjIwP0mLId9Ie4ID58phSHjfuONUpW9
 X2zen2IMxdx0MkHTKmLDBGkYcjOM9W5dL3MGkj8s9UMYRn5JIAzeUvW9PeZePENX/sVyFOuX
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=688131f8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=0w4he5-zLxu2L8T7xFsA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230161

On Wed, Jul 23, 2025 at 04:19:22PM +0200, Luca Weiss wrote:
> SM7225 is a variation of SM6350, and also needs an entry in the table.
> 
> Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Note, due to other bugs on next-20250723 I couldn't fully test that
> DPU/GPU are working, but this seems to be required in any case...
> ---
>  drivers/soc/qcom/ubwc_config.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

