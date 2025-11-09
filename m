Return-Path: <linux-kernel+bounces-892136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE33C446A7
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 21:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2548345C39
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 20:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949F919ADBA;
	Sun,  9 Nov 2025 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="evFm7SeN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bw4AxVoZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EFB1FCCF8
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762719319; cv=none; b=UYAOed7AeVW+hXIlWHoyaanOE7Eun5c1rfN02bkdxxWnEv23WVYwB/saLyxnkAim3bup+szpnbceGxqjAti3ULu0Dze2a2HTU/b9Sn9SbeGdgYFtDTmxaqCnmlqmBooKXdhbn4XF3Yfm7Tdd7s+Y5ZqVr9OdyU4L7zXOTb7eOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762719319; c=relaxed/simple;
	bh=VOhLYQV7vxgT9jsJn0omVQqhVWq7VqPmdXzqZoeD0mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEr2Tp+GIIPsMLr+da0VetmYbUfoy4npVOk4ZET6YCmHeFfkK4Whzgc/baIpYfXULYK0AORhVMNWiRf1LGhdVPgmbg5NO4bj/16owgf5vRX9FoFyjkXqp1n5ZUyxqUS288WyKj7nysVSXLs4TzQPqKfEpFQUEcL4O1+gV6CEnKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=evFm7SeN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bw4AxVoZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9FHFUA764845
	for <linux-kernel@vger.kernel.org>; Sun, 9 Nov 2025 20:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yWxI7c/xCcXaq0wTIFDh18pB
	mx0rP7+GbV3s02BhTRY=; b=evFm7SeNCzTz0S6GUcj6Vdz9U8xy7rwtuz64E/Cn
	1Ll1LE7MrJQ2qn2HFdi4oUckxKguhbbUAHI3GDE1SpO1hctIhUMCqGNgtBCzKHkz
	hc/Qr5oNMUeHQvy1Px1QAvIiONEwRP28AtC4SdzW7Q6C3a74pw5SpOTuVVnNUuB5
	4ERQg8+9onwGJSOeXYRex6IUjgT8e6+T+A+nCP0LKw8Tt7TbSRmIKYO6fDuLZKu9
	TpeMBnOJdDWW9cUCVUZGKEaAuXpCH+N4Ir2IiDUFTsMBACAQi7D6CzwQ78c9q852
	GzEHw6EhdqFqXwlKNYPA5lFeuWLwtNidGI+pz3xs7I+gNw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xu9tk3f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 20:15:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed6466f2baso72702731cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 12:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762719316; x=1763324116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWxI7c/xCcXaq0wTIFDh18pBmx0rP7+GbV3s02BhTRY=;
        b=bw4AxVoZBS+Q/hwImh6H/0/cxinVzKo7xjwEEpHbyR5pmiXndCgGzd2tgYm9YLOR6y
         GssQBdupGQX8D6OBHSwoYycpQjy949BMAYtkgCxHXF94Iy8u3B1Coq4txwf4RrTr46w4
         7CL0w0GYXz6ibNXZQ3rh8ATvtQhGXgu6c/5QDB+4TVdVlYa92ZKg93cMa8eD9VpB1iVT
         0G6FaXmVYbizjg4EZ1LDSG0gW45+9nzOHg/Vbw33fNRvOFQEfrE3jos5va5edlOgEXWQ
         JdH6stDku9/soUpg919q1m+KFc4OEaudeYMfa5Jz7peUpVqOzGDXMEgDd1sMbE7CBPKJ
         X/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762719316; x=1763324116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWxI7c/xCcXaq0wTIFDh18pBmx0rP7+GbV3s02BhTRY=;
        b=gIExUu2WRlLqZlr4k33QKrleo1/XqdTBwca8PBYEiPMgPnp4j10y+x/Nn39DdWnh+z
         kaq/eL/eD+SBKUdQZQvmkwdCnyeNhYs4wvIgXttpBqLbx09kmrxickHtOwrUqECgeyBo
         wuEhsf5JLVEJhCf3sm4TNlkhAJ5CZzXpuYrNhuMEgr2ExetnsqQqN4Ki15HrlfQtrK9N
         DLWPd5wmW37O8W8D2VF6bgNPcVLNQQkHSUX9s/y6jj65OIaZsuRF193oIM+0sTChTzuh
         ahdC0r9cxY9K4H7NmgL/WLrPq+snUwQ/qBpNH1hr8bFubuHVA0iLI3CclFb/hKI0lZW4
         nqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4KRB7VQSFOt/orLMoQi5XRj2aqP5eKf6//8IpOSgOMmStWWgZNrxAbUAV2w1nNtv9GaPTEBDjMLYoz/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnlcEt0xaWZYgj2ZsG5US6XHD+xaWeQ4386CkV3K9tg0K+8BlV
	HSZnDjkuzeMvxGSFMQ/Nv7mndSGX2JJtH4HkWtKQHA1+5dmY8du86OGQB/Oid/eao47WE7K3O4I
	ZFwVGSSenP0OmoWD4Oh91gcHmV9kYK11oSZ8xBwQ9p9THLtwr7oP2QFSP7iPPajXCT9gebb25Bh
	s=
X-Gm-Gg: ASbGnctaoXPCT8eyavWYpcFGEHYf2GIGnhBZD4uUQGrduYtTblwEDW1q85ZpZ++gX9/
	h4tdGRsK3fo0E3uPA9AWbj7KtyOdxIuotiTDZdM1s2Wj6mY2uGQh8YAxcJmVFuAJhA+eQMdlJIl
	Qc1wigTCSFaO6VmKwPsnWYMv8s/3wDqExjEwfrkZkXRCZ1Xf/J8vChZoEADZNJLzM43QQRK1r4x
	RD4L107QkrXHvcY3Dq2Bz5D+A0tKlvOM0fpGYqCPrhKEj2fKEdLifCw36wrKN/cqynW3VJZCkBy
	zwF21L1u6e4I6xRnkY75paeu+KpGqPnIclWpRY4vzUqKN2e7CFl7oT4d+G/Tj0hL5trnrlOcXYL
	7Uc5fM0TQiakqsZEEqnZWQz2gjH3cUQ1EJZZHzBDU/s6Me9YYRyeimG6HNsfQyP/2MqL/WdT01t
	9AsBS3RV9nwY5s
X-Received: by 2002:a05:622a:216:b0:4eb:a622:d95b with SMTP id d75a77b69052e-4eda4fa45d4mr92917031cf.51.1762719316311;
        Sun, 09 Nov 2025 12:15:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4ANbjuNtvdPFjoWMfYFMHj75q9eDCNJ5y/zkuJHUzlm9IN6fj+wQpDYG6CnEJQod1EkwzxA==
X-Received: by 2002:a05:622a:216:b0:4eb:a622:d95b with SMTP id d75a77b69052e-4eda4fa45d4mr92916631cf.51.1762719315862;
        Sun, 09 Nov 2025 12:15:15 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f058488sm28640561fa.1.2025.11.09.12.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 12:15:14 -0800 (PST)
Date: Sun, 9 Nov 2025 22:15:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_chejiang@quicinc.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com
Subject: Re: [PATCH v3 1/1] Bluetooth: btusb: add new custom firmwares
Message-ID: <hy62tzg5wyvrsmoebu5miair3a3s5ycvp2xisrjpwda3obnphn@uvkde6ddl35e>
References: <20251109092437.252022-1-quic_shuaz@quicinc.com>
 <20251109092437.252022-2-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109092437.252022-2-quic_shuaz@quicinc.com>
X-Proofpoint-ORIG-GUID: pixyAwV6PUOZg1F0BNk-BQByfYoR6b_h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDE4MCBTYWx0ZWRfXw4IAEKY6kR1c
 N+gIFd3fldBiErW9JAq3ZAIv8Nh39pWV+TVyJdbfT4Wqtm6M+PfdxvS/Ki/nLbZSnP59IrBDLc5
 2UgVZm9cCeLoZ3j+hRfMO8QuaVDv/QFRk/hhNeqaI1MRI/FYvK5i1fvQ/Sn/VmscVoqBMR98JqZ
 /s1EG1EZGOb4ZBeAqFwJHWrp4mOIe/U32jqYc1B1sUvDQRF47PH1iDtoQwkiIVo8p1NHmuua4+i
 xgu/0l0Fn1++YJJVJ037GJXriniSX2jcDe0ugI9S8mqU8X2LRQZ6XNyDcpQIKFIoefn9MXsFQ3/
 ii5k9QYVDYF97S4n61yzYpucULV4Sm+1DFJz+yxUSfH4QjKSlGI4YY+r2dkHEnwzBFYFZRDYqVr
 WiJI7aOAZcOwy4sUjncwWx4LqN+8Gg==
X-Authority-Analysis: v=2.4 cv=ZPXaWH7b c=1 sm=1 tr=0 ts=6910f655 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=CD0cDsPEZmLvIrSJVGoA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: pixyAwV6PUOZg1F0BNk-BQByfYoR6b_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_08,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090180

On Sun, Nov 09, 2025 at 05:24:37PM +0800, Shuai Zhang wrote:
> The new platform uses the QCA2066 chip along with a new board ID, which
> requires a dedicated firmware file to ensure proper initialization.
> Without this entry, the driver cannot locate and load the correct
> firmware, resulting in Bluetooth bring-up failure.
> 
> This patch adds a new entry to the firmware table for QCA2066 so that
> the driver can correctly identify the board ID and load the appropriate
> firmware from 'qca/QCA2066/' in the linux-firmware repository.
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/btusb.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

