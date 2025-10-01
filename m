Return-Path: <linux-kernel+bounces-838296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C80BAEE46
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A263C77BD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E94E1DED63;
	Wed,  1 Oct 2025 00:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GLd7DXSU"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E7E14EC62;
	Wed,  1 Oct 2025 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759279086; cv=none; b=F8gjkWB0xTE0+LFQitKi8ApCiOLXdkudG4OKzW6Y+CHsvtIcJQM50YyAbzFN32z+uzzTn/16Jx4N5Yhhh9QYci0vpP31CpsNBIxfWJ+EvZXYn8i0dE85WPLjywCrquenqH6OWgk92gJCqUCXy5FEf/eki9Y+1qzqGJO05sOTOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759279086; c=relaxed/simple;
	bh=8BLqL/BsxJ26HK4J/to4+4q52U9ucf8JK8/bDWdDw7s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Ig2u98Yb8ob5Cd+jQ20HT5bITANz/7yIHMswoBjc1s4bAY1T3sk2+xgcWd06gQizVoI4uRLJEoQ4Mr5Eyv93eqzClGj8KbWBC7GJ8zhGgKXrIO0FrX8ozOywxWGWCZ3/HP7Ib69lg10LyqMcpfE1cCP3wbvhsP1E8ila74cFXw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GLd7DXSU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKPKwK026871;
	Tue, 30 Sep 2025 20:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=j/6WPyUEhW9bKT3fK0U1EdP9t/9
	5jNdHMq+RbpueDEg=; b=GLd7DXSU48Omhl3TcEvFfl190qh5hhscPCuuVmLSQjK
	O/HD1RC+g68b+tF6EY03udcwyLuBemxnP2DblqKE6JpzENM8672si0n+DcZVBArG
	7r3yflcF0ipBRw+mkKiCZpD60pFDLzwoa1JLs0JSNBK3pRLn0LgkPUvg5pCTekGc
	qZcLagl3pU9FvBh7s/apG04Rl+gz+XoaRDdlb6fBpE7TXLsHUSHtuzn4yYW6794v
	6IoRFZWLiPCST2jYHJpZnmqEVYR+AQCOKo1nDZM9KN10R5tpV29TsGl8KHmh5wIW
	9C4tctar4Anawxx1PCbEvK29ALQAFqDfRiQNMrk0ajQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49g7sjp6pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 20:37:51 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5910bolX029478
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Sep 2025 20:37:50 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 30 Sep 2025 20:37:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 30 Sep 2025 20:37:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 30 Sep 2025 20:37:49 -0400
Received: from ATORRENO-L02.ad.analog.com (CAV-GBS-L25.ad.analog.com [10.118.9.50] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5910bcY1015453;
	Tue, 30 Sep 2025 20:37:41 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Subject: [PATCH 0/2] Update ADPM12160 and Add support for ADPM12200
Date: Wed, 1 Oct 2025 08:37:06 +0800
Message-ID: <20251001-hwmon-next-v1-0-f8ca6a648203@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALJ33GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS2MD3Yzy3Pw83bzUihJdo8SkxLRk87RkU2MDJaCGgqLUtMwKsGHRsbW
 1AOsgY+5cAAAA
X-Change-ID: 20250930-hwmon-next-2abafc7fc530
To: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Alexis Czezar Torreno
	<alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759279058; l=1212;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=8BLqL/BsxJ26HK4J/to4+4q52U9ucf8JK8/bDWdDw7s=;
 b=uEsx28+mp5V0f2Qnp6GsCV+4S6kZA0nXOvqix3srGLV+TheRennc9XgcCN46KF64nWP0Qrm1U
 Ai3r4RFpH13AFy5jK2NqskhfZNsTVkddJKs3OQ7H/Ex9rNfaQEt7v1R
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: yuROg56aUWTZNMUC6ph-fR-g_w68QbUS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDAzMyBTYWx0ZWRfXwh37NDp5pJxe
 vV8JeNI7+UXp+RkJA7imuw/GUQgcSbEBU+ZK6xwE8z/tBvHn5Y+zKIpLi7SwOjiyRYDp5m2KJTA
 6i1IBgFAfapokQc4jjFFT68p2VHG10z3VpJB4T5SDzwjXWujTg0jMYJsSGecoNzf/gVcw+S9kqt
 wEtR6ct6TpVfyz7jlWa6YFB/snXYV5daOzR4KsA9AjbTN2/q9DZeuTyOHFqopKqLfGcb2W+aj0e
 nudMJLXoJQkyFQze7oCunua28WS2Mw6QZXuFdnnhLHVec2NyYDig7i35mq6u3aVuJqE0Rmblmwp
 ig8huEq2akEYayvCrt+pmWpdxJVHVnGlfUCq7OzPfhg7IiEFTwJx2DE8XJxb4BmZSZWuQrkKndw
 9jd3nVb6YdDRdsrYhL4rkx3ETL0TJg==
X-Proofpoint-GUID: yuROg56aUWTZNMUC6ph-fR-g_w68QbUS
X-Authority-Analysis: v=2.4 cv=U/CfzOru c=1 sm=1 tr=0 ts=68dc77df cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=pX8K7AMcFWmkIJv9s54A:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509300033

Commit 1 updates ADPM12160 coefficients due to a FW update. The part
has not officially released and will release with the updated FW. Since
nothing exist publicly that uses the outdated firmware, this permanent
fix should be ok. Linking the old patches of ADPM12160 for reference.
https://lore.kernel.org/lkml/20250320-dev_adpm12160-v1-0-8f7b975eac75@analog.com/

Commit 2 adds ADPM12200. This is similar to ADPM12160 which is a quarter
brick DC/DC Power Module that delivers fully regulated 12V. It has a
continuous power level delivery of 2000W.

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
Alexis Czezar Torreno (2):
      hwmon: (pmbus/max34440): Update adpm12160 coeff due to latest FW
      hwmon: (pmbus/max34440): add support adpm12200

 Documentation/hwmon/max34440.rst | 25 +++++++++++++-----
 drivers/hwmon/pmbus/Kconfig      |  1 +
 drivers/hwmon/pmbus/max34440.c   | 56 +++++++++++++++++++++++++++++++++-------
 3 files changed, 66 insertions(+), 16 deletions(-)
---
base-commit: 76bb6969a8cfc5e00ca142fdad86ffd0a6ed9ecd
change-id: 20250930-hwmon-next-2abafc7fc530

Best regards,
-- 
Alexis Czezar Torreno <alexisczezar.torreno@analog.com>


