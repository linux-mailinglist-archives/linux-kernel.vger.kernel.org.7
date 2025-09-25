Return-Path: <linux-kernel+bounces-832899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA66BA0B32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B96189E7A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E916306B0A;
	Thu, 25 Sep 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lU5Cu3CF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5652C21E7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819093; cv=none; b=PBWe6iqWzltYW7wQd8IdfKWxLPf8Wny2g3A1OUajgHIeJnm4DirvMuabzHEl/UtIVgM6WXeOnA22lONrPDJjDGuLOitiOd67560kn6c/v0qAsqSGnlZ9PM38n2gnJh+47gCkYfiXxlST5nhCryiG2LbYqYSEZ4r7ZtfHXEHPHN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819093; c=relaxed/simple;
	bh=S6a5ag5L4g7VdPjFvaTg47WUro1fnBjqK7elHYvqxSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0U1fFzwnDfEsquuo65kq1T5QDgJwZve4nvYGPqUBFUZ17vzkNrmNUQvhywl/4AW8S3arU8T974oNAoUV9yIvcHo3vgu3MUn2twCv1IUx5U16cegXR+jIpN/Fk43AFu9iJNaHSnKp+OwnDNZFmE7ohcpbLJ3InoZKTOYimhmjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lU5Cu3CF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9KDil017438
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=c+JG/OhuIQPupywuY6KkOajV
	6jlmXSzIcLrtrmBfD70=; b=lU5Cu3CFo0GDvXb6ni7MhbGvqQwQx269+v+IEbE8
	m3//IfinKopHPg2FX5A2k/nfImgwuoIMEYrgKPV8S19EqoqwRnjlaRhg0kiq6Ifw
	cI8YmDFqZWZGWGVZ1U6peoR1SLuMiH2vc/lBJGTLS/YPw5e6fncgzKZ7FDxw5myj
	/KTnpJJh4636GbkZVpf/S+Drm7qPYAZfvo+aMyYrh4R2NSVNhm7nja7gOLQtv9pY
	FBE7HHofWvz5SMoIwCN2c4yt1zIjHIKa3wkafdOSB5sjPbp3eNYRDqLkNQcs2E+t
	NtjLFO05hZ/+/lrZQlq+PSqR94w36dF9O/xY0DLcRR+wVw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvk281w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:51:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ca4eeb9b06so28169101cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758819089; x=1759423889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+JG/OhuIQPupywuY6KkOajV6jlmXSzIcLrtrmBfD70=;
        b=B2q45ZMpyMgcZT1UYdQCOEnMomHqcejvwdpaqYCcBmXQttCa38ZVJJlLVself2MlRG
         Pvu1VQIu7eRk11fjE6nQMHpBW6gmvzM3q1Lx98chnuGoetHqDCkoYNGqJ59cwZWKqYbz
         Zp/yz2ZZoaHB5AIzCrKYHjttZGgkzVgeIp12e7NWovw0qX3NpvOkgJbTERYf+ybOl8D9
         2vBtT3yc62TXHBtK+nMrCzVSzdjxauCl5lkKyzBx0pUadI9NhoY55RsaE1UiveYJwc/i
         SNgj5+saot38I//u3MyWw6IZis0XuZIOBMc/9n99swjSLZ4CN8sCMpmWJM5Y+VTLKTE5
         zX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYhhwlFGuEwWRyBuYvMW0cOqVm4X3gwvjF0Cl1UeoMgwZy5GtH/DI9K7C2WwlGIAlPFpX8SDYhYIxlHLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyslhrMNFLpowIdeyNMk7FExKg7PFSAdbcnXzvjzBbt8XQ3uYNY
	Y0bw099nI6EK7xcjtYtiswkU7HcoS5J6uEridfDJPZ7DUsFbxfXg9QiN90CK9LFDsBuywe8lBt7
	ZvVmHhm3sH6yKxpD2tdWqQFisfjzKZdFRADGkAOs5sWR006pygM86CGXrQF+s16lbc0U=
X-Gm-Gg: ASbGncsBvHMdf2cxRt6WjJP2H/aZxoiqWDNjWBtO337zEFO542hsK95VnvA48WRPunQ
	ymZsrUTlk1a57zDzv10ikovmWnci7oXHCBM7jYI09bi4x1hf2EFLnrxuFkX+sWlc8bbcMF3yixH
	2A/FsyQ+bq7FvOzOC5k4ARSYQLSZ3Gjb8NOnjAnJhLunzd1WEHs1eRCtUUsMriGxtqe1FEMpSMi
	Q6PVlDUqbnuhCXylYgRNwX/bHg+leyEbLrJtOlah3paDTshknU7HzfoG8fOhaozYh89Bhi5Vgkb
	7fcOkNE+YJNaFlnP1Uwo2or5Dk3IxykyrWwPigE4K2eNwfzBSeRv6e/4YvUh5VDWtn6yxazyv39
	XMR0WxQ7VwI0+yc2f7s1JOPxRFAGRaxKVuJgeJYe+Y7VEpL3+ZHxm
X-Received: by 2002:a05:622a:4015:b0:4b5:e8ae:2c4f with SMTP id d75a77b69052e-4da4b141621mr51886911cf.51.1758819089033;
        Thu, 25 Sep 2025 09:51:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVLyOb6HzBw7NE0KYW6ReZtLk4APwH1tqa4Vyy2rWMVoaQRkN28lYQtae4HFZZ6flWO3/88A==
X-Received: by 2002:a05:622a:4015:b0:4b5:e8ae:2c4f with SMTP id d75a77b69052e-4da4b141621mr51886431cf.51.1758819088411;
        Thu, 25 Sep 2025 09:51:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7710474sm6418341fa.33.2025.09.25.09.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:51:26 -0700 (PDT)
Date: Thu, 25 Sep 2025 19:51:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Tengfei Fan <tengfei.fan@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
        trilok.soni@oss.qualcomm.com,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        aiqun.yu@oss.qualcomm.com, devicetree@vger.kernel.org,
        tingwei.zhang@oss.qualcomm.com,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Manish Pandey <manish.pandey@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        yijie.yang@oss.qualcomm.com,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Subject: Re: [PATCH 00/20] arm64: dts: qcom: Introduce Kaanapali platform
 device tree
Message-ID: <yjerom55r2jc6afqslzqfwgpq47dl6qmbuuofqrerchugnqkso@od53xmgnsyen>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <175880948892.820179.14957034733872726075.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175880948892.820179.14957034733872726075.robh@kernel.org>
X-Proofpoint-ORIG-GUID: vMhn_Srqn6RWcEvy31UouPjLd8rkJ4gj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfXy77dMFeGsSQt
 /ZTfiJFRgd8pTW69PIayLHsnHZaVs3VVwST9xp9rOdVLikXEdU4cxhUL/H5JWeWIlsSboiWn9Uf
 6aBW0P6VIYDYVoJjLws27fGE9OKJzo/Wx58NB1lBwuPMrcNym5jewHs7bw9/5EcXTiYaLu+vkFl
 Uhb43g/lZ37yG/vw9MHHfCXLWokvcd4zTDhlVzXkERNGIkoz12tI+VoYJJo+dMmE1SVS9kGStLk
 6hpd08CdcISlHdqN+B+8grKISUTBEW/CmaqB2InxAlnzWt/DjayB59uKci1UpwMtd19fbv9/FN/
 Bx1waOAwTto8b8u6KoQRi/viVP5EZOc8XaHjGTG9woxjqx5U0mq/Tltxn/wlNlUPXb5PBFqlD/6
 yvRRhiym
X-Proofpoint-GUID: vMhn_Srqn6RWcEvy31UouPjLd8rkJ4gj
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d57312 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=qC_FGOx9AAAA:8
 a=CYqfMpDs-nAaQ_9fh9QA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

On Thu, Sep 25, 2025 at 09:12:30AM -0500, Rob Herring (Arm) wrote:
> 
> On Wed, 24 Sep 2025 17:17:17 -0700, Jingyi Wang wrote:
> > Introduce the Device Tree for the recently announced Snapdragon SoC from Qualcomm:
> > https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdragon-8-series-mobile-platforms/snapdragon-8-elite-gen-5
> > 
> > Bindings and base Device Tree for the Kaanapali SoC, MTP (Mobile Test Platform)
> > and QRD (Qualcommm Reference Device) are splited in three:
> > 
> > - 1-3: MTP board boot-to-shell with basic function.
> > - 4-16: More feature including PCIE, sdcard, usb, DSPs, PMIC related, tsense, bus, crypto etc. Add QRD board support.
> > - 17-20: Multimedia features including audio, video and camss.
> > 
> > Features added and enabled:
> > - CPUs with PSCI idle states and cpufreq
> > - Interrupt-controller with PDC wakeup support
> > - Timers, TCSR Clock Controllers
> > - Reserved Shared memory
> > - GCC and RPMHCC
> > - TLMM
> > - Interconnect with CPU BWMONs
> > - QuP with uart
> > - SMMU
> > - RPMHPD and regulator
> > - UFS with inline crypto engine (ICE)
> > - LLCC
> > - Watchdog
> > - cDSP, aDSP with SMP2P and fastrpc
> > - BUS with I2C and SPI
> > - USB2/USB3
> > - Modem(see crash after bring up)
> > - SoCCP
> > - SDHCI
> > - random number generator (RNG) and Qcrypto
> > - tsens
> > - PCIE
> > - coresight
> > - Bluetooth
> > - WLAN
> > - Audio
> > - CAMSS
> > - Video
> > 
> > For part1(patch 1-3)
> > build dependency:
> > - tlmm: https://lore.kernel.org/all/20250924-knp-tlmm-v1-0-acabb59ae48c@oss.qualcomm.com/
> > - gcc: https://lore.kernel.org/all/20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com/
> > - interconnect: https://lore.kernel.org/all/20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com/
> > - rpmhpd: https://lore.kernel.org/all/20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com/
> > - config: https://lore.kernel.org/all/20250924-knp-config-v1-1-e2cf83b1932e@oss.qualcomm.com/
> > binding dependency:
> > - ipcc: https://lore.kernel.org/all/20250924-knp-ipcc-v1-1-5d9e9cb59ad4@oss.qualcomm.com/
> > - smmu: https://lore.kernel.org/all/20250924-knp-smmu-v1-1-c93c998dd04c@oss.qualcomm.com/
> > - pdc: https://lore.kernel.org/all/20250924-knp-pdc-v1-1-1aec7ecd2027@oss.qualcomm.com/
> > - cpufreq: https://lore.kernel.org/all/20250924-knp-cpufreq-v1-1-1bda16702bb1@oss.qualcomm.com/
> > - mfd: https://lore.kernel.org/all/20250924-knp-mfd-v1-1-6c8a98760e95@oss.qualcomm.com/
> > - watchdog: https://lore.kernel.org/all/20250924-knp-watchdog-v1-1-fd8f3fa0ae7e@oss.qualcomm.com/
> > - llcc: https://lore.kernel.org/all/20250924-knp-llcc-v1-0-ae6a016e5138@oss.qualcomm.com/
> > - bwmon: https://lore.kernel.org/all/20250924-knp-bwmon-v1-1-56a9cdda7d72@oss.qualcomm.com/
> > - ufs: https://lore.kernel.org/all/20250924-knp-ufs-v1-0-42e0955a1f7c@oss.qualcomm.com/
> > - ice: https://lore.kernel.org/all/20250924-knp-ice-v1-1-1adfc2d9e83c@oss.qualcomm.com/
> > - regulator: https://lore.kernel.org/all/20250924-knp-regulator-v1-0-d9cde9a98a44@oss.qualcomm.com/
> > - misc soc related: https://lore.kernel.org/all/20250924-knp-soc-binding-v1-0-93a072e174f9@oss.qualcomm.com/
> > others:
> > - socinfo: https://lore.kernel.org/all/20250924-knp-socid-v1-0-fad059c60e71@oss.qualcomm.com/
> > 
> > For part2(patch 4-16)
> > build dependency:
> > - ipcc header: https://lore.kernel.org/all/20250922-ipcc-header-v1-1-f0b12715e118@oss.qualcomm.com/
> > binding dependency:
> > - pcie: https://lore.kernel.org/all/20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com/
> > - sdcard: https://lore.kernel.org/all/20250924-knp-sdcard-v1-1-fc54940066f1@oss.qualcomm.com/
> > - usb: https://lore.kernel.org/all/20250924-knp-usb-v1-0-48bf9fbcc546@oss.qualcomm.com/
> > - remoteproc: https://lore.kernel.org/all/20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com/
> > - tsense: https://lore.kernel.org/all/20250924-knp-tsens-v1-1-ad0cde4bd455@oss.qualcomm.com/
> > - crypto: https://lore.kernel.org/all/20250924-knp-crypto-v1-0-49af17a231b7@oss.qualcomm.com/
> > - bam: https://lore.kernel.org/all/20250924-knp-bam-v1-0-c991273ddf63@oss.qualcomm.com/
> > - spmi: https://lore.kernel.org/all/20250924-knp-spmi-binding-v1-1-b4ace3f7a838@oss.qualcomm.com/
> > - pmic: https://lore.kernel.org/all/20250924-knp-pmic-binding-v1-1-b9cce48b8460@oss.qualcomm.com/
> > - pmic-peripherals: https://lore.kernel.org/all/20250924-knp-pmic-peri-v1-0-47413f8ddbf2@oss.qualcomm.com/
> > - bus: https://lore.kernel.org/all/20250924-knp-bus-v1-1-f2f2c6e6a797@oss.qualcomm.com/
> > others:
> > - fastrpc: https://lore.kernel.org/all/20250924-knp-fastrpc-v1-0-4b40f8bfce1d@oss.qualcomm.com/
> > - spmi-gpio: https://lore.kernel.org/all/20250920-glymur-spmi-v8-gpio-driver-v1-1-23df93b7818a@oss.qualcomm.com/
> > 
> > For part3(patch 17-20)
> > dependency:
> > - multimedia clk: https://lore.kernel.org/all/20250924-knp-mmclk-v1-0-d7ea96b4784a@oss.qualcomm.com/
> > - config: https://lore.kernel.org/all/20250924-knp-config-v1-2-e2cf83b1932e@oss.qualcomm.com/
> > - pd-mapper: https://lore.kernel.org/all/20250924-knp-pdmapper-v1-1-fcf44bae377a@oss.qualcomm.com/
> > - audio: https://lore.kernel.org/all/20250924-knp-audio-v1-0-5afa926b567c@oss.qualcomm.com/
> > - camss: https://lore.kernel.org/all/20250924-knp-cam-v1-0-b72d6deea054@oss.qualcomm.com/
> > - video: https://lore.kernel.org/all/20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com/

Please separate the actual dependencies (the patches which are required
to build the DT) and all other patches which are not a real
dependencies. Just adding a binding is not a dependency.

> > 
> > For convenience, a regularly refreshed linux-next based git tree containing all the Kaanapali related work is available at:
> > https://git.codelinaro.org/clo/linux-kernel/kernel-qcom/-/tree/kaanapali?ref_type=heads
> > 
> > Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

> > ---
> > base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> > change-id: 20250918-knp-dts-0e8da3f76e85

Oh, you are using b4, but you don't use b4 prep --edit-deps. That's sad.

> > 
> > Best regards,
> > --
> > Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> > 
> > 
> > 
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
-- 
With best wishes
Dmitry

