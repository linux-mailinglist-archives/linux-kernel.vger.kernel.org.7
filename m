Return-Path: <linux-kernel+bounces-848628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BC1BCE360
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40B8582326
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584492F7459;
	Fri, 10 Oct 2025 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X+JWwdZd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D913594A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120693; cv=none; b=fqFGrmiyjCwaAP44/bJ6GygSRQXjV/NAZF/Fjiv26IIWDUmFtSZn631fPWffLEbs0Jr56QKn6d9UlYoTS2Hq0GIy2Yxtnu4WXM6GFGrRsrhVJW3DsWxkWLU6xIKFrjeVtXR/UuaB5ykSvP4QQdqyaWGWY6VvFUk38dR5XmBXo9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120693; c=relaxed/simple;
	bh=9h+N7jcDyOc5BGr1kDkWLlpHAbv2LFq75pa/9F84Xl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4cP5IB/fcCgtjDVq1tJ81GKq505/b39v9LMzHibhWoF0r//ybgpIjglWyIqkdh66BG9E1rivy34sYR38pe4DBrDQtab1GQMGWGFgBygjGBDlSK6jLD8LFC9TeCNuB3+4RleZeFV4yEWBE1rLh0VfvwAFbO6poBiT6BapSRWHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X+JWwdZd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFgr3i032430
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9upVP/EYtvQuDS97rpn85pAn6Fk2yzF+mqttaZezhaA=; b=X+JWwdZdAeZ3rDg6
	97b9XDrZ/xBR0ZSPHDZS3h2jz4QC5InXWMJqQ1bQv0nAWAQNMBTcASa84rg8MPxQ
	EgJKPsqcBKkMoofLZu5cj57izKqDqDlRvIpFC3qWsPzAj1onspnHiqMCWOxWsrDQ
	qRW7dRCDAlThIgGOwZN1sYVe4twiXPXggsd4a6pFiDQBItqzAyL2nr2psV6iZuWO
	USVwvIUJZPpATqCcYysbx1YyaenK2g7jK0qs2/EWieXSkkej1222AWQKWr2rpDV+
	dBUX2oxt54stYhZd/BW8uRvSIU93lesPCGWqlxrIAUO5lrZrwRH7rfqDmhlpHqRy
	VjhQUA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kyb3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:24:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-85e23ce41bdso104098185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760120690; x=1760725490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9upVP/EYtvQuDS97rpn85pAn6Fk2yzF+mqttaZezhaA=;
        b=jsYaY33Uz1idxPvFSiKU3ZzSyKyYPgLP/0gEcdlAYX4XrU8EXKYx7+M9hTpUomeKTV
         ln30ObntKzy8l5h825fJL+BEF6Zk2N8lpVaA8AFPAZtQ9paJEMNWXg4JBAZpZx/Brgm4
         DOyPKEZ77tp2LLvXY2JzVnb+in94j+xzCw2LmT4CLRslQ4iAwI8TlYSIogl9XLvQvYZS
         NAniuXn36qEewLWK6G7HRN7F0gAA4VoZ9KzTUNhQiGSWcIcK/VQR9BEfbDEe8lobYGVJ
         GHlsUWi4Jf67nE/itMBIPTY7Aq9q8d4bDSS6yI1XGdc/oOcLQ2oOiqaQxMysH4DMvBqx
         IRmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuWWanJhzn4UKWch7G4z4eO3XhuToKCqClDBqrC6mpDiQI7/v+hk3xMJF1Ne+JoAlFTxxnn0AH2kTQ1f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHzyVRlqMrQQeRT5bsgzjwGA86gEXlEnObjqV25x0wvq5X38a
	XQ9bojI8sEMh5xGz6x1UN3ZxD4pkb1O1qpT1Si1IixLAAYMku85lbav9HOEb+pslQauc8G6OWwL
	N44+KGVyEnBbuITKtoz9mmPgLMLcbcDeZ6f+a/jgI///UBVx5UkoMwBERQFPrQ4JDoq0=
X-Gm-Gg: ASbGncvP8Y5DedQaNFTR5qQNQweHEDNUfekYBDiYaacyzX1G0Y6cZBO2u8Du+GFMS9m
	eW2XOnuK0rbS4V/0F4wwG6c188hD/Rzf30bRlycSy8Ui3dvlYlSS0PAmQMiQcVtk9ZSdiP66yey
	8JEccjae4Pq6MOtf9k+YhqnYi/MpkiT17Ql55NKavXDfJZL8f7jLPP5gOyAE9TQpWubQJFc5nq9
	lXQRHAOToNzUIkXl2iIwUb2Gsif100HNzsw5Q6oFM71fBwLgrvaYy8gA+H67b1XlRoEIoyv7vjU
	gskzyPPj3j+KgwMljoa2iRDTh5v9VvQjIiaqn7FN3+YzK5YnM+r4RsdLJJfkE1w0BKcjLu8BxnQ
	WG/xgpLhcZW8GUKrvNrmX3w==
X-Received: by 2002:a05:620a:3905:b0:878:7b3e:7bbf with SMTP id af79cd13be357-883527ca0b4mr1292956485a.3.1760120689959;
        Fri, 10 Oct 2025 11:24:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJDHOXXLxWpzMVsdELZY+jNe3rRfKX4hd2hb4fDYH/CA8/2CoNx4Yo+5Y9x92+KWGKQNrRvw==
X-Received: by 2002:a05:620a:3905:b0:878:7b3e:7bbf with SMTP id af79cd13be357-883527ca0b4mr1292953585a.3.1760120689465;
        Fri, 10 Oct 2025 11:24:49 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d2ce9sm288483766b.35.2025.10.10.11.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 11:24:49 -0700 (PDT)
Message-ID: <7f10f4b4-a5d6-47e7-9e27-8b6e48866e8c@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 20:24:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] drm/msm: Workaround IFPC counters bug
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251010-ifpc_counters_fix-v1-1-9187962b7d20@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251010-ifpc_counters_fix-v1-1-9187962b7d20@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXziaarcb0Ci9S
 g3oFp8O45baStAVFJje+Nz5OtAUCSKT4Zh/VLtd18AMqONEHrklPVzqi05plQkOWw4Ftmc6LOeB
 ZWHlYpt7hjeugqhLEMGYefwU4fgh6lutlFDJpiD+wj84aiorjOQpH/pOKJuRBvQLEI4cCIWly2h
 t5PBX/xijCjQ1UD9L3ZHvCjNf0+IuXBVRNPYoiJy+fsUUFwphhmTHLCNplvwWI+hmXHLQRdbaMp
 YFYyC5JbHvsuGf10xE/AxuYax81m9e/KCMrETrWMXjvAuIz7dIOfRKkWh/+gf1txR/dSaHTyo1Z
 t1zkbniwJYs9adlK+UM+ZgD4JL9uVceh1S+B1YU+cXFOB0DnQfITri/+kwbFrcaz2B54W2zGNv4
 /5b3j6BWckLWL64M4+nomFqUA9IPVA==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e94f73 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=LTEgcuO_lhVDbfJd3wgA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: KkdWRbnSvF66q08AHPO9NAJOkxF56Ub0
X-Proofpoint-ORIG-GUID: KkdWRbnSvF66q08AHPO9NAJOkxF56Ub0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/10/25 7:49 PM, Anna Maniscalco wrote:
> When keepalive vote is set to false IFPC will be re-enabled even if the
> perfcounter oob vote is set.
> 
> Workaround this by not setting keepalive vote when sysprof is active.
> 
> ---
> I have little confidence that this is the proper solution hence why
> this is an RFC.
> 
> Hopefully something better can be found.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>

Your sign-off is in the non-git-logged section here as well

Konrad

