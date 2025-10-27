Return-Path: <linux-kernel+bounces-871409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0292C0D29F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8917E3A5C10
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C16B2FAC06;
	Mon, 27 Oct 2025 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfUk1juL"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817882F7ADB
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564895; cv=none; b=G1ZPdedQMoSLJW6zys2MQLkzQlux/kETinD4QolZNrgGcc/yaSAn6ojCwEJ1+Eu502M7yVeLt6biYb122d3JrT3RcvAuE+74kpSvIg3CIG5a0Eabajm+Gh1YDfO0VPhxbIEQYD+jihfksvw4yHFHMSn/4523AD6AJoBrb50Zw1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564895; c=relaxed/simple;
	bh=5TBB1dS0xdm96UtguSy0r3N+8c94aYIZTQ5p5Qhj/p8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jz21lhNrjys5bKoJRQz4ED72hwOyxmIRn2zVMz/qXBZdXgqSO1s8dMBr8xoB8qBpXS7qDGAeKWoIbcJEMrzISgHpv4LWoxmXJH2AnaYPSUMqwwAbSCw8588mwsRFwLxpMRY2Xkv0FHCo2stMLM2iAx+pmDuznsxKNKheNHuac6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfUk1juL; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b550a522a49so3721797a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761564893; x=1762169693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+bbEtFgvtdD4nIW4Ki4K8L2rFFyWkm5SaPEHBXu2tU4=;
        b=dfUk1juLHkT8khrl2rfPRj/9bV1U7GNpn0ugRjQtcLwJsf9myJ6OXMTgXV9q5M9LyZ
         u+WeCjwmXo3oqPwLRPb9gPMwisK0EPSPSGueIQ2ph1K9G4jDdsdJn/WiHBJvkwFAidt/
         fnPiARrn8BJl7Ujxk4KdFlefz1ckXaDH0G/EDmt9GON9fwNTOSCaaNQ993+bFQ/1OnpY
         g39pJre/LSDS8JKilExBcUgpzDY+B4248fKYveRQuV9/ISZnLXonmLVGFQld4dLRItZ/
         ZdAf8SsZ9VafgvuUGqtJ6x/Cz84s5vvoAhENz6r5f97GdYPyeOwILdhkQZ7efGT1jaD4
         jGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761564893; x=1762169693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bbEtFgvtdD4nIW4Ki4K8L2rFFyWkm5SaPEHBXu2tU4=;
        b=RZkSDrmXNES90qPt6pII5aAITLMD0CE4vEKtBPkpoRJW4aa1tsvauMFgkeRVt/H0bz
         6mropkUkJmUwIVMoA0YbiCd9tUphLMKlYxKCwfVPVAdoQl6z2FZo9ODSgT3jfW9V4Hmw
         pE+d6+WNEKycBHaDl2GaEGSXd/gbX1EYauUjeBWrBeGSIgNIFzNguXlg9LDIE25M5zxx
         vnMdCF5hL9IbHaepMcY3/QLrLIt+6OR/RUqUfLzsO9vZTZYqL9mY2gs7uEHhcowvlemW
         bw6vuyXlzOgKjMqqsdZdXY9ZobuwgBp5Cbd8kuYay/a/UczCeq9xnkGhOalMdw778GDh
         9pBg==
X-Forwarded-Encrypted: i=1; AJvYcCXYQ6omaPyFlqW9LqF9YtAHhVCiq+KLO8mX2YM3HJB7SYni2Uy4wcMsVogd2Jgxu1eT40IOhgBBCDNAsls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw42qxo+bquEtDIJJI2Ex7Aw/OawpCapBmM/iUTD/YtXyPVpnd/
	qE1kq2XS92ynm7BdlcRxyZXtuHjUuQAyF03SzkkA/kDiT8o5992YoNgl
X-Gm-Gg: ASbGncuwJlx674ORl5erkW7l160EeiPq6T/IMhkvyPyD+V/m5Qp90VOfm52i8R82uWs
	pmNOgXcImy2eoXzhPiquffF0vhOidJED/F4wAJGEXm7pHyF+Nc8XucrICV3sYsbjPGucMN3XMdj
	pn9Wi9Azum9plIinEdtuK0J7ezFB0JL18MwqFmLCXzAR7haLvMti63amaiFjcdHcRAiHMaaAt9c
	+PcG0utmcRIof2kD/uvqvZMSgmkqicnqYAPR9Rfzfd3F7edX9ZQgx5CAEPL0FrCLCaomrptJQzO
	Zp/tjZvOS1urY0yzaFwGG4SuUbXF5zCp9a+0RgnBZ968kNC+96GSM42/wHoDzmB/UZpdQvlOkqS
	eemHsryocS+VXZDMU+78v62im+blds1jt7DeT6sYjRGXzYWrzK3dFc1f0vuz8hxa/MSdsAcRRmf
	m4US0hPz7OHJ9Pcx7wwrJD6eW5NqjEYH06/ckbVPGT
X-Google-Smtp-Source: AGHT+IEXotOiXJpTCp/puthxXvnmCrnF43T4sh9Ukdwx3XQqsIiiaQDtaOtYzH9OodVVaE5Vc6YsYQ==
X-Received: by 2002:a17:902:ec90:b0:293:a10:12ee with SMTP id d9443c01a7336-2930a1018a5mr217124005ad.15.1761564892811;
        Mon, 27 Oct 2025 04:34:52 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf33f9sm78216485ad.22.2025.10.27.04.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:34:52 -0700 (PDT)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Cc: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftests/user_events: Avoid taking address of packed member in perf_test
Date: Mon, 27 Oct 2025 17:04:39 +0530
Message-ID: <20251027113439.36059-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accessing 'reg.write_index' directly triggers a -Waddress-of-packed-member
warning due to potential unaligned pointer access:

perf_test.c:239:38: warning: taking address of packed member 'write_index'
of class or structure 'user_reg' may result in an unaligned pointer value 
[-Waddress-of-packed-member]
  239 |         ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
      |                                             ^~~~~~~~~~~~~~~ 

Use memcpy() instead to safely copy the value and avoid unaligned pointer
access across architectures.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/user_events/perf_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index 201459d8094d..e4385f4aa231 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -201,6 +201,7 @@ TEST_F(user, perf_empty_events) {
 	struct perf_event_mmap_page *perf_page;
 	int page_size = sysconf(_SC_PAGESIZE);
 	int id, fd;
+	__u32 write_index;
 	__u32 *val;
 
 	reg.size = sizeof(reg);
@@ -236,7 +237,8 @@ TEST_F(user, perf_empty_events) {
 	ASSERT_EQ(1 << reg.enable_bit, self->check);
 
 	/* Ensure write shows up at correct offset */
-	ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
+	memcpy(&write_index, &reg.write_index, sizeof(reg.write_index));
+	ASSERT_NE(-1, write(self->data_fd, &write_index,
 	                    sizeof(reg.write_index)));
 	val = (void *)(((char *)perf_page) + perf_page->data_offset);
 	ASSERT_EQ(PERF_RECORD_SAMPLE, *val);
-- 
2.51.0


