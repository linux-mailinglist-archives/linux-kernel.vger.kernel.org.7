Return-Path: <linux-kernel+bounces-772858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC456B29898
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEC23A9AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF7F266B72;
	Mon, 18 Aug 2025 04:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UOYTTFc/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EAF264636
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492101; cv=none; b=FG4iB9CiX7qjPzJEjNHAs7tVYo27wKqLf5MqKdjfgh0i3kCDy/q/uFAfyESE9UM7uBV6JJphqQRDQlTfjCA2dGIBHmbdlhenX82exszeEG0VlILzI+lxZOAGg5qgmK3ebLd8JyJu8K+O7prrfaSCTWFClyD89bRw+GEvRD4nW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492101; c=relaxed/simple;
	bh=uDnTCUlVtYUEnhAsmvmthDUWGvkn8yZ73+H3knBCChU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bXlGy9V3/qIbn30GkgxuEK/rQudhd+LEqKxrCwQWOSpP1QJu6lH6ESn9rZJUAv1T/nepIV/iN/PNuyRpF3Gy8plKvvVvnr00//025zkho6G+pHSPd46RWXkqhKjnRG709kAhVi1678g6vz92qKUtb9do+10i7yMvoltAdCwJrh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UOYTTFc/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HMjjFE004060
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=o7I5IvyDpDsrud1uxxC1FO
	tgxPWQpfNuEtfugWVnsak=; b=UOYTTFc/erC4fPfz8RAalVneWLd/EESS33toDB
	PwesgbCjJ+s1P6mFrJb19zLedA5k4WoiFJSaqY3ZAfKBk+ZkDABVmZNQYu1QxeSG
	sQ85p0v2Kix9UzlRs1MRjTTlsgwsUkHntLZ1QYwya2PJOi9ui/1AFr2+m0LVZsKp
	ydqYbKlzAeW4xdkZS8q5Pjg2aN4XryCzzgD/CzW2j4alxg4sD2vv9W5s7eSMRvVC
	xlBdu9BTQVeaLaz5yySVdUbHN0hxuMY4cx77EnTdrAvqzgVZe9VwffnhUglBJtsn
	8NjaIDkIB3Nqwx1UX+6JChHmqPQsdIyWeU4ykEN9LisD06Ww==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh073a0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:41:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24457efb475so42115435ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755492098; x=1756096898;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7I5IvyDpDsrud1uxxC1FOtgxPWQpfNuEtfugWVnsak=;
        b=M9EWEHw+J45srLKXmojhyOzzl/mCShHmmxDapBUW6KwVMt4AHXFgg014caEB/xDWfJ
         UbuTGhv20l7VIV6jCwoQ1OyoVW2ctZekn3j+dv4ooydfVlleKAd5wWlZ/LZb5d0miD+M
         TTfb6MwKLQBQ+vt3fMUnFQXgymmlpc6u2tRhQZNfE0qVfnxNibwBRdwGeVBFNCETkMl+
         sfBGkXf8Dcag8Z4i5Xndor1K5byGReWFcVAUz1mciS+tR9XFDSJ1CRmzNPd7Qlgbqy8M
         SFgZfQvCkZg36FCXcMr2SpDyld4HEZIbLB/XRvp+nfzjabjLTP8Ppd5GkRY3mwpAPCrC
         012A==
X-Forwarded-Encrypted: i=1; AJvYcCV/rmS0ACunLX4PQXiQZLjpTvWi52dB3LQlQEr8nQ0YbgcGbSgDfU+ENh+IObDnH38GRqp0t2OFJezqSB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4TmXSNwZqdHAZOOjxHMaJCMDOf5DyHOIXeJxo2hFmM4J8r0Z
	1D80xGwnOEMFE17gbJpAElulM5DD/J2l0czwzstqXvvFeQOybK3hlBerqIJlWaU/O957T/gD4nC
	5AT8hMxjR2ncRgyB6t8Bbp1Kie8BvtUgzW9zblr6c37PiaU6vAci6/ZO2Vw6CVkjdOj4=
X-Gm-Gg: ASbGncuwcR3mJ/0Wrtw/m/LTL3MeGqP6w+AnjZnQRzaJpcaj+JdpxRyJlwbU5TkloCF
	CQknlX7o8PWy6Bb6mlcn3L5qsjjzZ5px8MwNR1enZQ/NylYRSHUt8Jyjgzbo9hlcjcJs8KZ2ld3
	IxKc+DdkqXO96vH2HeDs9Lkj3bem8o7JAryyt/LZ6kPRAuRwr+9TqD5+EmLs0wycyrFvF9O6xjy
	G4e+JEjPUqeTDsM2vCI9VPgYLC2IF9/i99BXhL/VaBS/5DhaSLXfiI3hm/y5nzP0vuYLrd/0iIG
	Y/wiVlbjXJf3AKtK7wkIU5NR5hKoOhStYnGeS2xa76L1N3rRWhFgu6Aps5KTuF9U6Cp2vpUWD0B
	2YGa7OAi3DNznawi/CvjQ/5VCLKzHzf0zFYiaq4cCOzNF8rnMG/2vN10x
X-Received: by 2002:a17:903:2288:b0:240:50ef:2ed8 with SMTP id d9443c01a7336-2446d756f99mr124189135ad.21.1755492098154;
        Sun, 17 Aug 2025 21:41:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgpeqD4kU2YgdCDwpl0WnaZOy8L39AQdgkY4anazhYf3iTsVeZyOcpkw9FZe+ue2OHfVzGWA==
X-Received: by 2002:a17:903:2288:b0:240:50ef:2ed8 with SMTP id d9443c01a7336-2446d756f99mr124188845ad.21.1755492097690;
        Sun, 17 Aug 2025 21:41:37 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53ba5fsm67547155ad.113.2025.08.17.21.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:41:37 -0700 (PDT)
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
Subject: [PATCH 0/2] Modularize SX150X GPIO expander
Date: Mon, 18 Aug 2025 12:41:22 +0800
Message-Id: <20250818-modularize-sx150x-gpio-expander-v1-0-c2a027200fed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPOuomgC/x3NQQrCMBBG4auUWTuQKYQWryIuQvOnDmgSJijB0
 rsbXH6b9w5qMEWj63SQ4aNNSx6Qy0TbI+QdrHGYZjd7t8rKrxLfz2D6Bbcu3nXeqxZGryFHGG9
 IS4ouLF6ERqUakvb/4XY/zx8W8Q5GcQAAAA==
X-Change-ID: 20250818-modularize-sx150x-gpio-expander-cef7fd0a7511
To: Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fange Zhang <fange.zhang@oss.qualcomm.com>,
        dmitry.baryshkov@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        xiangxu.yin@oss.qualcomm.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755492094; l=653;
 i=fange.zhang@oss.qualcomm.com; s=20250714; h=from:subject:message-id;
 bh=uDnTCUlVtYUEnhAsmvmthDUWGvkn8yZ73+H3knBCChU=;
 b=jTwENWg0yo/FzfRh8Zq338WcnEPGHT7GBuPKLFuCbN8N5GU0P4PIlg8/A8qeEl4WfIzqif4Fn
 CiriMa59r6LC/Zhw+QRK78H2UqOPYMaH/Zx3qxA26aS9ASWcv4BjKHq
X-Developer-Key: i=fange.zhang@oss.qualcomm.com; a=ed25519;
 pk=tn190A7bjF3/EyH7AYy/eNzPoS9lwXGznYamlMv6TE0=
X-Proofpoint-ORIG-GUID: FS5v8wMzpxMq5Ej1aMFjUOV0VyZm_ub0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX3q1lsUepnNAF
 gAH/s3Y4c5/IsusW4owsB2K/HVNJE6PLiGEVUUDdQrExBlPe0E3xROf+XJMar0paVsDnar7EPsT
 8QJDfqksEU9Tsu9clOMuJVbKUlgMb4TGGCHJ67VYAfUfraZ3LzVOryIhocgDRRKkArKVK9athzp
 KUB1pSiNgfMLjjjSgXBeJy/crrP1ZXaNYEOcGD7Jy1mjQ+S+w1YxybIR6NooTwxYOESC8XIZX1a
 +KXQ43QjutEA4v1MhYPnaG3EloTO16852nz2sA+6kP+7LzvVT+6Vse9/kkBjSN0lQjC9h1Y44uO
 C4lErqqYHYOVF77UH1nWHDoLw3CtjbFrSx8knIrRocnehEux3UCn4i0wCs5kAgac6YkPpzbYipY
 V/DGuoAS
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a2af03 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=li5FUaLgavnFvxL7-nUA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: FS5v8wMzpxMq5Ej1aMFjUOV0VyZm_ub0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

The ANX7625 relies on SX150X-controlled GPIOs for reset and HPD for
the QCS615 Ride board

Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
---
Fange Zhang (2):
      pinctrl: sx150x: Make the driver tristate
      arm64: defconfig: Modularize SX150X GPIO expander

 arch/arm64/configs/defconfig     | 1 +
 drivers/pinctrl/Kconfig          | 2 +-
 drivers/pinctrl/pinctrl-sx150x.c | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)
---
base-commit: 1357b2649c026b51353c84ddd32bc963e8999603
change-id: 20250818-modularize-sx150x-gpio-expander-cef7fd0a7511

Best regards,
-- 
Fange Zhang <fange.zhang@oss.qualcomm.com>


