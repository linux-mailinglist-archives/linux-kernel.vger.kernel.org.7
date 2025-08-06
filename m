Return-Path: <linux-kernel+bounces-757251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D39B1BFDF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B13624D17
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79D319DFAB;
	Wed,  6 Aug 2025 05:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re4ea+rO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C781114
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754457755; cv=none; b=YK5r6UFciqOUMlbyFXoGkBqqn/g9NCvRamXTtN9iygJtYiXZTb+kQhdeNwk7eOeXDRyLMCmKlM4LDtH9c3nzhD/BjO7x/Dj9TnVx8fLSnvDfJGUX+4zol+dmF+G9IdGODsy/ydsU2fIeafPm0/xJaFwKlFoOU+0btJpGGy1LpwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754457755; c=relaxed/simple;
	bh=tqCPY7yIlC+Yf68lmUytU3qJt7wsROvcPOLHDh907yU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EdIMkaj2VWrnqaOSJa35CuCkOSlX6UbRbFnbEktaluNUMC4GHtiMxTJ+rOEdjTFKYhUuwf7w9PIYG7oxINz+92C9ttPAtCkheg5BHyZeK5/aqQr8c+j/pC5HpouABVUG8iYqO8UakguScCWbocGbseFHPmrMDmjS2gZFpF4kROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re4ea+rO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FD0C4CEF6;
	Wed,  6 Aug 2025 05:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754457754;
	bh=tqCPY7yIlC+Yf68lmUytU3qJt7wsROvcPOLHDh907yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=re4ea+rOiDkRPbP1dSQIxPVNijlcfv44fS+v+vp9kuFffgaFQy1vooR7imTHnG+pH
	 OO69XmtKGK/0gH6ElDfarANP5veEeoc29NGQTMo8FmHe8CAr/TA1QGx+HNHk+I5IEY
	 cc4VDQsD5E1ykLpCmNo+m9AHzxQ+5PS+kq71vF+9hhjxYE7KwlsImRLIWJLcXRxSD4
	 9axI2l1nIbj182vNhjHas1HHAdUZOSxukBjYdJHmDH6O2waO4Q1s+BZ6b4d0EyM68+
	 YKl2DGc/JYw+xMU4bZBY8YYzz8kmmUDhOqpWDI0W58SY+m0OwsDQD9wsYdkwLnyAVq
	 pvIWOtA25O0RQ==
From: SeongJae Park <sj@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH 4/4] mm/kasan: make kasan=on|off take effect for all three modes
Date: Tue,  5 Aug 2025 22:22:31 -0700
Message-Id: <20250806052231.619715-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250805062333.121553-5-bhe@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Baoqua,

On Tue,  5 Aug 2025 14:23:33 +0800 Baoquan He <bhe@redhat.com> wrote:

> Now everything is ready, set kasan=off can disable kasan for all
> three modes.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/kasan-enabled.h | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> index 32f2d19f599f..b5857e15ef14 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -8,30 +8,21 @@ extern bool kasan_arg_disabled;
>  
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>  
> -#ifdef CONFIG_KASAN_HW_TAGS
> -
>  static __always_inline bool kasan_enabled(void)
>  {
>  	return static_branch_likely(&kasan_flag_enabled);
>  }

I found mm-new build fails when CONFIG_KASAN is unset as below, and 'git
bisect' points this patch.

      LD      .tmp_vmlinux1
    ld: lib/stackdepot.o:(__jump_table+0x8): undefined reference to `kasan_flag_enabled'

Since kasna_flag_enabled is defined in mm/kasan/common.c, I confirmed diff like
below fixes this.  I think it may not be a correct fix though, since I didn't
read this patchset thoroughly.

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index b5857e15ef14..a53d112b1020 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -8,11 +8,22 @@ extern bool kasan_arg_disabled;
 
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
+#ifdef CONFIG_KASAN
+
 static __always_inline bool kasan_enabled(void)
 {
 	return static_branch_likely(&kasan_flag_enabled);
 }
 
+#else /* CONFIG_KASAN */
+
+static inline bool kasan_enabled(void)
+{
+	return false;
+}
+
+#endif
+
 #ifdef CONFIG_KASAN_HW_TAGS
 static inline bool kasan_hw_tags_enabled(void)
 {


[...]

Thanks,
SJ

