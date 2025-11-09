Return-Path: <linux-kernel+bounces-892155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BAAC447B1
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 22:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1BA74E57B0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 21:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11E326CE39;
	Sun,  9 Nov 2025 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dwx/yBFK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NrOe3H9c"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD200221739
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762723210; cv=none; b=unQAtRvrp9iMYGXEXVz/m6iov5n+QoMYTrYdfgXJ99OagOXF9Sr8dnMaqPQ7KflCN0RmNXggAHkmIiRotwy40iEbnxzvSK/JYEryKk9Unm4k/rsCClcaQyXkTnYk1VajNmzhAH4KG/RKipSDTgCEA03+/8BuHFSOLRxoeQRY45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762723210; c=relaxed/simple;
	bh=3kLuEtqOYFVKEThNqmDGAzD+Sfex2UQnxoC+sk8K5NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNSef61dkNsrv5qXXG509Q439idY3zL1C08HSlRAoUE5x6pld3uiW/Szg/TUi8Uy32yXCkfAF0o2h/T6ttY7iXnIVP6irUqIPLyX9OhuuAztyFqXdo9xlrOMqsr5k51GBeelrzHUXgxkxOZHqMEyVvVirOOJwpmYJTiK7tPGrYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dwx/yBFK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NrOe3H9c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9JW7Tn1410082
	for <linux-kernel@vger.kernel.org>; Sun, 9 Nov 2025 21:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pbVsXejt6h39ywCxmkDZ92ta
	+Bmr5io8nWG70XNXbyM=; b=Dwx/yBFKPv9FIkUU8TOmrtC5wBVk1ViYs9PF/gWB
	ClkIPlZTPm6aUYAQL/zdhOFrGAiBNjPJlnPCy8kj6XBVXhdDtW6ZkBVj3pcZXGq4
	toN8NOkNE4c3SbQt3hb19yG5AnjwrUu1DCJHDlE8JF/5L6uvtUgK5LcKpIRE+Ngm
	t3Ep2M6pwJ/9tCEi6SPCr6hjl+y18WJPEL/CXqHlQJWsQYOA8IXKT5otvdU0oKV7
	yEVI4P1VQdrEfcSyyth/cCdZzIUAaKtBBfCypIn6xRytxKMPvC2IfNUJqofJpIaI
	rHBGxVqYIm16Fy8xUY4MAjj7NMtb4FMeX5ZlDaLRlssJnQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aaue0ghhg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 21:20:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edb205b610so6264311cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 13:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762723207; x=1763328007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbVsXejt6h39ywCxmkDZ92ta+Bmr5io8nWG70XNXbyM=;
        b=NrOe3H9c8oFnsu1VF/QCNQfvNlM3WQObKCtnLp6kRkDMcCiQPumXjari7QzRIuJYLL
         iAF4Jku9bFXRWACspmMGf133X4qotHw/XZPKds91qIM/+cCedpGtksPq4ExdjyNuSgKA
         3MasZjbss8SwB35nUJWxi3JY+M9liD9OagaVCcWkUbSrCTcJyEpYnT5HZPEBNNssr2ms
         WvLbouO6aX0di5XlFZPgwgg/WSJpOQ1cvpTEQ61Okb3HNGoLeSP1X2EGJuMG5yfLruHE
         wRmUNZsvZQlksZA2rkMwoYran2cayzxE907arZGrZscKJgEZHnSb8g+ZBbcqBSlfcc7d
         gJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762723207; x=1763328007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbVsXejt6h39ywCxmkDZ92ta+Bmr5io8nWG70XNXbyM=;
        b=Ld9v0PrBPuCTA6wktSvQV/oDj/mY848Z/dE3qSpcAt9foWFhE62TTNtA8jpr2LJ3lH
         zu3OyoYJF9yB3tbYOCZ61IYUqCVHMH9LuSdJ2Bq5J/pGi9Kdi15XfbkJcwg7HOtCRZlv
         zr3Mio7TmFzB4catDH1nQLtVUIrh36GxKD0I/xHqG//Pprly06quYPS+u7r7iL/DDd+c
         43ijpQwR7iMHXt1AaV5niGsBhIdTYLxrkCinTV8AH2KC6uxzwIeiuCmhQUSxPlAuhie6
         Qi9q6HFvPg1ZfqWbJ7d2c+BhcT+llBdX+SaaYc4iQX5d2BPsQQUxyM9BFN1bVKETkTLh
         0Uyw==
X-Forwarded-Encrypted: i=1; AJvYcCXf+489kZuu5Zv4FqBNWFBEZmCN0GHihxMHzZkBpd0KQ+faLst2P3NKkmN8R6PeHqEE+5IQree8IIM8ALg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcVimMIWkx0y4sFU96XN2IA52xi3WeI/in0E45Ly9ArIAG8W2m
	4cmZOR0Qw3mU9CjHI9WTjrS2VkyLd6dozqVrQ5HVUHtwCF3KLIno6rybec/5HegOlHQZeCRQFRO
	vZkHV6uQfuqrjDO6ckWMHk432ynojHUPA5Vu2kbVjKPJ7Oxw3X+xiVZepCGYcWe3wTv4=
X-Gm-Gg: ASbGncuLZHZmyc3IMGZ0bZFQdjPcYYPx0GWCc+WszxNb7s2bFcev2EUjsVVN4hMfNRk
	pf5qPqsOLR9bSPn3r7N3eJ/QESpZom5jN5RCFU8oO6504wCj6nbaEmgz4RvKSHgMoe2iOo249Y3
	+UGbherBB2cy4ngPtKzRBIHF3h/V3FdrO3misvo07V4ykrrzgGT9qbZN+V2/3GBmBqGcRmUDR2f
	gEevhj/BikuSfqYVw63I8f/iwF7jbt31u8Z7Gds4Gl/gDquKXgO4EIHCihlPQyjJm/tEe2DHDug
	OM21of1vcT9qXeAQ+L9r0kSSuNnw79TX/IPv3O7apbvmlfLuir9et+7RstBSD12tWG5VhI83N93
	iKwVk2Hy/jv7ZmDLc9ZHam6qK0+pYQQq2I0jfOhz3cgxWK5pSG8sYTFUEIIWPy8dTuHeNvKocxQ
	BlBJLnPHh422Sk
X-Received: by 2002:a05:622a:1391:b0:4e6:ef26:3152 with SMTP id d75a77b69052e-4eda4fe0d46mr74479221cf.80.1762723206714;
        Sun, 09 Nov 2025 13:20:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYVBQScxAvnOfUXqgyJ3sZSK5uT7+bzU0vnJcBmWRUuT8ax0C+UWHx2AcA9vXBjJQ5A/MiZw==
X-Received: by 2002:a05:622a:1391:b0:4e6:ef26:3152 with SMTP id d75a77b69052e-4eda4fe0d46mr74479011cf.80.1762723206344;
        Sun, 09 Nov 2025 13:20:06 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a3a1c2dsm3412544e87.84.2025.11.09.13.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:20:05 -0800 (PST)
Date: Sun, 9 Nov 2025 23:20:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        quic_chejiang@quicinc.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Fix SSR unable to wake up bug
Message-ID: <lfvc5ndd6sb4hpgf7yxnajve3ipiptll52lzxjomjfpkjba2qk@3lgl6doz5tvc>
References: <20251104112601.2670019-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104112601.2670019-1-quic_shuaz@quicinc.com>
X-Proofpoint-ORIG-GUID: c783wbxjECHjPDVupN9xcZvQCVJFYJjB
X-Authority-Analysis: v=2.4 cv=BfDVE7t2 c=1 sm=1 tr=0 ts=69110587 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=NZlr1TM-Zul8l3pKAykA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: c783wbxjECHjPDVupN9xcZvQCVJFYJjB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDE5MCBTYWx0ZWRfX3wdnywfdfkH2
 NtE7VXnHayLvt8MJHZjuAJEuXE4fnYdLOytijHWVzhHmYikcaEHvNpBfBMXV6DwuD8MswBzyaT2
 S7kuCRddXwHwgMu+4WKbFjn1hY5kng5IxK7DPADNz0tCoFdTHfNx1I5HnonSyHFX6Q3gj5j/Tpp
 0BmvtFsWR8Udqbxb8BEdmyQ/xlX4eDCz7g7M+dnJ/QZFNxL4Ygs+grX6ZRZX8GP2At98jHxatXr
 uSk4me8GFXwO/9L7gIYf5GXJ+a/TQehxeg7lB+FHb3AFmUb6fUN17MbPKmygeMwLFcyOFYLL1/C
 hY63Q3J0cZ3Yq32wjDlTA8SIKouV1BKzu43KbMYqI8vL2GrmgXfAgm1lgop+98ptYN8mqdHRMFh
 aRlD4ZLpzBUDliNmNbjKoFDVC9PBsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_09,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090190

On Tue, Nov 04, 2025 at 07:26:01PM +0800, Shuai Zhang wrote:
> During SSR data collection period, the processing of hw_error events
> must wait until SSR data Collected or the timeout before it can proceed.
> The wake_up_bit function has been added to address the issue
> where hw_error events could only be processed after the timeout.
> 
> The timeout unit has been changed from jiffies to milliseconds (ms).
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>

Missing Fixes tag.

> ---
>  drivers/bluetooth/hci_qca.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
-- 
With best wishes
Dmitry

