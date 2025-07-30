Return-Path: <linux-kernel+bounces-751059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20395B164CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996A9188BBBB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE282DE712;
	Wed, 30 Jul 2025 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUgZZgED"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132CC2DC333;
	Wed, 30 Jul 2025 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893287; cv=none; b=GtwURUtkNfcUXO+00OpswgzdVYAVJPj4fzKgjB8yT5UzKp3cLQT4U9Jr0cQaFlPPa71Jw+3mzSfTxQw9pch2pDnYkFJXDeX8UT5yjAB2l5AF5c0nzDlbHbRSbTUh1dh1Gnvb+LuNMQnUUGv7vBnrMA7mRzeEyPljycHLFAaI9Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893287; c=relaxed/simple;
	bh=Pww2+2RTccweOOaSg3HQAH4+iNqxrYV0nPHxTr9SSxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f352EgVjsHdOTTG55xNtEZh2AwrPCO1AWmUD9aQmhlemoB7c/9cg27D5kfSREWHpHcStEpDwFh5sVQMcEjRS5vccjHe8w8dhKLH57WCHyeah8JudSNTGAdMCBrnhQiaU13o2MxSw9KKsAE+rxuBpP9n+JULpDubWMkNlYXQtMVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUgZZgED; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso13521196d6.3;
        Wed, 30 Jul 2025 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753893285; x=1754498085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=85jI46TT0GPR4edF9l8eb8Q9ABq24Mufxzr5iKnRg+w=;
        b=TUgZZgEDhBCBX0VM5FrP7Si9TO0rKLUWQm8Bb4WO/v+1pfiP7Cay3dFd1W8+ZMcsSH
         67ppBpN0uQ4udZ9JoExUuEo1eTJzOITyeybQSK8IRhrVJ2XZ+gF4K0ds4dNUlTAFZqX0
         pex6isIGMzwRtUCDcq7tgCp8C2K7bZ91nNmm0zOdaVaajm08X/HOutT8sA3ZREfR5CVg
         FRAq1pSaf1PxqAHphWWEt/Y0R3jXjSYvhmITbJGQhIri556fqh6t75tkr6IswtB9mFVC
         RlAnEQsfs6JB0VLfaj5p2Z8fD99FJ+QtP3qrVXMKWCoA6F6NYIHAJcWtWAKIC5Yv0Ga0
         ynGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753893285; x=1754498085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85jI46TT0GPR4edF9l8eb8Q9ABq24Mufxzr5iKnRg+w=;
        b=pB/u4vCWRgZGHfQClYs/3yu4A35vmJOGVrfJmFu1K0QuKJMjUpPJXmSrnBooQI5KUz
         jI+cdSL9dd14NWRS9DsvkWZkpIN1mLkyQdZ6KU1GneqK8ijgOfZIY5dFSJ4zqGVEiYcw
         ddr1ZO+VmMEmCDkys/gdccBqr6M0REmKahFDgv+5G4LHyhTKdi5sPcMtbeCwUaFYKP3q
         AtuGZMdm3qd/u6ckJxLMZXxzbNSMJfdc3W4MHbGjHQ4ZuDZrmVqw81q39nS1b6wmQbnm
         MLz9gnhD8WZ0WFM91UBJtmxwtOOdgwCFTZlMIAZbvxmAmChQSSGXrfZp8IKe2TJ85ser
         zKSA==
X-Forwarded-Encrypted: i=1; AJvYcCUhfjs7k7Ivh+XX2cYfkr5RWLovavWUSyk6ax2OEOnw7pRx5zgiJZ8n9jHR3cg3JLq+sLXU7V8dVwIWQFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDpyCSQesKu+LIaU9iDx09574GlneFYJWh4DBREDqe3UYkYxfC
	gU2dcSRYKiK7IqLV9QtJcIgWQJp1qwSYAG1ntnzVz7iI1T+tkk16DOUZ
X-Gm-Gg: ASbGncvsXvnnkiNqf+/+uhZ+b9KkcaO7QZQA7//A6ehOwBwIPcfCu2wJZzwUCdlbrT8
	OZg9oaBt/FTHIp0L1NzFfrnqxJxh/AQm6/3ZBwEpiN0oCiNLedMqiBG36dd80rdpThx+Z4X8/Zd
	Ge0Rh+3ldBVhzpjWPkDdMRjho25zuFu87oQ8ZwMh4BDq3DDRRgaKKgMEGoHNSiijmOHxIULZ0J/
	/ETgoQVH4PKtUe1/ETMSk3eH1WlXDS/pGsaINVC8zUnJbROVPJbZ/9xedEdVgMmQ3biwg0eSXRR
	vZYh9JthUNtpYZyaQK9ydvPe8iWp99Jbk8F7EC3hWwmtPA9izmMGNCw5Jrur0Iv0cSLUsZmUkAI
	Dd6EBALNpDq+I2n+s/HVHRraVcIs/O73d9lE/EKIDg9ueK2NkK62s+npc8S0t616EE02dEI4Sid
	0vh4BhCLfA9y2lKhMbydWvtd0=
X-Google-Smtp-Source: AGHT+IF87ui693FlfdtuZYq18YJCUZIqze6brhe0sL3caoDTaXoMwcznuI3n0atOElTBV/8/25J8kQ==
X-Received: by 2002:ad4:5746:0:b0:704:f7d8:edfd with SMTP id 6a1803df08f44-70767451bf6mr76938236d6.50.1753893284628;
        Wed, 30 Jul 2025 09:34:44 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-707299ff177sm63327516d6.8.2025.07.30.09.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:34:44 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7EAE1F40068;
	Wed, 30 Jul 2025 12:34:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 30 Jul 2025 12:34:43 -0400
X-ME-Sender: <xms:o0mKaMvQSaY3pq2y5J3XEilPCMQhD5pyhOKP_P913VJt2DqopwiZJQ>
    <xme:o0mKaDv757AaFzyvru0zyKvQBuFFK0J4D2KFO0Nu5QT0g1tlpCwBtm4rkt3Ey0adC
    PZNvBCWbMIogQLVFg>
X-ME-Received: <xmr:o0mKaNOVCSBPUK8zEW5vpfg6TgHmmcgAlk6vz6oDjy7J8VxEvGS4urNEeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghn
    ghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    epgeetleffkeevffdugedvtdffvdeitdejieffgeehhfdtueeijeejuedtffdufedunecu
    ffhomhgrihhnpeiiuhhlihhptghhrghtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhushhtqdhfohhrqdhlih
    hnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdr
    tghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtph
    htthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegp
    ghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:o0mKaFd806N46DtNrkDEhKXB3fr39RNmxl2hjpFZjVMnVYJdJ16GMg>
    <xmx:o0mKaEmyEDeebftcbJDTLHAFth9pe4pk6pDwDinJIkRmW82xolcr5g>
    <xmx:o0mKaHw-TLdEskvbx4yL9i7T9dV3p8jY3RTpu5xvjforyyo70VusQQ>
    <xmx:o0mKaHO54LEc_4cQNBb_DhkcMz4-LqZ0Y5lqNC2ovCyWDgFU_BUy2Q>
    <xmx:o0mKaIhR9mhx0fKDUk1dxnFyttWa4t04NTexgnaOKngxRsivcsEtnKwR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 12:34:42 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Alban Kurti <kurti@invicto.ai>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [RFC PATCH] rust: workqueue: Add an example for try_spawn()
Date: Wed, 30 Jul 2025 09:34:39 -0700
Message-Id: <20250730163439.50753-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`try_spawn()` could use an example to demonstrate the usage, and
arguably it's the most simple usage of workqueue in case someone needs a
deferred work, so add it.

Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
Miguel, Alice and Tejun, while I'm at it, should we also rename the
function to `spawn()` because of the motivation mentioned here [1]?

[1]: https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library/topic/.60new.60.20or.20.60try_new.60.3F/near/529533317

Also I find the `{ <clone> || { } }` is really good if I only need to
clone the Arc for passing to a callback closure, but I'm not sure how
people feel about it, so criticism is welcome ;-)

 rust/kernel/workqueue.rs | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index b9343d5bc00f..59c1a5e14d12 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -331,6 +331,33 @@ pub fn enqueue_delayed<W, const ID: u64>(&self, w: W, delay: Jiffies) -> W::Enqu
     /// Tries to spawn the given function or closure as a work item.
     ///
     /// This method can fail because it allocates memory to store the work item.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::{alloc::flags, sync::{Arc, Completion, new_spinlock}, workqueue};
+    ///
+    /// let work_done = Arc::pin_init(Completion::new(), flags::GFP_KERNEL)?;
+    /// let data = Arc::pin_init(new_spinlock!(0), flags::GFP_KERNEL)?;
+    ///
+    /// workqueue::system().try_spawn(
+    ///     flags::GFP_KERNEL,
+    ///     {
+    ///         let work_done = work_done.clone();
+    ///         let data = data.clone();
+    ///         move || {
+    ///             *data.lock() = 42;
+    ///             work_done.complete_all();
+    ///         }
+    ///     }
+    /// )?;
+    ///
+    /// work_done.wait_for_completion();
+    ///
+    /// // `work_done` being completed implies the observation of the write of `data` in the work.
+    /// assert_eq!(*data.lock(), 42);
+    /// # Ok::<(), Error>(())
+    /// ```
     pub fn try_spawn<T: 'static + Send + FnOnce()>(
         &self,
         flags: Flags,
-- 
2.39.5 (Apple Git-154)


