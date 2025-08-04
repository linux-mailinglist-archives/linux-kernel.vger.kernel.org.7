Return-Path: <linux-kernel+bounces-754734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875C6B19B95
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD7AB7A2740
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F3122F74D;
	Mon,  4 Aug 2025 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m/x96F+L"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4017DA6D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754288942; cv=none; b=ibSSIclwRFJRl7lWKSB4UpKftMJVBFzghtGAMoh/TSpbCZh1P+A9OzN9y0J5naLisUFQKwHJPwYDpHKjDhU1EgI8qZ+CIO87Dt4xcylhbgRIhMD9/3n1TBXsZpkz7GLIxuk/KHAKLuULuMZpu43SOr39teeNaO8norPPqVhBqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754288942; c=relaxed/simple;
	bh=UVq2TYOD85H1Ja3HHtmHivG3lZLMpy0pM635ppWjNoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBGawhXHOu+CkVNEHaekCIm5nDXCvSYeSUmazuiNzATqoTU0p829D8oSZVSWlayq91O3kQPjZbemiGnNzvJUhJc/RxATZUgvh+7l50vSH11Q+DNPwWKuyMcMTKpPiRg6YhczZvrK4x3MLTqPiiQaI+FzRCdLZuoNeFaegT860/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m/x96F+L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573NcUuj024035
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 06:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pvj9BgUvYssblNJ8rcEOnc8B
	tkYAnDBzYEMRah/53Tc=; b=m/x96F+LN4Wq5b9UUP+UMMwbiZ7orvW/7Z/uanHD
	gOUCt0v9TeGEk3MYXR78S1J7LqLhf2kiWVUC8FYwMr4lL4l/luwIj7atHGQG1h0r
	3/nFJtCVALTW4w/6G4ysldoXP/n9CX8DmbKIMMj00CrDPoEgYNQx87I0tP8Kjz3t
	qM4bEQ84v5onmlogNMMVeya1fyqX/3j75lAdI85K++j6/7ZK+ePgQnbcySi6W//E
	yTznV0kKxcaTstxuaodpEmWrhWM4drz5dQBQiQN8Vkl/wTtxSXnmZr2bkpe63swP
	TbfAquKzYZf/hXKeq6+uZPC2r3j+nyw7WoswLrVeFhJs1g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489b2a3n3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 06:28:59 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7073a52a800so72899956d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 23:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754288939; x=1754893739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvj9BgUvYssblNJ8rcEOnc8BtkYAnDBzYEMRah/53Tc=;
        b=CKzCdXGfrsCm4Cl7fsN5UaMHCwX059kY/NBJbikVn7g0MAQUy319HKciP1fDNSUsmr
         lMZS4Kgxkv5HMfM86EaVgsA8mx/00rOd7O84FjDQ8Ys9lX23UMa0+SUulpSHqwsbU9yF
         Ho9IxfE0VbZqY4b97coXWoerafieSXuF7IS0FPlR4Vfnoi1AC6lV/fGhD10Lh0PCUkw3
         vI00jArNt89bz3Sv4VkXvEhJN4DinYH4RbhzsBRI1yFGOHPsgLgU7nm+h9UkHtM3t6rx
         Z7een+ZvFekXA4oNXJKCD+AlvE8ui/J7hgYybiUnbNJ8PRiE1WNC0IGtvFj/wTnNRZ2s
         H6pA==
X-Forwarded-Encrypted: i=1; AJvYcCUrFpto9Jvkc6sx2geQF+VEGm1qCYNt+a1iiG1V81ULmsgpUL5+kQdBZ37kRY+6o2iWoHmI3g3cpXUrgTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYHbMTpZcKx7q0tUa/iArD6zUADPXOnuNNiFFWQfIpZYPEeznG
	1rKS9W/14QCOCBzoIx+IyqEsafHTt0AOcUjk5Z8HLOj35vieYrC+g/9SGa9EpLDYyYXUhiMPvQm
	4VUzh9TLKyAvjJ8j6FFpCIfUuQX5Ka5Bj7D7AGuEbFKPL32CYfDj1OVQjigtG7HP/LXw=
X-Gm-Gg: ASbGncsz8XKVRYGVu2QPePFFMOMPZeLYTM+u4h62uz76JvKF0pipJDBmh1egCslixI1
	+dnFoRFJSZDh45hYjA2gWQUIRAcxyCq/hWhNtzyMSSZbkm95SdvG+9ApPQ4PmkRyJyyBonKSzPt
	xpXglG9U8Ot6jg8RYrtu14GUW7rvRH7N3U7RKLshqvf6IB6m0BDHoob84NCNcBDj7Pcn07kdm6n
	uVz8JrO1rIAV6tcXsRLmxK4Oe3i2jLRLDxih14uKd3xSAUAgdTY13UG94tLqbfKJF+hwrXgrPOK
	Gh5WB+Iscam7EQwBEcbvY87v7ssSFYzt+Qmpju5hipxGBiz9Bv4EZi3VCc/bqwItrHNRlaedENf
	6ri2DhAdFTbvXV+Oo56knJoHBtyn5Mu0QeCgKdQuENlcF0FQVtfEw
X-Received: by 2002:a05:6214:2aab:b0:704:f956:667b with SMTP id 6a1803df08f44-7093637adeamr137156796d6.50.1754288938653;
        Sun, 03 Aug 2025 23:28:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH63vqAiisY6ETkheNsOB3qX+bnOLoYkIMhtnNsFiAj6A8wRDCiRqE+gB1mdnw3opOn+XtSiw==
X-Received: by 2002:a05:6214:2aab:b0:704:f956:667b with SMTP id 6a1803df08f44-7093637adeamr137156646d6.50.1754288938205;
        Sun, 03 Aug 2025 23:28:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272f28sm15151501fa.10.2025.08.03.23.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 23:28:57 -0700 (PDT)
Date: Mon, 4 Aug 2025 09:28:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] arm64: dts: qcom: qcs615: Add OSM l3 interconnect
 provider node and CPU OPP tables to scale DDR/L3
Message-ID: <bsrhqkrzdapg72o6h6yx3pw6fjeseolt7zmq5fpvfhhdg7ktyv@zz3ueam6lcqh>
References: <20250804061536.110-1-raviteja.laggyshetty@oss.qualcomm.com>
 <20250804061536.110-3-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804061536.110-3-raviteja.laggyshetty@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OKwn3TaB c=1 sm=1 tr=0 ts=6890532b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=PxBRM3sLOaicz7rGac0A:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 6pUadPceyPi2RhsetoTlCi-5RRj9kmqc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAzMSBTYWx0ZWRfX4WRdw4/xwK+b
 chzlteZifjVRYaH8e4a6KlEKqqjmnX9e+tCE6w3uY6UM3yekpHhAAUwt9cipUChmIs0Ulmtw9To
 FQkVx6qhU/YZJ345KVKOqw2FbILW/kcoJ52Do2Itguc5Wo+d+1cid8B3jSV1ElVuHUo3+irmFEg
 qu0P8FY7e7Ld7P2xVWuuvuUrr1JIGjfWXfKBqFUvDMOYJoPFBFcReaqu6RWVLNBaG3L5BLv/B6o
 Powyrv61zxAexbSmbEcXlJxBbDY2zlgyK7Iax2c0eILAk5hFmBI+XDdmsoIam3Q5h3aIoqoa6tw
 wfmWPXm/32+8IpXHpd7APPTPKUof/GlejuWRePEKCKwHzY6oE9gLxMNs3QbrN49VGu6DWeEIbzp
 LpTkE2bn7QBj/cViRgpsWhoAR7XUjhwkC2OEkeqmfL/+/VCVCMFhuzG6KSPCJOHi4y6dBQ+d
X-Proofpoint-GUID: 6pUadPceyPi2RhsetoTlCi-5RRj9kmqc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=967 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040031

On Mon, Aug 04, 2025 at 06:15:36AM +0000, Raviteja Laggyshetty wrote:
> Add Operation State Manager (OSM) L3 interconnect provide node and OPP
> tables required to scale DDR and L3 per freq-domain on QCS615 SoC.
> As QCS615 and SM8150 SoCs have same OSM hardware, added SM8150
> compatible as fallback for QCS615 OSM device node.
> 
> Depends-on: <20250702-qcs615-mm-cpu-dt-v4-v5-3-df24896cbb26@quicinc.com>

Yuck. It's not a way to define dependencies.

> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>

And the comment regarding SoB chain wasn't addressed.

> ---
>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 148 +++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 
>  			};
>  		};
>  
> +		osm_l3: interconnect@18321000 {
> +			compatible = "qcom,qcs615-osm-l3", "qcom,sm8150-osm-l3", "qcom,osm-l3";
> +			reg = <0 0x18321000 0 0x1400>;

reg = <0x0 0x18321000 0x0 0x1400>;

> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> +			clock-names = "xo", "alternate";
> +
> +			#interconnect-cells = <1>;
> +		};
> +
>  		usb_1_hsphy: phy@88e2000 {
>  			compatible = "qcom,qcs615-qusb2-phy";
>  			reg = <0x0 0x88e2000 0x0 0x180>;
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

