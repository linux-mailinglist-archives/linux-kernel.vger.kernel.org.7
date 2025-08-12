Return-Path: <linux-kernel+bounces-765611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FEFB23ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3057517DF21
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880C72D12E1;
	Tue, 12 Aug 2025 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBbCee3p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EBC2F0661
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034694; cv=none; b=nHs+emhbZtpNb31JtgZQZG12W6PGmbTL/VLs0B4jl3VONDOGd3Vr7ffIo1RyQnvYAUdO/RSHOaMVXMnY7XuGvjR+KzSU0jWKyhpHgCfjBfi8rLeErB7ZX/hAncjvLViuemAQrAr3kYUY9aD9EynqpPnykaKQ/En/ylKxZ7IQKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034694; c=relaxed/simple;
	bh=zrcNdbqwFxasgEHpfjq7To71wBNAxo6gnEKahJ8pP+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NA/p1vKDP0COYWilhG0/olgSYQxm5OVxM1qf4cbWTh8WUu1YC7g2O3cunEsBOggdfYd7sBLEGJMQc+AXBHwPKfH/3rDn9Ts+pkImRvefeQclPSusrX8aKRlq1dQqLujB1EEzw31JY/W/0BP/hWIPXQUoQ2nNvNiw/qMDCBGariA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBbCee3p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755034690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oEuIZtwk5nlstzv/3AvGWbPy5sVy/y3wf4vmyz9yARI=;
	b=CBbCee3p1Ow57hzMUItMfhv564o1NLUrPPRjaAmTmhAKwRHG8zyYqviBCpaEywwZaLUxwo
	HPXiM2xl/9Gejmjup8BtIXcGisEjXemqufVrsvEf7M4b3a2aXlysTc2DTUdXwD8Px+HBFV
	4tsmrHJvkg6t0sygwXwg06ZEnzvlsTo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-JwqqnvS9PkCaV7aIboi2IA-1; Tue,
 12 Aug 2025 17:38:04 -0400
X-MC-Unique: JwqqnvS9PkCaV7aIboi2IA-1
X-Mimecast-MFC-AGG-ID: JwqqnvS9PkCaV7aIboi2IA_1755034683
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE7F8180035B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 21:38:03 +0000 (UTC)
Received: from tbecker-thinkpadp16vgen1.rmtbr.csb (unknown [10.96.134.180])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BDAD1800280;
	Tue, 12 Aug 2025 21:38:02 +0000 (UTC)
From: tbecker@redhat.com
To: steved@redhat.com,
	linux-kernel@vger.kernel.org
Cc: Thiago Becker <tbecker@redhat.com>
Subject: [PATCH] nfsrahead: modify get_device_info logic
Date: Tue, 12 Aug 2025 18:37:59 -0300
Message-ID: <20250812213759.403790-1-tbecker@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Thiago Becker <tbecker@redhat.com>

There are a few reports of failures by nfsrahead to set the read ahead
when the nfs mount information is not available when the udev event
fires. This was alleviated by retrying to read mountinfo multiple times,
but some cases where still failing to find the device information. To
further alleviate this issue, this patch adds a 50ms delay between
attempts. To not incur into unecessary delays, the logic in
get_device_info is reworked.

While we are in this, remove a second loop of reptitions of
get_device_info.

Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 tools/nfsrahead/main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index 8a11cf1a..b7b889ff 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -117,9 +117,11 @@ out_free_device_info:
 
 static int get_device_info(const char *device_number, struct device_info *device_info)
 {
-	int ret = ENOENT;
-	for (int retry_count = 0; retry_count < 10 && ret != 0; retry_count++)
+	int ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
+	for (int retry_count = 0; retry_count < 5 && ret != 0; retry_count++) {
+		usleep(50000);
 		ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
+	}
 
 	return ret;
 }
@@ -135,7 +137,7 @@ static int conf_get_readahead(const char *kind) {
 
 int main(int argc, char **argv)
 {
-	int ret = 0, retry, opt;
+	int ret = 0, opt;
 	struct device_info device;
 	unsigned int readahead = 128, log_level, log_stderr = 0;
 
@@ -163,11 +165,7 @@ int main(int argc, char **argv)
 	if ((argc - optind) != 1)
 		xlog_err("expected the device number of a BDI; is udev ok?");
 
-	for (retry = 0; retry <= 10; retry++ )
-		if ((ret = get_device_info(argv[optind], &device)) == 0)
-			break;
-
-	if (ret != 0 || device.fstype == NULL) {
+	if ((ret = get_device_info(argv[optind], &device)) != 0 || device.fstype == NULL) {
 		xlog(D_GENERAL, "unable to find device %s\n", argv[optind]);
 		goto out;
 	}
-- 
2.43.5


