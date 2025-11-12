Return-Path: <linux-kernel+bounces-898015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF3FC54201
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B96D64E75EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E89352948;
	Wed, 12 Nov 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mto1Mz3S"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4A350A0E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975380; cv=none; b=r6Mpa3gq2T7bijf9k6HEAez4oGF+1rP5GOpykEskDHuCVac3VcbGyjYWBssDkn2kP8+0Lqk2rwzpkHw3Z9Q04qy3ueybcDU06E5mqHgU++Zlc8Kt2eBZOt3MfYnvtgc9WVMzTabJS2LIJbE09rG6DGeAf96FlTpcIBYLTVZDSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975380; c=relaxed/simple;
	bh=4WEWqFLkAyILTnk5IRmplEfehB7Qfwkb9Xc1jBRIVh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jcwGgggfXs0YXhP7UCgq35OjezA4gKe6nMNMnF+XvoDj9R2cDk5dxoiBQ4ve++BuHbSGxDo1tA5r07UWdxxbhiS2Bl3cuGDuRGTdDOkkbA/op41+gK43DuOm2acbKPA3puZdkXOyXxfqyQ7IYSNocS59k5mQGufaWp6ucX9GgUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mto1Mz3S; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7900f597d08so1257669b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975378; x=1763580178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mq/oPHnS+nR1DAAGuM6ciZxbjUUIou+j7/UhE84TOCk=;
        b=mto1Mz3S6cey2ugi/lZmLCcSeyr/JeDqcaYOguBgBeC9FxeA6K49VL8OJNxSBi9Ti7
         f7bTdKXwb0ArUjYTmYpP1L6UXjCzdamosqtmhHiZIpiGEdVxtfcPyOtDYp9kHmBysrsY
         RvIodXmScdoUUWvq6QAZLDjQIurSTqQsqRP7WEXY10VEEj8kdLvivAUJM94EpTMo/XGe
         fBcB09B6INIkfdqccQZvRyjlQTqQvb43Bg2ZKT06NKFrUukjnaGPMhCaCuk+WAOpa6rX
         z4HkR5HVpbVhF+ZYi1wZ0yEFunA/AeEAWDJdwP+X0BSz/9Upep9z6qDhFeL/r0Ptp0r4
         /UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975378; x=1763580178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mq/oPHnS+nR1DAAGuM6ciZxbjUUIou+j7/UhE84TOCk=;
        b=WQWiih4rjZ/It5tipKgdA7BK4lj8Wfpf3K0BlHuCcUIRWNbbXtYXYSeXeYj5LOvdF0
         cHGalPNKYnP48qDS2PvVLrh0+q0E/WJcfkhCfiBONt5P9KNX1F0IsY20xtqLswmCPWZP
         LhZDkgLvNcEEMpzqutx3eBVa8OzEsImp+CvOQDR/XT+la+cQX5TT4ZsVnzFFNT1SuJ9r
         br2DlbmkR1QEU0z+1iINkuY6SzLQz7XSaGXeyJucbkkwERNFFxNseRion0M0droS0N7I
         r2iVbIfgg9jpW2AptWvYjvD/Im3FJGi7QV1Gldw05StQRcqnlJRNwAkJHHV2Xypz4WLX
         y8nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKZsSYzAMz8oiTD7CiQ7ILqBKgglTYJAhQNVsapi8fEB/nH2LrU/WNDVvrcaYmZXOmIVn/ST5N1aA69fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn6t5x//6nOBLC88hlsrfNP50nk69A2zMPE9hwQXhj65qvKsUZ
	rG/js/mQVtEUfrmSi904TTIpn2N37D3zUaOSVFNHDx45mAb+zx3eNvtjIXwql694uEzavLOEHxu
	MIBTSWTDUfMXpKA==
X-Google-Smtp-Source: AGHT+IEd9++8is6wKtQHcfQ6Wkj1e3bbHC3t+bITp5e83+/U0RnUJT78Nw/CRkwOfCVl+NP4rN8DCvD7e+WkmQ==
X-Received: from pfbml5.prod.google.com ([2002:a05:6a00:3d85:b0:792:f698:fda2])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2ea7:b0:7b2:2d85:ae59 with SMTP id d2e1a72fcca58-7b7a2d8d131mr4883446b3a.11.1762975378013;
 Wed, 12 Nov 2025 11:22:58 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:23 +0000
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-10-dmatlack@google.com>
Subject: [PATCH v2 09/18] vfio: selftests: Upgrade driver logging to dev_err()
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Upgrade various logging in the VFIO selftests drivers from dev_info() to
dev_err(). All of these logs indicate scenarios that may be unexpected.
For example, the logging during probing indicates matching devices but
that aren't supported by the driver. And the memcpy errors can indicate
a problem if the caller was not trying to do something like exercise I/O
fault handling. Exercising I/O fault handling is certainly a valid thing
to do, but the driver can't infer the caller's expectations, so better
to just log with dev_err().

Suggested-by: Raghavendra Rao Ananta <rananta@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c   | 4 ++--
 tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
index 8d667be80229..0afbab0d82de 100644
--- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
+++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
@@ -70,7 +70,7 @@ static int dsa_probe(struct vfio_pci_device *device)
 		return -EINVAL;
 
 	if (dsa_int_handle_request_required(device)) {
-		dev_info(device, "Device requires requesting interrupt handles\n");
+		dev_err(device, "Device requires requesting interrupt handles\n");
 		return -EINVAL;
 	}
 
@@ -256,7 +256,7 @@ static int dsa_completion_wait(struct vfio_pci_device *device,
 	if (status == DSA_COMP_SUCCESS)
 		return 0;
 
-	dev_info(device, "Error detected during memcpy operation: 0x%x\n", status);
+	dev_err(device, "Error detected during memcpy operation: 0x%x\n", status);
 	return -1;
 }
 
diff --git a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
index e04dce1d544c..c6db311ce64d 100644
--- a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
+++ b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
@@ -51,7 +51,7 @@ static int ioat_probe(struct vfio_pci_device *device)
 		r = 0;
 		break;
 	default:
-		dev_info(device, "ioat: Unsupported version: 0x%x\n", version);
+		dev_err(device, "ioat: Unsupported version: 0x%x\n", version);
 		r = -EINVAL;
 	}
 	return r;
@@ -135,7 +135,7 @@ static void ioat_handle_error(struct vfio_pci_device *device)
 {
 	void *registers = ioat_channel_registers(device);
 
-	dev_info(device, "Error detected during memcpy operation!\n"
+	dev_err(device, "Error detected during memcpy operation!\n"
 		 "  CHANERR: 0x%x\n"
 		 "  CHANERR_INT: 0x%x\n"
 		 "  DMAUNCERRSTS: 0x%x\n",
-- 
2.52.0.rc1.455.g30608eb744-goog


