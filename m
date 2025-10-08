Return-Path: <linux-kernel+bounces-845851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F90BBC64CB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E750F406503
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733F12C11ED;
	Wed,  8 Oct 2025 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eDuVItXB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7D1F9EC0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759948327; cv=none; b=GsV5c52JU5II4uLMJRf3y38wBC26CPAhKH+ROA7qgYJKJ2jLFGtmx8Nz6Gc2ZUixkASZNye8+o6L91emOiO0Uf6rzGNzG76Oe/yNMWVM/YJdEPm75+mPC7Qj8cY6ZDX0NFVhxrn/R+P5lFvxaqJDDw+9qbXQTkLWAddoLxD1Jow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759948327; c=relaxed/simple;
	bh=25FN7DjXP5x3tJCg+gQhzwRMzdMByaBgob5iKkpDksI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNUyKZJ50xl16XivOBQpui+DozA73UBNB7gGcp+tK83Io+WW648mLRHsAqiKKwLjNfVMyZ3Fk9edcCFHTnI2lZMM1iUuACphTmKalzoONed+y84/bUJdfbHETlQd86S7bFItUgGmAvmA7d+UodXE0WIZpoTcpDPNu6q589A8JCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eDuVItXB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5JZn008739
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 18:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Uqwx5jDVnMd++8p09CsvgmiE
	n2SAfFQqSRGWKLGynvk=; b=eDuVItXBQkSAJMKmpD7Ml8AFWA63pV2T7OLovBMb
	yYlzNYq18nj9jRKbRrYZHPxXf4ptpan0PFLbgo3PGJu7vmMAsNUrJnwtDucYB63t
	Cl9sW1SOtkd80EZ2Dt6AZBHNYtz3vM3DCdX5Rhg0SzRxH1eEfaJ5KYZNZ5Tr7tbs
	xFKjORaGzWiJkBtIZuTgnNmfpGA903z8xxrviVBD86tTpzXHrCuvSeUCHqiEX8ov
	4TYvXxWyq23t3Kw8953QlMWb4oNPASQqiqyvzV9CdVHj3jVbpZJ3LKdePuf1rfT2
	dsP+aWagsR8xNLa2RIgz07Hv+eRwSyZRp5pvEZ4Rj3ZizQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4n87yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:32:05 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-55230b223b5so184669e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759948324; x=1760553124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uqwx5jDVnMd++8p09CsvgmiEn2SAfFQqSRGWKLGynvk=;
        b=aliaHuwp2GCXOLwNR4xEu2cnX/nqHLUYi5X6TtAgSOpfd1f1XlcEKMRkss27tjlat+
         h1nNIg+UMXesgilHqEbvPJXy8roPyAdlZCmzOSmhermbTRA3CKP7KEZq9gIHLDcbPjaM
         dw9PuGRS8fqLbd4q3b0znXzyiPjBgzrnH0Ve1jur3Iwg9CkOKdhHPkV9TqF94uYhrigW
         V7IxXUmhraY73nZ/O/xHNy0XLVvY1tP5YacEyVqcEbubO7+gsuYZpLvep/VfcMAt2B9S
         ta6tdFVZkOzABT3JDFJu5ssiATDYWDm7KaEtii5TG1W342amBw08IQp2HacaLneSsoOJ
         1DGw==
X-Forwarded-Encrypted: i=1; AJvYcCWo/GyH5AWoJKTJoslY9UH/N5zwTCaz6wlH9Cf0DvCHCNOpEpRrzbMzjR6X8T5SysEW9JztMOyAiJQ3+W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHyN6NljmIO/0tDuvqKjJdfD6+cAkdo4t3Yw/PvmubrTYhA41D
	dwgaeBCQCFJhLl24Po2pgVaqHS/TyeLmcc2djLh87GscZJNuiPhdQt9hJGK6Lpdhk9uYBfiQMov
	5RbrRazSx+Tia4nB+zYMhPxzyNtRbrh+iAehXEY0OEAx/hflfxtfPF0LhfERFUdNRa08=
X-Gm-Gg: ASbGncvCP+IeLsuQBMT2bYrbHDPn4YdSa2gBCGee0GBZWneZJ3CLHIbQ56g8hu5Y62J
	yQJZA4EGI8E2gm9vlPy6fzQWm1l39m8nhgFGVZYcrkVAiHSuS3UPsBuoWM5/ljuMyG5xoJNMnMe
	MNdDi3aoroiHN+UMJ/STgFABYvBHvq91gdo4/S6MKrTwLBs9PsTtowiFDbKkYFIT/LJEXpblpm8
	YBxZ2QyDWNte8uy62Mpe66dIHA7QUoebc1aZyffCIJQ2hfROiLlgNSlDKLu3SWa1L4OrlYOjKqH
	ddFJJ/ysITsUzYtkRbuKKBOXGzM9oHW78feQ3Sk+j9/uVR6WjGrYbJKdM1TI0ohQYC79PiK35Fs
	NsbrE43zm/AXkCKHOP/NfFNOzA3Nav2xd63uKcCdTAR8f3CaH2uEO9sw79Q==
X-Received: by 2002:a05:6122:c85:b0:54a:9316:f429 with SMTP id 71dfb90a1353d-554b8a7f865mr2116606e0c.3.1759948324126;
        Wed, 08 Oct 2025 11:32:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeridrpdJSwKBLLKxqzplda/MdVxnX9sdNhyATyFOKBILM1gJTPYRMJOlDLg9eqNSXDqCRYA==
X-Received: by 2002:a05:6122:c85:b0:54a:9316:f429 with SMTP id 71dfb90a1353d-554b8a7f865mr2116589e0c.3.1759948323654;
        Wed, 08 Oct 2025 11:32:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f39fcafbsm22678541fa.26.2025.10.08.11.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:32:01 -0700 (PDT)
Date: Wed, 8 Oct 2025 21:31:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for
 VBUS based on ID state
Message-ID: <odikli6rfdyid5oqavurtqytgnwgh5hpmka2jt5tprpdw7cd72@icpnjnkfowt7>
References: <20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com>
 <20251008175750.1770454-2-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008175750.1770454-2-krishna.kurapati@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e6ae25 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=smUmI0uzo1bZzf9w9C4A:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: aDWqTxuT5gxCngKG38QtbrC8J2fvrc6n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX2ovabVU+MQDP
 R8KIiiGp8FFpK961DlHxgk8PkIDs7ZkOJLZ434Dn7r4htSXi3SBYG09reQOW5eL+dvFbMS31vSf
 fLj/uv34JxS9AlUeQ528jSNkhiaZKnCkphbWDk821i1axqh89kzF1H/UFX/+Ymz+Q6y4yY0pw+R
 t5feH6p6KS24ELGGiy+EOm9Ol4U3f/Bv5tKrOMkE6h39GUUADXYzkV63gTOq6gPZdRxxUHrXtW6
 NyPfoV2IfxVIKclRJGXLfSNva4abddPQI0S986/08fkHEWy7kkUe4Wj/jIoeP6quZfO+TXpOt9X
 JHKl5gxo+EpxGRbRaUgkP3sjWh8mU5Qf+AWCrrmuRX31fWBgbLkhKh2Y9c+icj06wYwxXZqQhFF
 cmjkC+oopvnTjQiVFcOb26DVVINzbw==
X-Proofpoint-GUID: aDWqTxuT5gxCngKG38QtbrC8J2fvrc6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Wed, Oct 08, 2025 at 11:27:49PM +0530, Krishna Kurapati wrote:
> Update the bindings to support reading ID state and VBUS, as per the
> HD3SS3220 data sheet. The ID pin is kept high if VBUS is not at VSafe0V and
> asserted low once VBUS is at VSafe0V, enforcing the Type-C requirement that
> VBUS must be at VSafe0V before re-enabling VBUS.
> 
> Add id-gpios property to describe the input gpio for USB ID pin and vbus-
> supply property to describe the regulator for USB VBUS.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/usb/ti,hd3ss3220.yaml       | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> index bec1c8047bc0..c869eece39a7 100644
> --- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> @@ -25,6 +25,19 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  id-gpios:
> +    description:
> +      An input gpio for USB ID pin. Upon detecting a UFP device, HD3SS3220
> +      will keep ID pin high if VBUS is not at VSafe0V. Once VBUS is at VSafe0V,
> +      the HD3SS3220 will assert ID pin low. This is done to enforce Type-C
> +      requirement that VBUS must be at VSafe0V before re-enabling VBUS.
> +

Stray empty line?

> +    maxItems: 1
> +
> +  vbus-supply:
> +    description: A phandle to the regulator for USB VBUS if needed when host
> +      mode or dual role mode is supported.

Why are we adding the property here while we can use the vbus-supply of
the usb-c-connector?

> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>      description: OF graph bindings (specified in bindings/graph.txt) that model
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

