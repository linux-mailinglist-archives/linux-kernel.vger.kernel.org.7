Return-Path: <linux-kernel+bounces-836953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C38BAAF66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CD8172331
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A92212FB3;
	Tue, 30 Sep 2025 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YxxpvqUz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD58211290
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759198463; cv=none; b=NGch3svZKhT2bDcT00CkFLfBxOSJjauFEM81uOUJhk0SSf2jWYJzMQnaJkGJTWX1ek3Dpgo4G83m2YZrvBNhGDNGyeVWMDs42tU/TnbggTEyc4YjGBlk2DN4NoWoV+LLcC3q/BAuIh4gW5O3r9u87CKmA0Mt/qs6+lhrjyg9pBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759198463; c=relaxed/simple;
	bh=7uvs9seTMoFJ8Zn+T4ada7u77i+jtQyOgG5K25z89c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuWC5iVTA7+3GHJkE1/9DVpvPSOsnrCD3mHYTXPRVLWwK0ME1LbQkJpM4NibNdiI7P7s9O/ybENpi5RXcYHggCO5FPYc05yI/wPzDUrbAwf8uvvwQdo/60cHfqm0v0YTHMZn+z9X8OABCBBoaw/Qfqe+KVI7Vce+v7kP0rrna2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YxxpvqUz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TIJjKU007059
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0axRjvcMTtr61lesxlwkt6CZWhP8UnUm1b/fxV1JwM0=; b=YxxpvqUz3MFEA0SY
	LFhUzuFXOreuqEuNnX4zfwrZ1jDd4tzXlpGuO64rKaP3uayvz1QYXBtsewY8Kx+K
	ij0HnAMOhZMGnDG9TxovBS/D1A9LWFMT3+CnpNaRomkYTE051p2h8+KafQE0aYHe
	vJMgYe2y9IRn678sM8gV1/Qz6eNbw4VOoTKn96wvJfFIdm1A06LjhOgo8fBIFgh3
	AAK8Vbjo9TS+bonXULzk78hlI9mbDNkxDl8aAZVA8lqJAFBcT8XhEKybDTMCzgVM
	I1eF3Uy0dwybvi0RIVGj16yTrDAM0VqjFCL9GvL4iIa35/TN0dA/UizpxSXQRppz
	7PnPRQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851f82b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:14:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ed9dbba55so1437865a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759198460; x=1759803260;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0axRjvcMTtr61lesxlwkt6CZWhP8UnUm1b/fxV1JwM0=;
        b=lqi++WwHVMqCVfpIyZBFFcQ1E2JwVJ46nmrLKCEXIPlIMGxzXcsmClR3/5akpDc761
         38Uz9cDrlwbiDQHMVwaKVz196aacRkj2h1kYBWlYB4oVUa4P7wfA2yUcaCHbqCHkBh9f
         qSHCz4HVXf8vMB0Epoz7LEr9W6pAzlP9c7SKTH6ZYXOcCIMtIZwx6JqfKis9j8Xplaxh
         LUcczfI+5VTXDuRtZaA9KJHXjgqXRm5lK7YuJx6uZ5YnARqTiIiCg/8wyZ8Pb1fTiura
         avU1iToL2vo3lrI1p8jlIJwc35jGlOD08tsBZPRk76Lpl3+Cu+lp3Y40xUjgu/VXrD4A
         bJCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvEI0PvQCF4Cqdo5Cwh34WGUe3jtRQJZiS8UpZvrfyohK51w20TgQ/tGf6+YTVXtO3DDhK7gHM1+cLvBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJgYet1nPxUDYOiJIrxsymzc6T5MgcyfrRdbCio4yUTEa+RQM
	3LEd9F4itGoYi0zwTNs/ei7htpBLC927daw06Ab1YBFrcysdzwiHVO4aK8qKkT4PcT2OamP+Og9
	Ja+OMP0ro5kh5ztb5fAgcT7TFJ14KiJqCFzuGKM7pSpen2y5ft6ZKRpKyzwtumcc6y5g=
X-Gm-Gg: ASbGncvRrL1ZSVd9R+Fln9tZLj8Q3DHJzXkfs99KySDX0eY4QI4UJ73q0MZrZcoyl9V
	zxzXK49lN30Z5wpS2h72swpv7UNg30ea4zDbAmVEYObswEXXa1LUDxv+JnULFg2RyL+0WY4vc9q
	4kcj9iMNLG7uFYkmNrfl/rnFmegrgHGzuoSUsqBJzO2rHk3fFXcKhURZ3Y5648RTUz7T9+qJWHG
	NVv1OvHHk4DFscr5/P6kZ9bPaV90DvETifkNSGHYc3QY2KmRRymnNysUXUwRlPO+7PLArWfYptv
	OTpaNfgpyH9gmHQ/9KEBonZt4VYh2OAwJFSMVw/RlDIOiIxbjatijhcH1o7wFWn7QaEe4MaLqNV
	KncjexGQLNYKxIgrjuV7kaP4EzJ1nf8T4G+hn
X-Received: by 2002:a05:6a21:6d86:b0:2e6:b58a:ddf1 with SMTP id adf61e73a8af0-2e7ad646203mr13115981637.0.1759198460494;
        Mon, 29 Sep 2025 19:14:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQAguvzHmwUnb+rdbg2sxOcIH3ETIs9YUrlln8TWk77WZpIDKL35m8HuriOIJ/sZKAzh41vA==
X-Received: by 2002:a05:6a21:6d86:b0:2e6:b58a:ddf1 with SMTP id adf61e73a8af0-2e7ad646203mr13115955637.0.1759198459919;
        Mon, 29 Sep 2025 19:14:19 -0700 (PDT)
Received: from [10.133.33.226] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53db8d2sm12386755a12.24.2025.09.29.19.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 19:14:19 -0700 (PDT)
Message-ID: <7d8eb4fc-aeb2-48e3-942d-8aa2cb3aef6e@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 10:14:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] arm64: dts: qcom: kaanapali: Add QUPv3
 configuration for serial engines
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-13-3fdbc4b9e1b1@oss.qualcomm.com>
 <9685e29d-bff3-4188-b878-230d0f161ce3@oss.qualcomm.com>
 <5410dc83-0732-4b25-ba07-605e4956d840@oss.qualcomm.com>
 <20250929-notorious-masterful-cassowary-e26114@lemur>
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250929-notorious-masterful-cassowary-e26114@lemur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68db3cfd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=3TF44CuUNLJTpavCzZ4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfXzkSpb0RQZvTs
 F0sasJaCEUfNbitu60aDIrU61iLCrETUQT6FahAN3xwm6vJJ4XT+v3ffLoq3xXRRIuJ0Gt0r9CL
 /GYKnHDFC26Yz4RTgbYCTj7x/BDtvz9Ka+mnWb78p7PtnYdIhCTo1hkTqeALHAA27WKaYZEWLtS
 EP1l41bpn2PAbWSDrPPM14yfEuPnIBdmiKOERdDWxy0CE+QqB71LNTPWKmNgFfRTBJ40HQDH8T3
 0YUBs28G1KzpF27nGVjYuuVZIkF/dYaroouW2p17mja01Lx1EQodtYuxr2WjrI+2Oz/fc4ZiN3J
 6O0W13Auc1vZlOKDJYSSE3gWclGMR+pHWmxvoz3eL5kmZkRC8E/AD+aSrcQucCNOl9QngLZo7h5
 r36kEAkO868N0db9F9laloTy+L9JnQ==
X-Proofpoint-ORIG-GUID: a3-3C3cbNnsEjRaESJkZwpak86mDIdCj
X-Proofpoint-GUID: a3-3C3cbNnsEjRaESJkZwpak86mDIdCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On 9/29/2025 9:11 PM, Konstantin Ryabitsev wrote:
> On Mon, Sep 29, 2025 at 02:41:27PM +0800, Aiqun(Maria) Yu wrote:
>> We’ve tried using git format-patch --patience, and it did help avoid the
>> deletion lines issue. However, when we send out patches using the B4
>> tool, the formatting still defaults to the standard behavior.
>> The challenge now is: how can we integrate the functionality of git
>> format-patch --patience into the B4 workflow?
>> Any ideas?>
> 
> You can set this in your .git/config:
> 
>     [diff]
>     algorithm = patience
> 


Nice help, Thank you Konstantin!> -K


-- 
Thx and BRs,
Aiqun(Maria) Yu

