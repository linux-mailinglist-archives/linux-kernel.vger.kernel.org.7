Return-Path: <linux-kernel+bounces-806394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E07B49625
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627597AA135
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D0E3112B2;
	Mon,  8 Sep 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OJIa+OnN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0C30E0D6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350199; cv=none; b=QBjy6585gxiPrgBKTRYMms048e8vjwG4ejqvMYImp54Uj5Nz5x14c3LM2D2obI2yghZfCRtUPxJHUP1tWpCM1jpbl4Mn4c2PehLt0KXtjt94+Y5Hpi7+eOUwvp3PR88TwtSmwTMBDG6DNYw7hKHyoLtappppSht82hUupf43DZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350199; c=relaxed/simple;
	bh=/9CQ2OX3PxqBt7H0alYZbdGyWPsxjbARuPidtipLk1k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZvAQ8eMmDHmEuiKXG1K5axWeY7Ff3937QEdPYa1eJI3C6TG3/jR1K4xdaqZn8Vx1hosAPCKtA/CV0KmiwMAHw8dPGThCRmcA0kg2mtj5ud9LNESLs6h69crV+cdXNNNe0rN41K8cbYhwOihuWmxv1uxl5xlLsvkNiI2rwlqJpsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OJIa+OnN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GbJ5g017315
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 16:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dg2UgokEeWhMc48JRI2mp84dAZ/f8bS+61znB0C+pvU=; b=OJIa+OnN04Ie3fWo
	MlrJaDYr5UfsJCOk47esyBzp/1kdLAWVOZyZCkWDJkT16me5b/sigwnmOSwSMHLi
	Y5JgRGOCA0sbkQYuF+R2YfrUUISqEs1KJMBO/EnWcywiSjCgcWp6LrE8gPadrK7l
	DZuZqXW6XY9MIrSYuWkD4MVmNtkaBlOjIzq/ev+AALmuTEaRyKe18UJXJj4CNZqC
	leaWy86Wg8kMkF5CD2df1zxyVM/ZOORFpCcBUMxexR8ow364aD6rMR8IsWFj9QbJ
	fd0f8GgDAxDyDupNHJBIJu2t8LxrePjqWKKC/6krQ0OTM8aD0foag/NqJ/5MvzIQ
	i4RrDQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4kw6s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:49:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24c99bd543aso86847975ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757350196; x=1757954996;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dg2UgokEeWhMc48JRI2mp84dAZ/f8bS+61znB0C+pvU=;
        b=eN50P+IuIlhpG3EnMJrVAjRvXWNtAHtRK1NCHFl99f/JBgs3gmSCYHyevj/DACCFaB
         NeqAdQmOF/fotFZk8KSTYMnMSPhiDyqIqobd6n8NUghlJkcPgPIGezNaKO0u+XepveY6
         7mqMv49O7LSDIdocfCzfQyYvgTGQApNcD9XSwk7Ot5FU5YNRxT0Myst6dVnKudtZXl16
         dxZbRYStb1uJexX+q7EdHZoa7EntFClbieumi+9+XvDreJF3jFKMLI9iZFi39Pa0euj1
         geGQUVvxvw4RiN0M4XJfVk2fbOeFfNelpcLD0aljG92OtZq5EQFlW7u2pbTSiZm2Vilt
         VndQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvC2iSWu0w5KiU5HNjMdtW/DXG5ec5Bsa7diqW2i1oDpjxK/yzZySLi/llm4ln/vBaJtsByMiJBsVSmdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2gPbYS6RIgsKhZXMX5Aq5f1czCkzA2PCTlpstQKdBdE4Te6He
	NwZ4SGpnsCz3ETixTCBeGjYsBAHtUvj1Y96zlr2F+HWDLEpVpxoxjkjGsBvyZnssKxrX3BtpCzN
	62Mtv43oZaKiO9iIiekbn7+77TRpiI3fMLkUhUZM0t4Jx24D8tLyBK3u1nXoohRxbXZg=
X-Gm-Gg: ASbGncveCqEfEzfEoZsHd7UKAiN+869sAiTBCeq9HwZTUXFPV1lm9L4cCqzF7O+gGz2
	f2a47VCQu7b9hGlcr2ulhEwMR+gBPE9VWSWFmCfPLGwBW9jmAZ5DGcAtWxbpBf66Ffv4iIzV75r
	0jpX7B8LQvrKrm0vCI5+pAuABwD7vO//vjlFolyeBrcRo6X466KQqWPoiDzG8RVpRrRWx7bp1UY
	nTiGFoVa3wohHpYbvC+d33sVaOZxT+WG+tSNCeAceqLFQmqlrJDms2YGNCMGNa/ptJ6UYdfeiob
	jtHyeuLMJqNYQ7c3b6XjTzC9QQt1gNZnMD+RQurfrDWkg1OridDFsf33zPCnJqGNEwVJM1b/Zbt
	h
X-Received: by 2002:a17:902:e850:b0:24c:e6fa:2a38 with SMTP id d9443c01a7336-2516f050554mr107248825ad.25.1757350196249;
        Mon, 08 Sep 2025 09:49:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA+zIa0x4vuPGLZMXZtryawOhYTo5+tSCWHHkxGVO7NzqSam/ERzYOoCQyK3wKgWJuklzisg==
X-Received: by 2002:a17:902:e850:b0:24c:e6fa:2a38 with SMTP id d9443c01a7336-2516f050554mr107248415ad.25.1757350195711;
        Mon, 08 Sep 2025 09:49:55 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28c3147sm130460655ad.73.2025.09.08.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:49:55 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250908015025.1301398-1-miaoqing.pan@oss.qualcomm.com>
References: <20250908015025.1301398-1-miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: Fix missing station power
 save configuration
Message-Id: <175735019498.347840.10113935121682584580.b4-ty@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 09:49:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX1eWMsD6qGaY0
 OYk8oqzr2hokTOkTwbeQ6/OgggHjjqQvzZSjaYGxcHmyrSac9yPjQFlgcb5lxPCXO5+5cGBEtx5
 UR5xmr90+SjMxsyKU1zM0iSdhFAE5GoY8ncYzW8aASJHeKgPbxir5xJLdukY+h+pAvqWbe3sUJS
 NuB/vK/yD+8WU7sOl8I+93JRICCUb4aagyt3mewf9LRIx+jTIuRi7aFRPR8+0Y0ExGY/n1n3UzJ
 ejDPC1Fl+jK+0wD90R7TpOBf7sr/1CpW+9SHMnRpQFrpyLpYlYxQj46cVgMRihgnz4jeHLx9nu3
 P44EjNUw4pdZgiXhNjAtGvqA/wZh2kAC5uXzFrSdHoSzIGoUhzDVNE0FvEPI1g+m02sK4Rg2aKC
 RauT9FxR
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68bf0935 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JgkEKiiD5wMD4hIjs0YA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 8G7AkSY5mS-YQV8OEalSa9lmMuLAiatA
X-Proofpoint-ORIG-GUID: 8G7AkSY5mS-YQV8OEalSa9lmMuLAiatA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038


On Mon, 08 Sep 2025 09:50:25 +0800, Miaoqing Pan wrote:
> Commit afbab6e4e88d ("wifi: ath12k: modify ath12k_mac_op_bss_info_changed()
> for MLO") replaced the bss_info_changed() callback with vif_cfg_changed()
> and link_info_changed() to support Multi-Link Operation (MLO). As a result,
> the station power save configuration is no longer correctly applied in
> ath12k_mac_bss_info_changed().
> 
> Move the handling of 'BSS_CHANGED_PS' into ath12k_mac_op_vif_cfg_changed()
> to align with the updated callback structure introduced for MLO, ensuring
> proper power-save behavior for station interfaces.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix missing station power save configuration
      commit: 4b66d18918f8e4d85e51974a9e3ce9abad5c7c3d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


