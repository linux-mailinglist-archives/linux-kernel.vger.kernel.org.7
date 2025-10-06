Return-Path: <linux-kernel+bounces-843244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE3DBBEBE3
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5EE18983B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429EB2DCF47;
	Mon,  6 Oct 2025 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KU77/ZbN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF6B2D94A6
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769516; cv=none; b=cRrWgaLtG83lWE74dJWS/oSBpLgxrzslBbQbjAD9/Zme26nfRnLJHAgWVajWBwt6okhklZl672+ynwqveqTPEo+i2g4TUu2113CBAOA0wN5aClNIOeqGZ7ZrpXZA8JIthvb3sqym5p4spz7DBDJYC3zVSde5MNioG8wfagg6nTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769516; c=relaxed/simple;
	bh=A7UJsAckvltDqfaftbZweMIKjCKDFpp6wuMlEL7ZXd0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HPnTW3qG0lJUpGgvX3b2dq7ufkg8Dmn79yoVavqJIzo8KjURtdNanGPF3Cdhe88zasZL9LF4X7jEGwXPizLgxmlSf1m62l1IYIiVaQJ55klqgAV1F/7yjICYctIMPccUcRBRqaVkUp6ox9AAb426chRM4NtRYHMfXR4T63f8EjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KU77/ZbN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FBIuQ023928
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 16:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wo69v9N0i7yus5uBIq03Txo87lWpTPaftw54sQRNMhM=; b=KU77/ZbNmc6ao1z/
	zwv2bS8FUKkxW5HkGNXc9wgmj92lxSW3JP6G3PSA9mkaBrvcC34bWoECCCSZXAJR
	Hukmjfsi14Nb5aZ+jgJlvHHnCPL7/OkA5JuPJrFIK8Kt3oGplT02/CyCtEtpnGA8
	5+XsSrujzh77LnoAN5ENwKkQaeljI2L+6Dh4Ho59TjHjFtYHWrTMI1QLEH8c08In
	jqiIiN74N9dPkZqWjuquJQI5nmlTLJtw9/cv6d0pAbaeuLfCX7IFH4/YHfjybcZd
	u9WOYHx8i95P1iBLZY6/6K4kPArixDWoKDLuEsU5eFGdK0eCs4zxYD5VCt1TooHr
	cilU1g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mg6a891y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:51:54 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so8680007b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769513; x=1760374313;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo69v9N0i7yus5uBIq03Txo87lWpTPaftw54sQRNMhM=;
        b=B0wp5ovencLxEbDzbXuD1djJCLbTZL45j5GygHZ9n8+faKVs7FROB2zUMCARBh5902
         o1PSeR2ut/whTa7WPcJfB6US/Mb7CFBb3wESJPQ/EgwcVHsPH1yobM1K9MUiKqUvLUkc
         m7Gi3qp6aL7zUnt0wTisg+9N09pdeYulmm8/nj3GoLwscT6CVpt031vBjodXR1HgjdLv
         RAM7xSnvhy28BzRWOdUU6hGm7eQFTItNmvM6J3c+vmCkXp8YPJEPjHkpfsGcCDQwqagM
         rd7O0hGmKcb9nLyFGBXyNxGvnFAYDW0FQteSZFkyUATOxXjPA0LkbiGWkFbiCj82dNMQ
         ntfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHSocjhKZv9ZPKGR0tN0ZChbiDkJEsgVYbi2vfV29qipuHDh0bibwe8qv2CNbdXv+wcM3+W2/sRo4V3Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6nXphtR3gBEJiWfEOqLjtbGCpg6GtoMBKKDj68aKoB0e8SW7N
	IyTMiPJv8bmVPq3Zq0YRbnTC8ReCodWGyQtAZi7DDpN3yPF1UUbGyCZO0Cw3KV7KFRbcX1kC/R1
	wJPQ1A4xG+BEphR5GjTFE5VGrGFRvmk673RxpZUDAtgpfKXE2mYvVGqYWjiXhkONrLg4=
X-Gm-Gg: ASbGnctQvvyOonJNgSSgtgVnZn/straRD/PGJ98VQFbNrFMbj7OJtx7msuf5aIwLegJ
	B4tg3jM44A+HKi3i/5qUvb3qZ1v5bmJ9Grv9TI3TctStx5CYFop81PISrAhpQuSCIk6VMw59XrK
	hQp7nJ/9KOjLLu3ZazdZnLGUI8FR4iPrkQ4xZo1I5jAWJc34SgTaysEV3T+gXLSukjo/NFazOJe
	snrE5qt2rI3CH/Iu1TcA8jWhJUNL2ZDPkawNzTwczgc5XuXdNLuzIKNmTVCt+wb7hY9niJH2tmA
	NW2i6iCxIYfbudW5/pDcShJR5xwqSgzGXiYXL1mHLvusV3ni/59VmcpUfmoeZrEc7mgqLNGOUAf
	rwPJgGg==
X-Received: by 2002:a05:6a20:7f8b:b0:2ac:7567:c069 with SMTP id adf61e73a8af0-32b61e583d9mr17724734637.17.1759769513490;
        Mon, 06 Oct 2025 09:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETt6fN2a5uQ/TBgiYmhUZtcG9dd8mwsIIRymgKPE6BSHmuorQefyP4JFbxPMwBPSwvxcbj8A==
X-Received: by 2002:a05:6a20:7f8b:b0:2ac:7567:c069 with SMTP id adf61e73a8af0-32b61e583d9mr17724705637.17.1759769513059;
        Mon, 06 Oct 2025 09:51:53 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0205336csm13293176b3a.45.2025.10.06.09.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:51:52 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: jjohnson@kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250929192146.1789648-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20250929192146.1789648-1-mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH v2] wifi: ath11k: Add missing platform IDs for quirk
 table
Message-Id: <175976951234.3451922.1302880550621653546.b4-ty@oss.qualcomm.com>
Date: Mon, 06 Oct 2025 09:51:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=QtdTHFyd c=1 sm=1 tr=0 ts=68e3f3aa cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=4eKdMI8an_lkvHNd_m4A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: MIHknkS3MP8LHDLfaQ0CU5VlD5Hvr2ZB
X-Proofpoint-GUID: MIHknkS3MP8LHDLfaQ0CU5VlD5Hvr2ZB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMSBTYWx0ZWRfX8lB/mYI/6tPJ
 e7H1CFaxMFXlUq6xbdIA+peTUEp6znHyXOivWhaQQ0Svofx9BtrfleoFAM7cB9C9ToC97cHTJd9
 9EQJY5yaXpByUY0Jmraj2kLBMtw02kmCFjfhTq0ZNWwC8yV8KoCIi8RkX1weEQeIBt4vA2Vx8Ph
 r7nmdsR9jeuu/2/03ZC2ZTYB5OWUcdp9uliNLOI5QFdh1aNmR6NLRFehWOxGGi+nee2yDYuwIQu
 THFUPt4PnZvxuANSBXFwMX9E4wTGK00IPbnEBLZIhox3KgdozV1E8IDmylrmn6HMIcWSVrw+U4l
 T/8HW9Jw0tNRn6YrfdhkHT0PTnGXDhXi9TZ7EuLwjFYUI1b3VgSH5srKJqWYQPZKwedHFH9eV68
 n89aH+UKljbw7Avx185Ygy5jHa1+gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060121


On Mon, 29 Sep 2025 15:21:35 -0400, Mark Pearson wrote:
> Lenovo platforms can come with one of two different IDs.
> The pm_quirk table was missing the second ID for each platform.
> 
> Add missing ID and some extra platform identification comments.
> Reported on https://bugzilla.kernel.org/show_bug.cgi?id=219196
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Add missing platform IDs for quirk table
      commit: 0eb002c93c3b47f88244cecb1e356eaeab61a6bf

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


