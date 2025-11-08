Return-Path: <linux-kernel+bounces-891570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D14D7C42F56
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 466404E5CA6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE9125C81B;
	Sat,  8 Nov 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3Pyj4cW"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9018B23EAAB
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617720; cv=none; b=dnkwAx/LkZKMSARnIeqy5yiXqCxT2iCB6viXtMTyWk2irOzJQn4lCBTmOzX5WlDgNAaMs3b4Z7eCaUmwYAkgSfOGTt008zw8qGHp+omznCaFoMcS2hJ7+eVcuIgLFwVndglYOD95Yg6Nx9xJdcFXnJoHhCLVC+g1qNhLEovdxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617720; c=relaxed/simple;
	bh=kXti4VlF9If/Jhp5cw6M/i3Lzb+2XXWTFOdTl0a0yx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ouPF5491tgB0sHy3dHNqAap2O50+/IP2vrWwyVkikK8j5aoOzjjvrLe1ujCYPW9vzTlOucbv6AACEvS70RwtGEp975Jz8KMrD/BK9t9VDh6g6mOJN7/FNU9tXfQpHISm5CQ9w4zokl2M/5Xu1PC2Ls3MbvN9aVWsjrrYzOxhp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3Pyj4cW; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b67684e2904so1066839a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617718; x=1763222518; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lu3g3vSYUjY7/DxTl1+mYZ9eGfURyr+RcPBMpaSL4zc=;
        b=J3Pyj4cWtJm9KrnVOSVNSUxcGuo8cAwmkNeIo5p+ersOUlhzTahndiwj8f/1UVxnLB
         U/yFgVt1woo6RnqAd0TRV9tcq9hrAc0DjPbgYwWz1E1V6HBekZ3D68Y4hIXrzF6vWxHJ
         TrCL8z8xj0VTWvzQfC9Nr1/uexwB7VP28lW/5MgpbiK8wOuiDXF8GSx+0IR3XMCTgBRc
         DP65PoZtKgQbbBqF5O2X/pcFRcqFEgQWXeZwQ/OTXlkXNoTmlqQcsJtD5BKetbHMupuc
         gfyJ65l8S4eobmO1twEvbXTR/XMzm876qCRVdxwoaOPcZe9rNWWHlrj2lNxFaOaXinSp
         2RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617718; x=1763222518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lu3g3vSYUjY7/DxTl1+mYZ9eGfURyr+RcPBMpaSL4zc=;
        b=OqD5pBEISpGBGX8sEogNuvCOS14sP4vjBJoxVyn/ZmKLsXhJeZaleoHIR678iFy7WT
         KrxEyOIo9tDgerONOl2LGaqmGjlETHWPd+Dbffn+foengZ2BSZ3qUNSfLvfcv/yqTgDm
         KSe2TLU20KLOejegScYpDFde7le33vbFew8i2Pml1Qwu1e6LSSYyae42Kzn21QVyN8rc
         nvdQXaF6Gx1UyoiWGjf4DUETx2pq8aVqBm26T2FGUO2dt1L9lMDqbUo3/XonvKeV/RWt
         7b1UXsM9zQSAEsZIC8AZZcgDqTekM91o67EmqZmN5c9ocARmHNKcEvgAfU1RHjqE56Fh
         tpcw==
X-Forwarded-Encrypted: i=1; AJvYcCXfZ+AzGm4OryF3IhgmbXVmtf3mBS8D3g9mHmZf5qKttfCzsLVjwCxbAFZdloDk3N6hOaveie8VYG/d50c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqvd/AD0NigoFCPnVKuDDOecv/vlOsSnTcZZtUiNG4yHsFy8e/
	ZlLmVwM5GfjgBzDYYTVq7t8cvi7nCpgPIRJLyQGZ0vq84xFKXVT62Wnc
X-Gm-Gg: ASbGncsV/4ucICdLGL9ggely1MdXgNIoLcvPFNZfk3/Hcun3Q7F1Vx18ylZ+LbFPpNJ
	6ueCyXhavlUJ1av1d4253icUs5aCY9B5NJL7Q68UO1BC/nHBi0N2pOrCmM7YrxJXQukmrfxTPMR
	EmWqhPIeC6UmDwJtD/i7dU5POLl2u4YCfGWx+k8Yti1K3LYGhuAGtnovyNDdtPJjdrRYWCdZLwZ
	0jUJwEnXlJ39rors19JdYYrIZT9+k1xBEeFiiJFT1LH+hNLzmlFIjKwCrFa+XqeyRLun4LGSBel
	CAjErNmIOqVLoDZ+iKhPx2cLa8H5AUvAp8uyQz6TtDzxdKB7tZqh+Q8Woszccwyy/ieip68MQGW
	anxus2m7g9QQJzb34+3uJQ1UB+iBJyD9RMTFYKvebrx6Hsm7vn67N3nL0adKm54NPXGH0kkY60R
	eg++MP+bN52jBRVh22Fwc=
X-Google-Smtp-Source: AGHT+IHDIYzATzCHfhG57FblbDFeYnwOL/4oaPCyboie4iuVOegKtbCQgew0dvzNH4sWmPXvWF1Gyw==
X-Received: by 2002:a17:903:238e:b0:267:f7bc:673c with SMTP id d9443c01a7336-297e56d0401mr33795955ad.44.1762617717613;
        Sat, 08 Nov 2025 08:01:57 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651042c24sm93002675ad.50.2025.11.08.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:57 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:58 -0800
Subject: [PATCH net-next v4 07/12] selftests/vsock: add check_result() for
 pass/fail counting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-7-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add check_result() function to reuse logic for incrementing the
pass/fail counters. This function will get used by different callers as
we add different types of tests in future patches (namely, namespace and
non-namespace tests will be called at different places, and re-use this
function).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- fix botched rebase
- use more consistent ${VAR} style

Changes in v3:
- increment cnt_total directly (no intermediary var) (Stefano)
- pass arg to check_result() from caller, dont incidentally rely on
  global (Stefano)
- use new create_pidfile() introduce in v3 of earlier patch
- continue with more disciplined variable quoting style
---
 tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index bd231467c66b..2dd9bbb8c4a9 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -79,6 +79,26 @@ die() {
 	exit "${KSFT_FAIL}"
 }
 
+check_result() {
+	local rc arg
+
+	rc=$1
+	arg=$2
+
+	cnt_total=$(( cnt_total + 1 ))
+
+	if [[ ${rc} -eq ${KSFT_PASS} ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "ok ${cnt_total} ${arg}"
+	elif [[ ${rc} -eq ${KSFT_SKIP} ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "ok ${cnt_total} ${arg} # SKIP"
+	elif [[ ${rc} -eq ${KSFT_FAIL} ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "not ok ${cnt_total} ${arg} # exit=${rc}"
+	fi
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -530,17 +550,7 @@ cnt_total=0
 for arg in "${ARGS[@]}"; do
 	run_test "${arg}"
 	rc=$?
-	if [[ ${rc} -eq $KSFT_PASS ]]; then
-		cnt_pass=$(( cnt_pass + 1 ))
-		echo "ok ${cnt_total} ${arg}"
-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
-		cnt_skip=$(( cnt_skip + 1 ))
-		echo "ok ${cnt_total} ${arg} # SKIP"
-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
-		cnt_fail=$(( cnt_fail + 1 ))
-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
-	fi
-	cnt_total=$(( cnt_total + 1 ))
+	check_result "${rc}" "${arg}"
 done
 
 terminate_pidfiles "${pidfile}"

-- 
2.47.3


