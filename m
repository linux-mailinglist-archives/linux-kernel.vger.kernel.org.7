Return-Path: <linux-kernel+bounces-843422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA869BBF266
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 914924F0150
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEDE27A12B;
	Mon,  6 Oct 2025 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VeRrI5GM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B601487F6
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781149; cv=none; b=GH4lhPjf4h8QZ6y+ECr5sM01/QdYEAfnq6vNtlmAbG9JDm7gNyss7LdJy9Gt+zGlcMdX/WG8y4utT17cEJgwKQkVKB5eHKGtMtqmcKH1OP1Iwe3c4AXHlQb0Hanv0VX2WpqezC/LMx315PUlbyJ6wsmTtLYNk/3WVExWkdsf3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781149; c=relaxed/simple;
	bh=q1KvKmrtO8bl9Jw2x350Fw6zDSpeopygAF+ufzxztlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QE6fHiQZdv9mmC5zcg86lJDfTWBEMqxrABSgrbeT9SfXNQhG5ye9vTExNcy6phZKxx6rMGd+Fjy+UcHrkgRtmc3AFLz8kXCq7GW+B3Ql7tHSAXgg0/F9onAMlWG+oWhcywXJJzIRCLUziv1ZwQ/vgy/bdvznJ2t4XWUkWtoPPpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VeRrI5GM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596EqHPe024655
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 20:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VokQyOdAkrZGe951REC0SHkH8iGG4oi8Wa5R5hbvWX8=; b=VeRrI5GM/WX4BhQw
	JxbMkXd7ca6eCCteTDGZk7kC7jov9DvGCDFSi3RtYj0kbAi/vWuB+X4HiYZwyHPk
	Cem8ph/EbQFyvHIWUGAsJAjQGXqFEv6SbKI90o+brGw07iZDpCAZo30OpCSSeW2X
	wn9trMaV6O9z3rJA4ZEwv0hsqTuK7R5Y0OaqplXsBE5XESfXxojRGMkGgEoJDZ7w
	MpMLTmYwpUcDPE0LOa0MEZEIcux6b6J5lT8D7X7uKjGpgkmj/JLwilT9nVwNk57j
	vz+Jtk6PYIII7oJhkAPmj9fRiXmji2tVAO2Dq1rsF/U4q1BcmqPmq+MRGTOdGyAI
	r/l13A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvv7mugm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 20:05:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33428befd39so10292709a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759781145; x=1760385945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VokQyOdAkrZGe951REC0SHkH8iGG4oi8Wa5R5hbvWX8=;
        b=VBYa5BCVyC1iFThMC5EPE4Oc+N5H47GBAFlfztepWg5L7+QyeJLKrD+JtWg493aqsW
         L7JNfN1D4Fk++/48vn4dVJ4VS6ZB3jVvasXBLztcjKSACvrk7K91w0RYCHQf/3pW9mtp
         X2W39csdbtV8k6SZWG5QDOl4mABryr3wakbQzwgedDtar5LdYG5simGrMJGmrd/3MbDx
         +5csmiTloTT8O+4XF+AdkLs2MYqE+fgk8kJdRDlj44kkvOh+/vLip0qdwLewFTVDbczs
         MG5YFh9/Hskuhpf2hF3sXLdiqPfn+ZqqEs9gnyXLOZW44GzUyh5c8FzCVL+KpCr4Zok8
         69vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEPzPMbHbJqfGXpUiLwaUATLRanJ0OuL70WqWaPbTir2oEPaBBkwMQY5y9z6KS3Okj5NyXsIlhzhiXNx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjLHn089jqD+z4G5n4Aa/531VGyTx9D6HqOTPhZ50mrbZBy+Oo
	w6QBZ3xgdosfWuax3seXaYH3iqNfII4DuWp/4QPhhyb8uozvNeLQNKzCsNA8r5FNymjkD/W7KnC
	r1p3Mrh+Q+G/P9gSwuONTubduzcddGMG39eHcCKKphxXVBpmCYdeN9Ub+rtWyJWDpqnY=
X-Gm-Gg: ASbGnctDOFzlOCJYGEgKy51HXlrgrmHQ8NffnixF/dfXwo2R3OQGrE+AfEbXisWt6DW
	MjMU+f9NzE8btzVZGTmsXzNTJhIujrCfmESqW00N6kalt6JewNPQLZj/xxYD3hvNZDhfsOrV0gE
	uSDV/+M09jKHQlLtE4wypTNoP1LSliKbMSlJhne3cOFZfOstYFDN4g8xVim4QpjZ0YedEuKx+bR
	Gfff4UcplePYua+Xq8Gu4lUXhj/B3ivjSO+6e0pl2ASDq2nFUviTdJmR1pBLKAFQywiro5bYQX2
	WpBhmZ+omvJ/Wd05DQJAs7yYprZiOA4D3W4Tn7A9OCZL1Yhh/SBt6HCOh5rFV5otbTLpf6VZkhL
	RWnAcDNgseDrEqt5fIdQ=
X-Received: by 2002:a17:90b:1c8b:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-339c2707c6bmr17476063a91.8.1759781145343;
        Mon, 06 Oct 2025 13:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrIzvI/Ib4q5OWm/SKnkikSDyMwUjwzWH6VNDAasyPGsw6dl537x1y+EL1bAHyFVRtexfFew==
X-Received: by 2002:a17:90b:1c8b:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-339c2707c6bmr17476025a91.8.1759781144886;
        Mon, 06 Oct 2025 13:05:44 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a0c666sm11899960a91.1.2025.10.06.13.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 13:05:44 -0700 (PDT)
Message-ID: <cd8454a6-8b4c-4aa4-a510-98797d844d4f@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 14:05:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] accel/qaic: Replace kzalloc + copy_from_user with
 memdup_user
To: Thorsten Blum <thorsten.blum@linux.dev>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250917124805.90395-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250917124805.90395-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNyBTYWx0ZWRfX1e5CFVhSpjZG
 y4Aj5XzC/7MJtUHkD3HAcfUMX2EQi60pvhKl0DzESG0Xmf2ReexsoQ+AAjSfmJRA1Mn/oNZm0vN
 KZwyhOevXSWBq0TCGPHlPJLRCbwLJS43pK7FHLv5FVS91HHACCczjemHN8xmE37o4KC9Eh2J/7u
 V3OyB4aMc1A0VVtnoUNOyDQoUvYXQcV+9zAdEOLX851oQ3UAqjRKf6yWrlRUl1Bmv8VnMLGY9tq
 09rvvallXAHUihuyeo9urPlrjVRhTTNCpy0i0b4MKDoo01byAHg7auj4rTh0RvwJomPHVVQ0pFz
 EB0RgHFgyC9ksns4JXJe+ClLU6xi1sXF8Fi3An+f1UH+k00pGipumQFmYH1AjFVODPWqglH7Nzz
 M/lrtNYElYrt8tCXr+zQAaiImnK1dg==
X-Proofpoint-ORIG-GUID: aNF0tMILxeuIFGlT7niVZc6dNPv-tY4S
X-Authority-Analysis: v=2.4 cv=WIdyn3sR c=1 sm=1 tr=0 ts=68e4211a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=3NveYEIoZWvbRhgcYaYA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: aNF0tMILxeuIFGlT7niVZc6dNPv-tY4S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040037

On 9/17/2025 6:48 AM, Thorsten Blum wrote:
> Replace kzalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify qaic_attach_slice_bo_ioctl().
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

