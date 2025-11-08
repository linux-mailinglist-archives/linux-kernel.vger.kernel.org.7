Return-Path: <linux-kernel+bounces-891572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BCBC42FAA
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B103C188D798
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FBC26F296;
	Sat,  8 Nov 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbEHNJ87"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFD9231842
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617722; cv=none; b=jZt/6eyvm+Qdww32c0vXRYi/p9hybfeGub8danz08MpjB8zUNPiRUjhJeXDZ5P6od8+qIyojwWZ1LFF4i/f4Oko2ZIZuf7KckRIb0rhGLM9jkFvnpoB63w/liJfFFf+CkUx+SnSOIoQBYs1Os75wJLY9xlmGenKCcyI35oieh+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617722; c=relaxed/simple;
	bh=rsJoOi2cJHjVoFfWem70mON63FeGD3+bDKAfH1rnKVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUwjoA0K/BPxv20OafEYSK4nY6kigKSKDihw7jtNwKC9jAH00+tcGrYQ1hakL03Jq0lU3PtlbSA5rOPrMzIrm1KdoY5j8e3esJ1qTViwJZae98H/TUsDfmV0sppzlZhwrw6fxDpELUX5FELCLu0dqLnZSO2oFcltpNqJDj+fiR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbEHNJ87; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b9f1d0126e6so1081922a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617719; x=1763222519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCZpbzlgXNaHUfpJgg5bp7RfyHhboSaGeDqGPcpEBV4=;
        b=FbEHNJ872s4MpsK3sUgApvMq9Fl7KA5ribPexY6YEakaXYugX+SxvySyj+WgJ5PGLr
         trcMHQkT4TBI2ezTRgl6GQ+YzoZnO8VGPGQ3osNDe4iZ4E9jkZ5oLZZIGcw9ixO4KZMg
         1PTDh5jPZhjX2wjUfNGb2+1moqTVp41rIC+PZYReBUxZcRrTn5NCIdtplun36V+Xpbok
         KlLpgo0Xil5rGQW3b4dQmrnKC4I+ib207dXJMjzyQ6bf9y2gjHFTTYpQWfjIHlBsXlnu
         1NYZ9AMuZfRDlnFKn+tP4GI2285o5K8AnJHNcfc2hAy45ZvsBnn3q5BZFYbwhDHoaWN3
         RwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617719; x=1763222519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zCZpbzlgXNaHUfpJgg5bp7RfyHhboSaGeDqGPcpEBV4=;
        b=Yi2LdAiAMwidcYnn1yZt7E3t11Tp6drM4BRII+U6Z8GV0aaZhUGCuj/XVMeQcA/ABx
         AybtjVLeP/7oAJNn87V6zw71ZKC4J5LGuS0J9OZvxEI2NARsaDUGtxAWcV6lTwqBEceT
         cyokQj5m8n+h/D95ts5IOjK2FZr3X6JIT3lIRjch4ZHvHUuY0NgvU0vw7x1Pu2l3Iw3u
         hy1kmPj0WSa7KcQ9orYvs0B3m/jI6c93wlhjil2cG69LQe6bKEng2CfJ6l9HjQ9Fpnxq
         6iE2961ke+onkLLREOsXPZj3Et0fHd60HN+xbNvLWpTvlnP8oc6yAA0yPPGsNkJCKyp9
         8PiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyr+Dhf0ZUsdA2W6TDzC2iIfSfvl7WUKUGDm9L7PDu+o7nEFNQox+gV0l7anNypmxipy327qrSJugULw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJDLSNoWp+Yt3QCgA4+Xv4fFm8+pD6NwG4cXX084B/ykYgN4V
	DTIUnvtAfleHx244S5/6RtWuBn/Psri/gp/HqmkO8frMVvIrJUysMI18
X-Gm-Gg: ASbGncsc3rnla1BvZSWZ9gnU4UwjwjJ4tSp5onT1Am6jOLcQ2YGngtHr9LfrW2L0RcZ
	bfDkAuGI+Iz3yuLBii5nqqOgBI4WvVcWQ1gwc1VOXEjEpfzDqnCyR5bldUrRTYK8gQdcClnul5r
	PI8rQbeVgq/lba/T9KGQb+0q4WYeWfNLJPO6yqc3kCZwPMMThK8vCpCJi4KXqvfkP36nAh1t3MQ
	IkepFwhUowUgTePsOhnZbGkwxnF53mcGws0D/RxaIdBeBDilmpAk1A9h1LUmQPXekMCj7f57oQr
	x+brVIJZa4NL8VyUhxy/jiDduFGP6J7kwou1nTZVgKPlxHix7qJMkces5KrOUYWC7X472o6qh23
	iGvLaVgSTtV/cYAbkxqgRHo8/OvhSEzzOVHz7Hm5ibgKF8OJx9NwcWYEc8UwYSVc+XdexjCF6
X-Google-Smtp-Source: AGHT+IE4yGWFg0aIBwiA4LPoKZBjaoo7gZDrHFJPuzyKYWyf6FZGig58eJBXmK4vcD8oY5wVdHAoBA==
X-Received: by 2002:a17:902:f707:b0:295:6850:a38d with SMTP id d9443c01a7336-297c95b383emr64698465ad.19.1762617719452;
        Sat, 08 Nov 2025 08:01:59 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba90138f614sm8137032a12.27.2025.11.08.08.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:59 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:01:00 -0800
Subject: [PATCH net-next v4 09/12] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-9-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- remove fixes tag because it doesn't fix breakage of kselftest, and
  just supports otherwise invoking with bash -u
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a1c2969c44b6..e961b65b4c6e 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -548,6 +548,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3


