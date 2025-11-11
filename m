Return-Path: <linux-kernel+bounces-895925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D993AC4F476
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC0B3BE29D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300933A8D44;
	Tue, 11 Nov 2025 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4O2sGt8"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A583A5E72
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882635; cv=none; b=phmW96p2ZTdAIa5dQtq07UNOg4n3nTfPwLS39Xu5sGcLqimgMDWJ41ZX8QeaM6vVg3ltr1ZelObEOCqU0W/2f2IRUi1+YKzlPmp1M8j/8g4/UkGHl86CTI6F/XoFDBrcEonh6DvpzGeO3eUj/SH/Po99nWE35kMuDunwyyMPcQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882635; c=relaxed/simple;
	bh=vY92TuF7Ej3Ez3brm3uCohFAC0n7L0hYCJSEeQ1xG/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/qXXe3T0kNd7pmqS6Tbtr47g++gHKXP1ue806FinZ5t4L59eQFvB9KV8Dj2LWEnU0AX7u24RX0HIjsUrxvPyTJvLp8Hv0D7exvoYw6/ojw0HXaKUlv91leWm3myTmeveCcCwEG6yqcAMJg+/L1UBYTN3Vd1FUY42wztNUKk9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4O2sGt8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29845b06dd2so6091545ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762882632; x=1763487432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMvZzcseQYn3wwdrSrl5c1ZbByxcCXtXHqWe21yxXN0=;
        b=F4O2sGt8oQfDHD3uHt4XIzyIh9QgjKjU612asDdVUfxvy4iiulTT01u53ZnDG8To3Y
         +nSPGSd2R47oXQxBdoFTS0RXm7LujKyquflX21YwFykB7DzrmDOmLlIf4uIqE0tpoIaw
         PSzQ/oYxJ3aU+8z/RME2cYO5RcuZXhQ18VBkHRYTbLgCDCsHUR/KtGNFsxS/9LZHNS8w
         6dJqvcas+68HzFHetZYLvlHnqGc0YIFuWzFutujlWki/b0XpcqN0snPn5ItOzeFiiI7f
         mxW3+spdOONkK0TV6pinLFffmdtM8E4lZMTCDcsPF7Q0HT/61I+V4R8b8Dtw2vZM4J/c
         SoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882632; x=1763487432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hMvZzcseQYn3wwdrSrl5c1ZbByxcCXtXHqWe21yxXN0=;
        b=oLoBvojNFNbHZZ9muG8QjtPUmm76VJGfQDRR0x/NQ6PoXTbucLEOy7IDwE+8vL2iIy
         ShGhahtU+7F8ofILt2two8EHln3l2LyHrka4ZIUtlnQO7R1csHZUJ5YtJnH1b4l4WPdL
         Hjj8mIWwwfDDCxwXn4Rp+Fvejvk1U8vfXUVO5V1Qgk2ZHE0/G0ThglQL1obI4JLISEsA
         kTnHUPv1TA8nsWiCPf0+rYC3dQT46kK3wkfSplNhDSqbbeNRs+dvWTaJeLVl5Gm9fedJ
         lHL7XFZh1/ltmVNMm0ITd9NDPGMHEbI5WaENQeLqLC0JY30GnEhpxryKOBH0vb4ttBnc
         IUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvl5xUwY9Z4LTV9vGesr602Yuh+3NCGR9JifAHbV2yfXD+a7wBUmrFS260vPnJwBDkIj+70F65mXnbWFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzFweA9EImNMHqumIM2Ff3n+s30JHT0P/l3ujac0fFjnvf/otY
	fVbpV4eRF4h88EHFbNC/Xzaed96tt9wTrv24Q/mIcf0S0vprJ5rlbZpV
X-Gm-Gg: ASbGncsRNSQcaBU/ybHQKUDHY+2nPZcClXZqcWqGro0LONHKlxGv5Z/3/ume2bEtD5l
	wC3RssRs/54Kk4x7Y8PM1bT8tHzhmM0vtYJxHCLALLh8VBrUxy1jxLUjUyOg8fdC4zaRiQyCVZT
	6nUhK/lMDyyj5FUHTzaFEeGnhv6c30X0zwjh0AACQtoE1OG/aF3FPM+Xhrku6KHERDiHZKxMSUr
	gAgDl7+YSMzUkgIhsrE1VBrKiBUlVNv/35IMQ6S61udmctqvO+14sp+qwCBimLkuBCBvmsEJh3E
	D7uDr7r0+H1SfgOyxiSQftQcQKNfpot05YYB6WGV/rhTZLRylk8XPpkHlQWDLs4GDX/Mrn2m/aN
	34K5IoL41eXuN3SZ1MmetmEWIR7Uos1K6fup2LX42xWQCPAkQ0ucinAzLx/Pw8vLGJ6aGcxh36p
	oUSijVjkAtvtc=
X-Google-Smtp-Source: AGHT+IG5LBnpiDfUi5HlGeAIfhNNNhESoyuw+5Tec48NzHUFnX8+L1Hy73HslnZpG+1krOeegrC8sg==
X-Received: by 2002:a17:902:f60a:b0:294:cc8d:c0c2 with SMTP id d9443c01a7336-2984ed78ff6mr1696235ad.27.1762882631265;
        Tue, 11 Nov 2025 09:37:11 -0800 (PST)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf10c9sm3162625ad.38.2025.11.11.09.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:37:10 -0800 (PST)
From: Jiaming Zhang <r772577952@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kory.maincent@bootlin.com,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	r772577952@gmail.com,
	sdf@fomichev.me,
	syzkaller@googlegroups.com,
	vladimir.oltean@nxp.com
Subject: [PATCH v4 0/1] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
Date: Wed, 12 Nov 2025 01:36:51 +0800
Message-Id: <20251111173652.749159-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103171557.3c5123cc@kernel.org>
References: <20251103171557.3c5123cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

Sorry for the late response. I have updated the patch, NULL check
is moved from get/set caller to generic_hwstamp_ioctl_lower().

Please let me know if any change is needed :)

v4:
- Move NULL check from generic_hwtstamp_get/set_lower()
  to generic_hwtstamp_ioctl_lower()

v3:
- Add Kory's Reviewed-by tag.

v2:
- Fix typo in comment ("driver" -> "lower driver")

Best Regards,
Jiaming Zhang

Jiaming Zhang (1):
  net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()

 net/core/dev_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.34.1


