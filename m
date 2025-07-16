Return-Path: <linux-kernel+bounces-733547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570E8B07612
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468DB7B763F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4DF2F3C34;
	Wed, 16 Jul 2025 12:46:27 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D015E90
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669986; cv=none; b=cjvb2QyZCYtgaloYM+2lNVFW9hop9vuyMgCrj6Ri9WzfP/m85hbNGeglotp/a8RmQk+GtlC1PX0rBXt0EFFZG/vC+UYmGTL8lS7/RFmSfW3REdb9HbGUCUB5e9sSxF09LmoP/AMPDXG9izTK5sz5KoC30H462v3znSlqutWoOOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669986; c=relaxed/simple;
	bh=VtLZKHWeEQrix0u/ie+VyyTC5fO943Q83nJWFCiDwoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b0qcccHc9LfBJySSMkcnBONnDXarqhXKfAMJceLz/LquN4qVWjKkodz1RcGs+CjJqGbw7LLu4bbjDDcRXQ8rtqKxIjTUCqbD8KXCJiXPNlMwwmYRutamhMkHWp6K0HMz/1Y0WpFqB1zYljg2UxbS0ZMIq10Zg4GRNZsXdXRE8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae35f36da9dso1346007366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669983; x=1753274783;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nHi/Drr0uAysvpOhqgFMruCENictBdFBEyIV3Omq/E=;
        b=IDe4lsgqVRxHaiAkbBET+6/Ks38Zhsif6shYVORIpd2pHswg/Nc/B5DgOvIUuRXyxY
         RrMiro+Tepk5nO+VUxuPawDZfsuT/4unmP5X4wUQIGOMZsrg48hzhZrdoTxS33rYi/Ff
         aFUcmg9gLUNHiNonjXzarGDOdOLk05Hqznwj5nOCPCZ4eu6KKSGsEixSCHHcxiejiRzw
         RX0dFlSUw3FLpWLtviukijd11NEsiXajy5g40u6vM2Cls2V4/OTNx73bYmu66JUAuZvZ
         QYTKh/nN0ctcmODfq6JgGuaNQr/2n77bdEdwTvZXxcQiUhQtIqN9CRoO3MtODR+e07u5
         9rKg==
X-Forwarded-Encrypted: i=1; AJvYcCXn4UjmYyCXw31xcMQKgAJ44Wr5Ei4WzyLn5XS1jDJOklSP1+twxfmf2akKE1wBq4DbyTshUb51pQM6g2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhqzMz3JXETzFFIHV+CTKvrhYGQuUsIJGC4B9dcPH7QTbdXt9i
	CO3kptk81+3HNLEo4RyjfDEOUNEgz9oHcyCEryE8PkYnfm7ZrgkAfvre
X-Gm-Gg: ASbGnct166Hj/3nnqn2q5nE1i0/amVVgprYQpENB5ZWxnpNXjcew1pLEv7zfTA08eHa
	AqtYB6uWMc4y8KLCD9TZnCR4stYGJTU/LFjdDT0CfHwc/LCQhA4bQfv5IKRItwyWyRa77NJ3kaW
	W3AdTIIBGVzG1lmL7fMKMjC+BjePL1xJU331rBPCtk45V0Z498tW7insyjJioQeDoRg2obeaJ8h
	Gx1WFA0oyZMvZYH9D9y0qffarL0QwVHosVWdaPaAHkRYcvb9XJslsunlWmkgDshb5WwM8oIt15F
	qofwmqOOgUjMeVohKCf6NEuOYgkEgD7oGc9+Fku/awOnej/4muAarMAgjd8WWwb4qJD/v8mgV+f
	6nAyAnNLYrO1m
X-Google-Smtp-Source: AGHT+IHGQ4kq/7+AoGST06tjPNkopo5tZZQH4Vq1wEvkzrB7zFCChXgmwb/g3sz6G4TXC7budQyvTQ==
X-Received: by 2002:a17:906:3956:b0:ae4:85e:6207 with SMTP id a640c23a62f3a-ae9ce110d20mr190064266b.50.1752669982940;
        Wed, 16 Jul 2025 05:46:22 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee46cdsm1209083466b.60.2025.07.16.05.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:46:22 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Jul 2025 05:46:15 -0700
Subject: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
X-B4-Tracking: v=1; b=H4sIABafd2gC/x3MWwqAIBAF0K0M9ztBe+NWIkJsrPmxUKgg3HvQW
 cB5kTkJZ1h6kfiSLEeEJVMR/O7ixkpWWEKt604PplfZP8vtUpS4qc60jQ9mCKPuURHOxEGef5v
 mUj6kZwukXQAAAA==
X-Change-ID: 20250716-scx_warning-5143cf17f806
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, jake@hillion.co.uk, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603; i=leitao@debian.org;
 h=from:subject:message-id; bh=VtLZKHWeEQrix0u/ie+VyyTC5fO943Q83nJWFCiDwoM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBod58dZupF7dIoNxfa79oXtv/lhj51fVSyLx/8q
 Uvze7a9VbiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHefHQAKCRA1o5Of/Hh3
 bQ5/D/9zPFs4LKba02f3jKhFIkABvfbU2WfdVlBht/GYm35jp6b/C8cnukMTfHNVelKazFXIVYK
 mgfvlw2tBiP5qGe0kiTOgUlzthcd7vfVwYoMM8HSssObBolpkmFJw4CEFBLThc8UqVNS++yTAVS
 /4pC797s+eol9g/a5guSMg8U5e+URSoEN/K3+HmNipcBoQ5eMbPBIg1BKFw+5Wuu1i6PzJ9JGOs
 YkcpxZgCXhBONsy5fWpBtkpeuqvY5SjKdy9E18MyjAs33TEFC+NQwN5vV6rTutHspL2/K0wTwzc
 l2T7y8+7R3INAHfBKbxeVjK+Cf6tqZ/3Zd/z+tPLEV12ZiazpG6fT4T76iVuaqflahRpapFSGHz
 iyL5dIGK/BUnDM99BoB97rfcRD0HoODDxL6V+tHHKxOOzSi5BlYh/zZC5T91PYndlHHLrIK1KaU
 CY720ax/XWx1i8XZOTj/BuG/dPhamwCIH4A3RCVxk9J89wxyZLwAhUIAiFWTAR84lNNJxP0fuPw
 R3nxhHh2SW3oMm0CbLhtkeVw0akAFPz6GzzyYl1iK0PkY1fiHOgAY+opIKuj1HyCJ0v2wUHYBTI
 Fj/J2z9xe7bu47Hx0TgWSArMzg/l3BNVGZSffGz40CVhH2tmuve3up0FuZK3TtZHoS7sdNjxD/v
 e4koLE/M+p3mlxQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

__this_cpu_write() emits a warning if used with preemption enabled.

Function update_locked_rq() might be called with preemption enabled,
which causes the following warning:

	BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770

Disable preemption around the __this_cpu_write() call in
update_locked_rq() to suppress the warning, without affecting behavior.

If preemption triggers a  jump to another CPU during the callback it's
fine, since we would track the rq state on the other CPU with its own
local variable.

Suggested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")
Acked-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d867ba210..24fcbd7331f73 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1258,7 +1258,14 @@ static inline void update_locked_rq(struct rq *rq)
 	 */
 	if (rq)
 		lockdep_assert_rq_held(rq);
+	/*
+	 * __this_cpu_write() emits a warning when used with preemption enabled.
+	 * While there's no functional issue if the callback runs on another
+	 * CPU, we disable preemption here solely to suppress that warning.
+	 */
+	preempt_disable();
 	__this_cpu_write(locked_rq, rq);
+	preempt_enable();
 }
 
 /*

---
base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
change-id: 20250716-scx_warning-5143cf17f806

Best regards,
--  
Breno Leitao <leitao@debian.org>


