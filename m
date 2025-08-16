Return-Path: <linux-kernel+bounces-772272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9128DB29091
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 22:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC11B189D03F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 20:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7BF308F21;
	Sat, 16 Aug 2025 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbwjQ0fb"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7B6FC5;
	Sat, 16 Aug 2025 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755376846; cv=none; b=U62F8LlUi6viSzpYhelH06wN90QRPPiVSA+d9PITh3wiLzucPbJpHnVNZH7HL2sziwxqvs/eWwr+Zdx7ILb7Fg7aFo4ZTyKqD19gSpx9bL/gi03G2BeqE5XG3c1aU5KrwWXSB4+OHL9gIIAUpgvFEMJJtvDND7zHl03jjip+Ak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755376846; c=relaxed/simple;
	bh=IUMxX3sYOrYawtqKndVXDzrs15CgPpGIL94PGhnnl5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNLAndgWCVfYrAw4TIVIGptNvTVatVkrR12YKKpyLyqQXx9wOuswkNn3JEfSy/nDWew1O12VheGTuW4jcylqLMgw2ZH1ZX3YcizsxI6hW8Zlb5YvAPdjKc5MJRcDlhZUdeos/0kVzONCL/gjiVzqZDvNUHjUozVHAoAyzXbzMvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbwjQ0fb; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b471751142aso480599a12.2;
        Sat, 16 Aug 2025 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755376845; x=1755981645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NQJ4r+9HntyCspbZDSuL92d40bOt1SumIFreNDuCFew=;
        b=AbwjQ0fb7ZXbtHLvcdMabYO90LYwHAuTuAR6ukyrCDrDqshzhgHLk2KUlo42fdqhyv
         Ex+744AFbVUfyqJJPrQ8f9w/S/Nyr6Xc/yByOy/5lgeGtxrJ967MnRFo1h92F0i9wXyK
         wRMvmaNE8WTv60A6TsMjuG5Np26TY5yQ9eXU/mVS79qWRw1e1YH8Ag86/dvC0tbXO9Pl
         UcpCnUkPHfBBpiw9XgOscDtg4zQ9G72wy6jOpySnbzNK6P8TWTXnpQbFhCxSlvmYBDNc
         DUJNTOgMAktvAG+SSekeCTXM7QkcId6QA3cBwxAeop0uKI1mEl3j53YlcOM0NQDxNd2n
         1PPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755376845; x=1755981645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQJ4r+9HntyCspbZDSuL92d40bOt1SumIFreNDuCFew=;
        b=ioiy6OjP/V0hhzoW3RLNv35oIgHvw76F/basvRhHOcaRxjRinptFi/g9WHLImwQlX4
         rMauvcfZnv3BdUyd5WODety7EPBM59wgp9NrLpZz7NZSt/tDH+Xn9SXx/6+si8seD8Vq
         jYHjATbQlbWka7f4pLgtmg1LOV3acwgoB0mIVBaPKnySeQjIO3gJD+A0L447I8lGbKyj
         y7lXP7FndumeDD2lqOzSkQHISmsy7qJffjrFYmy1Q2vlXzu9y829qxpXdLJgk1OheFHV
         eLJV98XzbFNRBrLQ2dDVZk0E0YaYt6k/eiAR3OQsLeAsNxe0hHY1exyyZUGOwxM848t+
         G99w==
X-Forwarded-Encrypted: i=1; AJvYcCUI85jlFRAJ0zHtkwwj/wwEnhlACLw1fuiOW+jVWsu6oXDn5In6MS7elIASiBrRlNVtMiDAWxe3FaNMjiOVHJw=@vger.kernel.org, AJvYcCUMUqR73gZsPrnQbSFbZIkOatF7Tz9hHlpZJEhpM02tpkK3fjzP/6yLWqdyNz21d8qwxhUkDb4ojCD198Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8pNx54TbckvLHxYQ/BGLDHmR8nhhTV78Z1uUYQficJNYEMyWB
	a8Geot1W2klFriPOtYyo0z2VKx+wml7LiEMoXChk1gbwLd9QLr5uS0zNvfe23r25AW1s19vt2pT
	bYKRW1PmFdQBvihCpYZUOvHBRIS4fq/A=
X-Gm-Gg: ASbGncufjmfM4gBgT6zlLbR/CxgwTXuNkw4gy/2LNS+vfBmrZPLSkxsN/mt3U2jAGlG
	Cf3Jt/h89pxODvFlRRKCe+eNdbMpz6ZF0SV/t5aCyaJ0X8lrXe/ZZddRFwciGNqmbrOqNvX2tdQ
	3TAKF9OAkIsHkYBf3cWeUqkbb4svgdL21Qw6L+3/GxyDD1FGhvjB39Mz+XUF+oDwpax2t5CNwa6
	h6UQUwJ9nmbaUPwKm7iGaG9EGlRqQ==
X-Google-Smtp-Source: AGHT+IGLhy6XoHUsx4g+ZU/gF0IL5YIly3nhuQnXq2tLKmkb/hLfnaLNTwbpGNKpUiPVcLq/xiDrOcahf47iyFTm0jQ=
X-Received: by 2002:a17:902:e541:b0:240:9dcd:94c0 with SMTP id
 d9443c01a7336-2446d6f1c95mr43015575ad.2.1755376844509; Sat, 16 Aug 2025
 13:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731154919.4132-1-dakr@kernel.org> <20250731154919.4132-2-dakr@kernel.org>
In-Reply-To: <20250731154919.4132-2-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 16 Aug 2025 22:40:32 +0200
X-Gm-Features: Ac12FXzilRpwWw4Jjl4--bVK8kvcLn9z3359KfqcqWlR9FQCLCDD3nR0rYIEH4E
Message-ID: <CANiq72mUXy6AYkwCW_kO3ikjNBc5pLzXw0+fXFGmYum0tGmw1g@mail.gmail.com>
Subject: Re: [PATCH 1/4] rust: alloc: replace aligned_size() with Kmalloc::aligned_layout()
To: Danilo Krummrich <dakr@kernel.org>
Cc: lorenzo.stoakes@oracle.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	urezki@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000043baf4063c8185da"

--00000000000043baf4063c8185da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 5:49=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> +impl Kmalloc {
> +    /// Returns a [`Layout`] that makes [`Kmalloc`] fulfill the requeste=
d size and alignment of
> +    /// `layout`.
> +    pub const fn aligned_layout(layout: Layout) -> Layout {

I think this `const fn` here was removed when applying to make it work
with older compilers, right?

I was fixing another `rusttest` thing and noticed while applying
these. I had a patch to fix it, since we can actually just use the
feature, and then I noticed it wasn't in the tree. Since I have it, I
am attaching it for reference in case the now-stable feature is
needed, e.g. if you want to make that `const fn` again.

Cheers,
Miguel

--00000000000043baf4063c8185da
Content-Type: application/x-patch; 
	name="0001-rust-kernel-use-const_alloc_layout-feature-to-fix-Ru.patch"
Content-Disposition: attachment; 
	filename="0001-rust-kernel-use-const_alloc_layout-feature-to-fix-Ru.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_meepsu9f0>
X-Attachment-Id: f_meepsu9f0

RnJvbSAzY2YyNGYwNTYxNGUzMzQ5M2JhMDg2YmFiMWYwMmY3MDFjODk0ODA3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWd1ZWwgT2plZGEgPG9qZWRhQGtlcm5lbC5vcmc+CkRhdGU6
IFNhdCwgMTYgQXVnIDIwMjUgMjI6MjA6MjkgKzAyMDAKU3ViamVjdDogW05PVCBQQVRDSF0gcnVz
dDoga2VybmVsOiB1c2UgYGNvbnN0X2FsbG9jX2xheW91dGAgZmVhdHVyZSB0byBmaXggUnVzdAog
PCAxLjg1IGJ1aWxkcwoKQmVmb3JlIFJ1c3QgMS44NS4wIChyZWxlYXNlZCAyMDI1LTAyLTIwKSwg
YHBhZF90b19hbGlnbmAgd2FzIG5vdCBhdmFpbGFibGUKaW4gY29uc3QgY29udGV4dHM6CgogICAg
ZXJyb3I6IGBjb3JlOjphbGxvYzo6TGF5b3V0OjpwYWRfdG9fYWxpZ25gIGlzIG5vdCB5ZXQgc3Rh
YmxlIGFzIGEgY29uc3QgZm4KICAgICAgIC0tPiBydXN0L2tlcm5lbC9hbGxvYy9hbGxvY2F0b3Iu
cnM6MTIyOjkKICAgICAgICB8CiAgICAxMjIgfCAgICAgICAgIGxheW91dC5wYWRfdG9fYWxpZ24o
KQogICAgICAgIHwgICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl4KICAgICAgICB8CiAgICAg
ICAgPSBoZWxwOiBhZGQgYCMhW2ZlYXR1cmUoY29uc3RfYWxsb2NfbGF5b3V0KV1gIHRvIHRoZSBj
cmF0ZSBhdHRyaWJ1dGVzIHRvIGVuYWJsZQoKU2luY2UgdGhlIGBjb25zdF9hbGxvY19sYXlvdXRg
IGZlYXR1cmUgWzFdIGlzIGFscmVhZHkgc3RhYmxlIFsyXSBhbmQgaXMKYXZhaWxhYmxlIGluIG91
ciBtaW5pbXVtIFJ1c3QgdmVyc2lvbiB0b28sIHNpbXBseSBhZGQgaXQgdG8gdGhlIGxpc3Qgb2YK
dGhlIG9uZXMgd2UgdXNlLgoKTGluazogaHR0cHM6Ly9naXRodWIuY29tL3J1c3QtbGFuZy9ydXN0
L2lzc3Vlcy82NzUyMSBbMV0KTGluazogaHR0cHM6Ly9naXRodWIuY29tL3J1c3QtbGFuZy9ydXN0
L3B1bGwvMTM0NzY4IFsyXQpOb3QtRml4ZXMgKHBhdGNoIHdhcyBjaGFuZ2VkIG9uIGFwcGx5KTog
ZmRlNTc4Yzg2MjgxICgicnVzdDogYWxsb2M6IHJlcGxhY2UgYWxpZ25lZF9zaXplKCkgd2l0aCBL
bWFsbG9jOjphbGlnbmVkX2xheW91dCgpIikKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cnVzdC1mb3ItbGludXgvMjAyNTA3MzExNTQ5MTkuNDEzMi0yLWRha3JAa2VybmVsLm9yZy8KU2ln
bmVkLW9mZi1ieTogTWlndWVsIE9qZWRhIDxvamVkYUBrZXJuZWwub3JnPgotLS0KIHJ1c3Qva2Vy
bmVsL2xpYi5ycyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvcnVzdC9rZXJuZWwvbGliLnJzIGIvcnVzdC9rZXJuZWwvbGliLnJzCmluZGV4IGVk
NTMxNjllNzk1Yy4uOTRkMTc0ZWQ3YjhiIDEwMDY0NAotLS0gYS9ydXN0L2tlcm5lbC9saWIucnMK
KysrIGIvcnVzdC9rZXJuZWwvbGliLnJzCkBAIC0zMSw2ICszMSw5IEBACiAjIVtmZWF0dXJlKGNv
bnN0X3B0cl93cml0ZSldCiAjIVtmZWF0dXJlKGNvbnN0X3JlZnNfdG9fY2VsbCldCiAvLworLy8g
U3RhYmxlIHNpbmNlIFJ1c3QgMS44NS4wLgorIyFbZmVhdHVyZShjb25zdF9hbGxvY19sYXlvdXQp
XQorLy8KIC8vIEV4cGVjdGVkIHRvIGJlY29tZSBzdGFibGUuCiAjIVtmZWF0dXJlKGFyYml0cmFy
eV9zZWxmX3R5cGVzKV0KIC8vCi0tCjIuNTAuMQo=
--00000000000043baf4063c8185da--

