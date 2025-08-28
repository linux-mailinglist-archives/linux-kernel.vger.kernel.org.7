Return-Path: <linux-kernel+bounces-790565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD5EB3AA46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC7D7BB22A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EE0322A1D;
	Thu, 28 Aug 2025 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aQnBYNcf"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03F2277C84
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406920; cv=none; b=Xc8oynMvJ1ERiKJUifqtu+YDXQ1ZeV6yd7d+CHBCmTHPo0zBh++7EsWKl8vZQGgT5v8kjE/mELG1Gj3YwXEofeQdDRBt8yNE9WphTYzPUpl8NaIFKC77pk9LpwXPlh4XOuKLwwk76QiM7uRxIUtx3XumiHnTG1/jLdFYxr8c4TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406920; c=relaxed/simple;
	bh=fe43Ufei8hmJArfwfjHykXLl3MBtNupHer/YfngfUoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JH51tpjoXHqmPq9DYoFK8FADMzMITHN/qhgfmsvcIGJkAlLRbUbC4TcnYx/2won5ITK0n83b90gWFkhXuyvjrJJZLCoFJauJZ366cRMqU+Ara1zV0wVyfeN4xudRLj0bgj/RMVS2KC5nhmzmmkEyhxN0MZkz2B+fQeuAxMbnc54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aQnBYNcf; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso965829f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756406916; x=1757011716; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YCFZGFKOrqQ9/x6LRTlmOZOgQDcEYVtLxoEx0AmcCMI=;
        b=aQnBYNcf8pYYB5xW+uDvDXU4kLGAwstLaNplpBglsh7Ufq0zmi4dwTjLVGFABhBnU0
         //o4mxVh4Xg/yTXsb7kl1MLPtePS88GaEiNUzBadr9S3tOhKveihFZlC22Krm6bdvGs0
         zqmdoJIlc6NYXJlw0cW0xry5NbhKuCE3TkiNXqqM8HHHeDyzRIC4UE3MNYGGqR2cGZPU
         XAaH25oWV+uIPlVGY48vrF1GoXcZBIXkgg9WDfqitgB+i8IxSqFIIC1+WEfyuWA+Eoja
         JgUqyGLu4bu49Y5b0C0/YzoWV0l6xk5zlEReGHHetBNbvwBIl1l6BN9zZuT6Au4Guoao
         aHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756406916; x=1757011716;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCFZGFKOrqQ9/x6LRTlmOZOgQDcEYVtLxoEx0AmcCMI=;
        b=qoCCuNNPKTZONas+MdW41GyGYcB9C9aPC4Y85Ehifdxc/PhqV1HDniRfx8IZirQ8Au
         Bw0wvUfODj5ivSLuSx+Qip855L9suHwu3JnCyW8IjUQTwtA3TT00U3zgwfLBSZlEUq3I
         E65K/xwsp/lnLeeih5ymrXAUElbaD0ajig8I4Nit2ZmyMSemozmdNWuzwMpFY4BFuBr2
         y/A6+Pkd4CPI5dISHnSVOvZ2EcGi3zApSdXcH0/84N5Ijg83WlzX3e/wiVo5gZRTxfDm
         SLNqJJfV3xWEs8lr2ubB+m5i/x96yJp4E6fBOuvJRbwIxWSNFHGh3H3D4VfIjFb8gkWc
         hfDA==
X-Forwarded-Encrypted: i=1; AJvYcCXvDOyACLfTRm/4kiA0iNdwCClbrXXC9XvzBiSfGSFQpo1pgEEwtFS/aVAZEHhYDt2dskxqbzjstSYPPzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVFMTiYwOT6KrREnXAR6P7MbCeHX7t7sXPFRgQg6eBq9uT+Y5i
	EIqBL3ys807YxzSV/63sl7CsTJ9hVxZTTNfRlskD7IfXz/VHcQAMhnxYtAgT2FWq7zU=
X-Gm-Gg: ASbGnctTx8MdkeQNRaIp8VlLmKf+Rb4TWjlkYgCihwQbBm+R3690RDqLz2JIUb1HLDk
	ZWPM4RHb8W1Nq+afey86ctnmTFxIGC1UZ7vvx8yUzjO9Fr3ycGkCcXYfjRIIYT8rQ4n9Xw82tNH
	DhEbDxfsS+Sga6esaT17hZempLi+N58ZdL1Uid82Og8LCWJtz9u7FT7cEoiHaMhcSwbopvXn8AM
	SYYcNpmvoyWZwwYpX0qVOsd+ZT4UNS7m7cFnpbvMYwcxU9b/6/XXNTfusoRwoA36wjnZUF8SYlH
	rhyqDhJ5fburPTjZf5Jc7y5nVepDFdI123RaqolRXyYVBlnEZY+eDd6lhHAyTMKW38+92DcIuIr
	82sniXh1k2spswNMC0DNWF0nh9CcTjZ0=
X-Google-Smtp-Source: AGHT+IHVpWUb6I19wVNzRTK5okLcwkV6fHhDdpnCpY6sXIIuYLXSPeVvVtRTfWlPTgYkaVI82dzhHQ==
X-Received: by 2002:a05:6000:402c:b0:3ce:d43c:673f with SMTP id ffacd0b85a97d-3ced43c6c3fmr912774f8f.4.1756406915951;
        Thu, 28 Aug 2025 11:48:35 -0700 (PDT)
Received: from localhost ([177.94.120.255])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-89438a05d95sm124151241.11.2025.08.28.11.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 11:48:35 -0700 (PDT)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Date: Thu, 28 Aug 2025 15:48:30 -0300
Subject: [PATCH] selftests/bpf: Upon failures, exit with code 1 in
 test_xsk.sh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250828-selftests-bpf-test_xsk_ret-v1-1-e6656c01f397@suse.com>
X-B4-Tracking: v=1; b=H4sIAH2ksGgC/x2MQQqDMBAAvyJ77mISKEq/UookcaOhJcpukID49
 ybeZg4zJwhxJIFXdwLTESVuqYp+dOBXmxbCOFcHo8xTjWZEoV/IJFnQ7QEbTUW+E1NGTc4Ms7N
 eDRrqYGcKsdzz96e6s0Lo2Ca/tmXrE5Xch41vgOv6A4tuKcKQAAAA
X-Change-ID: 20250828-selftests-bpf-test_xsk_ret-1eb27dbac071
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=rbm@suse.com;
 h=from:subject:message-id; bh=fe43Ufei8hmJArfwfjHykXLl3MBtNupHer/YfngfUoE=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBosKSA/nhxIoPS8PHCw9bnh+yzRVq632rzVwddF
 OagFjceVWSJAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaLCkgBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKYXEhAAs9TjcvKoxfickRlOGkOOMBIReNojdTJ
 Cmf3hb3ahhhNrhQbdWqAvSBjzQPAVRx7pOH4ayhdu7hqmHXDPHjdRtTf2o2OyWt0wLeZj07Etsa
 9i6Ruw7nw8k1dmQiAzokP7nmb2Nfj9getAUul5qIxTS9eJtnyxDM0EIaCd5+yVKjdFfE+Vt0+ue
 QqNTyuNUj1hhxJgHto4QRUNFF3NHGqfZkAJeaDwCAG0xkyrjGPLsMZ0QzkYz+1hTMDxxS5qdBjF
 j7lpnPmIfvdjx7OTEwA4BfPPx0JvDMAb+VR16NCC3CvTSG9QZvx9SlsP5vzZToaaBqGGho9CVQh
 RpQCYPmkbeBHA86PC82hlCxQ0PmNMORUOzWZsvivbzzq0e/T8QTuBQtVwLL5IN/LnLdQTwpln0Q
 Ldl6dCg08Klth1edZD6cGb+MHvV9MyR/5Av85aqjycLAF8ZAqXA/ppEkGybm6lEgFKgHz+dwxgY
 j+v2w1rgJ8Pt3mwv5qg95FXr46+RMatYySKSPd31f5ckth4qS0W5V4k6fh6MKuzyk1QCYTDtDBu
 vL6c+RT5sZAZ8iKqOz6bKbndeap+ypS2THssEWCDb4zoAo/C1AYnpBNu6WG1Kd5kl0oBGjvIZ33
 CfHFkRP7u0Ml273F/g6r17OYZ9Cs7mgxhr2e4dNN6fCziMBB/fwU=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Currently, even if some subtests fails, the end result will still yield
"ok 1 selftests: bpf: test_xsk.sh". Fix it by exiting with 1 if there are
any failures.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/test_xsk.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 65aafe0003db054e9dfd156092fed53b07be06a0..62db060298a4a3b4391ee4cfa50557cf4a62d3d5 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -241,4 +241,6 @@ done
 
 if [ $failures -eq 0 ]; then
         echo "All tests successful!"
+else
+	exit 1
 fi

---
base-commit: 5b6d6fe1ca7b712c74f78426bb23c465fd34b322
change-id: 20250828-selftests-bpf-test_xsk_ret-1eb27dbac071

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


