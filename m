Return-Path: <linux-kernel+bounces-898218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3CC549E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 770AB4E13A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4850E2E0418;
	Wed, 12 Nov 2025 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Q+fK5qUq"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499002E1744
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983040; cv=none; b=km33QdTVUYT+hOfqUCHjwJpPrZc2YrAIrQU9s+Yr71IivGBy7ta4COhPc+6nWsvTF0PyILrZBzbRFLikGmVrH2uhM0+CttdwkYTgtZ2YzsYeW/QAQwDNuTBrtgYSKzB5fKFqLegiePPD6SGIKNjcTqfE1GdWCCptDYGGZ+gcZig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983040; c=relaxed/simple;
	bh=DCyPSevnU+J2+qum2WrrACeMVvtYuXW1zRZUGOIY8hY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=YoONMIcxc/p9yoh/dvNrgKCWkECxjzwFKEcFXSi9WP7bBU5M9/6++SPdZ/4p4tPyEczft+LsL/td0judVox2uE1TX06Mnah2MF64NUGWtR6unLYVX1Cv9fEx2K+8HKy4k4wYioItSxSkR9qDgeSxWKPfS//NOi6Qe0kQbgOPKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Q+fK5qUq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACGonpC2822531;
	Wed, 12 Nov 2025 16:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=w5yGVMWhwwvrL3xgC1inr6gkZ7Y
	TO2bxWYbujz/WysY=; b=Q+fK5qUqYF7BXQ14EYdsIw1z7TW+V74Q120I3CE5M02
	yq10rqV6ju7gzby6gWl92UZJ4ul+FsPxpFd2D+FigqsH5pNQjiKLe5aSdjfQaynC
	MlwgSFiRtMmFiHhDRvVyMGnO7d/JlzYF1mDBDBoUVOmhwUdLpDM8DROpC4x5qTYA
	h0Jz+72vcaD2WxcigPZEYA2VJQBTO2xc+8H+ekPEvHoisXpZ9wXtOtppwLE+5cOf
	A496GiyqlXF40M0xdkPZq2LT0GdX371hwpjzDMq0/3ILD68cngO0rIaAgWIZMw5O
	yRiHXra4UcinliXvPwnYgvaF5VhB10LPB5Cc4nIjmXg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4acpk2ks1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 16:30:21 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5ACLUKpq025957
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Nov 2025 16:30:20 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 12 Nov
 2025 16:30:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 12 Nov 2025 16:30:20 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5ACLU8MC032261;
	Wed, 12 Nov 2025 16:30:10 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Wed, 12 Nov 2025 22:30:00 +0100
Subject: [PATCH] i3c: master: Remove i3c_device_free_ibi from
 i3c_device_remove
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-ibi-unsafe-v1-1-d8454db22613@analog.com>
X-B4-Tracking: v=1; b=H4sIAFf8FGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQ0Mj3cykTN3SvOLEtFRdE4s0YxPjVENziyQLJaCGgqLUtMwKsGHRsbW
 1AFx2I+pcAAAA
X-Change-ID: 20251112-ibi-unsafe-48f343e178b8
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Frank Li
	<Frank.Li@nxp.com>
CC: <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <gastmaier@gmail.com>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762983008; l=3583;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=DCyPSevnU+J2+qum2WrrACeMVvtYuXW1zRZUGOIY8hY=;
 b=qgMan3urwKRIgQb0PJyvPIWaiEykS9X8Js6oP56pcTdIBnQBzGqfg1PynHL+lc7AKt3ZeubM8
 gK20999YDzFBFoFWAaNq4UKkPt3HyLQLLyzh/ka9rRWUqn9detGJd14
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=d8D4CBjE c=1 sm=1 tr=0 ts=6914fc6d cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=lSeveNQBOFyWionhGQgA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 6BEu0RuetLHqf-hHvFcpqOeDI2l0fh0Z
X-Proofpoint-ORIG-GUID: 6BEu0RuetLHqf-hHvFcpqOeDI2l0fh0Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3NCBTYWx0ZWRfX9te0ldoD7yRJ
 ktB5ctOxmAThO8KHygRPejQrLI49AAGdJ2dGAwFhjRg8iC7V7VeQyeCjgR1WJoPC1e8zCVYXs29
 CA82plVl37sol3yhkPCgJifzEQlFCXyWnaxjjmsEwhCjTAa9rlenTlxosiwqwqHKsy2SY3xDobR
 vcNUNpMtaSDz9cLkTXH1VuSlnOO8Qi9JaW/9W/lFSc4onbuqC+wVSw9SPF8K6NG99DEqAKnuAQ7
 f3Pw316agsXTFo8yaEGhCW7mPtlhyaf3yrapuDhg8ymZhUHceTCPzQN6WCuw5lRf/PrccK7cpaG
 Lyl/yssK9IA6pb3gzHRF5dA1RWWY48Ir5tYxOEtoedExcEt4Jfz0HhNNzIYHrCKV+d6BUtMMS7z
 M5IeES/IKt7yjmPu8olezAI17lbLHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120174

i3c_device_disable_ibi should be called before i3c_device_free_ibi,
however, a driver using devm actions cannot yield the call before the
bus_type.remove(), requiring to use a .remove method that is usually
discouraged for drivers that uses resources already manage. Since the
only consumer mctp-i3c.c of this method calls both
i3c_device_disable_ibi then i3c_device_free_ibi, remove the call from
the i3c_device_remove (bus_type.remove()).

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
As is, if i3c_device_free_ibi is called before i3c_device_disable_ibi,
the following exception occurs:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 12950 at drivers/i3c/master.c:3119 i3c_dev_free_ibi_locked+0x84/0xb0
Modules linked in: driver(-) at24 regmap_i2c regmap_i3c adi_i3c_master nvmem_axi_sysid
CPU: 0 UID: 0 PID: 12950 Comm: modprobe Not tainted 6.12.0+ #1
Hardware name: Xilinx Zynq Platform
Call trace:
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x54/0x68
 dump_stack_lvl from __warn+0x7c/0xe0
 __warn from warn_slowpath_fmt+0x1b4/0x1bc
 warn_slowpath_fmt from i3c_dev_free_ibi_locked+0x84/0xb0
 i3c_dev_free_ibi_locked from i3c_device_free_ibi+0x2c/0x44
 i3c_device_free_ibi from device_release_driver_internal+0x184/0x1f8
 device_release_driver_internal from driver_detach+0x44/0x80
 driver_detach from bus_remove_driver+0x58/0xa4
 bus_remove_driver from sys_delete_module+0x188/0x274
 sys_delete_module from ret_fast_syscall+0x0/0x54
Exception stack(0xe0d09fa8 to 0xe0d09ff0)
9fa0:                   004a2438 004a2438 004a2474 00000800 00000000 00000000
9fc0: 004a2438 004a2438 00000000 00000081 00000000 004a2438 00000000 00000000
9fe0: 0049fe10 bed2b73c 0047f0a5 b6c26168
---[ end trace 0000000000000000 ]---

Forcing drivers to set a .remove method instead of the wrapper
devm_add_action_or_reset, due to the call order.

I believe the best ergonomics is: if the driver requested and enabled
the ibi, the driver is responsible to disable and free ibi.

The usage looks like this:

  static void driver_remove_ibi(void *data)
  {
          struct i3c_device *i3cdev = data;
  
          i3c_device_disable_ibi(i3cdev);
          i3c_device_free_ibi(i3cdev);
  }
  
  static int driver_request_ibi(struct i3c_device *i3cdev)
  {
          const struct i3c_ibi_setup ibireq = {
                  .max_payload_len = 1,
                  .num_slots = 1,
                  .handler = driver_ibi_handler,
          };
          int ret;
  
          ret = i3c_device_request_ibi(i3cdev, &ibireq);
          if (ret)
                  return ret;
  
          ret = i3c_device_enable_ibi(i3cdev);
          if (ret)
                  goto err_enable_ibi;
  
          return devm_add_action_or_reset(&i3cdev->dev, driver_remove_ibi, i3cdev);
  
  err_enable_ibi:
          i3c_device_free_ibi(i3cdev);
          return ret;
  }

Best regards,
---
 drivers/i3c/master.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 66513a27e6e7..a0fe00e2487c 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -334,8 +334,6 @@ static void i3c_device_remove(struct device *dev)
 
 	if (driver->remove)
 		driver->remove(i3cdev);
-
-	i3c_device_free_ibi(i3cdev);
 }
 
 const struct bus_type i3c_bus_type = {

---
base-commit: ddb37d5b130e173090c861b4d1c20a632fb49d7a
change-id: 20251112-ibi-unsafe-48f343e178b8

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


