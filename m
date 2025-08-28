Return-Path: <linux-kernel+bounces-789904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F72B39C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F564666DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFFC30F55E;
	Thu, 28 Aug 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QJFt/4dv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14DB30EF9F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383007; cv=none; b=pXt3rUpt+lUxXm2ZaiB8nGDycxN5eBoRyHuHUIEemxURdoZkuFHAUlKlCHoqOaYVgxx2eUPx64HjuN0gPvxlMfRaqBEHbRtisQsCUmFEy4Cl120UsOR6Js4b2TdvhyXpCNPTWn3WBIKwNkjEomvmgH2aZTqQwnOgd8YhDM8olMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383007; c=relaxed/simple;
	bh=fmCVWwvsFOC0IPTia4wk7audEaDOpQ5OD/rFcq2x+T8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XjfUQaLfSq/icEhNt/XOrdAUf147eBeWu/yIenHRgJ6MXFTeJtubS4pHTsA622mfPrSZ/S9kDQr3z69xuNB+qrjKFCjuitQ/opSfCtG3z66A8+S6WlPkbGZA9+n3oIAZlrAVIUfGjKKc+1eH2g8BdKAbUHNGs489Af2KdS+UJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QJFt/4dv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S94C8g007201
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7CBo4RsO1OtHtmHnfgVDg7
	Mz0lcVGOkV5Of38is0x70=; b=QJFt/4dvLk01+Sf1U4efBMYxrqr7DQxobVw5k3
	ePY6CVc2X3id7Ln5cclpNqtwiJbrfd2/oYbBR3IrixxAwdR0R9MhkCB+TmZJLq0h
	/hWQjrXgKTj7w2HKTPXRmJbTtdVzPa/T2p+piBCchm0x5ZnUJyVxqX57AlfZo2mV
	CSxKv57khcgatU8d0vjwpt4oxMC/O5cSjExXiqOU73iXTOSwSQNTHCBaB/h1AjYo
	4O+0JzGjtnC4rDXfYb5/XR5cYftPjuFgS22ObH/LqfO9eJOz65TDrWXqBYVSlLSc
	L9kdVyN4Ev+e/0pOycUyBm8HlvgIKeglJIiOzWk1ge6H1CTw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tbpghv77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3234811cab3so1121906a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383003; x=1756987803;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CBo4RsO1OtHtmHnfgVDg7Mz0lcVGOkV5Of38is0x70=;
        b=OnaR7BeR0cscA+6hDEHFpX1ngjfpIFnGr8Av/fP17chgmO7ME8hGQIltp4blBtECyf
         VwS4kyz1RXzjiNx7bIFUV6wDe3SN/Tuo2rG8SHfpOlPOPcuJoOEFjDUfKboojzcDJE7b
         jJwX9EG2U76g0N/5U7T38KK924FDIg0G7arB1tOz76NpHu34B6s/4GsfDM0qf+4S/Noz
         n/ShDEuiQPqed6xLXWUYWXt1t3tq7Wpe1cdMqflr7iUHNivgPfq+u1ySRSlkB9jIPLoW
         xjwD1m0fUlhnpaoyFamMS9xeRmcim532NilC/I6SZabbtX3+N8lvqzFvYgMmwXL9uVID
         RG4g==
X-Forwarded-Encrypted: i=1; AJvYcCU3FfmSmDqRTWqnKnNxkRWxWF7eeOmw7sdtSyiRn4Uz3A/oq77IsEU8fryYlaGTw7L7JkZK14WmwHVho5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg7EEpNE3TNpLlt3RGzUTFljYmFax5mDwoE3Qp+id+A8hyhvd/
	EWZDSwJbd5v2noxIL6alecA3V+o/WKPfWEvSpJbzkLGtzmoO2xME4ALgSAXq2Kf/spz9hxsg89s
	kaMaUDtb1ZwoemMJDD+9hLzd6u5ZNtubH42C9oiL1QBPph38Te9qjRNDkJ1ItgmLVWlE=
X-Gm-Gg: ASbGncvI6G/broaHVwDr4MuhuqtN2fZY4SvTSZcHcTPrkA+89GSA3AkAIAAbIzJTI44
	V6tkglvVjO/FPBbBIqj7isAY5gWil7WVq1k2Kdd3XPu+wlqufZqYmWWba27d1QJQA/WauV9+94I
	qZjiI1SLT0dvAe7hrIBMrFnXiphIH32nwuonKNA98pl+0GIqdFzqPQYFyzh1KsiCO5eIzxvpUzP
	qMAVJEvmXLvKGcO+lub+/Y2zT1fQtUunRp+8s0xqom9fY2iuIF+3XrRt6cvdnQDJwG5I90gz9/3
	z/mcUBiDngUmQjl01xRELcbQYUQljoz5HDtllP+gGWJ7EBm3unV6C4fL3vOZ+MPwpebNZHrUD2Q
	=
X-Received: by 2002:a17:90b:3e89:b0:327:aaeb:e80d with SMTP id 98e67ed59e1d1-327aaebeff2mr3337431a91.7.1756383002721;
        Thu, 28 Aug 2025 05:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGShFwQdg1pXVH6TjbXej5/b8b+Ns3k7qKTLxyF2H8wNDEb5AkmNYw+GftmViK1wKFDqMPXpw==
X-Received: by 2002:a17:90b:3e89:b0:327:aaeb:e80d with SMTP id 98e67ed59e1d1-327aaebeff2mr3337372a91.7.1756383002079;
        Thu, 28 Aug 2025 05:10:02 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32741503367sm4019070a91.0.2025.08.28.05.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:10:01 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v6 0/9] PCI: Enable Power and configure the TC9563 PCIe
 switch
Date: Thu, 28 Aug 2025 17:38:57 +0530
Message-Id: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANpGsGgC/22P0QqCMBSGXyV23WQ7umld9R4RMvUsB+nU1SjEd
 28aEWU3B/4D33fOPxKHg0FH9puRDOiNM7YNQW43pKxVe0ZqqpAJMBAMONC+c5KL3Cc5pzpDCVp
 xnmaSBKIbUJv7YjueQq6Nu9rhsch9Mm/fHvnl8QlllKcIVSV2UIA6WOei/qYupW2aKIzZ/kJBr
 FFkmYxjlRaVztbo/IkXn+vJTwsvgkIUUjHJY9BY/lFM0/QErI8IJysBAAA=
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
        Shawn Anastasio <sanastasio@raptorengineering.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756382994; l=8072;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=fmCVWwvsFOC0IPTia4wk7audEaDOpQ5OD/rFcq2x+T8=;
 b=dntgyrpafu+Mj5IVIc77CSF3hlcMUe2yGSqQ48lTbPzSV6qF9wgaXfinZ370jrXGNl5oSiuZf
 peN02jJk2InDqtRom7uM9LZvHNA4KsH8wmspIc3xbAhCu4eTnsbZZxu
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: JNSZ5tCH4vu43hBIyZBWHfg7SvRgxwfC
X-Proofpoint-ORIG-GUID: JNSZ5tCH4vu43hBIyZBWHfg7SvRgxwfC
X-Authority-Analysis: v=2.4 cv=G7gcE8k5 c=1 sm=1 tr=0 ts=68b0471c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=yKAn6K1XAAAA:8 a=COk6AnOGAAAA:8 a=jdgvuftHn8Q9ZZcfGlkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=6M1ixcW_PCWoKiWyFx5v:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDE5OSBTYWx0ZWRfXzJnUlzgKSNs7
 4UI7c+oy75bDMSnfeDhfe4Tmy5FYOjUugwVbm1+T/g/YEMXmIqY4Yu47qaB3P7gxQwIjtMvdifY
 g3qyjVe2qJ9gLuARHNn26fN7lkZT4ds/ERWAUNaPyW1V3ISQV07vXhXrWeY/wgFPKkgU2zeplJB
 PV+4PqcAw3aRQ4CakczwR+Rq4LlVZxErh0YJH2WnKGIWYkY9hWkZYEi5kLAEVKzRI/s1rI9zyNV
 kRVjuExj1r06SQbkIT/OeQxO1ULsjXYY4hwUC2sh4ZyqcD8ctvRCJr+Hilr5bU8o7pXmyp0Gs6+
 eclPBfW1BuXk7VAap4kPSk8jZ4EYlLQtE5xM5mlYR5EJkyR/7cKCUVmyCpEMncExNhFfwbXKHnZ
 ch4hpvbB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508270199

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
Krishna Chaitanya Chundru (9):
      dt-bindings: PCI: Add binding for Toshiba TC9563 PCIe switch
      arm64: dts: qcom: qcs6490-rb3gen2: Add TC9563 PCIe switch node
      PCI: Add new start_link() & stop_link function ops
      PCI: dwc: Add host_start_link() & host_start_link() hooks for dwc glue drivers
      PCI: dwc: Implement .start_link(), .stop_link() hooks
      PCI: qcom: Add support for host_stop_link() & host_start_link()
      PCI: Add pcie_link_is_active() to determine if the link is active
      PCI: pwrctrl: Add power control driver for tc9563
      arm64: defconfig: Enable TC9563 PWRCTL driver

 .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 178 ++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       | 128 +++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
 arch/arm64/configs/defconfig                       |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |  18 +
 drivers/pci/controller/dwc/pcie-designware.h       |  16 +
 drivers/pci/controller/dwc/pcie-qcom.c             |  35 ++
 drivers/pci/hotplug/pciehp.h                       |   1 -
 drivers/pci/hotplug/pciehp_ctrl.c                  |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  35 +-
 drivers/pci/pci.c                                  |  28 +-
 drivers/pci/pci.h                                  |   1 +
 drivers/pci/pwrctrl/Kconfig                        |  13 +
 drivers/pci/pwrctrl/Makefile                       |   2 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 637 +++++++++++++++++++++
 include/linux/pci.h                                |   2 +
 16 files changed, 1062 insertions(+), 37 deletions(-)
---
base-commit: 07d9df80082b8d1f37e05658371b087cb6738770
change-id: 20250212-qps615_v4_1-f8e62fa11786

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


