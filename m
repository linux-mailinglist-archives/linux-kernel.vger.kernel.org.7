Return-Path: <linux-kernel+bounces-891994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 250A8C44091
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 15:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12FA34E57B3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378F32FF178;
	Sun,  9 Nov 2025 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQH7vgGi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YxO4yW9K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908892FE56C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762699122; cv=none; b=uNhCsFy3m+TVVKz5W8dlJQsYJhnmNy0eQ/KzXIUS1zJeD7kXKLBlSqOvpzlLuiggN5DhOXyCG4Tkj4I85AwrXw/u3vUO4lp/+I7BKj9MOoN+oEqMKCcf9TS2nsiAkbMKLERfjISBBROQsA2o628mmV5Wu8ksHLMM8f9FInvejs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762699122; c=relaxed/simple;
	bh=KkC4QSxclwx5Tk4AVwolzQwcYruXvNFOfpqU998deKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r9GWhJB9ydG56PCCdwi/IUL4sYzuJEXu1DRJ7kG0OkrQ5FuIXvZ2eW+jGmkIgsTTqthBzaw7ih7mmLevhlMCqDe3xcWYhrSFdQ0LLB9a+DiUoU1qJrDReMe3+vxh2zSXCnsU6n1YH2JWuk8DbPLDef7JoEP8jRh4CNWXx5dgxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQH7vgGi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YxO4yW9K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9ABlm9159474
	for <linux-kernel@vger.kernel.org>; Sun, 9 Nov 2025 14:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4zriVHHzMQQ8ELUT932V4l8RDRcEXWAm2X8YnUX13NY=; b=fQH7vgGixjiezK07
	fHna/+OSPKGwQ+ItQcFWBf75PqMmDj7mK0/1WjMPhxYBYZXlr28l40xHB9zumemM
	Gf/N5j2b+WjKVUTWYYITipRoXxviQIGEzlClo/y+wJN1aNLSn370ihi1GDKmJCnL
	C6lxzlJmDcvSiKQS9eZueFxfb8xHXuWwjGvQlJkLjiPboPrtuiTs5NBczHedbfPM
	76XMxwKiH+Wit8LYvT3xoZ4qQdxM8uNVE0kVakSpwaaLGlGIHlS/qIISX1FS/aae
	3X0Jk1nk94TUTFLPx0+QYNO4LRv/o7gd88r5RfUdaCHQl9JalTjuXTbQZg/pqPvW
	0Vr8dg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xu9t7da-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 14:38:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-343725e6243so981202a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 06:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762699119; x=1763303919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zriVHHzMQQ8ELUT932V4l8RDRcEXWAm2X8YnUX13NY=;
        b=YxO4yW9KpIvFZbjymrxiUPEdTaJaHX037L0Zg9KeUJlIEXH/wWgXB8OsYEqmrHuML5
         IsncZnEzhhs4iEuu6o7XSkQ5xHHtWhldr35gkRKghhqJq5n8eeVPUBe9J1oi0MeOkCf4
         Ri7qd/yPq3oTQjiWAAnHPwYvK+sYCvwgbBUroocsoXlb0wjk94g5KpvOuGwANXPPUuAu
         7Q+OX3UbM4eifwgIIKH5LNeO78gfRSLiDIgWVA2DWexMyR2IETADWAWRbQQP4La9PXSu
         GQI0T+3llyOMEjM6VocMb/qe/2x+atRA5L5J5Q5CuTJyEuSmfvj+6kvVxH7pyolxoage
         814Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762699119; x=1763303919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4zriVHHzMQQ8ELUT932V4l8RDRcEXWAm2X8YnUX13NY=;
        b=eGYg0lmVu4OMIE5IDRrvlq4y3aNXQMifd/axxnEMdlHLj14y4msIGNx3yIeo0eb375
         bnk7x6MgC7rEItJkimnB5iFG6ILaKw9QB8gEcz1nQ5QBKzfkt0PqLh4o4VJ8Knj1QeWP
         Dsfe9Qf4xYwvI9Xn3HvA8br+2xzDv46lYkHMem40E0mhZVOpZktsJiVePlPFfx6ayCze
         Bp1deWfS4MYhGobqpwFRAwni87snjel1WxK3lRFolhEfZIFSF27TpdF+QyNhka8YmbUj
         eVmi7AcKckn9ITl1Hn7g8e/t3N+PT/i/F4NmkBwC283UTCLFhxaaPAcM6xrAXl3ku+q7
         9I5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7mkFmNNc/y7I4RaF94F6KG5Vv4C31boVLPy9FjdtCaC1/DlVPNXGGLuwAvFlOwlkkr2YAWTK7Sns4iRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweurlg6sMsoOSBaA7nD9uA6/LVTEUSbSahaPpAxDpsa3V9sKgG
	uS4xfW6nl53uMdlVN32vFGEWx6S0DpXxK9dL8LazGaIuBPPEqdCcps2uQVKYhOQMShNuIhJcxkZ
	mkOXbIzLWK9SXE599+BOFumjdnZIrNijGo22fdvk+1UMJc4Wq0llkzNA2/XIoxyD4anY=
X-Gm-Gg: ASbGnct7YZvybufBgXB6pDmpgecRrPED89eGgCAPHDpUrldXWp4Htn6FNp8hOfxBud3
	xbXTdCwtsQ+YFekaeLLk5YFnUTO+BSoIQuAEH2sxdfas06MPym+Znaj1SWDGpzKuawu9XYytUhT
	Q8Nz1jFHh5DOBuf+YbnGrQbxbp8Agdaj2VSPRzyfbiq8zrXuQnCQzJvNSO9U/DheCE8qW3GvaOT
	8OzAGez6PRsrfeFfZMvi/7sP6syHrRN1ZxGcvQZX8fHtGOwEqW4lmflRUkAyFSMvMFTMKbGGylH
	bWVe2zkA8GBVbqNxHKPOyPz21JX8GEnqU4VK0huE5MigCsfC2soRhxQuzIjXnxFjrJTTMJ8sC/0
	X0yJLPlr2tIaYas+71bG3P16YgPgFskkr8L4=
X-Received: by 2002:a17:90b:2fcb:b0:341:88c5:d58 with SMTP id 98e67ed59e1d1-34353778f97mr10161808a91.13.1762699119024;
        Sun, 09 Nov 2025 06:38:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ8oa2bDV/JZ9g1CCPavF/hAUNJNmqCBo60PmRDygnciNNIeyHDQbrbNCCVrsDLl+kVYkWyw==
X-Received: by 2002:a17:90b:2fcb:b0:341:88c5:d58 with SMTP id 98e67ed59e1d1-34353778f97mr10161766a91.13.1762699118507;
        Sun, 09 Nov 2025 06:38:38 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a68e6sm14845401a91.4.2025.11.09.06.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:38:38 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 20:07:17 +0530
Subject: [PATCH v17 04/12] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-arm-psci-system_reset2-vendor-reboots-v17-4-46e085bca4cc@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762699073; l=2381;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=KkC4QSxclwx5Tk4AVwolzQwcYruXvNFOfpqU998deKY=;
 b=SqWaS1L4R9/PRetPDl5ezV2V1ONox0X/KxMUmUzwxKvHFi1GczgvDsL8xutCsbzcMU539brQM
 euC4liUMVlvBRKiwx/WOO31aamwBf3jSBXBW4Fc21qvaSDRKVnvttJf
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: fvQ1lDHTpLpyh4-YVP1r6ypaRQbjwZu1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEyOSBTYWx0ZWRfXzBdTiXRoJZrc
 rjAfA0mx+bVg6Lc7CClKrFSPIPANBoTvthPs7eF5H3YVeDUXXO6vBKvmJ2QYhwE4MrPIMgnSnRS
 BMsneoir7G028BADqmMTWFBlFt1Sjh2Actu8sCZUrZEnSBIhf6efjvbq39F0R4kTqmNz+esiiJ+
 I7QbryZzsz+pskv/xgwHWEMi772W4+9hJ2TltY4F7P7UjoghuT8LXGCyKGB+g6K5AlFzQDf0TO1
 8VGeZRIwSpzYi0gYwHQoCsVS0YZUpVFuwMIkR64TIBk4GZ2LYFtAXVw2QncDDV9zafg/0gBbbkw
 xKiDDa24CORXurDSCuWoM+gD0ZXMapgjt+7XQWA/UQ26iqIHQJXZQjctFRQSKHT36jWmKlHyfvw
 J0+Z4Z3XjMi5EW4f2LpMlxka0TbUxg==
X-Authority-Analysis: v=2.4 cv=ZPXaWH7b c=1 sm=1 tr=0 ts=6910a76f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=5CgfHzhl2afHKY-Ush4A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: fvQ1lDHTpLpyh4-YVP1r6ypaRQbjwZu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090129

Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes,
a read-only sysfs attribute exposing the list of supported
reboot-mode arguments. This file is created by reboot-mode
framework and provides a user-readable interface to query
available reboot-mode arguments.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 .../testing/sysfs-class-reboot-mode-reboot_modes   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
new file mode 100644
index 0000000000000000000000000000000000000000..6a3fc379afae3a6caf56ad0b73b1c06c43a9fee7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
@@ -0,0 +1,39 @@
+What:		/sys/class/reboot-mode/<driver>/reboot_modes
+Date:		August 2025
+KernelVersion:	6.17.0-rc1
+Contact:	linux-pm@vger.kernel.org
+		Description:
+		This interface exposes the reboot-mode arguments
+		registered with the reboot-mode framework. It is
+		a read-only interface and provides a space
+		separated list of reboot-mode arguments supported
+		on the current platform.
+		Example:
+		 recovery fastboot bootloader
+
+		The exact sysfs path may vary depending on the
+		name of the driver that registers the arguments.
+		Example:
+		 /sys/class/reboot-mode/nvmem-reboot-mode/reboot_modes
+		 /sys/class/reboot-mode/syscon-reboot-mode/reboot_modes
+		 /sys/class/reboot-mode/qcom-pon/reboot_modes
+
+		The supported arguments can be used by userspace
+		to invoke device reset using the reboot() system
+		call, with the "argument" as string to "*arg"
+		parameter along with LINUX_REBOOT_CMD_RESTART2.
+		Example:
+		 reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
+		        LINUX_REBOOT_CMD_RESTART2, "bootloader");
+
+		A driver can expose the supported arguments by
+		registering them with the reboot-mode framework
+		using the property names that follow the
+		mode-<argument> format.
+		Example:
+		 mode-bootloader, mode-recovery.
+
+		This attribute is useful for scripts or initramfs
+		logic that need to programmatically determine
+		which reboot-mode arguments are valid before
+		triggering a reboot.

-- 
2.34.1


