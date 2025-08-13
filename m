Return-Path: <linux-kernel+bounces-766078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002C9B241FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9D6582C12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0172D5C9E;
	Wed, 13 Aug 2025 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxQbe5gb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83CE2BE021
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068145; cv=none; b=uInrNLeNUUXdCLiXY4u7/Gz+ms1c7CuZ6S1aUI5ewHnZM0c3Cl0uk5Sq7hGO7Gu/HoxIGH6zYOQSD86Mn6IuPE59Iyy5A9/2s3HGs8a0PiwznSthzcxYbq3o30kC9yV8aTP9B5X/uEnVKAfOf8p/f8N4bMrrk24Qh8+xGAdRtwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068145; c=relaxed/simple;
	bh=NT3OXZ+6VFZb8CMe4L1nzdruLP5ekCY4F22ZMO9+lwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cw22z7FtRDjz8GCdHp9CGlFW9gG3S5lwPPAeF/+1hZ3ot6OEfionpy2mClHq2rcWdeccILd2FcYc7ZqSqebHW3hMQ4MN/M0YqSkKfc8mBXh4IShyf1bkG5bLwW5n0Y/PDlJCtFRhx98vRoLN44pSvdkzHfvnsvMdPLBN7HW6qfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxQbe5gb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mGTv027019
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=v89RUCwFdyomRq93Seq/cCar3eyic7DgZed
	XTAI4uzg=; b=GxQbe5gbpLOK9bhiBmB5lyEEGQEQ7ItuzcZg167xiPgvg67eGwy
	1O+dSkpAak+F8DwahEiDpb/Qybc4Db8uRnWUcAvuQrcMZ/2OZKPvUhH42BT6sSRT
	6qCTP0N2KjJAHJskku51iFXTp9S+WA7H0hKwCaS2jw6TcPen6AU1T//u0Jq3riSi
	AIVQj21tsOLWyxxGd4e8Da3etLVjEnGw0t1WHbcKzk5pCPKWEjUYA+B3fnv2E4X2
	d7r4QQJPCbP43xdCAykfowvXRW/TUuHNLxqOb6yjMSVdGh71TjGTKyYRKfPu+dn5
	xy0D4psnMDm6VXneJsaIjXn5fTUXgfPnChg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmaqwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:55:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fe28867b7so85450345ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 23:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755068140; x=1755672940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v89RUCwFdyomRq93Seq/cCar3eyic7DgZedXTAI4uzg=;
        b=sVQD82JjFwBKwLsp0UBQcW4SqSL2pwhNtsQDBGuwM9t6c0dTn4Sa4U9DscypWrplkQ
         21ew92c2mau4r15fDOBzUk7pd5WntD9T+NeVTTSDGka8+tV8bitYUKTlcQOfundV7nU4
         m3zpljCcfTjEopODkbeVa7j1whQ7QK0HaG+PTXcPvu/J07Xp9YgRl6L/LhE+67IUaEzs
         2J3ICU/398Y6ydmBEALEaprwrb/EBiDWXGeVeDubagNRAvkeeP74G8PNIhwPkpWfkj4t
         KwWnwD6GAWVrgtobu4Royn2FucBFZHNmeGqmuy4PlOWCAu+07Eu2NzszhAxP7bAW/C7S
         WA/A==
X-Forwarded-Encrypted: i=1; AJvYcCXLpYWs7L58emk/HRJTxrv6ojd2iUwAg4xBsvbPN6Vy9CSBTC6Cdnno98d1MaoNhN3Pu56GEEMbnMR/7iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/mudrHa5lUxf0YiaV7N0AtPUTDhNRsCA5bUD4BxwxSjsIxJUq
	iL6QTmGjX84NijA1WrrioWRj9z6JEIYUc2sC0VKz3B/zHpnb2+Z7+Brbf3Q17fsCHeLtvEoqaHC
	TbEPWx3KLJkku6AxmPktMq1F1J18PFOqpseXnwt0XKhOqsdBLWuoRw1dQjZ+/duNduRo=
X-Gm-Gg: ASbGncsfA2+UcPqSuH+HsjXTzvRP+wu50s3hZijSUrm2krMvrXRfnkoiiZfAlct2LHb
	QXWjE+xbHJUI+WpN6T78U3IAu6P9+HpFjixlv/VdLRk0bqz1goo9BoR0gtC9+PgbW6H/lEIkc8V
	IuOe/1/9DG8RGCf93UsZzJcOBhwpYH5TofSedJOscAhpd20vilrR69rR6LeM+H5/TcwFNh/+Du9
	Oges5qsL10TILj9GelEGVoAqIIsu+n7chOR+ia0Qb7HDVDxjrk2D5fcoGHryp3WBD1xDjZelLX1
	LeToKbqIN9MlK998D+BLkrmryiWmIrSGZ8GZNUSYvTwuG5Y1vN8Jmp2DOAfYI0U8upg63lEa4x1
	/vrTpdbnbfoLc5aNge+W+KpxZKhpAfAXNQABBuAWQljJdXTkIx/gkktWVlwzW
X-Received: by 2002:a17:903:b8d:b0:242:9bbc:c773 with SMTP id d9443c01a7336-2430d21de4cmr30253785ad.54.1755068140555;
        Tue, 12 Aug 2025 23:55:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjoz7s/dXHcA7mFMizX3dudhJwmJQlObOlwhL9SP3pNoUbNrgFVCMigCH22Xet8aYtZ6XYew==
X-Received: by 2002:a17:903:b8d:b0:242:9bbc:c773 with SMTP id d9443c01a7336-2430d21de4cmr30253325ad.54.1755068140008;
        Tue, 12 Aug 2025 23:55:40 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899aa1asm315958875ad.122.2025.08.12.23.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:55:39 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: andersson@kernel.org, linus.walleij@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        rajendra.nayak@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] pinctrl: qcom: Introduce Pinctrl for Glymur
Date: Wed, 13 Aug 2025 12:25:31 +0530
Message-Id: <20250813065533.3959018-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX7jK2t1ffs7cz
 Pz1ynO8IcRn6iH52W773gPLc8sZ0QbpJbaFT0cqZju28HU+VcgCYIUu107mku0zjPSzxYQZf629
 YKtv948j9WgnRdJLVN1kvPn7OeYRW+EHCSfKMCENOcMjcw+p6g3kSIPbmsUoIhwWr4dRvJAw6eh
 xNLLB76c7CGfYSFaHMyaO+a2QET+rn6DQp9F7JDlyblxVuWDVUfQaJSQm9qwX05cQzNT2l5qnVu
 pFkHVwKNc5JdRBKgJFDtvS8bhtG6Q9wvcfPmsAk+qK2+MtyMAV+nrmNF2rTyrppevl6yqtc7ZlS
 Ci5xBR6tV/b/87qKrSiahchpMuqYBBapLDYEkE9hzeAYSOvuiFOp+iFfTMJwFNXlANR4c1/UMfF
 W28vJB91
X-Proofpoint-GUID: NCo8p-HK33VOkU7Ts5uzccAUSZjW6X7z
X-Proofpoint-ORIG-GUID: NCo8p-HK33VOkU7Ts5uzccAUSZjW6X7z
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689c36ed cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=2OwXVqhp2XgA:10 a=ne6LWfaJPpk26Hbpmm8A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

Introduce Top Level Mode Multiplexer dt-binding and driver for
Qualcomm's next gen compute SoC - Glymur.
Device tree changes aren't part of this series and will be posted separately after the official announcement of the Glymur SoC

Changes in v5:
Rebased on top of v6.17-rc1
RESOUT_GPIO_N changed to lowercase in bindings and driver

Changes in v4:
Updated bindings to column length of 80 char

Changes in v3:
Fixed indentation for example tlmm node in bindings file
Fixed s-o-b and review comments in the driver

Changes in v2:
Fixed dt-bindings error from example node's reg propery
Fixed gpio-line-name maxItems
Driver UFS_RESET macro updated
Removed obsolete comment for pingroups
Updated ngpio to include ufs_reset pin

Pankaj Patil (2):
  dt-bindings: pinctrl: qcom: Add Glymur pinctrl bindings
  pinctrl: qcom: Add glymur pinctrl driver

 .../bindings/pinctrl/qcom,glymur-tlmm.yaml    |  133 ++
 drivers/pinctrl/qcom/Kconfig.msm              |   10 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-glymur.c         | 1777 +++++++++++++++++
 4 files changed, 1921 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-glymur.c

-- 
2.34.1


