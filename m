Return-Path: <linux-kernel+bounces-891566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F457C42F5F
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35033A812A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A13424418F;
	Sat,  8 Nov 2025 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEz1gbYN"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D376C2253FC
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617718; cv=none; b=bLQ4quNpQrXHXc9mNg6TzkUCbBv7Km9zBGtJYIM/da6mbLBFq1BOGu9q84qs32UP5KcdtUQVudm/I55sDR8BHBFJK9IskWIGaQiNOabh2Mw3mqTfkEntbpgxfsdioCssVYFk8+qmdMsHKozjqbOCPzxY5YJhigiQ5qylkGC0Ays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617718; c=relaxed/simple;
	bh=km2A2/M2INKPEdopMbzPv/EYa58WkO98Q3inMzUAOZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYHGfnWkou6XbQUhmBMH2ySYpspNVFJNp1SMSxai2t2IlX0UGTjWIILY4x7pi4ddt4rVkQM6ilGGLngy8DcI9aw112xppTp5uLb4JRLeEvGsxIrmWdHOUy5euwUhypU+mrJm+tYparg4Zz0nYskgYr7Cd0TSoLba47/O/q/s99E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEz1gbYN; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b994baabfcfso1048507a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617713; x=1763222513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMGzupop1iknPIaEBH2NS/TEyMs9rxoF1a5s3QxnVbI=;
        b=nEz1gbYNZTr+rY281OkDfVTVMJOLc4X6QjFxBC9LAZ6BQlvjldWNY7MC51maNxajvv
         K76ixutlesig4bGJn3/tQbTAZD+9LjqXfkYN3ZNkPv9YMmx9R1TWTYiTkP4jMfbVfbMj
         QPQofkdom/dslCxMGfDjmeCG2jFWqc95wNhhomCJwYCYvEBi7vPakUaO4Go9soQbDxX/
         85Qgbw1LR6y5VBWmiukoCMv2pfiv7mj32mtj5SBiPwpbGgiOG4Is8KWic90lyB2fZaxD
         6wckIObZNl0douKZYkw2e+f+aUateFRu9xWBu4SVhQuf+MtkZpE2g+NIAK0o2Y0I1S6z
         RoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617713; x=1763222513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zMGzupop1iknPIaEBH2NS/TEyMs9rxoF1a5s3QxnVbI=;
        b=obyDy773WeRaUryHJkp0f4lpFIp+A4bEjkq9M0v1C0DAl6FNzHcKgX60K0OPDhAiuF
         r+hzgrfmTdGE20uBVvUGoVwrhxTcOZKPXG+zBV+BLygDy12BP32Ubl2d+hrTvR2CCzKh
         Y9F4vg1Z/AjmEkPWDAGAqBJyEZtPgvUWR8nKCsVGAbAdxwG2kISrfcRYGblD/WiEsbJm
         Q4BK8nKYbjTtA2FcKvL2xc59QF5YcNQmFgeFYaNcuz8paGcELKT5qSZjEXTL8WFu5u23
         /Jj5x+13uB6Lfmt90ZKMfPjdMVYTSjkI0CGPFIUokNwskalGxAvXRiGKQcYKgrgU7qdN
         kxhg==
X-Forwarded-Encrypted: i=1; AJvYcCUl5oiXNBheazD2z+x7DLYwsVANMULvV/UMl/QnDtxakyVu2nhdAmbLJx6hqP5IwNBUtg1SPnUhmbD3tHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL+jmK9+11fFNRT2mlu0V4IyfE7AGrIh2i17ugdusxjQBfthyu
	MLK3IqM3hmpzFSVrMGKDdXOXNhVAGYn9R5bHodZQAmTuy0pZZQD1RKrpGXP6dIza
X-Gm-Gg: ASbGncurqF/6zRZ7g0Z20WHQ+GGP1mOJZyCcKRvSKDtTqVAlO3817+y3dkv1LQgEvCu
	3RyY91tNNrUJmXVl9jdkZRONMFeZphBqrPvbnFQbzxrpL7y4BAyxUBwFHzTYzl6TKvgXAPGmw3I
	Jv70HAzag5wsIkv9w4R2ykgajzypSuN2ZLkoRd8txxOfsIB7NfAv2f6CKpFy4yWcedpRyyxWMxu
	7yiz0V11NDnPqUg3eotI7+LlClQh5aND6MLuj/mKen2R1ixH14soSJ/XuPOdOH0fq/+tINevOEM
	hghA2wJ8Ckk6zbN/9+jGI0EL/RPcbjTmANebMP6qgJ1z+w9cSuz2PPJzTqcq/0CEC+vVnTlm3o/
	ect8I0vlelzhCAbtbsz36bGTCcOmMKWGE/GhX1eNh0rHaHfAU3CUwV8o3wy0d0NJVFXTRIKuL
X-Google-Smtp-Source: AGHT+IEXDETrGkQl7MwHVPnvPebwCXZubSUcSknCNmpO3Ei+QqK+KDEUJEIjXX7gb8KeZQyo0pNbCg==
X-Received: by 2002:a17:902:d507:b0:295:6a69:4ad5 with SMTP id d9443c01a7336-297e571bce3mr36484105ad.56.1762617712966;
        Sat, 08 Nov 2025 08:01:52 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c6f6cdsm95463135ad.71.2025.11.08.08.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:52 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:53 -0800
Subject: [PATCH net-next v4 02/12] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-2-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Rewrite wait_for_listener()'s pattern matching to avoid tripping the
if-condition when pipefail is on.

awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
exiting upon finding a match causes false-positives when the pipefail
option is used (grep exits, SIGPIPE emits, and awk complains with a
non-zero exit code). Instead, move all of the pattern matching into awk
so that SIGPIPE cannot happen and the correct exit code is returned.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- use awk-only tcp port lookup
- remove fixes tag because this problem is only introduced when a later
  patch enables pipefail for other reasons (not yet in tree)
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index bc16b13cdbe3..01ce16523afb 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -251,9 +251,11 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
 	for i in $(seq "${max_intervals}"); do
-		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
-		   grep -q "${pattern}"; then
+		if awk -v pattern="${pattern}" \
+			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
+			/proc/net/"${protocol}"*; then
 			break
 		fi
 		sleep "${interval}"

-- 
2.47.3


