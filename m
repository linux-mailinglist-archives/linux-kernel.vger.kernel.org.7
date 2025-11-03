Return-Path: <linux-kernel+bounces-882804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E6AC2B872
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631A83AA441
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC35630497A;
	Mon,  3 Nov 2025 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+N8Z+OX"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F7A303C8E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170580; cv=none; b=TppmNp8VTNIjpb7vB+kfxwAR7uLJfmtyDzhbMBcbpQj/p2ov/tPjq/7i376/ckZT2hm20xB1tF+moNHYTMMWvfIAoLXpMgDnreR0OqZcf7PyS1AkP9nfmKAdFHZGgWuZolIwqS3aeBZp+mum5WIar0ZOULXHsc03g3E3kr8ZXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170580; c=relaxed/simple;
	bh=APgdAknHqPJiWa2/QH7ZOODiVdGQ9E+OGnmmb+fe5p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ouXt8ZY/ea3U59X22y40r1nWB0a0OYSn9047mJ0+DBWof3c5IBJUVT4Qw4gPqo826j3SOM0XEku5UAUg9J8DaSNOXg9dI32mHpQNxEXnWJZa3a8OKN+X/wx0JV1c2YLYnDTuaI+HPtsANI1skP46gb+37gCHx6WwwjDq0EuDeOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+N8Z+OX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso6267818a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762170577; x=1762775377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkVl0Otg19KM1bBOhia1CJmMr0sGJOe4/Ogxs1Uyoq8=;
        b=i+N8Z+OXpe7vvdKcFAIsffQ4vnmp2Lmg91l5yKv+T4ohigKmclgFmx9E35B7MTFg0e
         jNPk8JmIOaNeqRsQWz57bXHoILj8+5arkz2bLQ24PgS3SZEwtM4zgKLLmYp0Vf1M6uTp
         1kUTmiWk6zANzCr1K7FOLgsOKgZlZmyQQ2R18TlTr04Jr+aKjf5DiB8DNYtqP42d6fd1
         pUQM7gBsJVN+PNTcGV7VVop7LNGwuSo1v1zU3er17RbvvbXUP5Jrfee9CNnAuyIfgyMW
         UX6BECQFpb5uCI/DiNzDMdU+MFDLoH3IYSnwMFjLoXS21wGqetGAD2LWSLRm+IJ24NWG
         Belw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762170577; x=1762775377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkVl0Otg19KM1bBOhia1CJmMr0sGJOe4/Ogxs1Uyoq8=;
        b=OIcc9mQwJZF/3nnE2v2kSrx3D3nba1LjmkOAt0IzaKnvRC/uFMNr7kS0/VbR2zcRmn
         B3RJPkIygkC1msZPb8h61lbNpAbvJlcdni0fPlaoZlEva9HmsT7Gc1pxxudNUblQbnQy
         AoZus5Om3b5OXAzcHjvfRV5+zhjd6tDYB0mdkTZf36qg9Cbe9Ow/LbihD+tJuoC/yVYc
         Hl9aRZSP1DSm6v3B+Sk6o9V2mujQ1QwjBrgc93HFtqTZS7cHNzZVfHQpErfemdBzapip
         iziWpWwqVePpA2bSgqvXC6eOawbzIGLhf8k8kY8qGLethXNLLYkcsk/irNUx/9u1ZWb9
         F3FA==
X-Forwarded-Encrypted: i=1; AJvYcCVCYcBYmRkNqNMDXAMlZ/7c5Zyq3GMdpswoQMc2SBeKL2Cprb2VvPz9SM/r0DKfFDKZL1JyNyoMiF27cpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ44EdCDvPEObclyMipCU1S3sonLMo1j1Rj/7HUP4bfhnoNGmg
	uqmhGKX2uS2xMDYInxDSrQxOHKJ3Ooxi6w0T+VFhLcXSmJ9Rvns/mMvQ
X-Gm-Gg: ASbGncun1h+F1fso4Y6CJYmM4BTJ/t8fh/uHCgLdfwf0sAW6Nai9QTA5e7b+0BOr1Sx
	3DUxkB6m8fEfBVMTyk5EWCaCNGJ2osXBkMgZUaDuEP03i4wJ09TDJLxjlH7KaeJKLR+gQYAla05
	Zq8bCiVrhbDx+nDD4Bgx0+IFUZGvaTDevSexw8nmMzSeQFscZwhV6nfOGn0ONkhxr2lCQ+EqeKA
	YyxlnglQ1WX0Q9d6yQSOs0tGY3lT2EittJ7eQLjgeS/6Y4Ue6gau9vUdd9T+gqcj78yFKZCaV5Q
	l3GPoo/vqtd2/481MwUFogqfdawaXVqeheCmBX+mKbEj7znk0qaFrfuo5X73Lp3JAEUFmPWyae/
	jqo1cSCr2etB18vL39JiS6R0LaFInzQbRTzbwIOpglRCnudt3vlsdFyaHfwnDAVmiwWYCboA46t
	thN7wfYsXeYLqb
X-Google-Smtp-Source: AGHT+IFXq9bnp96sEwFx/DuKX88NHdQtkXch/ktaCX6j8scT/NiJ960TzmMrnw3Erxfn9CX2FkXd0A==
X-Received: by 2002:a05:6402:440a:b0:640:b9c5:8c7b with SMTP id 4fb4d7f45d1cf-640b9c58d70mr3762816a12.15.1762170576462;
        Mon, 03 Nov 2025 03:49:36 -0800 (PST)
Received: from gmail.com ([147.161.143.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b438afasm9546138a12.30.2025.11.03.03.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:49:36 -0800 (PST)
From: hariconscious@gmail.com
To: perex@perex.cz,
	tiwai@suse.com
Cc: khalid@kernel.org,
	shuah@kernel.org,
	david.hunter.linux@gmail.com,
	mingo@kernel.org,
	tglx@linutronix.de,
	thorsten.blum@linux.dev,
	mengdewei@cqsoftware.com.cn,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH] ALSA: timer: Fix null dereference of 'timer->card' reported by smatch
Date: Mon,  3 Nov 2025 17:19:03 +0530
Message-ID: <20251103114902.11423-2-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

Fix null dereference in snd_timer_proc_read().

Smatch reported that  was previously assumed to be null
at line 1226, but later accessed without a check.
This could lead to a null pointer dereference under certain conditions.

Add a null check before accessing to ensure safe execution.

Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---
This patch addresses a null pointer dereference in snd_timer_proc_read()
by adding a proper check for timer->card.The issue was flagged by Smatch,
which noted that timer->card was previously assumed to be null at
line 1226 but accessed without validation.To ensure safe access, a
conditional check has been introduced before referencing timer->card.
The fix was verified by booting the kernel and performing audio playback
using ALSA commands. Additionally, the /proc/asound/timers
interface was inspected to confirm that timer information is
correctly populated and accessible without errors.
Note: Couldn't simulate a scenario where 'timer->card' is null and
'timer->card->shutdown' is 1 (shutdown initiated).

 sound/core/timer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index d9fff5c87613..d65e8bcb2f46 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1231,10 +1231,11 @@ static void snd_timer_proc_read(struct snd_info_entry *entry,
 			break;
 		case SNDRV_TIMER_CLASS_CARD:
 			snd_iprintf(buffer, "C%i-%i: ",
-				    timer->card->number, timer->tmr_device);
+				    timer->card ? timer->card->number : -1, timer->tmr_device);
 			break;
 		case SNDRV_TIMER_CLASS_PCM:
-			snd_iprintf(buffer, "P%i-%i-%i: ", timer->card->number,
+			snd_iprintf(buffer, "P%i-%i-%i: ",
+				    timer->card ? timer->card->number : -1,
 				    timer->tmr_device, timer->tmr_subdevice);
 			break;
 		default:

base-commit: 6093a688a07da07808f0122f9aa2a3eed250d853
-- 
2.43.0


