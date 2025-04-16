Return-Path: <linux-kernel+bounces-606542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E372A8B084
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 08:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7737017F80F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 06:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F58722D7A7;
	Wed, 16 Apr 2025 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhrTT8/m"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFE322D7A1
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785604; cv=none; b=GhGTWCrpQ0rYrg8CS9RmlSWjek9a71ATTVs35NXujqc8Z7Lp0ywKBlJD84lUyP2yDcjtPNLcUj1Cp0+REQFHeQnEwHPRyIIzloAeo8BJFFPQC/S6d56SBNACH3SC9NPLIVR5CiuKEgGlaO4s7xk2jX/j2Ro6eKNt2iqwNjEJAuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785604; c=relaxed/simple;
	bh=pRm5rikPg836Cpaht6T2Bti6G/gsdEEiL/oreW2ehWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NZzR4kpG3woCyhCkIRPcKBdqWh4m40oO9aUqfCoBE3qeeDd6clJ7aOJZA4vGUy6VG37whSZgLlfmZ3zH2W/k5Veg/35m/h9iPvvf+THc2dBuehOE6nt6TtTtaDSuYMQ4iKiSUFf5D21VHS5XN1Krnc1zKxfi3qGYH+pxk/X82/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JhrTT8/m; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2295d78b45cso90447805ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 23:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744785602; x=1745390402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaMUD1BDVL417dtmG3+/1YWJeUCWl78+KVSs+NX3TJI=;
        b=JhrTT8/m6kO4m1EAju7eGEsIHuUpRJFWF1FdOvfrMlmY8vdAC0MKW92hpOqLqIeD3u
         C91iwFkVxT9dlwB7IPoQiEch9vxGD9JZwTpKADUy542/ZXjDrR80cTQ+QtYbjH4Cvi3k
         ZT5pqaH/w+rTipU32vW7bx5E5gP1WqRpDNi1+7KTzkCo5OjtcsQYsD09bBal5lgmVyIV
         RNGSuguuqi/ASd1VOp/wdEzjEC4/eENq0TaSJjXJUmIm59x+6VS7c7CMVTqJE1Zzalbs
         xHoZkCoyF6S01/ZP4kCq+S+vBViL2B6fngMgXJOBTcqF4UclE9+fnanYGihsQazr3qeG
         q9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785602; x=1745390402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaMUD1BDVL417dtmG3+/1YWJeUCWl78+KVSs+NX3TJI=;
        b=tzWBm2u0XnKAyqc8ek7zzyGiJMEy8xnT3Jk7bXXRuPw93i/qVA6lOnTZCNr/DwtqaB
         Nk7MjhaZkUuGGNH0iIHjFi9WN5Jr8+eruZCK3YnzlKf6LZBHbDKponONAmfUkgjCpKYW
         pny+4gODXTbf6vY/Q3BfR0YirDG7+LZcSfewBE+NkeICXIy7WA+TRSsFe/8aINOlBLqx
         53dgZJ/gnRCI2lo9isuh0STVTwpn/GDBP5MmxhJvfM4n+46zzkndFU7twD0dWLIpSX+4
         /NebU/ylHh15rVhuG/1UfW5Tk6x02qvfHEY58obg61VnmO64IbGAGzOQtlLzaMFm3r54
         t/wA==
X-Forwarded-Encrypted: i=1; AJvYcCVlP24bJecBKQIB7Ets8Okyf2J4yLwJUSwd+D6Ig8rzxDiM3q5MT2r20P4NHCcIE5SJSgrsoIXcogwxY44=@vger.kernel.org
X-Gm-Message-State: AOJu0YydJhQlzKmJm9Z0XAKMmW/iOco2GCS42fr4i2esmAsmGzIpwP2s
	3yb6JMsAP3aVf7CFYTvx2Ex1Fmi2+878936H+Sn6q9HdqVrDAQ/aCeAemxAbnmc=
X-Gm-Gg: ASbGncsa9vzkWJVELn+HPMqoPh2omvM+1rxTI6NN12dRDfkN+Ng9LHlOWKnTzvwE9aA
	o4rRqJwCYhnvy1dbGd81aFjT8CufiTq0TRrk9rKdcgSuSHRjhyFEw5Ho4o77F3eAzNSnpnW3jcI
	bR5CcN89T2VWF6np0gq9j+65RYpFaoqJsaprLGAXCRRAt5linj0HjoM+I8BGHrtLGtUiQUwIClF
	HK2iCtxz/2cVieHlag2WYEyZ8LUV0jqO4x6NQr9X6PguRr2pxWzCx5v9UL5fFRDwbg+HNfd5gsf
	f0crUKMUiyuBHeK6ls+FbxTOb3YYiLke9TOvL7zEKA==
X-Google-Smtp-Source: AGHT+IEZ0BjxMEufYyWXS1DlCdKaeRakmruSioO3vp2nVRyRnB2tMQN8Qlo8XDozRJzOoVI66wZ2Yw==
X-Received: by 2002:a17:903:1aaf:b0:224:1781:a947 with SMTP id d9443c01a7336-22c358de2cdmr12563915ad.21.1744785602483;
        Tue, 15 Apr 2025 23:40:02 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1d3cbsm6459055ad.97.2025.04.15.23.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:40:02 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 03/15] MAINTAINERS: Add entry for Rust cpumask API
Date: Wed, 16 Apr 2025 12:09:20 +0530
Message-Id: <9115c43e4eae9fd958344e7befc945e0e649a6c5.1744783509.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1744783509.git.viresh.kumar@linaro.org>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the MAINTAINERS file to include the Rust abstractions for cpumask
API.

Yury has indicated that he does not wish to maintain the Rust code but
would like to be listed as a reviewer.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..bd7c54af4fd4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6237,6 +6237,12 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	drivers/cpuidle/cpuidle-riscv-sbi.c
 
+CPUMASK API [RUST]
+M:	Viresh Kumar <viresh.kumar@linaro.org>
+R:	Yury Norov <yury.norov@gmail.com>
+S:	Maintained
+F:	rust/kernel/cpumask.rs
+
 CRAMFS FILESYSTEM
 M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Maintained
-- 
2.31.1.272.g89b43f80a514


