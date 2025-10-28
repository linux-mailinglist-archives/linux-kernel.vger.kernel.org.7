Return-Path: <linux-kernel+bounces-873767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2BEC14A71
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B22BD4FB56F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA84D30EF8E;
	Tue, 28 Oct 2025 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RM751rUr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6295481CD
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655000; cv=none; b=PnbScJ9HCqu+Vpd7+ozVSbQ2GH0sdlAKZtLR16j/VFd3JehZ9ZikGtaMzGLtJ8Ls67Hzhs3v7Ki9ITOesPTY7C+j786oaYtSfvx7uxaqGWlBIAfmx/S032uECCAP6jz8HyGxkRe35tdS0b5n6HUR9pXgmr3KKHbfeKXX/hdvj40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655000; c=relaxed/simple;
	bh=FLfcye51sFnGBYEcyuAIBEV/z7O6KUMGBmdbRlBXsto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOujqNbp50Rdr8F2cnvXttz5pf6NdNXM81hwPaCuiiJx88ddhEDrE2gvasxiDsTKx/TutxVSzj0q8VqXRyDZT8SyDbNb6YAnrj4B7WTKFoGUJ9X+gW9u4MdYuWNjpa8zLEV1KGVNOdM98NAx36RZnq1lTJxEgnPmNyC8HJO5sO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RM751rUr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S7OCVq3813156
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lvaxdhK6o/XoM8ZzALCqs4Bk7cLM9dlvXJsxb+O4/+w=; b=RM751rUrwy3pxkX7
	Thq5nGcytUwunM3u8KZizz56ll+jhWuAillm5db+W2UECSr4FgkDYMuexPG1kgNR
	zITkuMiuVJXJ/L3vO6+VGT82Fs63WnitqnhrGv/v9SelleiJPZ+9mubJJVOGb6w/
	6iM8VwQo9/38b1N6cnBV0Ob03tD2C3AgHwG4N+Iqjq3lIus4PbVsRNOL/rsDfFcu
	YE0n3oYx32G2FojjixUKRoOjYBkfl0VYCK18VGi/jhG8lO8gaTolclE3g3AHEZBL
	lA61l1+X6k6nsS/NhXmMjqphZzWKfYAyJ+sk07SN/Jp83/gnv/MU+CvpD14D5bRK
	0L4hqw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2g2ftdar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:36:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b522037281bso3705952a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761654997; x=1762259797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvaxdhK6o/XoM8ZzALCqs4Bk7cLM9dlvXJsxb+O4/+w=;
        b=rddZhcX3p9klm2mh5RzA+LArX5sSOT3Nn8LNtE9ZCi/QXp6u9nBZU8OeYnBcXa62yM
         26OmotoAl48FcEq/OA61LO33lJdTkIayKRjh80KYWf0ZKMM2TbkP2vdAbX6u06JojlSk
         ImnHn3i2ivhQfIW7YvygS3qREtH1qqLfP4W3etThu0CyGCBEZ9qAAxZGQeb+0cPBnerB
         nGYyXrUHu59GoysZV+v0ikfe3w7Z9b35oXs99PJHICy5mKSed/vrwdYgKcLZbt8GeOcB
         rv428oDHP20K6WTsDjlcY5lyOd+dmuDDx1vUFgMWPrhC7U0fQWM34Pw9QAHoi+i60R60
         QrmA==
X-Forwarded-Encrypted: i=1; AJvYcCX5FVl5fOg4Pkz9RBDFqzgiq/Jb5uZyRzHBjxRM6C+3kfUeo0D21sEFHmbFUM4cp9lggssJ6iI/XYWWafA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqO2mR5MjIYo1TzjhpnqI24Q3V008oDIL7Pjx8CGyya6y46FtC
	NcfWIMrN9U+YYdpvON4b5y1nQW5druLCH8clWFSSoeWBa63+Db59i2utYFHBjUFbb9VU6lGgyXc
	vTe5Bnd6PYZIpqyiQccrAPgSDea2382lvM2UPPAvBsmzMEKeXvNpMJ1njFgQkDhvE5PNJOD1qdW
	M=
X-Gm-Gg: ASbGnctbEZ0JEMqLlCLUG1Yxyfd6iDyJXt+cetGTFKgheS+LHWPOCwHn+CNV7ThpwuT
	ViRahQzQvA9UxlkgWE8Id+fNAjLhGLGemijHHsYD1pX8pSa57zCYZLrU3anOUelDOLQdLRmkZER
	I5uReuImX5vdhn8CEM+kYeWq+KeqNgpJ8lRaihvGjo6dKr3CiBPUYxaSX9RKRuU1YPfF7qpo+AQ
	hLPDHq1RvEZV7mE1XrVylvuSoepaEEb6ICCkcnXmlzck/yZdoYfd8h38m/h6/bXbW7Bh7dmnoF3
	d+Gzd4/ZH1fusT19J8dad7KucN2rdoIyC0WEyrIC27h6xM0kln6LlvTvxC9j903uOefBChE7Jd7
	6eytfq/G7lhs06T5rNBDy2JwhWUXmI9jx
X-Received: by 2002:a17:902:d48e:b0:290:c902:759 with SMTP id d9443c01a7336-294cb68834emr39140135ad.51.1761654997005;
        Tue, 28 Oct 2025 05:36:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH602JtsdGlIpxmGIxTcXnfxZHUapmzZkM7OuWAMADDs9uW0/ImWEVIt9erQ9yiVzq0baBf+Q==
X-Received: by 2002:a17:902:d48e:b0:290:c902:759 with SMTP id d9443c01a7336-294cb68834emr39139765ad.51.1761654996545;
        Tue, 28 Oct 2025 05:36:36 -0700 (PDT)
Received: from [10.204.100.217] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34024246f86sm3768571a91.0.2025.10.28.05.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 05:36:35 -0700 (PDT)
Message-ID: <9f82ed4b-4bca-d990-22ad-b75492aec36b@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 18:06:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] media: venus: drop bogus probe deferrals
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Bryan ODonoghue <bod@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251017055809.8037-1-johan@kernel.org>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251017055809.8037-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDEwNSBTYWx0ZWRfX5XqXBd3yn1e4
 ptbjfI+c+lGLQYe+96iJBYYzJeY31zbmbBnd7ghO3D3a7XSSnAOXG0EnKFaNJ6Hz9UK3VjKIjKu
 AAIqrjxY/MuOpjmsvLZsWTNoCESHaTQlSzc5X2GU+KaFKPOTu1HVgc68zcIn9DuC3Q3hgVUp20i
 6VpiEqCkT3rMQX4xgG5ryo68NpnApnTPivrlGoSSh/RGjuCmCvlG4n6PiV7+Z6P6Gf0vjH9SKzJ
 oSeeuVNPyBlj36YSR86PCyhzNRoQMVtlc1pN0YW7Sb98UhQ5VzJvRrN8wmJeJ6mlf6Xz8FSFEaP
 Egc6bkOoysT7pcs5KkVtOSl5sF4GREd4/elR8SzJt6XrZDaa718WwRMLq+mPGIlaCmeGIha9Zfd
 gz0FV5/7AXkTSIU4btVM55OTjSUBTw==
X-Proofpoint-ORIG-GUID: JraBiRmVwZ0_evux4eZ85GjnWMKvIBTw
X-Proofpoint-GUID: JraBiRmVwZ0_evux4eZ85GjnWMKvIBTw
X-Authority-Analysis: v=2.4 cv=FIMWBuos c=1 sm=1 tr=0 ts=6900b8d6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mla-0liI9X_7Yk9rKOoA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280105


On 10/17/2025 11:28 AM, Johan Hovold wrote:
> The encoder and decoder platform devices are registered by the venus
> driver as children of the venus device, but even if someone were to mess
> this up no amount of probe deferring is going to conjure up a parent.
> 
> Relatedly, the venus driver sets its driver data before registering the
> child devices and if this ever breaks we want to learn about it by
> failing probe.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>


Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

