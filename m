Return-Path: <linux-kernel+bounces-889603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E429C3E065
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B953A9705
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93A2ECD32;
	Fri,  7 Nov 2025 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0CYzKgT"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6D32EA498
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476595; cv=none; b=PM6J2vKiIYRkckqTSmIEXDV+q7b/z44Og7oc+1jw9eCRx7hEGxXx/+mfD+3rbQmpEVVdwTuZJIVKhN0PH54OAl5mOD6UIbp0x1v7wSQzOlwCRaJX9hE6bhfrCGF8lIccKQomYJcbg7jd5F8C/prn8hpGd7or7yNHDtLuqk4iv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476595; c=relaxed/simple;
	bh=koFlOU8nPr40dYCnNR2Kb1hX/evxzyHNeLTqs2N9DX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XxMlpaZZC3KPrf5UNKUAFLVn8oiWs0JKY03tpPcKtBeqQdonz+UPPMLilq7bcs76h1hjjjRlg084xcEuFOno2VdVMVkx2hYJnhvqnAd0F0C3aLKrjlr9OsJHkUyAVU+saab3lVw5wL+aohnppCxbWVR9EeUaN/9gUIkP6dV87+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0CYzKgT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so190933a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476593; x=1763081393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bHLKHBydWD3BQnmasHq5DNEmPhWMbiyT3gusZiID5w=;
        b=b0CYzKgTztdTUUKCxanJqUiW7J1jEflGOXLWEC4l6OaucJJmU2qFO3Vr0ljJpeNidS
         H5SL8CokydlM4MepEhgZfMw+yM4uvQTYw80/qgBsdq4/c05vOKxsmEDvV4vPNMmigk/w
         g9+d7edhYqaTtl0ywojnUjCFoM91mImK5JcFlxS29UjJURmHCV0lYTTSRYLMfhkauLJS
         2gOwLBcc0nakf+Hbq4RWUN4JnjRYVvbbQfpG2r2cINOVyBFU5y0VANB8ITaFOFd/7j1Q
         XBGc+Cx/cdY0LL8fi6L0WpIbrXWiTA04hQ3lVX+ypb0GsbmfZ+JD6xUVwX8JEFeLpBar
         bUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476593; x=1763081393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+bHLKHBydWD3BQnmasHq5DNEmPhWMbiyT3gusZiID5w=;
        b=cJ9C3pMeKBqzRDKCw6yqn/cT1CeNxS4r+MpGXfIHuCf9jKN0iQHut/U3iD0jumgzcj
         nC0KrcdA2/OF177lnp4duBwD4VrD0iaZKca13+AV7Jt+to+vkR5PB7XrGMaYciox4poV
         JVaL7FEMVTkfWJr7iD31CvATJMMXPYddOjiF7qRXdTN77WrRer7aq6WtH0ONaCLSNQo2
         gw/Ptdz2GgxLNSL/dR76+ARFVk7MijTUmk8Tn7CxQqlTiQK2GA86qH5aRF56sLzZ5qr4
         AExz7SudySITxbYaHIELdlepphkKThcO0EOa+vIWrq08GOH8vPfCzyY4CEO5DYE6a9uz
         97sw==
X-Forwarded-Encrypted: i=1; AJvYcCW6U7YULskpgKp1ZB+5LrVOjXH4W+kKzWK55F0Bpz2ESwi7WNTqU0BWYljFTFRJ+cJ9nwUeo+5WmOoGK8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMG1hfOQzY/7BbwKzanbuQfdt63AxkCVfT5cCiBAeQhkzksEha
	UytbQWOivqwBFJ7khRDNOgmn5lO0zBicgF5uQUrQZN20sDXuo44tQ1hj
X-Gm-Gg: ASbGncs1xPGaF8tFGtxuIrre/KjDxzVgwNqMDB4CiEBRA3K9VbAF8z6KPLlZFrHEgdk
	JUaugR2iEI1sgwvlJqdGVLDVVhQQU339SbJabqFSUD8uy0r67fBZeu/QWN3XBJGZNPhGrcwo6nB
	XCJ/ge05eRJkaTpVO+jj0sYTy0QdNQuPBIc9CLC2ecNq6AfHH51kIHoLT6PJMRAxsivX9595GYv
	2/CFHzPnLv7smKNlan6XBvTtoM/OaGMeBphb88BSeouxFxvJ61KYMaymgX4BtZovVbQAbTr49f4
	KymGcJn7WlINEerWzm0MW4Es1FIYQDa2T2t1xirndcUt+G2n+SwfENT4uKy+qOoapnQMi4eYbIH
	sCD/RHBj4YkLeX/1FttnBpUvhpxEDh0ahqFkWiPdOjyEFXx1cS+GG8aX9oj0I5rFZVxGeUY1apH
	28FWkT9PvU
X-Google-Smtp-Source: AGHT+IGGoy9wEEdfN0EFLwAgMu/11l3zKvwUuDnYxOVJXD1G2hGNpGxEh0fLCyEjaIvkGIR6LPuB/Q==
X-Received: by 2002:a17:90b:2ec7:b0:340:a19f:c25b with SMTP id 98e67ed59e1d1-3434c55b5b5mr1365389a91.24.1762476593115;
        Thu, 06 Nov 2025 16:49:53 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d08afb02sm2233539a91.0.2025.11.06.16.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:52 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:46 -0800
Subject: [PATCH net-next v3 02/11] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-2-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
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
index 54bae61bf6d4..d936209d3eaa 100755
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


