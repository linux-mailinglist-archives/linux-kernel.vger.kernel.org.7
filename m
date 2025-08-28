Return-Path: <linux-kernel+bounces-790026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F00B39E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C53A7B628F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F97F3126BB;
	Thu, 28 Aug 2025 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O3YYsHa7"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04942311979
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386781; cv=none; b=YLymrbPhL5FFBtKuUNY8W1bgaxbZO/+5MxBBu6VuKyv974BQckDvOeEcrg7fdAiw/PVaTY7iNkGGy7qyIGqG8IAfNLXpqNl2U5I/lRln6ibgNvNkUndg00MeqTP7aRcCdHj14x9jKunUYT29Wsf1ZvKbVWlc+ZcXTPu/f9Y5EcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386781; c=relaxed/simple;
	bh=2N4zkmyqye7LBYfPkMsXA3H1zZ5ZsRLH5P7of8pw368=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T8iGYodkFADZ94q1U9AG6b2Ha5niYBLl8qEw9uYf6b4yBMJkshnK3lHEehTIX3NWDRtkPgP+b1gcsSK4b7RLlnigH3RBhXuePqk3lotJn9cP9HDr3EGP+fZ/+eDBwUeBtvzITunWmLcj25dURMsxKjZblWkxs+LJOIJByXvEQgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O3YYsHa7; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c79f0a604aso573793f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756386777; x=1756991577; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aaoHRMJOmlPZvNuw5zJXIt9WwLQFwql6jfGw43WqudQ=;
        b=O3YYsHa79TXCQ/PwN87lMgs4aqHy7lJApJ1wk5VrqPLp8s0M+k8sLQtqzKmDmBSSR3
         p1dnMApgno9C3s2L3H9A5QsrCAJIBVoK0RM1AwdsABqD0bZWQ/1oE18JG/Kfxar8gCfZ
         fQY/fPwEFb/aADZ5Nv2n4VeTIuJZDFI7/xsjsCV5AssZPKF8DjRUde5RUXARmDuaflj0
         1oHJv67PKcIe13uabc89oaeGddN4TumInfmwtSIYHf7OEtpLW6qVY+esKX86+vsYd1sY
         JTvYd0/Z0KA5lVejsPYEi+LLxywETZcD5fY8Ga70aA9hAGVzH7jcW0mnuMJv66q3rKyP
         B/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386777; x=1756991577;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaoHRMJOmlPZvNuw5zJXIt9WwLQFwql6jfGw43WqudQ=;
        b=r336QIbO7sK0hrHqTik0dYz3/XRolcKXrXUTK1fBj+G9o4eS0b4jbcX8mJF0H845np
         ux6ui80bgO2zjvbspdnoaPXUtF8B8h3G9y8GXXM5qnkDlcQ23Dwp0gvOLMYnd/YA2LQE
         l81kfkpQuoKPD8TXONwcAZdcZCFagdXNvPAasefmnDMND9yyAy5yerkV8mQ+2Q/X8PQ6
         cBM3oRizmmnyqVgGpWqA41Ef24ZxKiS9wz4XNnDgVTnFL/FZzjkHaZuVI4nLwaO0XjDz
         WIq1hr727rTzExPz0had4e2GGNW5JhyPmZlqL4XT71181vmbS9bAhBBCrwa88AJyxETf
         hrBA==
X-Forwarded-Encrypted: i=1; AJvYcCXy0oRL/osm1QWkzFO6keu0gSiG0WsfLKVP6BvIXCQRqp1GKa5AaXHrvagMOhUpeg2HME+LUbm3totQUL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjY3pTPQkoONJgrTUqaWXm85m+qwKCYp5h99SPGyuEdqM9BtN4
	AnEkEecW1M63IJLOFliW0tELZW4G6YlEPPajq+HJELaUlQeGmje6szWVbHbEKJSBeLY=
X-Gm-Gg: ASbGnct1iav8RQxZVTQKz0F4pE1HHTqKJETyfFtYU+PV7fgMpLbWZXaNUsS6kLOZBa+
	thgGfDyWi8le88Xl4gMfS7B+orwJNCDrFpPZ+jDJ5OtEe8YnePJYYar4mF/nF9paKt8izXnJqPX
	1wAE6qqpaRHoyU3ZpV5NVjx2OPCJIvMYupBjyLn5qQWaQpNof9TTorhWfjEl/VPVMgaUQXQaAh2
	x7RK3KqX5M5u6PKbcXLMi6YE6aShMHOHRdh7qOE92ok6y0yMvN1AXW5bnpofaCz0exx5lLikVxy
	FrX2OeJ/aRj4QF9MBdsUFo6BYhSjPslpFedO8vtbF6VKMKZZitmVFblC17pikAw90xx+iK3a48t
	9nP4j6IuDDQ==
X-Google-Smtp-Source: AGHT+IHKcbqOWajx9cMRL5ztLf39tQDGmF7C1CKrMSZTAerPaPmDVS3PcCg6lRUmSNT4kED+aAopEA==
X-Received: by 2002:a05:6000:2511:b0:3cd:7200:e021 with SMTP id ffacd0b85a97d-3cd7200e18amr3609135f8f.59.1756386777169;
        Thu, 28 Aug 2025 06:12:57 -0700 (PDT)
Received: from localhost ([177.94.120.255])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ca6240b4ecsm14435609f8f.43.2025.08.28.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:12:56 -0700 (PDT)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Date: Thu, 28 Aug 2025 10:12:33 -0300
Subject: [PATCH] selftests/bpf: Fix bpf_prog_detach2 usage in
 test_lirc_mode2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250828-selftests-bpf-v1-1-c7811cd8b98c@suse.com>
X-B4-Tracking: v=1; b=H4sIAMBVsGgC/x2MQQqDMBAAvyJ77lIb1Np+RXpI1k1dKFF2QxHEv
 xu9zRxmNjBWYYN3tYHyX0zmVORxq4Amn76MMhYHV7u27l2Pxr+Y2bJhWCI2LVF8UcfPsYHSLMp
 R1us3fIoHb4xBfaLpvJxJ4jXf46wXwL4f/+eAXIMAAAA=
X-Change-ID: 20250828-selftests-bpf-45ccf9c6e7d4
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=rbm@suse.com;
 h=from:subject:message-id; bh=2N4zkmyqye7LBYfPkMsXA3H1zZ5ZsRLH5P7of8pw368=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBosFXU9biVjxEUfGoANyy3ge+FD+emJsoaxcbZR
 znAS3JTHhyJAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaLBV1BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKZKGhAAi96BIN+czst4Ja7UBJVoY1FeQxgaqsf
 jQGL3+2DaedYNE8rCru8aWRwpjLBf6yk4Be/wSDmUKjAAecQLTgcw9n/NPALgVGkcNToQxeUXt6
 BTbRHWnaLNydPf077SqNAesxQaOiPZjBUpxDf1KB0nN8Whwmw8I+SULoLkwgO2/wVyd7SSB+G2P
 Iwt7U4aBjGyD8MS+64pP6qaK2DSHTliLOibivmNcT01mTjDnCMbt2cOV6suqEicz/QGBpA5LEZc
 ccyoHvIkqhfFW15m7fmWsbe7/4W+reNQ4mU5VCO6W329xkB6pnNNBvXUxl/uOwJxgTivT6LWc93
 JSqpF0gqAbHOdRQQNE/n8gEv5OBKPwqJMWB2bKzcciaqi5NrpsfSLmG3v4Ru4/IhGKBzRkl+ZsE
 CXPHHGyHpaHRIxl3U+Ym1MALfDC4/k40kX1VtSelbtqGBFErVqU4YNI6g7VAR16aBzjrM5Y9gzI
 rNhs3su/eFvZILXqMz3DYVglfHiDy8vYS20PdLz+cAFZ2zmXzASLs4rNGALPDL3EzORPL/TpEXU
 YUqIDBO1LFIUz0/hq7032MxFDWXDUWVd8FDG82s2FNwaHGxlGoM0IAjXbtHpBnTGqRtBHlNwTSD
 EGsPq6WBWqPk0McH2jEm3Qnp2V54uh4+hZlFuGYVeqcJaJfQMDEM=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Commit e9fc3ce99b34 ("libbpf: Streamline error reporting for high-level
APIs") redefined the way that bpf_prog_detach2() returns. Therefore, adapt
the usage in test_lirc_mode2_user.c.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/test_lirc_mode2_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_lirc_mode2_user.c b/tools/testing/selftests/bpf/test_lirc_mode2_user.c
index 4694422aa76c36faa4afa8832e56040547dc7547..88e4aeab21b7bc37665d6fd3959006c5a83a81c9 100644
--- a/tools/testing/selftests/bpf/test_lirc_mode2_user.c
+++ b/tools/testing/selftests/bpf/test_lirc_mode2_user.c
@@ -74,7 +74,7 @@ int main(int argc, char **argv)
 
 	/* Let's try detach it before it was ever attached */
 	ret = bpf_prog_detach2(progfd, lircfd, BPF_LIRC_MODE2);
-	if (ret != -1 || errno != ENOENT) {
+	if (ret != -ENOENT) {
 		printf("bpf_prog_detach2 not attached should fail: %m\n");
 		return 1;
 	}

---
base-commit: 5b6d6fe1ca7b712c74f78426bb23c465fd34b322
change-id: 20250828-selftests-bpf-45ccf9c6e7d4

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


