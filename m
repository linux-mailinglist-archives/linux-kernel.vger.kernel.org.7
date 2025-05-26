Return-Path: <linux-kernel+bounces-662879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC29AC40D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 16:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF373BACB6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49B720E03F;
	Mon, 26 May 2025 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="IO0v+y9O"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7539C20E023
	for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268046; cv=none; b=JxtEhZfAJIhp6Zjtm4kFIR+n9QLIR5F2dez5DP8d7ymypbYCEojd04Sa4C19PVLQDLTrRBI+dPLG8vhMjhyHFWQ229Az+BDqxGcBG5MkdhHK4I7QCbj35tWjDHXRfr7dkU3f0gWFe0upRDyeNUgDRgNtdL7V1HsuFgitzVzuyc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268046; c=relaxed/simple;
	bh=FH+XuZiqedmmbcdx7+ns4Iwr/ePiNYP4RtSE8O61uKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIVo+bzHquRq3FXS1176CmeGWu3lMZ2GP5rtwbwf0ULsbDPxn8H4CC0154ReVUkeov0QVDMb3QJ/WE5SwqgbRN4xcemEXKa82lFm5MloXRIargyUZe8Wzl5GjsD/K3pTKsjxtQrqNCk1+te5M3qBVJzUcxPV0FgOct2Zzp5ABUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=IO0v+y9O; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1748268042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQmxapCCbfWgqmAUgREJ3k7qr9htA9/0TELdt2lF078=;
	b=IO0v+y9ORD++Xj+HZ0d83rIbOOYxxbyWn5y41u4CBYYtsHz23NppYLIuqwyUI8TPx2q1p7
	4Ud2iHjgwFsuifJLognJK9Vdl7CqX3m/uj1Q7p+Xobw+rN4iapfZd3HBM0ikVbPsFUuYyn
	6iqDHUhtAT4nr/maXdZFe4iBp0SC+4YqchtfukKNvHAvO4ne/LH2jWEuoLqrtCEscokYMa
	F4r00x+0N9+/eNoQPa/ZKvM4NDxeyamT5qif7+CYl72zfQJ6rtDxGHaiMNK+xsxFEpSUHb
	zxrnsA767jKR4tUGTp6ex7rRsFqFBidIRLoQFueag1NsbsipHUyQrpeNhd3tGg==
From: George Anthony Vernon <contact@gvernon.com>
To: dmitry.torokhov@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: George Anthony Vernon <contact@gvernon.com>,
	bagasdotme@gmail.com,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 2/4] input: docs: Correct Amiga 4-jstick adapter pinout
Date: Mon, 26 May 2025 14:59:50 +0100
Message-ID: <20250526135957.180254-3-contact@gvernon.com>
In-Reply-To: <20250526135957.180254-1-contact@gvernon.com>
References: <20250526135957.180254-1-contact@gvernon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Pinout incorrectly duplicated pin 18, correct this.

Signed-off-by: George Anthony Vernon <contact@gvernon.com>
---
 Documentation/input/devices/amijoy.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/input/devices/amijoy.rst b/Documentation/input/devices/amijoy.rst
index f854ee975247..ea4de1ac0360 100644
--- a/Documentation/input/devices/amijoy.rst
+++ b/Documentation/input/devices/amijoy.rst
@@ -17,7 +17,7 @@ Pin    Meaning  Pin    Meaning
  4     Left1	 8     Left2
  5     Right1	 9     Right2
 13     Fire1	11     Fire2
-18     Gnd1	18     Gnd2
+19     Gnd1	18     Gnd2
 =====  ======== ====   ==========
 
 Amiga digital joystick pinout
-- 
2.49.0


