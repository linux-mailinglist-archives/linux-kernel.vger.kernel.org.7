Return-Path: <linux-kernel+bounces-818761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9F7B59617
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88E8E7A9618
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C530CD92;
	Tue, 16 Sep 2025 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iTr63tg6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277B21D5BC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025515; cv=none; b=WhSqPRySxe9oaYHbfyeBfIMoiezJ24n2f/a/w6H2ixg9Gu3MGvh0huopGX+3z/wkti6oa5Metg78mDFvBdOm4111ldOVnXxDewEtc8GSBu/XOq9A59/OjVeWOaZJtme2s0w0mAK7AaXJfsy1NIleSgwEJFxDF0yHgqmw27qS4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025515; c=relaxed/simple;
	bh=pYVRyG3Ofnpb0L1Y2+cXoG7kxZMxzvU+i1cFXSKD3ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttTiEYJYItUjYWfYcioAnpdulzJZV6NdpV+jh5Vtqrom3kxgFUSjyz3ZvoEI5X/VuxttFy5f9WLK18AnJ7BwNfY3F5lLQ1IErKw6PqEmmgsV9lg1kwgGnLonlpNssBhq+1ayPLj2GLVoYGrXLrvfw+0l0fdYQepm/AnPp18n/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iTr63tg6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9evQN007324
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rUHJ99Nhm6wc+crxDOeKRLBG
	ZdaCl2Lm6idkXPgbi40=; b=iTr63tg6bMh/8ofkmItHfBDoTgbgkxSsxeqAobW8
	RqPWU8Y+xuPemF9vlVaLLIJ480fs1yz1skKfhGckN0oN2LwYZXNizIaGotZJeLXM
	GV6E/+zuLBGKqjalpqqNanWrZDMWqz6pcjwzQVZpCIyvPyTWree1pcH8gPVrnbTL
	zspHCchPYTwaX/N/8OC9gfZGJXbhELE8htESKG1DEDJBWYNEyxcp+WgEirNU8N71
	ogIHxk9eHPC4QwDPhslpzqhBY914vcrJYiCuLjlLn83DnZsArXtkpS5D6nwZ0E4I
	whX++uOYCNM0LpldlBfCXLHAWrJXwzjuhT2tCt4tc4y0cw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n4fvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:25:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ced7cfa07so56990935ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758025512; x=1758630312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUHJ99Nhm6wc+crxDOeKRLBGZdaCl2Lm6idkXPgbi40=;
        b=UVsUQBVeUHzN/gmw2hNjGo8CVWMaqZtKx1pMNlymSnlie/QIl8HygveEzBelNP4nAe
         zRwvh6MnkWFjVxCOcxwvBiP/HnrNTyN03B9BIRs1PHXNyDaLr41cm+mvDbxXsF4ZAj0a
         j+vgLrLajl0mscE0HHLseruoR6v5hWI0A0SPOIzayt1HBE2eFXefkqdWBRl8SuRe91Zf
         pU6+GaHoK+EYSscrBOCX+oTdUuiLoqk+pXXy0c3xtw9Jd27RNmXzMjJnhXVTdwnAZBeg
         6aJY+TRt1fDF7AMpb0toZZB7mR9oaxWXJaTr9ELM/D/nwZvHzHVO6xogZN6T4nd05/T+
         jPnw==
X-Forwarded-Encrypted: i=1; AJvYcCVUS8OxP207Iqx+OcRw0isOxKiJ49BJbX0pRiX2kUGDuHknC+4T88SFYJicaWnTCGW/ZnZMe7cy1jPOTHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhkoNno9pxzb0Z+5auPbZ8ro9bYsuDLswHkTkmGYpk+VJJaZUF
	ht130qOrQMO3GJoNHcVGkFMq/+5Qp6CL0EVOHNebg7tG1fYk8X+cRcFLcGMe8VSCgyejZpudMUF
	jLP+yhL0BV3qB62VN74m99sfbtEyuZh5ubpWQ33+h4fTtERgy3lbHm81UPqQHB0AAZIE=
X-Gm-Gg: ASbGncvpmMvQdFTD2tGYuCdHrK8qpO2ea7lz1dgtgJaBL9NWmBWoEciu9u6ntR720kV
	6tmFVVQIJrgr+GAAurhpGJQDmaFV3b0R9+YljHlaM2YMMNe6rAiAkijFWP1oB+cYuejbB9i+REV
	7Trp1G403P7sA+dLXBQcvsTYN7reuAwKljC4jgEKbRfOjeIdgCIKW7Z6P/TZ1GYGC5+37yBhj0L
	RrQ9U8e/fVu7XzRPg7MgK3fNqrkBbUpaTB3zlxhMbq6klOMAP5jUoNXrppcx8YbAd0Amp75Qesq
	GNddV0uIKmeQBEZnAzqPBkQsWpIYdivSbv3/NyIqEE5IPDXJJFMZ1Ab+8Lxp3wz4Hx87
X-Received: by 2002:a17:903:b0b:b0:249:1156:31f3 with SMTP id d9443c01a7336-25d243e7fd8mr146599035ad.8.1758025512281;
        Tue, 16 Sep 2025 05:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfC+HYU/Gm0Yu1cZZREqssXTo+RveyP0dKwPWuRl4HJg2G55Yk2LtJ6nUVxaGFtw1OspyhKw==
X-Received: by 2002:a17:903:b0b:b0:249:1156:31f3 with SMTP id d9443c01a7336-25d243e7fd8mr146598795ad.8.1758025511851;
        Tue, 16 Sep 2025 05:25:11 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2676a14c514sm51154825ad.103.2025.09.16.05.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 05:25:11 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:55:05 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: Re: [PATCH v5 02/10] arm64: dts: qcom: lemans-evk: Enable GPI DMA
 and QUPv3 controllers
Message-ID: <aMlXIdgavXT6Ndt9@hu-wasimn-hyd.qualcomm.com>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-2-53d7d206669d@oss.qualcomm.com>
 <n4p4www37qz4hw75l6z2opeqks4g3u26brceyxi6golam7f5aw@raandspcihi6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n4p4www37qz4hw75l6z2opeqks4g3u26brceyxi6golam7f5aw@raandspcihi6>
X-Proofpoint-GUID: G5WPvu35x3_ed8DfNWCqdiYKKfB2MTbk
X-Proofpoint-ORIG-GUID: G5WPvu35x3_ed8DfNWCqdiYKKfB2MTbk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfX3KdRlQwsZo1r
 If7NkYyfK34fsJSgpYySV3t8SkwbmEw9JDLwqxUrtQ3ux0CSBX7XBJeeo93a681mHC+6oRR6IpH
 9bMvrYbNp5kP8MuPq86H3sAQrJJZsjDjc5hon9o70GTbhK1LdAnL9CPe2kPlnngaPoWi+nmPao3
 XlNKezXeTZYB5Wn7S5jWyjsa6dtrRvSIsAmQByn3A/ab4JqRsc3qLsyu5noQw0FI0nRFEYLJwTG
 LiMU0SgsA9V3CXJpi8CzqSZcy9mthxDhj36zCNIg30KWRSKXxNfCr2EzkgEjjoiEPNKHxuUuZon
 L854ny5mRYgBf40V0InozABfb2i3RtPYPs9pgDEwFBUZkiUHntYvh9WrdThMZgkmv7D/D5HA2Sh
 sUz3/q8G
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c95729 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=jsWzJFLPBp6GKZhRWDUA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087

On Tue, Sep 16, 2025 at 01:59:20PM +0300, Dmitry Baryshkov wrote:
> On Tue, Sep 16, 2025 at 04:16:50PM +0530, Wasim Nazir wrote:
> > From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > 
> > Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
> > interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
> > DMA and peripheral communication on the Lemans EVK platform.
> > 
> > qupv3_id_0 provides access to I2C/SPI/UART instances 0-5.
> 
> Nit: used for foo, bar, baz and slot ZYX.

Ack.

I will change it to:

qupv3_id_0 is used for I2C, SPI, UART, and slots 0 to 5.

> 
> > qupv3_id_2 provides access to I2C/SPI/UART instances 14-20.
> 
> Ditto

qupv3_id_2 is used for I2C, SPI, UART, and slots 14 to 20.


-- 
Regards,
Wasim

