Return-Path: <linux-kernel+bounces-885547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 386BDC33473
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD24188D8FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C76934B184;
	Tue,  4 Nov 2025 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejuBuseI"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B15336EC8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295962; cv=none; b=KigJfwvRtgwxg8/2nEc8E0EibRe5shKf0CMDWFkEzGIrTDVytaoHbe4hLvJvsBgt7OkGzJ3FnNC2ofdWiFM419LUgc5+ajJr2TQCGbeIiOULP8GbKLMWRSLLjQxb02xAfMxAyQCyyUF0y/Hb81Pxacd6V6POZF/zJIUO57vplN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295962; c=relaxed/simple;
	bh=u5DCKGRI4IXZokQzlkyrjLd6GRAOJx9KYjbavhXUqwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hqeGSlUNJKXO4MGL/ZsDFfYOEuCGc9D2WSXIYYzeKkSDcmXQkt34psDXx0BLA1uJrWtUmuOqne4hD2U7xgWUsrwMP3adeTGyt1ZS9C18xBuZ0E76NefVKgkzGfmqAxe8KWYirRWXPFlk2FiCImJV6TNmFK2zQNj+FiIhjxmjFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejuBuseI; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6cf07258e3so3899962a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295959; x=1762900759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnQ+dtcwjsJ29cwDu8qPf9gVDNI9igpgmiF2m60jenM=;
        b=ejuBuseI87JgAOzxRxrvLReQMp0JqqTJuPhOkvguFpn5nVDSO7/KW3d2+gTEIvk/Oc
         AOpa9KH6TvDYhKlesIMiiLBYkMxZtMPHTwRAwRCUCkiBuKKDQF3dFntCgupiT2YJI5pF
         gGd8AaCHIiE/qjqhsZNMMIpgxWZmt2OUSMACWpEVymnRkQZF56QYfBYLL+lm0cx1g9j9
         zuiGhe83Vv55T0wkVszwmb0WqD0CS9KYJ5eiGlBxBtgcCcDzO7eR37ES22neTVCf+Dx0
         ZENQLGCNuYhnuQnecfWarMcK6EzySMaiCnjkZ4C59HODLcdv5jNKo3fxBQHa/mKw68EV
         q/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295959; x=1762900759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnQ+dtcwjsJ29cwDu8qPf9gVDNI9igpgmiF2m60jenM=;
        b=Y6hbmv0svPlntSen0ftgBAawIxz1CmTxbRWGqLm6/BTVpxBGiGFlCFXIw8IBfV/zGP
         b22QVdxY1fx3gPvHdaiK5qfgNbH23hRlvvYLoj7AMx8yOYIHmX32z52jeq3+TjmqusjC
         DfRZCFT3gBus0zyUOd06ZwQ/Ykasd3u9sNPvrf2JMaYxoxblzC5oUtcpO2BiChXJroJl
         N+lQ3oQoSPSv5JvDNH6sFJeWqP8ugb8XjKGVOn/7NlYFvC0ixJiNX/T8amN3/h3WPqQt
         mOAVjhTqepuO5ioT65flKrd9pScxr/xUNlktT7pbLJk+js8Yrs4zM3IOoCK6Zffn0L4U
         ei+A==
X-Forwarded-Encrypted: i=1; AJvYcCVdkrhVdPMNR4RFKkD3wFEpRBog5A+XRR/ZOiEhB1yywl4ss7c3xkhA5M1ZNv2EEd4mc0VyAE21yKWZ5wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhwytlUkMEQ0ZIMMz7MN/NPmIKn9gpkmCcjP7kfIZChmvoPq4q
	GjzLcI2JejZa04NbmzB+4rHgVe00N6AoomX3XLZDdSyskpA5HYQfJnh7q1+zRg==
X-Gm-Gg: ASbGncsU56OSfNvuFAUIPeW5ScZ3dgZ9oplxIecAO/Vww9EXM5Wiep5mgC5Wg2ReJQh
	VqKG/cIDvmT4taCby9qUH14S3ClEDNqSlk3B7FVj52SmruwiAxmixKAT0SOtekxr7rrGGQ2F3eo
	IOIk/YI02Uxn+4hQL5PWwyMvDRQLJoJU4Va4AYhzk5Z1fAcnVMBg5+xdFLnslBIu+iyvNSopagF
	97S28r2LPNL0HMYSlYlVnzzo/nFBCFi8UaKeR2MV0bsMRCGdmNCTSZQrLOLbmC9W/p6SqL+LHoM
	XYzcqzlZmQQ2YFv5dGgrcfPew1UUeDpHLEoocws0xZw3b4qowZT85vJytmFN5EPnIlyFO4Hroz1
	ndbCo7kdpOeSr54nNQmjiq3TJr8Q8yhpOvZ7oJoSvOXgB+tt781u/Uq8hdKIZy4zEwtP2JA==
X-Google-Smtp-Source: AGHT+IESw972+NQugcgnm78ZKTviYmRok4BWA0JCtmd+JQgIjTPldLbnjKbimXu6x1kSemHZnD8cAQ==
X-Received: by 2002:a05:6300:218c:b0:34e:63bd:81b6 with SMTP id adf61e73a8af0-34f865ff9f0mr1241428637.57.1762295959215;
        Tue, 04 Nov 2025 14:39:19 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd682163csm4050602b3a.61.2025.11.04.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:18 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:39:01 -0800
Subject: [PATCH net-next v2 11/12] selftests/vsock: add vsock_loopback
 module loading
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-11-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test so that vmtest.sh
can be used for kernels built with loopback as a module.

This is not technically a fix as kselftest expects loopback to be
built-in already (defined in selftests/vsock/config). This is useful
only for using vmtest.sh outside of kselftest.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 0657973b5067..cfb6b589bcba 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -434,6 +434,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3


