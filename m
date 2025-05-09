Return-Path: <linux-kernel+bounces-641280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F5AB0F58
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 11:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021D44E7770
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 09:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBCB28CF51;
	Fri,  9 May 2025 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fzsRbbWB"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A51279330
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783692; cv=none; b=gARIaKDXsSutKNdB1R3E4GUmI+2n5InXs7nIEQOL/W3HYtDZE1uOkPi9Bvl+qcvpj9ipee0sWNgNnEe5jmMkit62Q7HLeAfbjNID8vww8h1Cv4YVoudAuiNqX9hxISyYhWPJRt6TRtZiyzfbbc6vqbllFLZK4dJZXLSJzeg1KAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783692; c=relaxed/simple;
	bh=/vWV4VzOd8ZFhgbykkxak6+ylyvoqGZrkRbjE+xOVUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hDyLaVb8ddyy1r0F43zz4umPnMSAi+ELwSnyaN+dTy5onaQOT66KnDcvbf91ma1pkeOseBIbW9IWvkD0XN53wJnH4YSs17hcZ7vXNDrY1qDBBbWqSjpjT6yVSSm2PezfYwA931z18+LtHTgD8CF46f2/X7TS9ApPW01NNrGTMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=fzsRbbWB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22fa48f7cb2so17069825ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1746783689; x=1747388489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0rfbYYFv5okSJ9FP6KBkPZgXmzWmufmKqi5XTuFZ00I=;
        b=fzsRbbWBTTMAqz+R5jSTFVrwbvqQJ6B1naHCG0XK4G4UGEd7GKOX9z5WDRqctt79ZB
         wl7TE8WTFA+9NGTHc9ezRk5E2ggEmTlksXb5xYqyFQ2Dna9tviqtPX6itbSZJeiA7efN
         qTaKi1JZyn6mGhGNC0dDG7xZaDlB72p9jGg+pAKlNIdjG6XzwFHZ/3dM7lKj4FfjertQ
         EVVFvGXiM3SOJLkzFBxv6As8vIRYS/y+0mUeNcbmE4tHGeZR6CEOMxL8JbRYsI3YnxBJ
         moL2gv1NKP+4y+7ROPg7Pm7uqvNM2JCfviL+WjUdu6PquZtrmxO25CDX/JWICtJ5x1hL
         5DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783689; x=1747388489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rfbYYFv5okSJ9FP6KBkPZgXmzWmufmKqi5XTuFZ00I=;
        b=Ow5BVsu/oMcf0T6lyzgg+7eXzn0/56GMEkA0ZD9SMatXOKPO97AqsjI9UDTegC2mtC
         ovwSAbzhqO71cPe7y2gOZodZtQ17xEBgodfnmOpvyuZQ+m9rah6F97avWm07dCTIxKP1
         nBJ9sLniVVxD/55qdNRTI0egfXWwlIrZ0tZVY0Fh//tdWEQs3Ixu+gENUzkQ+8zKLpCl
         osQyiu/v4q74qhEMtllV4fb4ljISmsSGuFXewFBv395dt6ZGCAwz5PTe9IP48xBZpBbx
         IJKFd3YM3j7LiVlXfZagdll6VWUQPb6wl4Bh7iFhUSu6U8hptKqVrPCYThBdr73Yfw5B
         2LkA==
X-Forwarded-Encrypted: i=1; AJvYcCVOV3X5wyWDcC0YWbp0bnNXjBCjfQWSnZHqkXI02w5LjNPCz3rwfJs5ShaCVlNabGyr6A/+JyPt0uWfPaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKU8HX6BYiqnUxv2GCemkp3R0gZ8Nm10PhZBaQawhPaV39S029
	tOu9DJmGGzvdbwpvgDRodIWNN/SgqxwGN5PS754OmQAA1SoToeyk0ldxE8aYU+c=
X-Gm-Gg: ASbGncvX1cxy5YDS5VGXiIhz54w8Jedbdd2hJ89xwCOa3vyTaupFPGyKHKmIqU+SpOR
	E5I9e9r2h0WOQLTEV1E3uwI1oA13m3nMSUEU7cgpVVxvQ9F+hBSqA7G8Tj9Owsn6NfN3Wpn0Fkh
	9MGr4OOz0r9ec2MuQ/3KwgWLfXVfg5bxDhBk8T6e9anFoKrjG1HUyDgygypSY0DX6aTqq8S1X3v
	a7GEhdlnKu/LH0H1QJ6l5NWr6jZWRpsNCxfYPLMltKH2OjpFzJcyaMx4+Wuvpz+hI+oHJUqgpen
	8SghGmFli51xt+/QelDLBBLqvKDNx1NPlIClKL5ggbIyJ0YoiLfE+Gb99kI+gbl0CPqNm4+Fxf0
	Jvg==
X-Google-Smtp-Source: AGHT+IGkkhlM5M+6Ld7nKmAFjVYH2kcGrb2uQx7YXLfMGH1JYPzi/20s2F/+C1+ZB+VEtlEdwAiPyA==
X-Received: by 2002:a17:902:e84d:b0:223:653e:eb09 with SMTP id d9443c01a7336-22fc8b10842mr38716365ad.7.1746783689060;
        Fri, 09 May 2025 02:41:29 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c38sm13271035ad.119.2025.05.09.02.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:41:28 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	samuel.holland@sifive.com,
	Nylon Chen <nylon.chen@sifive.com>
Subject: [PATCH v14 0/5] Change PWM-controlled LED pin active mode and algorithm
Date: Fri,  9 May 2025 17:52:29 +0800
Message-Id: <20250509095234.643890-1-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the circuit diagram of User LEDs - RGB described in the
manual hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].

The behavior of PWM is acitve-high.

According to the descriptionof PWM for pwmcmp in SiFive FU740-C000 Manual[2].

The pwm algorithm is (PW) pulse active time  = (D) duty * (T) period.
The `frac` variable is pulse "inactive" time so we need to invert it.

So this patchset removes active-low in DTS and adds reverse logic to the driver.

Links:
- [0]: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
- [1]: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf
- [2]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf

Updated patches: 1
New patches: 0
Unchanged patches: 4

Changed in v14:
 - Change `frac` from `u32` to `u64` and cast the constant in `min()` to
   `u64`  so that `do_div(frac, state->period)` no longer triggers type-mismatch

Changed in v13:
 - Fix syntax error: Added missing closing parenthesis in do_div()
   function call.

Changed in v12:
 - Replace division with do_div() to fix __udivdi3 modpost error.

Changed in v11:
 - Fix rounding consistency in apply() and get_state()
 - Add code comments to help clarify Reference Manual errors.

Changed in v10:
 - Add 'inactive' variable in apply() to match pwm_sifive_get_state()
   style
 - Update comment about hardware limitation - it cannot generate 0% duty
   cycle rather than 100% duty cycle

Changed in v9:
 - Fix commit message to adhere to 75 columns rule.
 - Update commit message's subject.
 - Add a variable for inactive logic.

Changed in v8:
 - Fix Signed-off-by and Co-developed-by typo.

Changed in v7:
 - Remove active-low strings from hifive-unleashed-a00.dts file.

Changed in v6:
 - Separate the idempotent test bug fixes into a new patch.
 - Move the reversing the duty before the line checking
   state->enabled.
 - Fix the algorithm and change it to take the minimum value first and
   then reverse it.

Changed in v5:
 - Add the updates to the PWM algorithm based on version 2 back in.
 - Replace div64_ul with DIV_ROUND_UP_ULL to correct the error in the
   period value of the idempotent test in pwm_apply_state_debug.

Changed in v4:
 - Remove previous updates to the PWM algorithm.

Changed in v3:
 - Convert the reference link to standard link.
 - Move the inverted function before taking the minimum value.
 - Change polarity check condition(high and low).
 - Pick the biggest period length possible that is not bigger than the
   requested period.

Changed in v2:
 - Convert the reference link to standard link.
 - Fix typo: s/sifive unmatched:/sifive: unmatched:/.
 - Remove active-low from hifive-unleashed-a00.dts.
 - Include this reference link in the dts and pwm commit messages.

Nylon Chen (5):
  riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's
    active-low properties
  pwm: sifive: change the PWM algorithm
  pwm: sifive: Fix the error in the idempotent test within the
    pwm_apply_state_debug function
  pwm: sifive: Fix rounding issues in apply and get_state functions
  pwm: sifive: clarify inverted compare logic in comments

 .../boot/dts/sifive/hifive-unleashed-a00.dts  | 12 ++---
 .../boot/dts/sifive/hifive-unmatched-a00.dts  | 12 ++---
 drivers/pwm/pwm-sifive.c                      | 52 ++++++++++++++-----
 3 files changed, 47 insertions(+), 29 deletions(-)

-- 
2.34.1


