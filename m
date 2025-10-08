Return-Path: <linux-kernel+bounces-845461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4367BC508A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FEA53B57F1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9072848AF;
	Wed,  8 Oct 2025 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="MgT5Yb+L"
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E5284885;
	Wed,  8 Oct 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928123; cv=none; b=T9fY3kpZzXpoWpRAppY/101SKGHhFN/6B9MhARL6MD5FS1FinHBNh94s3FouvDr932jwRUqqzNG/XvtxI+grjpHDoXuUl/euVPh4M1mh/1FdNBBBgf/ioVgWDyeSsh7Sg50pRZsw3/NEvRRM93lXuv/qZLJUhGt0qRQpcZla0BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928123; c=relaxed/simple;
	bh=HxTRL/2YUDkd+jfqLc4AsJdmH4OhaTVmob1ir2avKXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqTQruCtskRijhuw39PL+kSokLGN/aQJFHEJP49IhRUtInfjElfFPpeqX7o8BbnpLNvevcokFHD4qJkIp0s98Rxb1Ri6GWup3UvRtlibTkbLvJCPg/dRDsL6XMTfB7r9OzKXkwzo3ZTUZmNe4yXIBLq1ZGttBlXdLec2FjmdK1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=MgT5Yb+L; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id 36AB4865AD;
	Wed, 08 Oct 2025 15:47:33 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1b:3715:0:640:1185:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id B3F9480B32;
	Wed, 08 Oct 2025 15:47:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id LklD46OLveA0-vcNxUOCh;
	Wed, 08 Oct 2025 15:47:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759927643;
	bh=Sx8MdAac7N2yRtDh9OtiumveZ9iIOg++0ZjBT22o1ik=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=MgT5Yb+LosHUAisg1Uh1kBtUZGUdnJuH3GhpvLh7WaHR28VkajITt2YoL51B/zxqE
	 YE33Ys3mbPaMaFucKNc028ZZ7sK0jArll4MISoiKSRZuhe1ugiZux/RaZGuLmdHhrV
	 54fq2xS2TSg0SiZ8DsAMhP4257tRZRND03hyavj4=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	acourbot@nvidia.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	lyude@redhat.com,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v2 1/4] rust: xarray: move pointer check into `XArray::new`
Date: Wed,  8 Oct 2025 15:46:16 +0300
Message-ID: <20251008124619.3160-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008124619.3160-1-work@onurozkan.dev>
References: <20251008124619.3160-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There will be multiple functions that will store into XArray.
It's not ideal to duplicate this check in all of them. Moving it
into the constructor function will remove the need for duplication.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/xarray.rs | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index a49d6db28845..90e27cd5197e 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -87,6 +87,12 @@ pub enum AllocKind {
 impl<T: ForeignOwnable> XArray<T> {
     /// Creates a new initializer for this type.
     pub fn new(kind: AllocKind) -> impl PinInit<Self> {
+        // Ensure pointers stored in XArray are suitably aligned.
+        build_assert!(
+            T::FOREIGN_ALIGN >= 4,
+            "pointers stored in XArray must be 4-byte aligned"
+        );
+
         let flags = match kind {
             AllocKind::Alloc => bindings::XA_FLAGS_ALLOC,
             AllocKind::Alloc1 => bindings::XA_FLAGS_ALLOC1,
@@ -230,10 +236,6 @@ pub fn store(
         value: T,
         gfp: alloc::Flags,
     ) -> Result<Option<T>, StoreError<T>> {
-        build_assert!(
-            T::FOREIGN_ALIGN >= 4,
-            "pointers stored in XArray must be 4-byte aligned"
-        );
         let new = value.into_foreign();

         let old = {
--
2.51.0


