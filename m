Return-Path: <linux-kernel+bounces-612274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1C0A94CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 09:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6787F1891AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 07:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904D0213248;
	Mon, 21 Apr 2025 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRpbkr5m"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4D11C5D7A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220176; cv=none; b=IR0eG3MYR4+dPGq6P5yzhq14S1WG7/+d26s3sK6Ur+shn0I5ykVw/wznht+RWYyRaRwcQfyy6YkWyUqBnyzoAGDMK6KCwErKYyMZd3/ohtlWPfdBDJRYay6nMRdh/N/7UaDwsBGkpNxPo63fyPlT5dfEmykLHAd7aXjmRpQqg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220176; c=relaxed/simple;
	bh=pRm5rikPg836Cpaht6T2Bti6G/gsdEEiL/oreW2ehWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nb/dX6CVsTz5t34lAdzYAxIFDIN3wEIlo0xBTzhuUBhsLuF7zU+MkBgXn4W7KLRnyY4lJIRv8K8sDfImGc8PDK6Y63e82K0zwwcLvye1UXkbL5/GG7awCE9zBGyz5rm8wld+va05yguyAMjwR0xZtWvFsNAan8Q1Y1nbUXxSWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dRpbkr5m; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736a7e126c7so2975368b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 00:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745220175; x=1745824975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaMUD1BDVL417dtmG3+/1YWJeUCWl78+KVSs+NX3TJI=;
        b=dRpbkr5mOExVNv/LE5aQ0NXF1krTL2421Ot2emyRxVPV2+PcXVB4vugScyqF90S5/U
         a2/+H7z0fKiYGgMqTUSEmCzXqj9MhlJ7gRl0R8yjdwLRMiwmCJIwk53HGdW4lyZRhhWL
         SKmDDQ1jFawIf2PZoubxTW2+lr43PpVxiyKqbsCAFpRvogJP7tTI8oPFNv87acCsbkQu
         b/aTZKUUbVlGI3aYElo0qRKLAPpKv6AkX/L12hmcLz8Am/X8oCzuAcP2u7pS9GZ9HbiW
         p5MdrfFlrnS0sqjTp5mZPlM4uVBzTBvW0K1wEZOYVbEWNeKMHdR3Fv4KMnQSC/50teeh
         xFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745220175; x=1745824975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaMUD1BDVL417dtmG3+/1YWJeUCWl78+KVSs+NX3TJI=;
        b=MwbAZRF3iESgTLjkdNN28/o6Alo6UChwwwpBN6Rw8opBVA85ok/OZFY5AMRw7vmmON
         RI0yOqR2J7JKZRchBx1mryul4yGyuh6SVsYqShS15BizMdA3CVoq/0uABKouEyy0XMci
         a6zSUvVJhEbAAgMfUOmhDmvfNVkblTAAsCSBNxUa18KpiuYOBH3UyEMeiDjLH1sUzjdQ
         gx8WpbDQKhsHNksHXZvllPlbmgdNe2+W9RyckuzNnD84Qf0dZnVoci1L0EbSm+7ioZaR
         AC/qGLtc4ThwJGLg5rc/63vi+WiK9Idjt0MOqumU1CwFRICzjZVvI4qzs1aCmFjaO5E/
         Py5w==
X-Forwarded-Encrypted: i=1; AJvYcCW8tORcSkcNPJVDoQVETTNwMNRb+2y5sI6JB6h8P8njFUcvtjRRh0RugiTckK0IrAySGhu9p3Dw4A0Ax2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywll7pnq7pfGBJYmD2xf2KgxZ2bY08P7a6rY/bFBeRDLi7X+P7x
	3BmbQcjzYuXSUA/Aq49pjqAK+bvdVie6ujjV1/5HKP7FDjVXFmHRcpVmbV57veo=
X-Gm-Gg: ASbGncvx5HgyH62oPSgkPEOfAhNsEBQ9qhQDNrg7WkWq9kQLOn/mhuRuZCZgA9AgRBp
	jtMQIBLmy7coEeSOzujCvAIpOd6sq9SEHU6DuE4ek04Eu9oXPHu+wIfjmpsBFLH9r4RSnIVfnTU
	9ZD7raee2quMJ4F1O50k3N0LU0lWcDh8bznkzameJ8AtVNbvwKFS/CquGjbJ9PIaqqvFALyo+L2
	5HRBQFFCnMPGDrHj4ZJdxZKItNJKZ6JBMuU4ct85DDBhzvYLx2vJzGGShZqMuJZ+qrey4p5S9EL
	V90jgUkrg8V62EEnY36fCbhmyp+96B817XnQqvG7WQ==
X-Google-Smtp-Source: AGHT+IHNDpp0wsf3Dmxq9+k3By7x6rJU597c7yr2fhSHUbNSUXO88WHLo2YiD1Xe1S6gEIR8PM3vPg==
X-Received: by 2002:a05:6a20:6f8d:b0:1f5:619a:8f73 with SMTP id adf61e73a8af0-203cbd2058bmr14110631637.26.1745220174840;
        Mon, 21 Apr 2025 00:22:54 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db13a41a2sm4998462a12.21.2025.04.21.00.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 00:22:54 -0700 (PDT)
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
Subject: [PATCH V11 03/15] MAINTAINERS: Add entry for Rust cpumask API
Date: Mon, 21 Apr 2025 12:52:10 +0530
Message-Id: <9115c43e4eae9fd958344e7befc945e0e649a6c5.1745218975.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745218975.git.viresh.kumar@linaro.org>
References: <cover.1745218975.git.viresh.kumar@linaro.org>
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


