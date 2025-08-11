Return-Path: <linux-kernel+bounces-762358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD66B2056F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D63B7A2923
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB472367DF;
	Mon, 11 Aug 2025 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eMdIHOtq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC81DED53
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908382; cv=none; b=E5LGDCYuq0jT5vylvbZ0lePLL4bHRug/FDMxxlyR93VbbRwSSzwvjKPqnn0L8Sp0rEqSz/v0GHBHqkYnN/MchZQOP5tCvSegU32WzRr1CjfKqdLKpAt9JWtFk2OywWvCUdvf+PEJqvGkpOEZ6IAlFFnnqkdy8jXhyDn/g7NOxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908382; c=relaxed/simple;
	bh=LnEoDpnkoJHU8kW/etIi+d+IHIbHf6VB/4ZcFLdBa/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OA5iXmjTc7HErnuCzFycg1MVom9cOEnIEEEoeMsPz14GdKb6/nupkX1ad4g38DdO2Ir02dclGBaG31vmuB47Yc2ABcpqnu7LqsmFDDkr17Cyi9xTX62Lurjmf2YVlRDLAMM9vSa37XekVeM9A5Hehrsn6Nrfmefunb7i2J9P3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eMdIHOtq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dG86029264
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZnHcb9SoHxXWIKTgE0sy5s0fFPVq4IXyx5zLZaTr1jU=; b=eMdIHOtqd3s4zWYG
	K5aGT3wQhdg/20NBi2POFtCEeyFJcg28eH4R3n317ZAIdmfl8O0ObfPn4E6LsOfU
	LxYwsftdF1bziVqY9mqo+XtlEerhowwiy+chsBRVAOgzpumQ112HeyjQROcU785G
	YKG/Xbl3L+Bes1Q4H+/N5i8046RRVsT8Ewq2/JhJn5rFjSkPHhFgiv9BiEer04ML
	k0qrBnt5wuIyWT92Qji6DDtXpjggYSf2Y03eOVx3F9JsJSRnFtv43MaSCytzEBkz
	usUXgNyIY3SaC8xotUsOP6wb4Q+dJqkTFTtl7tGDsfgtZJvkXqggOpYyepkL9DcI
	2F/V1A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmbyde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2400cbd4241so69372595ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908379; x=1755513179;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnHcb9SoHxXWIKTgE0sy5s0fFPVq4IXyx5zLZaTr1jU=;
        b=GgdHUhWAACHTQokO4bDih1IobTeYw1u85WrqLNWdbHVae3cmudPFBQVlapm0tqes59
         uaGvgxLZOfi8QR3U8VSVogCT+Abhw3okFtxy3igztlYticN3BHAmxJ1D8dITGg5Q7Rrn
         aCgKeiQ0t25+6+JvBcoRChJthPuQzE2MG/6Qz9/s9Qnes8RoGeKTUL7uYs/G3B+2uonv
         x3ETvArnynSgnaYiig9ShKHeUG9M+uGcQ2SE7n6CQ2NZf/TauEPXfX51Rbi4czM0YFFI
         i0p3jvazGRKMNBHJYU6hXTK5744lrKapKl2KNG+VGjIJluOEt883iJTYZfKkGoEY7rxw
         D7jg==
X-Forwarded-Encrypted: i=1; AJvYcCUMXeg40D6rKtp56d2jc8alatrrkQcfURQW4loZNtQoDojUWO4z5HkJvfQq62vNNaSN3mHw2jWUVnMUFH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8TSBRFDVGO9Eods7p2WeqASRWLtVFHFzlg5cUPY/s6BkVEcsy
	mnIk1mINLWR3WiAQ2Su7ett442L6aTZNf5ejYSnDmMsZwQMjQgMW3o11rantO4AQzA92N3io0fd
	0pAqOoIBBQU+qY2yBH395X+FQzg4S9RYa8sBVFiehia5Us8/wIwxMdnu1RBSKHYpOa48=
X-Gm-Gg: ASbGncu5Y6D2laq06tjExsn+gSIAV4SRsMqa5WBOM+mzgSGFuu1PwQEb6xeRDPiDzEd
	pNZS9hR8WqNl1ti5jMY+5WZ0H2Re8QWO4iqRucs0vPrTldTeGao/i/5uBMs3y87wCQzA+D3swsd
	VBSGcDLBZEWrPiR5SI7QYCJylXRThGNRho1ki6ELk91rHGPK5YNtp4O3Q/RagDmWvfUvW+EofHu
	ovJXGc4mC659tgfRotHjvVYIHExeqAELnqaa0eEAJbeRZZQuzmEhJd3Z3cy+YhEHknduQ90Bs87
	GX6WpaJ4ct4NXpvjkEU3fQETd5wxr71maOs9Ly8+
X-Received: by 2002:a17:902:da91:b0:234:d292:be7a with SMTP id d9443c01a7336-242c1fdca31mr188037505ad.1.1754908379576;
        Mon, 11 Aug 2025 03:32:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnL8seQl4qJRIS+l3fx3q0zvEkrAxHVu3+GqAQLTm/24/fC5Ue6MHpNqLIu1E1JNvc543A9Q==
X-Received: by 2002:a17:902:da91:b0:234:d292:be7a with SMTP id d9443c01a7336-242c1fdca31mr188037065ad.1.1754908379120;
        Mon, 11 Aug 2025 03:32:59 -0700 (PDT)
Received: from [192.168.68.106] ([36.255.17.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89771e2sm270188205ad.88.2025.08.11.03.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:32:58 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
        bhelgaas@google.com, sfr@canb.auug.org.au, qiang.yu@oss.qualcomm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Wenbin Yao <quic_wenbyao@quicinc.com>
Cc: krishna.chundru@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com, quic_cang@quicinc.com
In-Reply-To: <20250722091151.1423332-1-quic_wenbyao@quicinc.com>
References: <20250722091151.1423332-1-quic_wenbyao@quicinc.com>
Subject: Re: (subset) [PATCH v5 0/3] arm64: qcom: x1e80100-qcp: Add power
 supply and sideband signals for PCIe RC
Message-Id: <175490837428.9171.16946610135898864162.b4-ty@kernel.org>
Date: Mon, 11 Aug 2025 16:02:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX/GrYN4TsSH4Y
 Z1eivnqEwv672WyHWHy+D6G8GfbKxG5UJs12vS0oiXdekSaf37no/l00QnKBOUZTEOm+NB0zCMx
 j/aNOLlKs9ssrzMUsgH3W5/vZpuJvpjeHipo6jwY1f9uJhGJKOpaN8IlQd6m/LrOTHySa3Py/no
 W4y0il5CaXZf0Zj7lu2HMzW8LzZavaF6A5wJHz6Zn2hTu+MBh5DzHiu4GgFDPIAq6tHUuUimAUd
 RhqiksfTQxseUIoG0xVhHI5xI1cxC50Zz6bmcAnS5CHnW+HixGlAJkUZ8NfbL++zQRiuxp+qGj4
 wO1aRjNFiEGY+qu1iHcZh+DBgDk++zFWfd+I36svZhxUUhEEf3W5n0uCoDY8fdUSp7PINome1uy
 oWREmk14
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=6899c6dc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=tivzXH558BYE5qsfyb1zSA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=idEpX0rf-HM0R3Am6JYA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: ZtlyZvELzw5UQ7XhrWyRbKtbv9HjrTjV
X-Proofpoint-ORIG-GUID: ZtlyZvELzw5UQ7XhrWyRbKtbv9HjrTjV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035


On Tue, 22 Jul 2025 17:11:48 +0800, Wenbin Yao wrote:
> The first patch enables the PCI Power Control driver to control the power
> state of PCI slots. The second patch adds the bus topology of PCIe domain 3
> on x1e80100 platform. The third patch adds perst, wake and clkreq sideband
> signals, and describe the regulators powering the rails of the PCI slots in
> the devicetree for PCIe3 controller and PHY device.
> 
> The patchset has been modified based on comments and suggestions.
> 
> [...]

Applied, thanks!

[1/3] PCI: dwc: enable PCI Power Control Slot driver for QCOM
      commit: add7b05aeeb417c86239e6731a168e6c46b83279

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


