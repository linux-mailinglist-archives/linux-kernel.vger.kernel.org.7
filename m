Return-Path: <linux-kernel+bounces-835025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E14BA612D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 17:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A90E189CFD0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD22D6605;
	Sat, 27 Sep 2025 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qmat1un8"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B41DE4FB
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758988259; cv=none; b=G5nZmVvnLY2NmkU81aKI95Xv55w2eKlGos5uPQiqeoIchlVYN+Pp8sSrsXSdVAc2DpMKLTtHZevEP9bSY6SkhTaOIwNYiCmSVKQswV+yZHAoxYs2NVjWSI2GlqW0u+MBjMxX44sy2DiO+Fao1JCVQKQmSDssvilYNf0nwNrnHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758988259; c=relaxed/simple;
	bh=nNKWPuJkQvdYn2ghVo9TRkfN7u3Hidr2mJ7omivL/CU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEkQBuBDOpglLgrqC33gTz2VXYz4d7wA39CbxcTY9wsD3QhSc5b2dwhi6Jv8cDGxtv7OM+ySMvfUiQku/LtiaAD2FzlTDaZiAgEM+dpkVtL8R5z1l0dE2PgDSICDP43FCQjp3Qv9QodHlslA2AsHqz1R2Dx0R5ZzJW9xQ6iRULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qmat1un8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7811fa91774so1155951b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758988258; x=1759593058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kgj5+aCbR7yqP5SrP2a81oiXtc58AxAfkdpFxIVr5E=;
        b=Qmat1un8cY4JDHOtk1A4nR3vox+KoM+S+KWts2E8RdBC4gsU7Y94YKS3ZYlto3kAIr
         gOTZQuRusIWRgG81lxLY3ZNd0IiMTCHzJqQuB0AV2U2N5nnmD2oc6E5+qcDQrOtI8yWT
         1+gEiUdqIriR0dpCtc+T9atMRZwcIQqqfnIaCYTc91J+/E7JZlnsdj69MbTccjb9FoVx
         fQk7sycLclNz+BliTU5uD3Tg3luo+QF7FmkVHmMKMOd26Al9/SStS3mgIHPablu1wJUt
         +sA70VYPmcIvIJRhSQznb76hKv1SwoivyGQjnQhXYSEi37P+q0KnROkzEEOuuUXR1Zwj
         6CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758988258; x=1759593058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kgj5+aCbR7yqP5SrP2a81oiXtc58AxAfkdpFxIVr5E=;
        b=MOl70gcP8Bn+a/aFFVI3P01hxdqvfG0AxUSb3i+515gO4U3kH8VKLH5nF4LWoqQEX/
         Q35eGicr9NStdNNSZJAPQ24XcYTlbNZaAIUMcL73lpln9gLNjCZffymoE/SjjBWaz/u9
         phFFOW9WS8fb7v5IpMrGcnSLHz14v8vjKb1jp6TSx9hALGm7+bMpZf+BUdf+9fVzozYQ
         w4d9PQ64hM5Bbcebbfj1L6cO5qHeDdn8tUciPFlsljla0XpP4d+YEqW5/T7P/NTk6lCo
         1RwjkJgJjN2rYNYGSFOEdA3ge+ggT5tG+q5ejPsOd+CCD/bUK5L9TgKDnvX50+h4QtOc
         Ja8g==
X-Forwarded-Encrypted: i=1; AJvYcCU5iGxUIDD/WJYAdE9+7nsUvo3J8mHWfwNihBwCsfWe+cvY5CD9Yt9AeZ7RIofvZDEsOziMfqDgIgCqjco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz22e6H7aTKOPU1QfYfc7BY2Z2VaxPZBk34LhYHufiQjLji9R5J
	Xtv5L9qCk3zMXCHuYLpdSmp9kRtf5rTHq/+apfAqS5Thi2YiVM7SA6i/
X-Gm-Gg: ASbGncsdYxE+KPXQ4XkD964qTOiJgG8gvHRfgqOr64tIU6D8RNwi/Fq0UYYkC21//KU
	l+BI5uxFtwRKyFtJ4Otnp34ZLwKYGUr30QTmXmaj3Mt4P2m0jG1vpteESk3MxEFWni/KBNHQSco
	8+bcXc7nItmcNyB1xe8NQ38l+/9HX1BHFfLJ2g3N0YyLaIWZ8BFuwDCvftOdypDey87pj7w4Nes
	dZccE5kWgrLLjxt4F7W2vbSSsYYaOWNm+ZBZvp5jdvYK55yvQhnSaGmJZsnmG6KIGGlZWg2jn8u
	g9qCfr2BirxZB9jlJkehKztNi2sGXBiQLuJWh6D6vlsyWXLJmxmuJpOePmgm3sXivpTiNlwjN80
	gXJh5vjToGeNRieWUBU0MceshLKClz+Juibtb+P8+5eTV8f8X9A==
X-Google-Smtp-Source: AGHT+IG47ud1lSXpr6ExC0WiuaHug4JfaaJhlS0FN8NZqk0SCfXpPQQk/wLHxYqFM8SzjzqvDy4OmQ==
X-Received: by 2002:a05:6a21:3391:b0:246:458:8540 with SMTP id adf61e73a8af0-2e7bfc1d510mr14582568637.1.1758988257816;
        Sat, 27 Sep 2025 08:50:57 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53db8e3sm7290750a12.23.2025.09.27.08.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 08:50:57 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com
Cc: aha310510@gmail.com,
	clemens@ladisch.de,
	hdanton@sina.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.de
Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
Date: Sun, 28 Sep 2025 00:50:52 +0900
Message-Id: <20250927155052.880528-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <68d7f4e9.a00a0220.102ee.0017.GAE@google.com>
References: <68d7f4e9.a00a0220.102ee.0017.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Reported-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com
> Tested-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com
>
> Tested on:
>

#syz test upstream master

---
 sound/usb/midi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index acb3bf92857c..97e7e7662b12 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1522,15 +1522,14 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
 {
 	int i;
 
+	if (!umidi->disconnected)
+		snd_usbmidi_disconnect(&umidi->list);
+
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
-		if (ep->out)
-			snd_usbmidi_out_endpoint_delete(ep->out);
-		if (ep->in)
-			snd_usbmidi_in_endpoint_delete(ep->in);
+		kfree(ep->out);
 	}
 	mutex_destroy(&umidi->mutex);
-	timer_shutdown_sync(&umidi->error_timer);
 	kfree(umidi);
 }
 
--

