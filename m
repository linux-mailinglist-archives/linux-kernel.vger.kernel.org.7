Return-Path: <linux-kernel+bounces-886475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E13C35B33
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA811A21C2C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464DF315D47;
	Wed,  5 Nov 2025 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKshOQ/J"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2730AAC2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346852; cv=none; b=BVT08/wiA/7y2QYJA2hxndtwf8nVoS0SG2foycH+A35r47UNndlj+S2kC9S88AnNUp6DdISR/G8TOwQU/d/mIr6vtFsxsBtFfgEkCzl4OIZP6ME71RRXiSwdH4SeM0PZ2c2IRT2qlSEAjlBpkHimi/0QRVWdD8m3euJGc+3v0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346852; c=relaxed/simple;
	bh=6EDEoQ8G1aeH7k2mK0kTG53ah50zIFSO89NPX7Nmkvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=guby7r0EjQ8PpIdqW27SpBUTHagyKRF3gzyRksOc18/mU6Mju8RPSB1j2eWPPkYk4FM+NNvKddSyYEx7v/9k9CSp3+j+C+4QZSzZGe9dfLf2eXdTrwWxiGyyzlqKljddAYAnkVLGzMsqbj2fup4YxvR2OSSnrRDKMMNr2eapsM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKshOQ/J; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-88703c873d5so239130039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 04:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762346849; x=1762951649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jK/gceny5PWDz/DbB/PatvWx/loVHzoFjA0SzuhB540=;
        b=JKshOQ/JDrbEox4T9HnfRkoDfdHAcnFavdKFquyWV8hIiW1L4HxmuQhs1tEuDln+ap
         C6S9wp6Qt3QNtREyLDIKHyWUgGuTdL56BrKSXkHE+rdT3almFN/Pi7VukOZUXI4MA28z
         17cPR+knlYUEqIY44bbb2bGwWRDHoAetkhY1pE1dc5CArQeYR2xYq+0jT/2m69AAwpFq
         gSemZTxPfqkiyoymxqDTSpHm23or73c7yrRcLMyFceQVKqWhkVudth2nGVhQ1w10/OcB
         QA+2vATthIjtF4gGBjjQtVyG5jTuCRpAaEl94rLY91SvRGTolofuq/AWEoUdgDWcGYAK
         QVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762346849; x=1762951649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jK/gceny5PWDz/DbB/PatvWx/loVHzoFjA0SzuhB540=;
        b=peLrnVNHCks5dEKn11dy25ywcsyYojxZ1s39PVZ0kJYx4BUKyKO+n7N1XSxmY2/VYd
         jWozROnKV+b3mQPCKCfGqBi3FIob/NvmKaF7cIkljTPzvBm6XBFdD2IWD4StJWL33g6T
         uYaex/nIoIkTO0Yfks+UzMl52vtPrEKGpNhZZGs0hYo8xhj9stifhNhWkpLXcoBPo3Xo
         HLeadH9HbDSIiA7XyGcYMkOhmg+nvFoU8xLhE6Sb0aeS1kOwh0ova60GfS7QOhCUEXkm
         6ZPHjpROKHqPMxP5vdjAUlPD84bv3bNFZt07LP8sQTse6Zc2PTuSZ62PJqmDyRrv0UQ3
         ZXWQ==
X-Gm-Message-State: AOJu0YwGBBfpcfapyleCUYQb6M0V1M2SUfxJKRBZDc2GB/fSvxD0auUF
	cseteuOvd73ywayjQlbDmx6Ia1gNakC7dl3pILMppm+tBYLPY6SI/Zl6
X-Gm-Gg: ASbGncuSd8Cjj/ebGwaiCY0iCMeP8K4LREwzBAnzeZfVnv2YTQvNR5gYzrH4bvwwUPp
	3zanF/4PMjheQupPow6RHrbiTXCHFxWm4RyMgQSRMnGBFjX11qOss4/8ffYkUcJJvi1tKJGj7Pe
	9H0Ij+kRWid/VcZeEhs1V/3pmUgiNLw9OFZE0xU/dkJ9ysYhfHz4mUwsv5XaycCpPBXSnFFrm/k
	4CbnEXu5dwp3HRl7Xapph+K9SLFAcrA4o+eOQ/CniUgUgqrV9WYToPOpXW2eAX0j2hqG87g3Kc8
	kbObhAWJqumsDqDVWwbFCek941maeL3wPH2EtqfqSv4XvbB/Isrbut8vTX8iU0PfwF2LP3401c/
	hL/9YYTsY+AuZCcUz+H3ANkxqszZED5uONN1tXXXphh4IkINagTuvbyrX/7Whx/UjgMpeQ5/sm4
	Yvvq/TJZto70Tqp212zI6DiQ==
X-Google-Smtp-Source: AGHT+IEYO5OB88hN6eQ+81LrxblmPXtqVllaL/oYvPXtpbKz7v2GjUAoOuzLaXR4zN+F70sNBnHk1Q==
X-Received: by 2002:a05:6e02:12c5:b0:433:2711:c5cc with SMTP id e9e14a558f8ab-433407d953bmr38615765ab.32.1762346848847;
        Wed, 05 Nov 2025 04:47:28 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335a91956sm25775835ab.6.2025.11.05.04.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 04:47:27 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 34F4C420A6A0; Wed, 05 Nov 2025 19:47:23 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux NVDIMM <nvdimm@lists.linux.dev>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: btt: Unwrap bit 31-30 nested table
Date: Wed,  5 Nov 2025 19:47:08 +0700
Message-ID: <20251105124707.44736-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=bagasdotme@gmail.com; h=from:subject; bh=6EDEoQ8G1aeH7k2mK0kTG53ah50zIFSO89NPX7Nmkvo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJncbjOS1rX8C5NtP+1iKPE08O1B3+IO8QazyyabDETDT VNk3B93lLIwiHExyIopskxK5Gs6vctI5EL7WkeYOaxMIEMYuDgFYCLGmQz/fbmqW3c0rN3CrZr3 786N+jzWK8md8lbFakq3zDX8JKq9GBn6gypMP+cZrJy/wNT8Wc4f13k3brrduMjYqyDROeWzdTU DAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Bit 31-30 usage table is already formatted as reST simple table, but it
is wrapped in literal code block instead. Unwrap it.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/nvdimm/btt.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/nvdimm/btt.rst b/Documentation/driver-api/nvdimm/btt.rst
index 107395c042ae07..2d8269f834bd60 100644
--- a/Documentation/driver-api/nvdimm/btt.rst
+++ b/Documentation/driver-api/nvdimm/btt.rst
@@ -83,7 +83,7 @@ flags, and the remaining form the internal block number.
 ======== =============================================================
 Bit      Description
 ======== =============================================================
-31 - 30	 Error and Zero flags - Used in the following way::
+31 - 30	 Error and Zero flags - Used in the following way:
 
 	   == ==  ====================================================
 	   31 30  Description

base-commit: 27600b51fbc8b9a4eba18c8d88d7edb146605f3f
-- 
An old man doll... just what I always wanted! - Clara


