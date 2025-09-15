Return-Path: <linux-kernel+bounces-816464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA1B57416
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A68E3AAB6C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0061D2EC57E;
	Mon, 15 Sep 2025 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="TAYZKgeM"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3E27604E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927161; cv=none; b=JXObdIbNSXAVZzQPkZUAzRMBPJ7bm5GZXy1LXvgfJT3z3c9pxB29BTvU0t9AhNYEHsAI7d75myk+c+OtloCCt6pxlqqshRUqXtDjJ5ef/6oLkX1hzcdhzFVXX6vhYQEv6NgmMLJqilEZCEm3NTb+AGihGlKd/+J5uSuLjNUGMq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927161; c=relaxed/simple;
	bh=WsoOk4de4fNm371nwUnTsBkS0Tj/8NNZzSNv6ehGp4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=jFOZe+ke6rZOB1G1cC05LGl3YFwWsHUJPSk+41tgYn1axP1acg0spvTa4OJZELnr4lkIWjTYbANd9sQxlQKA6wVZz2DX1GOi3zm9SGQxPjeUCRpNUJPTnH2N1JrVnOVgJh6INIOzq4kbO6VWqVVyKb/duCaBmRafbhVADs45usA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=TAYZKgeM; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0F3B1A0A37;
	Mon, 15 Sep 2025 11:05:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=vG3AmUlK7TLVEv8sjEgplP4++DgjWOVyUZ1fOM7EwBk=; b=
	TAYZKgeMGFZjb9/2rlNcOyHXbObH6F1lURcsfpdcg0yzc3YBImKxucQTj1O+kiWj
	/+wghKYsQnAwL67Ga31U6tYFIOoACJ1vUoSpjcoqMBitoUkIrRvDIzHpu23NmPg3
	F/lIG6el4VX3pd6PYjni525oafG1zkrHRCLPVfEf+4pmniMOfSl+VcNf/lVTRjLK
	Ii1dXJLSMml2A6awADkyreQQRrRdSiTgRRiDRGIimpESH9XoyzjmfZpkiiKWD1Xf
	taKUIy7eOcuqIInPunlEIQrjpWs5KhgOnEGXkNvrkDpJRouardECCRpIz2/6D3JJ
	UtqM1my0PRVcZj3do+aNyDFh0xavyGDCZnFHB89xAlkeCtNbuVS2nuwnZgshzoAH
	q4m7mUW9ImC0Zj+WOBOo9oDGShfWvLrTOnEvB9+QrOdEO9NFvExboj+RLj9PSuW9
	IjOir12Cpjl6yW0ExrTPVw+BJh5xfiQislt23XLx339fZa9lUvFWELHvGXidGKcb
	OP3h/gqdNtGNB2Xtc5SWh0U/IZAuYq5I1eIjTo/4Nb5oPIoMcl1/rZopgsxcL8Hz
	T8pU/9H+fF02XbD8LzkNSoghedZpSq9j5iQ5JSk9v1/V4ISMGes2OA6TEpO4oeI2
	FkUlg6bXRgkFrYhEoCvqrj8KQpMFA6dZ4CU/myyB9Bk=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Mon, 15 Sep 2025 11:05:42 +0200
Subject: =?utf-8?q?=5BPATCH=5D_mailmap=3A_Add_entry_for_Bence_Cs=C3=B3k?=
 =?utf-8?q?=C3=A1s?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250915-mailmap-v1-1-9ebdea93c6a7@prolan.hu>
X-B4-Tracking: v=1; b=H4sIAOXWx2gC/x3MQQqDMBCF4avIrBtIhFnEqxQXk3SiA02UGZGCe
 PemXX7wv3eBsQobTMMFyqeYbK0jPAbIK7WFnby6YfQj+hjQVZJ3pd0lLCV6DNlHhF7vykU+/6f
 n3J3I2CWlltffvpIdrHDfX/Lvj9dyAAAA
X-Change-ID: 20250915-mailmap-b5ff9051c095
To: <linux-kernel@vger.kernel.org>
CC: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <bence98@sch.bme.hu>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <bence98@sch.bme.hu>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1757927147;VERSION=7998;MC=807671872;ID=54041;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E627266

From: Bence Csókás <bence98@sch.bme.hu>

I will be leaving Prolan this week. You can reach me by my personal email
for now.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index aa09e792017f77b2d5c46ad5d6f4799d89ccedb3..747b9716ead1ca791a19e965a01d610c0fd7fcab 100644
--- a/.mailmap
+++ b/.mailmap
@@ -134,6 +134,7 @@ Ben M Cahill <ben.m.cahill@intel.com>
 Ben Widawsky <bwidawsk@kernel.org> <ben@bwidawsk.net>
 Ben Widawsky <bwidawsk@kernel.org> <ben.widawsky@intel.com>
 Ben Widawsky <bwidawsk@kernel.org> <benjamin.widawsky@intel.com>
+Bence Csókás <bence98@sch.bme.hu> <csokas.bence@prolan.hu>
 Benjamin Poirier <benjamin.poirier@gmail.com> <bpoirier@suse.de>
 Benjamin Tissoires <bentiss@kernel.org> <benjamin.tissoires@gmail.com>
 Benjamin Tissoires <bentiss@kernel.org> <benjamin.tissoires@redhat.com>

---
base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
change-id: 20250915-mailmap-b5ff9051c095

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



