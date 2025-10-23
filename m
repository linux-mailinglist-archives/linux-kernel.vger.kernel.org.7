Return-Path: <linux-kernel+bounces-867222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD3CC01E69
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FE5535A194
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8AC330B27;
	Thu, 23 Oct 2025 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/1zdoR0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9980330B35
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231076; cv=none; b=p0gP/I3Bt+KoEVg6LCNUi0pOFZJ7LHDSa6kfGQ2GnlR5oJIFTvZw2uTGg1yqJRUUI3xAUpRyoAbv6wg4aDqF9T6s7whkDJUkTnTE36RfYC+DzZEr5uv5YGcPOmA9R0Nm8wtIvD9ol3hul6gOepWRHLbvrdbLqNce5Iejg3EmxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231076; c=relaxed/simple;
	bh=nTCm0E0DZEOw4bT7skogqqCxkYln9uhSiEPtufpsYKY=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=bH++Qb8iXuD/45BBWDtxNwOzcu4eLXethfhrdSaatejoWWSQQ50OcVP7Kr1hR0AOWrpcWN8E2zVEhEf2C33gEkcl1sWPzW3s5p9dZCoh3jBe1KO02j75zIGTz7jmLFWHCt/dQi310X18PTY9+37/Y6TWM9RgVzLeh72lEOhsTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L/1zdoR0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEKRc9005710
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nTCm0E0DZEOw4bT7skogqq
	CxkYln9uhSiEPtufpsYKY=; b=L/1zdoR0nzKChbSOBfI11NXGJYfTYc2yVUaXun
	UsqK4nhA2hk/su05B+O/CtUt+IuKCHaw0Fs11zqaTJp0VZQEKDWCI3NRhf+MWrO6
	4U7oDpUCJmRX2SNTSeX3WaJyqN6RL867/HtBomi5k+q12KIkB65R//Emg83uoQbw
	cAJHYWB0thVKBzdUg86d2aEiYoRF7o5d86s6/PTeTHLlToaEkFyFzSaAIU4abcm5
	D8dN+00UkFLW+is2J2HUr1Ols+MEBe0J9xRHlT+VGEtLrQNHNnb4ahbFIblOhcQJ
	v7eNhRktlpIrA3FHNXVWyfIhJ4EeJlnutls1i1giLkSQ+YOQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j8r1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:51:13 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78108268ea3so1932755b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231072; x=1761835872;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nTCm0E0DZEOw4bT7skogqqCxkYln9uhSiEPtufpsYKY=;
        b=LgXHWpxsujOCceeLfIXgoRV3R/xAGc/+La9iCJuCurrwUdE9ZpeVsnr9rwBhMy2v5r
         OV3A0258H+2pQ6jp183gLKdQWFAWdDukegRiCG885tYIiuoxdFLdf2DC+S+7DYg/3NgD
         jn+dZRFoSOVSzUHhQeMmkqXuYlixoKf5gCfNcRgAQPv4ZMTaQxcvnbSvfgrRkSCFEPsP
         tbc2cOTurXIelELvFAGXg7jsGjB+1EQJ7EkfcHV2rjM6d/qKd60q0xVsNHso14lfNyxT
         CyBPEq45i5kRE1e/tpszuwZbKXa6vYdQ0N/EELMTuaIpQ8osjPAg1fVqS1Xq8sltuyi7
         4qMA==
X-Gm-Message-State: AOJu0YyDMO2Y4jc3rvd1V6dmcK/pUgUFzK33JZJzvxYaaadMtevvZkxi
	9DVX9IRHA2vrrFI9nFfBsqV4+oIKkyKZF6uTRnkpgiCqpRlIIesfNcapmrCEBoAxMOszW4lw/DB
	BzShwNXiV9ZHG1p7ZsqqZYxOklKDFQ7AbNL36FrlkREqrxE6oKyLFl0+TLzOZtPXzcAbDzhU8II
	w=
X-Gm-Gg: ASbGncttiGgwLoQEyr4R2jIRNp+Rhf3mjj04rrG/+iajHT3iKbNadYH0aeTWy8ZSOXd
	+rKqofSyOAgV7p4pjp9BREP+/YycwOvySigskH0GL2y69SgaNhV6fuK4NH6SXoPVSJO3cDMaOz8
	kG5gmnpb0jk895yBd9CMPxOD7xHzsigzBjBAtmXPbHKO5XSk6lvRDNVce8p+T7chwx14AfaT/8Z
	vqnr26DFbY/mOdxG/DOqksrWL/eMrjh+JcadDNKNedGF3jCLgNeHj+ongWf+RIQPW8AqBKFsPoU
	eOsl7n28WB5rmBFMfYRuij97RSlQl4LZVL5U1H3UWyK7Ix2Z6pHlUCcG4sCFXWU51oGxe5mo86C
	6veODpbr646V4f/3dS1CRnkHQVtY/Sryn4nCOdPf4LwA8HebUD169kx7mOeg=
X-Received: by 2002:a05:6300:6141:b0:334:98bd:4520 with SMTP id adf61e73a8af0-33b68abc66bmr7983561637.12.1761231071984;
        Thu, 23 Oct 2025 07:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjYteMI/fKDfe3PsFg3JdwCyweVgkVyz6Gs/nneMcRLDPxCcWHB0xwF9Tfecaj6oyZtJxGTQ==
X-Received: by 2002:a05:6300:6141:b0:334:98bd:4520 with SMTP id adf61e73a8af0-33b68abc66bmr7983519637.12.1761231071435;
        Thu, 23 Oct 2025 07:51:11 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c05165sm2299203a12.13.2025.10.23.07.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 07:51:11 -0700 (PDT)
Message-ID: <54b7bc6c-8e30-4924-b700-bcb87b79be5a@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 07:51:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
To: linux-sparse@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Will sparse ever work correctly with guard?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX2nkpD9a6rYto
 lv1Qu7w6MrRw9OdFiytWyzrlZiQ9PHI5vxCFxkG2c+uAyqCkSFDsQxBot5zI2tZSxylX1S095IO
 U/ohM0bB7yjpNOiZK9vz+xL2t0RU6ER9nAFkk1xIBoytpsM9vCPTqXjc49COELlNsHXI3CcZA4Q
 cJRYJXoMgmJH/4MnzGbs8lV3pnvZFo0qZRs5oF0FPhOX9MBsMtStpUWB4AvvzBROxicGIcAOtb+
 0cSAjXa+nr07alsoavoA0lGl/I1DfUPp9vgkfabtSt7wCU+DmnE2QQOPI4mDLyu+Tfj6QnYagYT
 USBHEUu7+IElePAhGwNaKmCJLvJuLGHIL9CSYIhMyU5upslXP8JnNrp7adNhIHflmoh1CMa7v46
 5wyqMk6WXapntpc0oX0xFNH1l9ZQLA==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fa40e1 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=3lU2tRPfHO6n-GZdqYUA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: ptF5oYNDWEijZdyq4qHbCVTukfZh5Zhs
X-Proofpoint-ORIG-GUID: ptF5oYNDWEijZdyq4qHbCVTukfZh5Zhs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

In code I maintain there are places where we are now trying to use guard to
cleanup locks. But 'make W=1 C=1' is complaining:

warning: context imbalance in '<function>' - wrong count at exit

And lore shows this is not a new complaint:
[PATCH v2] parse: handle __cleanup__ attribute
https://lore.kernel.org/all/Zag2fYsyJDtDR7a6@google.com/

For some reason scoped_guard doesn't have this issue:
Re: [PATCH v1 3/3] cgroup: add lock guard support for others
https://lore.kernel.org/all/722C5824-0381-4E43-B8AE-AE8503CFF51E@gmail.com/

But using scoped_guard then requires an additional level of indentation in the
code.

So I'm wondering if there is any chance that sparse will be able to handle
guard in the same manner as scoped_guard?

The code I maintain currently has no sparse issues, so if this cannot be fixed
then I'll have to decide whether to use scoped_guard (and indent the body of
those functions) or just keep the traditional "goto cleanup" code.

/jeff

