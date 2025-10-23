Return-Path: <linux-kernel+bounces-867135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 440F7C019EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D89134AB67
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A112B31A54A;
	Thu, 23 Oct 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kHUSZG/d"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694E7315778
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228218; cv=none; b=b0q7VMM/jOb09Ue0RunMa1bQoSC00HpQ27clbaxCMeGTi90QrdCH0bQ0XhRTsCzElXoMVqH8pFr2wionFkPX/eb7Kbk+Z5LvxIRPb005+GWjW9ZBlT/Y7vOFqXIgLHH45IOL8kP4CWdcLmizIZLJeYzezrVf0iVvsbs+dQSQKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228218; c=relaxed/simple;
	bh=0CzaTzlypWUkajfo0TGMzn+PrE2vSGgKyweMD9vFNVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B/iuCr+/zlmXwLPLPOQrZMJ6941lsbRB3xmEvKOVVVCGpTrOiueyb65xQMbci/Fzh0jHtD/AR4PDKBb39Qa7P3G7/Hr4gGqy7VLiw2aLIHqfTKbYxHEM5q0bd/Xbbxeenr599G0Ex1swx9FyONEGlL8faVyn5u0MufV7HZr00hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kHUSZG/d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6xovk007442
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RyLhRpTfWJSWp2k1SpRF7RM3OwZDTZ2/ogv70cQxLHE=; b=kHUSZG/dvXoiuiBp
	PtGQHMFpZVdCOtaivIad7rXBtbNZ1MO9+x6wsULjtXFCcVjGRjMR7I54O12TyxZ1
	zySkt4An/Kexb4rO4YJjGiOrMhLqgOLakdaVp4fc+H/KatzdH/GSFNq9snAvvo7S
	YHp5JEOVz78lXSlf8e3Eq9WpKOHafLmls+ZYpV3yPeHxG92GmlmjJvgjVHqT7+sa
	mE3L8gxy8jUB6YvCKjFG9VKAjigAfP7NZXW26S4AkLbzZ/zuoAg+duy8k266ajJL
	39xPdctXD4YT9otrlRe79XKyfwzdBlM9VJQoDKVBuXyaHiWWSEqylTerhBCKxmdv
	o1k2ZQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3448q4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:03:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33d75897745so2020110a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228215; x=1761833015;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyLhRpTfWJSWp2k1SpRF7RM3OwZDTZ2/ogv70cQxLHE=;
        b=ZzDXLPGR+2AOg+z9l1vIgnfy3hBd3exHNxLXa52ZJ5BwjpSP/VS2a8P/BDiyxz+goX
         Y8Tm+fk5lEdertenBtHFCnCFeFEhJaQ67mCgJ5HzwHQkinho7ioXju3V+J906+XmIvVR
         DTZhu6797OCTPPLlVoWTO44t0DS9VeDtcq1yNCY390Z4M1VGMQqvykWLqkAmt6+mwSBh
         L8Q5ONYouutWOHT6ClWjHupJX3NUI7a6FbF0pJNJsyJIFhyILKmR8vp5ttUg34AdmHMg
         e64y+kBxbfN8FkEjSiNP88Ky9b7VCdK8E5Olpc03oQEAGqdoqC6Pu7wwkiY0N7Aw2DHe
         pXxA==
X-Forwarded-Encrypted: i=1; AJvYcCU0RzMmsATS85aEy8lto3+L7JpoMp7Emz27vLlpKfMqeUfjITcw7IVmp+o8gfKoE1u28TTsD6xtayaLDl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxqgGb+8DcFevYz1KSrifUnOEx8hG6JRXcsRUiQBkVQ4BTy9E
	UPP+20fxlfUFUwzuq4SKAUKeVqLcA4d8FjzhakjyF66JbJb3cxC/sGdeWKkGQEw7d0/TSzXCzbs
	AP2vf3n0mfeKIp3u3K7NEtrKT1+LA3Hor0clSRUEcVWDhe7vD/M5MHXDeuUHqebXD2vo=
X-Gm-Gg: ASbGncuOHpGZX8BcsdqFcZz16JiD4RdvFArdeFNzPoabUZYsxDdwnyPvhgrvjZ07VAi
	DtAcP5cw2kLReq95Q3cEc68JpsAgt1LWggxSWfkORC3pm5ydib+WhcBVVFFt7daqzTyc0mgLLwQ
	Ln9SejxdKzjplkH8UEJSYJ1D2vFFoa3HDTc5JJOaTFC0I/amf0IEiLnDUCruffk4YSLPgvn87M+
	2ju4a2PmSMKlBQOOyM3lXOqIBkSLTGndtdgqOGUQ1l4pFtlccVGtSx/I9s3IqEZiUKkovCovEaU
	AZX+7MypZyMh52zJKRHS0whJY/dN/emwgtJjlhz5TNz3Z7Msx8wej3/t/9VcBxQ3nrpLjp3RfeG
	haQFR2rG8oziMzgX6qNHBBC3n88iMdTy0N/U=
X-Received: by 2002:a17:90b:5386:b0:32e:9281:7c7b with SMTP id 98e67ed59e1d1-33bcf85da05mr25992951a91.3.1761228214513;
        Thu, 23 Oct 2025 07:03:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnb09lMyHjX9OqhelwjDoLEOgHgOk+r/wUnfm+suG+1NvsV4vsi/W9hqLuhO6WQZAo8O1nAA==
X-Received: by 2002:a17:90b:5386:b0:32e:9281:7c7b with SMTP id 98e67ed59e1d1-33bcf85da05mr25992713a91.3.1761228212310;
        Thu, 23 Oct 2025 07:03:32 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff3c1f8csm4250708a91.4.2025.10.23.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:03:31 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
References: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/4] wifi: ath11k: add support for Tx Power
 insertion
Message-Id: <176122821156.3033388.10937600819458906745.b4-ty@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 07:03:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: X0qxgySJlakcp9J9VVJ2VDQRK9b9NFRW
X-Proofpoint-ORIG-GUID: X0qxgySJlakcp9J9VVJ2VDQRK9b9NFRW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX0ddp2aSkLghc
 qhk/MbSd6SS/2jNA82QkOKV8eoe16FYJIuKX5qIbFelTINCnCw2o2hoeRL5U/B62iQ5tscnehDo
 TW12wlxx37XZVbhF1FSFfGNfIiIAHvSXlP8eXEWN4/wZWvhKnaZN2ZeA2ILsnuGpnMWdZe3B0QP
 w98tGJpq5OoU6Lc22isdAQiFiBETuargpwfdQ0cctvHTqglwNh39uLIQtJGtzEFgGQXek/HchkV
 xLjH97yMNXUt9+hT0Qn94xfQ2uuOgY4ZWU37VRSuihFIt5M48IRJtIidBHGbqSwXLyD8Huufk4n
 EelXgA30s1VE3ZWKYrI5Y4sfUjzWnLmxlqawuAMrTV2mOEGpV4zMEKBIXSSs4NjXXNY2dkdggpl
 HyMeT2SiFxZzfEP34Yel0e6fXVzGfA==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68fa35b7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=9jhMNZ7qWXdoG8tHMgQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023


On Fri, 17 Oct 2025 09:37:56 +0530, Aditya Kumar Singh wrote:
> For certain action frames like the TPC Report IE in the spectrum management
> TPC Report action frame, and in the Radio Measurement Link Measurement
> Report action frame there is a requirement to fill in the current
> and max Tx power of the device in the packet.
> 
> Add support to populate these fields in the relevant packets. Advertise
> this capability from the driver using the feature flag
> NL80211_FEATURE_TX_POWER_INSERTION.
> 
> [...]

Applied, thanks!

[1/4] wifi: ath11k: relocate some Tx power related functions in mac.c
      commit: 66887282233d281cd9109dabfdad5d86b709acc0
[2/4] wifi: ath11k: wrap ath11k_mac_op_get_txpower() with lock-aware internal helper
      commit: c243d5e44f6ecbb29bf55b82e6dd92bca4fde0b1
[3/4] wifi: ath11k: add support for Tx Power insertion in RRM action frame
      commit: 722015690f52d046ae609e1b90cd3f018644d93d
[4/4] wifi: ath11k: advertise NL80211_FEATURE_TX_POWER_INSERTION
      commit: 998c68e96c03f10dec19b65279ade9d4000d1ae9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


