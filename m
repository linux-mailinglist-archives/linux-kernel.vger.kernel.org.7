Return-Path: <linux-kernel+bounces-852453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB4BBD9057
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64A83AF431
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81583112B4;
	Tue, 14 Oct 2025 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZm/6l8e"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E397C30F959
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441237; cv=none; b=C9Z6DMLILL/GJaYMSB5JRm8E1qEEj1QPZJSeK6yvoLaueaV3ohBeKq0xoChW2otay9s4qGgx6aunnap84453cqIqLo4q/zmOI7WGKyMoKclajIm0PttyqKxEeCq20FCRyBD2AX4CHiXDuFg2C0J4Z0OA0buFRQWRtqLfdJRi3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441237; c=relaxed/simple;
	bh=Rx/YhkNxvLHTn1Rxzb2qa4X0/4hclpnv8IPkM9Xg0Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XngAyPjnBOke2PM/L2cfmjuD9EWD1nkJj/YIYUfwYSifM9nB9gkaUyu3qEjnmstjyfUPIMHMfxqHOjuIowTilV89Cs8dvRMWIHc6oSusQHEdRM+qZLxokw8yRf+73ZXtY8fAxl9ddmY7UaKRE1wc+ORIqGOQ+8uXRjyoxmBjjw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZm/6l8e; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b5515eaefceso4505185a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441235; x=1761046035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iE4VzJhkO405E1xXiO2HovH6fVbTOd8AlZfv3OpV7tQ=;
        b=fZm/6l8etXCz+IX9EaYFXrINr+/EC5xO/KA/D/goPOt31MUJzDyet/ZxEgiA2sXwqP
         eo9ah2BfbtNGmFHVYg6leGsD6dSKaazLJBV8X5eJ8dZe6pJO8R+b9KzERmuoszWzy7xq
         EWKsaO9BpT57wDBvCdvLbDyqbaCk3dClrxpI/cuqgoIbEj8Z0Ame/e0gD1oBB/g1/rXA
         AGTSaU3PHg/qhnP93TsNC0VyiNpcmZKig5aOxq/I77v3nPd47l6Ec69LwUnTdATpGx1h
         URjqRZnr7Xh1ZPF+sUgVbVsvnhgUon5CCsQYhMKZGoylwSUVSOPJMa45YV1uV+9MHn0n
         Oq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441235; x=1761046035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iE4VzJhkO405E1xXiO2HovH6fVbTOd8AlZfv3OpV7tQ=;
        b=P3NC60bTC8TRL+pAsTITxRsvy0Tb/ZX5GdbCioky5kjxfpgnb52PNQ80czKZQUk5AZ
         86LE2sEAdfJT7ccbYiTSl2LaqA54gF/T08m7hYDFWzEfhdhv5yl0UCOxBD2AmO84fFA1
         fv27bFtmJkJPcAe24W2Kt+gptePeIH6C2RGoVMvMX+BSIctlml8dQ4gobTxB6q0IhEzf
         zrqY5400W1tH2TlgBkREi+efjjz9hYYS7fnXzuWeXXTY6/2h/vQexaYZZbcqllXXNiK0
         d+csK2n1hbl62BqaNQ1oXfjvEfmfiY+ax14cbDEUqz8z4mNnfx4n7ScqwD/ieQUtWHpk
         dgKw==
X-Forwarded-Encrypted: i=1; AJvYcCXDuP0J5dJQ4FuWEVvyMv8QxttVPEOIumAWRXpRIZ3fOE35iI0MT/kYnJ6IgNggpGIaUq8bS0cvddYtc64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXfSXSNbgXKzzlc/VQjEF6rhUBzPKsieWXneHYomnNxoAcBods
	YzHg/W2t9ro01WRlQM4dj9jfRoD05AlbQvPGpOJx9/2iAPBvX9Odm6TM
X-Gm-Gg: ASbGncvB7bILPkmrU+fk/ndopDjdopvTxDAw25XziKkxKgKgYFySZO260GYpAMZe1s5
	DHB2MegIZY9nbBpzXJA09sBi36dKN5Xc92/3oQChSGpaD3PKDt5vFMd6DntHf2h7SKTvipKQ5X9
	SR0GBqrrb0Bcc6LXX4F4xGA1lM11dyAaWEgSV8rTO2k5QP5BuqHiBW6MiB+c1nicorrHkd9NJyN
	TAcCOjCrmSETObVV264GaeKD41XQQw7cXNn/+m0SkPMmGyvbvfAEh6+r46CzqkLwVxoCouOjqCc
	BKqCwDTn6OPdd0Dk3Xxgwbbz1PN18omiKmjXdifjOjH61OT0zJrWCvRvvDbF2RRcULNrW+lKSxr
	UKOsISkQMMP7t7baH3H8/l+Ru8cCaSpJNyp/ivArId7IC4jmc
X-Google-Smtp-Source: AGHT+IFYag3HNohwuOOUkgMrRymk2W/3k72l93HvciN+it3ayDICZ/f/o7hlITPi8oCOkannkiormQ==
X-Received: by 2002:a17:903:246:b0:24c:9309:5883 with SMTP id d9443c01a7336-290273ecb35mr316032095ad.28.1760441235366;
        Tue, 14 Oct 2025 04:27:15 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm161807285ad.48.2025.10.14.04.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:27:15 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	paulmck@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 4/4] bpf: use bpf_prog_run_pin_on_cpu_rcu() in bpf_prog_run_clear_cb
Date: Tue, 14 Oct 2025 19:26:40 +0800
Message-ID: <20251014112640.261770-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014112640.261770-1-dongml2@chinatelecom.cn>
References: <20251014112640.261770-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All the calling of bpf_prog_run_clear_cb() is protected with
rcu_read_lock, so we can replace bpf_prog_run_pin_on_cpu() with
bpf_prog_run_pin_on_cpu_rcu() for it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 48eb42358543..5ec5b16538f4 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -995,7 +995,7 @@ static inline u32 bpf_prog_run_clear_cb(const struct bpf_prog *prog,
 	if (unlikely(prog->cb_access))
 		memset(cb_data, 0, BPF_SKB_CB_LEN);
 
-	res = bpf_prog_run_pin_on_cpu(prog, skb);
+	res = bpf_prog_run_pin_on_cpu_rcu(prog, skb);
 	return res;
 }
 
-- 
2.51.0


