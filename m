Return-Path: <linux-kernel+bounces-864086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43033BF9E02
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3064230D2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE19A2D5A07;
	Wed, 22 Oct 2025 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf6C9FM9"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71686230BCC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105213; cv=none; b=CWjGOMyGOl2PRSHb7mbq+xZvwGHufHqhqZ6J+z/d7BitEx3A/7Be4Dy84e+3dHq9H3Huew/EBf9M9PImd7DwGQ8hk031tl3zL8QPtLolRkRv5VErBDNJ9I2zn6l7/6qPW6zMZrMtQa4b1jr84eT+gjQjj8J/qMqHsAcTTP3DQP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105213; c=relaxed/simple;
	bh=NgVGJ3RlojH2BIldf9DMzJQA/qL9c9dzJihFVJWRi+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eHBQQG4tsc/k8DPfW5k7EaFojdYShBxcXTIFQGUpFSvoC3ZYcoUp9X8V9RnrnrTJZQjkgF4FmNVSwzl4FIS6/NvAIOWpLeY9Dm4jSlmBz9W1QjuLjj2ewZImMRfLBLrKuJiTVkqkarv71jBrpqyg3vVIOXgFs52I+oFDsvSt9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bf6C9FM9; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87c20106cbeso91660416d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761105210; x=1761710010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KsIgiR4etcCEBy0pFrrjsCMDR9ZoTd6l8rtkQ7UDm20=;
        b=bf6C9FM98dRyQM/qiKEG1mPZ58HkjRWYKIV+ppWbzNWXX50+NG7sgT7GB+Mt4RNHdv
         f+AKc8lnXiOPX3MrwcAiajXE4G4X2BTLaRbGlHcXOBE5OvTXjAQBs1QfJDre9OApAgK9
         LSLxoKtmhtOAkpKxxwcPYlizyMouiODMnETx54y4VeaG5JmRgZOQkzei/tB6gmip8DCe
         BgPy0Joq2Z+fPRGVTAnwctUdOSqJjWJp+rI3l/Y9cpBgcSSPcgiYaLfG+XWJrkrEPYxL
         XddSMOZA7TeJeR81Vi8Ob5T0vfVwNMjmcPYPa0B09jgldL+QhfUjjdSrqqezKuADhQKy
         Izdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105210; x=1761710010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsIgiR4etcCEBy0pFrrjsCMDR9ZoTd6l8rtkQ7UDm20=;
        b=ilzynHQIQUnseJkTDh4wX4IxpFPgeQLxct4u7YiRicUQBDNqp9WIGhocIDRIC3ZAWw
         2wH6cNTZt1OK6KkbiWKF2LPGbVQQcKMVFqhof7sWhGD7HwnRZz3RJx/E+ik61cMu9FCP
         GgrLg/XlnWEMqQTg4xFPytgJq2fdzQ77RLv884/epBvXtbfLOwO8/qnIlFE3lvN8oG7E
         ZR02VioGMrxTbbECFqNi1MBTrXFL7dJNWNB+5vqwzVL0JozSSAJB9PQQe0b03J1ll5s9
         wtakETN0wEZjSMKsEpL6iGCClW3ekNnH4rfHovzqwinq/0H3hOqTunadU3gpdwXXO0IU
         V2nw==
X-Forwarded-Encrypted: i=1; AJvYcCUIsuB3Xfhtl89Rsh62MgOfgibNm6S5th63l2hDWRpkRPbGE8y2VW5gxQi1z2JePaO6EwUdTEI/hAlokOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6MLK0uM4Ln/rFD9qk7Q4bdLlaFHsp8qM00Y3alyFF2Jk0Gt22
	jkjAfu5X5VXwL1suu7zs9saI2kQgXmtDOyBKPfdohs3o2UFAdmn2U3L3
X-Gm-Gg: ASbGnctvZMEbcuH+a3pDm+HlSMoTHUFH0iio2wy6UnVZyV4apj+6Wlx81pbbj8hWF+O
	1Kt94QOueP1Gs27my2RE2k8d0mCIebllfcLU2aezYLl/qDgMLGEntO8X6KB5RwkZxFwA46Vhqa8
	g7zZTGfHXtNOoYAmxBDqkFNb+pr+k6fcWbKtRjcsCt6a8DbpkeBBFmdnKFASYkLcY/mhC2ybTIa
	JH5JjQ5Law/A0BRjKiQWv1grl/qDti/VZeIPbBd6HaoGUW5acNS6hVSCz2r5HbNP7tdrd9OnDUB
	ssf+2YWw1ZS2ApWydgjWVBnfhw4MmViu1XLbltmEaAx0HrkzxoqSYEockbeGZ/5vTFuFUVL1moP
	cExSWhXcxHN7id+RcwWFV24A7jU+2VWSl62D+KbsQVB8GUFfypPsm38zzhNCo0Au3EI9buYbZbw
	Yw54rPhJF8CULVXX1qqwYbqtzxqpkQGas5+nH9HrO1HJv0nDbqLRK5pqc/hLmeii3cmH1++XZas
	d0tGuq1c6BGG/E=
X-Google-Smtp-Source: AGHT+IHLCFy3kwL5fiJiNyM+RN7RxnZo2hv3ukO91WZzWES9p+VXoj4Xmd9ciFsZ5y5Kxj4RH7jlHA==
X-Received: by 2002:a05:6214:1c0d:b0:7e6:5e19:8239 with SMTP id 6a1803df08f44-87c20427625mr213504446d6.0.1761105210314;
        Tue, 21 Oct 2025 20:53:30 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf51fcd39sm80328546d6.6.2025.10.21.20.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 20:53:29 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 56D97F40068;
	Tue, 21 Oct 2025 23:53:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 21 Oct 2025 23:53:29 -0400
X-ME-Sender: <xms:OVX4aB3T9oR09xNBjS5mssxggcMCI_Uc2A0Q2g6OucM4KK8q5tnqLw>
    <xme:OVX4aECwxGwx6VxLIc5IIYEpHcwKmk4aw1OzukwDKVRa3A-P9ips_rTYSXGN0rDhV
    a79ikQAWbLcG0exo_3cU5xa-G4hbsy78ixZRTnZXGUsv08bO5-aVQ>
X-ME-Received: <xmr:OVX4aIAn-sNLOkdGec6PmJ3TJOkLViifwKBKiwgeuNMmxM5gNdBIrMn4z6DU6_0fgEM8SLdh9r_zcVy78p9wZlSNK0DwREv2UZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpefgteffhfehjeegtdduieffudetfeehgfegudejudfhieefgfeigfevueduleduffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:OVX4aFOqpb2GuvJNUtR_5_c-Qj0AWz7a3-EDjFf5fjtX8DZT1ZWnjA>
    <xmx:OVX4aCPK06GY060GC_JkbSv_b42McWgO97vOuCfQd5qeERPjSrg9VA>
    <xmx:OVX4aJseNX7K9zwrpy5tyyKjvU7bMhg1I9Ai5PbMWBKZ4_jjNoHHSg>
    <xmx:OVX4aH9poGHOKdQQvGH6pyoQbOP1skW-wm5-JPKpT2WIqdqzD0TJnQ>
    <xmx:OVX4aFGcQ3X1sgjv4-8RZibKyrPDgrroZ8qb4aMZYb5_wcgfcPT6q_1j>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 23:53:28 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Maurer <mmaurer@google.com>
Subject: [PATCH 0/3] Remove the usage of Rust native atomics in debugfs
Date: Tue, 21 Oct 2025 23:53:21 -0400
Message-ID: <20251022035324.70785-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rust native atomics are not supposed to be used in kernel due to the
mismatch of memory model, since we now have the LKMM atomics in Rust,
remove the usage of Rust native atomics in debugfs.

(help is appreciated if anyone wants to help in other subsystem)

Boqun Feng (3):
  rust: sync: atomic: Make Atomic*Ops pub(crate)
  rust: sync: atomic: Implement Debug for Atomic<Debug>
  rust: debugfs: Replace the usage of Rust native atomics

 rust/kernel/debugfs/traits.rs       | 53 +++++++++--------------------
 rust/kernel/sync/atomic.rs          | 12 ++++++-
 samples/rust/rust_debugfs.rs        | 12 +++----
 samples/rust/rust_debugfs_scoped.rs |  6 ++--
 4 files changed, 36 insertions(+), 47 deletions(-)

-- 
2.51.0


