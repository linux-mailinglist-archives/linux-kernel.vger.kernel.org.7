Return-Path: <linux-kernel+bounces-734001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0DFB07BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE453AE2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D522F6F8D;
	Wed, 16 Jul 2025 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lcrgpN0R"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1742F1FED
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685897; cv=none; b=EcF3rgxSsRgHUj5YyFNGOe8Afk0Tr2nSk2BMqW+YPsoXsZ1O5yJiXJARfEZGNeO+U1s+ktZGTRgguv6lhGMS2iwFSFdsu1aze8U0nOs/6G8YCF1tPQcDRDN62PhiCdlEEzk4LHAt4TFUu0SjPZqrVA8xyIJwttxSFufYPAR/QZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685897; c=relaxed/simple;
	bh=teMc9fjwUgbak3TeVa32zmM1K7Kuh41Gi+pH8Ju0/BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GN5ciQDPYpOiZRRJ3KsNMnLJzEpaqus87qqlxWq7/XK7ailN+x8nqQctGHhZyvEctlyTGwy5fjH5RFIB6mQ4fsVrRSjgCdThF9zrqBBFcMnMMmIYQ94J0ddrlOX7xn1Yec2GeNz+RjpCadzcJHpH/aA+wk6NJHcvoPAiezvx9is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lcrgpN0R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGDcjq028124
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AvZu+s6FPUG3iM8B2iDP144HoBABMQMyB2lUuofN4v8=; b=lcrgpN0RS21s/wFj
	BA3V9E2v1JVAb0Jubcya9oPGT/MF+0yYlDwuJymmhDfnmwOBvvSZbbRcJCBu1TOY
	8NLV+BAE+cMui13Nej2B0JwpSsfbb4p+XU1HEM8aFm6g/eSVLKdLXMhUan+Wo37U
	LyaF8coJAdDXauV/J+qOph7zsKyDCWH2iAWQGHe/M6upStdCLSQNHLxJHs2xdLyA
	3EyrsJuzQ5fqObKx9gfBbbjcyyVvdCO4R/aO/aN3jLhSi+KVjnO5pgQcPhEFwVp/
	8OZdVTpXIZiVJPZLCb1QIh2yqciql6cFRNZ8xSj9ykqhbeAsK6/K1AvK9BPDslu2
	Z0w+Ag==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5w0gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:11:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23638e1605dso301225ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752685890; x=1753290690;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvZu+s6FPUG3iM8B2iDP144HoBABMQMyB2lUuofN4v8=;
        b=ixFkKDSfNnsfXEg8g0s4pVeU+aqHMWxwB/IrTpnMdYaiJyu1l3+xjlsiVpqKwPGbzK
         wYm2nSfgKWrNECTiY5afAqrp6dMK+Th1okN5rMgmQYN8wjaDEJvNpX8kEyXoYHJts/X0
         sOH14EQfuzS0xe5uX4lYGzEVVn9iwNc2EEcmT/48ryUvUl+J0SIiVlxfr7xKwm9ESqpJ
         Sl9O2OsEYBrU3SyecJNFEGBDogjXPw3u3oRcqF2zcLK+EhfdhFx5zfhSA+6tf+ldZ3mt
         tdxomA6oHqnTEJnaWMN5KNyCNcYkH9Tq450Zq0fmY1kjG746nRBRdCpALAhoCZB7FJc5
         DGtg==
X-Forwarded-Encrypted: i=1; AJvYcCXt5jnY9Xq+Tsw2SjRoI8iMU1J9PZxgh9yH0tIA+drH84qwlC63PgBXhVTJjSbNklZ8sizsPPJcxKKEhVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6J5EmHMlpbMEqCb1z46edBG4AqIWj41yxfWp7vAZbB7kbUiV
	ZS10Eji7JYPKjfMqZ8aaWFqHPYu+7TUT7xP85txFRwEEnMf6r2Zj5OsOCeK+fslARZr1HvgyE5A
	EqPP3YMPrU1WJl06nNhmSGtclbG8lhCNxFwwyZID/d2/3tCitm+tnLKzP9MJe73fEHO0=
X-Gm-Gg: ASbGnctWvwQ1ej2lJCpMC9Fswh51vkhAuERTKNeOIJwVlO6m1zcTuab3mZ07DVy6PR1
	S1if6/h9K1OK+3FjU4OTYGq0mrIFimPLEDWQSKe0/jJDfYy6qFrFRZyiriBxq0HDoTI9CErXWms
	hKgN+ongcImc7KKCZ7nL6mhvcxaoAubYKkooJMm35j7xYQv9IXPXa/4/OeU4AwJwg0dMXvF2b1J
	fQrG3qxq/rF5cbeN+7NhcNFqgEnjnHSoKx6C7oXLfikQKhqnBj/wHTnn2JeRAmLr+BwveYTiMB+
	5OCzu29MZ/MLmMFNgEpOU/1fdg4fJPjFh+DgKm/PxGSGxxqyEqjNQva5yIgVEAIDXfiK+19Wdye
	ENF6GDKxwGAdM3vhE2xY=
X-Received: by 2002:a17:903:1cf:b0:235:efbb:9539 with SMTP id d9443c01a7336-23e256b6e94mr60970205ad.17.1752685890510;
        Wed, 16 Jul 2025 10:11:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCaXQ8h/tJKVUb7+n8ZsAIn5RASnIJXRAkFzeIQw6HcoivPyubiz6hlD2vF/imJdL6JmfECw==
X-Received: by 2002:a17:903:1cf:b0:235:efbb:9539 with SMTP id d9443c01a7336-23e256b6e94mr60969775ad.17.1752685890010;
        Wed, 16 Jul 2025 10:11:30 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42abd8esm128205355ad.54.2025.07.16.10.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 10:11:29 -0700 (PDT)
Message-ID: <f3374104-684d-48c7-9e2d-e97dd48700e9@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 10:11:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] PCI/ASPM: Fix pci_enable_link_state*() APIs behavior
To: manivannan.sadhasivam@oss.qualcomm.com,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=6877dd43 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=rhYh_zIkBfzxVmIspk8A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: KkR66E-ofiVs0Szm2AkswgYxPnmFAF66
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1NSBTYWx0ZWRfXxhg7LXNG+cXv
 36wFcggNDEHzSSodOmEp9ScbRXEbU/kmNUSs5UV1XGI/G1WstqZgcErSh7WysIuK5Jnah++mphW
 ccQCM5U+/1VOEgAxdDxTWRT5ZtJLVsTqD2vTgFW/AZd8IZrCTsftmhZsYldzUPNx/7KnWkw147S
 4B2OOy7n8/Wcgz/j6N+r/mMbrqIHSFCFZfbAbRS2QaGonfCylaMRu+Qe9fxSZrbmcbyKHM+FaiD
 M05/b/54FG3il6nEioFoX3DRJinB8FxYiTmB2rtwbXg4yqi2eflNFu/n0v+dtjRVKrCjP6VwbHh
 IoYdLViSeW8IOk2F/QKeBpnIh9tPlnc49HZmV/ljcttF3Q6+sUdJmyVAEOtca4sfVVdQBU3EV8m
 MyB4cm0x+cPj+PLWWt6oMsKHm8sSphGMpTuj+VxTYSGb8P3fILBkzhFIacmlDEKhlhgg3Hva
X-Proofpoint-ORIG-GUID: KkR66E-ofiVs0Szm2AkswgYxPnmFAF66
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=435 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160155

On 7/16/2025 5:56 AM, Manivannan Sadhasivam via B4 Relay wrote:
> Merging Strategy
> ================
> 
> Even though there is no build dependency between PCI core and atheros patches,
> there is a functional dependency. So I'd recommend creating an immutable branch
> with PCI patches and merging that branch into both PCI and linux-wireless trees
> and finally merging the atheros patches into linux-wireless tree.
> 
> If immutable branch seems like a hassle, then PCI core patches could get merged
> for 6.17 and atheros patches can wait for 6.18.

I'm fine with either strategy. In the first case I'd merge the immutable
branch into the ath tree. Note I plan to issue my final PR to linux-wireless
for the 6.17 merge window on Monday, so we should close on this decision soon.

/jeff

