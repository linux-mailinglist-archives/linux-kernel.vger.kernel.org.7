Return-Path: <linux-kernel+bounces-875892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC55C1A068
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2DB52357FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5E331A6C;
	Wed, 29 Oct 2025 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h/ZmG+RG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W/bDjoyK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B232ED5B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737411; cv=none; b=fKIbwYp/twhY9moyw4BPER/NmfUI/yPHExano5L9tVxCwE50liTADBDnYu6gpfJegyR4HthGa4DaziwBafr7A1xR9H8bwP+7motQYUHDTDCffLeMY5OeuwIWveOAQh0nGBMV9nly1Fgk320/Lp5RREo1+dvbSdxlLQw4TADpyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737411; c=relaxed/simple;
	bh=R1ym5za/YxWveqf8yqW0XLv+wHPbUS9FbYThihnVuwo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CeZKnLO/XqIGljRxS6KeczTP2B1SZKRdyjSTgwzgZV63aNJGikt1E8sXuzN4cK56aByHAd2mEnmkYoFKRvT4GKd7xZJXwiy4OSZC9ovXr7p9abBi/xCVCvnnPcII29FGVgHtZtZboCE+zIDtj9/dsLNIo0478rc332alOvAZeJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h/ZmG+RG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W/bDjoyK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4vCES3664310
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=y2jm9dDHlt5T0Ww3rdQuy+
	Lar+Wls5nknPdT9+n/cKI=; b=h/ZmG+RGoH9pG0BiiGDv4tYKhgoaATxZgX8AAR
	MaxDEkM5y3lkB7H9czQQCS2rDx2tAJ3q8Yr1vA9EnxuiOIQTsbDUc17abckMYNbM
	k7v42vZ397tHxg889o4zpcovxeyxfDFZCr9XW2i/Fi8rcgwvNfSqLSxStL9WX7ee
	a9x5bvRgKiJjWq1vya5XVL3vYawvGV0Km7OVbdnH0IoPnioxOJ3Ykhbhx9Z9hviE
	KZZtOopzIGeffTzgEeGIzfplv7c+Qa74FqCIC3yO8flXZ4eU+bcFZpG+cZI7krqG
	7m8NW+fnS7KCvJlVobEeuE6NrczUkUBMMTWeKmA22deRXSVA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1ta7u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27c62320f16so71858205ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761737407; x=1762342207; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2jm9dDHlt5T0Ww3rdQuy+Lar+Wls5nknPdT9+n/cKI=;
        b=W/bDjoyKbRDcchJnF5njmV/2k4jjswBynwEL9gZ4R07QTW+Za9x5NbFOyhfgzKZTdn
         7oPV2fJlwYUTmWYwoJK4mh76+6omgmllvLQu/HFwYGPVcYktVrm20ScoEWt48KM8aUTF
         Mm20L+qB5H4uE71581yVVZPfxSgs3IZsLOKt1vigxlFWbaE/zcYC8UqqVpVx34XrR65c
         nqeADQzchT3mVg5yX3nz/zeaPpYMxT4/mlIuK6AF6dxpSDjZ3F1yIWUbrWdzpFbNYpAq
         ayoS/ZxNsTwl3LNBbGhH0WBv1yl1cRVtTI7OkbzdakiW23JS//l/aAzTrtMXTUNifeYL
         IvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737407; x=1762342207;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2jm9dDHlt5T0Ww3rdQuy+Lar+Wls5nknPdT9+n/cKI=;
        b=LAx8nqP5uZprlyC0ZosW3OEReI1VEYeL9TosVLRbMZurlvMvEc72l9atcwZha+scrr
         Iauc/xOELFuMA0uGwEPifxlZ7SUdWXRshRuloHQAn34x94tApk/VNlbWocALFKmOy9KF
         L8ebiEpDGr6AedqWZnwo99zeCn2kLNYrmKNE65De8DY1fvf2WB4qN7kUoyDlDDbfxoje
         8kKBbiPMX8B2n0JArsFAbtT0IllRt4IT9uE3Q1aco50MfsPsw7HcYzOzAAb/raDXjxoE
         CMSzuJ66pjZ6upkcdW6d1TY0eEr+2wK9dFJGGfN1DbuOMxooK+3tyKVBc/jsiUEG4KnT
         owTw==
X-Forwarded-Encrypted: i=1; AJvYcCVFoKMQjvXqZyN3iEGv00meKT20Y9ne9WjhsAPoooCXTng+rCvzgSsTbvylyv4jgi/Z1t0yIB0de9PMJgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwscotEo14DDNRO5qwgc4k10QcxrJMrfazgaaemlQ5smQwyDVvZ
	+zBaTDS3lbxilWz88bzvZO0OC69GL9yJPG/oBbyH0/KXvCAvLZLL+CHv488o31u7TAXGGkuQU6Q
	5q69hbqnu6DgnjGM2rwQR4R+pXTDQOg1l8am4LJ2UrKn7f8TLdAAO4+kJyIvd2Sgj8ck=
X-Gm-Gg: ASbGncum/vziIADstbsPW+ojZKFXludNAkH+eVGN0n+l1HC+uHZqQFPpxqYJNp+hOLa
	834EswqvGirwXIB+2m5EuFA/QrXWF0Xk1CNCRCmZjNy7fmexFZiEGCdzXGToTwsfJhScbNUFfQ3
	TkvEjSvIupWISN0FQI09/SrqOFgnGs3z+FxCQo5h7+XWXyHpWLCezqY0YVA6IHMsTdSYEZhVAys
	Cr48k27SAccDZHwHvYlMFwG4t+Icka8srWk8bA7NGlWRCV+lhEbtlsQSxvGLxubBOFb2oWVlUnL
	qN1rCwFG0xwzaaE+NS35tJ+VueqrGp4j6yyXkg/BFI0dfdu4WSWDNY50RcmIDOtD5HLPCIqWuXO
	17bgNi0BTcjZfI7NgrNmeZPkJ9PGweaZ0rQ==
X-Received: by 2002:a17:902:cec1:b0:275:2328:5d3e with SMTP id d9443c01a7336-294dedf4a48mr38764625ad.18.1761737406183;
        Wed, 29 Oct 2025 04:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4QuNCki4+zixZpMZK9vnl/SsRQHgfutzx405yAsnm6xucYwg8APiRkZJ1SC61gScEpYJOwg==
X-Received: by 2002:a17:902:cec1:b0:275:2328:5d3e with SMTP id d9443c01a7336-294dedf4a48mr38763585ad.18.1761737405134;
        Wed, 29 Oct 2025 04:30:05 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d429c6sm152154935ad.85.2025.10.29.04.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:30:04 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v7 0/8] PCI: Enable Power and configure the TC9563 PCIe
 switch
Date: Wed, 29 Oct 2025 16:59:53 +0530
Message-Id: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALH6AWkC/3XP3QoCIRAF4FcJrzN0dh3drnqPiHDXsYRqay0pY
 t89t4jo70Y4wvlm5soidYEim46urKMUYmh3OejxiDVru1sRDy5nBgKUAAn8sI8o1TKVS8m9IQR
 vpdQGWW7sO/LhfNfmi5zXIR7b7nLHUzn8Ph18c1LJBZeawDlVQQ121sY4OZzspmm320l+Bv1RB
 fVdJWGwKKyunTff1WGTpF7Ty48rksqEqtEKlAV4av4Q+CIMmHcCM1EZ5SthtXOi+EH0fX8DH7u
 eKW4BAAA=
X-Change-ID: 20250212-qps615_v4_1-f8e62fa11786
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761737398; l=8142;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=R1ym5za/YxWveqf8yqW0XLv+wHPbUS9FbYThihnVuwo=;
 b=bjXMRd2WO29QEf6QHKNYgV7NOKh0WLgIi02TP4pxrqdsKJFGFfIjo3fQCVGJcZiYaQi2nf1Vp
 UHhcG2ULBeiDfn0h7soAhL7KTlWxDbcQF7DkKtL5xH0YpkfQ+mKoojl
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: UJrceAmnl8iyShGn5BPRJCy1jgEsx_9D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA4NSBTYWx0ZWRfX7cacnKXv75OU
 +zZkv0oaHbmtABkmWrd6vLD3sSFvr8zVXNdXLmYlNspEMpAsvfBBlWpfx7Ubs74gZsHTVnaXOxZ
 C2QMf+Kg1U3DMlAPXqDX98nBIap9nAmShY22aucAkpSI/32VOVzgJZ2rPAQfZBva0DKcWkFJDl3
 jDFM9Mb0SGguMaOEkkmUoPAMyEIutEjaKo0ZFKI2kZvAlL9ye5QMzF179lkY4xJytf1VRuv/f/5
 3RkVhfV7axfxE9QPYIp3sJd8L5OfPmYYwqhPLUBHfXVnBKb2FrFtR4jP6Qum8mXEmy1C/ZpjJTv
 3nsNAZ2ZKgWJjNgPgDbo+vcXbEwrzlzQnOCIkdV8qn5OkY/kZbHcl6kwpKQo1d1yICDHBVwxDAo
 cyvRE2NO18Rlrfi8QAEt9dhEQZnXVg==
X-Proofpoint-ORIG-GUID: UJrceAmnl8iyShGn5BPRJCy1jgEsx_9D
X-Authority-Analysis: v=2.4 cv=UObQ3Sfy c=1 sm=1 tr=0 ts=6901fabf cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yKAn6K1XAAAA:8
 a=COk6AnOGAAAA:8 a=jdgvuftHn8Q9ZZcfGlkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=6M1ixcW_PCWoKiWyFx5v:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_04,2025-10-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290085

TC9563 is the PCIe switch which has one upstream and three downstream
ports. To one of the downstream ports ethernet MAC is connected as endpoint
device. Other two downstream ports are supposed to connect to external
device. One Host can connect to TC956x by upstream port.

TC9563 switch power is controlled by the GPIO's. After powering on
the switch will immediately participate in the link training. if the
host is also ready by that time PCIe link will established. 

The TC9563 needs to configured certain parameters like de-emphasis,
disable unused port etc before link is established.

As the controller starts link training before the probe of pwrctl driver,
the PCIe link may come up as soon as we power on the switch. Due to this
configuring the switch itself through i2c will not have any effect as
this configuration needs to done before link training. To avoid this
introduce two functions in pci_ops to start_link() & stop_link() which
will disable the link training if the PCIe link is not up yet.

This series depends on the https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/

Note: The QPS615 PCIe switch is rebranded version of Toshiba switch TC9563 series.
There is no difference between both the switches, both has two open downstream ports
and one embedded downstream port to which Ethernet MAC is connected. As QPS615 is the
rebranded version of Toshiba switch rename qps615 with tc956x so that this driver
can be leveraged by all who are using Toshiba switch.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v7:
- Rename stop_link() & start_link() to asser_perst() and change all
  occurances  (Bjorn).
- Remove PCIe link is active check & relevent patch,  assume this driver will
  be for the swicth connected directly to the root port, if it is
  connected in the DSP of another switch we can't control the link so driver will not have any impact
  we need make them as fixed regulators for now.
- Link to v6: https://lore.kernel.org/r/20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com

Changes in v6:
- Took v10 patch  https://lore.kernel.org/all/1822371399.1670864.1756212520886.JavaMail.zimbra@raptorengineeringinc.com/
  to my series as my change is dependent on it.
- Add Reviewed-by tag by Rob on dt-binding patch.
- Add Reviewed-by tag by Dmitry on devicetree.
- Fixed compilation errors.
- Fixed n-fts issue point by (Bjorn Helgaas).
- Fixed couple of nits by (Bjorn Helgas).
- Link to v5: https://lore.kernel.org/r/20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com
Changes from v4:
- Rename tc956x to tc9563, instead of using x which represents overlay board one
  use actual name (Konrad & Krzysztof).
- Remove the patches 9 & 10 from the series and this will be added by mani
- Couple of nits by Konrad
- Have defconfig change for TC956X by Dmitry
- Change the function name pcie_is_link_active to pcie_link_is_active
  replace all call sites of pciehp_check_link_active() with a call
  to the new function. return bool instead of int (Lukas)
- Add pincntrl property for reset gpio (Dmitry)
- Follow the example-schema order, remove ref for the
  tx-amplitude-microvolt, change the vendor prefix (Krzysztof)
- for USP node refer pci-bus-common.yaml and for remaining refer
  pci-pci-bridge.yaml(Mani)
- rebase to latest code and change pci dev retrieval logic due code
  changes in the latest tip.
- Link to v4: https://lore.kernel.org/r/20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com
changes from v3:
- move common properties like l0s-delay, l1-delay and nfts to pci-host-common.yaml (bjorn H)
- remove axi-clk-frequency property (Krzysztof)
- Update the pattern properties (Rob)
- use pci-pci-bridge as the reference (Rob)
- change tx-amplitude-millivolt to tx-amplitude-microvolt  (Krzysztof)
- rename qps615_pwrctl_power_on to qps615_pwrctl_bring_up (Bart)
- move the checks for l0s_delay, l1_delay etc to helper functon to
  reduce a level of indentation (Bjorn H)
- move platform_set_drvdata to end after there is no error return (bjorn H)
- Replace GPIOD_ASIS to GPIOD_OUT_HIGH (Mani)
- Create a common api to check if link is up or not and use that to call
  stop_link() and start_link().
- couple of nits in comments, names etc from everyone
Link to v3: https://lore.kernel.org/all/20241112-qps615_pwr-v3-3-29a1e98aa2b0@quicinc.com/T/
Changes from v2:
- As per offline discussions with rob i2c-parent is best suitable to
  use i2c client device. So use i2c-parent as suggested and remove i2c
  client node reference from the dt-bindings & devicetree.
- Remove "PCI: Change the parent to correctly represent pcie hierarchy"
  as this requires seperate discussions.
- Remove bdf logic to identify the dsp's and usp's to make it generic
  by using the logic that downstream devices will always child of
  upstream node and dsp1, dsp2 will always in same order (Dmitry)
- Remove recursive function for parsing devicetree instead parse
  only for required devicetree nodes (Dmitry)
- Fix the issue in be & le conversion (Dmitry).
- Call put_device for i2c device once done with the usage (Dmitry)
- Use $defs to describe common properties between upstream port and
  downstream properties. and remove unneccessary if then. (Krzysztof)
- Place the qcom,qps615 compatibility in dt-binding document in alphabatic order (Krzysztof)
- Rename qcom,no-dfe to describe it as hardware capability and change
  qcom,nfts description to reflect hardware details (Krzysztof)
- Fix the indentation in the example in dt binding (Dmitry)
- Add more description to qcom,nfts (Dmitry)
- Remove nanosec from the property description (Dmitry)
- Link to v2: https://lore.kernel.org/r/linux-arm-msm/20240803-qps615-v2-0-9560b7c71369@quicinc.com/T/
Changes from v1:
- Instead of referencing whole i2c-bus add i2c-client node and reference it (Dmitry)
- Change the regulator's as per the schematics as per offline review
(Bjorn Andresson)
- Remove additional host check in bus.c (Bart)
- For stop_link op change return type from int to void (Bart)
- Remove firmware based approach for configuring sequence as suggested
by multiple reviewers.
- Introduce new dt-properties for the switch to configure the switch
as we are replacing the firmware based approach.
- The downstream ports add properties in the child nodes which will
represented in PCIe hierarchy format.
- Removed D3cold D0 sequence in suspend resume for now as it needs
separate discussion.
- Link to v1: https://lore.kernel.org/linux-pci/20240626-qps615-v1-4-2ade7bd91e02@quicinc.com/T/

---
Krishna Chaitanya Chundru (8):
      dt-bindings: PCI: Add binding for Toshiba TC9563 PCIe switch
      arm64: dts: qcom: qcs6490-rb3gen2: Add TC9563 PCIe switch node
      PCI: Add assert_perst() operation to control PCIe PERST#
      PCI: dwc: Add assert_perst() hook for dwc glue drivers
      PCI: dwc: Implement .assert_perst() hook
      PCI: qcom: Add support for assert_perst()
      arm64: defconfig: Enable TC9563 PWRCTL driver
      PCI: pwrctrl: Add power control driver for tc9563

 .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 178 ++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       | 128 +++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
 arch/arm64/configs/defconfig                       |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |  19 +
 drivers/pci/controller/dwc/pcie-designware.h       |   9 +
 drivers/pci/controller/dwc/pcie-qcom.c             |  13 +
 drivers/pci/pwrctrl/Kconfig                        |  13 +
 drivers/pci/pwrctrl/Makefile                       |   2 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 639 +++++++++++++++++++++
 include/linux/pci.h                                |   1 +
 11 files changed, 1004 insertions(+), 1 deletion(-)
---
base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
change-id: 20250212-qps615_v4_1-f8e62fa11786

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


