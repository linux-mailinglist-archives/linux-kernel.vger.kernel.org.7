Return-Path: <linux-kernel+bounces-817241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1463BB57FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A702E3AC3D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7BB341662;
	Mon, 15 Sep 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aXh5hcS1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF4C340DA7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948076; cv=none; b=Wq9j8PtqQKRV5ocPMM5qfmpJmkzNcLfD5p0G/huvWAFPjbWvFpPFCXPrVQYc/bxQv1V/s0qQl6cOFXhbkAT7NvJr2MFGdSYy6sRu5jMhzjD3FnTzcGwGrap9Gc/En9aLOOfZUynEhpWCFkZre7VC/F64FpLi4J0YcI4CqxsKXZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948076; c=relaxed/simple;
	bh=PS/pbmTRXcygzjKLV/ZriweIInnpNBJCFMpcte3A8mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZxkEZTPGLQEE/gJouG74Q3o/nOKAs+6va5uu8SoCtGeLYfvlKiFzFZbzfJjswNm0q2jm5UdPDVvpQHWc3V7rrxn2CMAXBO4pE6VUBhWpg3Uj4Ztmhn9fhJYudrxiC4qOadG9d5EcLJgxLZufL+CWcysZaCp8/K223zRSTRGXKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aXh5hcS1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FDoPJi008398
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TMSXgi/BqIZSCVKz3fftJI0C
	kUt1hfyDi31hmUWvWS0=; b=aXh5hcS14xPsBunpQrH8Eh5TQbDRg0PmqQNaHo/6
	9S5xu31giH22C693vkM+MrT3c0BnZpy3kubiltEDzBV2AGFaDTZ2e/nUSAioudg6
	2d7jOHE77Hdve05PsSQpNzaryB8ftWFlOBy6oW/FhYwB9w6zK0ifHxkKFoU6qedT
	s2yl9vDonKEeKN89fiswvww/SJVFcGrmiQhjFvE3zqD8PoCewii1RfrPc6a+w49x
	jDns2D3p+956O/I+QPrKrGO8xj8iDWtvsxhIIcDeCP5djCM37XNOHxj2m/kWt3YM
	DCO3tmL0Yc/pw35b7pddxCE7GWUkfsGfFek+YI1xAA2d6w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqpv888-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:54:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2507ae2fa99so80982205ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757948073; x=1758552873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMSXgi/BqIZSCVKz3fftJI0CkUt1hfyDi31hmUWvWS0=;
        b=rfoQXZkylXEld/AmFyOowMZlfyXbZv8bkRczi9JKg2GKeKkL1VcqsXKNQTQCj82vM3
         JttRqZ5jh46QeICHLPxFYvD2JvYvB2C3xdOCr+FmCAiCXv4i/NOdj9NvfnfdeYozLKgg
         gRqxr7qqd0EFR+ULQhlOrckPYqXe0RsGyl76wcSls9/GJVcN0b0/j1sO5G3fccjvGkcm
         7sId+6BaW6rEYqcMoDER96pULBwuOr+bftV4GckJB30b9K5438Apn3eFJqLnaxW2LnwG
         fuSfUfClwomcYzPTrP6fxvQjpJC8zsGSGgzPC9TGk7K7Sw6qp3ntJ6TJPcDUmYx7M+j7
         rWWA==
X-Forwarded-Encrypted: i=1; AJvYcCWjvmP7Fqi1nEHhQjL9VOq43FjHBO2ZHbjGhz2Z3Hrld5f81WWLzBeV52/EMjOlg0HdmGfYta/0K+HGZ7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9HtXybwAi5AHcDVG/m1ALrGwec5io3GG3rb2X+MkiE7mqIy2t
	X/rvbe/RtI5AQb6eL2LssaHSY7yjWnBE47n9gVGglzTFa55O7pKJcfMhfnNn8p0gxRUQdOBsF9r
	TMQXds8UY5MS5EVVnBBANvPsWNv+4VuT+x0m74oGfPpW+EODU9uZgRj3w/LCUDjhoYnY=
X-Gm-Gg: ASbGncvu8RKE9NPgfNyVtyp4ge2f+St8v17oNpFPAkgQ/ffFJcF3XE44IJkMahi0dqH
	656JaP3RPT/23ExWfWQjBhpgGNnD9q/bmny+3Fy9/o7ijjz9fg2PkkT2RYIHrl8R8k2R+hTimF9
	sGgLuRLLYPncXoUHoNBFzsC7ywkq9kB1BOI1O1gETomYUaOHWVtzH21bld+vrZTbylmKJWGSIl7
	uzKy44btEH64qQjCXBmzreepVUIFnM4XTZ/D7UCOIEFL0dyTpweJ8985gZFgrQGTiGpQeYJ/0HF
	JE8TSyCPpEXzvH3MrE8+jYy6WuZj7YHZpCEISwHS1GPrcZj10L95eA==
X-Received: by 2002:a17:903:1b28:b0:24d:4d8b:a17 with SMTP id d9443c01a7336-25d27929650mr163440575ad.56.1757948073176;
        Mon, 15 Sep 2025 07:54:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoNwqnfXJFToAd40yGFcgFxbZGcyYvpuu1gaAnNng/OHoz50BZQe6dvr+nmCY5nQscoatjSw==
X-Received: by 2002:a17:903:1b28:b0:24d:4d8b:a17 with SMTP id d9443c01a7336-25d27929650mr163440125ad.56.1757948072624;
        Mon, 15 Sep 2025 07:54:32 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26628eddb09sm35094205ad.59.2025.09.15.07.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:54:32 -0700 (PDT)
Date: Mon, 15 Sep 2025 20:24:26 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qcom: qca808x: Add .get_rate_matching
 support
Message-ID: <aMgootkPQ/GcdiXX@oss.qualcomm.com>
References: <20250914-qca808x_rate_match-v1-1-0f9e6a331c3b@oss.qualcomm.com>
 <aMcFHGa1zNFyFUeh@shell.armlinux.org.uk>
 <aMfUiBe9gdEAuySZ@oss.qualcomm.com>
 <aMgCA13MhTnG80_V@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMgCA13MhTnG80_V@shell.armlinux.org.uk>
X-Proofpoint-GUID: exD6pynLNY5V0X_MBwYHs2F4c9zgRvVQ
X-Proofpoint-ORIG-GUID: exD6pynLNY5V0X_MBwYHs2F4c9zgRvVQ
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c828aa cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=Tu3KNy09MRMvIius73gA:9
 a=CjuIK1q_8ugA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX7HJXiNnyqinJ
 YQ4bLN8X0GLwSTLd5I4FxFVv/wm2j7FJ2GP/PFANohrwqTiGljXnTnqdmdgdTf8k97NR2nvpoql
 3xdMe0mnga2XgpU3Qq041knJ8rvQuj9ELF/SlMETEvVtca2gnYMg3KO+ehG6izFn3HKtP841TTF
 5Gg07SjxrdeZOgJ3unDm6CLt82CKqv7kKBvo5zJimVY5LuLGQci63WscJ979xFJAjn76QN/gOQY
 Cxd69urPNBZ6EOlMzsIRTZceVHWTBywL9A6IGQafw9U0rXDjrZcKWIeDIc6YoAFEgaJRaMQvhNr
 4SIB9gW4rYiJN5qoR89nbbH5N0geasNXC6hugUnH+NFeRK52VuVVTID/8s2oz9hLsEzQd9XEsjF
 lSUeNbsb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Mon, Sep 15, 2025 at 01:09:39PM +0100, Russell King (Oracle) wrote:
> This shows that the PHY supports SGMII (4) and 2500base-X (23). However,
> as we only validate 2500base-X, this suggests stmmac doesn't support
> switching between SGMII and 2500base-X.
> 
> What *exactly* is the setup with stmmac here? Do you have an external
> PCS to support 2500base-X, or are you using the stmmac internal PCS?

Internal PCS. But it's not really pure 2500base-X...
I found an older thread for this exact MAC core [0], and it looks like
we have an overclocked SGMII, i.e., 2500base-X without in-band
signalling.

Just wondering if registering a `.get_interfaces` callback in
`dwmac-qcom-ethqos.c` and doing something like the following will be
helpful?

case PHY_INTERFACE_MODE_2500BASEX:
	__set_bit(PHY_INTERFACE_MODE_2500BASEX, interfaces);
	fallthrough;
case PHY_INTERFACE_MODE_SGMII:
	__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
	break;
...

This should ensure that both SGMII and 2500base-X are validated,
allowing switching between them.

	Ayaan
---
[0] https://lore.kernel.org/netdev/4f642463-3a8c-4412-a007-42fb65c4276e@lunn.ch/

