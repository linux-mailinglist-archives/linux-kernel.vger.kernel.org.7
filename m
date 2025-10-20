Return-Path: <linux-kernel+bounces-860474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E92CBF0341
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F233A7175
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828AE2F5A34;
	Mon, 20 Oct 2025 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1AWuBwr9"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFC22A1CF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952953; cv=none; b=LVhSrqtMk7q2ADIboos2eRQrOlVRppREq44r2QyiYcKf3ACuqgjr+RQjHdB4gJsFHrQ+dcrA/Dw/hpGVFCu2iattUZqy5Zeg6OacPKpa8QcD/sVsbuyUXD1FwY0mrOPh0sBcW0muGguPwoIi7Dz4wMoVpzP5NFOv/wm6MRvrbzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952953; c=relaxed/simple;
	bh=XhBk+fLp2W5DECzp9hS0MG7aAfAwiZePIRPabG3zfvQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RBA/BWWWZ1ejIxms4ZznDrhgrDTiEQy+OJ9EjE0rBenKEs8/YF8gt07IeoSNVIJ1NOwPdFp4tS+1ei442cAEn2aEn8wC5yx7lpfPTiRpjM+JycaRRDFp5O7istLFjWCAGX4sgW8jGYn5wPCPcozqz3we+p3611p0oorqdcEv/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1AWuBwr9; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471193dacffso26587525e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760952950; x=1761557750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ecbXXUemuSWRJnCILxztx4T9Y94vvKKPFZCmK42EZU4=;
        b=1AWuBwr9bWBWN2KdYxxf9bPip8eO54XPe02DKZPLNm6Uu2fC4dJDkOmLHLmx1sOrxU
         gFGSWMMq30EaQVdoT0skNEtw5dW0OL3B67AX/ZNqzFDTY6ZA1q1/N5poKzNbxzrQriCB
         8E7deXS4CYG8hCowRnu0Xh4mvF3Y6eXwoM0cLVqrCnIskgkFqFDwOJYOCDlQPwBVc2/s
         6SYQI1NnXr2BfWycFgZZXpS74Rvonq7KmhbEMR1Zj0IxSt92y5xZUZVkIILP6upMhgAL
         gFeHliRH5I5fbklisFYYe9RIHUKBRgBKP0FhkmtPnbELmpO3M6sfbx1+29rfveWRVTVN
         4GGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760952950; x=1761557750;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecbXXUemuSWRJnCILxztx4T9Y94vvKKPFZCmK42EZU4=;
        b=fqJZE+N53O6CL7m0EjG4hAr8q10R92yErJvgskhSs7DkHJUjnxktjRIsHtxUZPpZ2+
         stTR0avJGUytt5mxO/WX79b2MYlyj4FsHTAzV1a4/odgwZIhYFpyKvHc9E60N+nfoWES
         Ts6JpPPn8zNSyS7YKTtNtBEFcJUiqwhp9obhr6NG7uWX6s4RAUVlbVWIGJYKibId0n2H
         vZH/BbbSn8yn2pcnyvYQ8wpXj1vF7mWhLlNruQeFhmZfslLG5r7HL4mGkQOZSxzjCy9F
         CxjGYom6yEa5mXE8j9K3sBe4sXIVcjBufDuF9hwinD/O5vtanUakesyMFqGyTApoweHp
         /mmA==
X-Forwarded-Encrypted: i=1; AJvYcCVQoh46WU81M60rqejodGUBUFkcZpJSI9v5rqQyVZ9WiCJqpYbTclY+/lebmRYqX9w6V+IPg5QlxRg+Hms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFn3aqSgU+xj0xD9Os/WlLKTm1CijqLCaILkNIPt2uSXnGfqyn
	R+FDHNaOaphKZ7bdlQt2t6GoBZq+1EfvhWwOGy1M3ZRTbrJYZWH2BIW6rC5PG18lwRyAG1FPEHv
	6gRYbEoqy90qOqxjBYA==
X-Google-Smtp-Source: AGHT+IEtfKcr2bAXbhY6IBXnQhniMXdtpnsNRZuWCK/iqep4lByGpTbbKfjLmiObkoIKm2uxWetnzZkGUuTSDxI=
X-Received: from wmwl14.prod.google.com ([2002:a05:600d:82ee:b0:46e:2e2a:b707])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b8d:b0:471:60c:1501 with SMTP id 5b1f17b1804b1-47117918c0cmr104204395e9.28.1760952950391;
 Mon, 20 Oct 2025 02:35:50 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:35:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGUC9mgC/3XMSw7CIBSF4a00d+w1vIzVkfswHVS4UGKFBgyxa
 di72LnD/yTn2yBT8pTh2m2QqPjsY2ghDh3oaQyO0JvWIJg4sQtTqOcnZgoG8xo0Sm3Hs1XENQl onyWR9Z/duw+tJ5/fMa07X/hv/ScVjhxVb5iQUjB69DcXo5vpqOMLhlrrF6sjiBOrAAAA
X-Change-Id: 20250904-clk-send-sync-3cfa7f4e1ce2
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=XhBk+fLp2W5DECzp9hS0MG7aAfAwiZePIRPabG3zfvQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo9gJs7Q7itgelMJ1LzKLFYAoousvr6TcvFH7hQ
 XjvX4P/A7eJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaPYCbAAKCRAEWL7uWMY5
 RkAoEACoMbT7N91tq6z9gw5Ha5yrZpV6rkSfFWZ/exIkoXzGDiz5RKf+RRI/iiwC2FvD5ZAy4mq
 SOaXWmfTBTXHUkdWBUOlYkytI9maWPYNDfdFM+g3jQ8Y5/CFeKJRonwwCWRrpy/TTNjO+sDCjja
 xOvhuxcIGWqX01KA1+TpsGrKPLtu/awy0ttYdUSfHBKbBz/jGGnHWVv9MEzUjQxB+Cs6qFZwfDM
 DNhJxlffjrIiI3dOCarwQkSjILbEK4mE8nA87uH6ExHRtUAazId7Lfva+v7+uGHpJo10AzQ7HmC
 ZTmRY1yoVbmsPaEcJj7CzG4IGsOrF7kSS7MOYGYkI0sCM2MxJaVMsY+JOqAnhcfNpRkGX2ic9Uf
 p7KHTC+Ps0hlwNRbkyjL2uxnd/n4F+7ZR1LKnPxyVpphdzVV+2C/7tOyqBn7isNEUB/hkBYtfzd
 Pyzzzn3xbIJaClZfI6YvG2iQflzXw9VZGLFYdn4a9Gx1GDrDRZ271Q9/sFOw2RBZEZ8CRwQKjNT
 fiEXQsl71RZmGRQePGzg6aGKgcC90ZXfspJzyc5cpitifksiKN81asWWr0hROILxRdUJzoLx+js
 2yD1Vx3GGHOvk7ATDcf7TbuqCfG4NIXEn9DJ7g0x4DFwSOc6KaZamGTkVjUgRCR9EOPY6jOPKWO myLnflY/rcRpMPA==
X-Mailer: b4 0.14.2
Message-ID: <20251020-clk-send-sync-v2-0-44ab533ae084@google.com>
Subject: [PATCH v2 0/2] Implement Send and Sync for clk
From: Alice Ryhl <aliceryhl@google.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

I added a patch to remove the Send/Sync impl for the Tyr driver as well.
I think it's fine for the Tyr patch to land through whichever tree takes
the clk patch, as there should be no non-trivial merge conflicts. Or we
can also take the clk patch through drm-rust where tyr patches normally
go if preferred by clk maintainers.

Regarding Daniel's patch [1], I suggest that Daniel sends his type-state
change rebased on top of this series (without including the patches in
this series in his).

[1]: https://lore.kernel.org/rust-for-linux/20250910-clk-type-state-v2-2-1b97c11bb631@collabora.com/

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Rebase on v6.18-rc1.
- Add patch to tyr driver.
- Link to v1: https://lore.kernel.org/r/20250904-clk-send-sync-v1-1-48d023320eb8@google.com

---
Alice Ryhl (2):
      rust: clk: implement Send and Sync
      tyr: remove impl Send/Sync for TyrData

 drivers/gpu/drm/tyr/driver.rs | 12 ------------
 rust/kernel/clk.rs            |  7 +++++++
 2 files changed, 7 insertions(+), 12 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250904-clk-send-sync-3cfa7f4e1ce2

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


