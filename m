Return-Path: <linux-kernel+bounces-885540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B290CC33431
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A12204F00F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA4346FC5;
	Tue,  4 Nov 2025 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ghumm7Pj"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED70133F365
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295956; cv=none; b=UFjLeXsZsMr/Ot047ifazAhEQdR2fQUxmG1mGDwvwDXLRQ+iphZ0TgBtwSGM3D8+kEg5jRb/vENe2a4/YB6772xmj4nX6JJ/qozTO3deE6Qa16Jsg7ie8xUtlE4kl1xolv6D1QS8mS0vZKXrB6FBUm/5V+ROIlAgo7RagIZp1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295956; c=relaxed/simple;
	bh=MP2KoZXX+79Mi4EOxuj0JaxBOJBdoc+sCYGsGHNCwUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B6HeppY0gZ5EEmRv+P5ZokYEebwslBMUAuNQkf9du9RUpc4zA8sOz22faEqjAiuOyrpYlz/Wrqf6DI+QxZcb0uMRbiUavrCCIc2TIMzpYiBjQREvpn1dWVnENdMyWRkSmaVgkQsTDgFF40W2YdLLL2ICxoFUAx6Lf1KoYxaSpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ghumm7Pj; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so3763407a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295951; x=1762900751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2TtF77uA9Y6v8jmRi2a/W5oTLXZ//NRPnuqn89vDsU=;
        b=Ghumm7PjRqXPAsnxOBc2oQIiGww/tpfuDykkyRIgzJ+5rMGZX395wg4T+TEasn/6nO
         KZ1UHkU9oAci8OcLg+7qGS1hJgnmzFCSi3N4W/1Ji4P2E8SAG3KwjhgeLtGa7sMEAZiW
         fJv5x7DXAnvgAQXqtqTNfrlKjew+n6k12B7ufE4Yn1zgQypFfF+2KoQXY32G3rlx1nWL
         BGkCGQAXbBKrj4dvrH9rcwvl/vUo1U+n6D8snWKNrxrzWAPD6gEIfXGWN+ek40ITjoew
         Vd7Ghxbm2uJE0V8pOuBLxJfM3XXRsQrV2oxJK9jUF6F5FBUzEhfIRwnEcw5DbKXZmudD
         UFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295951; x=1762900751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2TtF77uA9Y6v8jmRi2a/W5oTLXZ//NRPnuqn89vDsU=;
        b=qKFsrip47CLYCnTO2yKxNWVX0tk/oLnOVYrgkM3VBovSctwkjPwiY07ujqAEBVKkS+
         Bih46YxHTV7aNk6FGaD0uF0gUZW0azv4/VhV0bIdUtdXKIL4JEPCHv5y7+aFym6Ni6vU
         DkuODzwOWKC7Yd7NEziun2uH3uL7v1t9JnJ0Fcpl23C2fsJpSMPYt8LSftFKwk6KK5f5
         NmYVJtLL2tO7QlocEIo4n5N2VLsvTxAKdCiqyLYQhcVdggpvI6DxbbIk/Qf0vc1ppu4R
         sb0Timm/UpN9g0yRHzuhwOv4rymzEMJ6iGpr2NYBOGIcu+iK+bhZ8bN852UgR1bbTU/O
         92Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVN6TDEwbWG28rTtw+GW5UPQiEd/R3ZJ2MjQFfH9+62GNsdRNWNaNOTabgMZBSnEh/E/Wx16L+1OHYUylY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgcvnIxd5XayCpPAu+pe6iY4CYZKYa7E20q3Su4QcrHtX0z2JI
	jMZQRIBn9FcoFrk46gE18PIvf6eZMmKffZUjtThJO6KhkH/vaEk/NGlf
X-Gm-Gg: ASbGncsIRtIEI7kAWDel3Nrgj1cLUkoYZA5edaR9EPiCi3QrLrJ/5QRV3eDfhs+Rzfu
	iT0otjgwu4ZRiRfxkgrst4YKxtaeiFeWpkGYeHtWkzJPzVXIF/qJspNrWtcT5pUsQrhFlP8QQso
	iw60+nVuJyO7RRugkAF9E9dEgSbifJHJGaFWF1TJ2CvAavdwf6tfzGicYcM0FzkCnEIdtPceGFt
	SkmBfhqsfC9h7unqVrtA2WZj1rJyoHJ2Dn3V+b0uPv1vRzVDSypItNmeihKnMNt87NtWdYsy1Fi
	rteagn41eqvMQD6kK3jgtPWLV78zMYxOAyhwqb2jSywhZpBxzE+SKNdjExQJvLHm2CEtrVSAqLf
	c4gRnxusEZMFKssxsCs5ucGR9WKm+56AP/PjqqTeefhNL/mHZLxz1F3xyeoGwvs4aKAKlPQmr
X-Google-Smtp-Source: AGHT+IHjLept3ve48AUPW/GiyFbQHZFSoms2OQFSZb1ZP3j5dSJ+0pBWFTSSrVMg5PH2kQRmlJsbhw==
X-Received: by 2002:a05:6a20:7483:b0:34e:63bd:81c1 with SMTP id adf61e73a8af0-34f839f5a57mr1249874637.3.1762295951213;
        Tue, 04 Nov 2025 14:39:11 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd324680asm4163732b3a.1.2025.11.04.14.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:10 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:52 -0800
Subject: [PATCH net-next v2 02/12] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-2-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Rewrite wait_for_listener()'s pattern matching to avoid tripping the
if-condition when pipefail is on.

awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
exiting upon finding a match causes false-positives when the pipefail
option is used (grep exists, SIGPIPE emits, and awk complains with a
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
index 1715594cc783..da0408ca6895 100755
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


