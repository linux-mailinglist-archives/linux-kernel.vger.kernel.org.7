Return-Path: <linux-kernel+bounces-852451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72689BD9053
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51C3A4FE814
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12D330CDA0;
	Tue, 14 Oct 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi+GOJLa"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE9F3101AB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441226; cv=none; b=SoZzLX4XVtPYDuk4n7J1QwoWajwGcWtDkPtRbpThLE5V09ya3oh6JTNiK82szyyNtveuyZeS+YFKxHG/IDtIy/gdgYwJvYu9uMol02f91A0NJkke9cAVPqmo9jq6KHppudytjzI0/OnOnZwwFKNo5DaPoFKQZaIKiFguiTt2gcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441226; c=relaxed/simple;
	bh=T1Nmm/R6LFBiTFjOpeGfSLW0d5l/K2N7bsDjPiEWPmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opAkia9kKsGGFs9wkS3Hl41ueyG5Rlj6Y2cJKtRtyKltDuKX4xc1ytI4Kh5kalsXkxY4D0YAXo4pPG9g5iiC6f0/PevvHMT+jdDuzROwWsDW/98+1AfsZbFXYqgmcwH0fKJtpiPQlhHV7tnumIp6Gwohj4j7DqMfNmigAzo+4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi+GOJLa; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7841da939deso4570758b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441223; x=1761046023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q3iRfExEJqSXZ9Zc1Icg4TjF6EtAHQb2pCdXlTokh4=;
        b=Zi+GOJLaSWqNICUjGYoVC6y93s4bW9axrH/dehEFEQGplsW2aYB30xT8OWdZlqTDbc
         64ZoCrnWHzrl7bhLdPPfC4PG7DkCIJQnXy2aQFR02K2ZMSj3m6sq9G/5s3iG8Ea1jvxO
         ICqhYT1H8smExYECw1vXUxFfWPuRMVqnDUftDBZuMDA6NlVmtkUQQIdcvLBf4AvvcdKy
         vioJ+4zKYqJtAlZYiXw2/BeE1ANXEO+4blwEpSOkiT8LU2pERusPaXob4ScEgZjH1yKY
         LiMcc0hmEUuv1n2PlZnAqhhcgkDr1vvtGiUSgC0S6Vfzlxz/KEmL0zK2GfHQVh7N3sHi
         xrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441223; x=1761046023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Q3iRfExEJqSXZ9Zc1Icg4TjF6EtAHQb2pCdXlTokh4=;
        b=ruw7/p/saPy9HY3CFWWwuFhVy8cnmRVV8Bq6vBvSdDEHZuuWAno5elfTWFr7o9X8Xu
         pmPbJtWbEdhrrE47EkBElglxq1GVczDz2mGDI7PpskeTmx+mdqufPn/hb/4O2/QSuMG2
         n7Db72v3UHI9iEWFqGQXcn0Zf50TrohxyTb0qa6v68+UjSLyvmYqR25GPsKNibVs2a2E
         uZXPCQ/c13UGccFtQPyAFSG7+1HTw30ny2JFqTpCSYmTglP7Suay6LyQgdEHCiFhhYge
         eKaZmbFN3sOc7VesGRRgQRm9V/UcaTLNgIthJaxPWC72UFxxEcCq0M4ibhQSoqHgh9xQ
         F8GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhqT8Z3Ov1cutB5apbcuQcowS1N/8Y06gYUkaAIZ7mGFK66ps/BwREznGQu5GMUobOgzBYFpNDN3++s2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMmtnwEu9cxbmCbtyufxKD8y+UUSyLBEyToW9BOw6KoThoYsJ
	kd6ArWKFpCPEPgIGSNgXtRFgOg4e0QvmoMiX4HIuVQBe45Sa9/v2gVdZ
X-Gm-Gg: ASbGncshcethojkZZXAH82MgWByvfn7XVYMepE1T84zlWpP45ghTDwJef9ATkIZp1IL
	W9a+5rXjoEJhZIKZH2niWnBGdzWbR9qzYxxWtUQ7nBu42XBBB1vrs8fAdjQkkjX3Zq9JOPohvKf
	KzUc7YTu4s6WLLGflcR0MsgslepUZ/Jzmfb69CqR98oqvsci2+kodn1TwVBVC/TeqE87/wfrBEx
	LZq2GoW97DTDemU69xbfCPxKjN/LdBA3vB8pkqjNqkxkbvMO39z2TmHi/6vHUaJROTvmtpb1cIn
	Sm+TuemnJpBcgpHnAQx9UVFEziHSI1KMlwpXwlpjixOUCPORgC5W/67sN0DkmpR2UShaqweGsgA
	MIcJFL9e8X75kJ8w9CnDO2GNbi0nEIgs4HqFOVO5e7g==
X-Google-Smtp-Source: AGHT+IESAHoQT5qoaRUX6Sg1Z4sRZoIKiFEVF1CVFjtoN9V7EZsWdw8UMx2i81q1k2h2feHx/dvUDQ==
X-Received: by 2002:a17:902:e550:b0:268:15f:8358 with SMTP id d9443c01a7336-29027402ca0mr302264415ad.42.1760441223089;
        Tue, 14 Oct 2025 04:27:03 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm161807285ad.48.2025.10.14.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:27:02 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/4] bpf: introduce bpf_prog_run_pin_on_cpu_rcu()
Date: Tue, 14 Oct 2025 19:26:38 +0800
Message-ID: <20251014112640.261770-3-dongml2@chinatelecom.cn>
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

Introduce bpf_prog_run_pin_on_cpu_rcu(), which will be called with
rcu_read_lock. migrate_disable_rcu and migrate_enable_rcu are used to get
better performance when CONFIG_PREEMPT_RCU is not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/filter.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5c859b8131a..48eb42358543 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -747,6 +747,18 @@ static inline u32 bpf_prog_run_pin_on_cpu(const struct bpf_prog *prog,
 	return ret;
 }
 
+/* The same as bpf_prog_run_pin_on_cpu, except rcu_read_lock should be held */
+static inline u32 bpf_prog_run_pin_on_cpu_rcu(const struct bpf_prog *prog,
+					      const void *ctx)
+{
+	u32 ret;
+
+	migrate_disable_rcu();
+	ret = bpf_prog_run(prog, ctx);
+	migrate_enable_rcu();
+	return ret;
+}
+
 #define BPF_SKB_CB_LEN QDISC_CB_PRIV_LEN
 
 struct bpf_skb_data_end {
-- 
2.51.0


