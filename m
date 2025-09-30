Return-Path: <linux-kernel+bounces-837125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F83ABAB719
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60CE24E1955
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD15525B30E;
	Tue, 30 Sep 2025 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LQllsrN0"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B72EB10;
	Tue, 30 Sep 2025 05:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759208586; cv=none; b=JfkffGtAZ6a7xEsiiq8mMvAZp92dSQ/aEPGScy5SrmWc22paNYUpaDU64/U2mRnll5ibPOCn8rVblkP9G/ESDXmG8G1oyMUO5aAaDf+BhVAJiT4ca24U8MWhwD6zptQiujIAdgzgYw3IKaE4EwnJOjobLYHFGW62OGw05n/MJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759208586; c=relaxed/simple;
	bh=R0VXzEjQC9X15y/ownEY2xtSPGqQXP6asV4BOwW5nhI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=gR7o5+IVZx3oYVaV4wjPe0GP/6SqFpf3XAvgsrlyM4QxKdDF5QLMOpcYrESZzWtY/hquxB21UDeB1GNNNDmMNyyTkSXUmZQallDH1JAz1ZIOee6mKrGPA8eAStcCmtFZBu26547Ek5lQ7IBivWASOlMQsqPsFFIrKatZBsQEd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LQllsrN0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U3unaL001019;
	Tue, 30 Sep 2025 01:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=HsMPNYv7wbF0tOcyeiwJvFSuRbS
	1U+VXaxcRNqD8SCQ=; b=LQllsrN0X4VaxtqohGZ3aqPmPQ9X7pPG2UpGcDl6XVg
	wNPLM6eURYdj8U7sRg71jeroLxil+maY0FmqIg0H2FzURjN24KH7nw7qgWicgZtF
	0wG5B8RweCBa22AOB0CtVXJur6fpaXxbWjxoz5+1bNU++KRWPqZlQY/SUiXB130q
	Q6o+SzIJ0RYCankM3fq9vY6xzNqJ1Q0nMkdEN7GvMqbGOfJG6iyKNPzReNPFaSqM
	E0qR2DJPZq33kNcEfE8QieaIrJ6EPgWBtmdV4lxlNwWAk5RCq0WRbRgTRM18D0vE
	JFj5OG0rmZrkBpqPACjtyCTa65LyGGOaehNnyvLRUVA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49ecu1pden-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:02:47 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 58U52kQQ063224
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Sep 2025 01:02:46 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 30 Sep 2025 01:02:46 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 30 Sep 2025 01:02:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 30 Sep 2025 01:02:46 -0400
Received: from [10.0.2.15] (MDONATO-T01.ad.analog.com [10.117.223.49] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58U52YIQ032686;
	Tue, 30 Sep 2025 01:02:37 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH 0/2] Add support for MAX17616/MAX17616A hwmon device
Date: Tue, 30 Sep 2025 13:02:19 +0800
Message-ID: <20250930-upstream-max17616-v1-0-1525a85f126c@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFtk22gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS2MD3dKC4pKi1MRc3dzECkNzM0Mz3eQUQwNLC4vUJHPzRCWgvoKi1LT
 MCrCZ0bG1tQD1m/HUYwAAAA==
X-Change-ID: 20250930-upstream-max17616-cd10988eb77a
To: Kim Seer Paller <kimseer.paller@analog.com>,
        Guenter Roeck
	<linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759208553; l=1238;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=R0VXzEjQC9X15y/ownEY2xtSPGqQXP6asV4BOwW5nhI=;
 b=2Bt8rMwGl/qqvXKCBPbc41DuaAQAGAirWkUtgw/FyBCbNIyHSZComuvkgoUpZvaTz3hB0B6NJ
 //QWuXASJ+OCVlUVgQSJeWFJDcf9htffLTY0b8XPyL0xaABOAMGRWd3
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: KIJKhU_yfnwVcuRblguCtlWPXeMR7-EJ
X-Proofpoint-GUID: KIJKhU_yfnwVcuRblguCtlWPXeMR7-EJ
X-Authority-Analysis: v=2.4 cv=A5Nh/qWG c=1 sm=1 tr=0 ts=68db6478 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=NfNE3UA9eXWMGTDrDeoA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA4NCBTYWx0ZWRfX7PNY8KrWPRzc
 3du5+KO6rceQ8cBA+NKRIZfnZqa4ymPQIN7LWl/LnjCVWLkarKb1YyIwmcLv/Ne/bcy7RuIUMV3
 hSkg6ZtTYkNqXNtMxaLPmuZOD1gqqQU/tIQd3yE8xJiZ3jcmNSjlMhfRr/MDGvQRM9lTzKKJalf
 Bol5DWpHEU4gcF9vHxjmklrM/0TU6eKEBkgAYQOGzr0fYJVTDTvZ0hh8Kuf3t9ZIIfVvshDjSNK
 jHVOtcor7TJh5/dbXnvag1XFkl5pZyPFRP9CC0RRzzsoE+Kf7OTZiFLFDij0fq0Goy2jTlyy4Na
 nakA2VXR7vht9h2lhkxCt5OytUGcSfdrSFUT/v6M9VBiYTe5OLoxusLDcqG9+NnT6NLYre+Hwbj
 BPdL06Fv4879/lft02G+nObr7gHZug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270084

The MAX17616/MAX17616A is a current-limiter with overvoltage/surge,
undervoltage, reverse polarity, loss of ground protection with PMBus
interface. The PMBus interface allows monitoring of input/output
voltages, output current and temperature.

More info: https://www.analog.com/media/en/technical-documentation/data-sheets/max17616-max17616a.pdf

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
Kim Seer Paller (2):
      dt-bindings: hwmon: pmbus: add max17616
      hwmon: (pmbus/max17616): add driver for max17616

 .../bindings/hwmon/pmbus/adi,max17616.yaml         | 48 ++++++++++++++
 Documentation/hwmon/index.rst                      |  1 +
 Documentation/hwmon/max17616.rst                   | 62 ++++++++++++++++++
 MAINTAINERS                                        |  9 +++
 drivers/hwmon/pmbus/Kconfig                        |  9 +++
 drivers/hwmon/pmbus/Makefile                       |  1 +
 drivers/hwmon/pmbus/max17616.c                     | 73 ++++++++++++++++++++++
 7 files changed, 203 insertions(+)
---
base-commit: 76bb6969a8cfc5e00ca142fdad86ffd0a6ed9ecd
change-id: 20250930-upstream-max17616-cd10988eb77a

Best regards,
-- 
Kim Seer Paller <kimseer.paller@analog.com>


