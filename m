Return-Path: <linux-kernel+bounces-854803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09091BDF6DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A0C483C56
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F5D31B13F;
	Wed, 15 Oct 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0WoAqQG"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB130CDA5
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542734; cv=none; b=pXepbqF71uGOJMccyuexYBLDzIlH4oNtMBdgnmYc5IgxYg40cZWqA93gYrRotDXOTDQwTHoQyUTQUO7Dnc4qDzWznk7XJHudjXY/53MAoZrAYQlggU/t8pI80Pyb2gc1TZYKtOCh3TNIDi1f35qfvefQZuwocknZQxwQKhdR0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542734; c=relaxed/simple;
	bh=FSQRDeAYqQ/2VoAUFvlk01F5rvPWoaNjV1C46hVYIzI=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TyX1ZMUZosa+ZS1MlJItl5uoLvfRga7yOvRtmUfYoHedVssDeNz2etYUf6CkMarX9BAUNkfCekGSWglAb5dC0NgJfls+mONn3gyBtjfe5F8MWY7nsHASGDcjxKHKyBuubBithgQcYGlqoiTmCC8+rBv/wTCNNcLBpoi4nn6QWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0WoAqQG; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78e9f48da30so84830136d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760542723; x=1761147523; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+F1mH7vqcfyu05p+jyAm8iUdNffr1wFOUdLtFbWtZU=;
        b=k0WoAqQGMFUrTnXoohgdw4UHCg19+xRqrXJlWp0WlbF82yHcdzL1JiKGoADN7vTey8
         Y2HJWxt7L+oP8gU8u7RZ2KMgU8gdyOt4hBwO1uERAGC9ohguQVR0w7fR1wG5GY8JkVFW
         lEZopmN/xDaC/YXlRyrO1apAGUm8jkI4cYQxtCA5R5YzKwurd+fKz6tS7/7SzkwzkJTk
         646EpjNT5i6w03YZ4yAYBveD/pwz3LFwxIz6dPWS7ystvXbVsACP3tJOEFuETzGzu39+
         lId2JcbHDD9bk41HkHiFNqKqsN/AWRtkMFFfWm4w3CjiDe+5OMjtiDo98CtqpsKtCvKy
         YuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760542723; x=1761147523;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+F1mH7vqcfyu05p+jyAm8iUdNffr1wFOUdLtFbWtZU=;
        b=TuuN0D8QSp7nPk3ZuTIcwh56YnMsO3o5Y90SDZXwZu9mexngvlVZ/mnYuHjG+84iCO
         CxhDoq0PD+gtKsm+yFArSzuSs9K5kWbEhIjtR5lOjG1fyiriKT0B3bNIuJxKrexNkvKH
         C3p6b+bmQTQ7U4Zccvnw8V5gU9Z7KOAyLEjFYKvB74f7FswH1BV6wgdP/NBtSJijhe8a
         HNyXhK27J7RtiU4nI3k+CaRh9R+SPAobnuSADWJ1To++ZlOwBNJwoZJkgAUbVbhzU/Hs
         YJ228v0z2qREqfQnrp9yoZPMNB4z8OqMI+TvEv5j5DUIiLtANhrHlINO2PL0FIKRiTDj
         NWrg==
X-Forwarded-Encrypted: i=1; AJvYcCW6m1NfMJ9S1lseUJ9PHpi/6wn0xMHbc7l/vzU+EUv58Hlkmyrnx40nVPTUjnZ7oo/TNdRk1R9JKJmgEgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrYlgU18arLRk7TsVRBF7Df+S2woRqyE1GcMQDFII/LIUZFQjY
	6uRZrzM97POtE9kpxUpy8JalbiUFqgpZg3Ur6VSyQdei0oj+wJKZv3aQ
X-Gm-Gg: ASbGncsgDmrIfqP9Itw9sIjU87wLtdyBuckZ3aUv6q2lrfDV456m5gpQ5MXKuCXQQz7
	6mIMt7rKu4bcncAvssXQ06r9er0/4DlXD2Sfl1V5Mk9N1aUPgEOifdUgxErBvO/5Mny2bj3dvIr
	MWY5jeXDfbRsGknoZRT9kgyY4M+Z+9QgrheA/FjiRqMp/HmfsEsQrifcwdG3hP6dhEjaOl2xAps
	Rs8M6aO60F2Zo/6XmrbmEXuWh4ld+NMmwlkoGSPiJaBMnYF6QcH+lFO5jcr2+D2CKAlkupeIKuS
	KeYJpCZtDkhDsPOnwgL1MYxnhEXNq94/YYhK0VRQLSjhLOiGhw0NHSN5QWdW9WDDAe0bHRMvEzO
	Bxrj6AlZK89a35y+7imibsCasc0aVw/NJTyeep0lWqXgj640h
X-Google-Smtp-Source: AGHT+IG6rN4LZQ60GHvJUFjr2Ucod9gZKCb0fKHJcDhV38Qj5DzJAmVjTMxF3EseKqcVnSvkkId3pw==
X-Received: by 2002:ad4:5c62:0:b0:879:eb26:dafc with SMTP id 6a1803df08f44-87b2efdbb1dmr470143536d6.54.1760542723334;
        Wed, 15 Oct 2025 08:38:43 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e88f3f2f0asm5036741cf.28.2025.10.15.08.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:38:42 -0700 (PDT)
From: yury.norov@gmail.com
Date: Wed, 15 Oct 2025 11:38:41 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Yury Norov <yury.norov@gmail.com>
Subject: [GIT PULL] bitmap for 6.18-rc2
Message-ID: <aO_AAQBzqMkrGiry@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull fixes for 6.18-rc2: "unnecessary `unsafe`" warning fix for
bitmap/rust, and one leftover patch for FIELD_PREP_WM16() conversion.

Thanks,
Yury

The following changes since commit 9b332cece987ee1790b2ed4c989e28162fa47860:

  Merge tag 'nfsd-6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux (2025-10-14 09:28:12 -0700)

are available in the Git repository at:

  https://github.com/norov/linux.git tags/bitmap-for-v6.18-rc2

for you to fetch changes up to 7e85ac9da1acc591bd5269f2b890ed1994c42e96:

  PM / devfreq: rockchip-dfi: switch to FIELD_PREP_WM16 macro (2025-10-15 10:39:54 -0400)

----------------------------------------------------------------
bitmap-for-6.18-rc2

 - rust: bitmap: clean Rust 1.92.0 `unused_unsafe` warning (Miguel);
 - FIELD_PREP_WM16() rework leftover (Nicolas).

----------------------------------------------------------------
Miguel Ojeda (1):
      rust: bitmap: clean Rust 1.92.0 `unused_unsafe` warning

Nicolas Frattaroli (1):
      PM / devfreq: rockchip-dfi: switch to FIELD_PREP_WM16 macro

 drivers/devfreq/event/rockchip-dfi.c | 45 ++++++++++++++++++------------------
 rust/kernel/bitmap.rs                |  2 ++
 2 files changed, 24 insertions(+), 23 deletions(-)

