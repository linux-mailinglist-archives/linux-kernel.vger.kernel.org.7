Return-Path: <linux-kernel+bounces-866058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEE0BFECD8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C9DD4ECFF7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F70291C07;
	Thu, 23 Oct 2025 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISHve6E3"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3722A7E5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181242; cv=none; b=qvErRqT7M5WaF30GjRbNVW7RqiA3QaX07qlp1FUq5UeU34uO5HEjX7zdR1CD/HG3ruM2Tzxtjxn8UcB11CVrhyDHtKLY30UmeFt4yLSum2bQ6HmUrKxVQuO0m6cxlRu+RNhOGxN+DaJsK+MT4aA60Hul+8KZSY0owMAVA/ZeaEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181242; c=relaxed/simple;
	bh=94uzV3VFEsNc5hciZIog7zBBbpwZzL3cEkwJ4Knqo18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fvZtuwh/85CEMuc8XPPb3wQ1vt+NtbL1/8RUa/JV4vYKOcVWCYhixOfYt09vL2d7geTO3gznHRCmDkP1e5XDWPfjApeabrtxRvwEcrDBcfdjNjpcHCwr/YwuKXoTtwHflgAtlw6PvJuoAMOVtp24phKBd6tTRFs5kd5w75/OSBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISHve6E3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33292adb180so223718a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181236; x=1761786036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KyrEoOAeZKPRfbyTnz5cosCWFxdbO0nbS1ytMd/2Og=;
        b=ISHve6E32hhuWJDWyvQvUFboTItF6+IRHd0M1Zi8dO/ngsEfaOqXuN+pIMCJrztSfU
         O+Hmou4a8pmogV8zTi1m5eHhXdWgi+FujR1jeA8iYSHz9+JkejtR4hok5/t4kBgfYXvK
         lAeoot42z63rJCbX1xSjdUkuA5ENWuH7CnZxWaO4+d0coZzbpiHcsMavTpFeKD9ueWqk
         fkz58+mhhWUdhyKZtd8CdqVIC0uVUg8QejlVkbMRTGSZFTPFh51p1OnUzTOcGdpm53Pf
         DMSRPDDX1kg/LnMqpVd4koiTkhUD1vo4OLOJe5vbnMyuqWIRFgN68dYQ4qwUSwx+aeG6
         B4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181236; x=1761786036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KyrEoOAeZKPRfbyTnz5cosCWFxdbO0nbS1ytMd/2Og=;
        b=fmjChKlQdGFbElYN4VD1FOp0Oz1D+5ibxMQ+SJOAPbFQ9gFOuj60G9NZSyLFLCzO7C
         u0HqkxYfdlURaKl0Lb2L0On1Hg521zH7k5n9lUbs2elWcVd764dNwUKgckjoHMsAB48N
         SqNVLnB3KymD2w2VM2C+3yFUa3SXpKb9dHaCeIS43At7+o3Cn0HyQae+OXQLET0CtoZ5
         Uu66ml3kvCnqWxRbYY7gRT3tbtExkd6C3b9xlArsIkdd5VbEWdwvrtdPXbfab4VBZ8ks
         V242t29Uor3YnPfhvFUBmkyWqVEI5Phm0cIPbZu1Flo1jIWaBwVdF3S/qEeJ4l9gBEoE
         AxEw==
X-Forwarded-Encrypted: i=1; AJvYcCUzVktHjswy/ecKxY0Fl7LvJfdQS8762HVC6wwStdu7pOBlbJfdGBy0ATNeYm8zGymP3WZpK51t4gfZxfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrI3dCUriBKSp8ZzJRpsTa3AbxVPYHXBm44VIhJHtB5ApXbxlf
	B5iSAINLnvNvwiLxJtNk/qsVMT24BCRblHFmk6qR+C8tNgVkUm8gkjtz
X-Gm-Gg: ASbGnctwjjg4PT15KQhQMj0lUFl2/3DmURCcgxQt2L9WAkcNEF4VDHJAPWtpi5C9P8M
	Q4Eup3U1Vx58hyzw51EzrE2XntH2IE/gMw+NukrXxbhe9E+2mvmtloGSk+gbjlAiBZrEy0/PPbT
	REDcug1QdEpaZMKlcRdKCKYG21/Sb6nm3Db5Cv3EkSamXvOsZbBi9D8hyEVTM5NIXornwyNb41R
	stq0jTSO/iH6gXoQ46mjXhCbzbAO1DNB5e6wb3/RuEFNpDkDonREUwk6O5AWdv864gjhDK1Egka
	zEoIbaYXgzwDkjprvyJ7+JYxzA31YjHKzHsM4Z1qNvjITvwCK6D5OB9rxTx+QvGxX7v3IsNt1p5
	LS/+CZvtsbsPq9jIwn+hRFot6XcwuWQy6pGkVFijEIchkar7pocDwRPex7Kq5MHdgYWh2p3wTIE
	yu3jsjrizslYKYXYgkVw==
X-Google-Smtp-Source: AGHT+IEOXbL7VuQGK4ycx5x+XFWwQbZrBd+2XbxwOLCxBAkNJU5f38Hm416YN0mJLPBe2ibivOPQGg==
X-Received: by 2002:a17:90b:5343:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-33bcf84e1edmr30854960a91.8.1761181235816;
        Wed, 22 Oct 2025 18:00:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb9027sm360734a12.6.2025.10.22.18.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:35 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:15 -0700
Subject: [PATCH net-next 11/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-11-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index aa7199c94780..038bb5e2b5e2 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -152,7 +152,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3


